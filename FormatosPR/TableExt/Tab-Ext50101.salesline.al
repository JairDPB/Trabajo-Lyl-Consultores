tableextension 60102 salesline extends "Sales Line"
{
    fields
    {
        field(60102; LyLExtDescription; Text[1000])
        {
            Caption = 'LyL Descripción extensa';
            DataClassification = ToBeClassified;
        }
    }
}
