query 90149 "D365LATAM TrialBalanceQry"
{
    QueryType = Normal;

    elements
    {
        dataitem(G_L_Account; "G/L Account")
        {
            column(G_L_Account_No_; "No.") { }
            column(G_L_Account_Name; Name) { }
            column(Account_Type; "Account Type") { }
            column(Totaling; Totaling) { }
            dataitem(G_L_Entry_1; "G/L Entry")
            {
                DataItemLink = "G/L Account No." = G_L_Account."No.";
                SqlJoinType = LeftOuterJoin;
                column(Shortcut_Dimension_3_Code; "D365L CO Third No.") { }

                column(Amount; Amount)
                {
                    Method = sum;
                }
                filter(Posting_Date; "Posting Date")
                {
                }

            }
        }
    }

}