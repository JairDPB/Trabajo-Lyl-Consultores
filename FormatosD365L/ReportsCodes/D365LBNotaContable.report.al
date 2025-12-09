/// <summary>
/// Reporte de Nota contable 
/// </summary>
report 50119 D365LNotaContable
{
    ApplicationArea = all;
    Caption = 'Nota Contable';
    RDLCLayout = 'Reports/D365LNotaContable.rdl';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;


    dataset
    {
        dataitem(G_LEntry; "G/L Entry")
        {
            DataItemTableView = SORTING("Document No.");

            column(G_LEntDebit_Amount; "Debit Amount") { }
            column(Entry_No_; "Entry No.") { }
            column(CompanyInfoName; CompanyInformation.Name) { }
            column(CompanyInfoVat; CompanyInformation."VAT Registration No.") { }
            column(CompanyInfoAddress; CompanyInformation.Address) { }
            column(CompanyInfoPhone; CompanyInformation."Phone No.") { }
            column(CompanyInfoEMail; CompanyInformation."E-Mail") { }
            column(CompanyInfoPicture; CompanyInformation.Picture) { }
            column(G_LEntCredit_Amount; "Credit Amount") { }
            column(G_LEnt_Account_No; "G/L Account No.") { }
            column(nitocc; "D365L CO Third No.") { }
            column(G_LEntDocument_No_; "Document No.") { }
            column(nombretercero; nombretercero) { }
            column(Description; Description) { }
            column(External_Document_No_; "External Document No.") { }
            column(Posting_Date; "Posting Date") { }

            dataitem("G/L Account"; "G/L Account")
            {
                DataItemTableView = SORTING("No.");
                DataItemLinkReference = G_LEntry;
                DataItemLink = "No." = field("G/L Account No.");
                column(G_LAccName; Name)
                {

                }
                dataitem(User; User)
                {
                    DataItemTableView = SORTING("User Security ID");
                    DataItemLinkReference = G_LEntry;
                    DataItemLink = "User Name" = field("User ID");
                    column(User_Security_ID; "User Security ID")
                    {

                    }
                    column(User_Name; "Full Name")
                    {

                    }
                }






            }
            trigger OnAfterGetRecord()
            var
                seg: Record Customer;
                dimv: Record Vendor;

            begin
                //nitocc := '';
                nombretercero := '';
                //seg.SetFilter("Dimension Set ID", '%1', "Purch. Inv. Header"."Dimension Set ID");
                if G_LEntry."D365L CO Third No." <> '' then begin
                    seg.SetFilter("No.", G_LEntry."D365L CO Third No.");
                    //seg.SetFilter("Dimension Set ID", '%1', G_LEntry."Dimension Set ID");
                    if seg.FindFirst() then begin
                        nombretercero := seg.Name;
                    end else begin
                        dimv.SetFilter("No.", G_LEntry."D365L CO Third No.");
                        if dimv.FindFirst() then begin
                            nombretercero := dimv.Name;
                        end;

                    end;
                end;

            end;

            trigger OnPreDataItem()
            begin

                if NoValor <> '' then begin
                    SetFilter("Document No.", NoValor);
                end /*else
                    Error('Debe seleccionar un documento');*/
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

                    field(NoValor; NoValor)
                    {
                        ApplicationArea = All;
                        Caption = 'No. Documento';
                        ShowMandatory = true;

                        trigger OnDrillDown()
                        var
                            dim: Record "G/L Entry";
                            pag: Page "General Ledger Entries";
                        begin
                            pag.SETTABLEVIEW(dim);
                            pag.LOOKUPMODE(TRUE);
                            IF pag.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                pag.GETRECORD(dim);
                                NoValor := dim."Document No.";
                            end;
                        end;

                    }
                }
            }
        }
    }
    trigger OnInitReport()
    begin
        CompanyInformation.SetAutoCalcFields(Picture);
        CompanyInformation.get();
    end;
    /// <summary>
    /// Procedimiento para validar el filtro del documento
    /// </summary>
    /// <param name="CodDoc">Recibe el documento a validar</param>
    procedure setValueFilter(CodDoc: Code[20])
    var
        myInt: Integer;
    begin
        NoValor := CodDoc;
    end;

    var
        nombretercero: text[100];
        nitocc: text[20];
        NoValor: Code[30];
        CompanyInformation: Record "Company Information";
}