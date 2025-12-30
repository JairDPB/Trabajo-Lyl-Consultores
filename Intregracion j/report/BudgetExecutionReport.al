report 50148 "Budget Execution Report"
{
    Caption = 'Ejecución Presupuestal por Centro de Costo';
    ProcessingOnly = true;
    ApplicationArea = All;
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Filters)
                {
                    field(DateFilter; DateFilter)
                    {
                        Caption = 'Fecha';
                        ApplicationArea = All;
                    }
                    field(Dim1Filter; Dim1Filter)
                    {
                        Caption = 'Dimensión 1';
                        ApplicationArea = All;
                    }
                    field(Dim2Filter; Dim2Filter)
                    {
                        Caption = 'Dimensión 2';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
    var
        ExcelBuffer: Record "Excel Buffer" temporary;
        BudgetEntry: Record "G/L Budget Entry";
        GLEntry: Record "G/L Entry";
        BudgetMgt: Codeunit "Budget Execution Mgt";

        DateFilter: Date;
        Dim1Filter: Code[20];
        Dim2Filter: Code[20];

        BudgetOriginal: Decimal;
        BudgetAdjustment: Decimal;
        BudgetModified: Decimal;
        ExecutedAmount: Decimal;
        RemainingAmount: Decimal;
        VarianceTxt: Text[50];
        TempBudgetReport: Record "Temp Budget Report" temporary;

        trigger OnPreReport()
begin
    ExcelBuffer.DeleteAll();

    ExcelBuffer.AddColumn('Cuenta', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
    ExcelBuffer.AddColumn('Nombre Cuenta', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
    ExcelBuffer.AddColumn('Dimensiones', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
    ExcelBuffer.AddColumn('Presupuesto Aprobado', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
    ExcelBuffer.AddColumn('Modificación Presupuestal', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
    ExcelBuffer.AddColumn('Presupuesto Modificado', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
    ExcelBuffer.AddColumn('Total Ejecutado', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
    ExcelBuffer.AddColumn('Por Ejecutar', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
    ExcelBuffer.AddColumn('Variación Presupuestal', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
    ExcelBuffer.AddColumn('Por qué', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
    ExcelBuffer.AddColumn('Causa', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
    ExcelBuffer.AddColumn('Consecuencia', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
    ExcelBuffer.AddColumn('Solicitudes / Contratos', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
end;


        trigger OnPostReport()
    
begin
    // Limpiar tabla temporal
    TempBudgetReport.DeleteAll();

    // Filtrar y recorrer BudgetEntry
    BudgetEntry.Reset();
    BudgetEntry.SetRange("Date", 0D, DateFilter);

    if Dim1Filter <> '' then
        BudgetEntry.SetRange("Global Dimension 1 Code", Dim1Filter);
    if Dim2Filter <> '' then
        BudgetEntry.SetRange("Global Dimension 2 Code", Dim2Filter);

    if BudgetEntry.FindSet() then
        repeat
            // Inicializar variables
            BudgetOriginal := 0;
            BudgetAdjustment := 0;

            if BudgetEntry.Amount >= 0 then
                BudgetOriginal := BudgetEntry.Amount
            else
                BudgetAdjustment := BudgetEntry.Amount;

            // Buscar si ya existe fila en TempBudget
            if TempBudgetReport.Get(BudgetEntry."G/L Account No.", BudgetEntry."Dimension Set ID") then begin
                TempBudgetReport.BudgetOriginal += BudgetOriginal;
                TempBudgetReport.BudgetAdjustment += BudgetAdjustment;
                TempBudgetReport.Modify();
            end else begin
                TempBudgetReport.Init();
                TempBudgetReport."G/L Account No." := BudgetEntry."G/L Account No.";
                TempBudgetReport."Dimension Set ID" := BudgetEntry."Dimension Set ID";
                TempBudgetReport.BudgetOriginal := BudgetOriginal;
                TempBudgetReport.BudgetAdjustment := BudgetAdjustment;
                TempBudgetReport.Insert();
            end;
        until BudgetEntry.Next() = 0;

    // Recorrer TempBudgetReport y calcular Presupuesto Modificado y Ejecutado
    TempBudgetReport.Reset();
    if TempBudgetReport.FindSet() then
        repeat
            TempBudgetReport.BudgetModified := TempBudgetReport.BudgetOriginal + TempBudgetReport.BudgetAdjustment;

            // Ejecutado real
            GLEntry.Reset();
            GLEntry.SetRange("G/L Account No.", TempBudgetReport."G/L Account No.");
            GLEntry.SetRange("Posting Date", 0D, DateFilter);
            GLEntry.SetRange("Dimension Set ID", TempBudgetReport."Dimension Set ID");
            GLEntry.CalcSums(Amount);
            TempBudgetReport.ExecutedAmount := GLEntry.Amount;
            TempBudgetReport.RemainingAmount := TempBudgetReport.BudgetModified - TempBudgetReport.ExecutedAmount;

            if TempBudgetReport.ExecutedAmount <= TempBudgetReport.BudgetModified then
                TempBudgetReport.VarianceTxt := 'Sub ejecución'
            else
                TempBudgetReport.VarianceTxt := 'Sobre ejecución';

            // Escribir en Excel
            ExcelBuffer.NewRow();
            ExcelBuffer.AddColumn(TempBudgetReport."G/L Account No.", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(BudgetMgt.GetAccountName(TempBudgetReport."G/L Account No."), false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(BudgetMgt.GetDimensionValueNames(TempBudgetReport."Dimension Set ID"), false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(TempBudgetReport.BudgetOriginal, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
            ExcelBuffer.AddColumn(TempBudgetReport.BudgetAdjustment, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
            ExcelBuffer.AddColumn(TempBudgetReport.BudgetModified, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
            ExcelBuffer.AddColumn(TempBudgetReport.ExecutedAmount, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
            ExcelBuffer.AddColumn(TempBudgetReport.RemainingAmount, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
            ExcelBuffer.AddColumn(TempBudgetReport.VarianceTxt, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);

            // Columnas vacías
            ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);

        until TempBudgetReport.Next() = 0;

    // Crear Excel
    ExcelBuffer.CreateNewBook('Ejecución Presupuestal');
    ExcelBuffer.WriteSheet('Reporte', CompanyName, UserId);
    ExcelBuffer.CloseBook();
    ExcelBuffer.OpenExcel();
end;

}