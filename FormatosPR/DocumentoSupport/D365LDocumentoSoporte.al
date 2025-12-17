/*report 50104 "D365L Documento Soporte"
{
    ApplicationArea = All;
    Caption = 'Documento Soporte';
    RDLCLayout = 'Reports/D365LDocumentoSoporte.rdl';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            DataItemTableView = SORTING("No.");

            column(PurchInvHeadNo_; "No.") { }

            column(PurchInvHeadDimensionSetID; "Dimension Set ID") { }
            column(PurchInvHeadAmount; Amount) { }
            column(PurchInvHeadAmount_Including_VAT; "Amount Including VAT") { }
            column(PurchInvHeadRemaining_Amount; "Remaining Amount") { }
            column(PurchInvHeadPay_to_Name; "Pay-to Name") { }
            column(PurchInvHeadInvoice_Discount_Amount; "Invoice Discount Amount") { }
            column(PurchInvHeadUser_ID; "User ID") { }
            column(PurchInvHeadDocument_Date; "Document Date") { }
            column(PurchInvHeadAmountInWords; AmountInWords) { }
            column(PurchInvHeadValor; valor) { }
            column(PurchInvHeadCurrency_Code; currency) { }
            column(PurchInvHeadVendor_Invoice_No_; "Vendor Invoice No.") { }
            column(CompanyInfoName; CompanyInformation.Name) { }
            column(CompanyInfoVat; CompanyInformation."VAT Registration No.") { }
            column(CompanyInfoAddress; CompanyInformation.Address) { }
            column(CompanyInfoPhone; CompanyInformation."Phone No.") { }
            column(CompanyInfoEMail; CompanyInformation."E-Mail") { }
            column(CompanyInfoPicture; CompanyInformation.Picture) { }
            column(PurchInvHeadPosting_Date; "Posting Date") { }
            column(PurchInvHeadVAT_Reporting_Date; "VAT Reporting Date") { }
            column(PurchInvHeadDue_Date; "Due Date") { }
            column(PurchInvHeadPay_to_Vendor_No_; "Pay-to Vendor No.") { }
            column(PurchInvHeadPay_to_Address; "Pay-to Address") { }
            column(PurchInvHeadPay_to_Contact; "Pay-to Contact") { }
            column(PurchInvHeadPosting_Description; "Posting Description") { }
            column(PurchInvHeadPay_to_City; "Pay-to City") { }
            column(PurchInvHeadPay_to_Contact_No_; "Pay-to Contact No.") { }
            column(PurchInvHeadLyL_CUFE; "D365L CO DS CUFE") { }
            column(PurchInvHeadLyL_QRInvoiceLink; "D365L CO DS QRInvoiceLink") { }
            column(D365L_CO_Resolution_No_; TempNoSeriesLine."D365L CO Resolution No.") { }
            //  column(D365L_CO_FE_Prefix; ) { }
            //column(D365L_CO_Res__Ending_Date; TempNoSeriesLine."G2LCO_Resolution Ending Date") { }
            column(Starting_Date; TempNoSeriesLine."D365L CO Resol. Appr.Date DIAN") { }
            column(Starting_No_; TempNoSeriesLine."Starting No.") { }
            column(Ending_No_; TempNoSeriesLine."Ending No.") { }
            column(PurchInvHeadCurrency_Factor; currencyF) { }
            column(salamou; salamou) { }
            column(piedpag1; piedpag1) { }
            column(piedpag2; piedpag2) { }
            column(piedpag3; piedpag3) { }
            column(marcaAgua; marcaAgua) { }
            column(metodpay; metodpay) { }
            column(termspay; termspay) { }
            column(Your_Reference; "Your Reference") { }
            column("InvoiceDiscountAmount"; "Invoice Discount Amount") { }
            column(CalcuSalamount; CalcuSalamount) { }
            column(calcudiscuount; calcudiscuount) { }
            column(Calcuamount; Calcuamount) { }
            column(calcutotal; calcutotal) { }
            column(D365L_CO_DS_Date_load; "D365L CO ds Date_load") { }
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
            dataitem(Vendor; Vendor)
            {
                DataItemTableView = SORTING("No.");
                DataItemLink = "No." = field("Pay-to vendor No.");

                column(E_Mail; "E-Mail")
                {

                }
            }
            dataitem(TaxLines; Integer)
            {
                DataItemTableView = SORTING(Number);
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
                    lylQueryGeneralTax.SetFilter(Document_No, "Purch. Inv. Header"."No.");
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
                        if ("Purch. Inv. Header"."Currency Code" <> 'COP') and ("Purch. Inv. Header"."Currency Code" <> '') then begin

                            VATEntry_Amount := lylQueryGeneralTax.VATEntry_Amount / currencyF;

                            Calcutax := VATEntry_Amount * currencyF;

                        end else begin

                            VATEntry_Amount := lylQueryGeneralTax.VATEntry_Amount;
                            Calcutax := VATEntry_Amount * currencyF;

                        end;

                    end
                    else begin
                        CurrReport.Skip();
                    end;
                end;
            }

            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemTableView = SORTING("Document No.");
                DataItemLink = "Document No." = field("No.");
                column(PurchInvLineShortcut_Dimension_1_Code; "Shortcut Dimension 1 Code") { }
                column(PurchInvLineBuyFromVendorNo; "Buy-from Vendor No.") { }
                column(PurchInvLineNoNo; "No.") { }
                column(PurchInvLineLine_No_; "Line No.") { }
                column(PurchInvLineTERCERO; TERCERO) { }
                column(PurchInvLineNombre; Nombre) { }
                column(PurchInvLineDescriptionLine; Description) { }
                column(PurchInvLineUnit_Cost; "Unit Cost") { }
                column(PurchInvLineAmount; Amount) { }
                column(PurchInvLineQuantity; Quantity) { }
                column(VatEntrycuenta1; cuenta1) { }
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
                    "Purch. Inv. Line".SetFilter("Unit Cost", '>0');
                    if dimension.FindFirst() then begin
                        TERCERO := dimension."Dimension Value Code";
                    end;
                end;

                trigger OnAfterGetRecord()
                var
                    nombre1: Record "Dimension Value";
                    cuenta: Record "G/L Entry";
                    PurchInvHeader: Record "Purch. Inv. Header";

                begin
                    nombre1.SetRange("Dimension Code", 'TERCERO');
                    nombre1.SetRange(Code, TERCERO);
                    cuenta.SetRange("Document No.", "Purch. Inv. Line"."Document No.");
                    cuenta1 := cuenta."G/L Account No.";
                end;

            }


            trigger OnAfterGetRecord()
            var
                numberToText: Codeunit "LyL NumberToText_ING";
                AmountText: array[2] of Text;
                txtCharsToKeep: Text;
                txtCharsToKeepNumeric: Text;
                paymet: record "Payment Method";
                payterms: record "Payment Terms";
                lines: record "Purch. Inv. Line";
                pidpagina: Record "Sales & Receivables Setup";
            begin
                if "Purch. Inv. Header"."Payment Terms Code" <> '' then begin
                    payterms.SetFilter(code, "Purch. Inv. Header"."Payment Terms Code");
                    paymet.SetFilter(Code, "Purch. Inv. Header"."Payment Method Code");
                    if payterms.FindFirst() then begin
                        termspay := payterms.Description;
                    end;
                    if paymet.FindFirst() then begin
                        metodpay := paymet.Description;
                    end;
                end;
                valor := "Amount Including VAT" - Amount;
                currencyText := Format("Currency Code");
                numberToText.FormatNoText(AmountText, "Amount Including VAT", currencyText);
                if (currencyText = '') or (currencyText = 'COP') then begin
                    currency := 'COP';
                end
                else
                    currency := currencyText;

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
                if currency = 'USD' then begin
                    AmountInWords := AmountText[1] + AmountText[2];
                    if not AmountInWords.Contains('DOLARES') then begin
                        AmountInWords := AmountInWords.Replace('CENTAVOS', '');
                        AmountInWords += ' DOLARES';
                    end else begin
                        AmountInWords := AmountText[1] + AmountText[2];
                    end;
                end;
                currencyF := "Purch. Inv. Header"."Currency Factor";
                if "Purch. Inv. Header"."Currency Factor" > 0 then begin
                    currencyF := 1 / "Purch. Inv. Header"."Currency Factor";
                end;

                lines.SetFilter("Document No.", "Purch. Inv. Header"."No.");
                lines.CalcSums("Line Amount");
                salamou := lines."Line Amount";

                CalcuSalamount := salamou * currencyF;
                calcudiscuount := "Purch. Inv. Header"."Invoice Discount Amount" * currencyF;
                Calcuamount := "Purch. Inv. Header".Amount * currencyF;
                calcutotal := "Purch. Inv. Header"."Amount Including VAT" * currencyF;
                if pidpagina.FindFirst() then begin
                    piedpag1 := pidpagina."D365L CO FE Texto1";
                    piedpag2 := pidpagina."D365L CO FE Texto2";
                    piedpag3 := pidpagina."D365L CO FE Texto3";

                end;
                TempNoSeriesLine.SetFilter("Series Code", "No. Series");
                TempNoSeriesLine.FindFirst();
                marcaAgua := '';

                if "Purch. Inv. Header"."D365L CO ds Status_EBill" <> "Purch. Inv. Header"."D365L CO ds Status_EBill"::Process then begin

                    marcaAgua := 'lleno';
                end;

            end;

            trigger OnPreDataItem()
            begin

                if NoValor <> '' then begin
                    SetFilter("No.", NoValor);
                end 
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

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
                        ShowMandatory = true;

                        trigger OnDrillDown()
                        var
                            dim: Record "Purch. Inv. Header";
                            pag: Page "Posted Purchase Invoices";
                        begin
                            //dim.SetRange("D365L CO DS Status_EBill", dim."D365L CO DS Status_EBill"::Process);
                            pag.SETTABLEVIEW(dim);
                            pag.LOOKUPMODE(TRUE);
                            IF pag.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                pag.GETRECORD(dim);
                                NoValor := dim."No.";
                            end;
                        end;

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


    procedure calculateTotalTax(SIH_no: Code[20]; taxCode: Code[5]; tarifa: Decimal): Decimal
    var
        ST: Record "VAT Entry";
        SIH: Record "Purch. Inv. Header";
        ER: Decimal;
    begin
        SIH.SetFilter("No.", SIH_no);
        SIH.FindFirst();
        ST.SetFilter("Document No.", SIH_no);
        ST.SetFilter("D365L CO VAT DIAN Code", taxCode);
        ST.SetRange("D365L CO Tax Above Maximum COL", tarifa);
        if (SIH."Currency Code" <> 'COP') and (SIH."Currency Code" <> '') then begin
            ER := Round((1 / SIH."Currency Factor"), 0.01, '=');
            ST.CalcSums(Amount);
            exit(Round((ST.Amount / ER), 0.01, '='));
        end else begin
            ST.CalcSums(Amount);
            exit(ST.Amount);
        end;
    end;

    var
        salamou: Decimal;
        CalcuSalamount: Decimal;
        calcudiscuount: Decimal;
        Calcuamount: Decimal;
        calcutotal: Decimal;
        piedpag1: Text;
        piedpag2: text;
        piedpag3: text;
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

        lylQueryGeneralTax: Query "D365L GeneralTaxQuery";
        observation: Text[100];
        amountRound: Decimal;
        valor: decimal;
        numero: Code[20];
        Nombre: Text[50];
        TERCERO: CODE[20];
        currencyText: text[50];
        currency: text[50];
        Calcutax: Decimal;
        currencyF: Decimal;
}
*/