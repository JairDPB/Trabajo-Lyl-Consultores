query 60104 LyLGLEntryQry
{
    QueryType = Normal;

    elements
    {
        dataitem(DataItemName; "G/L Entry")
        {
            column(Amount; Amount) { }
            column(Document_No_; "Document No.") { }
            column(Description; Description) { }
            column(Source_Type; "Source Type") { }
            column(Document_Type; "Document Type") { }

            column(Source_No_; "Source No.") { }
        }
    }

    var
        myInt: Integer;

    trigger OnBeforeOpen()
    begin

    end;
}