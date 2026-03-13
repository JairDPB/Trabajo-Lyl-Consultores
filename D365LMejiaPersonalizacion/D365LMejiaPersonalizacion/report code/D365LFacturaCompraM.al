reportextension 88102 "D365L PurchInvoiceExt" extends "D365L FacturaCompra"
{
    dataset
    {}

    requestpage
    {}

    rendering
    {
        layout(D365LFacturaCompraM)
        {
            Type = RDLC;
            LayoutFile = 'Report/D365LFacturaCompraM.rdl';
        }
    }
    var
        NoOrden: Text;
        Presupuesto: Text;
        ThirdNo1: text;
        ThirdNo2: text;
        CustomerEmail: text;
        CustomerAddress: text;
        CustomerPhone: text;
        CustomerNit: text;
}