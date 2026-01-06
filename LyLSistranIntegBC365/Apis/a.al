page 50410 "LLApiClientesTempMX"
{
    PageType = API;
    ApplicationArea = All;

    Caption = 'Transaccional de clientes';
    ODataKeyFields = SystemId;
    SourceTable = LLClientesAPItemp;
    UsageCategory = Administration;

    APIVersion = 'v1.0';
    APIPublisher = 'lylConsultores';
    APIGroup = 'sistranmx';
    EntityName = 'llclientesmx';
    EntitySetName = 'llclientesmx';
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
                field(codigoCiudad; Rec.CodigoCiudad)
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

        if Rec.NoDocumento = '' then
            Error('No documento no puede estar vacio');

        if StrLen(Rec.NoDocumento) < 5 then
            Error('No documento no puede contener menos de 5 caracteres númericos');

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
