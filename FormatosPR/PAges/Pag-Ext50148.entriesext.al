/*pageextension 50148 entriesext extends "General Ledger Entries"
{
    actions
    {
        addbefore("F&unctions")
        {

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
                        PurchInvHeader.SetFilter("No.", Rec."Document No.");
                        documentSupport.SetTableView(PurchInvHeader);
                        documentSupport.Run;
                    end;
                }
            }
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
                        PurchInvHeader.SetFilter("No.", Rec."Document No.");
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
                        PurchInvHeader.SetFilter("No.", '%1..%2', 'CM4730', 'CM4739');
                        //PurchInvHeader.SetFilter("No.", Rec."Document No.");
                        //pettyCash.SetTableView(PurchInvHeader);
                        //pettyCash.Run;
                        REPORT.Run(50110, false, false, PurchInvHeader);
                    end;
                }
            }
        }
    }
}*/