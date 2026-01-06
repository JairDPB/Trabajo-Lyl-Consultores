codeunit 50400 "LLCUIntegracion"
{
    Permissions = tabledata LLClientesAPItemp = rdmi, tabledata LLFacturaAPItemp = rdmi, tabledata LLLineasFacturaAPItemp = rdmi, tabledata "LYLOC_CO DIAN Setup" = r;
    //, tabledata TemporalVendor = rdmi, tabledata PlanoPagoClientes = rdmi, tabledata Header = rdmi, tabledata Lines = rdmi, tabledata Impuestos = rdmi, tabledata HomologacionImpuestos = rdmi, tabledata PurchaseHeader = rdmi, tabledata PurchaseLines = rdmi, tabledata PurchaseImpuestos = rdmi;

    procedure InsertNewCustomer(temporal: Record LLClientesAPItemp)
    var
        SearchName: Text[100];
        DimValueTercero: Code[20];
    begin
        // Clear(PostCode);
        Clear(Customer);
        Clear(TipoDocumento);
        Clear(ResponsabiliadFiscal);
        Clear(TerminosPago);
        Clear(MetodoPago);

        //  PostCode.SetFilter(Code, temporal.PostCode);

        TerminosPago.SetFilter(Code, 'CONTADO');

        MetodoPago.SetFilter(Code, 'EFECT');

        Customer.Init();

        Customer."No." := temporal.NoDocumento;
        Customer.Validate("No.");

        Customer."VAT Registration No." := temporal.NoDocumento;
        //Customer.Validate("VAT Registration No.");

        Customer.Address := temporal.Direccion;
        Customer.Validate(Address);

        Customer."Phone No." := temporal.Telefono;
        Customer."Mobile Phone No." := temporal.Telefono;

        Customer."E-Mail" := temporal.Email;
        Customer.Validate("E-Mail");

        // Customer."Post Code" := temporal.PostCode;
        Customer.Validate("Post Code");

        //Customer."G2LCO_Verification Code COL" := CalcVerificationCode(temporal.NoDocumento);

        if TerminosPago.FindFirst() then begin
            Customer."Payment Terms Code" := TerminosPago.Code;
            Customer.Validate("Payment Terms Code");
        end;

        if MetodoPago.FindFirst() then begin
            Customer."Payment Method Code" := MetodoPago.Code;
            Customer.Validate("Payment Method Code");
        end;

        /*    IF PostCode.FindFirst() then begin
                Customer.City := PostCode.City;
                Customer.Validate(City);
            end;*/

        Customer."Country/Region Code" := temporal.Pais;

        Customer."Customer Posting Group" := 'NAC';
        Customer."Gen. Bus. Posting Group" := 'GENERAL';
        Customer."Customer Price Group" := 'COMERCIAL';
        Customer."Tax Liable" := true;

        Customer."LYLOC_CO DIAN Ident. Type" := temporal.TipoDocumento;
        Customer.Validate("LYLOC_CO DIAN Ident. Type");

        TipoDocumento.SetFilter("DIAN Code", temporal.TipoDocumento);
        if TipoDocumento.FindFirst() then
            Customer."LYLOC_CO Document Type Desc" := TipoDocumento.Description;

        Customer."LYLOC_CO DIAN Entity type" := temporal.TipoEntidad;

        if temporal.TipoEntidad = '1' then begin
            //  Customer."Tax Area Code" := 'C_NOREPIVA';
            Customer.Name := temporal.PrimerNombre;
            Customer."Name 2" := temporal.SegundoNombre;
            Customer."LYLOC_CO Last Name" := temporal.PrimerApellido;
            Customer."LYLOC_CO Mothers Last Name" := temporal.SegundoApellido;
            SearchName := temporal.PrimerNombre;
        end else begin
            //   Customer."Tax Area Code" := 'C_REPIVA';
            Customer.Name := temporal.RazonSocial;
            SearchName := temporal.RazonSocial;
        end;

        Customer."Search Name" := SearchName;
        //  Customer.G2LCO_NaturalPersonName := SearchName;

        if Customer.Insert(false, true) then begin
            Customer."VAT Registration No." := temporal.NoDocumento;
            Customer.Validate("VAT Registration No.");
            Customer.Modify();
            /*  Evaluate(DimValueTercero, temporal.NoDocumento);
              Customer.ValidateShortcutDimCode(3, DimValueTercero);
              Customer.Modify();

              ResponsabiliadFiscal.Init();
              ResponsabiliadFiscal."Table From" := ResponsabiliadFiscal."Table From"::Customer;
              ResponsabiliadFiscal."Company No." := Customer."No.";
              ResponsabiliadFiscal."Tax Respon. DIAN" := 'R-99-PN';
              ResponsabiliadFiscal."Tax Respon. DIAN Desc." := 'NO RESPONSABLE';
              ResponsabiliadFiscal.Insert(true);*/
        end;

    end;

    procedure UpdateCustomerExist(temporal: Record LLClientesAPItemp)
    var
        SearchName: Text[100];
        DimValueTercero: Code[20];
    begin
        Clear(Customer);
        Clear(PostCode);
        Customer.SetFilter("No.", temporal.NoDocumento);
        if Customer.FindFirst() then begin
            // PostCode.SetFilter(Code, temporal.PostCode);

            Customer."Phone No." := temporal.Telefono;
            Customer."Mobile Phone No." := temporal.Telefono;

            Customer."E-Mail" := temporal.Email;
            Customer.Validate("E-Mail");

            /*  Customer."Country/Region Code" := temporal.Pais;
              IF PostCode.FindFirst() then begin
                  Customer."Post Code" := PostCode.Code;
                  Customer.Validate("Post Code");
              end;*/


            /* IF PostCode.FindFirst() then begin
                 Customer.City := PostCode.City;
                 Customer.Validate(City);
             end;*/

            Customer."LYLOC_CO DIAN Ident. Type" := temporal.TipoDocumento;
            Customer.Validate("LYLOC_CO DIAN Ident. Type");

            TipoDocumento.SetFilter("DIAN Code", temporal.TipoDocumento);
            if TipoDocumento.FindFirst() then
                Customer."LYLOC_CO Document Type Desc" := TipoDocumento.Description;

            Customer."LYLOC_CO DIAN Entity type" := temporal.TipoEntidad;

            if temporal.TipoEntidad = '1' then begin
                //Customer."Tax Area Code" := 'C_NOREPIVA';
                Customer.Name := temporal.PrimerNombre;
                Customer."Name 2" := temporal.SegundoNombre;
                Customer."LYLOC_CO Last Name" := temporal.PrimerApellido;
                Customer."LYLOC_CO Mothers Last Name" := temporal.SegundoApellido;
                SearchName := RetornarNombre(temporal.PrimerNombre, temporal.SegundoNombre, temporal.PrimerApellido, temporal.SegundoApellido);
            end else begin
                //Customer."Tax Area Code" := 'C_REPIVA';
                Customer.Name := temporal.RazonSocial;
                SearchName := temporal.RazonSocial;
            end;

            Customer."Search Name" := SearchName;
            //    Customer.G2LCO_NaturalPersonName := SearchName;

            Customer.Modify();
        end;
    end;

    local procedure RetornarNombre(nom1: Text[100]; nom2: Text[50]; ape1: Text[100]; ape2: Text[100]) nombre: Text
    begin
        nombre := nom1;

        if nom2 <> '' then
            nombre := nombre + ' ' + nom2;

        if ape1 <> '' then
            nombre := nombre + ' ' + ape1;

        if ape2 <> '' then
            nombre := nombre + ' ' + ape2;
    end;

    procedure UpdateCustomerDimension(temporal: Record LLClientesAPItemp)
    var
        Dimension: Record "Dimension Value";
        Name: Text[200];
    begin
        Clear(Dimension);

        if temporal.TipoEntidad = '1' then begin
            Name := RetornarNombre(temporal.PrimerNombre, temporal.SegundoNombre, temporal.PrimerApellido, temporal.SegundoApellido);
        end else begin
            Name := temporal.RazonSocial;
        end;

        Dimension.SetRange("Dimension Code", 'TERCERO');
        Dimension.SetFilter("Code", temporal.NoDocumento);

        if Dimension.FindFirst() then begin
            Dimension.Name := Name;

            Dimension.Modify(false);
        end;

    end;

    procedure CalcVerificationCode(vat: Text[20]): Code[2]
    var
        length: Integer;
        total: Integer;
        serie: List of [Integer];
        i: Integer;
        j: Integer;
        modResult: Integer;
        verificationCode: Integer;
        numbers: List of [Integer];
        number: Integer;
    begin

        i := 1;
        vat := vat.Replace(' ', '');
        vat := vat.Replace('-', '');
        vat := vat.Replace('.', '');
        vat := vat.Replace('\', '');
        vat := vat.Replace('/', '');

        length := StrLen(vat);
        serie.Add(3);
        serie.Add(7);
        serie.Add(13);
        serie.Add(17);
        serie.Add(19);
        serie.Add(23);
        serie.Add(29);
        serie.Add(37);
        serie.Add(41);
        serie.Add(43);
        serie.Add(47);
        serie.Add(53);
        serie.Add(59);
        serie.Add(67);
        serie.Add(71);

        while i <= length do begin
            if Evaluate(j, vat.Substring(i, 1)) then
                numbers.Add(j);
            i := i + 1;
        end;

        foreach number in numbers do begin
            total := total + (number * serie.Get(length));
            length := length - 1;
        end;

        modResult := total mod 11;

        if modResult > 1 then begin
            verificationCode := 11 - modResult;
        end else begin
            verificationCode := modResult;
        end;

        exit(Format(verificationCode));
    end;

    var
        PostCode: Record "Post Code";
        Customer: Record Customer;
        Vendor: Record Vendor;
        TipoDocumento: Record "LYLOC_CO DIAN Setup";
        ResponsabiliadFiscal: Record "LYLOC_CO Tax Respon. DIAN";
        TerminosPago: Record "Payment Terms";
        MetodoPago: Record "Payment Method";
}