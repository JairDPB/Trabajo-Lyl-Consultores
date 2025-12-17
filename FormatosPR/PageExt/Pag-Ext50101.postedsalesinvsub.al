pageextension 60101 postedsalesinvsub extends "Posted Sales Invoice Subform"
{
    layout
    {
        addafter("No.")
        {
            field(LyLExtDescription; Rec.LyLExtDescription)
            {
                Caption = 'Descripción extensa';
                ApplicationArea = All;
            }
        }

    }
}
pageextension 60102 postedSalesCMLine extends "Posted Sales Cr. Memo Subform"

{
    layout
    {
        addafter("No.")
        {
            field(LyLExtDescription; Rec.LyLExtDescription)
            {
                Caption = 'Descripción extensa';
                ApplicationArea = All;
            }
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
