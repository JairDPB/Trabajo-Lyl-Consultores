pageextension 60104 "Posted Purchase Invoice ext" extends "Posted Purchase Invoice"
{
    actions
    {
        modify(Print)
        {
            Visible = false;

        }
        modify(AttachAsPDF)
        {
            Visible = false;

        }
        addbefore(Print)
        {
            /*
                        group("Documento soporte")
                        {
                            action("Generar Documento soporte")
                            {
                                Promoted = true;
                                Image = Report;
                                ApplicationArea = All;

                                trigger OnAction()
                                var

                                    documentSupport: Report documentSupport;
                                    PurchInvHeader: Record "Purch. Inv. Header";
                                begin
                                    PurchInvHeader.SetFilter("No.", Rec."No.");
                                    documentSupport.SetTableView(PurchInvHeader);
                                    documentSupport.Run;
                                end;
                            }
                        }*/
            group("Factura de compra")
            {
                action("Generar Factura de compra")
                {

                    Promoted = true;
                    Image = Report;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        invoicing: Report invoicing;
                        PurchInvHeader: Record "Purch. Inv. Header";
                    begin
                        PurchInvHeader.SetFilter("No.", Rec."No.");
                        invoicing.SetTableView(PurchInvHeader);
                        invoicing.Run;
                    end;
                }
            }
            group("Caja menor")
            {
                action("Generar Caja menor")
                {
                    Promoted = true;
                    Image = Report;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        pettyCash: Report pettyCash;
                        PurchInvHeader: Record "Purch. Inv. Header";

                    begin
                        // PurchInvHeader.SetFilter("No.", '%1..%2', 'CM4730', 'CM4739');
                        PurchInvHeader.SetFilter("No.", Rec."No.");
                        pettyCash.SetTableView(PurchInvHeader);
                        pettyCash.Run;
                        //REPORT.Run(50110, false, false, PurchInvHeader);
                    end;
                }
            }
        }
    }
}