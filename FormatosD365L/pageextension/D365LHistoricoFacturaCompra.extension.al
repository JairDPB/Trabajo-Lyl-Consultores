/// <summary>
/// Extension de pagina para generar factura de compra publicada
/// </summary>
pageextension 50140 "D365HistoricoFacturaCompra" extends "Posted Purchase Invoice"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addlast("&Invoice")
        {
            action("Imprimir Como Factura Compra")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Imprimir Factura Compra';
                Image = Report;
                ToolTip = 'Imprimir Factura Compra';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category6;

                trigger OnAction()
                var
                    PurchInvHeader: Record "Purch. Inv. Header";
                    D365LFacturaCompra: Report "D365L FacturaCompra";
                begin
                    D365LFacturaCompra.setValueFilter(Rec."No.");
                    D365LFacturaCompra.Run();
                end;
            }
            action("Imprimir Como Caja Menor")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Imprimir Caja Menor';
                Image = Report;
                ToolTip = 'Imprimir Caja Menor';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category6;

                trigger OnAction()
                var
                    PurchInvHeader: Record "Purch. Inv. Header";
                    D365LFacturaCompra: Report "D365L Caja Menor";
                begin
                    D365LFacturaCompra.setValueFilter(Rec."No.");
                    D365LFacturaCompra.Run();

                end;
            }


        }

    }

    var
        myInt: Integer;
}