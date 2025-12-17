report 60108 RCReport
{
    //ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;
    WordLayout = 'Reports/1PurchaseInvoice1RC4_fin.docx';
    Caption = 'D365LATAM Recibo de caja';
    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            column(NameCompany; "Company Information".Name) { }
            column(Registration_No_; "Company Information"."Registration No.") { }
            column(VAT_Registration_No_; "Company Information"."VAT Registration No.") { }
            column(LYLOC_CO_Verification_Code; "Company Information"."D365L PR Verification Code") { }
            column(Picture; "Company Information".Picture) { }
            column(Company_Information_address; "Company Information".Address) { }
            column(Company_Information_phone; "Company Information"."Phone No.") { }
            column(Company_Information; "Company Information"."D365L PR Verification Code") { }
            column(AcceptedPaymentTolerance; "Accepted Payment Tolerance")
            {
            }
            column(AcceptedPmtDiscTolerance; "Accepted Pmt. Disc. Tolerance")
            {
            }
            column(AdjustedCurrencyFactor; "Adjusted Currency Factor")
            {
            }
            column(CUSTOAmount; Amount) { }
            column(bank; bank) { }
            column(AmountLCY; "Amount (LCY)")
            {
            }
            column(AmounttoApply; "Amount to Apply")
            {
            }
            column(AppliestoDocNo; "Applies-to Doc. No.")
            {
            }
            column(AppliestoDocType; "Applies-to Doc. Type")
            {
            }
            column(AppliestoExtDocNo; "Applies-to Ext. Doc. No.")
            {
            }
            column(AppliestoID; "Applies-to ID")
            {
            }
            column(ApplyingEntry; "Applying Entry")
            {
            }
            column(BalAccountNo; "Bal. Account No.")
            {
            }
            column(BalAccountType; "Bal. Account Type")
            {
            }
            column(ClosedatDate; "Closed at Date")
            {
            }
            column(ClosedbyAmount; "Closed by Amount")
            {
            }
            column(ClosedbyAmountLCY; "Closed by Amount (LCY)")
            {
            }
            column(ClosedbyCurrencyAmount; "Closed by Currency Amount")
            {
            }
            column(ClosedbyCurrencyCode; "Closed by Currency Code")
            {
            }
            column(ClosedbyEntryNo; "Closed by Entry No.")
            {
            }
            column(CreditAmount; "Credit Amount")
            {
            }
            column(CreditAmountLCY; "Credit Amount (LCY)")
            {
            }

            column(CurrencyCode; currency_Txt)
            {
            }
            column(DebitAmount; "Debit Amount")
            {
            }
            column(DebitAmountLCY; "Debit Amount (LCY)")
            {
            }
            column(Description; Description)
            {
            }
            column(DimensionSetID; "Dimension Set ID")
            {
            }
            column(DocumentDate; "Document Date")
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(DocumentType; "Document Type")
            {
            }
            column(DueDate; "Due Date")
            {
            }
            column(EntryNo; "Entry No.")
            {
            }
            column(ExportedtoPaymentFile; "Exported to Payment File")
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code; "Global Dimension 2 Code")
            {
            }
            column(ICPartnerCode; "IC Partner Code")
            {
            }
            column(InvDiscountLCY; "Inv. Discount (LCY)")
            {
            }
            column(JournalBatchName; "Journal Batch Name")
            {
            }
            column(JournalTemplName; "Journal Templ. Name")
            {
            }
            column(MaxPaymentTolerance; "Max. Payment Tolerance")
            {
            }
            column(MessagetoRecipient; "Message to Recipient")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(OnHold; "On Hold")
            {
            }
            column(Open; Open)
            {
            }
            column(OrigPmtDiscPossibleLCY; "Orig. Pmt. Disc. Possible(LCY)")
            {
            }
            column(OriginalAmount; "Original Amount")
            {
            }
            column(OriginalAmtLCY; "Original Amt. (LCY)")
            {
            }
            column(OriginalCurrencyFactor; "Original Currency Factor")
            {
            }
            column(OriginalPmtDiscPossible; "Original Pmt. Disc. Possible")
            {
            }
            column(PaymentMethodCode; "Payment Method Code")
            {
            }
            column(PaymentReference; "Payment Reference")
            {
            }
            column(PmtDiscToleranceDate; "Pmt. Disc. Tolerance Date")
            {
            }
            column(PmtDiscountDate; "Pmt. Discount Date")
            {
            }
            column(PmtToleranceLCY; "Pmt. Tolerance (LCY)")
            {
            }
            column(Positive; Positive)
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(Prepayment; Prepayment)
            {
            }
            column(ReasonCode; "Reason Code")
            {
            }
            column(RecipientBankAccount; "Recipient Bank Account")
            {
            }
            column(RemainingAmount; "Remaining Amount")
            {
            }
            column(RemainingAmtLCY; "Remaining Amt. (LCY)")
            {
            }
            column(RemainingPmtDiscPossible; "Remaining Pmt. Disc. Possible")
            {
            }
            column(Reversed; Reversed)
            {
            }
            column(totalAmount_; totalAmount_) { }
            column(ReversedEntryNo; "Reversed Entry No.")
            {
            }
            column(ReversedbyEntryNo; "Reversed by Entry No.")
            {
            }
            column(ShortcutDimension3Code; "Shortcut Dimension 3 Code")
            {
            }
            column(ShortcutDimension4Code; "Shortcut Dimension 4 Code")
            {
            }
            column(ShortcutDimension5Code; "Shortcut Dimension 5 Code")
            {
            }
            column(ShortcutDimension6Code; "Shortcut Dimension 6 Code")
            {
            }
            column(ShortcutDimension7Code; "Shortcut Dimension 7 Code")
            {
            }
            column(ShortcutDimension8Code; "Shortcut Dimension 8 Code")
            {
            }
            column(SourceCode; "Source Code")
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy; SystemCreatedBy)
            {
            }
            column(SystemId; SystemId)
            {
            }
            column(SystemModifiedAt; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy; SystemModifiedBy)
            {
            }
            column(TransactionNo; "Transaction No.")
            {
            }
            column(UserID; "User ID")
            {
            }
            column(Customer_No_; "Customer No.")
            {

            }
            column(custosamount; custosamount) { }
            column(AmountInWordsNew; AmountInWords) { }
            column(bankname; bankname) { }
            column(bname; bname) { }
            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = field("Customer No.");
                column(Name; Name) { }
                column(Address; Address) { }
                column(Phone_No_; "Phone No.") { }
                column(City; City) { }
                column(VAT_Registration_No_c; "VAT Registration No.") { }
            }
            dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
            {
                DataItemLink = "Document No." = field("Document No.");
                column(Description2; Description) { }
                column(LYLOC_CO_Bank_Trans__No_; "D365L PR Bank Trans. No.") { }
            }

            dataitem(detailed; Integer)
            {
                DataItemTableView = sorting(Number);
                column(amountdetailed; detailcustomerquery.Amount) { }
                column(entrydetailed; detailcustomerquery.Entry_No_) { }
                column(invoicingno; invoicingno) { }
                column(amountdetailedinvo; amountdetailedinvo) { }
                column(descriptioninv; descriptioninv) { }
                column(shorcut; shorcut) { }
                column(accountNo; accountNo) { }
                /* dataitem("G/L Entry"; "G/L Entry")
                 {
                     column(Source_No_; "Source No.") { }
                     column(G_L_Account_No_gl; "G/L Account No.") { }
                     column(Debit_Amount; "Debit Amount") { }
                     column(Credit_Amount; "Credit Amount") { }

                     dataitem("Bank Account"; "Bank Account")
                     {
                         DataItemLink = "No." = field("Source No.");
                         column(Name1; Name) { }
                     }
                     trigger OnAfterGetRecord()
                     var
                         myInt: Integer;
                     begin

                         "G/L Entry".SetFilter("Document No.", invoicingno);
                         "G/L Entry".SetRange("Bal. Account Type", "Bal. Account Type"::"G/L Account");

                     end;
                 }*/

                trigger OnPreDataItem()
                var
                    GenJournalDocumentType: Enum "Gen. Journal Document Type";
                    DetailedCVLedgerEntryType: Enum "Detailed CV Ledger Entry Type";
                begin

                    SetRange(Number, 1, 100);
                    detailcustomerquery.SetFilter(Document_No_, "Cust. Ledger Entry"."Document No.");
                    detailcustomerquery.TopNumberOfRows(100);
                    detailcustomerquery.SetFilter(Entry_type, 'Liquidación');
                    detailcustomerquery.SetFilter(Document_Type, 'Pago');
                    detailcustomerquery.SetFilter(Initial_Document_Type, '<>%1', GenJournalDocumentType::Payment);
                    detailcustomerquery.Open();
                end;

                trigger OnAfterGetRecord()
                var

                begin
                    if detailcustomerquery.Read() then begin
                        invoicingno := getinvoiceno(detailcustomerquery.Cust__Ledger_Entry_No_);
                        accountNo := GetGLEntryAccountNo(invoicingno);
                        descriptioninv := getinvoicedescription(invoicingno);
                        shorcut := getshorcutinvo(detailcustomerquery.Cust__Ledger_Entry_No_);
                        if (detailcustomerquery.Amount < 0) then begin
                            amountdetailedinvo := detailcustomerquery.Amount * -1;
                        end else begin
                            amountdetailedinvo := detailcustomerquery.Amount;
                        end;


                    end
                    else begin
                        CurrReport.Skip();
                    end;
                end;

            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = sorting(number);
                column(description_tax; LyLGLEntryQry.Description) { }
                column(amount_tax; LyLGLEntryQry.Amount) { }
                column(docNo_tax; LyLGLEntryQry.Document_No_) { }
                column(source; LyLGLEntryQry.Source_No_) { }
                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, 100);
                    LyLGLEntryQry.TopNumberOfRows(100);
                    LyLGLEntryQry.SetFilter(Document_No_, "Cust. Ledger Entry"."Document No.");
                    LyLGLEntryQry.SetRange(Source_Type, GenJournalSourceType::" ");
                    LyLGLEntryQry.SetFilter(Document_Type, 'Pago');
                    LyLGLEntryQry.Open();

                end;

                trigger OnAfterGetRecord()
                var

                begin

                    if LyLGLEntryQry.Read() then begin
                        totalVatAmount_ := LyLGLEntryQry.Amount;
                    end
                    else begin
                        CurrReport.Skip();
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            var
                AmountText: array[2] of Text;
                txtCharsToKeep: Text;
                txtCharsToKeepNumeric: Text;
                currencys: Text;
                amounts: Integer;
                numberToText: Codeunit "LyL NumberToText_ING";

                numberToText1: Codeunit "LyL NumberToText_ING";
                a: Decimal;
            //  AmountText: array[2] of Text;
            //  currencys: Text;

            begin

                bankname := getnamebank("Document No.");

                bank := getBanks("Document No.");

                bname := getnameb(bankname);

                totalAmount_ := CalculateTotalAmountv2("Document No.");

                totalt := calculatetotaltax("Cust. Ledger Entry"."Document No.");

                totalAmount_ := totalAmount_ * -1;

                totalAmount_ := totalAmount_ - totalt;

                currencys := Format("Currency Code");
                if (currencys = '') or (currencys = 'COP') then begin
                    currency_Txt := 'COP'
                end ELSE begin
                    currency_Txt := Format("Currency Code");
                end;

                custosamount := Amount;


                if (custosamount < 0) then
                    custosamount := Amount * -1;

                numberToText.FormatNoText(AmountText, totalAmount_, currency);
                AmountInWords := AmountText[1] + AmountText[2];

            end;

            trigger OnPreDataItem()

            begin
                SetFilter("Document No.", NoValor);
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

                        trigger OnDrillDown()
                        var
                            dim: Record "Cust. Ledger Entry";
                            pag: Page "Customer Ledger Entries";
                        begin
                            dim.SetFilter("Document No.", 'RC*');
                            pag.SETTABLEVIEW(dim);
                            pag.LOOKUPMODE(TRUE);
                            IF pag.RUNMODAL = ACTION::LookupOK THEN BEGIN

                                pag.GETRECORD(dim);

                                NoValor := dim."Document No.";
                            end;
                        end;

                    }
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        "Company Information".SetAutoCalcFields(Picture);
        "Company Information".get();
    end;

    var
        accountNo: text;
        "Company Information": Record "Company Information";
        NoValor: Code[30];
        lylQueryGeneralTax: Query "LyL LyLGeneralTaxQuery";
        detailcustomerquery: Query detailcustomerquery;
        GenJournalSourceType: Enum "Gen. Journal Source Type";
        currency: Text;
        totalAmount_: decimal;
        totalVatAmount_: Decimal;

        LyLGLEntryQry: Query LyLGLEntryQry;
        LYLCustLedgEntryQry: Query LYLCustLedgEntryQry;

        currency_Txt: Text;

        AmountInWords: Text;

        bank: Text;
        bankname: Text;

        bname: Text;
        invoicingno: Code[20];
        entryes: Integer;
        amountdetailedinvo: Decimal;
        custosamount: Decimal;
        descriptioninv: Text;

        shorcut: Text;

        totalt: Decimal;

    local procedure CalculateTotalAmount(EntryNo: Integer): Decimal
    var
        total: Decimal;
    begin
        LYLCustLedgEntryQry.SetRange(Closed_by_Entry_No_, EntryNo);
        LYLCustLedgEntryQry.Open();



        while LYLCustLedgEntryQry.Read() do begin
            total += LYLCustLedgEntryQry.Amount_Including_VAT;
        end;
        exit(total);
    end;

    local procedure calculatetotaltax(document: Code[20]): Decimal
    var
        total: Decimal;
        LyLGLEntryQry1: Query LyLGLEntryQry;
        GenJournalDocumentType: Enum "Gen. Journal Document Type";
        DetailedCVLedgerEntryType: Enum "Detailed CV Ledger Entry Type";
    begin

        LyLGLEntryQry.TopNumberOfRows(100);
        LyLGLEntryQry.SetFilter(Document_No_, document);
        LyLGLEntryQry.SetRange(Source_Type, GenJournalSourceType::" ");
        LyLGLEntryQry.SetFilter(Document_Type, 'Pago');
        LyLGLEntryQry.Open();

        while LyLGLEntryQry.Read() do begin
            total += LyLGLEntryQry.Amount;
        end;
        exit(total);

    end;

    local procedure CalculateTotalAmountv2(DocumentNo: Code[20]): Decimal
    var
        total: Decimal;
        detailcustomerquery2: Query detailcustomerquery;
        GenJournalDocumentType: Enum "Gen. Journal Document Type";
        DetailedCVLedgerEntryType: Enum "Detailed CV Ledger Entry Type";
        GLEntry: Record "G/L Entry";
        invoicingno1: Code[20];
    begin
        detailcustomerquery2.SetFilter(Document_No_, DocumentNo);
        detailcustomerquery2.TopNumberOfRows(100);
        detailcustomerquery2.SetFilter(Entry_type, 'Liquidación');
        detailcustomerquery2.SetFilter(Document_Type, 'Pago');
        detailcustomerquery2.SetFilter(Initial_Document_Type, '<>%1', GenJournalDocumentType::Payment);
        detailcustomerquery2.Open();
        //  invoicingno1 := getinvoiceno(detailcustomerquery2.Cust__Ledger_Entry_No_);
        while detailcustomerquery2.Read() do begin
            /*invoicingno1 := getinvoiceno(detailcustomerquery2.Cust__Ledger_Entry_No_);
            Clear(GLEntry);
            GLEntry.SetFilter("Document No.", invoicingno1);
            total += GLEntry."Debit Amount";*/
            total += detailcustomerquery2.Amount;
        end;
        detailcustomerquery2.Close();
        exit(total);
    end;

    local procedure CalculateTotalAmountv3(DocumentNo: Code[20]): Decimal
    var
        GLEntry: Record "G/L Entry";
    begin
        GLEntry.SetFilter("Document No.", DocumentNo);
    end;

    local procedure GetGLEntryAccountNo(documentNo: Code[20]): text
    var
        GLEntry: Record "G/L Entry";
    begin
        GLEntry.SetFilter("Document No.", documentNo);
        GLEntry.SetRange("Bal. Account Type", GLEntry."Bal. Account Type"::"G/L Account");
        GLEntry.SetRange("Source Type", GLEntry."Source Type"::Customer);
        if GLEntry.FindFirst() then
            exit(GLEntry."G/L Account No.");
        exit('');
    end;


    local procedure getBanks(documentNo: Code[20]): Text
    var
        total: Decimal;
        v: Record "Bank Account";
        GLEntry: Record "G/L Entry";
    begin
        GLEntry.SetFilter("Document No.", documentNo);
        GLEntry.SetFilter("Source Type", '%1', GLEntry."Source Type"::"Bank Account");
        if (GLEntry.FindFirst()) THEN begin
            v.SetFilter("No.", GLEntry."Source No.");
            if (v.FindFirst()) then begin
                exit(v.Name)
            end;
        end else begin
            exit('');
        end;

    end;

    local procedure getnamebank(Document: Code[20]): Code[50]
    var
        v: Record "Bank Account Ledger Entry";
    begin
        v.SetFilter("Document No.", Document);
        if (v.FindFirst()) then begin
            exit(v."Bank Account No.");
        end else begin
            exit('');
        end;

    end;

    local procedure getnameb(codee: Code[20]): Code[50]
    var
        v: Record "Bank Account";
    begin
        v.SetFilter("No.", codee);
        if (v.FindFirst()) then begin
            exit(v.Name);
        end else begin
            exit('');
        end;

    end;

    local procedure getinvoiceno(entry: Integer): Code[20]
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgerEntry.SetRange("Entry No.", entry);
        if (CustLedgerEntry.FindFirst()) then begin
            exit(CustLedgerEntry."Document No.");
        end else begin
            exit('')
        end
    end;

    local procedure getshorcutinvo(entry: Integer): Code[20]
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgerEntry.SetRange("Entry No.", entry);
        if (CustLedgerEntry.FindFirst()) then begin
            exit(CustLedgerEntry."Global Dimension 1 Code");
        end else begin
            exit('')
        end
    end;


    local procedure getinvoicedescription(invoice: Code[20]): Text
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgerEntry.SetRange("Document No.", invoice);
        if (CustLedgerEntry.FindFirst()) then begin
            exit(CustLedgerEntry.Description);
        end else begin
            exit('')
        end
    end;

}


