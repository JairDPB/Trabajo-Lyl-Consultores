page 50402 LLApiFacturasLineasTemp
{
    PageType = ListPart;
    UsageCategory = Administration;
    SourceTable = LLLineasFacturaAPItemp;
    DelayedInsert = true;
    //AutoSplitKey = true;
    PopulateAllFields = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(lines)
            {
                field(NoLinea; Rec.NoLinea)
                {
                    ApplicationArea = All;
                }
                field(TipoProducto; Rec.TipoProducto)
                {
                    ApplicationArea = All;
                }
                field(NoProducto; Rec.NoProducto)
                {
                    ApplicationArea = All;
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                }
                field(Cantidad; Rec.Cantidad)
                {
                    ApplicationArea = All;
                }
                field(ValorUnitario; Rec.ValorUnitario)
                {
                    ApplicationArea = All;
                }
                field(CentroCosto; Rec.CentroCosto)
                {
                    ApplicationArea = All;
                }
                field(noDocumento; Rec.HeaderNo)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        IsDeepInsert: Boolean;

    trigger OnInsertRecord(BelowXRec: Boolean): Boolean
    var
        Header: Record LLFacturaAPItemp;
        Lines: Record LLLineasFacturaAPItemp;
        Tipo: Enum "Sales Line Type";
        Cuentas: Record "G/L Account";
        Impuestos: Record "Tax Group";
        Dimesion: Record "Dimension Value";
        NewDimesion: Record "Dimension Value";
        DefaultDimension: Record "Default Dimension";
        NewDefaultDimension: Record "Default Dimension";
        DDPT: Enum "Default Dimension Parent Type";
        Item: Record Item;
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        //validacion de campos
        if REc.HeaderNo = '' then
            Error('No documento no puede estar vacío');

        if Rec.NoProducto = '' then begin
            Error('El Producto no puede ser vacio');
        end else begin
            Clear(Item);
            Item.SetFilter("No.", Rec.NoProducto);

            if not Item.FindFirst() then
                Error('El Producto no existe');
        end;

        if Format(Rec.Cantidad) = '' then begin
            Error('La cantidad no puede estar vacia');
        end/* else begin
            if (Rec.Cantidad < 1) or (Rec.Cantidad > 1) then
                Error('La cantidad debe ser 1');
        end*/;

        if Format(REc.ValorUnitario) = '' then begin
            Error('El Valor no puede estar vacío');
        end else begin
            if Rec.ValorUnitario < 0 then
                Error('El Valor debe ser mayor/igual a 0');
        end;

        // if Rec.GrupoImpuestos = '' then begin
        //     Error('El grupo impuestos no puede estar vacío');
        // end else begin
        //     Clear(Impuestos);
        //     Impuestos.SetFilter("Code", Rec.GrupoImpuestos);

        //     if not Impuestos.FindFirst() then
        //         Error('El grupo de impuestos no existe');
        // end;
        GeneralLedgerSetup.Get();
        if Rec.CentroCosto = '' then begin
            Error('Centro de costos no puede estar vacío');
        end else begin
            Clear(Dimesion);
            Dimesion.SetRange("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 1 Code");
            Dimesion.SetFilter("Code", Rec.CentroCosto);

            if not Dimesion.FindFirst() then
                Error('El centro de costos no existe');
        end;
    end;

    trigger OnNewRecord(BelowXRec: Boolean)
    var
        Header: Record LLFacturaAPItemp;
    begin
        IsDeepInsert := IsNullGuid(Rec.HeaderId);
        if not IsDeepInsert then begin
            Header.GetBySystemId(Rec.HeaderId);
            Rec.HeaderNo := Header.NoOrdenFacturacion;
        end;
    end;
}