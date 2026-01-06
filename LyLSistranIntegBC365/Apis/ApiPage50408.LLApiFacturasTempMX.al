page 50408 LLApiFacturasTempMX
{
    PageType = API;
    APIVersion = 'v1.0';
    APIPublisher = 'lylConsultores';
    APIGroup = 'sistranmx';
    EntityName = 'llfacturamx';
    EntitySetName = 'llfacturamx';
    SourceTable = LLFacturaAPItempMX;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(SystemId; Rec.SystemId)
                {
                    ApplicationArea = all;
                }
                field(TipoDocumento; Rec.TipoDocumento)
                {
                    ApplicationArea = all;
                }
                field(NoOrdenFacturacion; Rec.NoOrdenFacturacion)
                {
                    ApplicationArea = all;
                }
                field(NoDocumentoCliente; Rec.NoDocumentoCliente)
                {
                    ApplicationArea = all;
                }
                field(Fecha; Rec.Fecha)
                {
                    ApplicationArea = All;
                }
                field(Divisa; Rec.Divisa)
                {
                    ApplicationArea = All;
                }
                field(TRM; Rec.TRM)
                {
                    ApplicationArea = All;
                }
                field(Concepto; Rec.Concepto)
                {
                    ApplicationArea = All;
                }
                field(DocumentoRerencia; Rec.DocumentoRerencia)
                {
                    ApplicationArea = All;
                }
                field(EsCancelacion; Rec.EsCancelacion)
                {
                    ApplicationArea = All;
                }
                part(lines; LLApiFacturasLineasTempMX)
                {
                    EntityName = 'lines';
                    EntitySetName = 'lines';
                    SubPageLink = HeaderId = field(SystemId);
                }
            }
        }
    }



    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        Tipo: Enum "Sales Document Type";
        Clientes: Record Customer;
        Vendedores: Record "Salesperson/Purchaser";
        Impuestos: Record "Tax Area";
        TipoTrans: Record "LYLOC_CO DIAN Setup";
        TipoDocRef: Enum "Gen. Journal Document Type";
        ConfCont: Record "General Ledger Setup";
        SH: Record "Sales Header";
        SIH: Record "Sales Invoice Header";
        SalesDocumentType: Enum "Sales Document Type";
    begin
        //validacion de campos
        Clear(SH);
        Clear(SIH);
        SH.SetFilter("No.", Rec.NoOrdenFacturacion);
        if Rec.TipoDocumento = SalesDocumentType::"Credit Memo" then begin
            SH.SetRange("Document Type", Rec.TipoDocumento::"Credit Memo");
        end else
            SH.SetRange("Document Type", Rec.TipoDocumento::Invoice);

        if SH.FindFirst() then
            Error('Error, la factura No. ' + Rec.NoOrdenFacturacion + 'ya esta creado como borrador.');

        SIH.SetFilter("No.", Rec.NoOrdenFacturacion);
        if SIH.FindFirst() then
            Error('Error, la factura No. ' + Rec.NoOrdenFacturacion + 'ya esta creada.');

        if (Rec.TipoDocumento <> Tipo::Invoice) and (Rec.TipoDocumento <> Tipo::"Credit Memo") then begin
            Error('EL tipo documento no puede estar vacío o ser diferente a una Invoice, Credit Memo');
        end;

        if Rec.NoOrdenFacturacion = '' then
            Error('El No. no puede estar vacío');

        if Rec.NoDocumentoCliente = '' then begin
            Error('El No documento del cliente no puede estar vacío');
        end else begin
            Clear(Clientes);
            Clientes.SetFilter("VAT Registration No.", Rec.NoDocumentoCliente);

            if not Clientes.FindFirst() then
                Error('El clinte no existe');
        end;

        if Rec.Fecha = 0D then
            Error('Fecha no puede estar vacia');

        if Rec.TipoDocumento = SalesDocumentType::"Credit Memo" then begin
            if Rec.DocumentoRerencia = '' then
                Error('El documento de referencia no puede estar vacío');
        end;
    end;
}