pageextension 50106 "Purchase Order Tax Ext" extends "Purchase Order"
{
    actions
    {
        addafter("P&osting")
        {
            action(ConsultarImpuestos)
            {
                ApplicationArea = All;
                Caption = 'Consultar Impuestos';
                Image = TaxDetail;
                ToolTip = 'Consulta el historial de impuestos del proveedor para el mes actual';
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                
                trigger OnAction()
                var
                    TaxInquiryMgt: Codeunit "Tax Inquiry Management";
                begin
                    TaxInquiryMgt.ShowTaxInquiry(Rec."Buy-from Vendor No.", Rec."Posting Date");
                end;
            }
        }
    }
}
