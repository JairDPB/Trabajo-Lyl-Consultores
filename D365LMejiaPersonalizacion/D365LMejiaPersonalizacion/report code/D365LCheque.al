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
            RequestFilterFields = "Journal Template Name", "Journal Batch Name", "Document No.";
            
            column(Posting_Date; "Posting Date") { }
            column(Account_No_; "Account No.") { }
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
            column(ParDisContable; DisContable) { }
            column(Day; Day) { }
            column(totalAmount_; totalAmount_) { }
           dataitem(VendorLedgerEntry; "Vendor Ledger Entry")
            {
                DataItemTableView = sorting("Document No.");
                DataItemLink = "Document No." = field("Document No.");

                // ── Datos del proveedor y usuario responsable ──
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
                    column(VendorE_Mail; "E-Mail") { }

                    dataitem(User; User)
                    {
                        DataItemLinkReference = VendorLedgerEntry;
                        DataItemTableView = sorting("User Security ID");
                        DataItemLink = "User Name" = field("User ID");

                        column(User_Security_ID; "User Security ID") { }
                        column(User_Name; "Full Name") { }
                    }
                }

                // ── Facturas/documentos aplicados al pago ──
                dataitem(VendLedgEntry2; "Vendor Ledger Entry")
                {
                    DataItemTableView = SORTING("Entry No.");

                    // Columnas para mostrar en el RDL
                    column(CLENo_; "Document No.") { }
                    column(CLEDocumentDate; "Document Date") { }
                    column(CLEexternal; "External Document No.") { }
                    column(CLEDescription_; Description) { }
                    column(CLEamount; Amount) { }
                    // Valor aplicado con descuento  →  en RDL usar: =Fields!ClEVendLedEntLAmountWDiscCur.Value * -1
                    column(ClEVendLedEntLAmountWDiscCur; VendLedEntLAmountWDiscCur) { }

                    trigger OnPreDataItem()
                    begin
                        // Lógica tomada de Comprobante de Egresos
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
                                VendLedEntLineDiscount := CurrExchRate.ExchangeAmtFCYToFCY(
                                    "Posting Date", '', "Currency Code", "Pmt. Disc. Rcd.(LCY)");

                            VendorLedgerEntry.Amount += VendLedEntLineDiscount;
                            VendLedEntLAmountWDiscCur := -VendLedEntLineAmount - VendLedEntLineDiscount;
                        end else begin
                            Clear(DtldVendLedgEntry);
                            CalcFields(Amount, "Remaining Amount");
                            DtldVendLedgEntry.SetRange("Vendor Ledger Entry No.", "Entry No.");
                            DtldVendLedgEntry.SetRange("Entry Type", DtldVendLedgEntry."Entry Type"::Application);
                            DtldVendLedgEntry.SetRange(Unapplied, false);
                            if not DtldVendLedgEntry.IsEmpty() then begin
                                DtldVendLedgEntry.CalcSums(Amount, "Remaining Pmt. Disc. Possible");
                                VendLedEntLineAmount := DtldVendLedgEntry.Amount;

                                if "Currency Code" <> '' then begin
                                    if IsDiscountAppliedToPayment(VendorLedgerEntry."Entry No.", VendorLedgerEntry."Document No.") then
                                        VendLedEntLineDiscount := DtldVendLedgEntry."Remaining Pmt. Disc. Possible"
                                end else
                                    VendLedEntLineDiscount := CurrExchRate.ExchangeAmtFCYToFCY(
                                        "Posting Date", '', "Currency Code", "Pmt. Disc. Rcd.(LCY)");

                                VendorLedgerEntry.Amount += VendLedEntLineDiscount;
                                VendLedEntLAmountWDiscCur := -VendLedEntLineAmount - VendLedEntLineDiscount;
                            end;
                        end;
                    end;
                }
            }

            dataitem(G_LEntry; "G/L Entry")
            {
                DataItemTableView = SORTING("Document No.") where("Document Type" = const(Payment));
                DataItemLink = "Document No." = field("Document No.");

                // Columnas de la distribución contable
                column(G_LEntDebit_Amount; "Debit Amount") { }
                column(G_LEntCredit_Amount; "Credit Amount") { }
                column(G_LEnt_Account_No; "G/L Account No.") { }

                // Sub-dataitem para obtener el nombre de la cuenta contable
                dataitem("G/L Account"; "G/L Account")
                {
                    DataItemTableView = SORTING("No.");
                    DataItemLink = "No." = field("G/L Account No.");

                    column(G_LAccName; Name) { }
                }

                trigger OnAfterGetRecord()
                begin
                    // Evitar duplicados igual que en Comprobante de Egresos
                    if TempGLEntryExist("Entry No.") then
                        CurrReport.Skip();
                end;
            }
            
            trigger OnPreDataItem()
            begin
                // Filtrar solo cheques manuales
                SetRange("Bank Payment Type", "Bank Payment Type"::"Manual Check");
            end;

    trigger OnAfterGetRecord()
            var
                AmountText: array[2] of Text;
                GenJournalLine: Record "Gen. Journal Line";
                GenJournalLineVendor: Record "Gen. Journal Line";
                BankA: Record "Bank Account";
                numberToText: Codeunit "LyL NumberToText_INGCH";
                proveedor: Record Vendor;
                cliente: Record Customer;
            begin
                // ── Limpiar TempGLEntry para cada nuevo documento ──
                TempGLEntry.Reset();
                TempGLEntry.DeleteAll();
        // Buscar la línea del BANCO para obtener datos del banco
        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", "Gen. Journal Line"."Journal Template Name");
        GenJournalLine.SetRange("Journal Batch Name", "Gen. Journal Line"."Journal Batch Name");
        GenJournalLine.SetRange("Document No.", "Gen. Journal Line"."Document No.");
        GenJournalLine.SetRange("Account Type", GenJournalLine."Account Type"::"Bank Account");
        if GenJournalLine.FindFirst() then begin
            BankA.Reset();
            BankA.SetRange("No.", GenJournalLine."Account No.");
            if BankA.FindFirst() then begin
                bankaa := BankA."Bank Account No.";
                Banco := BankA.Name;
            end;
            DocNo := GenJournalLine."Document No.";
            CuentaB := GenJournalLine."Account No.";
        end;

    // Buscar la línea del PROVEEDOR/CLIENTE 
    GenJournalLineVendor.Reset();
    GenJournalLineVendor.SetRange("Journal Template Name", "Gen. Journal Line"."Journal Template Name");
    GenJournalLineVendor.SetRange("Journal Batch Name", "Gen. Journal Line"."Journal Batch Name");
    GenJournalLineVendor.SetRange("Document No.", "Gen. Journal Line"."Document No.");
    GenJournalLineVendor.SetFilter("Account Type", '<>%1', GenJournalLineVendor."Account Type"::"Bank Account");
    GenJournalLineVendor.CalcSums(Amount);
    totala := Abs(GenJournalLineVendor.Amount); // Abs para asegurar valor positivo
    totalAmount_ := totala;

    // Obtener nombre del tercero
    if GenJournalLineVendor.FindFirst() then begin
        proveedor.Reset();
        proveedor.SetRange("No.", GenJournalLineVendor."D365L CO Third No.");
        if proveedor.FindFirst() then
            tercero := proveedor.Name
        else begin
            cliente.Reset();
            cliente.SetRange("No.", GenJournalLineVendor."D365L CO Third No.");
            if cliente.FindFirst() then
                tercero := cliente.Name;
        end;
    end;

    // Fecha
    InputDate := "Posting Date";
    Day := Date2DMY(InputDate, 1);
    Month := Date2DMY(InputDate, 2);
    Year := Date2DMY(InputDate, 3);

    // Moneda y monto en letras
    currencyText := "Currency Code";
    if (currencyText = '') or (currencyText = 'COP') then
        currencyc := 'COP'
    else
        currencyc := currencyText;

    numberToText.FormatNoText(AmountText, totala, currencyText);
    AmountInWords := AmountText[1] + AmountText[2];

    // Formato mes
    MESFormat := Format(Month, 0, '<Integer,2><Filler Character,0>');

    // Texto en palabras con moneda
    case currencyc of
        'COP':
            begin
                if not AmountInWords.Contains(' PESOS ') then
                    AmountInWords := AmountText[1] + 'PESOS' + AmountText[2]
                else
                    AmountInWords := AmountText[1] + AmountText[2];
            end;
        'USD':
            begin
                if not AmountInWords.Contains(' DOLARES ') then
                    AmountInWords := AmountText[1] + 'DOLARES' + AmountText[2]
                else
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
    SaveValues = true;
    layout
    {
        area(Content)
        {
            group(NumeroConsecutivo)
            {
                field(consecutivo; consecutivo)
                {
                    ApplicationArea = All;
                    Caption = 'Numero de Cheque';
                }
            }
            group(Opciones)
            {
                Caption = 'Opciones';
                field(DisContable; DisContable)
                {
                    ApplicationArea = All;
                    Caption = 'Mostrar Distribución Contable';
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
    local procedure TempGLEntryExist(EntryNo: Integer): Boolean
    begin
        if TempGLEntry.Get(EntryNo) then
            exit(true);
        TempGLEntry.Init();
        TempGLEntry."Entry No." := EntryNo;
        TempGLEntry.Insert();
    end;
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
        DisContable: Boolean;
        totalAmount_: Decimal;  
        TempGLEntry: Record "G/L Entry" temporary; 
        CurrExchRate: Record "Currency Exchange Rate";
        VendLedEntLAmountWDiscCur: Decimal;
        VendLedEntLineAmount: Decimal;
        VendLedEntLineDiscount: Decimal;
        CreateVendLedgEntry: Record "Vendor Ledger Entry";

}