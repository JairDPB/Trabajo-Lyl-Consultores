/// <summary>
/// Ventana de reporte para generar varios reportes de Nota contable en forma masiva en un zip
/// </summary>
report 50120 "D365LNotaContableMasivo"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Nota Contable Masivo';


    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
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
                    SetFilter("Document No.", pref + '*');

                zip.CreateZipArchive();
            end;

            trigger OnAfterGetRecord()
            var
                tempBlob: Codeunit "Temp Blob";
                outs: OutStream;
                ins: InStream;
                ref: RecordRef;
                recRef: RecordRef;
                GLEntryRec: Record "G/L Entry";

            begin
                GLEntryRec:="G/L Entry";
                GLEntryRec.SetRange("Document No.","G/L Entry"."Document No.");
                GLEntryRec.SetFilter("Document Date","G/L Entry".GetFilter("Document Date"));

                tempBlob.CreateOutStream(outs);
                recRef.GetTable(GLEntryRec);
                Report.SaveAs(Report::"D365LNotaContable", '', ReportFormat::Pdf, outs, recRef);

                tempBlob.CreateInStream(ins);
                zip.AddEntry(ins, "G/L Entry"."Document No." + '.pdf');
                
            end;

            trigger OnPostDataItem()
            var
                tempBlob: Codeunit "Temp Blob";
                outs: OutStream;
                ins: InStream;
                fileName: text;
            begin
                fileName := 'NotaContable.zip';
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

        validationList: List of [text];
}