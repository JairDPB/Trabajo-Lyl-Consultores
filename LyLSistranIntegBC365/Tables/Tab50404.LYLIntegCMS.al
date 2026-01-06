table 50404 LYLIntegCMS
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; Nodocumento; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; NitCliente; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; FechaRegistro; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; FechaVencimiento; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Estatus; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; FechaRC; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; NoFacturaContable; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Tipo; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; RespuestaCMS; Text[500])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        DatosJson();
    end;

    local procedure DatosJson(): text
    var
        texto: text;
        LYLEnviarCMS: Codeunit LYLEnviarCMS;
        RespuestaCMS: text;
        EstatusCMS: text;
    begin
        Commit();
        if Rec.tipo = 1 then begin
            texto := '{';
            texto += '"NumeroOrdenFacturacion":"' + Rec.Nodocumento + '",';
            texto += '"Nit":"' + Rec.NitCliente + '",';
            texto += '"NumeroFacturaContable":"' + Rec.NoFacturaContable + '",';
            texto += '"FechaRegistro":"' + Format(Rec.FechaRegistro, 0, '<Day,2>/<Month,2>/<YEAR4>') + '",';
            texto += '"FechaVencimiento":"' + Format(Rec.FechaVencimiento, 0, '<Day,2>/<Month,2>/<YEAR4>') + '"';
            texto += '}';
            RespuestaCMS := LYLEnviarCMS.SendPost(texto, 'AccountingInvoiceNumber');
            EstatusCMS := LYLEnviarCMS.ProcessResponse(RespuestaCMS);
            Rec.RespuestaCMS := EstatusCMS;
            //   Rec.Modify();
        end;

    end;
}