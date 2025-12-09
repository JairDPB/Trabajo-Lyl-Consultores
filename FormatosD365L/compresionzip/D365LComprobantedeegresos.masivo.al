/// <summary>
/// Ventana de reporte para generar varios reportes de comprobante de egresos en forma masiva en un zip
/// </summary>
report 50112 "D365LComprobanteEgresosMasivo"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Comprobante Egresos Masivo';

    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            RequestFilterFields = "Posting Date";
            trigger OnPreDataItem()
            var
            //statement: Report "D365L Comprobante Egresos";
            begin
                // parametres := statement.RunRequestPage();
                // if parametres = '' then
                // Error('Debe seleccionar un rango de fecha');
                SetRange("Document Type", "Vendor Ledger Entry"."Document Type"::Payment);
                SetFilter("Document No.", pref);

                zip.CreateZipArchive();
            end;

            trigger OnAfterGetRecord()
            var
                tempBlob: Codeunit "Temp Blob";
                outs: OutStream;
                ins: InStream;
                ref: RecordRef;
                vendorRec: Record "Vendor Ledger Entry";

            begin
                // Preparar un record filtrado para pasarlo al Report.SaveAs
                vendorRec.SetRange("Document No.", "Vendor Ledger Entry"."Document No.");
                vendorRec.SetFilter("Posting Date", "Vendor Ledger Entry".GetFilter("Posting Date"));
                vendorRec.SetRange("Document Type", vendorRec."Document Type"::Payment);

                tempBlob.CreateOutStream(outs);
                ref.GetTable(vendorRec);
                Report.SaveAs(Report::"D365L Comprobante Egresos", parametres, ReportFormat::Pdf, outs, ref);
                tempBlob.CreateInStream(Ins);
                zip.AddEntry(ins, "Vendor Ledger Entry"."Document No." + '.pdf');
            end;

            trigger OnPostDataItem()
            var
                tempBlob: Codeunit "Temp Blob";
                outs: OutStream;
                ins: InStream;
                fileName: text;
            begin
                fileName := 'ComprobanteEgresos.zip';
                tempBlob.CreateOutStream(outs);
                zip.SaveZipArchive(outs);
                tempBlob.CreateInStream(ins);

                DownloadFromStream(ins, '', '', '', FileName);
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
                    /* field(pref; pref)
                    {
                        ApplicationArea = all;
                        caption = 'Prefijo';
                    }*/
                    field(pref; pref)
                    {
                        ApplicationArea = all;
                        caption = 'Documentos';
                        ToolTip = 'Ingrese los documentos separados por | o use * como comodín (Ej: CE*)';
                    }

                }
            }
        }

    }

    var
        parametres: Text;
        zip: Codeunit "Data Compression";

        pref: text;
        NumDoc: text;
}