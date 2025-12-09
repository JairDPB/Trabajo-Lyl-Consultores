/// <summary>
/// Reporte de comprobante de egresos para GPA
/// </summary>
report 50149 "D365L Comprobante Egresos"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/D365LComprobanteEgresos.rdl';
    Caption = 'Reporte comprobante de egresos';

    dataset
    {
        dataitem(VendorLedgerEntry; "Vendor Ledger Entry")
        {
            //RequestFilterFields = "Document No.";
            DataItemTableView = sorting("Document No.");
            column(VendLedEntbank; bank)
            { }
            column(VendLedEntAcceptedPaymentTolerance; "Accepted Payment Tolerance")
            {
            }
            column(VendLedEntAcceptedPmtDiscTolerance; "Accepted Pmt. Disc. Tolerance")
            {
            }
            column(VendLedEntAdjustedCurrencyFactor; "Adjusted Currency Factor")
            {
            }
            column(VendLedEntAmount; amount)
            {
            }
            column(VendLedEntAmountLCY; "Amount (LCY)")
            {
            }
            column(VendLedEntAmounttoApply; "Amount to Apply")
            {
            }
            column(VendLedEntAppliestoDocNo; "Applies-to Doc. No.")
            {
            }
            column(VendLedEntAppliestoDocType; "Applies-to Doc. Type")
            {
            }
            column(VendLedEntAppliestoExtDocNo; "Applies-to Ext. Doc. No.")
            {
            }
            column(VendLedEntAppliestoID; "Applies-to ID")
            {
            }
            column(VendLedEntApplyingEntry; "Applying Entry")
            {
            }
            column(VendLedEntBalAccountNo; "Bal. Account No.")
            {
            }
            column(VendLedEntBalAccountType; "Bal. Account Type")
            {
            }
            column(VendLedEntBuyfromVendorNo; "Buy-from Vendor No.")
            {
            }
            column(VendLedEntClosedatDate; "Closed at Date")
            {
            }
            column(VendLedEntClosedbyAmount; "Closed by Amount")
            {
            }
            column(VendLedEntClosedbyAmountLCY; "Closed by Amount (LCY)")
            {
            }
            column(VendLedEntClosedbyCurrencyAmount; "Closed by Currency Amount")
            {
            }
            column(VendLedEntClosedbyCurrencyCode; "Closed by Currency Code")
            {
            }
            column(VendLedEntClosedbyEntryNo; "Closed by Entry No.")
            {
            }
            column(VendLedEntCreditAmount; "Credit Amount")
            {
            }
            column(VendLedEntCreditAmountLCY; "Credit Amount (LCY)")
            {
            }
            column(VendLedEntCreditorNo; "Creditor No.")
            {
            }
            column(VendLedEntCurrencyCode; currency_Txt)
            {
            }
            column(VendLedEntDebitAmount; "Debit Amount")
            {
            }
            column(VendLedEntDebitAmountLCY; "Debit Amount (LCY)")
            {
            }
            column(VendLedEntDescription; Description)
            {
            }
            column(VendLedEntDimensionSetID; "Dimension Set ID")
            {
            }
            column(VendLedEntDocumentDate; "Document Date")
            {
            }
            column(VendLedEntDocumentNo; "Document No.")
            {
            }
            column(VendLedEntDocumentType; "Document Type")
            {
            }
            column(VendLedEntDueDate; "Due Date")
            {
            }
            column(VendLedEntEntryNo; "Entry No.")
            {
            }
            column(VendLedEntExportedtoPaymentFile; "Exported to Payment File")
            {
            }
            column(VendLedEntExternalDocumentNo; "External Document No.")
            {
            }
            column(VendLedEntG2LCO_Canceled_Document; "D365L CO Canceled Document")
            {
            }
            column(VendLedEntG2LCO_Concept_DIAN; "D365L CO Concept DIAN")
            {
            }
            column(VendLedEntG2LCO_Deductible; "D365L CO Deductible")
            {
            }
            column(VendLedEntG2LCO_Doc__Type_DIAN; "D365L CO Doc. Type DIAN")
            {
            }
            column(VendLedEntG2LCO_Regime_Type; "D365L CO Regime Type")
            {
            }
            column(VendLedEntGlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(VendLedEntGlobalDimension2Code; "Global Dimension 2 Code")
            {
            }
            column(VendLedEntICPartnerCode; "IC Partner Code")
            {
            }
            column(VendLedEntInvDiscountLCY; "Inv. Discount (LCY)")
            {
            }
            column(VendLedEntJournalBatchName; "Journal Batch Name")
            {
            }
            column(VendLedEntJournalTemplName; "Journal Templ. Name")
            {
            }
            column(VendLedEntMaxPaymentTolerance; "Max. Payment Tolerance")
            {
            }
            column(VendLedEntMessagetoRecipient; "Message to Recipient")
            {
            }
            column(VendLedEntNoSeries; "No. Series")
            {
            }
            column(VendLedEntOnHold; "On Hold")
            {
            }
            column(VendLedEntOpen; Open)
            {
            }
            column(VendLedEntOrigPmtDiscPossibleLCY; "Orig. Pmt. Disc. Possible(LCY)")
            {
            }
            column(VendLedEntOriginalAmount; "Original Amount")
            {
            }
            column(VendLedEntOriginalAmtLCY; "Original Amt. (LCY)")
            {
            }
            column(VendLedEntOriginalCurrencyFactor; "Original Currency Factor")
            {
            }
            column(VendLedEntOriginalPmtDiscPossible; "Original Pmt. Disc. Possible")
            {
            }
            column(VendLedEntPaymentMethodCode; "Payment Method Code")
            {
            }
            column(VendLedEntPaymentReference; "Payment Reference")
            {
            }
            column(VendLedEntPmtDiscRcdLCY; "Pmt. Disc. Rcd.(LCY)")
            {
            }
            column(VendLedEntPmtDiscToleranceDate; "Pmt. Disc. Tolerance Date")
            {
            }
            column(VendLedEntPmtDiscountDate; "Pmt. Discount Date")
            {
            }
            column(VendLedEntPmtToleranceLCY; "Pmt. Tolerance (LCY)")
            {
            }
            column(VendLedEntPositive; Positive)
            {
            }
            column(VendLedEntPostingDate; "Posting Date")
            {
            }
            column(VendLedEntPrepayment; Prepayment)
            {
            }
            column(VendLedEntPurchaseLCY; "Purchase (LCY)")
            {
            }
            column(VendLedEntPurchaserCode; "Purchaser Code")
            {
            }
            column(VendLedEntReasonCode; "Reason Code")
            {
            }
            column(VendLedEntRecipientBankAccount; "Recipient Bank Account")
            {
            }
            column(VendLedEntRemainingAmount; "Remaining Amount")
            {
            }
            column(VendLedEntRemainingAmtLCY; "Remaining Amt. (LCY)")
            {
            }
            column(VendLedEntRemainingPmtDiscPossible; "Remaining Pmt. Disc. Possible")
            {
            }
            column(VendLedEntRemittoCode; "Remit-to Code")
            {
            }
            column(VendLedEntReversed; Reversed)
            {
            }
            column(VendLedEntReversedEntryNo; "Reversed Entry No.")
            {
            }
            column(VendLedEntReversedbyEntryNo; "Reversed by Entry No.")
            {
            }
            column(VendLedEntShortcutDimension3Code; "Shortcut Dimension 3 Code")
            {
            }
            column(VendLedEntShortcutDimension4Code; "Shortcut Dimension 4 Code")
            {
            }
            column(VendLedEntShortcutDimension5Code; "Shortcut Dimension 5 Code")
            {
            }
            column(VendLedEntShortcutDimension6Code; "Shortcut Dimension 6 Code")
            {
            }
            column(VendLedEntShortcutDimension7Code; "Shortcut Dimension 7 Code")
            {
            }
            column(VendLedEntShortcutDimension8Code; "Shortcut Dimension 8 Code")
            {
            }
            column(VendLedEntSourceCode; "Source Code")
            {
            }
            column(VendLedEntSystemCreatedAt; SystemCreatedAt)
            {
            }
            column(VendLedEntSystemCreatedBy; SystemCreatedBy)
            {
            }
            column(VendLedEntSystemId; SystemId)
            {
            }
            column(VendLedEntSystemModifiedAt; SystemModifiedAt)
            {
            }
            column(VendLedEntSystemModifiedBy; SystemModifiedBy)
            {
            }
            column(VendLedEntTransactionNo; "Transaction No.")
            {
            }
            column(VendLedEntUserID; "User ID")
            {
            }
            column(VendLedEntVendorName; "Vendor Name")
            {
            }
            column(VendLedEntVendorNo; "Vendor No.")
            {
            }
            column(VendLedEnttotalAmount_; totalAmount_) { }
            column(VendLedEntVendorPostingGroup; "Vendor Posting Group")
            {
            }
            column(VendLedEntamountwtax; amountwtax) { }
            column(VendLedEntAmountInWordsNew; AmountInWords) { }
            column(CompanyInfoVAT_Registration_No; CompanyInformation."VAT Registration No.")
            {

            }
            column(CompanyInfoAddress1; CompanyInformation.Address)
            {

            }
            column(CompanyInfoPicture; CompanyInformation.Picture) { }
            column(CompanyInfoPhone_No_1; CompanyInformation."Phone No.") { }
            column(CompanyInfoName; CompanyInformation.name)
            {

            }
            column(CompanyInfoE_Mail; CompanyInformation."E-Mail") { }

            column(ParDisContable; DisContable) { }

            dataitem(Vendor; Vendor)
            {
                DataItemLink = "No." = field("Vendor No.");
                DataItemTableView = sorting("No.");
                DataItemLinkReference = VendorLedgerEntry;

                column(VendorName; Name) { }
                column(VendorAddress; Address) { }
                column(VendorPhone_No_; "Phone No.") { }
                column(VendorCity; City) { }
                column(VendorVAT_Registration_No_Vendor; "VAT Registration No.") { }
                dataitem(User; User)
                {
                    DataItemLinkReference = VendorLedgerEntry;
                    DataItemTableView = sorting("User Security ID");
                    DataItemLink = "User Name" = field("User ID");
                    column(User_Security_ID; "User Security ID")
                    {

                    }
                    column(User_Name; "Full Name")
                    {

                    }
                }
            }



            dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
            {
                DataItemTableView = sorting("Document No.");
                DataItemLink = "Document No." = field("Document No.");
                column(D365LCO_Bank_Transaction_No_; "D365L CO Bank Trans. No.") { }
            }
            dataitem(VendLedgEntry2; "Vendor Ledger Entry")
            {

                DataItemTableView = SORTING("Entry No.");

                column(CLENo_; "Document No.")
                {
                }
                column(CLEDocumentDate; "Document Date") { }
                column(CLEexternal; "External Document No.") { }
                column(CLEDescription_; Description) { }
                column(CLEamount; Amount) { }

                column(ClEVendLedEntLAmountWDiscCur; VendLedEntLAmountWDiscCur) { }


                trigger OnPreDataItem()

                begin
                    CreateVendLedgEntry := VendorLedgerEntry;
                    FindApplnEntriesDtldtLedgEntry();
                    SetCurrentKey("Entry No.");
                    SetRange("Entry No.");

                    if CreateVendLedgEntry."Closed by Entry No." <> 0 then begin
                        "Entry No." := CreateVendLedgEntry."Closed by Entry No.";
                        Mark(true);
                    end;

                    SetCurrentKey("Closed by Entry No.");
                    SetRange("Closed by Entry No.", CreateVendLedgEntry."Entry No.");
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
                    DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
                begin
                    CalcFields(Amount, "Remaining Amount");
                    DtldVendLedgEntry.SetRange("Vendor Ledger Entry No.", "Entry No.");
                    DtldVendLedgEntry.SetRange("Entry Type", DtldVendLedgEntry."Entry Type"::Application);
                    DtldVendLedgEntry.SetRange("Document Type", DtldVendLedgEntry."Document Type"::Payment);
                    DtldVendLedgEntry.SetRange("Document No.", VendorLedgerEntry."Document No.");
                    DtldVendLedgEntry.SetRange(Unapplied, false);
                    if not DtldVendLedgEntry.IsEmpty() then begin
                        DtldVendLedgEntry.CalcSums(Amount, "Remaining Pmt. Disc. Possible");
                        VendLedEntLineAmount := DtldVendLedgEntry.Amount;

                        if "Currency Code" <> '' then begin
                            if IsDiscountAppliedToPayment(VendorLedgerEntry."Entry No.", VendorLedgerEntry."Document No.") then
                                VendLedEntLineDiscount := DtldVendLedgEntry."Remaining Pmt. Disc. Possible"
                        end else
                            VendLedEntLineDiscount := CurrExchRate.ExchangeAmtFCYToFCY("Posting Date", '', "Currency Code", "Pmt. Disc. Rcd.(LCY)");

                        VendorLedgerEntry.Amount += VendLedEntLineDiscount;

                        VendLedEntLAmountWDiscCur := -VendLedEntLineAmount - VendLedEntLineDiscount;
                    end else begin
                        Clear(DtldVendLedgEntry);
                        CalcFields(Amount, "Remaining Amount");
                        DtldVendLedgEntry.SetRange("Vendor Ledger Entry No.", "Entry No.");
                        DtldVendLedgEntry.SetRange("Entry Type", DtldVendLedgEntry."Entry Type"::Application);
                        //   DtldVendLedgEntry.SetRange("Document Type", DtldVendLedgEntry."Document Type":);
                        DtldVendLedgEntry.SetRange(Unapplied, false);
                        if not DtldVendLedgEntry.IsEmpty() then begin
                            DtldVendLedgEntry.CalcSums(Amount, "Remaining Pmt. Disc. Possible");
                            VendLedEntLineAmount := DtldVendLedgEntry.Amount;

                            if "Currency Code" <> '' then begin
                                if IsDiscountAppliedToPayment(VendorLedgerEntry."Entry No.", VendorLedgerEntry."Document No.") then
                                    VendLedEntLineDiscount := DtldVendLedgEntry."Remaining Pmt. Disc. Possible"
                            end else
                                VendLedEntLineDiscount := CurrExchRate.ExchangeAmtFCYToFCY("Posting Date", '', "Currency Code", "Pmt. Disc. Rcd.(LCY)");

                            VendorLedgerEntry.Amount += VendLedEntLineDiscount;

                            VendLedEntLAmountWDiscCur := -VendLedEntLineAmount - VendLedEntLineDiscount;
                        end;
                    end;
                    //  CurrReport.Skip();
                end;

            }
            dataitem(DetailedVendorLedgerEntry; Integer)
            {
                DataItemTableView = sorting(Number);

                column(DetVenLedEntVPamount; VPamount) { }
                column(DetVenLedEntVPdescription; VPdescription) { }
                column(DetVenLedEntVPaccount; VPaccount) { }

                trigger OnPreDataItem()
                var
                    GenJournalDocumentType: Enum "Gen. Journal Document Type";
                    DetailedCVLedgerEntryType: Enum "Detailed CV Ledger Entry Type";
                begin
                    VPamount := 0;
                    VPdescription := '';
                    VPaccount := '';

                    SetRange(Number, 1, 100);
                    detailedvendorquery.TopNumberOfRows(100);
                    detailedvendorquery.SetFilter(Vendor_Ledger_Entry_No_, '%1', VendorLedgerEntry."Entry No.");
                    detailedvendorquery.SetRange(Entry_Type, detailedvendorquery.Entry_Type::"Payment Tolerance");
                    detailedvendorquery.SetFilter(Initial_Document_Type, '%1', GenJournalDocumentType::Payment);
                    detailedvendorquery.Open();


                end;

                trigger OnAfterGetRecord()
                var
                    TempGLEntry: Record "G/L Entry";
                begin
                    if detailedvendorquery.Read() then begin
                        /*   invoicingno := getinvoiceno(detailedvendorquery.Vendor_Ledger_Entry_No_);*
                           descriptioninv := getinvoicedescription(invoicingno);
                           externalinvo := getexternaldoc(detailedvendorquery.Vendor_Ledger_Entry_No_);
                           if (detailedvendorquery.Amount < 0) then begin
                               amountdetailedinvo := detailedvendorquery.Amount * -1;
                           end else begin
                               amountdetailedinvo := detailedvendorquery.Amount;
                           end;*/

                        TempGLEntry.SetFilter("Document No.", detailedvendorquery.Document_No_);
                        TempGLEntry.SetFilter(Amount, '0..1');
                        if TempGLEntry.FindFirst() then begin
                            VPamount := TempGLEntry.Amount;
                            VPdescription := TempGLEntry.Description;
                            VPaccount := TempGLEntry."G/L Account No.";
                        end;
                    end
                    else begin
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


                currency := currency_Txt;

                totalAmount_ := CalculateTotalAmountv2(VendorLedgerEntry."Document No.", VendorLedgerEntry."Entry No.");
                amountwtax := totalAmount_;

                //   if amountwtax < 0 then
                //      amountwtax := amountwtax * -1;
                numberToText.FormatNoText(AmountText, amount, currency_Txt);
                AmountInWords := AmountText[1] + AmountText[2];

                if currency = 'COP' then begin
                    if not AmountInWords.Contains(' PESOS ') then begin
                        AmountInWords := AmountText[1] + ' PESOS ' + AmountText[2];
                    end;
                end;
                if currency = 'USD' then begin
                    if not AmountInWords.Contains(' DOLARES ') then begin
                        AmountInWords := AmountText[1] + ' DOLARES' + AmountText[2];
                    end;
                end;


            end;

            trigger OnPreDataItem()
            begin
                if NoValor <> '' then begin
                    SetFilter("Document No.", NoValor);


                end //else
                    //Error('Debe seleccionar un documento');

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
                            dim: Record "Vendor Ledger Entry";
                            pag: Page "Vendor Ledger Entries";
                        begin
                            dim.SetRange("Document Type", dim."Document Type"::Payment);
                            pag.SETTABLEVIEW(dim);
                            pag.LOOKUPMODE(TRUE);
                            IF pag.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                pag.GETRECORD(dim);
                                NoValor := dim."Document No.";
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
        trigger OnInit()
        var
            myInt: Integer;
        begin
            DisContable := true;
        end;
    }
    trigger OnInitReport()

    begin

        CompanyInformation.get();
        CompanyInformation.CalcFields(Picture);
    end;

    var
        CurrExchRate: Record "Currency Exchange Rate";
        VendLedEntLAmountWDiscCur: Decimal;
        VendLedEntLineDIscount: Decimal;
        VendLedEntLineAmount: Decimal;
        CreateVendLedgEntry: Record "Vendor Ledger Entry";
        DisContable: Boolean;
        CompanyInformation: Record "Company Information";
        VPaccount: text;
        VPdescription: text;
        VPamount: Decimal;
        company: Record "Company Information";
        NoValor: Code[30];
        GenJournalSourceType: Enum "Gen. Journal Source Type";
        currency: Text;
        totalAmount_: decimal;
        totalVatAmount_: Decimal;

        LyLGLEntryQry: Query "D365L GLEntryQry";
        detailedvendorquery: Query "D365L detailvendorquery";
        LYLCustLedgEntryQry: Query "D365L VendorLedgEntryQry2";

        currency_Txt: Text;

        AmountInWords: Text;
        amountLine: Decimal;
        bank: Text;
        //DetVenLedEntinvoicingno: Code[20];
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

    ///<summary>
    ///Procedimiento para validar valor total afectado por el proveedor desde los detalles
    ///</summary>
    ///<param name="DocumentNo">Recibe numero del documento</param>
    local procedure CalculateTotalAmount(DocumentNo: Code[20]): Decimal
    var
        total: Decimal;
        detailvendorquery: Query "D365L detailvendorquery";
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
    ///<summary>
    ///Procedimiento para validar valor total afectado por el proveedor desde los movimientos de contabilidad
    ///</summary>
    ///<param name="DocumentNo">Recibe numero del documento</param>
    ///<param name="VLEN">Recibe numero de movimiento</param>
    local procedure CalculateTotalAmountv2(DocumentNo: Code[20]; VLEN: Integer): Decimal
    var
        total: Decimal;
        GLEntry: Record "G/L Entry";
        DetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
        DetailedCVLedgerEntryType: Enum "Detailed CV Ledger Entry Type";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        GLEntry.SetFilter("Document No.", DocumentNo);
        GLEntry.SetFilter(Amount, '0..1');
        GLEntry.CalcSums(Amount);

        VendorLedgerEntry.SetFilter("Document No.", DocumentNo);
        if VendorLedgerEntry.FindSet() then
            repeat
                DetailedVendorLedgEntry.SetFilter("Vendor Ledger Entry No.", '%1', VendorLedgerEntry."Entry No.");
                DetailedVendorLedgEntry.SetFilter(Amount, '<0');
                DetailedVendorLedgEntry.SetFilter("Entry Type", '%1', DetailedCVLedgerEntryType::Application);
                DetailedVendorLedgEntry.CalcSums(Amount);
                total += DetailedVendorLedgEntry.Amount;
            until VendorLedgerEntry.Next() = 0;

        exit((total * -1) + GLEntry.Amount);
    end;

    ///<summary>
    ///Procedimiento para validar el banco al cual se realizo el pago del documento
    ///</summary>
    ///<param name="documentNo">Recibe el documento del movimiento</param>
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
    ///<summary>
    /// Procedimiento para obtener todos los detalles de la factura
    /// </summary>
    ///<param name="entry">Recibe numero de movimiento</param>
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
    ///<summary>
    /// Procedimiento para traer la descripcion de la factura del proveedor
    /// </summary>
    ///<param name="invoice">Recibe Numero de factura</param>
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
    ///<summary>
    /// Procedimiento para comparar movimientos relacionados al proveedor para obtener tanto pagos aplicados y no aplicados para los movimientos de dicho proveedor
    /// </summary>
    local procedure FindApplnEntriesDtldtLedgEntry()
    var
        DtldVendLedgEntry1: Record "Detailed Vendor Ledg. Entry";
        DtldVendLedgEntry2: Record "Detailed Vendor Ledg. Entry";
    begin
        DtldVendLedgEntry1.Reset();
        DtldVendLedgEntry1.SetCurrentKey("Vendor Ledger Entry No.");
        DtldVendLedgEntry1.SetRange("Vendor Ledger Entry No.", VendorLedgerEntry."Entry No.");
        DtldVendLedgEntry1.SetRange(Unapplied, false);
        if DtldVendLedgEntry1.Find('-') then
            repeat
                if DtldVendLedgEntry1."Vendor Ledger Entry No." =
                   DtldVendLedgEntry1."Applied Vend. Ledger Entry No."
                then begin
                    DtldVendLedgEntry2.Reset();
                    DtldVendLedgEntry2.SetCurrentKey("Applied Vend. Ledger Entry No.", "Entry Type");
                    DtldVendLedgEntry2.SetRange(
                      "Applied Vend. Ledger Entry No.", DtldVendLedgEntry1."Applied Vend. Ledger Entry No.");
                    DtldVendLedgEntry2.SetRange("Entry Type", DtldVendLedgEntry2."Entry Type"::Application);
                    DtldVendLedgEntry2.SetRange(Unapplied, false);
                    if DtldVendLedgEntry2.Find('-') then
                        repeat
                            if DtldVendLedgEntry2."Vendor Ledger Entry No." <>
                               DtldVendLedgEntry2."Applied Vend. Ledger Entry No."
                            then begin
                                VendLedgEntry2.SetCurrentKey("Entry No.");
                                VendLedgEntry2.SetRange("Entry No.", DtldVendLedgEntry2."Vendor Ledger Entry No.");
                                if VendLedgEntry2.Find('-') then
                                    VendLedgEntry2.Mark(true);
                            end;
                        until DtldVendLedgEntry2.Next() = 0;
                end else begin
                    VendLedgEntry2.SetCurrentKey("Entry No.");
                    VendLedgEntry2.SetRange("Entry No.", DtldVendLedgEntry1."Applied Vend. Ledger Entry No.");
                    if VendLedgEntry2.Find('-') then
                        VendLedgEntry2.Mark(true);
                end;
            until DtldVendLedgEntry1.Next() = 0;
    end;
    ///<summary>
    /// Procedimiento para obtener numero de documento externo
    /// </summary>
    ///<param name="EntryNo">Recibe numero de movimiento</param>
    local procedure getexternaldoc(EntryNo: Integer): Text
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        VendorLedgerEntry.Setfilter("Closed by Entry No.", '%1', EntryNo);
        if (VendorLedgerEntry.FindFirst()) then begin
            exit(VendorLedgerEntry."External Document No.");
        end else begin
            exit('')
        end
    end;
    ///<summary>
    /// Procedimiento para validar si se aplico descuento al momento de realizar el pago 
    /// </summary>
    /// <param name="DocNo">Recibe numero de documento</param>
    /// <param name="VendLedgEntryNo">Recibe numero de movimiento</param>
    local procedure IsDiscountAppliedToPayment(VendLedgEntryNo: Integer; DocNo: Code[20]): Boolean
    var
        DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
    begin
        DtldVendLedgEntry.LoadFields("Vendor Ledger Entry No.", "Entry Type", "Document Type", "Document No.", "Currency Code", Unapplied);
        DtldVendLedgEntry.SetRange("Vendor Ledger Entry No.", VendLedgEntryNo);
        DtldVendLedgEntry.SetRange("Entry Type", DtldVendLedgEntry."Entry Type"::"Payment Discount");
        DtldVendLedgEntry.SetRange("Document Type", DtldVendLedgEntry."Document Type"::Payment);
        DtldVendLedgEntry.SetRange("Document No.", DocNo);
        DtldVendLedgEntry.SetFilter("Currency Code", '<>%1', '');
        DtldVendLedgEntry.SetRange(Unapplied, false);
        if not DtldVendLedgEntry.IsEmpty() then
            exit(true);
    end;
}
