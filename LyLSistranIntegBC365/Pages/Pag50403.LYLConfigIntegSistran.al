page 50403 LYLConfigIntegSistran
{
    ApplicationArea = All;
    Caption = 'Configuración Integración CMS';
    PageType = Card;
    UsageCategory = Administration;
    SourceTable = LYLConfigIntegSistran;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(UrlServicio; Rec.UrlServicio)
                {
                    ApplicationArea = all;
                    Caption = 'Url';
                }
                field(KeyServicio; Rec.KeyServicio)
                {
                    ApplicationArea = all;
                    Caption = 'Key';
                }
            }
        }
    }
}
