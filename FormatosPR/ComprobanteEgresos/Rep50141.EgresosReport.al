report 60102 EgresosReport
{
    //  ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;
    WordLayout = 'Reports/1PurchaseInvoice1EG4.docx';
    Caption = 'D365LATAM Reporte comprobante de egresos v2';
    dataset
    {
        dataitem(VendorLedgerEntry; "Vendor Ledger Entry")
        {
            RequestFilterFields = "Document No.";
            column(bank; bank) { }
            column(AcceptedPaymentTolerance; "Accepted Payment Tolerance")
            {
            }
            column(AcceptedPmtDiscTolerance; "Accepted Pmt. Disc. Tolerance")
            {
            }
            column(AdjustedCurrencyFactor; "Adjusted Currency Factor")
            {
            }
            column(Amount; Amount)
            {
            }
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
            column(BuyfromVendorNo; "Buy-from Vendor No.")
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
            column(CreditorNo; "Creditor No.")
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
            column(G2LCO_CanceledDocument; "D365L PR Canceled Document")
            {
            }
            column(LYLCO_ConceptDIAN; "D365L PR Concept HACIENDA")
            {
            }
            column(LYLCO_Deductible; "D365L PR Deductible")
            {
            }
            column(LYLOC_PR_Doc_Type_HACIENDA; "D365L PR Doc. Type HACIENDA")
            {
            }
            column(LYLOC_PR_Regime_Type; "D365L PR Regime Type")
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
            column(PmtDiscRcdLCY; "Pmt. Disc. Rcd.(LCY)")
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
            column(PurchaseLCY; "Purchase (LCY)")
            {
            }
            column(PurchaserCode; "Purchaser Code")
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
            column(RemittoCode; "Remit-to Code")
            {
            }
            column(Reversed; Reversed)
            {
            }
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
            column(VendorName; "Vendor Name")
            {
            }
            column(VendorNo; "Vendor No.")
            {
            }
            column(totalAmount_; totalAmount_) { }
            column(VendorPostingGroup; "Vendor Posting Group")
            {
            }
            column(amountwtax; amountwtax) { }
            column(AmountInWordsNew; AmountInWords) { }
            dataitem(Vendor; Vendor)
            {
                DataItemLink = "No." = field("Vendor No.");
                column(Name; Name) { }
                column(Address; Address) { }
                column(Phone_No_; "Phone No.") { }
                column(City; City) { }
                column(VAT_Registration_No_Vendor; "VAT Registration No.") { }
            }
            dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
            {
                DataItemLink = "Document No." = field("Document No.");
                column(LYLOC_PR_Bank_Trans__No_; "D365L PR Bank Trans. No.") { }
            }
            dataitem("Company Information"; "Company Information")
            {
                column(VAT_Registration_No_; "VAT Registration No.")
                {

                }
                column(Address1; Address)
                {

                }
                column(Phone_No_1; "Phone No.") { }
            }
            dataitem("G/L Entry"; "G/L Entry")
            {
                DataItemLink = "Document No." = field("Document No.");

                column(G_L_Account_No_; "G/L Account No.") { }
                column(VAT_Amount; "VAT Amount") { }
                dataitem("Bank Account"; "Bank Account")
                {
                    DataItemLink = "No." = field("Source No.");
                    column(Name1; Name) { }
                }


            }
            dataitem(detailed; Integer)
            {
                DataItemTableView = sorting(Number);
                column(amountdetailed; detailedvendorquery.Amount) { }
                column(entrydetailed; detailedvendorquery.Entry_No_) { }
                column(invoicingno; invoicingno) { }
                column(amountdetailedinvo; amountdetailedinvo) { }
                column(descriptioninv; descriptioninv) { }
                column(externalinvo; externalinvo)
                {
                }

                trigger OnPreDataItem()
                var
                    GenJournalDocumentType: Enum "Gen. Journal Document Type";
                    DetailedCVLedgerEntryType: Enum "Detailed CV Ledger Entry Type";
                begin

                    SetRange(Number, 1, 100);
                    detailedvendorquery.SetFilter(Document_No_, VendorLedgerEntry."Document No.");
                    detailedvendorquery.TopNumberOfRows(100);
                    detailedvendorquery.SetFilter(Entry_type, 'Liquidación');
                    detailedvendorquery.SetFilter(Document_Type, 'Pago');
                    detailedvendorquery.SetFilter(Initial_Document_Type, '<>%1', GenJournalDocumentType::Payment);
                    detailedvendorquery.Open();
                end;

                trigger OnAfterGetRecord()
                var

                begin
                    if detailedvendorquery.Read() then begin
                        invoicingno := getinvoiceno(detailedvendorquery.Vendor_Ledger_Entry_No_);
                        descriptioninv := getinvoicedescription(invoicingno);
                        externalinvo := getexternaldoc(invoicingno);
                        if (detailedvendorquery.Amount < 0) then begin
                            amountdetailedinvo := detailedvendorquery.Amount * -1;
                        end else begin
                            amountdetailedinvo := detailedvendorquery.Amount;
                        end;
                    end
                    else begin
                        CurrReport.Skip();
                    end;

                end;

            }


            dataitem(CLE; Integer)
            {
                DataItemTableView = sorting(number);
                //    DataItemLink = "Closed by Entry No." = field("Entry No.");
                column(G_L_Entry_Amount; amountLine) { }
                column(No_; LYLCustLedgEntryQry.No_) { }
                column(Currency_Code; currency) { }
                column(Description_; LYLCustLedgEntryQry.Description) { }
                column(apliestto; LYLCustLedgEntryQry.Applies_to_Doc__No_) { }
                column(external; LYLCustLedgEntryQry.External_Document_No_) { }
                column(Shortcut_Dimension_1_Code; LYLCustLedgEntryQry.Shortcut_Dimension_1_Code) { }
                //  column(AmountInWords; (AmountInWords)) { }
                //  column(Amount_VAT_; LYLCustLedgEntryQry.Amount_Including_VAT - LYLCustLedgEntryQry.VAT_Base_Amount) { }
                trigger OnPreDataItem()

                begin
                    SetRange(Number, 1, 100);
                    LYLCustLedgEntryQry.TopNumberOfRows(100);
                    //  LYLCustLedgEntryQry.SetRange(Closed_by_Entry_No_, VendorLedgerEntry."Entry No.");
                    LYLCustLedgEntryQry.SetFilter(Document_No_, VendorLedgerEntry."Document No.");
                    LYLCustLedgEntryQry.Open();
                end;

                trigger OnAfterGetRecord()
                var
                    amoungr: Decimal;
                begin
                    if LYLCustLedgEntryQry.Read() then begin
                        amoungr := LYLCustLedgEntryQry.Amount_Including_VAT;
                        if (amoungr < 0) then begin
                            amountLine := amoungr * -1;
                        end else begin
                            amountLine := LYLCustLedgEntryQry.Amount_Including_VAT;
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
                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, 100);
                    LyLGLEntryQry.TopNumberOfRows(100);
                    LyLGLEntryQry.SetFilter(LyLGLEntryQry.Document_No_, VendorLedgerEntry."Document No.");
                    LyLGLEntryQry.SetRange(LyLGLEntryQry.Source_Type, GenJournalSourceType::" ");
                    LyLGLEntryQry.SetFilter(LyLGLEntryQry.Document_Type, 'Pago');
                    LyLGLEntryQry.Open();
                end;

                trigger OnAfterGetRecord()
                var

                begin

                    if LyLGLEntryQry.Read() then begin
                        vatamount := LyLGLEntryQry.Amount;
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

            begin
                bank := getBanks("Document No.");
                totalAmount_ := 0;

                if (totalAmount_ < 0) then begin
                    totalAmount_ := totalAmount_ * -1;
                end;
                currencys := Format("Currency Code");
                if (currencys = '') or (currencys = 'COP') then begin
                    currency_Txt := 'COP'
                end ELSE begin
                    currency_Txt := Format("Currency Code");
                end;
                totalAmount_ := CalculateTotalAmountv2(VendorLedgerEntry."Document No.");
                amountwtax := totalAmount_ + vatamount;

                numberToText.FormatNoText(AmountText, amountwtax, currency_Txt);
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
                            dim: Record "Vendor Ledger Entry";
                            pag: Page "Vendor Ledger Entries";
                        begin
                            dim.SetFilter("Document No.", 'CE*');
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
    var
        NoValor: Code[30];
        lylQueryGeneralTax: Query "LyL LyLGeneralTaxQuery";
        GenJournalSourceType: Enum "Gen. Journal Source Type";
        currency: Text;
        totalAmount_: decimal;
        totalVatAmount_: Decimal;

        LyLGLEntryQry: Query LyLGLEntryQry;
        detailedvendorquery: Query detailvendorquery;
        LYLCustLedgEntryQry: Query LYLVendorLedgEntryQry2;

        currency_Txt: Text;

        AmountInWords: Text;
        amountLine: Decimal;
        bank: Text;
        invoicingno: Code[20];
        entryes: Integer;
        amountdetailedinvo: Decimal;
        custosamount: Decimal;
        descriptioninv: Text;
        externalinvo: Text;
        total: Decimal;

        total1: Decimal;
        amountwtax: Decimal;
        vatamount: Decimal;


    local procedure CalculateTotalAmount(DocumentNo: Code[20]): Decimal
    var
        total: Decimal;
        detailvendorquery: Query detailvendorquery;
        GenJournalDocumentType: Enum "Gen. Journal Document Type";
        DetailedCVLedgerEntryType: Enum "Detailed CV Ledger Entry Type";
    begin

        detailedvendorquery.SetFilter(Document_No_, DocumentNo);
        detailedvendorquery.TopNumberOfRows(100);
        detailedvendorquery.SetFilter(Entry_type, 'Liquidación');
        detailedvendorquery.SetFilter(Document_Type, 'Pago');
        detailedvendorquery.SetFilter(Initial_Document_Type, '<>%1', GenJournalDocumentType::Payment);
        detailvendorquery.Open();


        while detailvendorquery.Read() do begin
            total += detailvendorquery.Amount;
        end;
        detailvendorquery.Close();
        exit(total);
    end;

    local procedure CalculateTotalAmountv2(DocumentNo: Code[20]): Decimal
    var
        total: Decimal;
        detailvendorquery1: Query detailvendorquery;
        GenJournalDocumentType: Enum "Gen. Journal Document Type";
        DetailedCVLedgerEntryType: Enum "Detailed CV Ledger Entry Type";
    begin

        detailvendorquery1.SetFilter(Document_No_, DocumentNo);
        detailvendorquery1.TopNumberOfRows(100);
        detailvendorquery1.SetFilter(Entry_type, 'Liquidación');
        detailvendorquery1.SetFilter(Document_Type, 'Pago');
        detailvendorquery1.SetFilter(Initial_Document_Type, '<>%1', GenJournalDocumentType::Payment);
        detailvendorquery1.Open();

        while detailvendorquery1.Read() do begin
            total += detailvendorquery1.Amount;
        end;
        detailvendorquery1.Close();
        exit(total);
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

    local procedure getinvoiceno(entry: Integer): Code[20]
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        VendorLedgerEntry.SetRange("Entry No.", entry);
        if (VendorLedgerEntry.FindFirst()) then begin
            exit(VendorLedgerEntry."Document No.");
        end else begin
            exit('')
        end
    end;

    local procedure getinvoicedescription(invoice: Code[20]): Text
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        VendorLedgerEntry.SetRange("Document No.", invoice);
        if (VendorLedgerEntry.FindFirst()) then begin
            exit(VendorLedgerEntry.Description);
        end else begin
            exit('')
        end
    end;

    local procedure getexternaldoc(invoice: Code[20]): Text
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        VendorLedgerEntry.SetRange("Document No.", invoice);
        if (VendorLedgerEntry.FindFirst()) then begin
            exit(VendorLedgerEntry."External Document No.");
        end else begin
            exit('')
        end
    end;
}
