pageextension 88100 PostedSalesInvoiceExt extends "Posted Sales Invoice"
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