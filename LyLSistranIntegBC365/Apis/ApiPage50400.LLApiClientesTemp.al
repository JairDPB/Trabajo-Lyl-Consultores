page 50400 "LLApiClientesTemp"
{
    PageType = API;
    ApplicationArea = All;

    Caption = 'Transaccional de clientes';
    ODataKeyFields = SystemId;
    SourceTable = LLClientesAPItemp;
    UsageCategory = Administration;

    APIVersion = 'v1.0';
    APIPublisher = 'lylConsultores';
    APIGroup = 'sistran';
    EntityName = 'llclientes';
    EntitySetName = 'llclientes';
    Extensible = false;
    DelayedInsert = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(SystemId; Rec.SystemId)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(tipoDocumento; Rec.TipoDocumento)
                {
                    ApplicationArea = All;
                }
                field(noDocumento; Rec.NoDocumento)
                {
                    ApplicationArea = All;
                }
                field(tipoEntidad; Rec.TipoEntidad)
                {
                    ApplicationArea = All;
                }

                field(primerNombre; Rec.PrimerNombre)
                {
                    ApplicationArea = All;
                }
                field(segundoNombre; Rec.SegundoNombre)
                {
                    ApplicationArea = All;
                }
                field(primerApellido; Rec.PrimerApellido)
                {
                    ApplicationArea = All;
                }
                field(segundoApellido; Rec.SegundoApellido)
                {
                    ApplicationArea = All;
                }
                field(razonSocial; Rec.RazonSocial)
                {
                    ApplicationArea = All;
                }
                field(email; Rec.Email)
                {
                    ApplicationArea = All;
                }
                field(direccion; Rec.Direccion)
                {
                    ApplicationArea = All;
                }
                field(CodigoCiudad; Rec.CodigoCiudad)
                {
                    ApplicationArea = All;
                }
                field(telefono; Rec.Telefono)
                {
                    ApplicationArea = All;
                }
                field(pais; Rec.Pais)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        Customer: Record Customer;
        // Dian: Record "G2LCO_DIAN Setup";
        Pais: Record "Country/Region";
        Codigo: Record "Post Code";
        Metodo: Record "Payment Method";
    begin
        Clear(Customer);
        Rec.Status := true;

        Customer.SetFilter("No.", Rec.NoDocumento);

        if Customer.FindFirst() then begin
            Rec.StatusMessage := Rec.StatusMessage::"El cliente ya se encuentra registrado";
        end else begin
            Rec.StatusMessage := Rec.StatusMessage::"Registrado Correctamente";
        end;

        /*  if Rec.TipoEntidad = '' then begin
              Error('Tipo entidad no puede estar vacio');
          end else begin
              Clear(Dian);
              Dian.SetRange("Table Code", '1002');
              Dian.SetFilter("DIAN Code", Rec.TipoEntidad);

              if not Dian.FindFirst() then
                  Error('Tipo entidad no puede ser diferente de 1 (natural) o 2 (juridica)');
          end;*/

        /*  if Rec.TipoDocumento = '' then begin
              Error('Tipo documento no puede estar vacio');
          end else begin
              Clear(Dian);
              Dian.SetRange("Table Code", '1003');
              Dian.SetFilter("DIAN Code", Rec.TipoDocumento);

              if not Dian.FindFirst() then
                  Error('Tipo documento no puede ser diferente de 12, 13, 21, 22, 31, 41, 42, 50, 91')
          end;*/

        if Rec.NoDocumento = '' then
            Error('No documento no puede estar vacio');

        if StrLen(Rec.NoDocumento) < 5 then
            Error('No documento no puede contener menos de 5 caracteres númericos');

        if Rec.TipoEntidad = '1' then begin
            begin
                if Rec.PrimerNombre = '' then
                    Error('El primer nombre no pueden estar vacio');

                if Rec.PrimerApellido = '' then
                    Error('El primer apellido no pueden estar vacio');
            end;

        end;

        if Rec.TipoEntidad = '2' then begin
            if Rec.RazonSocial = '' then
                Error('El nombre de la empresa no puede estar vacio');
        end;

        if Rec.Email = '' then
            Error('Email no puede estar vacio');

        if Rec.Direccion = '' then
            Error('Dirección no puede estar vacio');

        if Rec.Pais = '' then begin
            Error('Código pais no puede estar vacio');
        end else begin
            Clear(Pais);
            Pais.SetFilter(Code, Rec.Pais);
            if not Pais.FindFirst() then
                Error('Código pais es incorrecto');
        end;
    end;
}
