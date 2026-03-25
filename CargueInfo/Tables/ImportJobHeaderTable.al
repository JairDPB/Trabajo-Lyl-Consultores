table 50148 "D365L_Import Job Header"
{
    Caption = 'Import Job Header';
    DataClassification = ToBeClassified; 
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true; 
        }
        field(2; "Entity"; Option)
        {
            Caption = 'Entity';
            OptionMembers = Saldos,Proveedores,Clientes,Items;
            OptionCaption = 'Saldos financieros,Proveedores,Clientes,Items';
        }
        field(3; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = Pendiente,Validando,ConErrores,Validado,Procesado;
            OptionCaption = 'Pendiente,Validando,Con errores,Validado,Procesado';
        }
        field(4; "Import DateTime"; DateTime)
        {
            Caption = 'Import Date/Time';
        }
        field(5; "Imported By User"; Code[50])
        {
            Caption = 'Imported By User';
        }
        field(6; "Source File Name"; Text[250])
        {
            Caption = 'Source File Name';
        }
        field(7; "Gen. Jnl. Template"; Code[10])
        {
            Caption = 'Gen. Jnl. Template';
            TableRelation = "Gen. Journal Template";
        }
        field(8; "Gen. Jnl. Batch"; Code[10])
        {
            Caption = 'Gen. Jnl. Batch';
            TableRelation = "Gen. Journal Batch".Name
                WHERE("Journal Template Name" = FIELD("Gen. Jnl. Template"));
        }
        field(9; "Has Errors"; Boolean) { Caption = 'Has Errors'; }
        field(10; "Lines Count"; Integer) { Caption = 'Lines Count'; }
        field(11; "Valid Lines Count"; Integer) { Caption = 'Valid Lines Count'; }
        field(12; "Error Lines Count"; Integer) { Caption = 'Error Lines Count'; }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}