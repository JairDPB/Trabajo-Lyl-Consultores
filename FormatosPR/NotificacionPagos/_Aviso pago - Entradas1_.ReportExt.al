reportextension 60101 "Aviso pago - Entradas1" extends "Remittance Advice - Entries"
{
    RDLCLayout = 'Reports/Sistran notificacion.rdlc';

    dataset
    {
        add("Vendor Ledger Entry")
        {
            column(Mensaje; "Message to Recipient")
            {
            }
            column(Posting_Date; Format("Posting Date", 0, '<Closing><Day,2>/<Month,2>/<Year>'))
            {
            }
            column(valor; valor)
            {
            }
            column(Closed_by_Amount__LCY_; "Closed by Amount")
            {
            }
            column(Amount__LCY_; Amount)
            {
            }
            column(External_Document_No_; "External Document No.") { }
        }
        modify("Vendor Ledger Entry")
        {
            trigger OnAfterAfterGetRecord()
            var
            begin
                valor := "Closed by Amount";
                SetFilter("Document Type", 'Pago');
                if valor = 0 then valor := "Amount (LCY)";
                ;
                SetFilter("Document Type", 'pago');
                Vend1.Get("Vendor No.");
                FormatAddr1.Vendor(VendorAddr1, Vend1);
                CalcFields(Amount);
            end;
        }
    }
    var
        FormatAddr1: Codeunit "Format Address";
        VendorAddr1: array[8] of Text[100];
        Vend1: Record Vendor;
        valor: Decimal;
        tabla1: Record "Vendor Ledger Entry";
        page1: Page "Applied Vendor Entries";
}
