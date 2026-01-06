page 50409 LYLIntegSistranAPITempMX
{
    ApplicationArea = All;
    Caption = 'LL Integ CMS API TEMP MX';
    PageType = List;
    SourceTable = LLFacturaAPItempMX;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Concepto; Rec.Concepto)
                {
                    ToolTip = 'Specifies the value of the Concepto field.';
                }
                field(Divisa; Rec.Divisa)
                {
                    ToolTip = 'Specifies the value of the Divisa field.';
                }
                field(DocumentoRerencia; Rec.DocumentoRerencia)
                {
                    ToolTip = 'Specifies the value of the DocumentoRerencia field.';
                }
                field(Fecha; Rec.Fecha)
                {
                    ToolTip = 'Specifies the value of the Fecha field.';
                }
                field(NoDocumentoCliente; Rec.NoDocumentoCliente)
                {
                    ToolTip = 'Specifies the value of the NoDocumentoCliente field.';
                }
                field(NoOrdenFacturacion; Rec.NoOrdenFacturacion)
                {
                    ToolTip = 'Specifies the value of the NoOrdenFacturacion field.';
                }
                field(TRM; Rec.TRM)
                {
                    ToolTip = 'Specifies the value of the TRM field.';
                }
                field(TipoDocumento; Rec.TipoDocumento)
                {
                    ToolTip = 'Specifies the value of the TipoDocumento field.';
                }
            }
        }
    }
}
