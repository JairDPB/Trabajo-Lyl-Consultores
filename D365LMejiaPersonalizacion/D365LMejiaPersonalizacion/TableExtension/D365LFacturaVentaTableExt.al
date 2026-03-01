tableextension 88100 SalesInvoiceHeaderExt extends "Sales Invoice Header"
{
    fields
    {
        field(50100; "No orden"; Text[100])
        {
            Caption = 'No orden';
            DataClassification = ToBeClassified;
        }
         field(50101; "Presupuesto"; Text[100])
        {
            Caption = 'Presupuesto';
            DataClassification = ToBeClassified;
        }
    }
}