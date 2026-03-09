reportextension 88100 "D365L SalesInvoiceExt" extends "D365L Factura Venta"
{
    dataset
    {
        add("Sales Invoice Header")
        {
            column(ThirdNo1; ThirdNo1) { }
            column(ThirdNo2; ThirdNo2) { }
            column(CustomerEmail; CustomerEmail) { }
            column(CustomerAddress; CustomerAddress) { }
            column(CustomerPhone; CustomerPhone) { }
            column(CustomerNit; CustomerNit) { }
            column(NoOrden; NoOrden) { }
            column(Presupuesto; Presupuesto) { }

        }
        modify("Sales Invoice Header")
        {
            trigger OnAfterAfterGetRecord()
            var
                CustomerRec: Record Customer;
            begin
                if CustomerRec.Get("Sell-to Customer No.") then
                    ThirdNo1 := CustomerRec.Name;

                if not CustomerRec.Get("Bill-to Customer No.") then
                    Clear(CustomerRec);

                if "Ship-to Name" <> '' then
                    ThirdNo2 := "Ship-to Name"
                else
                    ThirdNo2 := CustomerRec.Name;

                if "Ship-to Address" <> '' then
                    CustomerAddress := "Ship-to Address"
                else
                    CustomerAddress := CustomerRec.Address;

                if "Ship-to Phone No." <> '' then 
                    CustomerPhone := "Ship-to Phone No."
                else
                    CustomerPhone := CustomerRec."Phone No.";

                // 3. Campos que normalmente no están en el Ship-to del Header (Email y NIT)
                CustomerEmail := CustomerRec."E-Mail";
                CustomerNit := "Ship-to Code";

                
                if ThirdNo2 = '' then
                    ThirdNo2 := ThirdNo1;
            end;
        }
    }

    requestpage
    {
        // Add changes to the requestpage here
    }

    rendering
    {
        layout(D365LFacturaVentaMJ)
        {
            Type = RDLC;
            LayoutFile = 'Report/D365LFacturaVentaMJ.rdl';
        }
    }
    var
        NoOrden: Text;
        Presupuesto: Text;
        ThirdNo1: text;
        ThirdNo2: text;
        CustomerEmail: text;
        CustomerAddress: text;
        CustomerPhone: text;
        CustomerNit: text;
}