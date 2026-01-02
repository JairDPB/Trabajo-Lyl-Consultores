table 50121 "D365L GL Movements Buffer"
{
    TableType = Temporary;
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Posting Date"; Date) { }
        field(2; "G/L Account No."; Code[20]) { }
        field(3; "Dim 1"; Code[20]) { }
        field(4; "Dim 2"; Code[20]) { }
        field(5; "Dim 3"; Code[20]) { }
        field(6; "Dim 4"; Code[20]) { }
        field(7; "Dim 5"; Code[20]) { }
        field(8; "Dim 6"; Code[20]) { }
        field(9; "Dim 7"; Code[20]) { }
        field(10; "Dim 8"; Code[20]) { }
        field(11; "Is Closing Entry"; Boolean) { }
        field(12; Amount; Decimal) 
        { 
            AutoFormatType = 1;
        }
        field(13; "Debit Amount"; Decimal) 
        { 
            AutoFormatType = 1;
        }
        field(14; "Credit Amount"; Decimal) 
        { 
            AutoFormatType = 1;
        }
    }

    keys
    {
        key(PK; "Posting Date", "G/L Account No.", "Dim 1", "Dim 2", "Dim 3", "Dim 4", "Dim 5", "Dim 6", "Dim 7", "Dim 8", "Is Closing Entry")
        {
            Clustered = true;
        }
    }
}