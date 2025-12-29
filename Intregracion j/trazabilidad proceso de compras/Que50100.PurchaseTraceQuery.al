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

            dataitem(RcptLine; "Purch. Rcpt. Line")
            {
                DataItemLink =
                    "Order No." = PurchLine."Document No.",
                    "Order Line No." = PurchLine."Line No.";

                column(ReceiptNo; "Document No.") {}
                column(ReceiptDate; "Posting Date") {}
                column(ReceivedQty; Quantity) {}

                dataitem(InvLine; "Purch. Inv. Line")
                {
                    DataItemLink =
                        "Receipt No." = RcptLine."Document No.",
                        "Receipt Line No." = RcptLine."Line No.";

                    column(InvoiceNo; "Document No.") {}
                    column(InvoiceDate; "Posting Date") {}
                    column(InvQty; Quantity) {}
                    column(InvUnitCost; "Direct Unit Cost") {}
                    column(InvAmount; Amount) {}
                }
            }
        }
    }
}
