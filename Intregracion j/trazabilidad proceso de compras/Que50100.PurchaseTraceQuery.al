query 50111 "Purchase Trace Query"
{
    QueryType = Normal;

    elements
    {
        dataitem(PurchLine; "Purchase Line")
        {
            DataItemTableFilter =
                "Document Type" = const(Order);

            column(OrderNo; "Document No.") {}
            column(LineNo; "Line No.") {}
            column(ItemNo; "No.") {}
            column(Description; Description) {}
            column(Quantity; Quantity) {}
            column(UnitCost; "Direct Unit Cost") {}
            column(LineAmount; "Line Amount") {}
            column(UOM; "Unit of Measure Code") {}
            column(Currency; "Currency Code") {}
        }
    }
}
