report 50116 "D365LFacturaCompraMasivo"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Factura De Compra Masivo';

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            RequestFilterFields = "Document Date";

            trigger OnPreDataItem()
            begin
                if pref <> '' then
                    SetFilter("No.", pref + '*');

                zip.CreateZipArchive();
            end;

            trigger OnAfterGetRecord()
            var
                tempBlob: Codeunit "Temp Blob";
                outs: OutStream;
                ins: InStream;
                recRef: RecordRef;
                purchInv: Record "Purch. Inv. Header";
            begin
                purchInv := "Purch. Inv. Header";
                purchInv.SetRange("No.", "Purch. Inv. Header"."No.");
                purchInv.SetFilter("Document Date", "Purch. Inv. Header".GetFilter("Document Date"));

                tempBlob.CreateOutStream(outs);
                recRef.GetTable(purchInv);
                Report.SaveAs(Report::"D365L FacturaCompra", '', ReportFormat::Pdf, outs, recRef);

                tempBlob.CreateInStream(ins);
                zip.AddEntry(ins, "Purch. Inv. Header"."No." + '.pdf');
            end;

            trigger OnPostDataItem()
            var
                tempBlob: Codeunit "Temp Blob";
                outs: OutStream;
                ins: InStream;
                fileName: Text;
            begin
                fileName := 'FacturasCompra.zip';
                tempBlob.CreateOutStream(outs);
                zip.SaveZipArchive(outs);
                tempBlob.CreateInStream(ins);

                DownloadFromStream(ins,'','','', fileName);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(Opciones)
                {
                    Caption = 'Filtros';
                    field(pref; pref)
                    {
                        ApplicationArea = all;
                        Caption = 'Prefijo';
                    }
                }
            }
        }
    }

    var
        parametres: Text;
        zip: Codeunit "Data Compression";
        pref: Text;
}
