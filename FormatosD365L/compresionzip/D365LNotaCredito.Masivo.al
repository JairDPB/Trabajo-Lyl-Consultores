report 50117 "D365LNotaCreditoMasivo"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Nota Crédito Masivo';

    dataset
    {
        dataitem("Purch. Cr. Memo Header"; "Purch. Cr. Memo Hdr.")
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
                crMemo: Record "Purch. Cr. Memo Hdr.";
            begin
                crMemo := "Purch. Cr. Memo Header";
                crMemo.SetRange("No.", "Purch. Cr. Memo Header"."No."); // ajusta al campo que uses
                crMemo.SetFilter("Document Date", "Purch. Cr. Memo Header".GetFilter("Document Date"));

                tempBlob.CreateOutStream(outs);
                recRef.GetTable(crMemo);
                Report.SaveAs(Report::"D365L NotaCredito", '', ReportFormat::Pdf, outs, recRef);

                tempBlob.CreateInStream(ins);
                zip.AddEntry(ins, "Purch. Cr. Memo Header"."No." + '.pdf');
            end;

            trigger OnPostDataItem()
            var
                tempBlob: Codeunit "Temp Blob";
                outs: OutStream;
                ins: InStream;
                fileName: Text;
            begin
                fileName := 'NotasCredito.zip';
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
