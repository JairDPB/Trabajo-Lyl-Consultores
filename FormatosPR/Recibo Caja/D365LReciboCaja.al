report 60107 "D365L Recibo Caja"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/D365LReciboCaja.rdl';
    Caption = 'D365LATAM Reporte recibo de caja';
    dataset
    {
        dataitem(CustLedgerEntry; "Cust. Ledger Entry")
        {
            //RequestFilterFields = "Entry No.";
            DataItemTableView = SORTING("Document No.");

            column(CustLedEntAcceptedPaymentTolerance; "Accepted Payment Tolerance")
            {
            }
            column(CustLedEntAcceptedPmtDiscTolerance; "Accepted Pmt. Disc. Tolerance")
            {
            }
            column(CustLedEntAdjustedCurrencyFactor; "Adjusted Currency Factor")
            {
            }
            column(CustLedEntCUSTOAmount; amount) { }
            column(CustLedEntbank; bank) { }
            column(CustLedEntAmountLCY; "Amount (LCY)")
            {
            }
            column(CustLedEntAmounttoApply; "Amount to Apply")
            {
            }
            column(CustLedEntAppliestoDocNo; "Applies-to Doc. No.")
            {
            }
            column(CustLedEntAppliestoDocType; "Applies-to Doc. Type")
            {
            }
            column(CustLedEntAppliestoExtDocNo; "Applies-to Ext. Doc. No.")
            {
            }
            column(CustLedEntAppliestoID; "Applies-to ID")
            {
            }
            column(CustLedEntApplyingEntry; "Applying Entry")
            {
            }
            column(CustLedEntBalAccountNo; "Bal. Account No.")
            {
            }
            column(CustLedEntBalAccountType; "Bal. Account Type")
            {
            }
            column(CustLedEntClosedatDate; "Closed at Date")
            {
            }
            column(CustLedEntClosedbyAmount; "Closed by Amount")
            {
            }
            column(CustLedEntClosedbyAmountLCY; "Closed by Amount (LCY)")
            {
            }
            column(CustLedEntClosedbyCurrencyAmount; "Closed by Currency Amount")
            {
            }
            column(CustLedEntClosedbyCurrencyCode; "Closed by Currency Code")
            {
            }
            column(CustLedEntClosedbyEntryNo; "Closed by Entry No.")
            {
            }
            column(CustLedEntCreditAmount; "Credit Amount")
            {
            }
            column(CustLedEntCreditAmountLCY; "Credit Amount (LCY)")
            {
            }

            column(CustLedEntCurrencyCode; currency_Txt)
            {
            }
            column(CustLedEntDebitAmount; "Debit Amount")
            {
            }
            column(CustLedEntDebitAmountLCY; "Debit Amount (LCY)")
            {
            }
            column(CustLedEntDescription; Description)
            {
            }
            column(CustLedEntDimensionSetID; "Dimension Set ID")
            {
            }
            column(CustLedEntDocumentDate; "Document Date")
            {
            }
            column(CustLedEntDocumentNo; "Document No.")
            {
            }
            column(CustLedEntDocumentType; "Document Type")
            {
            }
            column(CustLedEntDueDate; "Due Date")
            {
            }
            column(CustLedEntEntryNo; "Entry No.")
            {
            }
            column(CustLedEntExportedtoPaymentFile; "Exported to Payment File")
            {
            }
            column(CustLedEntExternalDocumentNo; "External Document No.")
            {
            }
            column(CustLedEntGlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(CustLedEntGlobalDimension2Code; "Global Dimension 2 Code")
            {
            }
            column(CustLedEntICPartnerCode; "IC Partner Code")
            {
            }
            column(CustLedEntInvDiscountLCY; "Inv. Discount (LCY)")
            {
            }
            column(CustLedEntJournalBatchName; "Journal Batch Name")
            {
            }
            column(metodpay; metodpay) { }
            column(CustLedEntJournalTemplName; "Journal Templ. Name")
            {
            }
            column(CustLedEntMaxPaymentTolerance; "Max. Payment Tolerance")
            {
            }
            column(CustLedEntMessagetoRecipient; "Message to Recipient")
            {
            }
            column(CustLedEntNoSeries; "No. Series")
            {
            }
            column(CustLedEntOnHold; "On Hold")
            {
            }
            column(CustLedEntOpen; Open)
            {
            }
            column(CustLedEntOrigPmtDiscPossibleLCY; "Orig. Pmt. Disc. Possible(LCY)")
            {
            }
            column(CustLedEntOriginalAmount; "Original Amount")
            {
            }
            /*column(CustLedEntOriginalAmtLCY; "Original Amt. (LCY)")
            {
            }*/
            column(CustLedEntOriginalCurrencyFactor; "Original Currency Factor")
            {
            }
            column(CustLedEntOriginalPmtDiscPossible; "Original Pmt. Disc. Possible")
            {
            }
            column(CustLedEntPaymentMethodCode; "Payment Method Code")
            {
            }
            column(CustLedEntPaymentReference; "Payment Reference")
            {
            }
            column(CustLedEntPmtDiscToleranceDate; "Pmt. Disc. Tolerance Date")
            {
            }
            column(CustLedEntPmtDiscountDate; "Pmt. Discount Date")
            {
            }
            column(CustLedEntPmtToleranceLCY; "Pmt. Tolerance (LCY)")
            {
            }
            column(CustLedEntPositive; Positive)
            {
            }
            column(CustLedEntPostingDate; "Posting Date")
            {
            }
            column(CustLedEntPrepayment; Prepayment)
            {
            }
            column(CustLedEntReasonCode; "Reason Code")
            {
            }
            column(CustLedEntRecipientBankAccount; "Recipient Bank Account")
            {
            }
            column(CustLedEntRemainingAmount; "Remaining Amount")
            {
            }
            column(CustLedEntRemainingAmtLCY; "Remaining Amt. (LCY)")
            {
            }
            column(CustLedEntRemainingPmtDiscPossible; "Remaining Pmt. Disc. Possible")
            {
            }
            column(CustLedEntReversed; Reversed)
            {
            }
            column(CustLedEnttotalAmount_; totalAmount_) { }
            column(CustLedEntReversedEntryNo; "Reversed Entry No.")
            {
            }
            column(CustLedEntReversedbyEntryNo; "Reversed by Entry No.")
            {
            }
            column(CustLedEntShortcutDimension3Code; "Shortcut Dimension 3 Code")
            {
            }
            column(CustLedEntShortcutDimension4Code; "Shortcut Dimension 4 Code")
            {
            }
            column(CustLedEntShortcutDimension5Code; "Shortcut Dimension 5 Code")
            {
            }
            column(CustLedEntShortcutDimension6Code; "Shortcut Dimension 6 Code")
            {
            }
            column(CustLedEntShortcutDimension7Code; "Shortcut Dimension 7 Code")
            {
            }
            column(CustLedEntShortcutDimension8Code; "Shortcut Dimension 8 Code")
            {
            }
            column(CustLedEntSourceCode; "Source Code")
            {
            }
            column(CustLedEntSystemCreatedAt; SystemCreatedAt)
            {
            }
            column(CustLedEntSystemCreatedBy; SystemCreatedBy)
            {
            }
            column(CustLedEntSystemId; SystemId)
            {
            }
            column(CustLedEntCurrency_Factor; currencyF) { }
            column(CustLedEntSystemModifiedAt; SystemModifiedAt)
            {
            }
            column(CustLedEntSystemModifiedBy; SystemModifiedBy)
            {
            }
            column(CustLedEntTransactionNo; "Transaction No.")
            {
            }
            column(CustLedEntUserID; "User ID")
            {
            }

            column(CustEntamountwtax; amountwtax) { }
            column(CustLedEntCustomer_No_; "Customer No.")
            {

            }
            column(CustLedEntcustosamount; custosamount) { }
            column(CustLedEntAmountInWordsNew; AmountInWords) { }
            column(CustLedEntbankname; bankname) { }
            column(CustLedEntbname; bname) { }
            column(CompanyInfoName; "Company Information".Name) { }
            column(CompanyInfoRegistration_No_; "Company Information"."Registration No.") { }
            column(CompanyInfoVAT_Registration_No; "Company Information"."VAT Registration No.") { }
            column(CompanyInfoD365LVerification_Code; "Company Information"."D365L PR Verification Code") { }
            column(CompanyInfoPicture; "Company Information".Picture) { }
            column(CompanyInfoaddress; "Company Information".Address) { }
            column(CompanyInfoPhone_No_1; "Company Information"."Phone No.") { }
            column(CompanyInfoE_Mail; "Company Information"."E-Mail") { }
            column(ParDisContable; DisContable) { }

            dataitem(Customer; Customer)

            {
                DataItemTableView = SORTING("No.");
                DataItemLink = "No." = field("Customer No.");
                column(CustName; Name) { }
                column(CustAddress; Address) { }
                column(CustPhone_No_; "Phone No.") { }
                column(CustCity; City) { }
                column(CustVAT_Registration_No_c; "VAT Registration No.") { }
                column(CustE_Mail; "E-Mail") { }

                dataitem(User; User)
                {
                    DataItemLinkReference = CustLedgerEntry;
                    DataItemTableView = SORTING("User Security ID");
                    DataItemLink = "User Name" = field("User ID");
                    column(User_Security_ID; "User Security ID")
                    {

                    }
                    column(User_Name; "Full Name")
                    {

                    }
                    dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
                    {
                        //DataItemTableView = SORTING("Document No.");
                        DataItemLinkReference = CustLedgerEntry;
                        DataItemLink = "Document No." = field("Document No.");
                        column(D365LCO_Bank_Description; Description) { }
                        column(D365LCO_Bank_Trans__No_; "D365L PR Bank Trans. No.") { }
                        column(Amount__LCY_; "Amount") { }
                        dataitem(CustLedgerEntry2; "Cust. Ledger Entry")
                        {
                            DataItemLinkReference = CustLedgerEntry;
                            DataItemTableView = SORTING("Entry No.");

                            column(CLENo_; "Document No.")
                            {
                            }
                            column(CLEDocumentDate; "Document Date") { }
                            column(CLEexternal; "External Document No.") { }
                            column(CLEDescription_; Description) { }
                            column(CLEamount; Amount) { }

                            column(ClECustLedEntLAmountWDiscCur; CustLedEntLAmountWDiscCur) { }


                            trigger OnPreDataItem()

                            begin
                                CreateCustLedgEntry := CustLedgerEntry;
                                FindApplnEntriesDtldtLedgEntry();
                                SetCurrentKey("Entry No.");
                                SetRange("Entry No.");

                                if CreateCustLedgEntry."Closed by Entry No." <> 0 then begin
                                    "Entry No." := CreateCustLedgEntry."Closed by Entry No.";
                                    Mark(true);
                                end;

                                SetCurrentKey("Closed by Entry No.");
                                SetRange("Closed by Entry No.", CreateCustLedgEntry."Entry No.");
                                if Find('-') then
                                    repeat
                                        Mark(true);
                                    until Next() = 0;

                                SetCurrentKey("Entry No.");
                                SetRange("Closed by Entry No.");
                                MarkedOnly(true);
                            end;

                            trigger OnAfterGetRecord()
                            var
                                DtldVendLedgEntry: Record "Detailed Cust. Ledg. Entry";
                            begin
                                CalcFields(Amount, "Remaining Amount");
                                DtldVendLedgEntry.SetRange("Cust. Ledger Entry No.", "Entry No.");
                                DtldVendLedgEntry.SetRange("Entry Type", DtldVendLedgEntry."Entry Type"::Application);
                                DtldVendLedgEntry.SetRange("Document Type", DtldVendLedgEntry."Document Type"::Payment);
                                DtldVendLedgEntry.SetRange("Document No.", CustLedgerEntry."Document No.");
                                DtldVendLedgEntry.SetRange(Unapplied, false);
                                if not DtldVendLedgEntry.IsEmpty() then begin
                                    DtldVendLedgEntry.CalcSums(Amount, "Remaining Pmt. Disc. Possible");
                                    CustLedEntLineAmount := DtldVendLedgEntry.Amount;

                                    if "Currency Code" <> '' then begin
                                        if IsDiscountAppliedToPayment(CustLedgerEntry."Entry No.", CustLedgerEntry."Document No.") then
                                            CustLedEntLineDIscount := DtldVendLedgEntry."Remaining Pmt. Disc. Possible"
                                    end else
                                        CustLedEntLineDIscount := CurrExchRate.ExchangeAmtFCYToFCY("Posting Date", '', "Currency Code", "Pmt. Disc. Given (LCY)");

                                    CustLedgerEntry.Amount += CustLedEntLineDIscount;

                                    CustLedEntLAmountWDiscCur := -CustLedEntLineAmount - CustLedEntLineDIscount;
                                end else begin
                                    Clear(DtldVendLedgEntry);
                                    CalcFields(Amount, "Remaining Amount");
                                    DtldVendLedgEntry.SetRange("Cust. Ledger Entry No.", "Entry No.");
                                    DtldVendLedgEntry.SetRange("Entry Type", DtldVendLedgEntry."Entry Type"::Application);
                                    //   DtldVendLedgEntry.SetRange("Document Type", DtldVendLedgEntry."Document Type":);
                                    DtldVendLedgEntry.SetRange(Unapplied, false);
                                    if not DtldVendLedgEntry.IsEmpty() then begin
                                        DtldVendLedgEntry.CalcSums(Amount, "Remaining Pmt. Disc. Possible");
                                        CustLedEntLineAmount := DtldVendLedgEntry.Amount;

                                        if "Currency Code" <> '' then begin
                                            if IsDiscountAppliedToPayment(CustLedgerEntry."Entry No.", CustLedgerEntry."Document No.") then
                                                CustLedEntLineDIscount := DtldVendLedgEntry."Remaining Pmt. Disc. Possible"
                                        end else
                                            CustLedEntLineDIscount := CurrExchRate.ExchangeAmtFCYToFCY("Posting Date", '', "Currency Code", "Pmt. Disc. Given (LCY)");

                                        CustLedgerEntry.Amount += CustLedEntLineDIscount;

                                        CustLedEntLAmountWDiscCur := -CustLedEntLineAmount - CustLedEntLineDIscount;
                                    end;
                                end;
                                // totalAmount_ += CustLedEntLAmountWDiscCur;
                                //  CurrReport.Skip();
                            end;

                        }

                    }
                }

            }

            dataitem(DetailedCustLedgEntry; Integer)
            {
                DataItemTableView = sorting(Number);
                /*column(DetCustLedEntAmountDetailed; detailcustomerquery.Amount) { }
                column(DetCustLedEntentrydetailed; detailcustomerquery.Entry_No_) { }
                column(DetCustLedEntinvoicingno; invoicingno) { }
                column(DetCustLedEntamountdetailedinvo; amountdetailedinvo) { }
                column(DetCustLedEntdescriptioninv; descriptioninv) { }
                column(DetCustLedEntshorcut; shorcut) { }
                column(DetCustLedDocumentDate;detailcustomerquery.)
                column(DetCustLedEntaccountNo; accountNo) { }*/

                trigger OnPreDataItem()
                var
                    GenJournalDocumentType: Enum "Gen. Journal Document Type";
                    DetailedCVLedgerEntryType: Enum "Detailed CV Ledger Entry Type";
                begin

                    SetRange(Number, 1, 100);
                    detailcustomerquery.TopNumberOfRows(100);
                    detailcustomerquery.SetRange(Cust__Ledger_Entry_No_, "CustLedgerEntry"."Entry No.");
                    detailcustomerquery.SetRange(Entry_type, DetailedCVLedgerEntryType::Application);
                    detailcustomerquery.SetFilter(Initial_Document_Type, '<>%1', DetailedCVLedgerEntryType::"Initial Entry");
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
                        detailcustomerquery.Close();
                        CurrReport.Skip();
                    end;
                end;

            }




            dataitem(G_LEntry; "G/L Entry")
            {
                DataItemTableView = SORTING("Document No.");
                DataItemLink = "Document No." = field("Document No.");
                column(G_LEntDebit_Amount; "Debit Amount") { }
                column(G_LEntCredit_Amount; "Credit Amount") { }
                column(G_LEnt_Account_No; "G/L Account No.") { }
                dataitem("G/L Account"; "G/L Account")
                {
                    DataItemTableView = SORTING("No.");
                    DataItemLink = "No." = field("G/L Account No.");
                    column(G_LAccName; Name)
                    {

                    }


                }
            }
            trigger OnAfterGetRecord()
            var
                AmountText: array[2] of Text;
                txtCharsToKeep: Text;
                txtCharsToKeepNumeric: Text;
                currencys: Text;
                amounts: Integer;
                numberToText: Codeunit "LyL NumberToText_ING";
                vat: Decimal;
                amountTotal: Decimal;
                paymet: record "Payment Method";
                payterms: record "Payment Terms";
                pidpagina: Record "Sales & Receivables Setup";
            begin
                if CustLedgerEntry."Payment Method Code" <> '' then begin
                    //payterms.SetFilter(code, "Sales Invoice Header"."Payment Terms Code");
                    paymet.SetFilter(Code, CustLedgerEntry."Payment Method Code");
                    /*if payterms.FindFirst() then begin
                        termspay := payterms.Description;
                    end;*/
                    if paymet.FindFirst() then begin
                        metodpay := paymet.Description;
                    end;
                end;
                bank := getBanks("Document No.");

                currencys := Format("Currency Code");
                if (currencys = '') then begin
                    currency_Txt := general."LCY Code";
                end ELSE begin
                    currency_Txt := Format("Currency Code");
                end;


                currency := currency_Txt;

                if totalAmount_ = 0 then begin
                    totalAmount_ := CalculateTotalAmountv2(CustLedgerEntry."Document No.");
                    amountwtax := totalAmount_;

                    if (totalAmount_ < 0) then begin
                        totalAmount_ := totalAmount_ * -1;
                    end;

                    numberToText.FormatNoText(AmountText, totalAmount_, currency);
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
                        numberToText.FormatNoText(AmountText, totalAmount_, currency);
                        AmountInWords := AmountText[1] + AmountText[2];
                        if not AmountInWords.Contains('DOLARES') then begin
                            AmountInWords := AmountInWords.Replace('CENTAVOS', '');
                            AmountInWords += ' DOLARES';
                        end else begin
                            AmountInWords := AmountText[1] + AmountText[2];
                        end;
                    end;
                    currencyF := CustLedgerEntry."Original Currency Factor";
                    if CustLedgerEntry."Original Currency Factor" > 0 then begin
                        currencyF := 1 / CustLedgerEntry."Original Currency Factor";
                    end;
                end;

                //   if amountwtax < 0 then
                //      amountwtax := amountwtax * -1;

                /*   amountTotal := CustLedgerEntry.Amount;
                   if amountTotal < 0 then
                       amountTotal := amountTotal * -1;*/



                /*    if currency = 'COP' then begin
                        if not AmountInWords.Contains(' PESOS ') then begin
                            AmountInWords := AmountText[1] + AmountText[2];
                        end else begin
                            AmountInWords := AmountText[1] + AmountText[2];
                        end;
                    end;*/

            end;

            trigger OnPreDataItem()
            begin
                if NoValor <> '' then begin
                    SetFilter("Document No.", NoValor);
                    SetRange("Document Type", "Document Type"::Payment);


                end;
                if (filterDate1 <> 0D) and (filterDate2 <> 0D) then begin
                    SetFilter("Posting Date", '%1..%2', filterDate1, filterDate2);
                    SetFilter("Document No.", 'RC*');
                end;
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
                            dim: Record "Cust. Ledger Entry";
                            pag: Page "Customer Ledger Entries";
                        begin
                            //dim.SetFilter("Document No.", 'EGR*');
                            dim.SetRange("Document Type", dim."Document Type"::Payment);
                            pag.SETTABLEVIEW(dim);
                            pag.LOOKUPMODE(TRUE);
                            IF pag.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                pag.GETRECORD(dim);
                                NoValor := dim."Document No.";
                            end;
                        end;

                    }
                    field(filterDate; filterDate1)
                    {
                        ApplicationArea = All;
                        Caption = 'Fecha Inicial';
                        ShowMandatory = true;

                    }
                    field(filterDate2; filterDate2)
                    {
                        ApplicationArea = All;
                        Caption = 'Fecha Final';
                        ShowMandatory = true;

                    }
                    field(DisContable; DisContable)
                    {

                        ApplicationArea = all;
                        Caption = 'Mostrar Distribución Contable';

                    }
                }
            }
        }
        trigger OnInit()
        var
            myInt: Integer;
        begin
            DisContable := true;
        end;
    }

    trigger OnInitReport()
    begin
        general.get();
        "Company Information".SetAutoCalcFields(Picture);
        "Company Information".get();

        totalAmount_ := 0;
    end;

    var
        filterDate1: Date;
        filterDate2: Date;
        accountNo: text;
        "Company Information": Record "Company Information";
        NoValor: Code[30];
        detailcustomerquery: Query "D365L DetailCustomerQuery";
        GenJournalSourceType: Enum "Gen. Journal Source Type";
        currency: Text;
        totalAmount_: decimal;
        totalVatAmount_: Decimal;

        LyLGLEntryQry: Query LyLGLEntryQry;
        LYLCustLedgEntryQry: Query LYLCustLedgEntryQry;
        general: Record "General Ledger Setup";
        currency_Txt: Text;
        currencyF: Decimal;
        AmountInWords: Text;
        DisContable: Boolean;
        bank: Text;
        bankname: Text;
        metodpay: Text;
        bname: Text;
        invoicingno: Code[20];
        amountdetailedinvo: Decimal;
        custosamount: Decimal;
        descriptioninv: Text;

        shorcut: Text;
        amountwtax: Decimal;
        totalt: Decimal;
        CustLedEntLAmountWDiscCur: Decimal;
        CreateCustLedgEntry: Record "Cust. Ledger Entry";
        CustLedEntLineAmount: Decimal;
        CustLedEntLineDIscount: Decimal;
        CurrExchRate: Record "Currency Exchange Rate";


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
        LyLGLEntryQry.SetFilter(LyLGLEntryQry.Document_No_, CustLedgerEntry."Document No.");
        LyLGLEntryQry.SetRange(LyLGLEntryQry.Source_Type, GenJournalSourceType::" ");
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
        detailcustomerquery2: Query "D365L detailcustomerquery";
        GenJournalDocumentType: Enum "Gen. Journal Document Type";
        DetailedCVLedgerEntryType: Enum "Detailed CV Ledger Entry Type";
        GLEntry: Record "G/L Entry";
        invoicingno1: Code[20];
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
    begin
        BankAccountLedgerEntry.SetFilter("Document No.", DocumentNo);
        BankAccountLedgerEntry.CalcSums(Amount);
        exit(BankAccountLedgerEntry.Amount);
        /* detailcustomerquery2.SetFilter(Document_No_, DocumentNo);
         detailcustomerquery2.TopNumberOfRows(100);
         detailcustomerquery2.SetFilter(Entry_type, 'Liquidación');
         detailcustomerquery2.SetFilter(Document_Type, 'Pago');
         detailcustomerquery2.SetFilter(Initial_Document_Type, '<>%1', GenJournalDocumentType::Payment);
         detailcustomerquery2.Open();
         while detailcustomerquery2.Read() do begin
             total += detailcustomerquery2.Amount;
         end;
         detailcustomerquery2.Close();*/
        // exit(total);
    end;

    local procedure GetGLEntryAccountNo(documentNo: Code[20]): text
    var
        GLEntry: Record "G/L Entry";
    begin
        GLEntry.SetFilter("Document No.", documentNo);
        //   GLEntry.SetRange("Bal. Account Type", GLEntry."Bal. Account Type"::"G/L Account");
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

    local procedure IsDiscountAppliedToPayment(CustLedgEntryNo: Integer; DocNo: Code[20]): Boolean
    var
        DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
    begin
        DtldVendLedgEntry.LoadFields("Vendor Ledger Entry No.", "Entry Type", "Document Type", "Document No.", "Currency Code", Unapplied);
        DtldVendLedgEntry.SetRange("Vendor Ledger Entry No.", CustLedgEntryNo);
        DtldVendLedgEntry.SetRange("Entry Type", DtldVendLedgEntry."Entry Type"::"Payment Discount");
        DtldVendLedgEntry.SetRange("Document Type", DtldVendLedgEntry."Document Type"::Payment);
        DtldVendLedgEntry.SetRange("Document No.", DocNo);
        DtldVendLedgEntry.SetFilter("Currency Code", '<>%1', '');
        DtldVendLedgEntry.SetRange(Unapplied, false);
        if not DtldVendLedgEntry.IsEmpty() then
            exit(true);
    end;

    local procedure FindApplnEntriesDtldtLedgEntry()
    var
        DtldCustLedgEntry1: Record "Detailed cust. Ledg. Entry";
        DtldCustLedgEntry2: Record "Detailed cust. Ledg. Entry";
    begin
        DtldCustLedgEntry1.Reset();
        DtldCustLedgEntry1.SetCurrentKey("Cust. Ledger Entry No.");
        DtldCustLedgEntry1.SetRange("Cust. Ledger Entry No.", CustLedgerEntry."Entry No.");
        DtldCustLedgEntry1.SetRange(Unapplied, false);
        if DtldCustLedgEntry1.Find('-') then
            repeat
                if DtldCustLedgEntry1."Cust. Ledger Entry No." =
                   DtldCustLedgEntry1."Applied Cust. Ledger Entry No."
                then begin
                    DtldCustLedgEntry2.Reset();
                    DtldCustLedgEntry2.SetCurrentKey("Applied Cust. Ledger Entry No.", "Entry Type");
                    DtldCustLedgEntry2.SetRange(
                      "Applied Cust. Ledger Entry No.", DtldCustLedgEntry1."Applied Cust. Ledger Entry No.");
                    DtldCustLedgEntry2.SetRange("Entry Type", DtldCustLedgEntry2."Entry Type"::Application);
                    DtldCustLedgEntry2.SetRange(Unapplied, false);
                    if DtldCustLedgEntry2.Find('-') then
                        repeat
                            if DtldCustLedgEntry2."Cust. Ledger Entry No." <>
                               DtldCustLedgEntry2."Applied Cust. Ledger Entry No."
                            then begin
                                CustLedgerEntry2.SetCurrentKey("Entry No.");
                                CustLedgerEntry2.SetRange("Entry No.", DtldCustLedgEntry2."Cust. Ledger Entry No.");
                                if CustLedgerEntry2.Find('-') then
                                    CustLedgerEntry2.Mark(true);
                            end;
                        until DtldCustLedgEntry2.Next() = 0;
                end else begin
                    CustLedgerEntry2.SetCurrentKey("Entry No.");
                    CustLedgerEntry2.SetRange("Entry No.", DtldCustLedgEntry1."Applied Cust. Ledger Entry No.");
                    if CustLedgerEntry2.Find('-') then
                        CustLedgerEntry2.Mark(true);
                end;
            until DtldCustLedgEntry1.Next() = 0;
    end;
}


