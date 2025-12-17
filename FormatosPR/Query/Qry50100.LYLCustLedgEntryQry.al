query 60103 LYLCustLedgEntryQry
{
    QueryType = Normal;

    elements
    {
        dataitem(CLEs; "Cust. Ledger Entry")
        {
            column(Closed_by_Entry_No_; "Closed by Entry No.") { }
            column(Amount_Including_VAT; Amount) { }
            column(No_; "Document No.") { }
            column(Description; Description) { }
            column(Currency_Code; "Currency Code") { }
            column(Amount__LCY_; "Amount (LCY)") { }
            column(Shortcut_Dimension_1_Code; "Global Dimension 1 Code") { }
            column(Credit_Amount; "Credit Amount") { }
            column(Debit_Amount; "Debit Amount") { }

            dataitem(G_L_Entry; "G/L Entry")
            {
                DataItemLink = "Document No." = CLEs."Document No.", "Entry No." = CLEs."Entry No.";

                column(G_L_Account_No_; "G/L Account No.") { }

                filter(Bal__Account_Type; "Bal. Account Type") { }
            }
        }
    }
}