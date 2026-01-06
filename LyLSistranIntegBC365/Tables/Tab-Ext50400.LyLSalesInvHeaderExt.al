tableextension 50400 LyLSalesInvHeaderExt extends "Sales Invoice Header"
{
    fields
    {
        field(50400; LYLCMS_status; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }
    }

    var
        myInt: Integer;
}