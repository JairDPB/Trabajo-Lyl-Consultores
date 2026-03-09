pageextension 88101 PostedSalesInvoiceExt extends "Posted Sales Invoice"
{
    layout
    {
        addlast(General)
        {
            field("No orden"; Rec."No orden")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Presupuesto"; Rec."Presupuesto")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}