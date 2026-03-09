// 1. Extensión de tabla Sales Header (donde se editan los campos)
tableextension 88101 SalesHeaderExt extends "Sales Header"
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