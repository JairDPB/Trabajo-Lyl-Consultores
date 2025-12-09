///<summary>
///Reporte de comprobante de movimientos bancarios tanto debitos como creditos
///</summary>
report 50148 "D365L Comprobante De Bancos"
{
    ApplicationArea = All;
    Caption = 'Comprobante Bancario';
    RDLCLayout = 'Reports/D365LComprobantedebancos.rdl';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(BankAccLedEnt; "Bank Account Ledger Entry")
        {
            DataItemTableView = SORTING("Document No.");

            column(BankAccLedEntDescription; Description) { }
            column(BankAccLedEntDocument_No_; "Document No.") { }
            column(BankAccLedEntBal__Account_No_; "Bal. Account No.") { }
            column(BankAccLedEntNo_; "Entry No.") { }
            column(BankAccLedEntbankaccountNo; "Bank Account No.") { }
            column(DimensionSetID; "Dimension Set ID") { }
            column(BankAccLedEntAmount; Amount) { }
            column(BankAccLedEntRemaining_Amount; "Remaining Amount") { }
            column(BankAccLedEntUser_ID; "User ID") { }
            column(BankAccLedEntDocument_Date; "Document Date") { }
            column(BankAccLedEntAmountInWords; AmountInWords) { }
            column(BankAccLedEntValor; valor) { }
            column(BankAccLedEntCurrency_Code; currency_Txt) { }
            column(CompanyInfoName; CompanyInformation.Name) { }
            column(CompanyInfoVat; CompanyInformation."VAT Registration No.") { }
            column(CompanyInfoAddress; CompanyInformation.Address) { }
            column(CompanyInfoPhone; CompanyInformation."Phone No.") { }
            column(CompanyInfoEMail; CompanyInformation."E-Mail") { }
            column(CompanyInfoPicture; CompanyInformation.Picture) { }
            column(BankAccLedEntPosting_Date; "Posting Date") { }

            dataitem(User; User)
            {
                DataItemTableView = SORTING("User Security ID");
                DataItemLink = "User Name" = field("User ID");
                column(User_Security_ID; "User Security ID")
                {

                }
                column(User_Name; "Full Name")
                {

                }
            }

            dataitem("Bank Account"; "Bank Account")
            {
                DataItemTableView = SORTING("No.");
                // DataItemLinkReference = BankAccLedEnt;
                DataItemLink = "No." = field("Bank Account No.");
                column(BankAccountNoNo; "No.") { }
                column(BankAccLedEntbank; Name) { }

            }
            dataitem(G_LEntry; "G/L Entry")
            {
                DataItemTableView = SORTING("Document No.");

                DataItemLink = "Document No." = field("Document No.");
                column(G_LEntDebit_Amount; "Debit Amount") { }
                column(Entry_No_; "Entry No.") { }
                column(G_LEntCredit_Amount; "Credit Amount") { }
                column(G_LEnt_Account_No; "G/L Account No.") { }
                column(nitocc; nitocc) { }
                column(nombretercero; nombretercero) { }
                dataitem("G/L Account"; "G/L Account")
                {
                    DataItemTableView = SORTING("No.");
                    DataItemLinkReference = G_LEntry;
                    DataItemLink = "No." = field("G/L Account No.");
                    column(G_LAccName; Name)
                    {

                    }
                    trigger OnAfterGetRecord()
                    var
                        seg: Record "Dimension Set Entry";
                        dimv: Record "Dimension Value";

                    begin
                        nitocc := '';
                        nombretercero := '';
                        //seg.SetFilter("Dimension Set ID", '%1', "Purch. Inv. Header"."Dimension Set ID");
                        seg.SetFilter("Dimension Code", 'TERCERO');
                        seg.SetFilter("Dimension Set ID", '%1', G_LEntry."Dimension Set ID");
                        if seg.FindFirst() then begin
                            dimv.SetFilter(Code, seg."Dimension Value Code");
                            if dimv.FindFirst() then begin
                                nombretercero := dimv."Name";
                            end;
                            nitocc := seg."Dimension Value Code";

                        end;
                    end;



                }
            }

            trigger OnAfterGetRecord()
            var
                AmountText: array[2] of Text;
                txtCharsToKeep: Text;
                txtCharsToKeepNumeric: Text;
                currencys: Text;
                amounts: Integer;
                numberToText: Codeunit "LyL NumberToText_ING";
                vat: Decimal;
                totalAmount: Decimal;
            begin
                //bank := getBanks("Document No.");

                totalAmount := BankAccLedEnt.Amount;
                if (totalAmount < 0) then begin
                    totalAmount := totalAmount * -1;
                end;

                currencys := Format("Currency Code");
                if (currencys = '') or (currencys = 'COP') then begin
                    currency_Txt := 'COP'
                end ELSE begin
                    currency_Txt := Format("Currency Code");
                end;
                currency := currency_Txt;

                numberToText.FormatNoText(AmountText, totalAmount, currency_Txt);
                AmountInWords := AmountText[1] + AmountText[2];

                if currency = 'COP' then begin
                    if not AmountInWords.Contains(' PESOS ') then begin
                        AmountInWords := AmountText[1] + ' PESOS ' + AmountText[2];
                    end;
                end;
                if currency = 'USD' then begin
                    if not AmountInWords.Contains(' DOLARES ') then begin
                        AmountInWords := AmountText[1] + ' DOLARES' + AmountText[2];
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
                            dim: Record "Bank Account Ledger Entry";
                            pag: Page "Bank Account Ledger Entries";
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

    /*local procedure getBanks(documentNo: Code[20]): Text
    var
        total: Decimal;
        v: Record "Bank Account";
        GLEntry: Record "G/L Entry";
    begin
        GLEntry.SetFilter("Document No.", documentNo);
        GLEntry.SetFilter("Source Type", '%1', GLEntry."Source Type"::"Bank Account");
        if (GLEntry.FindFirst()) THEN begin
            v.SetFilter("No.", GLEntry."Source No.");
            if (v.FindFirst()) then begin
                exit(v.Name)
            end;
        end else begin
            exit('');
        end;

    end;*/




    var
        nombretercero: text[100];
        nitocc: text[20];
        Tax01: Decimal;
        Tax05: Decimal;
        Tax06: Decimal;
        Tax07: Decimal;
        //TempNoSeriesLine: Record "No. Series Line";
        CompanyInformation: Record "Company Information";
        AmountInWords: Text;
        AmountInWordsC: Text;
        NoText: array[2] of Text;
        Stream: InStream;

        VATEntry_Amount: Decimal;
        totalAmount_: decimal;
        cuenta1: Code[20];

        VATEntry_DianDesc: Text[100];
        NoValor: Code[30];

        lylQueryGeneralTax: Query "D365L GeneralTaxQuery";
        observation: Text[100];
        amountRound: Decimal;
        currency_Txt: text;
        valor: decimal;
        numero: Code[20];
        Nombre: Text[50];
        bank: Text;
        TERCERO: CODE[20];
        currencyText: text[50];
        currency: text[50];
}