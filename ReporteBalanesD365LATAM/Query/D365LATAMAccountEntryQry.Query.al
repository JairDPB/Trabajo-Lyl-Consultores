query 90147 "D365LATAM AccountEntryQry"
{
    QueryType = Normal;

    elements
    {
        dataitem(G_L_Entry; "G/L Entry")
        {
            column(G_L_Account_No_; "G/L Account No.") { }
            column(Shortcut_Dimension_3_Code; "D365L CO Third No.") { }
            column(Amount; Amount)
            {
                Method = Sum;
            }
            column(Credit_Amount; "Credit Amount")
            {
                Method = sum;
            }
            column(Debit_Amount; "Debit Amount")
            {
                Method = sum;
            }
            filter(Posting_Date; "Posting Date")
            {
            }
        }
    }
}