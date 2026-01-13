table 50131 "Payroll DIAN Response"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }

        // Relación con documento
        field(10; "Numero"; Code[30])
        {
            TableRelation = "Payroll Electronic Document"."Numero";
        }

        // Respuesta exitosa (200)
        field(20; "statusCode"; Integer) { }
        field(21; "trackId"; Text[100]) { }
        field(22; "cune"; Text[100]) { }
        field(23; "statusMessage"; Text[250]) { }
        field(24; "statusDescription"; Text[250]) { }
        field(25; "warnings"; Text[2048]) { }

        // Respuesta error (400, 401, 50X)
        field(30; "errorMessage"; Text[250]) { }
        field(31; "errorReason"; Text[250]) { }

        // Control
        field(40; "Response DateTime"; DateTime) { }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(SK1; "Numero")
        {
        }
    }
}