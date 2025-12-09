/// <summary>
/// Ventana de reporte para generar varios reportes de Recibo de caja en forma masiva en un zip
/// </summary>
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
                recRef: RecordRef;
                cashRec: Record "Cust. Ledger Entry";
            begin
                cashRec := "Cust. Ledger Entry";
                cashRec.SetRange("Document No.", "Cust. Ledger Entry"."Document No."); // u otro campo identificador
                cashRec.SetFilter("Document Date", "Cust. Ledger Entry".GetFilter("Document Date"));

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
                fileName: text;
            begin
                fileName := 'ReciboCaja.zip';
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