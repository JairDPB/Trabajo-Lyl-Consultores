/*report 50100 documentSupportCN
{
    //ApplicationArea = All;
    Caption = 'D365LATAM Documento de Ajuste';
    RDLCLayout = 'Reports/DocumentSupportCN.rdl';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Cr. Memo Hdr.")
        {
            column(No_; "No.") { }
            column(DimensionSetID; "Dimension Set ID") { }
            column(Amount; Amount) { }
            column(Amount_Including_VAT; "Amount Including VAT") { }
            column(Remaining_Amount; "Remaining Amount") { }
            column(Pay_to_Name; "Pay-to Name") { }
            column(Invoice_Discount_Amount; "Invoice Discount Amount") { }
            column(User_ID; "User ID") { }
            column(Document_Date; "Document Date") { }
            column(AmountInWords; AmountInWords) { }
            column(Valor; valor) { }
            column(Currency_Code; currency) { }
            column(Vendor_Invoice_No_; "Vendor Cr. Memo No.") { }
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
            column(Posting_Description; "Posting Description") { }
            column("DocRef"; "D365L CO DS No. Corr. Doc. FR") { }
            dataitem("Company Information"; "Company Information")
            {
                column(Picture; Picture) { }
            }
            dataitem("Purch. Inv. Line"; "Purch. Cr. Memo Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code") { }
                column(TERCERONIT; "Buy-from Vendor No.") { }
                column(NoCuenta_; "No.") { }
                column(Line_No_; "Line No.") { }
                column(TERCERO; TERCERO) { }
                column(Nombre; Nombre) { }
                column(DescriptionLine; Description) { }
                column(Unit_Cost; "Unit Cost") { }
                column(AmountS; Amount) { }
                dataitem("G/L Account"; "G/L Account")
                {
                    DataItemLink = "No." = field("No.");
                    column(Name; Name) { }
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
            dataitem(Integer; Integer)
            {
                DataItemTableView = sorting(number);
                column(VATEntry_DianDesc; lylQueryGeneralTax.VATEntry_DianDesc) { }
                column(VATEntry_Amount; lylQueryGeneralTax.VATEntry_Amount) { }
                column(tarifa; lylQueryGeneralTax.VATEntry_tarifa) { }
                column(numero; numero) { }
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

                valor := "Amount Including VAT" - Amount;
                currencyText := Format("Currency Code");
                numberToText.FormatNoText(AmountText, "Amount Including VAT", currencyText);
                if (currencyText = '') or (currencyText = 'COP') then begin
                    currency := 'COP';
                end
                else
                    currency := currencyText;

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
        CompanyInformation: Record "Company Information";
        AmountInWords: Text;
        AmountInWordsC: Text;
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
        TERCERO: CODE[20];
        currencyText: text[50];
        currency: text[50];
}
*/