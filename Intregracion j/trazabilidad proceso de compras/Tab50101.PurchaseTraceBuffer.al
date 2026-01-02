table 50112 "D365L Purchase Trace Buffer"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        // ==== PEDIDO ====
        field(70; "Order No."; Code[20]) { }
        field(2; "Order Date"; Date) { }
        field(3; "Order Approval Date"; Date) { }
        field(4; "Expected Receipt Date"; Date) { }
        field(5; "Order Created By"; Code[50]) { }
        field(6; "Buyer Code"; Code[20]) { }
        field(7; Status; Code[20]) { }

        field(8; "Vendor No."; Code[20]) { }
        field(9; "Vendor Name"; Text[100]) { }

        // ==== LÍNEA DE PEDIDO ====
        field(10; "Order Line No."; Integer) { }
        field(11; "Order Item No."; Code[20]) { }
        field(12; "Order Description"; Text[100]) { }

        field(13; "Currency Code"; Code[10]) { }
        field(14; TRM; Decimal) { }

        field(15; "Order Quantity"; Decimal) { }
        field(16; "Unit of Measure"; Code[10]) { }
        field(17; "Order Unit Cost"; Decimal) { }
        field(18; "Order Line Amount"; Decimal) { }

        // ==== DIMENSIONES ====
        field(30; "Dim 1"; Code[20]) { }
        field(31; "Dim 2"; Code[20]) { }
        field(32; "Dim 3"; Code[20]) { }
        field(33; "Dim 4"; Code[20]) { }
        field(34; "Dim 5"; Code[20]) { }
        field(35; "Dim 6"; Code[20]) { }
        field(36; "Dim 7"; Code[20]) { }
        field(37; "Dim 8"; Code[20]) { }

        // ==== RECEPCIÓN ====
        field(50; "Receipt No."; Code[20]) { }
        field(51; "Receipt Date"; Date) { }
        field(52; "Received Quantity"; Decimal) { }

        // ==== FACTURA ====
        field(60; "Invoice No."; Code[20]) { }
        field(61; "Vendor Invoice No."; Code[35]) { }
        field(62; "Invoice Date"; Date) { }

        field(63; "Invoice Item No."; Code[20]) { }
        field(64; "Invoice Description"; Text[100]) { }
        field(65; "Invoiced Quantity"; Decimal) { }
        field(66; "Invoice Unit Cost"; Decimal) { }
        field(67; "Invoice Line Amount"; Decimal) { }
    }

    keys
    {
        key(PK; "Entry No.")//(PK; "Order No.", "Order Line No.", "Receipt No.", "Invoice No.")
        {
            Clustered = true;
        }
    }
}
