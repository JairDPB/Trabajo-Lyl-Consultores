/// <summary>
/// Ventana de reporte para generar varios reportes de nota credito en forma masiva en un zip
/// </summary>
report 50117 "D365LNotaCreditoMasivo"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Nota Credito Masivo';


    dataset
    {
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
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
                crMemo: Record "Purch. Cr. Memo Hdr.";

            begin
                crMemo := "Purch. Cr. Memo Hdr.";
                crMemo.SetRange("No.", "Purch. Cr. Memo Hdr."."No."); // ajusta al campo que uses
                crMemo.SetFilter("Document Date", "Purch. Cr. Memo Hdr.".GetFilter("Document Date"));

                tempBlob.CreateOutStream(outs);
                recRef.GetTable(crMemo);
                Report.SaveAs(Report::"D365L NotaCredito", '', ReportFormat::Pdf, outs, recRef);

                tempBlob.CreateInStream(ins);
                zip.AddEntry(ins, "Purch. Cr. Memo Hdr."."No." + '.pdf');
            end;

            trigger OnPostDataItem()
            var
                tempBlob: Codeunit "Temp Blob";
                outs: OutStream;
                ins: InStream;
                fileName: text;
            begin
                fileName := 'NotaCredito.zip';
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