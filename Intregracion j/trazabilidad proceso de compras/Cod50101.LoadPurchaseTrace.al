codeunit 50138 "Load Purchase Trace"
{
    // Cambiar de trigger OnRun() a un procedimiento que reciba el buffer
    procedure LoadData(var Buffer: Record "D365L Purchase Trace Buffer")
    var
        TraceQuery: Query "Purchase Trace Query";
        PurchHeader: Record "Purchase Header";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        PurchInvLine: Record "Purch. Inv. Line";
        PurchInvHeader: Record "Purch. Inv. Header";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        DimSetEntry: Record "Dimension Set Entry";
        EntryNo: Integer;
    begin
        // Limpia buffer temporal
        Buffer.Reset();
        Buffer.DeleteAll();
        EntryNo := 0;

        TraceQuery.Open();
        while TraceQuery.Read() do begin
            EntryNo += 1;

            Buffer.Init();
            Buffer."Entry No." := EntryNo;

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

                // DIMENSIONES
                DimSetEntry.Reset();
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
            // TRM
            // =========================
            if Buffer."Currency Code" <> '' then begin
                CurrencyExchangeRate.Reset();
                CurrencyExchangeRate.SetRange("Currency Code", Buffer."Currency Code");
                CurrencyExchangeRate.SetFilter("Starting Date", '<=%1', Buffer."Order Date");
                if CurrencyExchangeRate.FindLast() then
                    Buffer.TRM := CurrencyExchangeRate."Exchange Rate Amount";
            end else
                Buffer.TRM := 1;

            // =========================
            // RECEPCIÓN (opcional)
            // =========================
            PurchRcptLine.Reset();
            PurchRcptLine.SetRange("Order No.", Buffer."Order No.");
            PurchRcptLine.SetRange("Order Line No.", Buffer."Order Line No.");
            if PurchRcptLine.FindFirst() then begin
                Buffer."Receipt No." := PurchRcptLine."Document No.";
                Buffer."Receipt Date" := PurchRcptLine."Posting Date";
                Buffer."Received Quantity" := PurchRcptLine.Quantity;
            end;

            // =========================
            // FACTURA (opcional)
            // =========================
            PurchInvLine.Reset();
            PurchInvLine.SetRange("Order No.", Buffer."Order No.");
            PurchInvLine.SetRange("Order Line No.", Buffer."Order Line No.");
            if PurchInvLine.FindFirst() then begin
                Buffer."Invoice No." := PurchInvLine."Document No.";
                Buffer."Invoice Date" := PurchInvLine."Posting Date";
                Buffer."Invoiced Quantity" := PurchInvLine.Quantity;
                Buffer."Invoice Unit Cost" := PurchInvLine."Direct Unit Cost";
                Buffer."Invoice Line Amount" := PurchInvLine.Amount;

                if PurchInvHeader.Get(Buffer."Invoice No.") then
                    Buffer."Vendor Invoice No." := PurchInvHeader."Vendor Invoice No.";
            end;

            Buffer.Insert();
        end;

        TraceQuery.Close();
        
        // Posicionar en el primer registro
        if Buffer.FindFirst() then;
    end;
}