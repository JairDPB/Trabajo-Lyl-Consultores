page 50406 "LYLPostedSalesInvoiceCMS"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sales Invoice Header";
    Caption = 'Facturas CMS';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    Caption = 'No. Documento';
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    Caption = 'No. Cliente';
                }
                field(LYLCMS_status; CMSestatus)
                {
                    Caption = 'Estatus CMS';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'Fecha y Hora de Creación';
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action("Enviar a CMS")
            {
                ApplicationArea = all;
                trigger OnAction()

                begin
                    EnviarCMS();
                end;
            }
        }
    }
    var
        CMSestatus: text;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        if Rec.LYLCMS_status = 0 then
            CMSestatus := 'PENDIENTE';
        if Rec.LYLCMS_status = 1 then
            CMSestatus := 'ENVIADA';
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Rec.SetFilter("LYLFE_CO Status_EBill", '%1', Rec."LYLFE_CO Status_EBill"::PROCESADA);
    end;

    local procedure EnviarCMS()
    var
        LYLIntegCMS: Record LYLIntegCMS;
        LYLIntegCMSCU: Codeunit LYLIntegCMS;
        Customer: Record Customer;
        lastId: Integer;
    begin
        if (Rec.LYLCMS_status = 0) and (Rec."LYLFE_CO Status_EBill" = Rec."LYLFE_CO Status_EBill"::PROCESADA) then begin
            lastId := 1;
            if LYLIntegCMS.FindLast() then
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
            LYLIntegCMSCU.changeStatusCMS(Rec);
        end;
    end;
}