pageextension 60100 salesinvsub extends "Sales Invoice Subform"
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

pageextension 60103 salesCMLines extends "Sales Cr. Memo Subform"
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
