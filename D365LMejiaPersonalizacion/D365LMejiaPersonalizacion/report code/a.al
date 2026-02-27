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
        }
        modify("Sales Invoice Header")
        {
            trigger OnAfterAfterGetRecord()
            var
                Customer: Record Customer;
            begin
                Customer.Get("Sell-to Customer No.");
                ThirdNo1 := Customer.Name;
                if "Bill-to Customer No." <> "Sell-to Customer No." then begin
                    Customer.Get("Bill-to Customer No.");
                    ThirdNo2 := Customer.Name;
                    CustomerAddress := customer.Address;
                    CustomerPhone := customer."Phone No.";
                    CustomerEmail := customer."E-Mail";
                    CustomerNit := customer."VAT Registration No.";
                end else
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
        ThirdNo1: text;
        ThirdNo2: text;
        CustomerEmail: text;
        CustomerAddress: text;
        CustomerPhone: text;
        CustomerNit: text;
}