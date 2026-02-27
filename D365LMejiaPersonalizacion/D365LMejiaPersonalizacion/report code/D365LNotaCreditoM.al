///<summary>
///Reporte Nota Credito de venta
///</summary>
report 88100 "D365L Nota CreditoM"
{
    ApplicationArea = All;
    Caption = 'Nota Credito';
    RDLCLayout = 'Report/D365LNotaCreditoM.rdl';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(SalesCrMemoHdr; "Sales Cr.Memo Header")
        {
            RequestFilterFields = "No.";
            DataItemTableView = SORTING("No.");
            column(Currency_Code; "Currency Code") { }
            column(SalesCrMemoHdrNo_; "No.") { }
            column(SalesCrMemoHdrDimensionSetID; "Dimension Set ID") { }
            column(SalesCrMemoHdrAmount; Amount) { }
            column(SalesCrMemoHdrAmount_Including_VAT; AmountIncVat) { }
            column(SalesCrMemoHdrRemaining_Amount; "Remaining Amount") { }
            column(SalesCrMemoHdrPay_to_Name; "Sell-to Customer Name") { }
            column(SalesCrMemoHdrInvoice_Discount_Amount; "Invoice Discount Amount") { }
            column(SalesCrMemoHdrUser_ID; "User ID") { }
            column(SalesCrMemoHdrDocument_Date; "Document Date") { }
            column(SalesCrMemoHdrAmountInWords; AmountInWords) { }
            column(SalesCrMemoHdrValor; valor) { }
            column(SalesCrMemoHdrCurrency_Code; currency) { }
            column(CompanyInfoName; CompanyInformation.Name) { }
            column(CompanyInfoVat; CompanyInformation."VAT Registration No.") { }
            column(CompanyInfoAddress; CompanyInformation.Address) { }
            column(CompanyInfoPhone; CompanyInformation."Phone No.") { }
            column(CompanyInfoEMail; CompanyInformation."E-Mail") { }
            column(CompanyInfoPicture; CompanyInformation.Picture) { }
            column(SalesCrMemoHdrPosting_Date; "Posting Date") { }
            column(SalesCrMemoHdrVAT_Reporting_Date; "VAT Reporting Date") { }
            column(SalesCrMemoHdrDue_Date; "Due Date") { }
            column(SalesCrMemoHdrPay_to_Vendor_No_; "Sell-to Customer No.") { }
            column(SalesCrMemoHdrPay_to_Address; "Sell-to Address") { }
            column(SalesCrMemoHdrPay_to_Contact; "sell-to Contact") { }
            column(SalesCrMemoHdrPosting_Description; getworkdescription) { }
            column(SalesCrMemoHdrPay_to_City; "Sell-to City") { }
            column(SalesCrMemoHdrPay_to_Contact_No_; "Sell-to Contact No.") { }
            column(SalesCrMemoHdrLyL_CUFE; "D365L CO FE CUFE") { }
            column(SalesCrMemoHdrCurrency_Factor; currencyF) { }

            column(SalesCrMemoHdrLyL_QRInvoiceLink; "D365L CO fe QRInvoiceLink") { }
            column(D365L_CO_Resolution_No_; TempNoSeriesLine."D365L CO Resolution No.") { }
            //  column(D365L_CO_FE_Prefix; ) { }
            column(D365L_CO_Res__Ending_Date; TempNoSeriesLine."D365L CO Res. Ending Date") { }
            column(Starting_Date; TempNoSeriesLine."D365L CO Resol. Appr.Date DIAN") { }
            column(Starting_No_; TempNoSeriesLine."Starting No.") { }
            column(Ending_No_; TempNoSeriesLine."Ending No.") { }
            column(D365L_CO_DS_Date_load; "D365L CO FE Date_load") { }
            column(salamou; salamou) { }
            column(piedpag1; piedpag1) { }
            column(piedpag2; piedpag2) { }
            column(piedpag3; piedpag3) { }
            column(piedpag4; piedpag4) { }
            column(marcaAgua; marcaAgua) { }
            column(metodpay; metodpay) { }
            column(termspay; termspay) { }
            column(numLineas; numLineas) { }
            column(FormaPago; FormaPago) { }
            column(CufeDocRef; cufedocref) { }
            column(ConceptoDes; ConceptoDes) { }
            column(D365L_CO_Concept_DIAN; "D365L CO FE Concept DIAN") { }
            column(Your_Reference; "Your Reference") { }
            column("InvoiceDiscountAmount"; "Invoice Discount Amount") { }
            column("D365LCOFENoCorrDocFR"; "D365L CO FE No. Corr. Doc. FR") { }
            column(CalcuSalamount; CalcuSalamount) { }
            column(calcudiscuount; calcudiscuount) { }
            column(Calcuamount; Calcuamount) { }
            column(calcutotal; calcutotal) { }
            column(SalesCrMemoHdrSell_to_E_Mail; "Sell-to E-Mail") { }
            column(AmountInWords_org; AmountInWords_org) { }
            column(ParDisContable; DisContable) { }
            column(User_NameCreator; User_NameCreator){}
            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = field("Sell-to Customer No.");
                column(CustVAT_Registration_No_; "VAT Registration No.") { }
            }

            dataitem(User; User)
            {
                DataItemTableView = SORTING("User Security ID");
                DataItemLink = "User Name" = field("User ID");
                column(User_Security_ID; "User Security ID")
                {

                }
                column(User_Name; "Full Name")
                {

                }
            }



            dataitem(TaxLines; Integer)
            {
                DataItemTableView = sorting(Number);

                column(VATEntry_Amount; VATEntry_Amount) { }
                column(VATEntry_DianDesc; VATEntry_DianDesc) { }
                column(VATEntry_DianCode; lylQueryGeneralTax.VATEntry_DianCode) { }
                column(VATEntry_tarifa; lylQueryGeneralTax.VATEntry_tarifa) { }
                column(Calcutax; Calcutax) { }
                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    SetRange(Number, 1, 100);
                    lylQueryGeneralTax.TopNumberOfRows(100);
                    lylQueryGeneralTax.SetFilter(Document_No, SalesCrMemoHdr."No.");
                    lylQueryGeneralTax.SetFilter(VATEntry_DianCode, '<>ZZ');
                    lylQueryGeneralTax.Open();

                end;

                trigger OnAfterGetRecord()
                var
                //  temptax: Code[20];
                begin
                    if lylQueryGeneralTax.Read() then begin
                        //  temptax := lylQueryGeneralTax.VATEntry_DianCode;
                        //  VATEntry_Amount := LyLSalesInvoiceReportStandard.calculateTotalTax(Header."No.", lylQueryGeneralTax.VATEntry_DianCode, lylQueryGeneralTax.VATEntry_tarifa) * (-1);
                        VATEntry_DianDesc := lylQueryGeneralTax.VATEntry_DianDesc + ' ' + Format(lylQueryGeneralTax.VATEntry_tarifa, 0, '<Integer><Decimals,4>') + '%';
                        if (SalesCrMemoHdr."Currency Code" <> 'COP') and (SalesCrMemoHdr."Currency Code" <> '') then begin
                            VATEntry_Amount := lylQueryGeneralTax.VATEntry_Amount;
                            Calcutax := lylQueryGeneralTax.VATEntry_Amount * SalesCrMemoHdr."Currency Factor";
                        end else begin
                            VATEntry_Amount := lylQueryGeneralTax.VATEntry_Amount;
                            Calcutax := lylQueryGeneralTax.VATEntry_Amount;
                        end
                    end
                    else begin
                        CurrReport.Skip();
                    end;
                    User.SetFilter("User Security ID", SystemCreatedBy);
                    if User.FindFirst() then
                    User_NameCreator := User."Full Name";
                end;
                
            }


            dataitem(SalesCrMemoLine; "Sales Cr.Memo Line")
            {
                DataItemTableView = SORTING("Document No.");
                DataItemLink = "Document No." = field("No.");
                column(SalesCrMemoLineShortcut_Dimension_1_Code; "Shortcut Dimension 1 Code") { }
                column(SalesCrMemoLineBuyFromVendorNo; "Sell-to Customer No.") { }
                column(SalesCrMemoLineNoNo; "No.") { }
                column(SalesCrMemoLineLine_No_; "Line No.") { }
                column(SalesCrMemoLineTERCERO; TERCERO) { }
                column(SalesCrMemoLineNombre; Nombre) { }
                column(SalesCrMemoLineDescriptionLine; Description) { }
                column(SalesCrMemoLineUnit_Cost; "Unit Price") { }
                column(SalesCrMemoLineAmount; Amount) { }
                column(SalesCrMemoLineQuantity; Quantity) { }
                column(VatEntrycuenta1; cuenta1) { }
                column(SalesCrMemoLineUnit_of_Measure; "Unit of Measure Code") { }
                column(OrgLineAmount; OrgLineAmount) { }
                column(OrgLineUnitPrice; OrgLineUnitPrice) { }
                dataitem("G/L Account"; "G/L Account")
                {
                    DataItemTableView = SORTING("No.");
                    DataItemLink = "No." = field("No.");
                    column(GLAcountName; Name) { }
                }

                trigger OnPreDataItem()
                var
                    dimension: record "Dimension Set Entry";
                begin
                    dimension.SetRange("Dimension Code", 'TERCERO');
                    dimension.SetRange("Dimension Set ID", "Dimension Set ID");
                    if dimension.FindFirst() then begin
                        TERCERO := dimension."Dimension Value Code";
                    end;
                end;

                trigger OnAfterGetRecord()
                var
                    nombre1: Record "Dimension Value";
                    cuenta: Record "G/L Entry";
                    PurchInvHeader: Record "Purch. Cr. Memo Hdr.";

                begin
                    nombre1.SetRange("Dimension Code", 'TERCERO');
                    nombre1.SetRange(Code, TERCERO);
                    cuenta.SetRange("Document No.", SalesCrMemoHdr."No.");
                    cuenta1 := cuenta."G/L Account No.";
                    OrgLineAmount := 0;
                    OrgLineUnitPrice := 0;
                    if (SalesCrMemoHdr."Currency Code" <> '') then begin
                        OrgLineAmount := "Line Amount";
                        OrgLineUnitPrice := "Unit Price";
                        Amount := Amount * currencyF;
                        "Unit Cost" := "Unit Cost" * currencyF;
                    end;
                end;

            }
            dataitem("G/L Entry"; "G/L Entry")
            {
                DataItemTableView = SORTING("Document No.");
                DataItemLink = "Document No." = field("No."), "Posting Date" = field("Posting Date");
                column(GL_Account_No; "G/L Account No.") { }
                column(GL_Account_Name; "G/L Account Name") { }
                column(Debit_Amount; "Debit Amount") { }
                column(Credit_Amount; "Credit Amount") { }
            }

            trigger OnAfterGetRecord()
            var
                numberToText: Codeunit "LyL NumberToText_ING";
                AmountText: array[2] of Text;
                txtCharsToKeep: Text;
                txtCharsToKeepNumeric: Text;
                paymet: record "Payment Method";
                payterms: record "Payment Terms";
                lines: record "Sales Cr.Memo Line";
                pidpagina: Record "Sales & Receivables Setup";
                SIH: Record "Sales Invoice Header";
                DIANSETUP: Record "D365L CO DIAN Setup";
                User: Record User;

            begin
                FormaPago := '';
                numLineas := 0;
                CufeDocRef := '';
                if SalesCrMemoHdr."Payment Terms Code" <> '' then begin
                    payterms.SetFilter(code, SalesCrMemoHdr."Payment Terms Code");
                    paymet.SetFilter(Code, SalesCrMemoHdr."Payment Method Code");
                    if payterms.FindFirst() then begin
                        termspay := payterms.Description;
                        if payterms."D365L CO FE DIAN Setup" = '2' then
                            FormaPago := 'CREDITO';
                        if payterms."D365L CO FE DIAN Setup" = '1' then
                            FormaPago := 'CONTADO';
                    end;
                    if paymet.FindFirst() then begin
                        metodpay := paymet.Description;
                    end;
                end;

                User.SetFilter("User Security ID", SystemCreatedBy);
                if User.FindFirst() then
                    User_NameCreator := User."Full Name";

                currencyF := 0;
                if SalesCrMemoHdr."Currency Factor" > 0 then begin
                    currencyF := 1 / SalesCrMemoHdr."Currency Factor";
                end;
                clear(SIH);
                if SalesCrMemoHdr."D365L CO FE No. Corr. Doc. FR" <> '' then begin
                    SIH.SetFilter("No.", SalesCrMemoHdr."D365L CO FE No. Corr. Doc. FR");
                    if SIH.FindFirst() then begin
                        CufeDocRef := SIH."D365L CO FE CUFE";
                    end else begin
                        CufeDocRef := SalesCrMemoHdr."D365L CO FE CUFE_DocRef_text";
                    end;


                end else begin
                    CufeDocRef := SalesCrMemoHdr."D365L CO FE CUFE_DocRef_text";

                end;

                valor := "Amount Including VAT" - Amount;
                currencyText := Format("Currency Code");

                currency := 'COP';
                lines.SetFilter("Document No.", SalesCrMemoHdr."No.");
                lines.SetFilter(Quantity, '>0');
                numLineas := lines.Count();
                lines.CalcSums("Line Amount", "Amount Including VAT");


                salamou := lines."Line Amount";
                if (SalesCrMemoHdr."Currency Code" <> '') then begin
                    AmountIncVat := Round(lines."Amount Including VAT" * currencyF, 0.01, '=');

                    CalcuSalamount := salamou;
                    calcudiscuount := SalesCrMemoHdr."Invoice Discount Amount";
                    Calcuamount := SalesCrMemoHdr.Amount;
                    calcutotal := lines."Amount Including VAT";

                    salamou := salamou * currencyF;
                    SalesCrMemoHdr."Invoice Discount Amount" := SalesCrMemoHdr."Invoice Discount Amount" * currencyF;
                    Amount := SalesCrMemoHdr.Amount * currencyF;
                    "Amount Including VAT" := "Amount Including VAT" * currencyF;

                end
                else begin
                    CalcuSalamount := 0;
                    calcudiscuount := 0;
                    Calcuamount := 0;
                    calcutotal := 0;
                    AmountIncVat := Round(lines."Amount Including VAT", 0.01, '=');

                end;

                /*   if (currencyText = '') or (currencyText = 'COP') then begin
                       currency := 'COP';
                   end
                   else
                       currency := currencyText;*/
                numberToText.FormatNoText(AmountText, AmountIncVat, 'COP');
                AmountInWords := AmountText[1] + AmountText[2];

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
                if SalesCrMemoHdr."Currency Code" <> '' then begin
                    numberToText.FormatNoText(AmountText, calcutotal, SalesCrMemoHdr."Currency Code");
                    AmountInWords_org := AmountText[1] + AmountText[2];
                    if not AmountInWords_org.Contains('DOLARES') then begin
                        AmountInWords_org := AmountInWords_org.Replace('CENTAVOS', '');
                        AmountInWords_org += ' DOLARES';
                    end else begin
                        AmountInWords_org := AmountText[1] + AmountText[2];
                    end;
                end;


                if pidpagina.FindFirst() then begin
                    piedpag1 := pidpagina."D365L CO FE Texto1";
                    piedpag2 := pidpagina."D365L CO FE Texto2";
                    piedpag3 := pidpagina."D365L CO FE Texto3";
                    piedpag4 := pidpagina."D365L CO FE InfoSoftware";

                end;


                TempNoSeriesLine.SetFilter("Series Code", "No. Series");
                if not TempNoSeriesLine.IsEmpty then
                    TempNoSeriesLine.FindFirst();

                marcaAgua := '';

                if SalesCrMemoHdr."D365L CO FE Status_EBill" <> SalesCrMemoHdr."D365L CO FE Status_EBill"::PROCESADA then begin

                    marcaAgua := 'lleno';
                end;
                ConceptoDes := '';
                DIANSETUP.SetFilter("DIAN Code", SalesCrMemoHdr."D365L CO FE Concept DIAN");
                DIANSETUP.SetFilter("Table Code", '110');
                if DIANSETUP.FindFirst() then
                    ConceptoDes := DIANSETUP.Description;
            end;




            trigger OnPreDataItem()
            begin

                if NoValor <> '' then begin
                    SetFilter("No.", NoValor);
                end /*else
                    Error('Debe seleccionar un documento');*/
            end;
        }
    }

    requestpage
    {
        SaveValues = TRUE;

        layout
        {
            area(content)
            {
                group(Opciones)
                {
                    Caption = 'Filtros';

                    field(NoValor; NoValor)
                    {
                        ApplicationArea = All;
                        Caption = 'No. Documento';
                        // ShowMandatory = true;

                        trigger OnDrillDown()
                        var
                            dim: Record "Sales Cr.Memo Header";
                            pag: Page "Posted Sales Credit Memos";
                        begin
                            //dim.SetRange("D365L CO fe Status_EBill", dim."D365L CO fe Status_EBill"::PROCESADA);
                            pag.SETTABLEVIEW(dim);
                            pag.LOOKUPMODE(TRUE);
                            IF pag.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                pag.GETRECORD(dim);
                                NoValor := dim."No.";
                            end;
                        end;
                    }
                    field(DisContable; DisContable)
                    {
                        ApplicationArea = all;
                        Caption = 'Mostrar Distribución Contable';
                    }
                }
            }
        }
    }
    trigger OnInitReport()
    begin
        CompanyInformation.SetAutoCalcFields(Picture);
        CompanyInformation.get();
    end;
    ///<summary>
    /// Procedimiento para obtener las observaciones de notas credito de venta
    /// </summary>
    procedure GetWorkDescription(PurchHeader: Record "Sales Cr.Memo Header") WorkDescription: Text
    var
        MyInStream: InStream;

    begin
        Clear(WorkDescription);
        PurchHeader.Calcfields("Work Description");
        If PurchHeader."Work Description".HasValue() then begin
            PurchHeader."Work Description".CreateInStream(MyInStream, TextEncoding::UTF8);
            MyInStream.Read(WorkDescription);
        end;
    end;


    var
        DisContable: Boolean;
        User_NameCreator: Text[100];
        AmountIncVat: decimal;
        OrgLineAmount: Decimal;
        OrgLineUnitPrice: Decimal;
        salamou: Decimal;
        CalcuSalamount: Decimal;
        calcudiscuount: Decimal;
        Calcuamount: Decimal;
        calcutotal: Decimal;
        piedpag1: Text;
        piedpag2: text;
        piedpag3: text;
        piedpag4: text;
        termspay: Text;
        metodpay: Text;
        marcaAgua: TEXT;

        TempNoSeriesLine: Record "No. Series Line";
        CompanyInformation: Record "Company Information";
        AmountInWords: Text;
        AmountInWordsC: Text;
        NoText: array[2] of Text;
        Stream: InStream;

        VATEntry_Amount: Decimal;

        cuenta1: Code[20];

        VATEntry_DianDesc: Text[100];
        NoValor: Code[30];
        Calcutax: Decimal;
        currencyF: Decimal;

        lylQueryGeneralTax: Query "D365L GeneralTaxQuery";
        observation: Text[100];
        amountRound: Decimal;
        valor: decimal;
        numero: Code[20];
        Nombre: Text[50];
        TERCERO: CODE[20];
        currencyText: text[50];
        currency: text[50];
        FormaPago: code[20];
        numLineas: Integer;
        CufeDocRef: text[100];
        ConceptoDes: text[250];
        AmountInWords_org: text;
}