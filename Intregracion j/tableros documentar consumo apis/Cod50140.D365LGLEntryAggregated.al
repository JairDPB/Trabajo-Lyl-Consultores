codeunit 50140 "Load GL Movements"
{
    procedure LoadData(var Buffer: Record "D365L GL Movements Buffer"; PostingDateFilter: Text)
    var
        GLEntry: Record "G/L Entry";
        SourceCodeSetup: Record "Source Code Setup";
        IsClosing: Boolean;
        CloseIncomeStatementCode: Code[10];
    begin
        // Limpiar buffer temporal
        Buffer.Reset();
        Buffer.DeleteAll();

        // Obtener el código de cierre de ingresos desde la configuración
        if SourceCodeSetup.Get() then
            CloseIncomeStatementCode := SourceCodeSetup."Close Income Statement"
        else
            CloseIncomeStatementCode := '';

        // Configurar filtros en G/L Entry
        GLEntry.Reset();
        
        /*// Aplicar filtro de fecha si se proporciona desde OData
        if PostingDateFilter <> '' then
            GLEntry.SetFilter("Posting Date", PostingDateFilter);
*/
        // Procesar todos los movimientos contables
        if GLEntry.FindSet() then
            repeat
                // Determinar si es asiento de cierre comparando Source Code
                IsClosing := (GLEntry."Source Code" = CloseIncomeStatementCode);

                // Buscar si ya existe esta combinación exacta en el buffer
                Buffer.Reset();
                Buffer.SetRange("Posting Date", GLEntry."Posting Date");
                Buffer.SetRange("G/L Account No.", GLEntry."G/L Account No.");
                Buffer.SetRange("Dim 1", GLEntry."Global Dimension 1 Code");
                Buffer.SetRange("Dim 2", GLEntry."Global Dimension 2 Code");
                Buffer.SetRange("Dim 3", GLEntry."Shortcut Dimension 3 Code");
                Buffer.SetRange("Dim 4", GLEntry."Shortcut Dimension 4 Code");
                Buffer.SetRange("Dim 5", GLEntry."Shortcut Dimension 5 Code");
                Buffer.SetRange("Dim 6", GLEntry."Shortcut Dimension 6 Code");
                Buffer.SetRange("Dim 7", GLEntry."Shortcut Dimension 7 Code");
                Buffer.SetRange("Dim 8", GLEntry."Shortcut Dimension 8 Code");
                Buffer.SetRange("Is Closing Entry", IsClosing);

                if Buffer.FindFirst() then begin
                    // Ya existe: acumular los importes
                    Buffer.Amount += GLEntry.Amount;
                    Buffer."Debit Amount" += GLEntry."Debit Amount";
                    Buffer."Credit Amount" += GLEntry."Credit Amount";
                    Buffer.Modify();
                end else begin
                    // No existe: crear nuevo registro agrupado
                    Buffer.Init();
                    Buffer."Posting Date" := GLEntry."Posting Date";
                    Buffer."G/L Account No." := GLEntry."G/L Account No.";
                    Buffer."Dim 1" := GLEntry."Global Dimension 1 Code";
                    Buffer."Dim 2" := GLEntry."Global Dimension 2 Code";
                    Buffer."Dim 3" := GLEntry."Shortcut Dimension 3 Code";
                    Buffer."Dim 4" := GLEntry."Shortcut Dimension 4 Code";
                    Buffer."Dim 5" := GLEntry."Shortcut Dimension 5 Code";
                    Buffer."Dim 6" := GLEntry."Shortcut Dimension 6 Code";
                    Buffer."Dim 7" := GLEntry."Shortcut Dimension 7 Code";
                    Buffer."Dim 8" := GLEntry."Shortcut Dimension 8 Code";
                    Buffer."Is Closing Entry" := IsClosing;
                    Buffer.Amount := GLEntry.Amount;
                    Buffer."Debit Amount" := GLEntry."Debit Amount";
                    Buffer."Credit Amount" := GLEntry."Credit Amount";
                    Buffer.Insert();
                end;
            until GLEntry.Next() = 0;

        // Posicionar en el primer registro para la API
        Buffer.Reset();
        if Buffer.FindFirst() then;
    end;
}