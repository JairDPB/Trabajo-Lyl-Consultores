report 90148 D365LGLEntrys
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = D365LGLEntrysLy;
    Caption = 'D365LATAM Diario de Contabilidad';

    dataset
    {
        dataitem(GLEntry; "G/L Entry")
        {
            column(CompanyName; CompanyInformation.Name) { }
            column(CompanyNit; CompanyInformation."VAT Registration No.") { }
            column(PeriodoIni; PeriodoIni) { }
            column(PeriodoFin; PeriodoFin) { }
            column(Entry_No_; "Entry No.") { }
            column(Posting_Date; "Posting Date") { }
            column(G_L_Account_No_; "G/L Account No.") { }
            column(G_L_Account_Name; "G/L Account Name") { }
            column(Document_No_; "Document No.") { }
            column(Description; Description) { }
            column(Amount; Amount) { }
            column(Debit_Amount; "Debit Amount") { }
            column(Credit_Amount; "Credit Amount") { }
            column(D365L_CO_Third_No_; "D365L CO Third No.") { }
            column(Transaction_No_; "Transaction No.") { }
            // Nuevos campos
            column(User_ID; "User ID") { }
            column(Cost_Center_Code; CostCenterCode) { }
            column(Cost_Center_Name; CostCenterName) { }
            column(Source_Currency_Code; "Source Currency Code") { }
            column(No_Series_Code; NoSeriesCode) { }
            column(No_Series_Description; NoSeriesDescription) { }
            column(Accounting_Period; AccountingPeriod) { }
            column(External_Document_No_; "External Document No.") { }
            dataitem("D365L CO Third Master"; "D365L CO Third Master")
            {
                DataItemLink = "No." = field("D365L CO Third No.");
                column(D365L_CO_Third_Name; Name) { }
                column(VAT_Registration_No_; "VAT Registration No.") { }
            }
        trigger OnAfterGetRecord()
            var
                General_Ledger_Setup: Record "General Ledger Setup";
                DimensionSetEntry: Record "Dimension Set Entry";
                DimensionValue: Record "Dimension Value";
                NoSeries: Record "No. Series";
                NoSeriesLine: Record "No. Series Line";
            begin
                //Obtener Centro de Costo - Dimensión CC
                CostCenterCode := '';
                CostCenterName := '';
                General_Ledger_Setup.Get();
                GlobalDimension1Code := General_Ledger_Setup."Global Dimension 1 Code";
                
                DimensionSetEntry.SetRange("Dimension Set ID", GLEntry."Dimension Set ID");
                DimensionSetEntry.SetRange("Dimension Code", GlobalDimension1Code);
                if DimensionSetEntry.FindFirst() then begin
                    CostCenterCode := DimensionSetEntry."Dimension Value Code";
                    if DimensionValue.Get(GlobalDimension1Code, DimensionSetEntry."Dimension Value Code") then
                        CostCenterName := DimensionValue.Name;
                end;
                
                //Obtener Tipo de Comprobante (No. Series)
                NoSeriesCode := '';
                NoSeriesDescription := '';
                
                // Buscar la serie del documento
                NoSeries.Reset();
                if NoSeries.FindSet() then
                    repeat
                        NoSeriesLine.Reset();
                        NoSeriesLine.SetRange("Series Code", NoSeries.Code);
                        if NoSeriesLine.FindSet() then
                            repeat
                                // Verificar si el documento está en el rango de esta serie
                                if (NoSeriesLine."Starting No." <> '') then begin
                                    if (GLEntry."Document No." >= NoSeriesLine."Starting No.") and 
                                    ((NoSeriesLine."Ending No." = '') or (GLEntry."Document No." <= NoSeriesLine."Ending No.")) then begin
                                        NoSeriesCode := NoSeries.Code;
                                        NoSeriesDescription := NoSeries.Description;
                                        exit;
                                    end;
                                end;
                            until NoSeriesLine.Next() = 0;
                    until (NoSeries.Next() = 0) or (NoSeriesCode <> '');
                
                //Calcular Periodo Contable (formato: Mes Año)
                AccountingPeriod := Format(GLEntry."Posting Date", 0, '<Month Text> <Year4>');
            end;
        trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                SetFilter("Posting Date", '%1..%2', PeriodoIni, PeriodoFin);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(PeriodoIni; PeriodoIni)
                    {
                        ApplicationArea = All;
                        Caption = 'Fecha Inicial';
                    }
                    field(PeriodoFin; PeriodoFin)
                    {
                        ApplicationArea = All;
                        Caption = 'Fecha Final';
                    }
                }
            }
        }
    }

    rendering
    {
        layout(D365LGLEntrysLy)
        {
            Type = RDLC;
            LayoutFile = 'ReportFiles/D365LGLEntrys.rdl';
        }
    }

    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        CompanyInformation.Get();
    end;

    var
        PeriodoIni: Date;
        PeriodoFin: Date;
        CompanyInformation: Record "Company Information";
        CostCenterCode: Code[20];
        CostCenterName: Text[100];
        NoSeriesCode: Code[20];
        NoSeriesDescription: Text[100];
        AccountingPeriod: Text[50];
        GlobalDimension1Code: Code[20];
}