///<summary>
///Consulta de informacion de los movimientos detallados de proveedores
///</summary>
query 50149 "D365L DetailVendorQuery"
{
    QueryType = Normal;

    elements
    {
        dataitem(DetailedVendorLedgEntry; "Detailed Vendor Ledg. Entry")
        {
            column(Amount; Amount) { }
            column(Document_No_; "Document No.") { }
            column(Entry_No_; "Entry No.") { }
            column(Entry_Type; "Entry Type") { }
            column(Document_Type; "Document Type") { }
            column(Vendor_Ledger_Entry_No_; "Vendor Ledger Entry No.") { }
            filter(Initial_Document_Type; "Initial Document Type") { }

        }
    }

}
