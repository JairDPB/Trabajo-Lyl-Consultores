table 50126 "D365L Budget Summary Temp"
{
    TableType = Temporary;
    Caption = 'Resumen presupuestario temporal';
    
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(10; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(20; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
        }
        field(30; "Global Dimension 1"; Code[20])
        {
            Caption = 'Global Dimension 1';
        }
        field(31; "Global Dimension 2"; Code[20])
        {
            Caption = 'Global Dimension 2';
        }
        field(40; "Budget Dimension 1"; Code[20])
        {
            Caption = 'Budget Dimension 1';
        }
        field(41; "Budget Dimension 2"; Code[20])
        {
            Caption = 'Budget Dimension 2';
        }
        field(42; "Budget Dimension 3"; Code[20])
        {
            Caption = 'Budget Dimension 3';
        }
        field(43; "Budget Dimension 4"; Code[20])
        {
            Caption = 'Budget Dimension 4';
        }
        field(50; "Original Amount API"; Decimal)
        {
            Caption = 'Monto Original';
        }
        field(51; "Adjustment Amount API"; Decimal)
        {
            Caption = 'Monto de Ajuste';
        }
        field(52; "Budget Amount"; Decimal)
        {
            Caption = 'Monto del Presupuesto';
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
