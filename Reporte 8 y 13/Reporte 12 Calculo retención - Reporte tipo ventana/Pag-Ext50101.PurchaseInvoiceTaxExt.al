pageextension 50105 "Purchase Invoice Tax Ext" extends "Purchase Invoice"
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
                PromotedCategory = Category5;
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