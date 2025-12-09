/// <summary>
/// Ventana de reporte para generar varios reportes de Documento soporte en forma masiva en un zip
/// </summary>
report 50115 "D365LDocumentoSoporteMasivo"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Documento Soporte Masivo';

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            RequestFilterFields = "Document Date";
            trigger OnPreDataItem()
            var
            //statement: Report "D365L Comprobante Egresos";
            begin
                // parametres := statement.RunRequestPage();
                // if parametres = '' then
                // Error('Debe seleccionar un rango de fecha');
                //SetRange("Document Type", "Purch. Inv. Header"."Document Type"::Payment);
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
                headerRec: Record "Purch. Inv. Header";
            begin
                // Prepara un record con el filtro del registro actual
                headerRec := "Purch. Inv. Header";
                headerRec.SetRange("No.", "Purch. Inv. Header"."No.");
                headerRec.SetFilter("Document Date", "Purch. Inv. Header".GetFilter("Document Date"));

                // Guarda el PDF del report asociado en tempBlob
                tempBlob.CreateOutStream(outs);
                recRef.GetTable(headerRec);
                // Si el subreport no necesita RequestPage, pasa '' como parámetros
                Report.SaveAs(Report::"D365L documentSupport", '', ReportFormat::Pdf, outs, recRef);

                // Añadimos al ZIP
                tempBlob.CreateInStream(ins);
                zip.AddEntry(ins, "Purch. Inv. Header"."No." + '.pdf');
            end;

            trigger OnPostDataItem()
            var
                tempBlob: Codeunit "Temp Blob";
                outs: OutStream;
                ins: InStream;
                fileName: text;
            begin
                fileName := 'DocumentoSoporte.zip';
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
                    field(pref; pref)
                    {
                        ApplicationArea = all;
                        caption = 'Prefijo';


                    }


                }
            }
        }

    }

    var
        parametres: Text;
        zip: Codeunit "Data Compression";

        pref: text;
}