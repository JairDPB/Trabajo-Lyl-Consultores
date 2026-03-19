reportextension 88103 "D365L CajaMenorM" extends "D365L Caja Menor"
{
    dataset
    {}

    requestpage
    {}

    rendering
    {
        layout(D365LCajaMenorM)
        {
            Type = RDLC;
            LayoutFile = 'Report/D365LCajaMenorM.rdl';
        }
    }
}