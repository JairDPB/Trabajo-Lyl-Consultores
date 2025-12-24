report 50100 "D365L_report movimientosBancos"
{
    Caption = 'D365L_report movimientosBancos';
    dataset
    {
        dataitem(BankAccountLedgerEntry; "Bank Account Ledger Entry")
        {
            column(Description; Description)
            {
            }
            column(BankAccountNo; "Bank Account No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(ClosedatDate; "Closed at Date")
            {
            }
            column(DocumentType; "Document Type")
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(Amount; Amount)
            {
            }
            column(DimensionSetID; "Dimension Set ID")
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
