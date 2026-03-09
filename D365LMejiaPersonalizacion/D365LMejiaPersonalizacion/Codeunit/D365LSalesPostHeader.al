codeunit 88102 SalesPostSubscriber
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvHeaderInsert', '', false, false)]
    local procedure OnAfterSalesInvHeaderInsert(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header")
    begin
        SalesInvHeader."No orden" := SalesHeader."No orden";
        SalesInvHeader."Presupuesto" := SalesHeader."Presupuesto";
        SalesInvHeader.Modify();
    end;
}