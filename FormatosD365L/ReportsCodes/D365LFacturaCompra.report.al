///<summary>
///Reporte de factura de compra desde el historico
///</summary>
report 50146 "D365L FacturaCompra"
{
    ApplicationArea = All;
    Caption = 'Factura de Compra';
    RDLCLayout = 'Reports/FacturaCompra.rdl';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            DataItemTableView = SORTING("No.");
            column(PurchInvHeadOrder_No_; "Order No.") { }
            column(PurchInvHeadNo_; "No.") { }
            column(PurchInvHeadDimensionSetID; "Dimension Set ID") { }
            column(Vendor_Invoice_No_; "Vendor Invoice No.") { }
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
            column(D365L_CO_Res__Ending_Date; TempNoSeriesLine."D365L CO Res. Ending Date") { }
            column(Starting_Date; TempNoSeriesLine."D365L CO Resol. Appr.Date DIAN") { }
            column(Starting_No_; TempNoSeriesLine."Starting No.") { }
            column(Ending_No_; TempNoSeriesLine."Ending No.") { }
            dataitem(User; User)
            {
                DataItemTableView = SORTING("User Security ID");
                DataItemLinkReference = "Purch. Inv. Header";
                DataItemLink = "User name" = field("User ID");

                column(User_Security_ID; "User Security ID")
                {

                }
                column(User_Name; "Full Name")
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
                            VATEntry_Amount := lylQueryGeneralTax.VATEntry_Amount * "Purch. Inv. Header"."Currency Factor";
                        end else begin
                            VATEntry_Amount := lylQueryGeneralTax.VATEntry_Amount;
                        end
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
            begin

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
                            //dim.SetFilter("Document No.", 'EGR*');
                            //dim.SetRange("LyL Status_EBill", dim."LyL Status_EBill"::Process);
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
    /// <summary>
    /// Procedimiento para validar el filtro del documento
    /// </summary>
    /// <param name="CodDoc">Recibe el documento a validar</param>
    procedure setValueFilter(CodDoc: Code[20])
    var
        myInt: Integer;
    begin
        NoValor := CodDoc;
    end;


    /*procedure calculateTotalTax(SIH_no: Code[20]; taxCode: Code[5]; tarifa: Decimal): Decimal
    var
        ST: Record "VAT Entry";
        SIH: Record "Purch. Inv. Header";
        ER: Decimal;
    begin
        SIH.SetFilter("No.", SIH_no);
        SIH.FindFirst();
        ST.SetFilter("Document No.", SIH_no);
        ST.SetFilter("G2LCO_VAT DIAN Code", taxCode);
        ST.SetRange("G2LCO_Tax Above Maximum COL", tarifa);
        if (SIH."Currency Code" <> 'COP') and (SIH."Currency Code" <> '') then begin
            ER := Round((1 / SIH."Currency Factor"), 0.01, '=');
            ST.CalcSums(Amount);
            exit(Round((ST.Amount / ER), 0.01, '='));
        end else begin
            ST.CalcSums(Amount);
            exit(ST.Amount);
        end;
    end;*/

    var
        Tax01: Decimal;
        tax04: Decimal;
        Tax05: Decimal;
        Tax06: Decimal;
        Tax07: Decimal;
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
}