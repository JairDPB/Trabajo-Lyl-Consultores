page 50110 "Purchase Trace List"
{
    ApplicationArea = All;
    Caption = 'Seguimiento del Proceso de Compras';
    PageType = List;
    SourceTable = "D365L Purchase Trace Buffer";
    SourceTableTemporary = true;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                // ===== PEDIDO =====
                field("Order No."; Rec."Order No.") { Caption = 'Número de pedido'; }
                field("Order Date"; Rec."Order Date") { Caption = 'Fecha de pedido'; }
                field("Order Approval Date"; Rec."Order Approval Date") { Caption = 'Fecha aprobación pedido'; }
                field("Expected Receipt Date"; Rec."Expected Receipt Date") { Caption = 'Fecha entrega'; }
                field("Order Created By"; Rec."Order Created By") { Caption = 'Creado por'; }
                field("Buyer Code"; Rec."Buyer Code") { Caption = 'Código comprador'; }
                field(Status; Rec.Status) { Caption = 'Estado'; }

                field("Vendor No."; Rec."Vendor No.") { Caption = 'Proveedor'; }
                field("Vendor Name"; Rec."Vendor Name") { Caption = 'Nombre proveedor'; }

                // ===== LÍNEA DE PEDIDO =====
                field("Order Line No."; Rec."Order Line No.") { Caption = 'Núm. línea'; }
                field("Order Item No."; Rec."Order Item No.") { Caption = 'Código'; }
                field("Order Description"; Rec."Order Description") { Caption = 'Descripción'; }

                field("Currency Code"; Rec."Currency Code") { Caption = 'Moneda'; }
                field(TRM; Rec.TRM) { Caption = 'TRM'; }

                field("Order Quantity"; Rec."Order Quantity") { Caption = 'Cantidad'; }
                field("Unit of Measure"; Rec."Unit of Measure") { Caption = 'Unidad de medida'; }
                field("Order Unit Cost"; Rec."Order Unit Cost") { Caption = 'Valor unitario'; }
                field("Order Line Amount"; Rec."Order Line Amount") { Caption = 'Valor total'; }

                // ===== DIMENSIONES =====
                field("Dim 1"; Rec."Dim 1") { Caption = 'Dimensión 1'; }
                field("Dim 2"; Rec."Dim 2") { Caption = 'Dimensión 2'; }
                field("Dim 3"; Rec."Dim 3") { Caption = 'Dimensión 3'; }
                field("Dim 4"; Rec."Dim 4") { Caption = 'Dimensión 4'; }
                field("Dim 5"; Rec."Dim 5") { Caption = 'Dimensión 5'; }
                field("Dim 6"; Rec."Dim 6") { Caption = 'Dimensión 6'; }
                field("Dim 7"; Rec."Dim 7") { Caption = 'Dimensión 7'; }
                field("Dim 8"; Rec."Dim 8") { Caption = 'Dimensión 8'; }

                // ===== RECEPCIÓN =====
                field("Receipt No."; Rec."Receipt No.") { Caption = 'Número de recepción'; }
                field("Receipt Date"; Rec."Receipt Date") { Caption = 'Fecha recepción'; }
                field("Received Quantity"; Rec."Received Quantity") { Caption = 'Cantidad recibida'; }

                // ===== FACTURA =====
                field("Invoice No."; Rec."Invoice No.") { Caption = 'Número factura'; }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.") { Caption = 'Factura proveedor'; }
                field("Invoice Date"; Rec."Invoice Date") { Caption = 'Fecha factura'; }

                field("Invoice Item No."; Rec."Invoice Item No.") { Caption = 'Código factura'; }
                field("Invoice Description"; Rec."Invoice Description") { Caption = 'Descripción factura'; }
                field("Invoiced Quantity"; Rec."Invoiced Quantity") { Caption = 'Cantidad facturada'; }
                field("Invoice Unit Cost"; Rec."Invoice Unit Cost") { Caption = 'Valor unitario factura'; }
                field("Invoice Line Amount"; Rec."Invoice Line Amount") { Caption = 'Valor total factura'; }
            }
        }
    }
        trigger OnOpenPage()
        
            
        var
            LoadCU: Codeunit "Load Purchase Trace";
        begin
            LoadCU.LoadData(Rec);
        end;

}
