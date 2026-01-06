table 50402 LLLineasFacturaAPItemp
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; NoLinea; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; HeaderNo; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = LLFacturaAPItemp.NoOrdenFacturacion;
            trigger OnValidate()
            begin
                GetHeader();
            end;

        }
        field(3; TipoProducto; Enum "Sales Line Type")
        {
            DataClassification = ToBeClassified;
        }
        field(4; NoProducto; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Descripcion; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Cantidad; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; ValorUnitario; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; CentroCosto; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; HeaderId; Guid)
        {
            TableRelation = LLFacturaAPItemp.SystemId;
        }

    }

    keys
    {
        key(Key1; HeaderNo, NoLinea, HeaderId)
        {
            Clustered = true;
        }
    }

    var
        Header: Record LLFacturaAPItemp;

    local procedure CheckHeaderStatus()
    begin
        GetHeader();
    end;

    local procedure GetHeader()
    begin
        if Header.SystemId <> HeaderId then
            Header.GetBySystemId(HeaderId);
    end;

    trigger OnInsert()
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        NewSalesLine: Record "Sales Line";
        Dimension: Record "Dimension Value";
        LineNo: Integer;
        C_DimValue1: Code[20];
        C_DimValue2: Code[20];
        C_DimValue4: Code[20];
        CU: Codeunit LLCUIntegracion;
        NoLinea: Integer;
        customer: Record Customer;
        SalesDocumentType: Enum "Sales Document Type";
    begin
        Clear(SalesHeader);
        Clear(SalesLine);
        Clear(NewSalesLine);
        Clear(Dimension);

        SalesHeader.SetFilter("No.", Rec.HeaderNo);
        SalesHeader.SetCurrentKey(SystemId);
        if SalesHeader.GetAscending(SystemId) then begin
            if SalesHeader.FindLast() then begin

                NewSalesLine.Init();
                NewSalesLine."Document No." := SalesHeader."No.";
                NewSalesLine."Document Type" := SalesHeader."Document Type";
                NewSalesLine.Validate(NewSalesLine."Document Type");
                NewSalesLine.Type := Rec.TipoProducto;
                Evaluate(NewSalesLine."Line No.", Rec.NoLinea);
                NewSalesLine."No." := Rec.NoProducto;
                NewSalesLine.Validate(NewSalesLine."No.");
                NewSalesLine.Quantity := Rec.Cantidad;
                NewSalesLine.Validate(NewSalesLine.Quantity);
                NewSalesLine."Unit Price" := Rec.ValorUnitario;
                NewSalesLine.Validate(NewSalesLine."Unit Price");
                NewSalesLine."Unit of Measure Code" := 'UND';
                NewSalesLine.LyLExtDescription := Rec.Descripcion;
                NewSalesLine.Insert();
            end;
        end;


    end;

}