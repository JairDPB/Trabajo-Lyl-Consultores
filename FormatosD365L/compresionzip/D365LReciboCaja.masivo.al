report 50118 "D365LReciboCajaMasivo"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Recibo Caja Masivo';

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
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
                cashRec: Record "Cust. Ledger Entry";
            begin
                cashRec := "Cust. Ledger Entry";
                cashRec.SetRange("Document No.", "Cust. Ledger Entry"."Document No."); // u otro campo identificador
                cashRec.SetFilter("Posting Date", "Cust. Ledger Entry".GetFilter("Posting Date"));

                tempBlob.CreateOutStream(outs);
                recRef.GetTable(cashRec);
                Report.SaveAs(Report::"D365L Recibo Caja", '', ReportFormat::Pdf, outs, recRef);

                tempBlob.CreateInStream(ins);
                zip.AddEntry(ins, "Cust. Ledger Entry"."Document No." + '.pdf');
            end;

            trigger OnPostDataItem()
            var
                tempBlob: Codeunit "Temp Blob";
                outs: OutStream;
                ins: InStream;
                fileName: Text;
            begin
                fileName := 'RecibosCaja.zip';
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
