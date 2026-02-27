report 88101 "D365LCheque"
{
    ApplicationArea = All;
    Caption = 'Cheque';
    RDLCLayout = 'Report/D365LCheque.rdl';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            RequestFilterFields = "Journal Template Name", "Journal Batch Name";

            column(Posting_Date; "Posting Date")
            {

            }
            column(Account_No_; "Account No.")
            {

            }
            column(consecutivo; consecutivo) { }
            column(companyName; company.Name) { }
            column(companyVatR; company."VAT Registration No.") { }
            column(tercero; tercero) { }
            column(AmountInWords; AmountInWords) { }
            column(Description; Description) { }
            column(Amount; Amount) { }
            column(totala; totala) { }
            column(DocNo; DocNo) { }
            column(Banco; Banco) { }
            column(CuentaB; bankaa) { }
            column(Year; Year) { }
            column(Month; Month) { }
            column(Day; Day) { }
            trigger OnAfterGetRecord()
            var
                AmountText: array[2] of Text;
                vat: Decimal;
                GenJournalLine: Record "Gen. Journal Line";
                BankA: Record "Bank Account";
                numberToText: Codeunit "LyL NumberToText_INGCH";
                txtCharsToKeep: Text;
                txtCharsToKeepNumeric: Text;
                proveedor: Record Vendor;
                cliente: Record Customer;
                BannkA: Record "Bank Account";
            begin
                //TotalA := GetTotalAmount("Gen. Journal Line"."amount");}
                GenJournalLine.SetFilter("Account Type", '%1', GenJournalLine."Account Type"::"Bank Account");
                GenJournalLine.SetFilter("Journal Batch Name", "Gen. Journal Line"."Journal Batch Name");

                if GenJournalLine.FindFirst() then begin
                    BankA.SetFilter("No.", GenJournalLine."Account No.");
                    if BankA.FindFirst() then begin
                        bankaa := BankA."Bank Account No.";
                        Banco := BankA.Name;
                        /* BankA.SetFilter("No.", GenJournalLine."Account No.");
                         if BankA.FindFirst() then begin
                             Banco := BankA.Name;
                         end;*/
                    end;
                    proveedor.SetFilter("No.", GenJournalLine."D365L CO Third No.");
                    if proveedor.FindFirst() then begin
                        tercero := proveedor.Name;
                    end else begin
                        cliente.SetFilter("No.", GenJournalLine."D365L CO Third No.");
                        if cliente.FindFirst() then
                            tercero := cliente.Name;
                    end;
                    totala := GenJournalLine.Amount * -1;
                    DocNo := GenJournalLine."Document No.";
                    CuentaB := GenJournalLine."Account No.";
                end;
                InputDate := "Posting Date";
                Day := Date2DMY(InputDate, 1);
                Month := Date2DMY(InputDate, 2);
                Year := Date2DMY(InputDate, 3);
                currencyText := "Currency Code";
                numberToText.FormatNoText(AmountText, totala, currencyText);
                if (currencyText = '') or (currencyText = 'COP') then begin
                    currencyc := 'COP';
                end
                else
                    currencyc := currencyText;

                AmountInWords := AmountText[1] + AmountText[2];
                if Month = 1 then begin
                    MESFormat := '01';
                end;
                if Month = 2 then begin
                    MESFormat := '02';
                end;
                if Month = 3 then begin
                    MESFormat := '03';
                end;
                if Month = 4 then begin
                    MESFormat := '04';
                end;
                if Month = 5 then begin
                    MESFormat := '05';
                end;
                if Month = 6 then begin
                    MESFormat := '06';
                end;
                if Month = 7 then begin
                    MESFormat := '07';
                end;
                if Month = 8 then begin
                    MESFormat := '08';
                end;
                if Month = 9 then begin
                    MESFormat := '09';
                end;
                if Month = 10 then begin
                    MESFormat := '10';
                end;
                if Month = 11 then begin
                    MESFormat := '11';
                end;
                if Month = 12 then begin
                    MESFormat := '12';
                end;



                if currencyc = 'COP' then begin
                    if not AmountInWords.Contains(' PESOS ') then begin
                        AmountInWords := AmountText[1] + 'PESOS' + AmountText[2];
                    end else begin
                        AmountInWords := AmountText[1] + AmountText[2];
                    end;
                end;
                if currencyc = 'USD' then begin
                    if not AmountInWords.Contains(' DOLARES ') then begin
                        AmountInWords := AmountText[1] + 'DOLARES' + AmountText[2];
                    end else begin
                        AmountInWords := AmountText[1] + AmountText[2];
                    end;
                end;
                AmountInWords := AmountInWords.Replace('MILLON PESOS', 'MILLON DE PESOS');
                AmountInWords := AmountInWords.Replace('MILLONES PESOS', 'MILLONES DE PESOS');
                AmountInWords := AmountInWords.Replace('MILLON DOLARES', 'MILLON DE DOLARES');
                AmountInWords := AmountInWords.Replace('MILLONES DOLARES', 'MILLONES DE DOLARES');



            end;

        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(NumeroConsecutivo)
                {
                    field(consecutivo; consecutivo)
                    {
                        ApplicationArea = all;
                        caption = 'Numero de Cheque';


                    }
                }
            }
        }



    }
    trigger OnInitReport()
    begin
        //GLSetup.Get();
        company.SetAutoCalcFields(Picture);
        Company.Get();
        //D365lEncabezados.SetAutoCalcFields(Picture);
        //D365lEncabezados.FindFirst();
        //PurchSetup.Get();

        //OnAfterInitReport;

    end;

    var
        consecutivo: text[200];
        company: Record "Company Information";
        bankaa: text[30];
        totala: Decimal;
        DocNo: code[20];
        tercero: text[250];
        Banco: text[100];
        dc: code[20];
        Day: Integer;
        Month: Integer;
        MESFormat: Text;
        Year: Integer;
        InputDate: Date;
        AmountInWords: Text;
        currencyText: text[50];
        currencyc: text[50];
        CuentaB: code[20];


}