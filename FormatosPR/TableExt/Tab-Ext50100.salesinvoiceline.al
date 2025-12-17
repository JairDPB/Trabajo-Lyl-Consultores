tableextension 60100 salesinvoiceline extends "Sales Invoice Line"
{
    fields
    {
        field(60100; LyLExtDescription; Text[1000])
        {
            Caption = 'LyL Descripción extensa';
            DataClassification = ToBeClassified;
        }
    }
}
tableextension 60101 salesCMLine extends "Sales Cr.Memo Line"
{
    fields
    {
        field(60101; LyLExtDescription; Text[1000])
        {
            Caption = 'LyL Descripción extensa';
            DataClassification = ToBeClassified;
        }
    }
}
