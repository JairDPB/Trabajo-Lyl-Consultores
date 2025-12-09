report 50114 "D365LComprobanteBancarioMasivo"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Comprobante Bancario Masivo';

    dataset
    {
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
            RequestFilterFields = "Document Date";

            trigger OnPreDataItem()
            begin
                // Prepara el filtro "Document No." si el usuario lo pasó en pref
                if pref <> '' then
                    SetFilter("Document No.", '(' + pref + '* )');
                zip.CreateZipArchive();
            end;

            trigger OnAfterGetRecord()
            var
                tempBlob: Codeunit "Temp Blob";
                outs: OutStream;
                ins: InStream;
                recRef: RecordRef;
                bankRecFiltered: Record "Bank Account Ledger Entry";
            begin
                // Prepara un registro filtrado con la Document No. del registro actual
                bankRecFiltered := "Bank Account Ledger Entry";
                bankRecFiltered.SetRange("Document No.", "Bank Account Ledger Entry"."Document No.");
                bankRecFiltered.SetFilter("Document Date", "Bank Account Ledger Entry".GetFilter("Document Date"));

                // Guarda el sub-report en tempBlob y luego en el ZIP
                tempBlob.CreateOutStream(outs);
                recRef.GetTable(bankRecFiltered);
                // Llama al report que genera el comprobante bancario en PDF
                Report.SaveAs(Report::"D365L Comprobante De Bancos", '', ReportFormat::Pdf, outs, recRef);

                tempBlob.CreateInStream(ins);
                zip.AddEntry(ins, "Bank Account Ledger Entry"."Document No." + '.pdf');
            end;

            trigger OnPostDataItem()
            var
                tempBlob: Codeunit "Temp Blob";
                outs: OutStream;
                ins: InStream;
                fileName: Text;
            begin
                fileName := 'ComprobanteBancario.zip';
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
                        ToolTip = 'Prefijo o patrón para Document No. (ej: BAN* o BAN001|BAN002)';
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
//ya cree mi repositorio git