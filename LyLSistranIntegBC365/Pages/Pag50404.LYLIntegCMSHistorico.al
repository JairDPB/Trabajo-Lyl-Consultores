page 50404 LYLIntegCMSHistorico
{
    ApplicationArea = All;
    Caption = 'CMS Histórico de Envíos';
    PageType = List;
    SourceTable = LYLIntegCMS;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the value of the ID field.';
                    ApplicationArea = all;
                }
                field(Nodocumento; Rec.Nodocumento)
                {
                    ToolTip = 'Specifies the value of the Nodocumento field.';
                    ApplicationArea = all;
                }
                field(NoFacturaContable; Rec.NoFacturaContable)
                {
                    ToolTip = 'Specifies the value of the NoFacturaContable field.';
                    ApplicationArea = all;
                }
                field(FechaRC; Rec.FechaRC)
                {
                    ToolTip = 'Specifies the value of the FechaRC field.';
                    ApplicationArea = all;
                }
                field(FechaRegistro; Rec.FechaRegistro)
                {
                    ToolTip = 'Specifies the value of the FechaRegistro field.';
                    ApplicationArea = all;
                }
                field(FechaVencimiento; Rec.FechaVencimiento)
                {
                    ToolTip = 'Specifies the value of the FechaVencimiento field.';
                    ApplicationArea = all;
                }
                field(NitCliente; Rec.NitCliente)
                {
                    ToolTip = 'Specifies the value of the NitCliente field.';
                    ApplicationArea = all;
                }
                field(Tipo; Rec.Tipo)
                {
                    ToolTip = 'Specifies the value of the Tipo field.';
                    ApplicationArea = all;
                }
                field(RespuestaCMS; Rec.RespuestaCMS)
                {
                    ToolTip = 'Specifies the value of the RespuestaCMS field.';
                    ApplicationArea = all;
                }
            }
        }
    }
}
