page 50149 "D365L_Import Saldos Subpage"
{
    PageType = List;
    SourceTable = "D365L_Import Saldos Line";
    Caption = 'Saldos Financieros';
    UsageCategory = Lists;
    ApplicationArea = All;
    Editable = true;
    AutoSplitKey = true;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Job Entry No."; Rec."Job Entry No.") { ApplicationArea = All; Editable = false; }
                field("Line No."; Rec."Line No.") { ApplicationArea = All; Editable = false; }
                field("Excel Line No."; Rec."Excel Line No.") { ApplicationArea = All; }
                field("Posting Date"; Rec."Posting Date") { ApplicationArea = All; }
                field("Type mov"; Rec."Tipo de mov") { ApplicationArea = All; }
                field("Document No."; Rec."Document No.") { ApplicationArea = All; }
                field("G/L Account No."; Rec."G/L Account No.") { ApplicationArea = All; }
                field("NIT"; Rec."NIT") { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; }
                field(Amount; Rec.Amount) { ApplicationArea = All; }
                field("Line Status"; Rec."Line Status") { ApplicationArea = All; }
                field("Dimension 1 Code"; Rec."Dimension 1 Code") { ApplicationArea = All; }
                field("Dimension 2 Code"; Rec."Dimension 2 Code") { ApplicationArea = All; }
                field("Dimension 3 Code"; Rec."Dimension 3 Code") { ApplicationArea = All; }
                field("Dimension 4 Code"; Rec."Dimension 4 Code") { ApplicationArea = All; }
                field("Dimension 5 Code"; Rec."Dimension 5 Code") { ApplicationArea = All; }
                field("Dimension 6 Code"; Rec."Dimension 6 Code") { ApplicationArea = All; }
                field("Dimension 7 Code"; Rec."Dimension 7 Code") { ApplicationArea = All; }
                field("Dimension 8 Code"; Rec."Dimension 8 Code") { ApplicationArea = All; }
                field("User Message"; Rec."User Message") { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            // ✅ NUEVO: Validar todas las líneas del trabajo de una vez
            action(ValidarLineas)
            {
                ApplicationArea = All;
                Caption = 'Validar Líneas';
                ToolTip = 'Valida todas las líneas del trabajo y detecta errores. Marca el estado y los mensajes en cada línea.';
                Image = CheckRulesSyntax;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ImportSaldosLineBuffer: Record "D365L_Import Saldos Line";
                    JobEntryNo: Integer;
                begin
                    // Obtener el Job Entry No. del filtro activo
                    if Rec.GetFilter("Job Entry No.") <> '' then
                        JobEntryNo := Rec.GetRangeMin("Job Entry No.")
                    else
                        JobEntryNo := Rec."Job Entry No.";

                    if JobEntryNo = 0 then begin
                        Message('Debe seleccionar un trabajo para validar.');
                        exit;
                    end;

                    // Llamar al procedimiento de validación de la tabla
                    ImportSaldosLineBuffer.ValidateJobLines(JobEntryNo);

                    // Refrescar la página para mostrar los resultados
                    CurrPage.Update(false);

                    Message('Validación completada. Revise el estado y mensajes de cada línea.');
                end;
            }
        }

        area(Navigation)
        {
            action(VerEncabezado)
            {
                ApplicationArea = All;
                Caption = 'Ver Encabezado';
                ToolTip = 'Abre la tarjeta del encabezado relacionada.';
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    JobHeader: Record "D365L_Import Job Header";
                begin
                    if JobHeader.Get(Rec."Job Entry No.") then
                        Page.Run(Page::"D365L_Import Job Card", JobHeader);
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        JobHeaderEntryNo: Integer;
    begin
        // Heredar el Job Entry No. si hay un filtro activo (contexto de subpágina)
        if Rec."Job Entry No." = 0 then begin
            if Rec.GetFilter("Job Entry No.") <> '' then begin
                JobHeaderEntryNo := Rec.GetRangeMin("Job Entry No.");
                if JobHeaderEntryNo > 0 then
                    Rec."Job Entry No." := JobHeaderEntryNo;
            end;
        end;
    end;

    procedure SetHeaderFilter(EntryNo: Integer)
    begin
        Rec.SetRange("Job Entry No.", EntryNo);
    end;
}