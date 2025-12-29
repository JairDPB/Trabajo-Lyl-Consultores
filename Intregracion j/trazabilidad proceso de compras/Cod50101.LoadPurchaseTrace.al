codeunit 50138 "Load Purchase Trace"
{
    trigger OnRun()
    var
        TraceQuery: Query "Purchase Trace Query";
        Buffer: Record "D365L Purchase Trace Buffer";

        PurchHeader: Record "Purchase Header";
        PurchInvHeader: Record "Purch. Inv. Header";

        CurrencyExchangeRate: Record "Currency Exchange Rate";
        DimSetEntry: Record "Dimension Set Entry";
    begin
        Buffer.Reset();
        Buffer.DeleteAll();
        COMMIT;

        TraceQuery.Open();
        while TraceQuery.Read() do begin
            Clear(Buffer);
            Buffer.Init();

            // =========================
            // PEDIDO - LÍNEA
            // =========================
            Buffer."Order No." := TraceQuery.OrderNo;
            Buffer."Order Line No." := TraceQuery.LineNo;
            Buffer."Order Item No." := TraceQuery.ItemNo;
            Buffer."Order Description" := TraceQuery.Description;
            Buffer."Order Quantity" := TraceQuery.Quantity;
            Buffer."Order Unit Cost" := TraceQuery.UnitCost;
            Buffer."Order Line Amount" := TraceQuery.LineAmount;
            Buffer."Unit of Measure" := TraceQuery.UOM;
            Buffer."Currency Code" := TraceQuery.Currency;

            // =========================
            // PEDIDO - HEADER
            // =========================
            if PurchHeader.Get(PurchHeader."Document Type"::Order, Buffer."Order No.") then begin
                Buffer."Order Date" := PurchHeader."Order Date";
                Buffer."Expected Receipt Date" := PurchHeader."Expected Receipt Date";
                Buffer."Buyer Code" := PurchHeader."Purchaser Code";
                Buffer.Status := Format(PurchHeader.Status);
                Buffer."Vendor No." := PurchHeader."Buy-from Vendor No.";
                Buffer."Vendor Name" := PurchHeader."Buy-from Vendor Name";
                Buffer."Order Created By" := PurchHeader."Assigned User ID";
                

                // =========================
                // DIMENSIONES (1–8)
                // =========================
                DimSetEntry.SetRange("Dimension Set ID", PurchHeader."Dimension Set ID");
                if DimSetEntry.FindSet() then
                    repeat
                        case DimSetEntry."Dimension Code" of
                            'DIM1': Buffer."Dim 1" := DimSetEntry."Dimension Value Code";
                            'DIM2': Buffer."Dim 2" := DimSetEntry."Dimension Value Code";
                            'DIM3': Buffer."Dim 3" := DimSetEntry."Dimension Value Code";
                            'DIM4': Buffer."Dim 4" := DimSetEntry."Dimension Value Code";
                            'DIM5': Buffer."Dim 5" := DimSetEntry."Dimension Value Code";
                            'DIM6': Buffer."Dim 6" := DimSetEntry."Dimension Value Code";
                            'DIM7': Buffer."Dim 7" := DimSetEntry."Dimension Value Code";
                            'DIM8': Buffer."Dim 8" := DimSetEntry."Dimension Value Code";
                        end;
                    until DimSetEntry.Next() = 0;
            end;

            // =========================
            // TRM (Tasa de cambio)
            // =========================
            if Buffer."Currency Code" <> '' then begin
                CurrencyExchangeRate.SetRange("Currency Code", Buffer."Currency Code");
                CurrencyExchangeRate.SetFilter("Starting Date", '<=%1', Buffer."Order Date");
                if CurrencyExchangeRate.FindLast() then
                    Buffer.TRM := CurrencyExchangeRate."Exchange Rate Amount";
            end else
                Buffer.TRM := 1;

            // =========================
            // RECEPCIÓN
            // =========================
            Buffer."Receipt No." := TraceQuery.ReceiptNo;
            Buffer."Receipt Date" := TraceQuery.ReceiptDate;
            Buffer."Received Quantity" := TraceQuery.ReceivedQty;

            // =========================
            // FACTURA - LÍNEA
            // =========================
            Buffer."Invoice No." := TraceQuery.InvoiceNo;
            Buffer."Invoice Date" := TraceQuery.InvoiceDate;
            Buffer."Invoice Item No." := TraceQuery.ItemNo; 
            Buffer."Invoice Description" := TraceQuery.Description;
            Buffer."Invoiced Quantity" := TraceQuery.InvQty;
            Buffer."Invoice Unit Cost" := TraceQuery.InvUnitCost;
            Buffer."Invoice Line Amount" := TraceQuery.InvAmount;

            // =========================
            // FACTURA - HEADER
            // =========================
            if Buffer."Invoice No." <> '' then
                if PurchInvHeader.Get(Buffer."Invoice No.") then
                    Buffer."Vendor Invoice No." := PurchInvHeader."Vendor Invoice No.";

            Buffer.Insert();
        end;

        TraceQuery.Close();
    end;
}
