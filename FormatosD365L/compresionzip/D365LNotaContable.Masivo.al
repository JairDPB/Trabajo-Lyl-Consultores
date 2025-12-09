report 50111 "D365LNotaContableMasivo"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Nota Contable Masivo';

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            RequestFilterFields = "Posting Date";

            trigger OnPreDataItem()
            begin
                if pref <> '' then
                    SetFilter("Document No.", pref + '*');

                zip.CreateZipArchive();
            end;

            trigger OnAfterGetRecord()
            var
                tempBlob: Codeunit "Temp Blob";
                outs: OutStream;
                ins: InStream;
                recRef: RecordRef;
                journalLine: Record "Gen. Journal Line";
            begin
                journalLine := "Gen. Journal Line";
                journalLine.SetRange("Document No.", "Gen. Journal Line"."Document No.");
                journalLine.SetFilter("Posting Date", "Gen. Journal Line".GetFilter("Posting Date"));

                tempBlob.CreateOutStream(outs);
                recRef.GetTable(journalLine);
                Report.SaveAs(Report::"D365LNotaContable", '', ReportFormat::Pdf, outs, recRef);

                tempBlob.CreateInStream(ins);
                zip.AddEntry(ins, "Gen. Journal Line"."Document No." + '.pdf');
            end;

            trigger OnPostDataItem()
            var
                tempBlob: Codeunit "Temp Blob";
                outs: OutStream;
                ins: InStream;
                fileName: Text;
            begin
                fileName := 'NotasContables.zip';
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
        validationList: List of [Text];
}
