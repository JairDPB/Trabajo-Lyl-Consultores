pageextension 50400 LYLPostedSalesInvExt extends "Posted Sales Invoice"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        /*addlast(processing)
        {
            action("Envia Pruebas 1")
            {
                Caption = 'lyl test envia 1';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category9;
                Image = Action;
                trigger OnAction()
                var
                    LYLIntegCMS: Codeunit LYLIntegCMS;
                begin
                    LYLIntegCMS.EnviaCMSManual(Rec);
                end;
            }
            action("Envia Pruebas 2")
            {
                Caption = 'lyl test envia 2';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category9;
                Image = Action;
                trigger OnAction()
                var
                    LYLIntegCMS: Codeunit LYLIntegCMS;
                begin
                    LYLIntegCMS.EnviarCMSPagoTotal(Rec."No.");
                end;
            }
        }*/
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        EnviarCMS();
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