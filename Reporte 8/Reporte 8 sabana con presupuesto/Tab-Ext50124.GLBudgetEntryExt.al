tableextension 50124 "G/L Budget Entry Ext" extends "G/L Budget Entry"
{
    fields
    {
        field(50; "D365L Original Amount API"; Decimal)
        {
            Caption = 'D365L Monto Original';
            DataClassification = CustomerContent;
        }
        field(51; "D365L Adjustment API"; Decimal)
        {
            Caption = 'D365L Ajuste';
            DataClassification = CustomerContent;
        }
    }
}
