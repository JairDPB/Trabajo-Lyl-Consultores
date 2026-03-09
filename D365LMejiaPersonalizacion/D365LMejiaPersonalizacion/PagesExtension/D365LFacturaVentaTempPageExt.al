pageextension 88102 SalesInvoiceExt extends "Sales Invoice"
{
    layout
    {
        addlast(General)
        {
            field("No orden"; Rec."No orden")
            {
                ApplicationArea = All;
            }
            field("Presupuesto"; Rec."Presupuesto")
            {
                ApplicationArea = All;
            }
        }
    }
}
