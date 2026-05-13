table 50149 "D365L_Import Saldos Line"
{
    Caption = 'Import Saldos Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Job Entry No."; Integer)
        {
            Caption = 'Job Entry No.';
            TableRelation = "D365L_Import Job Header"."Entry No.";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(10; "Excel Line No."; Integer)
        {
            Caption = 'Excel Line No.';
        }
        field(11; "Posting Date"; Date)
        {
            Caption = 'Fecha registro';
        }
        field(12; "G/L Account No."; Code[20])
        {
            Caption = 'Nº cuenta';
            TableRelation = "G/L Account";
        }
        field(13; "Document No."; Code[20])
        {
            Caption = 'Nº documento';
        }
        field(14; Description; Text[100])
        {
            Caption = 'Descripción';
        }
        field(15; Amount; Decimal)
        {
            Caption = 'Importe';
        }
        field(16; "NIT"; Code[20])
        {
            Caption = 'NIT';
        }
        field(17; "Tipo de mov"; Code[20])
        {
            Caption = 'Tipo de mov';

            trigger OnValidate()
            begin
                Rec."Tipo de mov" := NormalizeMovementType(Rec."Tipo de mov");
            end;
        }
        field(30; "Dimension 1 Code"; Code[20])
        {
            Caption = 'Dimension 1';
        }
        field(31; "Dimension 2 Code"; Code[20])
        {
            Caption = 'Dimension 2';
        }
        field(32; "Dimension 3 Code"; Code[20])
        {
            Caption = 'Dimension 3';
        }
        field(33; "Dimension 4 Code"; Code[20])
        {
            Caption = 'Dimension 4';
        }
        field(34; "Dimension 5 Code"; Code[20])
        {
            Caption = 'Dimension 5';
        }
        field(35; "Dimension 6 Code"; Code[20])
        {
            Caption = 'Dimension 6';
        }
        field(36; "Dimension 7 Code"; Code[20])
        {
            Caption = 'Dimension 7';
        }
        field(37; "Dimension 8 Code"; Code[20])
        {
            Caption = 'Dimension 8';
        }
        field(80; "Line Status"; Option)
        {
            Caption = 'Line Status';
            OptionMembers = Pendiente,Valida,Error,Procesada;
            OptionCaption = 'Pendiente,Válida,Error,Procesada';
        }
        field(81; "Technical Errors JSON"; Blob)
        {
            Caption = 'Errores técnicos (JSON)';
            SubType = Memo;
        }
        field(82; "User Message"; Text[250])
        {
            Caption = 'Mensaje usuario';
        }
        field(83; "Last Validation DateTime"; DateTime)
        {
            Caption = 'Last Validation Date/Time';
        }
    }

    keys
    {
        key(PK; "Job Entry No.", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        ImportSaldosLineBuffer: Record "D365L_Import Saldos Line";
        NextLineNo: Integer;
    begin
        if Rec."Line No." = 0 then begin
            // Obtener el máximo Line No. para este Job Entry No. y asignar el siguiente
            // Se suma 10 para permitir inserciones intermedias sin colisiones
            ImportSaldosLineBuffer.SetRange("Job Entry No.", Rec."Job Entry No.");
            if ImportSaldosLineBuffer.FindLast() then
                NextLineNo := ImportSaldosLineBuffer."Line No." + 10
            else
                NextLineNo := 10;

            Rec."Line No." := NextLineNo;
        end;
    end;

    procedure ValidateJobLines(JobEntryNo: Integer)
    var
        ImportSaldosLine: Record "D365L_Import Saldos Line";
        IsPostingDateConsistent: Boolean;
        IsTotalAmountBalanced: Boolean;
        TotalAmount: Decimal;
    begin
        if JobEntryNo = 0 then
            exit;

        EvaluateJobValidationContext(JobEntryNo, IsTotalAmountBalanced, IsPostingDateConsistent, TotalAmount);

        ImportSaldosLine.SetRange("Job Entry No.", JobEntryNo);
        if ImportSaldosLine.FindSet(true) then
            repeat
                ApplyValidationResult(ImportSaldosLine, IsTotalAmountBalanced, IsPostingDateConsistent, TotalAmount);
                ImportSaldosLine.Modify();
            until ImportSaldosLine.Next() = 0;

        UpdateJobHeaderValidation(JobEntryNo);
    end;

    local procedure RevalidateCurrentLine()
    var
        IsPostingDateConsistent: Boolean;
        IsTotalAmountBalanced: Boolean;
        TotalAmount: Decimal;
    begin
        EvaluateJobValidationContext("Job Entry No.", IsTotalAmountBalanced, IsPostingDateConsistent, TotalAmount);
        ApplyValidationResult(Rec, IsTotalAmountBalanced, IsPostingDateConsistent, TotalAmount);
    end;

    // Centraliza la validacion de la linea con reglas individuales y globales del trabajo.
    local procedure ApplyValidationResult(var ImportSaldosLine: Record "D365L_Import Saldos Line"; IsTotalAmountBalanced: Boolean; IsPostingDateConsistent: Boolean; TotalAmount: Decimal)
    var
        Errors: TextBuilder;
    begin
        ValidateGLAccount(ImportSaldosLine, Errors);
        ValidateNIT(ImportSaldosLine, Errors);
        ValidateMovementTypeAndBankSetup(ImportSaldosLine, Errors);
        ValidateDimensions(ImportSaldosLine, Errors);
        AppendJobValidationErrors(ImportSaldosLine, IsTotalAmountBalanced, IsPostingDateConsistent, TotalAmount, Errors);
        FinalizeValidationResult(ImportSaldosLine, Errors);
    end;

    // Evalúa las reglas globales del conjunto de líneas del mismo trabajo.
    // ✅ Valida: (1) Suma de importes = 0, (2) Todas las fechas de registro son iguales
    local procedure EvaluateJobValidationContext(
        JobEntryNo: Integer;
        var IsTotalAmountBalanced: Boolean;
        var IsPostingDateConsistent: Boolean;
        var TotalAmount: Decimal)
    var
        JobLinesBuffer: Record "D365L_Import Saldos Line";
        FirstLineBuffer: Record "D365L_Import Saldos Line";
        ReferencePostingDate: Date;
        HasFirstLine: Boolean;
    begin
        IsTotalAmountBalanced := true;
        IsPostingDateConsistent := true;
        TotalAmount := 0;
        HasFirstLine := false;

        if JobEntryNo = 0 then
            exit;

        JobLinesBuffer.SetRange("Job Entry No.", JobEntryNo);

        // Validar conjunto vacío
        if JobLinesBuffer.IsEmpty() then
            exit;

        // ✅ VALIDACIÓN 1: Suma de importes debe ser 0 (balanceado)
        JobLinesBuffer.CalcSums(Amount);
        TotalAmount := JobLinesBuffer.Amount;
        IsTotalAmountBalanced := (TotalAmount = 0);

        // ✅ VALIDACIÓN 2: Todas las líneas deben tener la misma fecha de registro
        // Capturar la fecha de la primera línea como referencia
        JobLinesBuffer.SetRange("Job Entry No.", JobEntryNo);
        if JobLinesBuffer.FindFirst() then begin
            FirstLineBuffer := JobLinesBuffer;
            ReferencePostingDate := FirstLineBuffer."Posting Date";
            HasFirstLine := true;
        end;

        // Recorrer TODAS las líneas (incluyendo la primera) para verificar consistencia de fecha
        if HasFirstLine then begin
            JobLinesBuffer.SetRange("Job Entry No.", JobEntryNo);
            if JobLinesBuffer.FindSet() then
                repeat
                    if JobLinesBuffer."Posting Date" <> ReferencePostingDate then begin
                        IsPostingDateConsistent := false;
                        exit;  // Salir en primer error encontrado
                    end;
                until JobLinesBuffer.Next() = 0;
        end;
    end;

    // Valida que la cuenta exista y sea de tipo Posting.
    local procedure ValidateGLAccount(var ImportSaldosLine: Record "D365L_Import Saldos Line"; var Errors: TextBuilder)
    var
        GLAccount: Record "G/L Account";
    begin
        if ImportSaldosLine."G/L Account No." = '' then begin
            AppendError(Errors, 'La cuenta contable es obligatoria.');
            exit;
        end;

        if not GLAccount.Get(ImportSaldosLine."G/L Account No.") then begin
            AppendError(Errors, StrSubstNo('La cuenta contable %1 no existe.', ImportSaldosLine."G/L Account No."));
            exit;
        end;

        if GLAccount."Account Type" <> GLAccount."Account Type"::Posting then
            AppendError(Errors, StrSubstNo('La cuenta contable %1 debe ser de tipo Registro.', ImportSaldosLine."G/L Account No."));
    end;

    // Valida el NIT contra la tabla de terceros de localizacion CO sin detener la ejecucion.
    local procedure ValidateNIT(var ImportSaldosLine: Record "D365L_Import Saldos Line"; var Errors: TextBuilder)
    var
        ExistsInThirdMaster: Boolean;
        MetadataError: Text;
    begin
        if ImportSaldosLine."NIT" = '' then
            exit;

        if not ExternalRecordExistsByFieldValue(66001, 'VAT Registration No.', '', ImportSaldosLine."NIT", ExistsInThirdMaster, MetadataError) then begin
            AppendError(Errors, MetadataError);
            exit;
        end;

        if not ExistsInThirdMaster then
            AppendError(Errors, StrSubstNo('El NIT %1 no existe en D365L CO Third Master.', ImportSaldosLine."NIT"));
    end;

    // Valida el tipo de movimiento y la configuracion bancaria asociada a la cuenta contable.
    local procedure ValidateMovementTypeAndBankSetup(var ImportSaldosLine: Record "D365L_Import Saldos Line"; var Errors: TextBuilder)
    var
        BankAccountPostingGroup: Record "Bank Account Posting Group";
        BankPostingGroupRef: RecordRef;
        HasCurrencyAdjustment: Boolean;
        MetadataError: Text;
    begin
        ImportSaldosLine."Tipo de mov" := NormalizeMovementType(ImportSaldosLine."Tipo de mov");

        if (ImportSaldosLine."Tipo de mov" <> '') and
           (ImportSaldosLine."Tipo de mov" <> 'CUENTA') and
           (ImportSaldosLine."Tipo de mov" <> 'BANCO')
        then
            AppendError(Errors, StrSubstNo('El Tipo de mov %1 no es valido. Use CUENTA o BANCO.', ImportSaldosLine."Tipo de mov"));

        if ImportSaldosLine."G/L Account No." = '' then
            exit;

        BankAccountPostingGroup.SetRange("G/L Account No.", ImportSaldosLine."G/L Account No.");
        if not BankAccountPostingGroup.FindFirst() then begin
            if ImportSaldosLine."Tipo de mov" = 'BANCO' then
                AppendError(Errors, StrSubstNo('La cuenta %1 no esta registrada en un grupo de registros bancarios y no puede quedar como tipo BANCO.', ImportSaldosLine."G/L Account No."));

            exit;
        end;

        BankPostingGroupRef.GetTable(BankAccountPostingGroup);
        if not RecordFieldHasValue(BankPostingGroupRef, Database::"Bank Account Posting Group", 'D365L CO Currency Adjusment', 'D365L CO Currency Adjustment', HasCurrencyAdjustment, MetadataError) then begin
            AppendError(Errors, MetadataError);
            exit;
        end;

        if not HasCurrencyAdjustment then
            AppendError(Errors, StrSubstNo('La cuenta %1 esta en un grupo de registros bancarios y requiere configurar D365L CO Currency Adjusment.', ImportSaldosLine."G/L Account No."));

        if ImportSaldosLine."Tipo de mov" <> 'BANCO' then
            AppendError(Errors, StrSubstNo('La cuenta %1 esta registrada en un grupo de registros bancarios; modifique el Tipo de mov a BANCO.', ImportSaldosLine."G/L Account No."));
    end;

    // Valida las dimensiones 1..8 contra el orden configurado en General Ledger Setup.
    local procedure ValidateDimensions(var ImportSaldosLine: Record "D365L_Import Saldos Line"; var Errors: TextBuilder)
    begin
        ValidateDimensionCode(1, ImportSaldosLine."Dimension 1 Code", Errors);
        ValidateDimensionCode(2, ImportSaldosLine."Dimension 2 Code", Errors);
        ValidateDimensionCode(3, ImportSaldosLine."Dimension 3 Code", Errors);
        ValidateDimensionCode(4, ImportSaldosLine."Dimension 4 Code", Errors);
        ValidateDimensionCode(5, ImportSaldosLine."Dimension 5 Code", Errors);
        ValidateDimensionCode(6, ImportSaldosLine."Dimension 6 Code", Errors);
        ValidateDimensionCode(7, ImportSaldosLine."Dimension 7 Code", Errors);
        ValidateDimensionCode(8, ImportSaldosLine."Dimension 8 Code", Errors);
    end;

    // Verifica que el valor exista para la dimension configurada en esa posicion.
    local procedure ValidateDimensionCode(ShortcutDimensionNo: Integer; DimensionValueCode: Code[20]; var Errors: TextBuilder)
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        ShortcutDimensionCode: Code[20];
    begin
        if DimensionValueCode = '' then
            exit;

        if not GeneralLedgerSetup.Get() then begin
            AppendError(Errors, 'No existe configuracion en General Ledger Setup para validar dimensiones.');
            exit;
        end;

        ShortcutDimensionCode := GetShortcutDimensionCode(GeneralLedgerSetup, ShortcutDimensionNo);
        if ShortcutDimensionCode = '' then begin
            AppendError(Errors, StrSubstNo('La Dimension %1 no esta configurada en General Ledger Setup.', ShortcutDimensionNo));
            exit;
        end;

        if not DimensionValue.Get(ShortcutDimensionCode, DimensionValueCode) then
            AppendError(Errors, StrSubstNo('El valor %1 no existe para la Dimension %2 configurada como %3.', DimensionValueCode, ShortcutDimensionNo, ShortcutDimensionCode));
    end;

    // Agrega errores globales del trabajo a la linea actual.
    local procedure AppendJobValidationErrors(var ImportSaldosLine: Record "D365L_Import Saldos Line"; IsTotalAmountBalanced: Boolean; IsPostingDateConsistent: Boolean; TotalAmount: Decimal; var Errors: TextBuilder)
    begin
        if ImportSaldosLine."Job Entry No." = 0 then
            exit;

        if not IsTotalAmountBalanced then
            AppendError(Errors, StrSubstNo('La suma del Importe del trabajo %1 debe ser 0 y actualmente es %2.', ImportSaldosLine."Job Entry No.", Format(TotalAmount)));

        if not IsPostingDateConsistent then
            AppendError(Errors, StrSubstNo('La fecha de registro debe ser igual en todas las lineas del trabajo %1.', ImportSaldosLine."Job Entry No."));
    end;

    // Persiste el resultado final de la validacion en campos de estado, mensaje y BLOB.
    local procedure FinalizeValidationResult(var ImportSaldosLine: Record "D365L_Import Saldos Line"; var Errors: TextBuilder)
    var
        ErrorOutStream: OutStream;
        ErrorText: Text;
    begin
        ErrorText := Errors.ToText();

        Clear(ImportSaldosLine."Technical Errors JSON");
        ImportSaldosLine."Last Validation DateTime" := CurrentDateTime();

        if ErrorText = '' then begin
            ImportSaldosLine."Line Status" := ImportSaldosLine."Line Status"::Valida;
            Clear(ImportSaldosLine."User Message");
            exit;
        end;

        ImportSaldosLine."Line Status" := ImportSaldosLine."Line Status"::Error;
        ImportSaldosLine."User Message" := CopyStr(ErrorText, 1, MaxStrLen(ImportSaldosLine."User Message"));
        ImportSaldosLine."Technical Errors JSON".CreateOutStream(ErrorOutStream, TextEncoding::UTF8);
        ErrorOutStream.WriteText(ErrorText);
    end;

    // Concatena mensajes de error con separador guion.
    local procedure AppendError(var Errors: TextBuilder; ErrorText: Text)
    begin
        if ErrorText = '' then
            exit;

        if Errors.Length() > 0 then
            Errors.Append(' - ');

        Errors.Append(ErrorText);
    end;

    local procedure GetShortcutDimensionCode(GeneralLedgerSetup: Record "General Ledger Setup"; ShortcutDimensionNo: Integer): Code[20]
    begin
        case ShortcutDimensionNo of
            1:
                exit(GeneralLedgerSetup."Shortcut Dimension 1 Code");
            2:
                exit(GeneralLedgerSetup."Shortcut Dimension 2 Code");
            3:
                exit(GeneralLedgerSetup."Shortcut Dimension 3 Code");
            4:
                exit(GeneralLedgerSetup."Shortcut Dimension 4 Code");
            5:
                exit(GeneralLedgerSetup."Shortcut Dimension 5 Code");
            6:
                exit(GeneralLedgerSetup."Shortcut Dimension 6 Code");
            7:
                exit(GeneralLedgerSetup."Shortcut Dimension 7 Code");
            8:
                exit(GeneralLedgerSetup."Shortcut Dimension 8 Code");
        end;
    end;

    local procedure NormalizeMovementType(MovementType: Code[20]): Code[20]
    begin
        exit(CopyStr(UpperCase(DelChr(MovementType, '<>', ' ')), 1, 20));
    end;

    // Busca un registro externo por valor de campo usando metadata para evitar dependencias duras.
    local procedure ExternalRecordExistsByFieldValue(TableNo: Integer; PrimaryFieldName: Text; SecondaryFieldName: Text; SearchValue: Text; var RecordExists: Boolean; var MetadataError: Text): Boolean
    var
        GenericRecRef: RecordRef;
        SearchFieldNo: Integer;
        SearchFieldRef: FieldRef;
    begin
        RecordExists := false;
        Clear(MetadataError);

        if SearchValue = '' then
            exit(true);

        if not TryOpenRecordRef(GenericRecRef, TableNo) then begin
            MetadataError := StrSubstNo('No fue posible abrir la tabla %1 para la validacion configurada.', TableNo);
            exit(false);
        end;

        if not TryGetFieldNoByNames(TableNo, PrimaryFieldName, SecondaryFieldName, SearchFieldNo) then begin
            MetadataError := StrSubstNo('No se encontro el campo %1 en la tabla %2 para completar la validacion.', PrimaryFieldName, TableNo);
            exit(false);
        end;

        SearchFieldRef := GenericRecRef.Field(SearchFieldNo);
        SearchFieldRef.SetRange(SearchValue);
        RecordExists := not GenericRecRef.IsEmpty();
        exit(true);
    end;

    // Verifica si un campo dinamico del registro tiene valor configurado.
    local procedure RecordFieldHasValue(var SourceRecRef: RecordRef; TableNo: Integer; PrimaryFieldName: Text; SecondaryFieldName: Text; var HasValue: Boolean; var MetadataError: Text): Boolean
    var
        FieldNo: Integer;
        DynamicFieldRef: FieldRef;
    begin
        HasValue := false;
        Clear(MetadataError);

        if not TryGetFieldNoByNames(TableNo, PrimaryFieldName, SecondaryFieldName, FieldNo) then begin
            MetadataError := StrSubstNo('No se encontro el campo %1 en la tabla %2 para validar la configuracion bancaria.', PrimaryFieldName, TableNo);
            exit(false);
        end;

        DynamicFieldRef := SourceRecRef.Field(FieldNo);
        HasValue := Format(DynamicFieldRef.Value()) <> '';
        exit(true);
    end;

    // Obtiene el numero del campo usando el nombre real o una variante alternativa.
    local procedure TryGetFieldNoByNames(TableNo: Integer; PrimaryFieldName: Text; SecondaryFieldName: Text; var FieldNo: Integer): Boolean
    var
        FieldMetadata: Record "Field";
    begin
        FieldNo := 0;

        FieldMetadata.SetRange(TableNo, TableNo);
        FieldMetadata.SetRange(FieldName, PrimaryFieldName);
        if FieldMetadata.FindFirst() then begin
            FieldNo := FieldMetadata."No.";
            exit(true);
        end;

        if SecondaryFieldName = '' then
            exit(false);

        FieldMetadata.Reset();
        FieldMetadata.SetRange(TableNo, TableNo);
        FieldMetadata.SetRange(FieldName, SecondaryFieldName);
        if FieldMetadata.FindFirst() then begin
            FieldNo := FieldMetadata."No.";
            exit(true);
        end;

        exit(false);
    end;

    // Actualiza la cabecera con el resultado agregado de la validacion.
    local procedure UpdateJobHeaderValidation(JobEntryNo: Integer)
    var
        ImportJobHeader: Record "D365L_Import Job Header";
        ImportSaldosLine: Record "D365L_Import Saldos Line";
    begin
        if JobEntryNo = 0 then
            exit;

        if not ImportJobHeader.Get(JobEntryNo) then
            exit;

        ImportSaldosLine.SetRange("Job Entry No.", JobEntryNo);
        ImportJobHeader."Lines Count" := ImportSaldosLine.Count();

        ImportSaldosLine.SetRange("Line Status", ImportSaldosLine."Line Status"::Valida);
        ImportJobHeader."Valid Lines Count" := ImportSaldosLine.Count();

        ImportSaldosLine.SetRange("Line Status", ImportSaldosLine."Line Status"::Error);
        ImportJobHeader."Error Lines Count" := ImportSaldosLine.Count();

        ImportJobHeader."Has Errors" := ImportJobHeader."Error Lines Count" > 0;

        if ImportJobHeader."Lines Count" = 0 then
            ImportJobHeader.Status := ImportJobHeader.Status::Pendiente
        else
            if ImportJobHeader."Has Errors" then
                ImportJobHeader.Status := ImportJobHeader.Status::ConErrores
            else
                ImportJobHeader.Status := ImportJobHeader.Status::Validado;

        ImportJobHeader.Modify();
    end;

    [TryFunction]
    local procedure TryOpenRecordRef(var GenericRecRef: RecordRef; TableNo: Integer)
    begin
        GenericRecRef.Open(TableNo);
    end;
}
