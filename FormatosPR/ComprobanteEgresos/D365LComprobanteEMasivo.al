report 60101 "D365LComprobanteEgresosMasivo"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    //  ApplicationArea = All;
    Caption = 'Comprobante Egresos Masivo';

    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            RequestFilterFields = "Document Date";
            trigger OnPreDataItem()
            var
            //statement: Report "D365L Comprobante Egresos";
            begin
                // parametres := statement.RunRequestPage();
                // if parametres = '' then
                // Error('Debe seleccionar un rango de fecha');
                SetRange("Document Type", "Vendor Ledger Entry"."Document Type"::Payment);
                SetFilter("Document No.", pref + '*');

                zip.CreateZipArchive();
            end;

            trigger OnAfterGetRecord()
            var
                tempBlob: Codeunit "Temp Blob";
                outs: OutStream;
                ins: InStream;
                ref: RecordRef;
                fr: FieldRef;

            begin
                tempBlob.CreateOutStream(outs);
                ref.Open(Database::"Vendor Ledger Entry");
                fr := ref.Field(6);
                fr.SetRange("Vendor Ledger Entry"."Document No.");
                fr := ref.Field(62);
                fr.SetFilter("Vendor Ledger Entry".GetFilter("Document Date"));

                Report.SaveAs(Report::EgresosReport, parametres, ReportFormat::Pdf, outs, ref);
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