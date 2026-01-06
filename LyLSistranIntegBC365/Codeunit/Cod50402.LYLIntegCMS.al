codeunit 50402 LYLIntegCMS
{
    Permissions = tabledata "Sales Invoice Header" = rm, tabledata LYLIntegCMS = rmdi;

    procedure changeStatusCMS(var Rec: Record "Sales Invoice Header")
    var
        myInt: Integer;
    begin
        Rec.LYLCMS_status := 1;
        Rec.Modify();
    end;

    procedure EnviaCMSManual(Rec: Record "Sales Invoice Header")
    var
        LYLIntegCMS: Record LYLIntegCMS;
        Customer: Record Customer;
        lastId: Integer;
    begin
        lastId := 1;
        if LYLIntegCMS.FindLast() then
            lastId := LYLIntegCMS.ID + 1;
        lastId := LYLIntegCMS.ID + 1;
        Clear(LYLIntegCMS);

        Customer.get(Rec."Bill-to Customer No.");
        LYLIntegCMS.Init();
        LYLIntegCMS.ID += lastId;
        LYLIntegCMS.Nodocumento := Rec."Pre-Assigned No.";
        LYLIntegCMS.NitCliente := Customer."VAT Registration No.";
        LYLIntegCMS.NoFacturaContable := Rec."No.";
        LYLIntegCMS.FechaRegistro := Rec."Posting Date";
        LYLIntegCMS.FechaVencimiento := Rec."Due Date";
        LYLIntegCMS.Tipo := 1;
        LYLIntegCMS.Insert(true);
    end;

    procedure EnviarCMSPagoTotal(NoFactura: code[20])
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        LYLIntegCMS: Record LYLIntegCMS;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        Customer: Record Customer;
        DtldCVLedgEntryType: Enum "Detailed CV Ledger Entry Type";
        lastId: Integer;
    begin
        lastId := 1;
        if LYLIntegCMS.FindLast() then
            lastId := LYLIntegCMS.ID + 1;
        lastId := LYLIntegCMS.ID + 1;
        Clear(LYLIntegCMS);

        CustLedgerEntry.SetFilter("Document No.", NoFactura);
        if CustLedgerEntry.FindFirst() then begin
            DetailedCustLedgEntry.SetFilter("Cust. Ledger Entry No.", '%1', CustLedgerEntry."Entry No.");
            DetailedCustLedgEntry.CalcSums(Amount);
            if DetailedCustLedgEntry.Amount = 0 then begin
                SalesInvoiceHeader.SetFilter("No.", NoFactura);
                if SalesInvoiceHeader.FindFirst() then begin
                    Customer.get(SalesInvoiceHeader."Bill-to Customer No.");

                    clear(DetailedCustLedgEntry);
                    DetailedCustLedgEntry.SetFilter("Cust. Ledger Entry No.", '%1', CustLedgerEntry."Entry No.");
                    DetailedCustLedgEntry.SetFilter("Entry Type", '<>%1', DtldCVLedgEntryType::"Initial Entry");
                    if DetailedCustLedgEntry.FindSet() then
                        repeat
                            LYLIntegCMS.Init();
                            LYLIntegCMS.ID := lastId;
                            LYLIntegCMS.FechaRC := DetailedCustLedgEntry."Posting Date";
                            LYLIntegCMS.Nodocumento := DetailedCustLedgEntry."Document No.";
                            LYLIntegCMS.NitCliente := Customer."VAT Registration No.";
                            LYLIntegCMS.NoFacturaContable := SalesInvoiceHeader."No.";
                            LYLIntegCMS.Tipo := 2;
                            LYLIntegCMS.Insert();
                            lastId += 1;
                        until DetailedCustLedgEntry.Next() = 0;
                    EnviaPago(SalesInvoiceHeader."No.");
                end;
            end else begin

            end;
        end;
    end;

    local procedure EnviaPago(noFactura: Code[20])
    var
        texto: text;
        LYLEnviarCMS: Codeunit LYLEnviarCMS;
        LYLIntegCMS: Record LYLIntegCMS;
        RespuestaCMS: text;
        EstatusCMS: text;
    begin
        LYLIntegCMS.SetFilter(NoFacturaContable, noFactura);
        LYLIntegCMS.SetFilter(Tipo, '%1', 2);
        texto := '[';
        if LYLIntegCMS.FindSet() then
            repeat
                texto += '{';
                texto += '"FechaReciboCaja":"' + Format(LYLIntegCMS.FechaRC, 0, '<Day,2>/<Month,2>/<YEAR4>') + '",';
                texto += '"NumeroReciboCaja":"' + LYLIntegCMS.Nodocumento + '",';
                texto += '"Nit":"' + LYLIntegCMS.NitCliente + '",';
                texto += '"NumeroFacturaContable":"' + LYLIntegCMS.NoFacturaContable + '"';
                texto += '}';
            until LYLIntegCMS.Next() = 0;
        texto += ']';
        RespuestaCMS := LYLEnviarCMS.SendPost(texto, 'SalesInvoicePayment');
        EstatusCMS := LYLEnviarCMS.ProcessResponse(RespuestaCMS);

        //     EstatusCMS := 'Conexión Exitosa';

        Clear(LYLIntegCMS);
        LYLIntegCMS.SetFilter(NoFacturaContable, noFactura);
        LYLIntegCMS.SetFilter(Tipo, '%1', 2);
        texto := '[';
        if LYLIntegCMS.FindSet() then
            repeat
                LYLIntegCMS.RespuestaCMS := EstatusCMS;
                LYLIntegCMS.Modify();
            until LYLIntegCMS.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Detailed Cust. Ledg. Entry", 'OnAfterInsertEvent', '', false, false)]
    local procedure EnviarCMSPagoTotalEventSub(var Rec: Record "Detailed Cust. Ledg. Entry")
    var
        DtldCVLedgEntryType: Enum "Detailed CV Ledger Entry Type";
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        if Rec."Entry Type" <> DtldCVLedgEntryType::"Initial Entry" then begin
            CustLedgerEntry.SetFilter("Entry No.", '%1', Rec."Cust. Ledger Entry No.");
            if CustLedgerEntry.FindFirst() then begin
                if CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Invoice then
                    EnviarCMSPagoTotal(CustLedgerEntry."Document No.");
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"LYLFE_CO DocumentHistory", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnInsertSalesInvoiceHistory(var Rec: Record "LYLFE_CO DocumentHistory")
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        LYLIntegCMS: Record LYLIntegCMS;
        lastId: Integer;
        Customer: Record Customer;
        LYLIntegCMSCU: Codeunit LYLIntegCMS;
    begin
        SalesInvoiceHeader.SetFilter("No.", Rec."No.");
        if SalesInvoiceHeader.FindFirst() then begin
            if (SalesInvoiceHeader.LYLCMS_status = 0)
            and (SalesInvoiceHeader."LYLFE_CO Status_EBill" = SalesInvoiceHeader."LYLFE_CO Status_EBill"::PROCESADA) then begin
                lastId := 1;
                if LYLIntegCMS.FindLast() then
                    lastId := LYLIntegCMS.ID + 1;
                Clear(LYLIntegCMS);
                Customer.get(SalesInvoiceHeader."Bill-to Customer No.");
                LYLIntegCMS.Init();
                LYLIntegCMS.ID += lastId;
                LYLIntegCMS.Nodocumento := SalesInvoiceHeader."Pre-Assigned No.";
                LYLIntegCMS.NitCliente := Customer."VAT Registration No.";
                LYLIntegCMS.NoFacturaContable := Rec."No.";
                LYLIntegCMS.FechaRegistro := Rec."Posting Date";
                LYLIntegCMS.FechaVencimiento := SalesInvoiceHeader."Due Date";
                LYLIntegCMS.Tipo := 1;
                LYLIntegCMS.Insert(true);
                LYLIntegCMSCU.changeStatusCMS(SalesInvoiceHeader);
            end;
        end;
    end;
}