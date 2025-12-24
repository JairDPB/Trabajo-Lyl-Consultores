pageextension 50104 BankLedgerEntriesExt extends "Bank Account Ledger Entries"
{
    layout
    {
        addlast(Control1)
        {
            field("Tipo Movimiento"; Rec."Tipo Movimiento")
            {
                ApplicationArea = All;
            }
        }
    }
}
