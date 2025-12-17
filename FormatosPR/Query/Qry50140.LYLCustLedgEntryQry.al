query 60105 LYLVendorLedgEntryQry2
{
    QueryType = Normal;

    elements
    {
        dataitem(CLE_1; "Vendor Ledger Entry")
        {
            column(Document_No_; "Document No.") { }
            dataitem(CLE; "Vendor Ledger Entry")
            {
                DataItemLink = "Closed by Entry No." = CLE_1."Entry No.";
                column(Closed_by_Entry_No_; "Closed by Entry No.") { }
                column(Amount_Including_VAT; Amount) { }
                column(No_; "Document No.") { }
                column(Currency_Code; "Currency Code") { }
                column(Amount__LCY_; "Amount (LCY)") { }
                column(Shortcut_Dimension_1_Code; "Global Dimension 1 Code") { }
                column(Applies_to_Doc__No_; "Applies-to Doc. No.") { }
                column(External_Document_No_; "External Document No.") { }
                column(Description; Description) { }
            }
        }

    }
}