pageextension 50109 "Posted Purch Inv Tax Ext" extends "Posted Purchase Invoice"
{
    actions
    {
        addlast(processing)
        {
            action(ConsultarImpuestos)
            {
                ApplicationArea = All;
                Caption = 'Consultar Impuestos';
                Image = TaxDetail;
                ToolTip = 'Consulta el historial de impuestos del proveedor para el mes actual';
                Promoted = true;
                PromotedCategory = Process;
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