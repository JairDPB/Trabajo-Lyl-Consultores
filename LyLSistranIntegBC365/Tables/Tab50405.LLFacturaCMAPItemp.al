table 50405 LLFacturaCMAPItemp
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; TipoDocumento; Enum "Sales Document Type")
        {
            DataClassification = ToBeClassified;
        }
        field(2; NoDocumentoCliente; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Fecha; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; NoOrdenFacturacion; code[25])
        {
            DataClassification = ToBeClassified;
        }
        field(5; TRM; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Concepto; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(7; DocumentoRerencia; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Divisa; Code[4])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; NoOrdenFacturacion)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        Header: Record LLFacturaAPItemp;
        SalesHeader: Record "Sales Header";
        Tipo: Enum "Sales Document Type";
        CustomerPostingGroup: Record "Customer Posting Group";
        customer: Record Customer;
    begin
        Clear(SalesHeader);
        SalesHeader.Init();

        customer.SetFilter("VAT Registration No.", Rec.NoDocumentoCliente);
        customer.FindFirst();

        SalesHeader."No." := Rec.NoOrdenFacturacion;
        SalesHeader."Document Type" := Rec.TipoDocumento;
        SalesHeader."Document Date" := today;
        SalesHeader."Sell-to Customer No." := customer."No.";
        //    SalesHeader."Bill-to Customer No." := customer."No.";
        SalesHeader."Sell-to Customer Templ. Code" := customer."No.";
        SalesHeader.Validate("Sell-to Customer No.");
        // SalesHeader."VAT Registration No." := Rec.NoDocumentoCliente;
        /*  SalesHeader."Invoice Disc. Code" := Rec.NoDocumentoCliente;
          SalesHeader.Validate(SalesHeader."Invoice Disc. Code");*/
        SalesHeader."Posting Date" := Rec.Fecha;
        //     SalesHeader."Posting No." := Rec.NoOrdenFacturacion;
        if Rec.Divisa = 'COP' then begin
            SalesHeader."Currency Code" := '';
        end else begin
            SalesHeader."Currency Code" := Rec.Divisa;
            SalesHeader."Currency Factor" := 1 / rec.TRM;
        end;

        if Tipo::"Credit Memo" = Rec.TipoDocumento then begin
            SalesHeader."Applies-to Doc. Type" := SalesHeader."Applies-to Doc. Type"::Invoice;
            SalesHeader."Applies-to Doc. No." := Rec.DocumentoRerencia;
        end;

        // falta Concepto
        SalesHeader.Insert(false);
    end;

}