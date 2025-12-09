///<summary>
///Consulta de la tabla de movimientos de contabilidad
///</summary>
query 50131 "D365L GLEntryQry"
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
            column(Credit_Amount; "Credit Amount") { }
            column(Debit_Amount; "Debit Amount") { }
            column(G_L_Account_No_; "G/L Account No.") { }
        }
    }

    var
        myInt: Integer;

    trigger OnBeforeOpen()
    begin

    end;
}