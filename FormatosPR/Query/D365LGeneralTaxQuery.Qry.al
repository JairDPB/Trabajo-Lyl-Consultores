query 60102 "D365L GeneralTaxQuery"
{
    QueryType = Normal;
    OrderBy = ascending(VATEntry_DianCode);

    elements
    {
        dataitem(LyL_GeneralTaxSIH_1; "VAT Entry")
        {
            column(Document_No; "Document No.") { }
            column(VATEntry_DianCode; "D365L PR VAT HACIENDA Code") { }
            column(VATEntry_tarifa; "D365L PR Tax Above Maximum COL") { }
            column(VATEntry_Amount; Amount)
            {
                Method = Sum;
            }
            dataitem(LYLOC_CO_DIAN_Setup; "D365L PR HACIENDA Setup")
            {
                DataItemLink = "HACIENDA Code" = LyL_GeneralTaxSIH_1."D365L PR VAT HACIENDA Code";
                DataItemTableFilter = "Table Code" = const('1005');
                column(VATEntry_DianDesc; Description) { }
            }
        }

    }
}
