///<summary>
///Consulta de la tabla de impuestos
///</summary>
query 50112 "D365L GeneralTaxQuery"
{
    QueryType = Normal;
    OrderBy = ascending(VATEntry_DianCode);

    elements
    {
        dataitem(LyL_GeneralTaxSIH_1; "VAT Entry")
        {
            column(Document_No; "Document No.") { }
            column(VATEntry_DianCode; "d365l co VAT DIAN Code") { }
            column(VATEntry_tarifa; "D365L CO Tax Above Maximum COL") { }
            column(VATEntry_Amount; Amount)
            {
                //Method = Sum;
            }
            dataitem(LYLOC_CO_DIAN_Setup; "D365L CO DIAN Setup")
            {
                DataItemLink = "DIAN Code" = LyL_GeneralTaxSIH_1."D365L CO VAT DIAN Code";
                DataItemTableFilter = "Table Code" = const('1005');
                column(VATEntry_DianDesc; Description) { }
            }
        }

    }
}
