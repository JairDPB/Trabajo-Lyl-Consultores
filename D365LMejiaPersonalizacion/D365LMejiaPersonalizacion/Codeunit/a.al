codeunit 88100 "D365L Mejia Personalizacion"
{
    Permissions = tabledata "Sales Line" = rm,
                 tabledata "Sales Header" = rm;
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterInsertEvent, '', false, false)]
    local procedure MyProcedure(var Rec: Record "Sales Line")
    var
        Customer: Record Customer;
        SalesLine: Record "Sales Line";
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.SetFilter("Document Type", '%1', SalesHeader."Document Type"::Invoice);
        SalesHeader.SetFilter("No.", Rec."Document No.");
        if (SalesHeader.FindFirst()) and (SalesHeader."Document Type" = SalesHeader."Document Type"::invoice) and (SalesHeader."Bill-to Customer No." <> SalesHeader."Sell-to Customer No.") then begin
            Customer.SetFilter("No.", SalesHeader."Bill-to Customer No.");
            if Customer.FindFirst() then begin
                Rec.Validate("D365L CO Third No.", Customer."No.");
                Rec.Modify(true);
            end;
        end;

    end;


}