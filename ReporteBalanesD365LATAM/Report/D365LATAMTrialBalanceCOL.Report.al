report 90147 "D365LATAM TrialBalanceCOL"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportFiles/LyLBalanceSumasSaldosTerceros.rdl';
    AdditionalSearchTerms = 'year closing,close accounting period,close fiscal year';
    ApplicationArea = Basic, Suite;
    Caption = 'D365LATAM - Reporte Cuenta Tercero Colombia';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Integer; Integer)
        {
            column(No_; tempTable.G_L_Account_No_) { }
            column(Name; tempTable.G_L_Account_Name) { }
            column(CompanyName; CompanyInformation.Name) { }
            column(CompanyNIT; CompanyInformation."VAT Registration No.") { }
            column(PeriodoIni; PeriodoIni) { }
            column(PeriodoFin; PeriodoFin) { }
            // column(CompanyPicture; CompanyInformation.Picture) { }
            column(Shortcut_Dimension_3_Code; tempTable.Shortcut_Dimension_3_Code) { }
            column(Amount; tempTable.Amount) { }
            column(Debit_Amount; tempTable.Debit_Amount) { }
            column(Credit_Amount; tempTable.Credit_Amount) { }
            column(Posting_Date; tempTable.Posting_Date) { }
            column(InitialBalance; tempTable.InitialBalance_debit) { }
            column(Dimension_Value_Name; tempTable.Dimension_Value_Name) { }
            column(AccountTotailng; tempTable.AccountTotailng) { }
            column(NotCode; tempTable.NitCode) { }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin

                tempTable.Reset();
                if tempTable.count = 0 then
                    currreport.break;
                SetRange(Number, 1, tempTable.Count);
            end;

            trigger OnAfterGetRecord()
            begin

                if Number = 1 then begin
                    if not tempTable.Find('-') then
                        CurrReport.Break();
                end else
                    if tempTable.Next() = 0 then
                        CurrReport.Break();
            end;
        }

    }


    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(Periodo)
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

                    field(Tercero; Tercero)
                    {
                        ApplicationArea = All;
                        Caption = 'Tercero';
                        trigger OnDrillDown()
                        var
                            D365LCOThirdMaster: Record "D365L CO Third Master";
                            pag: Page "D365L ThirdMasterList";
                        begin
                            D365LCOThirdMaster.SetFilter("D365L CO VAT Registration No.", Tercero + '*');
                            pag.SETTABLEVIEW(D365LCOThirdMaster);
                            pag.LOOKUPMODE(TRUE);
                            IF pag.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                pag.GETRECORD(D365LCOThirdMaster);
                                Tercero := D365LCOThirdMaster."D365L CO VAT Registration No.";
                            end;
                        end;
                    }
                    field(Cuenta; Cuenta)
                    {
                        ApplicationArea = All;
                        Caption = 'No. Cuenta';
                        trigger OnDrillDown()
                        var
                            sCuenta: Record "G/L Account";
                            pag: Page "G/L Account List";
                        begin
                            pag.SETTABLEVIEW(sCuenta);
                            pag.LOOKUPMODE(TRUE);
                            IF pag.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                pag.GETRECORD(sCuenta);
                                Cuenta := sCuenta."No.";
                            end;
                        end;
                    }
                }
            }

        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        llenarTabla();
    end;

    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        //  CompanyInformation.SetAutoCalcFields(Picture);
        CompanyInformation.get();
    end;

    var
        Cuenta: Code[20];
        dimensionDesc: Code[20];
        cantrows: Integer;
        CompanyInformation: Record "Company Information";
        CompanyNIT: Text;
        CompanyName: Text;
        PeriodoIni: Date;
        PeriodoFin: Date;
        ProcessDate: Text;
        DateEnd: Date;
        DimensionCode: Code[20];
        AccountNo: Code[20];
        Tercero: Code[50];
        fTercero: text;
        tempTable: Record "D365LATAM TrialBalanceCOL" temporary;

    local procedure llenarTabla()
    var
        qr: Query "D365LATAM AccountEntryQry";
        TrialBalanceReport: Query "D365LATAM TrialBalanceQry";
        //  temp: Integer;
        tempTableReport: Record "D365LATAM ReportTemp";
        //        glAccount: Query "D365LATAM AccountQry";

        rGLAccount: Record "G/L Account";

        Credit_Amount: Decimal;
        Debit_Amount: Decimal;
        totalAmountCredit: Decimal;
        InitialBalance_debit: Decimal;

        dimensionDesc: Code[20];
        DSE: Record "D365L CO Third Master";
        GLAccountType: Enum "G/L Account Type";

        Nit: Code[40];
        NitName: Text[100];
        id: Integer;

        validacionTercero: list of [text[50]];
    begin
        tempTable.DeleteAll();
        tempTableReport.DeleteAll();

        qr.SetFilter(Posting_Date, '>=%1&<=%2', PeriodoIni, PeriodoFin);
        qr.Open();
        while qr.Read() do begin
            tempTableReport.Init();
            tempTableReport.ID += 1;
            tempTableReport.G_L_Account_No_ := qr.G_L_Account_No_;
            tempTableReport.Shortcut_Dimension_3_Code := qr.Shortcut_Dimension_3_Code;
            //  tempTableReport.Nit := qr.VAT_Registration_No_;
            tempTableReport.Debit_Amount := qr.Debit_Amount;
            tempTableReport.Credit_Amount := qr.Credit_Amount;
            tempTableReport.Insert();
        end;
        qr.Close();

        TrialBalanceReport.SetFilter(Posting_Date, '..%1', PeriodoFin);
        if Cuenta <> '' then
            TrialBalanceReport.SetFilter(G_L_Account_No_, Cuenta);

        if Tercero <> '' then begin
            DSE.SetFilter("D365L CO VAT Registration No.", '%1', Tercero);
            if DSE.FindSet() then
                repeat
                    fTercero += DSE."No." + '|';
                until DSE.Next() = 0;
            if fTercero <> '' then
                fTercero := fTercero.Substring(1, Text.StrLen(fTercero) - 1);
        end;

        Nit := '-01';
        id := 1;
        if fTercero <> '' then
            // TrialBalanceReport.SetFilter(VAT_Registration_No_, Tercero);
            TrialBalanceReport.SetFilter(Shortcut_Dimension_3_Code, fTercero);
        TrialBalanceReport.Open();
        while TrialBalanceReport.Read() do begin
            Nit := '';
            NitName := '';

            if (TrialBalanceReport.Shortcut_Dimension_3_Code <> '') then begin
                Clear(DSE);
                DSE.SetFilter("No.", '%1', TrialBalanceReport.Shortcut_Dimension_3_Code);
                if DSE.FindFirst() then begin
                    Nit := DSE."D365L CO VAT Registration No.";
                    NitName := DSE.Name;
                end;
            end;

            /*  tempTable.Reset();
              tempTable.SetFilter(Shortcut_Dimension_3_Code, '%1', Nit);
              tempTable.SetFilter(G_L_Account_No_, TrialBalanceReport.G_L_Account_No_);
              if (not tempTable.FindFirst()) or (Nit = '-01') then begin*/
            //   Clear(tempTable);
            tempTable.Init();
            tempTable.ID := id;
            id += 1;
            tempTable.G_L_Account_No_ := TrialBalanceReport.G_L_Account_No_;
            tempTable.G_L_Account_Name := TrialBalanceReport.G_L_Account_Name;

            if (TrialBalanceReport.Shortcut_Dimension_3_Code <> '') then begin
                if Nit <> '' then begin
                    tempTable.Dimension_Value_Name := NitName;
                    tempTable.Shortcut_Dimension_3_Code := Nit;
                end else begin
                    tempTable.Dimension_Value_Name := '';
                    tempTable.Shortcut_Dimension_3_Code := '';
                end;
            end else begin
                tempTable.Dimension_Value_Name := '';
                tempTable.Shortcut_Dimension_3_Code := '';
            end;

            if (TrialBalanceReport.Account_Type <> TrialBalanceReport.Account_Type::Total) then begin
                tempTable.AccountType := 1;
            end else begin
                tempTable.AccountType := 0;
            end;

            if TrialBalanceReport.Account_Type = GLAccountType::Posting then
                tempTable.AccountTotailng := 'SI';

            Clear(tempTableReport);
            tempTableReport.SetFilter(G_L_Account_No_, TrialBalanceReport.G_L_Account_No_);
            if (TrialBalanceReport.Shortcut_Dimension_3_Code <> '') then begin
                tempTableReport.SetFilter(Shortcut_Dimension_3_Code, '%1', TrialBalanceReport.Shortcut_Dimension_3_Code);
            end else begin
                tempTableReport.SetRange(Shortcut_Dimension_3_Code, '');
            end;

            if (TrialBalanceReport.G_L_Account_No_ = '1105') then
                Debit_Amount := 0;

            if tempTableReport.FindFirst() then begin
                tempTable.Debit_Amount := tempTableReport.Debit_Amount;
                tempTable.Credit_Amount := tempTableReport.Credit_Amount;
                tempTable.InitialBalance_debit := TrialBalanceReport.Amount - (tempTableReport.Debit_Amount - tempTableReport.Credit_Amount);
            end else begin
                tempTable.Debit_Amount := 0;
                tempTable.Credit_Amount := 0;
                tempTable.InitialBalance_debit := TrialBalanceReport.Amount;
            end;
            tempTable.Amount := TrialBalanceReport.Amount;
            tempTable.Insert();
            /* end else begin
                 tempTableReport.Reset();
                 tempTableReport.SetFilter(G_L_Account_No_, TrialBalanceReport.G_L_Account_No_);
                 tempTableReport.SetFilter(Shortcut_Dimension_3_Code, '%1', TrialBalanceReport.Shortcut_Dimension_3_Code);

                 if (TrialBalanceReport.G_L_Account_No_ = '1105') then
                     Debit_Amount := 0;

                 if tempTableReport.FindFirst() then begin
                     tempTable.Debit_Amount += tempTableReport.Debit_Amount;
                     tempTable.Credit_Amount += tempTableReport.Credit_Amount;
                     tempTable.InitialBalance_debit += TrialBalanceReport.Amount - (tempTableReport.Debit_Amount - tempTableReport.Credit_Amount);
                 end else begin
                     tempTable.Debit_Amount += 0;
                     tempTable.Credit_Amount += 0;
                     tempTable.InitialBalance_debit += TrialBalanceReport.Amount;
                 end;
                 tempTable.Amount += TrialBalanceReport.Amount;
                 tempTable.Modify();
             end;*/
            //  end;
        end;
        TrialBalanceReport.Close();

        rGLAccount.SetFilter("Account Type", '%1', rGLAccount."Account Type"::Total);
        if rGLAccount.FindSet() then
            repeat
                if (rGLAccount."Account Type" = rGLAccount."Account Type"::Total) then begin
                    totalAmountCredit := 0;
                    InitialBalance_debit := 0;
                    Credit_Amount := 0;
                    Debit_Amount := 0;
                    if (rGLAccount."No." = '1105') then
                        Debit_Amount := 0;
                    tempTable.Reset();
                    tempTable.SetRange(AccountType, 1);
                    if tempTable.Count > 0 then begin
                        tempTable.SetFilter(G_L_Account_No_, Format(rGLAccount."No." + '*'));
                        if tempTable.Count > 0 then begin
                            tempTable.CalcSums(Amount, Debit_Amount, Credit_Amount, InitialBalance_debit);
                            totalAmountCredit := tempTable.Amount;
                            InitialBalance_debit := tempTable.InitialBalance_debit;
                            Credit_Amount := tempTable.Credit_Amount;
                            Debit_Amount := tempTable.Debit_Amount;
                        end;
                    end;

                    tempTable.Reset();
                    tempTable.SetFilter(G_L_Account_No_, rGLAccount."No.");
                    if tempTable.FindFirst() then begin
                        tempTable.Amount := totalAmountCredit;
                        tempTable.Debit_Amount := Debit_Amount;
                        tempTable.Credit_Amount := Credit_Amount;
                        tempTable.InitialBalance_debit := InitialBalance_debit;
                        tempTable.AccountTotailng := 'NO';
                        tempTable.Modify();
                    end;

                end;

            until rGLAccount.next() = 0;
    end;

}

