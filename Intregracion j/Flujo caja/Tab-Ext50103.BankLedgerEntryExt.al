tableextension 50107 "BankLedgerEntryExt " extends "Bank Account Ledger Entry"
{
    fields
    {
        field(50121; "Tipo Movimiento"; Enum "Tipo Movimiento Banco")
        {
            Caption = 'Tipo Movimiento';
            Editable = true;
            DataClassification = CustomerContent;
        }
    }
    trigger OnAfterInsert()
    begin
        clasifircarMovimiento();
    end;
    local procedure clasifircarMovimiento()
    begin
        if Amount>=0 then
            "Tipo Movimiento" := "Tipo Movimiento Banco"::Ingreso
        else
            "Tipo Movimiento" := "Tipo Movimiento Banco"::Egreso;
    end;
}
