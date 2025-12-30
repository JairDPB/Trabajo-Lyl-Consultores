query 50129 "D365L GLEntry Aggregated"
{
    QueryType = Normal;

    elements
    {
        dataitem(GLEntry; "G/L Entry")
        {
            column(PostingDate; "Posting Date") { }
            column(GLAccountNo; "G/L Account No.") { }

            column(Dim1; "Global Dimension 1 Code") { }
            column(Dim2; "Global Dimension 2 Code") { }
            column(Dim3; "Shortcut Dimension 3 Code") { }
            column(Dim4; "Shortcut Dimension 4 Code") { }
            column(Dim5; "Shortcut Dimension 5 Code") { }
            column(Dim6; "Shortcut Dimension 6 Code") { }
            column(Dim7; "Shortcut Dimension 7 Code") { }
            column(Dim8; "Shortcut Dimension 8 Code") { }

            column(IsClosingEntry; "Source Code") { }

            column(Amount; Amount)
            {
                Method = Sum;
            }

            column(DebitAmount; "Debit Amount")
            {
                Method = Sum;
            }

            column(CreditAmount; "Credit Amount")
            {
                Method = Sum;
            }
        }
    }
}
