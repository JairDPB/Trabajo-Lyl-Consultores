page 50120 "D365L Purchase Trace API"
{
    PageType = API;
    SourceTable = "D365L Purchase Trace Buffer";
    DelayedInsert = true;

    APIPublisher = 'd365l';
    APIGroup = 'purchasetrace';
    APIVersion = 'v1.0';

    EntityName = 'purchaseTrace';
    EntitySetName = 'purchaseTraces';

    ODataKeyFields = "Entry No.";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                // ===== SOLICITUD / PEDIDO =====
                field(entryNo; Rec."Entry No.") { }
                field(orderNo; Rec."Order No.") { }
                field(orderDate; Rec."Order Date") { }
                field(orderApprovalDate; Rec."Order Approval Date") { }
                field(expectedReceiptDate; Rec."Expected Receipt Date") { }
                field(orderCreatedBy; Rec."Order Created By") { }
                field(buyerCode; Rec."Buyer Code") { }
                field(status; Rec.Status) { }

                // ===== PROVEEDOR =====
                field(vendorNo; Rec."Vendor No.") { }
                field(vendorName; Rec."Vendor Name") { }

                // ===== LÍNEA DE PEDIDO =====
                field(orderLineNo; Rec."Order Line No.") { }
                field(itemNo; Rec."Order Item No.") { }
                field(description; Rec."Order Description") { }

                // ===== MONEDA =====
                field(currencyCode; Rec."Currency Code") { }
                field(trm; Rec.TRM) { }

                // ===== CANTIDADES Y VALORES =====
                field(quantity; Rec."Order Quantity") { }
                field(unitOfMeasure; Rec."Unit of Measure") { }
                field(unitCost; Rec."Order Unit Cost") { }
                field(lineAmount; Rec."Order Line Amount") { }

                // ===== DIMENSIONES =====
                field(dim1; Rec."Dim 1") { }
                field(dim2; Rec."Dim 2") { }
                field(dim3; Rec."Dim 3") { }
                field(dim4; Rec."Dim 4") { }
                field(dim5; Rec."Dim 5") { }
                field(dim6; Rec."Dim 6") { }
                field(dim7; Rec."Dim 7") { }
                field(dim8; Rec."Dim 8") { }

                // ===== RECEPCIÓN =====
                field(receiptNo; Rec."Receipt No.") { }
                field(receiptDate; Rec."Receipt Date") { }
                field(receivedQuantity; Rec."Received Quantity") { }

                // ===== FACTURA =====
                field(invoiceNo; Rec."Invoice No.") { }
                field(vendorInvoiceNo; Rec."Vendor Invoice No.") { }
                field(invoiceDate; Rec."Invoice Date") { }

                field(invoiceItemNo; Rec."Invoice Item No.") { }
                field(invoiceDescription; Rec."Invoice Description") { }
                field(invoicedQuantity; Rec."Invoiced Quantity") { }
                field(invoiceUnitCost; Rec."Invoice Unit Cost") { }
                field(invoiceLineAmount; Rec."Invoice Line Amount") { }
            }
        }
    }
}
