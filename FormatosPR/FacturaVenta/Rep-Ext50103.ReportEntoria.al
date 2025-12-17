reportextension 60100 ReportInvoiceSistran extends "Standard Sales - Invoice"
{
    WordLayout = 'Reports/InvoiceVentas.docx';
    dataset
    {
        add(Header)
        {
            column(linestotalamountcop; linestotalamountcop) { }
            column(invoicediscuountamountcop; invoicediscuountamountcop) { }
            column(Vatentryamountcop; Vatentryamountcop) { }
            column(countroundcop; countroundcop) { }
            column(numLineas; numLineas) { }
            column(Moneda; Moneda) { }
            column(TasaCambio; TasaCambio) { }
            column(FormaPago; FormaPago) { }
            column(piedepag3; '') { }
            column(BalAccountNo; "Bal. Account No.") { }
            column(bankAccountNo; bankAccountNo) { }
            column(bankCode; bankCode) { }
            column(bankName; bankName) { }
            column(swftCode; swftCode) { }
            column(AmountInWords; AmountInWords) { }
            column(LYLFE_CO_CUFE; '') { }
            column(LYLFE_CO_QRInvoiceLink; '') { }
            column(des; des) { }
            column(VAT_Registration_No_; "VAT Registration No.") { }
            column(Currency_Code; "Currency Code") { }
            column(currency; currency) { }
            column(LYLFE_CO_Date_load; today) { }
            column(LYLOC_CO_Resolution_No_; LYLOC_CO_Resolution_No_) { }
            column(LYLOC_CO_Resol__Appr_Date_DIAN; Format(LYLOC_CO_Resol__Appr_Date_DIAN, 0, 4)) { }
            column(Starting_No_; Starting_No_) { }
            column(Ending_No_; Ending_No_) { }
        }
        addlast(Header)
        {
            dataitem(Customer; Customer)
            {
                DataItemLink = "VAT Registration No." = field("VAT Registration No.");
                column(Phone_No_custo; "Phone No.") { }
            }
            dataitem("No. Series Line"; "No. Series Line")
            {
                DataItemLink = "Series Code" = field("No. Series");
                //   column(LYLOC_CO_Resolution_No_; "D365L CO Resolution No.") { }
                column(LYLFE_CO_Prefix; '') { }
                //   column(LYLOC_CO_Resol__Appr_Date_DIAN; Format("D365L CO Resol. Appr.Date DIAN", 0, 4)) { }
                //   column(Starting_No_; "Starting No.") { }
                //   column(Ending_No_; "Ending No.") { }
                column(months; months) { }

            }
            dataitem("Company Information2"; "Company Information")
            {
                column(Name; Name) { }
                column(LYLOC_CO_Regimen_Type; "D365L PR Regimen Type") { }
                column(Phone_No_; "Phone No.") { }
                dataitem("LYLOC_CO DIAN Setup"; "D365L PR HACIENDA Setup")
                {
                    DataItemLink = "HACIENDA Code" = field("D365L PR Regimen Type");
                    column(Description; '') { }
                }
            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = sorting(number);
                column(VATEntry_DianDesc; VATEntry_DianDesc) { }
                column(VATEntry_Amount; VATEntry_Amount) { }
                column(vatamount; vatamount) { }

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, 100);
                    lylQueryGeneralTax.TopNumberOfRows(100);
                    lylQueryGeneralTax.SetFilter(Document_No, Header."No.");
                    lylQueryGeneralTax.SetFilter(VATEntry_DianCode, '<>ZZ');
                    lylQueryGeneralTax.Open();
                end;

                trigger OnAfterGetRecord()
                var
                    temptax: Code[20];
                    exchangeRate: Decimal;
                begin
                    if lylQueryGeneralTax.Read() then begin
                        temptax := lylQueryGeneralTax.VATEntry_DianCode;
                        if Header."Currency Code" <> '' then begin
                            exchangeRate := Round((1 / Header."Currency Factor"), 0.01, '=');
                            VATEntry_Amount := Round((lylQueryGeneralTax.VATEntry_Amount / exchangeRate), 0.01, '=');

                        end else begin
                            VATEntry_Amount := Round((lylQueryGeneralTax.VATEntry_Amount), 0.01, '=');
                        end;

                        VATEntry_Amount := VATEntry_Amount * -1;

                        if (VATEntry_Amount < 0) then begin
                            vatamount := '(' + Format(VATEntry_Amount * -1) + ')';
                        end else begin
                            vatamount := Format(
                                VATEntry_Amount
                            );
                        end;

                        VATEntry_DianDesc := lylQueryGeneralTax.VATEntry_DianDesc + ' ' + Format(lylQueryGeneralTax.VATEntry_tarifa, 0, '<Integer><Decimals,4>%');
                    end
                    else begin
                        CurrReport.Skip();
                    end;
                end;
            }
        }
        modify(Header)
        {
            trigger OnAfterAfterGetRecord()
            var
                BAs: Record "Customer Bank Account";
                Customer: Record Customer;
                Company: Record "Company Information";
                // Check: Report Check;
                NoOfYears: Integer;
                NoOfMonths: Integer;
                startDate: Date;
                endDate: Date;
                DataSendFE: list of [text];
                LYLOC_CO_Resol: text;
                payterms: record "Payment Terms";
                lines: Record "Sales Invoice Line";
            begin
                Moneda := 'USD';
                TasaCambio := 0;
                lines.SetFilter("Document No.", "Header"."No.");
                numLineas := lines.Count();
                if ("Header"."Payment Terms Code" <> '') then begin
                    payterms.SetFilter(code, "Header"."Payment Terms Code");
                    if payterms.FindFirst() then begin
                        if payterms.Code <> 'CONTADO' then
                            FormaPago := 'CREDITO';
                        if payterms.code = 'CONTADO' then
                            FormaPago := Header."Payment Terms Code";
                    end;
                end;

                if Header."Currency Factor" <> 0 then begin
                    if (Header."Currency Code" <> '') and (Header."Currency Code" <> 'USD') then begin
                        TasaCambio := 1 / Header."Currency Factor";

                    end;
                end;
                /* if "D365L CO FE Data_FE" <> '' then begin
                     DataSendFE := "D365L CO FE Data_FE".Split('|');

                     DataSendFE.Get(1, LYLOC_CO_Resolution_No_);
                     DataSendFE.Get(2, LYLOC_CO_Resol);
                     Evaluate(LYLOC_CO_Resol__Appr_Date_DIAN, LYLOC_CO_Resol);
                     DataSendFE.Get(3, LYLOC_CO_Resol__End_Date_DIAN);
                     DataSendFE.Get(4, Starting_No_);
                     DataSendFE.Get(5, Ending_No_);
                     //   DataSendFE.Get(6, CustItenType);
                     //  DataSendFE.Get(7, CustPersonType);
                     //   DataSendFE.Get(8, CustNIT);

                     Evaluate(startDate, Format(LYLOC_CO_Resol__Appr_Date_DIAN));
                     Evaluate(endDate, Format(LYLOC_CO_Resol__End_Date_DIAN));

                     NoOfYears := DATE2DMY(endDate, 3) - DATE2DMY(startDate, 3);
                     NoOfMonths := DATE2DMY(endDate, 2) - DATE2DMY(startDate, 2);
                     months := Format(12 * NoOfYears + NoOfMonths);
                 end;*/

                des := getregimentype(Company."D365L PR VAT Registration No.");
                /* Customer.SetFilter("No.", "Bill-to Customer No.");
                 if Customer.FindFirst() then begin
                     BAs.SetFilter(Code, Customer."Preferred Bank Account Code");
                     if BAs.FindFirst() then begin
                         bankName := BAs.Name;
                         bankCode := Customer."Preferred Bank Account Code";
                         bankAccountNo := BAs."Bank Account No.";
                         bankCode := BAs.Code;
                         swftCode := BAs."SWIFT Code";
                     end;
                 end;*/
                if Company.FindFirst() then begin
                    bankName := Company."Bank Name";
                    bankCode := Company."Bank Branch No.";
                    bankAccountNo := Company."Bank Account No.";
                    swftCode := Company."SWIFT Code";
                end;
                //Check.FormatNoText(AmountText, CalculateTotalAmount(Header."No.", '01'), 'USD');

                if ("Currency Code" = '') then begin
                    currency := 'USD';
                end else begin
                    currency := "Currency Code";
                end;
                ;

                numberToText.FormatNoText(AmountText, CalculateTotalAmount(Header."No.", '01'), currency);
                AmountInWords := AmountText[1] + AmountText[2];

                if currency = 'USD' then begin
                    if not AmountInWords.Contains(' DOLARES ') then begin
                        if not AmountInWords.Contains(' CENTAVOS ') then begin
                            AmountInWords := AmountText[1] + AmountText[2] + ' DOLARES';
                        end else begin
                            AmountInWords := AmountText[1] + ' DOLARES ' + AmountText[2];
                        end;
                    end else begin
                        AmountInWords := AmountText[1] + AmountText[2];
                    end;
                end;
                /* if currency = 'USD' then begin
                      AmountInWords := AmountText[1] + AmountText[2];
                      if not AmountInWords.Contains('DOLARES') then begin
                          AmountInWords := AmountInWords.Replace('CENTAVOS', '');
                          AmountInWords += ' DOLARES';
                      end else begin
                          AmountInWords := AmountText[1] + AmountText[2];
                      end;
                  end;*/

            end;
        }

        add(Line)
        {
            column(LyLExtDescription_lyl; Description) { }
            column(ItemNo; ItemNo) { }
            column(LyLExtDescription; '') { }
        }
        addlast(Line)
        {
            dataitem("VAT Entry"; "VAT Entry")
            {
                DataItemLink = "Document No." = field("Document No."), "D365L PR Line No" = field("Line No.");
                column(LYLOC_CO_Tax_Above_Maximum_COL; "D365L PR Tax Above Maximum COL") { }
                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    SetFilter("D365L PR VAT HACIENDA Code", '01');
                end;
            }
        }
        modify(Line)
        {
            trigger OnAfterAfterGetRecord()
            begin
                SalesInvoiceLine.SetFilter(SystemId, Line.SystemId);
                if SalesInvoiceLine.FindFirst() then begin
                    ItemNo := SalesInvoiceLine."No.";
                end;
            end;
        }
    }

    var
        Piedepag3: Text;
        numLineas: Integer;
        Moneda: text[20];
        TasaCambio: Decimal;
        FormaPago: Code[10];
        cufeDocref: text;
        linestotalamountcop: Decimal;
        invoicediscuountamountcop: Decimal;
        Vatentryamountcop: Decimal;
        countroundcop: Decimal;
        SalesInvoiceLine: Record "Sales Invoice Line";
        ItemNo: Code[20];
        bankName: Text[100];
        bankAccountNo: Text[100];
        bankCode: Text[100];
        swftCode: Text[100];
        numberToText: Codeunit "LyL NumberToText_ING";
        AmountText: array[2] of Text;
        AmountInWords: Text;
        lylQueryGeneralTax: Query "LyL LyLGeneralTaxQuery";
        VATEntry_Amount: Decimal;
        VATEntry_DianDesc: Text;
        des: Text;
        NoSerieLine: Record "No. Series Line";
        months: Text;

        taxamount: Decimal;

        vatamount: Text;

        currency: Text;
        LYLOC_CO_Resolution_No_: text;
        LYLOC_CO_Resol__Appr_Date_DIAN: date;
        LYLOC_CO_Resol__End_Date_DIAN: text;
        Starting_No_: text;
        Ending_No_: text;

    local procedure CalculateTotalAmount(SIH_No: Code[20]; taxCode: Code[2]): Decimal
    var
        SIL: Record "Sales Invoice Line";
    begin
        SIL.SetFilter("Document No.", SIH_No);
        SIL.SetFilter(Quantity, '>0');
        SIL.CalcSums(SIL."Amount Including VAT");
        exit(SIL."Amount Including VAT");
    end;

    local procedure getregimentype(vat: Text[20]): Text
    var
        CompanyInformation: Record "Company Information";
        code1: Code[20];
        LYLOC_CODIANSetup: Record "D365L PR HACIENDA Setup";

    begin
        CompanyInformation.SetFilter("D365L PR VAT Registration No.", vat);
        code1 := CompanyInformation."D365L PR Regimen Type";
        LYLOC_CODIANSetup.SetFilter("HACIENDA Code", code1);
        LYLOC_CODIANSetup.SetFilter("Table Code", '1004');
        exit(LYLOC_CODIANSetup.Description);
    end;

    procedure getResolution(): Text

    begin

    end;
}
