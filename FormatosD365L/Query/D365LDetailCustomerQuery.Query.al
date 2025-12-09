///<summary>
///Consulta de informacion de los movimientos detallados de clientes
///</summary>
query 50148 "D365L DetailCustomerQuery"
{
    QueryType = Normal;

    elements
    {
        dataitem(DetailedCustLedgEntry; "Detailed Cust. Ledg. Entry")
        {
            column(Amount; Amount)
            {
            }
            column(Document_No_; "Document No.") { }
            column(Entry_No_; "Entry No.") { }
            column(Entry_Type; "Entry Type") { }
            column(Document_Type; "Document Type") { }
            column(Cust__Ledger_Entry_No_; "Cust. Ledger Entry No.") { }

            filter(Initial_Document_Type; "Initial Document Type") { }

        }
    }

}
