query 90148 "D365LATAM AccountQry"
{
    QueryType = Normal;
    OrderBy = descending(No_);

    elements
    {
        dataitem(G_L_Account; "G/L Account")
        {
            column(No_; "No.") { }
            column(Account_Type; "Account Type") { }
            column(Totaling; Totaling) { }
        }
    }
}