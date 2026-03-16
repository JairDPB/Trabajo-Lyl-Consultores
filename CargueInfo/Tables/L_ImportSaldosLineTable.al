table 50101 "D365L_Import Saldos Line"

{

    Caption = 'Import Saldos Line';
    DataClassification = ToBeClassified; 
    fields
    {
        field(1; "Job Entry No."; Integer)
        {
            Caption = 'Job Entry No.';
            TableRelation = "D365L_Import Job Header"."Entry No.";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(10; "Excel Line No."; Integer)
        {
            Caption = 'Excel Line No.';
        }
        field(11; "Posting Date"; Date)
        {
            Caption = 'Fecha registro';
        }
        field(12; "G/L Account No."; Code[20])
        {
            Caption = 'Nº cuenta';
            TableRelation = "G/L Account";
        }
        field(13; "Document No."; Code[20])
        {
            Caption = 'Nº documento';
        }
        field(14; Description; Text[100])
        {
            Caption = 'Descripción';
        }
        field(15; Amount; Decimal)
        {
            Caption = 'Importe';
        }
        field(16; "NIT"; Code[20])
        {
            Caption = 'NIT';
        }
        // Dimensiones
        field(30; "Dimension 1 Code"; Code[20]) { Caption = 'Dimension 1'; }
        field(31; "Dimension 2 Code"; Code[20]) { Caption = 'Dimension 2'; }
        field(32; "Dimension 3 Code"; Code[20]) { Caption = 'Dimension 3'; }
        field(33; "Dimension 4 Code"; Code[20]) { Caption = 'Dimension 4'; }
        field(34; "Dimension 5 Code"; Code[20]) { Caption = 'Dimension 5'; }
        field(35; "Dimension 6 Code"; Code[20]) { Caption = 'Dimension 6'; }
        field(36; "Dimension 7 Code"; Code[20]) { Caption = 'Dimension 7'; }
        field(37; "Dimension 8 Code"; Code[20]) { Caption = 'Dimension 8'; }
        // Estado / errores
        field(80; "Line Status"; Option)
        {
            Caption = 'Line Status';
            OptionMembers = Pendiente,Valida,Error,Procesada;
            OptionCaption = 'Pendiente,Válida,Error,Procesada';
        }
        field(81; "Technical Errors JSON"; Blob)
        {
            Caption = 'Errores técnicos (JSON)';
            SubType = Memo;
        }
        field(82; "User Message"; Text[250])
        {
            Caption = 'Mensaje usuario';
        }
        field(83; "Last Validation DateTime"; DateTime)
        {
            Caption = 'Last Validation Date/Time';
        }

    }
    keys

    {
        key(PK; "Job Entry No.", "Line No.")
        {
            Clustered = true;
        }
    }

}