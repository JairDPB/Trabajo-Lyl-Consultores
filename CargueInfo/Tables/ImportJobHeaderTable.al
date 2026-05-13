table 50148 "D365L_Import Job Header"
{
    Caption = 'Import Job Header';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'N.º de entrada';
            AutoIncrement = true;
        }

        field(2; "Entity"; Option)
        {
            Caption = 'Entidad';
            OptionMembers = Saldos,Proveedores,Clientes,Items;
            OptionCaption = 'Saldos financieros,Proveedores,Clientes,Items';
        }

        field(3; "Status"; Option)
        {
            Caption = 'Estado';
            OptionMembers = Pendiente,Validando,ConErrores,Validado,Procesado;
            OptionCaption = 'Pendiente,Validando,Con errores,Validado,Procesado';
        }

        field(4; "Import DateTime"; DateTime)
        {
            Caption = 'Fecha y hora de importación';
        }

        field(5; "Imported By User"; Code[50])
        {
            Caption = 'Importado por usuario';
        }

        field(6; "Source File Name"; Text[250])
        {
            Caption = 'Nombre del archivo origen';
        }

        field(7; "Gen. Jnl. Template"; Code[10])
        {
            Caption = 'Plantilla diario general';
            TableRelation = "Gen. Journal Template";
        }

        field(8; "Gen. Jnl. Batch"; Code[10])
        {
            Caption = 'Lote diario general';
            TableRelation = "Gen. Journal Batch".Name
        WHERE("Journal Template Name" = FIELD("Gen. Jnl. Template"));
        }

        field(9; "Has Errors"; Boolean)
        {
            Caption = 'Tiene errores';
        }

        field(10; "Lines Count"; Integer)
        {
            Caption = 'Cantidad de líneas';
        }

        field(11; "Valid Lines Count"; Integer)
        {
            Caption = 'Cantidad de líneas válidas';
        }

        field(12; "Error Lines Count"; Integer)
        {
            Caption = 'Cantidad de líneas con error';
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