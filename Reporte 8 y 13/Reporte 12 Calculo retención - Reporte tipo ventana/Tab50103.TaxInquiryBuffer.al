table 50108 "Tax Inquiry Buffer"
{
    TableType = Temporary;
    
    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(5; "Source Type"; Option)
        {
            Caption = 'Tipo Origen';
            OptionMembers = Invoice,"Credit Memo";
        }
        field(10; "Document Type"; Text[50])
        {
            Caption = 'Tipo documento';
        }
        field(20; "Document No."; Code[20])
        {
            Caption = 'No.';
        }
        field(25; "Line No."; Integer)
        {
            Caption = 'No. Línea';
        }
        field(30; "Vendor Invoice No."; Code[35])
        {
            Caption = 'Factura proveedor';
        }
        field(40; "Document Date"; Date)
        {
            Caption = 'Fecha factura';
        }
        field(50; "Type"; Text[50])
        {
            Caption = 'Tipo';
        }
        field(60; "Item Code"; Code[20])
        {
            Caption = 'Cod. producto';
        }
        field(70; "Description"; Text[100])
        {
            Caption = 'Descripción';
        }
        field(80; "Quantity"; Decimal)
        {
            Caption = 'Cantidad';
            DecimalPlaces = 0 : 5;
        }
        field(90; "Unit Price"; Decimal)
        {
            Caption = 'Valor unitario';
            DecimalPlaces = 0 : 5;
        }
        field(100; "Total Amount"; Decimal)
        {
            Caption = 'Valor total';
            DecimalPlaces = 0 : 5;
        }
        field(110; "Tax Area Code"; Code[20])
        {
            Caption = 'Área de impuesto';
        }
        field(120; "Tax Group Code"; Code[20])
        {
            Caption = 'Grupo de impuesto';
        }
        field(130; "VAT Amount"; Decimal)
        {
            Caption = 'IVA';
            DecimalPlaces = 0 : 5;
        }
        field(140; "VAT Withholding"; Decimal)
        {
            Caption = 'ReteIVA';
            DecimalPlaces = 0 : 5;
        }
        field(150; "Income Withholding"; Decimal)
        {
            Caption = 'Retefuente';
            DecimalPlaces = 0 : 5;
        }
        field(160; "ICA Withholding"; Decimal)
        {
            Caption = 'ReteICA';
            DecimalPlaces = 0 : 5;
        }
    }
    
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}