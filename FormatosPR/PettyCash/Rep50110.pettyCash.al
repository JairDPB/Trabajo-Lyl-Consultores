report 60106 pettyCash
{
    ApplicationArea = All;
    Caption = 'D365LATAM Caja menor';
    RDLCLayout = 'Reports/pettyCash.rdl';
    //RDLCLayout = 'Documento soporte1.rdl';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            column(No_; "No.") { }
            column(DimensionSetID; "Dimension Set ID") { }
            column(Amount; Amount) { }
            column(Amount_Including_VAT; "Amount Including VAT") { }
            column(Remaining_Amount; "Remaining Amount") { }
            column(Pay_to_Name; "Pay-to Name") { }
            column(Invoice_Discount_Amount; "Invoice Discount Amount") { }
            column(User_ID; "User ID") { }
            column(AmountInWords; AmountInWords) { }
            column(Valor; valor) { }
            column(Currency_Code; currency) { }
            column(Vendor_Invoice_No_; "Vendor Invoice No.") { }
            column(CompanyInformationName; CompanyInformation.Name) { }
            column(CompanyInformationVat; CompanyInformation."VAT Registration No.") { }
            column(CompanyInformationAddress; CompanyInformation.Address) { }
            column(CompanyInformationPhone; CompanyInformation."Phone No.") { }
            column(Posting_Date; "Posting Date") { }
            column(VAT_Reporting_Date; "VAT Reporting Date") { }
            column(Due_Date; "Due Date") { }
            column(Pay_to_Vendor_No_; "Pay-to Vendor No.") { }
            column(Pay_to_Address; "Pay-to Address") { }
            column(Pay_to_Contact; "Pay-to Contact") { }
            column(Pay_to_City; "Pay-to City") { }
            column(currency; currency) { }

            column(Posting_Description; "Posting Description") { }
            dataitem(Vendor; Vendor)
            {
                DataItemLink = Name = field("Pay-to Name");
                column(VAT_Registration_No_; "VAT Registration No.") { }
            }
            dataitem("Company Information"; "Company Information")
            {
                column(Picture; Picture) { }
            }

            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(LYLOC_CO_Third_No_; '') { }
                column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code") { }
                column(TERCERONIT; "Buy-from Vendor No.") { }
                column(NoCuenta_; "No.") { }
                column(Line_No_; "Line No.") { }
                column(TERCERO; TERCERO) { }
                column(TERCERONAME; TERCERONAME) { }
                column(Nombre; Nombre) { }
                column(DescriptionLine; Description) { }
                column(Unit_Cost; "Unit Cost") { }
                column(AmountS; Amount) { }

                column(Quantity; Quantity) { }
                column(iva; iva) { }
                column(ica; ica) { }
                column(ivaget; ivaget) { }
                column(fuente; fuente) { }
                column(totaliva; totaliva) { }
                column(totalica; totalica) { }
                column(totalfuente; totalfuente) { }
                column(totalivas; totalivas) { }
                column(reteiva; reteiva) { }
                column(reteica; reteica) { }
                column(retefuente; retefuente) { }
                column(ivaline; ivaamount) { }
                column(amountwithtax2; amountwithtax2) { }
                column(tax; tax) { }
                column(amountwithtax; amountwithtax) { }
                dataitem("G/L Account"; "G/L Account")
                {
                    DataItemLink = "No." = field("No.");
                    column(Name; Name) { }
                }
                dataitem(VendorLine; Vendor)
                {
                    DataItemLink = "No." = field("Buy-from Vendor No.");
                    column(NameThird; Name) { }
                    column(VAT_Registration_No_third; "VAT Registration No.") { }
                }
                trigger OnAfterGetRecord()
                var
                    DimensionValue: Record "Dimension Value";
                    cuenta: Record "G/L Entry";
                    dimension: record "Dimension Set Entry";
                    PurchInvHeader: Record "Purch. Inv. Header";
                    numberToText: Codeunit "LyL NumberToText_ING";
                    AmountText: array[2] of Text;
                    txtCharsToKeep: Text;
                    txtCharsToKeepNumeric: Text;

                begin


                    TERCERO := '';
                    TERCERONAME := '';
                    iva := getrteIVA("Document No.");
                    ivaget := getIVA("Document No.");
                    ica := getrteICA("Document No.");
                    fuente := getrteFuente("Document No.");

                    dimension.SetRange("Dimension Code", 'TERCERO');
                    dimension.SetRange("Dimension Set ID", "Dimension Set ID");
                    if dimension.FindFirst() then begin
                        TERCERO := dimension."Dimension Value Code";

                    end;
                    TERCERONAME := GETNAME(TERCERO);

                    reteiva := CalculateTaxAmount("Purch. Inv. Line", '05');
                    reteica := CalculateTaxAmount("Purch. Inv. Line", '07');
                    retefuente := CalculateTaxAmount("Purch. Inv. Line", '06');
                    ivaamount := CalculateTaxAmount("Purch. Inv. Line", '01');

                    totaliva := calculateTotalTax("Document No.", "Purch. Inv. Line", '05');
                    totalica := calculateTotalTax("Document No.", "Purch. Inv. Line", '07');
                    totalfuente := calculateTotalTax("Document No.", "Purch. Inv. Line", '06');
                    totalivas := calculateTotalTax("Document No.", "Purch. Inv. Line", '01');

                    currencyText := Format("Purch. Inv. Header"."Currency Code");
                    tax := Round(totaliva, 0.01, '>') + Round(totalica, 0.01, '>') + Round(totalfuente, 0.01, '>') + Round(totalivas, 0.01, '>');
                    amountwithtax := "Purch. Inv. Header"."Amount Including VAT" + tax;
                    numberToText.FormatNoText(AmountText, amountwithtax, 'COP');
                    amountwithtax2 := amountwithtax;
                    AmountInWords := AmountText[1] + AmountText[2];
                    valor := "Amount Including VAT" - Amount;

                    if currency = 'COP' then begin
                        if not AmountInWords.Contains(' PESOS ') then begin
                            if not AmountInWords.Contains(' CENTAVOS ') then begin
                                AmountInWords := AmountText[1] + AmountText[2] + ' PESOS';
                            end else begin
                                AmountInWords := AmountText[1] + ' PESOS ' + AmountText[2];
                            end;
                        end else begin
                            AmountInWords := AmountText[1] + AmountText[2];
                        end;
                    end;
                    if currency = 'USD' then begin
                        AmountInWords := AmountText[1] + AmountText[2];
                        if not AmountInWords.Contains('DOLARES') then begin
                            AmountInWords := AmountInWords.Replace('CENTAVOS', '');
                            AmountInWords += ' DOLARES';
                        end else begin
                            AmountInWords := AmountText[1] + AmountText[2];
                        end;
                    end;
                end;

            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = sorting(number);
                column(VATEntry_DianDesc; lylQueryGeneralTax.VATEntry_DianDesc) { }
                column(VATEntry_Amount; lylQueryGeneralTax.VATEntry_Amount) { }
                column(numero; numero) { }
                column(tarifa; lylQueryGeneralTax.VATEntry_tarifa) { }
                column(cuenta1; cuenta1) { }
                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, 100);
                    lylQueryGeneralTax.TopNumberOfRows(100);
                    lylQueryGeneralTax.SetFilter(Document_No, "Purch. Inv. Header"."No.");
                    lylQueryGeneralTax.SetFilter(VATEntry_DianCode, '<>ZZ');
                    lylQueryGeneralTax.Open();

                end;

                trigger OnAfterGetRecord()
                var


                    temptax: Code[20];
                begin
                    if lylQueryGeneralTax.Read() Then begin
                        temptax := lylQueryGeneralTax.VATEntry_DianCode;


                        VATEntry_Amount := calculateTotalTax("Purch. Inv. Line"."Document No.", lylQueryGeneralTax.VATEntry_DianCode, lylQueryGeneralTax.VATEntry_tarifa) * (-1);
                        VATEntry_DianDesc := lylQueryGeneralTax.VATEntry_DianDesc + ' ' + Format(lylQueryGeneralTax.VATEntry_tarifa, 0, '<Integer><Decimals,4>');
                    end
                    else begin
                        CurrReport.Skip();
                    end;
                end;
            }
            trigger OnAfterGetRecord()
            var
                numberToText: Codeunit "LyL NumberToText_ING";
                AmountText: array[2] of Text;
                txtCharsToKeep: Text;
                txtCharsToKeepNumeric: Text;
            begin

                currencyText := Format("Currency Code");
                numberToText.FormatNoText(AmountText, "Amount Including VAT", currencyText);
                AmountInWords := AmountText[1] + AmountText[2];
                valor := "Amount Including VAT" - Amount;

                if (currencyText = '') or (currencyText = 'COP') then begin
                    currency := 'COP';
                end
                else begin
                    currency := currencyText;
                end;

                if currency = 'COP' then begin
                    if not AmountInWords.Contains(' PESOS ') then begin
                        AmountInWords := AmountText[1] + ' PESOS' + AmountText[2];
                    end else begin
                        AmountInWords := AmountText[1] + AmountText[2];
                    end;
                end;
                if currency = 'USD' then begin
                    if not AmountInWords.Contains(' DOLARES ') then begin
                        AmountInWords := AmountText[1] + ' DOLARES' + AmountText[2];
                    end else begin
                        AmountInWords := AmountText[1] + AmountText[2];
                    end;
                end;
            end;
        }
    }
    trigger OnInitReport()
    begin
        CompanyInformation.CalcFields(Picture);
        CompanyInformation.get();
    end;


    procedure calculateTotalTax(SIH_no: Code[20]; taxCode: Code[5]; tarifa: Decimal): Decimal
    var
        ST: Record "VAT Entry";
        SIH: Record "Purch. Inv. Header";
        ER: Decimal;
    begin
        SIH.SetFilter("No.", SIH_no);
        SIH.FindFirst();
        ST.SetFilter("Document No.", SIH_no);
        ST.SetFilter("D365L PR VAT HACIENDA Code", taxCode);
        ST.SetRange("D365L PR Tax Above Maximum COL", tarifa);
        if (SIH."Currency Code" <> 'COP') and (SIH."Currency Code" <> '') then begin
            ER := Round((1 / SIH."Currency Factor"), 0.01, '=');
            ST.CalcSums(Amount);
            exit(Round((ST.Amount / ER), 0.01, '='));
        end else begin
            ST.CalcSums(Amount);
            exit(ST.Amount);
        end;
    end;

    procedure getrteICA(DocumentNo: Code[30]): Decimal
    var
        VATEntry: Record "VAT Entry";
    begin
        VATEntry.SetFilter("Document No.", DocumentNo);
        VATEntry.SetFilter("D365L PR VAT HACIENDA Code", '07');
        if (VATEntry.FindFirst()) then begin
            exit(VATEntry.Amount);
        end else begin
            exit(0);
        end;
    end;

    procedure getrteIVA(DocumentNo: Code[30]): Decimal
    var
        VATEntry: Record "VAT Entry";
    begin
        VATEntry.SetFilter("Document No.", DocumentNo);
        VATEntry.SetFilter("D365L PR VAT HACIENDA Code", '05');
        if (VATEntry.FindFirst()) then begin
            exit(VATEntry.Amount);
        end else begin
            exit(0);
        end;

    end;

    procedure getIVA(DocumentNo: Code[30]): Decimal
    var
        VATEntry: Record "VAT Entry";
    begin
        VATEntry.SetFilter("Document No.", DocumentNo);
        VATEntry.SetFilter("D365L PR VAT HACIENDA Code", '01');
        if (VATEntry.FindFirst()) then begin
            exit(VATEntry.Amount);
        end else begin
            exit(0);
        end;

    end;

    procedure getrteFuente(DocumentNo: Code[30]): Decimal
    var
        VATEntry: Record "VAT Entry";
    begin
        VATEntry.SetFilter("Document No.", DocumentNo);
        VATEntry.SetFilter("D365L PR VAT HACIENDA Code", '06');
        if (VATEntry.FindFirst()) then begin
            exit(VATEntry.Amount);
        end else begin
            exit(0);
        end;
    end;

    procedure gettotalICA(DocumentNo: Code[30]): Decimal
    var
        VATEntry: Record "VAT Entry";
    begin
        VATEntry.SetFilter("Document No.", DocumentNo);
        VATEntry.SetFilter("D365L PR VAT HACIENDA Code", '07');
        if (VATEntry.FindFirst()) then begin
            VATEntry.CalcSums(Amount);
            exit(VATEntry.Amount);
        end else begin
            exit(0);
        end;
    end;

    procedure gettotalIVA(DocumentNo: Code[30]): Decimal
    var
        VATEntry: Record "VAT Entry";
    begin
        VATEntry.SetFilter("Document No.", DocumentNo);
        VATEntry.SetFilter("D365L PR VAT HACIENDA Code", '05');
        if (VATEntry.FindFirst()) then begin
            VATEntry.CalcSums(Amount);
            exit(VATEntry.Amount);
        end else begin
            exit(0);
        end;

    end;

    procedure gettotalsIVA(DocumentNo: Code[30]): Decimal
    var
        VATEntry: Record "VAT Entry";
    begin
        VATEntry.SetFilter("Document No.", DocumentNo);
        VATEntry.SetFilter("D365L PR VAT HACIENDA Code", '01');
        if (VATEntry.FindFirst()) then begin
            VATEntry.CalcSums(Amount);
            exit(VATEntry.Amount);
        end else begin
            exit(0);
        end;

    end;

    procedure gettotalFuente(DocumentNo: Code[30]): Decimal
    var
        VATEntry: Record "VAT Entry";
    begin
        VATEntry.SetFilter("Document No.", DocumentNo);
        VATEntry.SetFilter("D365L PR VAT HACIENDA Code", '06');
        if (VATEntry.FindFirst()) then begin
            VATEntry.CalcSums(Amount);
            exit(VATEntry.Amount);
        end else begin
            exit(0);
        end;
    end;


    var
        CompanyInformation: Record "Company Information";
        AmountInWords: Text;
        NoText: array[2] of Text;
        Stream: InStream;

        VATEntry_Amount: Decimal;

        cuenta1: Code[20];

        VATEntry_DianDesc: Text[100];

        lylQueryGeneralTax: Query "LyL LyLGeneralTaxQuery";
        observation: Text[100];
        amountRound: Decimal;
        valor: decimal;
        numero: Code[20];
        Nombre: Text[50];
        TERCERO: CODE[200];

        TERCERONAME: Text[200];

        currency: Text[50];

        currencyText: Text[50];

        iva: Decimal;
        ica: Decimal;
        fuente: Decimal;
        ivaget: Decimal;

        totaliva: Decimal;
        totalica: Decimal;
        totalfuente: Decimal;
        totalivas: Decimal;

        reteiva: Decimal;
        reteica: Decimal;
        retefuente: Decimal;
        ivaamount: Decimal;

        amountwithtax: Decimal;
        amountwithtax2: Decimal;

        tax: Decimal;
        currencypety: Text;

    procedure GETNAME(cod: Code[20]): Text[200]
    var
        v: Record "Dimension Value";
    begin
        v.SetFilter(Code, cod);
        if (v.FindFirst()) then begin
            exit(v.Name);
        end;
    end;

    local procedure CalculateTaxAmount(pil: Record "Purch. Inv. Line"; codedian: Code[10]): Decimal
    var
        taxArea: Record "Tax Area Line";
        taxGroup: Record "Tax Group";
        taxDetail: Record "Tax Detail";
        taxJurisdiction: Record "Tax Jurisdiction";
        LYLOC_CO_DIAN_Setup: Record "D365L PR HACIENDA Setup";

        flag: Boolean;
        isRetention: Boolean;
        pilamounttax: Decimal;
    begin
        taxArea.SetFilter("Tax Area", pil."Tax Area Code");
        taxDetail.SetFilter("Tax Group Code", pil."Tax Group Code");

        if taxArea.FindSet() then
            repeat
                taxDetail.SetFilter("Tax Jurisdiction Code", taxArea."Tax Jurisdiction Code");
                if taxDetail.FindSet() then
                    repeat
                        flag := false;
                        if taxDetail."D365L PR Tax Apply" then begin
                            taxJurisdiction.SetFilter(Code, taxDetail."Tax Jurisdiction Code");
                            taxJurisdiction.SetRange("D365L PR VAT Retention", false);
                            taxJurisdiction.SetFilter("D365L PR VAT HACIENDA Code", codedian);
                            LYLOC_CO_DIAN_Setup.SetFilter("Table Code", '1005');
                            if taxJurisdiction.FindFirst() then begin
                                LYLOC_CO_DIAN_Setup.SetFilter("HACIENDA Code", taxJurisdiction."D365L PR VAT HACIENDA Code");
                                LYLOC_CO_DIAN_Setup.FindFirst();
                                if pil.Amount >= taxDetail."Maximum Amount/Qty." then begin

                                    pilamounttax := (pil.Amount * taxDetail."Tax Below Maximum") / 100;
                                    exit(pilamounttax);
                                end;
                            end;
                        end;
                    until taxDetail.Next() = 0;
            until taxArea.Next() = 0;
    end;

    local procedure calculatetotaltax(DocumentNo: Code[50]; pil: Record "Purch. Inv. Line"; codedian: Code[10]): Decimal
    var
        v: Record "Purch. Inv. Line";
        totaltax: Decimal;
    begin
        totaltax := 0;
        v.SetFilter("Document No.", DocumentNo);
        if v.FindSet() then
            repeat
                totaltax := totaltax + CalculateTaxAmount(pil, codedian);
            until v.Next() = 0;
        exit(totaltax);
    end;
}