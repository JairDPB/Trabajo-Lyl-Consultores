table 50120 "D365L GL Movements Buffer"
{
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

        field(20; "Is Closing Entry"; Boolean) { }

        field(30; Amount; Decimal) { }
        field(31; "Debit Amount"; Decimal) { }
        field(32; "Credit Amount"; Decimal) { }
    }

    keys
    {
        key(PK;
            "Posting Date",
            "G/L Account No.",
            "Dim 1","Dim 2","Dim 3","Dim 4",
            "Dim 5","Dim 6","Dim 7","Dim 8",
            "Is Closing Entry")
        {
            Clustered = true;
        }
    }
}
