/// <summary>
/// Ventana de reporte para generar varios reportes de caja menor en forma masiva en un zip
/// </summary>
report 50113 "D365LCajaMenorMasivo"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Caja Menor Masivo';


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
                ref: RecordRef;
                purchRec: Record "Purch. Inv. Header";
            begin
                // Crea un record filtrado para enviar al SaveAs
                purchRec.SetRange("No.", "Purch. Inv. Header"."No.");
                purchRec.SetFilter("Document Date", "Purch. Inv. Header".GetFilter("Document Date"));

                tempBlob.CreateOutStream(outs);

                // Convierte record en RecordRef
                ref.GetTable(purchRec);

                // Guarda el PDF
                Report.SaveAs(Report::"D365L Caja Menor", parametres, ReportFormat::Pdf, outs, ref);

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
                fileName := 'CajaMenor.zip';
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