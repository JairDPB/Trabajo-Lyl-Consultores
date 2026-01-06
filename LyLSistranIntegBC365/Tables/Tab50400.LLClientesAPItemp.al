table 50400 "LLClientesAPItemp"
{
    Caption = 'Temporal Clientes';
    DataPerCompany = true;

    fields
    {
        field(1; No; Integer)
        {
            Description = 'No.';
            AutoIncrement = true;
        }

        field(2; TipoDocumento; Code[2])
        {
            Description = 'Tipo de Documento';
        }

        field(3; NoDocumento; Code[20])
        {
            Description = 'NO. Registro';
        }

        field(4; TipoEntidad; Code[1])
        {
            Description = 'Codigo Postal';
        }
        field(5; SegundoApellido; Text[42])
        {
            Description = 'Segundo Apellido';
        }
        field(6; PrimerApellido; Text[42])
        {
            Description = 'Primer Apellido';
        }
        field(7; PrimerNombre; Text[50])
        {
            Description = 'Primer Nombre';
        }
        field(8; SegundoNombre; Text[50])
        {
            Description = 'Segundo nombre';
        }

        field(9; RazonSocial; Text[100])
        {
            Description = 'Razon Social';
        }
        field(10; Email; Text[70])
        {
            Description = 'Correo Electrónico';
        }
        field(11; Direccion; Text[200])
        {
            Description = 'Direccion';
        }
        field(12; Telefono; Text[10])
        {
            Description = 'Teléfono';
        }
        field(13; Pais; Code[2])
        {
            Description = 'Pais';
        }
        field(15; MetodoPago; Code[10])
        {
            Description = 'Metodo de pago';
        }
        field(16; Status; Boolean)
        {
            InitValue = false;
        }
        field(17; StatusMessage; Option)
        {
            OptionMembers = "Sin procesar","Registrado Correctamente","Ocurrio error al registrar","El cliente ya se encuentra registrado";
        }
        field(18; CodigoCiudad; Code[5])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PrimaryKey; NoDocumento)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        Customer: Record Customer;
        TempCustomer: Record Customer;
        CU: Codeunit LLCUIntegracion;
    begin
        Clear(TempCustomer);
        TempCustomer.SetFilter("VAT Registration No.", Rec.NoDocumento);

        if not TempCustomer.FindFirst() then begin//si no existe cliente inserta
            CU.InsertNewCustomer(Rec);
        end else begin //si el cliente existe lo actualiza
            CU.UpdateCustomerExist(Rec);
            CU.UpdateCustomerDimension(Rec);
        end;

    end;
}