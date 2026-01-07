report 50149 "Impuestos"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Impuestos';
    DefaultLayout = RDLC;
    RDLCLayout = 'Reporte 13 calculo de retencion/Impuestos.rdl';

    dataset
    {
        dataitem(PurchInvHdr; "Purch. Inv. Header")
        {
            DataItemTableView = sorting("Buy-from Vendor No.", "Posting Date");
            RequestFilterFields = "Posting Date", "Buy-from Vendor No.";
            column(CompanyInformationName; CompanyInformation.Name) { }
            column(CompanyInformationVATRegistrationNo; CompanyInformation."VAT Registration No.") { }

            column(TipoDocumento; 'Factura') { }
            column(NoDocumento; "No.") { }
            column(FacturaProveedor; "Vendor Invoice No.") { }
            column(FechaFactura; "Posting Date") { }
            column(NoProveedor; "Buy-from Vendor No.") { }
            column(NombreProveedor; "Buy-from Vendor Name") { }

            dataitem(PurchInvLine; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.");

                column(Tipo; Format(Type)) { }
                column(CodProducto; "No.") { }
                column(Descripcion; Description) { }
                column(Cantidad; Quantity) { }
                column(ValorUnitario; "Direct Unit Cost") { }
                column(ValorTotal; Amount) { }
                column(AreaImpuesto; "VAT Bus. Posting Group") { }
                column(GrupoImpuesto; "VAT Prod. Posting Group") { }
                column(IVA; IVA) { }
                column(ReteIVA; ReteIVA) { }
                column(ReteFuente; ReteFuente) { }
                column(ReteICA; ReteICA) { }

                trigger OnAfterGetRecord()
                begin
                    ClearTaxes();
                    //Calcular por documento completo y distribuir
                    CalcTaxesByDocument("Document No.");
                end;
            }
        }

        dataitem(PurchCrHdr; "Purch. Cr. Memo Hdr.")
        {
            DataItemTableView = sorting("Buy-from Vendor No.", "Posting Date");
            RequestFilterFields = "Posting Date", "Buy-from Vendor No.";

            column(TipoDocumentoNC; 'NC') { }
            column(NoDocumentoNC; "No.") { }
            column(FacturaProveedorNC; "Vendor Cr. Memo No.") { }
            column(FechaFacturaNC; "Posting Date") { }
            column(NoProveedorNC; "Buy-from Vendor No.") { }
            column(NombreProveedorNC; "Buy-from Vendor Name") { }

            dataitem(PurchCrLine; "Purch. Cr. Memo Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.");

                column(TipoNC; Format(Type)) { }
                column(CodProductoNC; "No.") { }
                column(DescripcionNC; Description) { }
                column(CantidadNC; Quantity) { }
                column(ValorUnitarioNC; "Direct Unit Cost") { }
                column(ValorTotalNC; Amount) { }
                column(AreaImpuestoNC; "VAT Bus. Posting Group") { }
                column(GrupoImpuestoNC; "VAT Prod. Posting Group") { }
                column(IVANC; IVA) { }
                column(ReteIVANC; ReteIVA) { }
                column(ReteFuenteNC; ReteFuente) { }
                column(ReteICANC; ReteICA) { }

                trigger OnAfterGetRecord()
                begin
                    ClearTaxes();
                    CalcTaxesByDocument("Document No.");
                end;
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(Opciones)
                {
                    Caption = 'Opciones';
                    field(FechaInicio; FechaInicio)
                    {
                        ApplicationArea = All;
                        Caption = 'Fecha Inicio';
                        ToolTip = 'Especifica la fecha de inicio del período';
                    }
                    field(FechaFin; FechaFin)
                    {
                        ApplicationArea = All;
                        Caption = 'Fecha Fin';
                        ToolTip = 'Especifica la fecha de fin del período';
                    }
                }
            }
        }
    }
    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        CompanyInformation.get();
    end;

    var
        CompanyInformation: Record "Company Information";
        VATEntry: Record "VAT Entry";
        IVA: Decimal;
        ReteIVA: Decimal;
        ReteFuente: Decimal;
        ReteICA: Decimal;
        FechaInicio: Date;
        FechaFin: Date;

    local procedure ClearTaxes()
    begin
        IVA := 0;
        ReteIVA := 0;
        ReteFuente := 0;
        ReteICA := 0;
    end;

    //Calcular impuestos a nivel de documento
    local procedure CalcTaxesByDocument(DocNo: Code[20])
    var
        VATPostingSetup: Record "VAT Posting Setup";
        TotalLines: Integer;
    begin
        VATEntry.Reset();
        VATEntry.SetRange("Document No.", DocNo);
        VATEntry.SetRange(Type, VATEntry.Type::Purchase);

        if VATEntry.FindSet() then begin
            // Contar líneas del documento para distribuir impuestos
            TotalLines := CountDocumentLines(DocNo);
            if TotalLines = 0 then
                TotalLines := 1;

            repeat
                // Calcular IVA Normal
                if VATEntry."VAT Calculation Type" = VATEntry."VAT Calculation Type"::"Normal VAT" then
                    IVA += (VATEntry.Amount / TotalLines);

                // Identificar retenciones por VAT Prod. Posting Group
                case VATEntry."VAT Prod. Posting Group" of
                    'RETEIVA':
                        ReteIVA += (VATEntry.Amount / TotalLines);
                    'RETEFUENTE', 'RFTE':
                        ReteFuente += (VATEntry.Amount / TotalLines);
                    'RETEICA':
                        ReteICA += (VATEntry.Amount / TotalLines);
                end;

            until VATEntry.Next() = 0;
        end;
    end;

    local procedure CountDocumentLines(DocNo: Code[20]): Integer
    var
        PurchInvLine: Record "Purch. Inv. Line";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
    begin
        PurchInvLine.Reset();
        PurchInvLine.SetRange("Document No.", DocNo);
        if PurchInvLine.FindSet() then
            exit(PurchInvLine.Count);

        PurchCrMemoLine.Reset();
        PurchCrMemoLine.SetRange("Document No.", DocNo);
        if PurchCrMemoLine.FindSet() then
            exit(PurchCrMemoLine.Count);

        exit(1);
    end;
}