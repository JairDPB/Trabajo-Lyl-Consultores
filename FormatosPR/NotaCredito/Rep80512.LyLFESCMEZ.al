report 60104 "LyL FESCM_EZ"
{
    WordLayout = './Reports/LyL_CM_Sis.docx';
    Caption = 'D365LATAM Nota credito venta';
    DefaultLayout = Word;
    Permissions = TableData "Sales Shipment Buffer" = rimd;
    PreviewMode = PrintLayout;
    WordMergeDataItem = Header;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Header; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Credit Memo';
            column(ConceptoDes; ConceptoDes) { }
            column(numLineas; numLineas) { }
            column(Moneda; Moneda) { }
            column(TasaCambio; TasaCambio) { }
            column(FormaPago; FormaPago) { }
            column(piedepag3; '') { }
            column(cufeDocref; cufeDocref) { }
            column(linestotalamountcop; linestotalamountcop) { }
            column(invoicediscuountamountcop; invoicediscuountamountcop) { }
            column(Vatentryamountcop; Vatentryamountcop) { }
            column(countroundcop; countroundcop) { }
            column(CompanyAddress1; CompanyInfo.Name)
            {
            }
            column(CompanyAddress2; CompanyInfo.Address)
            {
            }
            column(CompanyAddress3; CompanyAddr[3])
            {
            }
            column(CompanyAddress4; CompanyAddr[4])
            {
            }
            column(CompanyAddress5; CompanyAddr[5])
            {
            }
            column(CompanyAddress6; CompanyAddr[6])
            {
            }
            column(CompanyHomePage; CompanyInfo."Home Page")
            {
            }
            column(CompanyEMail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyPicture; DummyCompanyInfo.Picture)
            {
            }
            column(CompanyPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyPhoneNo_Lbl; CompanyInfoPhoneNoLbl)
            {
            }
            column(CompanyGiroNo; CompanyInfo."Giro No.")
            {
            }
            column(CompanyGiroNo_Lbl; CompanyInfoGiroNoLbl)
            {
            }
            column(CompanyBankName; CompanyInfo."Bank Name")
            {
            }
            column(CompanyBankName_Lbl; CompanyInfoBankNameLbl)
            {
            }
            column(CompanyBankBranchNo; CompanyInfo."Bank Branch No.")
            {
            }
            column(CompanyBankBranchNo_Lbl; CompanyInfo.FieldCaption("Bank Branch No."))
            {
            }
            column(CompanyBankAccountNo; CompanyInfo."Bank Account No.")
            {
            }
            column(CompanyBankAccountNo_Lbl; CompanyInfoBankAccNoLbl)
            {
            }
            column(CompanyIBAN; CompanyInfo.IBAN)
            {
            }
            column(CompanyIBAN_Lbl; CompanyInfo.FieldCaption(IBAN))
            {
            }
            column(CompanySWIFT; CompanyInfo."SWIFT Code")
            {
            }
            column(CompanySWIFT_Lbl; CompanyInfo.FieldCaption("SWIFT Code"))
            {
            }
            column(CompanyLogoPosition; CompanyLogoPosition)
            {
            }
            column(CompanyRegistrationNumber; CompanyInfo.GetRegistrationNumber)
            {
            }
            column(CompanyRegistrationNumber_Lbl; CompanyInfo.GetRegistrationNumberLbl)
            {
            }
            column(CompanyVATRegNo; CompanyInfo.GetVATRegistrationNumber)
            {
            }
            column(CompanyVATRegNo_Lbl; CompanyInfo.GetVATRegistrationNumberLbl)
            {
            }
            column(CompanyVATRegistrationNo; CompanyInfo.GetVATRegistrationNumber)
            {
            }
            column(CompanyVATRegistrationNo_Lbl; CompanyInfo.GetVATRegistrationNumberLbl)
            {
            }

            column(CompanyLegalStatement; GetLegalStatement)
            {
            }
            column(CustomerAddress1; CustomerRc.Name + ' ' + CustomerRc."D365L PR Last Name")
            {
            }
            column(CustomerAddress2; CustAddr[2])
            {
            }
            column(CustomerAddress3; CustAddr[3])
            {
            }
            column(CustomerAddress4; CustAddr[4])
            {
            }
            column(CustomerAddress5; CustAddr[5])
            {
            }
            column(CustomerAddress6; CustAddr[6])
            {
            }
            column(CustomerAddress7; CustAddr[7])
            {
            }
            column(CustomerAddress8; CustAddr[8])
            {
            }
            column(SellToContactPhoneNoLbl; SellToContactPhoneNoLbl)
            {
            }
            column(SellToContactMobilePhoneNoLbl; SellToContactMobilePhoneNoLbl)
            {
            }
            column(SellToContactEmailLbl; SellToContactEmailLbl)
            {
            }
            column(BillToContactPhoneNoLbl; BillToContactPhoneNoLbl)
            {
            }
            column(BillToContactMobilePhoneNoLbl; BillToContactMobilePhoneNoLbl)
            {
            }
            column(BillToContactEmailLbl; BillToContactEmailLbl)
            {
            }
            column(SellToContactPhoneNo; SellToContact."Phone No.")
            {
            }
            column(SellToContactMobilePhoneNo; SellToContact."Mobile Phone No.")
            {
            }
            column(SellToContactEmail; SellToContact."E-Mail")
            {
            }
            column(BillToContactPhoneNo; BillToContact."Phone No.")
            {
            }
            column(BillToContactMobilePhoneNo; BillToContact."Mobile Phone No.")
            {
            }
            column(BillToContactEmail; BillToContact."E-Mail")
            {
            }
            column(CustomerPostalBarCode; FormatAddr.PostalBarCode(1))
            {
            }
            column(YourReference; "Your Reference")
            {
            }
            column(YourReference_Lbl; FieldCaption("Your Reference"))
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(ExternalDocumentNoLbl; FieldCaption("External Document No."))
            {
            }
            column(ShipmentMethodDescription; ShipmentMethod.Description)
            {
            }
            column(ShipmentMethodDescription_Lbl; ShptMethodDescLbl)
            {
            }
            column(ShipmentDate; Format("Shipment Date", 0, 4))
            {
            }
            column(ShipmentDate_Lbl; FieldCaption("Shipment Date"))
            {
            }
            column(Shipment_Lbl; ShipmentLbl)
            {
            }
            column(ShowShippingAddress; ShowShippingAddr)
            {
            }
            column(ShipToAddress_Lbl; ShiptoAddrLbl)
            {
            }
            column(ShipToAddress1; ShipToAddr[1])
            {
            }
            column(ShipToAddress2; ShipToAddr[2])
            {
            }
            column(ShipToAddress3; ShipToAddr[3])
            {
            }
            column(ShipToAddress4; ShipToAddr[4])
            {
            }
            column(ShipToAddress5; ShipToAddr[5])
            {
            }
            column(ShipToAddress6; ShipToAddr[6])
            {
            }
            column(ShipToAddress7; ShipToAddr[7])
            {
            }
            column(ShipToAddress8; ShipToAddr[8])
            {
            }
            column(PaymentTermsDescription; PaymentTerms.Description)
            {
            }
            column(PaymentTermsDescription_Lbl; PaymentTermsDescLbl)
            {
            }
            column(PaymentMethodDescription; PaymentMethod.Description)
            {
            }
            column(PaymentMethodDescription_Lbl; PaymentMethodDescLbl)
            {
            }
            column(BilltoCustumerNo; "Bill-to Customer No.")
            {
            }
            column(BilltoCustumerNo_Lbl; FieldCaption("Bill-to Customer No."))
            {
            }
            column(DocumentDate; Format("Document Date", 0, 4))
            {
            }
            column(DocumentDate_Lbl; FieldCaption("Document Date"))
            {
            }
            column(DueDate; Format("Due Date", 0, 4))
            {
            }
            column(DueDate_Lbl; FieldCaption("Due Date"))
            {
            }
            column(DocumentNo; "No.")
            {
            }
            column(DocumentNo_Lbl; InvNoLbl)
            {
            }
            column(AppliesToDocument; AppliesToText)
            {
            }
            column(AppliesToDocument_Lbl; AppliesToTextLbl)
            {
            }
            column(PricesIncludingVAT; "Prices Including VAT")
            {
            }
            column(PricesIncludingVAT_Lbl; FieldCaption("Prices Including VAT"))
            {
            }
            column(PricesIncludingVATYesNo; Format("Prices Including VAT"))
            {
            }
            column(SalesPerson_Lbl; SalespersonLbl)
            {
            }
            column(SalesPersonBlank_Lbl; SalesPersonText)
            {
            }
            column(SalesPersonName; SalespersonPurchaser.Name)
            {
            }
            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
            }
            column(SelltoCustomerNo_Lbl; FieldCaption("Sell-to Customer No."))
            {
            }
            column(VATRegistrationNo; GetCustomerVATRegistrationNumber)
            {
            }
            column(VATRegistrationNo_Lbl; GetCustomerVATRegistrationNumberLbl)
            {
            }
            column(GlobalLocationNumber; GetCustomerGlobalLocationNumber)
            {
            }
            column(GlobalLocationNumber_Lbl; GetCustomerGlobalLocationNumberLbl)
            {
            }
            /* column(LegalEntityType; Cust.GetLegalEntityType)
             {
             }
             column(LegalEntityType_Lbl; Cust.GetLegalEntityTypeLbl)
             {
             }*/
            column(Copy_Lbl; CopyLbl)
            {
            }
            column(EMail_Header_Lbl; EMailLbl)
            {
            }
            column(HomePage_Header_Lbl; HomePageLbl)
            {
            }
            column(InvoiceDiscountBaseAmount_Lbl; InvDiscBaseAmtLbl)
            {
            }
            column(InvoiceDiscountAmount_Lbl; InvDiscountAmtLbl)
            {
            }
            column(LineAmountAfterInvoiceDiscount_Lbl; LineAmtAfterInvDiscLbl)
            {
            }
            column(LocalCurrency_Lbl; LocalCurrencyLbl)
            {
            }
            column(ExchangeRateASText; ExchangeRateText)
            {
            }
            column(Page_Lbl; PageLbl)
            {
            }
            column(SalesInvoiceLineDiscount_Lbl; SalesInvLineDiscLbl)
            {
            }
            column(DocumentTitle_Lbl; SalesCreditMemoLbl)
            {
            }
            column(ShowWorkDescription; ShowWorkDescription)
            {
            }
            column(Subtotal_Lbl; SubtotalLbl)
            {
            }
            column(Total_Lbl; TotalLbl)
            {
            }
            column(VATAmount_Lbl; VATAmtLbl)
            {
            }
            column(VATBase_Lbl; VATBaseLbl)
            {
            }
            column(VATAmountSpecification_Lbl; VATAmtSpecificationLbl)
            {
            }
            column(VATClauses_Lbl; VATClausesLbl)
            {
            }
            column(VATIdentifier_Lbl; VATIdentifierLbl)
            {
            }
            column(VATPercentage_Lbl; VATPercentageLbl)
            {
            }
            column(VATClause_Lbl; VATClause.TableCaption)
            {
            }
            column(Posting_Description; "Posting Description") { }
            column(Ship_to_Name; "Ship-to Name") { }
            column(LinesTotalAmount; LinesTotalAmount) { }
            column(amountRound; amountRound) { }
            column(AmountInWords; AmountInWords) { }
            column(Departament; sPostCode) { }
            column(LyL_CUFE; '') { }
            column(CustEmail; Cust."E-Mail") { }
            column(CustAddress; Cust.Address) { }
            column(CustPhone; Cust."Phone No.") { }
            column(CustCity; Cust.City) { }
            column(lblCustommerAddress; CustommerAddress) { }
            column(lblCustommerPhone; CustommerPhone) { }
            column(lblCustommerCity; CustommerCity) { }
            column(NoSerieLine_StartDate; NoSerieLine."Starting Date") { }
            column(NoSerieLine_EndDate; NoSerieLine."D365L PR Res. Ending Date") { }
            column(NoSerieLine_Resolution; NoSerieLine."D365L PR Resolution No.") { }
            column(NoSerieLine_startNo; NoSerieLine."Starting No.") { }
            column(NoSerieLine_endNo; NoSerieLine."Ending No.") { }
            column(CompanyPhone; CompanyPhone) { }
            column(lblClient; lblClient) { }
            column(lblNoAutorizacion; lblNoAutorizacion) { }
            column(lblRangoAut; lblRangoAut) { }
            column(lblRangoAutEnd; lblRangoAutEnd) { }
            column(lblValidity; lblValidity) { }
            column(LyL_QrCode; '') { }
            column(CompanyInfo_txtEconomicActivity; '') { }
            column(CompanyInfo_txtTaxes; '') { }
            column(CompanyInfo_RetentionText; '') { }
            column(lblCustommerEmail; CustommerEmail) { }
            column(DIAN_RegimeDesc; DIAN_RegimeDesc) { }
            column(DIAN_EmisorType; DIAN_EmisorType) { }
            column(Resp_DIAN; '') { }
            column(Prefix; DocumentPrefix) { }
            column(customerRespons; CustomerRespon) { }
            column(CustomerEntityType; CustomerEntityType) { }
            column(CustomerIdentityType; CustomerIdentityType) { }
            column(Observation; Observation) { }
            //    column(LyL_Date_load; Format("D365L CO Date_load", 0, 4)) { }
            //    column(G2LCO_No__Corrected_Doc__FR; "LYLFE_CO No. Corr. Doc. FR") { }
            dataitem(Line; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = Header;
                DataItemTableView = SORTING("Document No.", "Line No.");
                column(LineNo_Line; "Line No.")
                {
                }
                column(AmountExcludingVAT_Line; Amount)
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(AmountExcludingVAT_Line_Lbl; FieldCaption(Amount))
                {
                }
                column(AmountIncludingVAT_Line; "Amount Including VAT")
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(AmountIncludingVAT_Line_Lbl; FieldCaption("Amount Including VAT"))
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(Description_Line; Line.LyLExtDescription)
                {
                }
                column(Description_Line_Lbl; FieldCaption(Description))
                {
                }
                column(LineDiscountPercent_Line; "Line Discount %")
                {
                }
                column(LineDiscountPercentText_Line; LineDiscountPctText)
                {
                }
                column(LineAmount_Line; FormattedLineAmount)
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(LineAmount_Line_Lbl; FieldCaption("Line Amount"))
                {
                }
                column(ItemNo_Line; "No.")
                {
                }
                column(ItemNo_Line_Lbl; FieldCaption("No."))
                {
                }
                column(ItemReferenceNo_Line; "Item Reference No.")
                {
                }
                column(ItemReferenceNo_Line_Lbl; FieldCaption("Item Reference No."))
                {
                }
                column(ShipmentDate_Line; Format("Shipment Date"))
                {
                }
                column(ShipmentDate_Line_Lbl; PostedShipmentDateLbl)
                {
                }
                column(Quantity_Line; FormattedQuantity)
                {
                }
                column(Quantity_Line_Lbl; FieldCaption(Quantity))
                {
                }
                column(Type_Line; Format(Type))
                {
                }
                column(UnitPrice; FormattedUnitPrice)
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 2;
                }
                column(UnitPrice_Lbl; FieldCaption("Unit Price"))
                {
                }
                column(UnitOfMeasure; "Unit of Measure")
                {
                }
                column(UnitOfMeasure_Lbl; FieldCaption("Unit of Measure"))
                {
                }
                column(VATIdentifier_Line; "VAT Identifier")
                {
                }
                column(VATIdentifier_Line_Lbl; FieldCaption("VAT Identifier"))
                {
                }
                column(VATPct_Line; FormattedVATPct)
                {
                }
                column(VATPct_Line_Lbl; FieldCaption("VAT %"))
                {
                }
                column(TransHeaderAmount; TransHeaderAmount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }


                dataitem(ShipmentLine; "Sales Shipment Buffer")
                {
                    DataItemTableView = SORTING("Document No.", "Line No.", "Entry No.");
                    UseTemporary = true;
                    column(DocumentNo_ShipmentLine; "Document No.")
                    {
                    }
                    column(PostingDate_ShipmentLine; "Posting Date")
                    {
                    }
                    column(PostingDate_ShipmentLine_Lbl; FieldCaption("Posting Date"))
                    {
                    }
                    column(Quantity_ShipmentLine; Quantity)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(Quantity_ShipmentLine_Lbl; FieldCaption(Quantity))
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                        SetRange("Line No.", Line."Line No.");
                    end;
                }
                dataitem(AssemblyLine; "Posted Assembly Line")
                {
                    DataItemTableView = SORTING("Document No.", "Line No.");
                    UseTemporary = true;
                    column(LineNo_AssemblyLine; "No.")
                    {
                    }
                    column(Description_AssemblyLine; Description)
                    {
                    }
                    column(Quantity_AssemblyLine; Quantity)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(UnitOfMeasure_AssemblyLine; GetUOMText("Unit of Measure Code"))
                    {
                    }
                    column(VariantCode_AssemblyLine; "Variant Code")
                    {
                    }

                    trigger OnPreDataItem()
                    var
                        ValueEntry: Record "Value Entry";
                    begin
                        Clear(AssemblyLine);
                        if not DisplayAssemblyInformation then
                            CurrReport.Break();
                        GetAssemblyLinesForDocument(
                          AssemblyLine, ValueEntry."Document Type"::"Sales Credit Memo", Line."Document No.", Line."Line No.");
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    InitializeSalesShipmentLine;
                    if Type = Type::"G/L Account" then
                        "No." := '';

                    if "Line Discount %" = 0 then
                        LineDiscountPctText := ''
                    else
                        LineDiscountPctText := StrSubstNo('%1%', -Round("Line Discount %", 0.1));

                    VATAmountLine.Init();
                    VATAmountLine."VAT Identifier" := "VAT Identifier";
                    VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                    VATAmountLine."Tax Group Code" := "Tax Group Code";
                    VATAmountLine."VAT %" := "VAT %";
                    VATAmountLine."VAT Base" := Amount;
                    VATAmountLine."Amount Including VAT" := "Amount Including VAT";
                    VATAmountLine."Line Amount" := "Line Amount";
                    if "Allow Invoice Disc." then
                        VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                    VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                    VATAmountLine."VAT Clause Code" := "VAT Clause Code";
                    VATAmountLine.InsertLine();

                    TransHeaderAmount += PrevLineAmount;
                    PrevLineAmount := "Line Amount";
                    TotalSubTotal += "Line Amount";
                    TotalInvDiscAmount -= "Inv. Discount Amount";
                    TotalAmount += Amount;
                    TotalAmountVAT += "Amount Including VAT" - Amount;
                    TotalAmountInclVAT += "Amount Including VAT";
                    TotalPaymentDiscOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");

                    FormatDocument.SetSalesCrMemoLine(Line, FormattedQuantity, FormattedUnitPrice, FormattedVATPct, FormattedLineAmount);

                    if FirstLineHasBeenOutput then
                        Clear(DummyCompanyInfo.Picture);
                    FirstLineHasBeenOutput := true;

                    /* LYL */
                    LinesTotalAmount := LinesTotalAmountExVat(Header."No.");
                    /*LYL*/
                end;

                trigger OnPreDataItem()
                begin
                    VATAmountLine.DeleteAll();
                    VATClauseLine.DeleteAll();
                    ShipmentLine.Reset();
                    ShipmentLine.DeleteAll();
                    MoreLines := Find('+');
                    while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do
                        MoreLines := Next(-1) <> 0;
                    if not MoreLines then
                        CurrReport.Break();
                    SetRange("Line No.", 0, "Line No.");
                    TransHeaderAmount := 0;
                    PrevLineAmount := 0;
                    FirstLineHasBeenOutput := false;
                    DummyCompanyInfo.Picture := CompanyInfo.Picture;
                end;
            }
            dataitem(WorkDescriptionLines; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 .. 99999));
                column(WorkDescriptionLineNumber; Number)
                {
                }
                column(WorkDescriptionLine; WorkDescriptionLine)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if WorkDescriptionInstream.EOS then
                        CurrReport.Break();
                    WorkDescriptionInstream.ReadText(WorkDescriptionLine);
                end;

                trigger OnPostDataItem()
                begin
                    Clear(WorkDescriptionInstream)
                end;

                trigger OnPreDataItem()
                begin
                    if not ShowWorkDescription then
                        CurrReport.Break();
                    Header."Work Description".CreateInStream(WorkDescriptionInstream, TEXTENCODING::UTF8);
                end;
            }
            dataitem(VATAmountLine; "VAT Amount Line")
            {
                DataItemTableView = SORTING("VAT Identifier", "VAT Calculation Type", "Tax Group Code", "Use Tax", Positive);
                UseTemporary = true;
                column(InvoiceDiscountAmount_VATAmountLine; "Invoice Discount Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(InvoiceDiscountAmount_VATAmountLine_Lbl; FieldCaption("Invoice Discount Amount"))
                {
                }
                column(InvoiceDiscountBaseAmount_VATAmountLine; "Inv. Disc. Base Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(InvoiceDiscountBaseAmount_VATAmountLine_Lbl; FieldCaption("Inv. Disc. Base Amount"))
                {
                }
                column(LineAmount_VatAmountLine; "Line Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(LineAmount_VatAmountLine_Lbl; FieldCaption("Line Amount"))
                {
                }
                column(VATAmount_VatAmountLine; "VAT Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATAmount_VatAmountLine_Lbl; FieldCaption("VAT Amount"))
                {
                }
                column(VATAmountLCY_VATAmountLine; VATAmountLCY)
                {
                }
                column(VATAmountLCY_VATAmountLine_Lbl; VATAmountLCYLbl)
                {
                }
                column(VATBase_VatAmountLine; "VAT Base")
                {
                    AutoFormatExpression = Line.GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(VATBase_VatAmountLine_Lbl; FieldCaption("VAT Base"))
                {
                }
                column(VATBaseLCY_VATAmountLine; VATBaseLCY)
                {
                }
                column(VATBaseLCY_VATAmountLine_Lbl; VATBaseLCYLbl)
                {
                }
                column(VATIdentifier_VatAmountLine; "VAT Identifier")
                {
                }
                column(VATIdentifier_VatAmountLine_Lbl; FieldCaption("VAT Identifier"))
                {
                }
                column(VATPct_VatAmountLine; "VAT %")
                {
                    DecimalPlaces = 0 : 5;
                }
                column(VATPct_VatAmountLine_Lbl; FieldCaption("VAT %"))
                {
                }
                column(NoOfVATIdentifiers; Count)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    VATBaseLCY :=
                      GetBaseLCY(
                        Header."Posting Date", Header."Currency Code",
                        Header."Currency Factor");
                    VATAmountLCY :=
                      GetAmountLCY(
                        Header."Posting Date", Header."Currency Code",
                        Header."Currency Factor");

                    TotalVATBaseLCY += VATBaseLCY;
                    TotalVATAmountLCY += VATAmountLCY;

                    if "VAT Clause Code" <> '' then begin
                        VATClauseLine := VATAmountLine;
                        if VATClauseLine.Insert() then;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    Clear(VATBaseLCY);
                    Clear(VATAmountLCY);

                    TotalVATBaseLCY := 0;
                    TotalVATAmountLCY := 0;
                end;
            }
            dataitem(VATClauseLine; "VAT Amount Line")
            {
                DataItemTableView = SORTING("VAT Identifier", "VAT Calculation Type", "Tax Group Code", "Use Tax", Positive);
                UseTemporary = true;
                column(VATIdentifier_VATClauseLine; "VAT Identifier")
                {
                }
                column(Code_VATClauseLine; VATClause.Code)
                {
                }
                column(Code_VATClauseLine_Lbl; VATClause.FieldCaption(Code))
                {
                }
                column(Description_VATClauseLine; VATClause.Description)
                {
                }
                column(Description2_VATClauseLine; VATClause."Description 2")
                {
                }
                column(VATAmount_VATClauseLine; "VAT Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(NoOfVATClauses; Count)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if "VAT Clause Code" = '' then
                        CurrReport.Skip();
                    if not VATClause.Get("VAT Clause Code") then
                        CurrReport.Skip();
                    VATClause.GetDescriptionText(Header);
                end;
            }
            dataitem(ReportTotalsLine; "Report Totals Buffer")
            {
                DataItemTableView = SORTING("Line No.");
                UseTemporary = true;
                column(Description_ReportTotalsLine; Description)
                {
                }
                column(Amount_ReportTotalsLine; Amount)
                {
                }
                column(AmountFormatted_ReportTotalsLine; "Amount Formatted")
                {
                }
                column(FontBold_ReportTotalsLine; "Font Bold")
                {
                }
                column(FontUnderline_ReportTotalsLine; "Font Underline")
                {
                }

                trigger OnPreDataItem()
                begin
                    CreateReportTotalLines;
                end;
            }
            dataitem(LetterText; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(GreetingText; GreetingLbl)
                {
                }
                column(BodyText; BodyLbl)
                {
                }
                column(ClosingText; ClosingLbl)
                {
                }
            }
            dataitem(Totals; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(TotalNetAmount; TotalAmount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalVATBaseLCY; TotalVATBaseLCY)
                {
                }
                column(TotalAmountIncludingVAT; TotalAmountInclVAT)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalVATAmount; TotalAmountVAT)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalVATAmountLCY; TotalVATAmountLCY)
                {
                }
                column(TotalInvoiceDiscountAmount; TotalInvDiscAmount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalPaymentDiscountOnVAT; TotalPaymentDiscOnVAT)
                {
                }
                column(TotalVATAmountText; VATAmountLine.VATAmountText)
                {
                }
                column(TotalExcludingVATText; TotalExclVATText)
                {
                }
                column(TotalIncludingVATText; TotalInclVATText)
                {
                }
                column(TotalSubTotal; TotalSubTotal)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalSubTotalMinusInvoiceDiscount; TotalSubTotal + TotalInvDiscAmount)
                {
                }
                column(TotalText; TotalText)
                {
                }
            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = sorting(number);
                column(VATEntry_DianDesc; VATEntry_DianDesc) { }
                column(VATEntry_Amount; VATEntry_Amount) { }
                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, 100);
                    lylQueryGeneralTax.TopNumberOfRows(100);
                    lylQueryGeneralTax.SetFilter(Document_No, Header."No.");
                    lylQueryGeneralTax.SetFilter(VATEntry_DianCode, '<>ZZ');
                    lylQueryGeneralTax.Open();
                end;

                trigger OnAfterGetRecord()
                var
                    listTax: List of [Code[20]];
                begin
                    if lylQueryGeneralTax.Read() then begin
                        if listTax.Contains(lylQueryGeneralTax.VATEntry_DianCode) = false then begin
                            listTax.Add(lylQueryGeneralTax.VATEntry_DianCode);
                            //  VATEntry_Amount := lylQueryGeneralTax.VATEntry_Amount;
                            VATEntry_Amount := calculateTotalTax(Header."No.", lylQueryGeneralTax.VATEntry_DianCode, lylQueryGeneralTax.VATEntry_tarifa) * (-1);
                            VATEntry_DianDesc := lylQueryGeneralTax.VATEntry_DianDesc + ' ' + Format(lylQueryGeneralTax.VATEntry_tarifa, 0, '<Integer><Decimals,4>') + '%';
                        end;
                    end
                    else begin
                        CurrReport.Skip();
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            var
                CurrencyExchangeRate: Record "Currency Exchange Rate";
                numberToText: Codeunit "LyL NumberToText_ING";
                AmountText: array[2] of Text;
                txtCharsToKeepNumeric: Text;
                sPostalCode: Text;
                Stream: InStream;
                txtCharsToKeep: Text;
                currency: Record Currency;
                payterms: record "Payment Terms";
                lines: Record "Sales Cr.Memo Line";
                SIH: Record "Sales Invoice Header";
                DIANSETUP: Record "D365L PR HACIENDA Setup";
            begin
                /*  SIH.SetFilter("No.", header."D365L PR FE No. Corr. Doc. FR");
                  if SIH.FindFirst() then begin
                      cufeDocref := SIH."D365L CO FE CUFE";
                  end;*/
                Moneda := 'USD';
                TasaCambio := 0;
                lines.SetFilter("Document No.", "Header"."No.");
                numLineas := lines.Count();
                if ("Header"."Payment Terms Code" <> '') then begin
                    payterms.SetFilter(code, "Header"."Payment Terms Code");
                    if payterms.FindFirst() then begin
                        if payterms.Code <> 'CONTADO' then
                            FormaPago := 'CREDITO';
                        if payterms.code = 'CONTADO' then
                            FormaPago := Header."Payment Terms Code";
                    end;
                end;

                if Header."Currency Factor" <> 0 then begin
                    if (Header."Currency Code" <> '') and (Header."Currency Code" <> 'USD') then begin
                        TasaCambio := 1 / Header."Currency Factor";

                    end;
                end;
                ConceptoDes := '';
                /*DIANSETUP.SetFilter("DIAN Code", Header."D365L CO FE Concept DIAN");
                DIANSETUP.SetFilter("Table Code", '110');
                if DIANSETUP.FindFirst() then
                    ConceptoDes := DIANSETUP.Description;*/
                if not IsReportInPreviewMode then
                    CODEUNIT.Run(CODEUNIT::"Sales Cr. Memo-Printed", Header);

                CalcFields("Work Description");
                ShowWorkDescription := "Work Description".HasValue;
                //  CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");

                FormatAddressFields(Header);
                if SellToContact.Get("Sell-to Contact No.") then;
                if BillToContact.Get("Bill-to Contact No.") then;

                if not Cust.Get("Bill-to Customer No.") then
                    Clear(Cust);

                if "Currency Code" <> '' then begin
                    CurrencyExchangeRate.FindCurrency("Posting Date", "Currency Code", 1);
                    CalculatedExchRate :=
                      Round(1 / "Currency Factor" * CurrencyExchangeRate."Exchange Rate Amount", 0.000001);
                    ExchangeRateText := StrSubstNo(ExchangeRateTxt, CalculatedExchRate, CurrencyExchangeRate."Exchange Rate Amount");
                end;

                Clear(Observation);
                Header.Calcfields("Work Description");
                If Header."Work Description".HasValue() then begin
                    Header."Work Description".CreateInStream(Stream);
                    Stream.Read(Observation);
                end;

                txtCharsToKeep := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890#*-@,. abcdefghijklmnopqrstuvwxyz';
                Observation := DELCHR(Observation, '=', DELCHR(Observation, '=', txtCharsToKeep));

                TotalSubTotal := 0;
                TotalInvDiscAmount := 0;
                TotalAmount := 0;
                TotalAmountVAT := 0;
                TotalAmountInclVAT := 0;
                TotalPaymentDiscOnVAT := 0;

                DocumentPrefix := Format(Header."No.").Substring(1, 4);

                amountRound := Round(CalculateTotalAmountCN(Header."No.", '01'));
                numberToText.FormatNoText(AmountText, amountRound, Header."Currency Code");
                AmountInWords := AmountText[1] + AmountText[2];

                if Header."Currency Code" = 'USD' then begin
                    if not AmountInWords.Contains(' DOLARES ') then begin
                        if not AmountInWords.Contains(' CENTAVOS ') then begin
                            AmountInWords := AmountText[1] + AmountText[2] + ' DOLARES';
                        end else begin
                            AmountInWords := AmountText[1] + ' DOLARES ' + AmountText[2];
                        end;
                    end else begin
                        AmountInWords := AmountText[1] + AmountText[2];
                    end;
                end;
                if Header."Currency Code" = 'COP' then begin
                    if not AmountInWords.Contains(' PESOS ') then begin
                        if not AmountInWords.Contains(' CENTAVOS ') then begin
                            AmountInWords := AmountText[1] + AmountText[2] + ' PESOS';
                        end else begin
                            AmountInWords := AmountText[1] + ' PESOS ' + AmountText[2];
                        end;
                    end else begin
                        AmountInWords := AmountText[1] + AmountText[2];
                    end;
                end;
                /*  if Header."Currency Code" = 'USD' then begin
                      AmountInWords := AmountText[1] + AmountText[2];
                      if not AmountInWords.Contains('DOLARES') then begin
                          AmountInWords := AmountInWords.Replace('CENTAVOS', '');
                          AmountInWords += ' DOLARES';
                      end else begin
                          AmountInWords := AmountText[1] + AmountText[2];
                      end;
                  end;*/
                /*dataFE := Header."D365L CO FE Data_FE".Split('|');
                //  dataFE.Get(1, ResolutionNo);
                //  dataFE.Get(2, sSerieDateIni);
                //   dataFE.Get(3, sSerieDateEnd);
                //   dataFE.Get(4, sSerieRangIni);
                //   dataFE.Get(5, sSerieRangEnd);
                dataFE.Get(5, CustItenType);
                dataFE.Get(6, CustPersonType);
                dataFE.Get(7, CustNIT);*/

                NoSerieLine.SetFilter("Series Code", Header."D365L PR Invoice Series");
                NoSerieLine.FindFirst();

                CustomerRc.SetFilter("No.", Header."Bill-to Customer No.");
                CustomerRc.FindFirst();

                /* DIAN_Setup.SetRange("HACIENDA Code", CompanyInfo."D365L PR Regimen Type");
                 DIAN_Setup.SetRange("Table Code", '1004');
                 DIAN_Setup.FindFirst();*/
                DIAN_RegimeDesc := '';

                DIAN_Setup.SetRange("HACIENDA Code", CompanyInfo."D365L PR HACIENDA Entity type");
                DIAN_Setup.SetRange("Table Code", '1002');
                if DIAN_Setup.FindFirst() then
                    DIAN_EmisorType := DIAN_Setup.Description;

                /* Resp_DIAN.SetRange("Table From", Resp_DIAN."Table From"::Customer);
                 Resp_DIAN.SetFilter("Company No.", Header."Bill-to Customer No.");
                 if Resp_DIAN.FindFirst() then begin
                     CustomerRespon := Resp_DIAN."Tax Respon. DIAN";
                 end;*/

                /*    Clear(Resp_DIAN);
                    Resp_DIAN.SetRange("Table From", Resp_DIAN."Table From"::"My Company");
                    Resp_DIAN.FindFirst();*/

                DIAN_Setup.SetRange("HACIENDA Code", CustomerRc."D365L PR HACIENDA Entity type");
                DIAN_Setup.SetRange("Table Code", '1002');
                if DIAN_Setup.FindFirst() then
                    CustomerEntityType := DIAN_Setup.Description;

                DIAN_Setup.SetRange("HACIENDA Code", CustItenType);
                DIAN_Setup.SetRange("Table Code", '1003');
                if DIAN_Setup.FindFirst() then
                    CustomerIdentityType := DIAN_Setup.Description;

                sPostCode := '';
                txtCharsToKeepNumeric := '1234567890';
                sPostalCode := Header."Bill-to Post Code";
                sPostalCode := DELCHR(sPostalCode, '=', DELCHR(sPostalCode, '=', txtCharsToKeepNumeric));
                PostCode.SetFilter(Code, sPostalCode);
                if PostCode.FindFirst() then
                    sPostCode := PostCode."Search City";
            end;

            trigger OnPreDataItem()
            begin
                FirstLineHasBeenOutput := false;
            end;
        }
    }

    trigger OnInitReport()
    begin
        GLSetup.Get();
        CompanyInfo.SetAutoCalcFields(Picture);
        CompanyInfo.Get();
        SalesSetup.Get();
        CompanyInfo.VerifyAndSetPaymentInfo;
        CompanyPhone := CompanyInfo."Phone No.";
    end;


    var
        ConceptoDes: text[250];
        linestotalamountcop: Decimal;
        invoicediscuountamountcop: Decimal;
        Vatentryamountcop: Decimal;
        countroundcop: Decimal;
        Piedepag3: Text;
        numLineas: Integer;
        Moneda: text[20];
        TasaCambio: Decimal;
        FormaPago: Code[10];
        cufeDocref: text;
        Observation: TExt;
        Document_No: Code[20];
        VATEntry_DianDesc: Text;
        VATEntry_Amount: Decimal;
        lylQueryGeneralTax: Query "LyL LyLGeneralTaxQuery";

        LinesTotalAmount: Decimal;
        CustItenType: Text;
        CustPersonType: Text;
        CustNIT: Text;
        dataFE: List of [Text];
        CustomerIdentityType: Text;
        AmountInWords: Text;
        amountRound: Decimal;
        NoText: array[2] of Text;
        report1401: Report Check;
        PostCode: Record "Post Code";
        sPostCode: Text;
        CompanyPhone: Text;
        CustomerEntityType: Text;
        CustomerRc: Record Customer;
        DIAN_Setup: Record "D365L PR HACIENDA Setup";
        NoSerie: Record "No. Series";
        NoSerieLine: Record "No. Series Line";
        CustomerRespon: Text;
        DocumentPrefix: Text;
        //Resp_DIAN: Record d365tax //"D365L PR Tax Respon. HACIENDA";
        DIAN_EmisorType: Text;
        DIAN_RegimeDesc: Text;
        // CU_QRCodeGenerator: Codeunit "LyL QRCodeAzureFunction";
        CustommerEmail: Label 'Email', Comment = 'Email', Locked = false;
        CustommerAddress: Label 'Address', Comment = 'ESP="Dirección"', Locked = false;
        CustommerPhone: Label 'Phone', Comment = 'ESP="Teléfono"', Locked = false;
        CustommerCity: Label 'City', Comment = 'ESP="Ciudad"', Locked = false;
        lblNoAutorizacion: Label 'Autorization No.', Comment = 'ESP="Número de Autorizacion"';
        lblRangoAut: Label 'Numering Range', Comment = 'ESP="Rango Autorizado Desde"';
        lblRangoAutEnd: Label 'Numering Range End', Comment = 'ESP="Rango Autorizado Hasta"';
        lblValidity: Label 'Validity', Comment = 'ESP="Vigencia"';
        lblClient: Label 'Client', Comment = 'ESP="Cliente"';
        SalesCreditMemoNoLbl: Label 'Sales - Credit Memo %1';
        SalespersonLbl: Label 'Sales person';
        CompanyInfoBankAccNoLbl: Label 'Account No.';
        CompanyInfoBankNameLbl: Label 'Bank';
        CompanyInfoGiroNoLbl: Label 'Giro No.';
        CompanyInfoPhoneNoLbl: Label 'Phone No.';
        CopyLbl: Label 'Copy';
        EMailLbl: Label 'Email';
        HomePageLbl: Label 'Home Page';
        InvDiscBaseAmtLbl: Label 'Invoice Discount Base Amount';
        InvDiscountAmtLbl: Label 'Invoice Discount';
        InvNoLbl: Label 'Credit Memo No.';
        LineAmtAfterInvDiscLbl: Label 'Payment Discount on VAT';
        LocalCurrencyLbl: Label 'Local Currency';
        PageLbl: Label 'Page';
        PaymentTermsDescLbl: Label 'Payment Terms';
        PaymentMethodDescLbl: Label 'Payment Method';
        PostedShipmentDateLbl: Label 'Shipment Date';
        SalesInvLineDiscLbl: Label 'Discount %';
        SalesCreditMemoLbl: Label 'Credit Memo';
        ShipmentLbl: Label 'Shipment';
        ShiptoAddrLbl: Label 'Ship-to Address';
        ShptMethodDescLbl: Label 'Shipment Method';
        SubtotalLbl: Label 'Subtotal';
        TotalLbl: Label 'Total';
        VATAmtSpecificationLbl: Label 'VAT Amount Specification';
        VATAmtLbl: Label 'VAT Amount';
        VATAmountLCYLbl: Label 'VAT Amount (LCY)';
        VATBaseLbl: Label 'VAT Base';
        VATBaseLCYLbl: Label 'VAT Base (LCY)';
        VATClausesLbl: Label 'VAT Clause';
        VATIdentifierLbl: Label 'VAT Identifier';
        VATPercentageLbl: Label 'VAT %';
        SellToContactPhoneNoLbl: Label 'Sell-to Contact Phone No.';
        SellToContactMobilePhoneNoLbl: Label 'Sell-to Contact Mobile Phone No.';
        SellToContactEmailLbl: Label 'Sell-to Contact E-Mail';
        BillToContactPhoneNoLbl: Label 'Bill-to Contact Phone No.';
        BillToContactMobilePhoneNoLbl: Label 'Bill-to Contact Mobile Phone No.';
        BillToContactEmailLbl: Label 'Bill-to Contact E-Mail';
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        DummyCompanyInfo: Record "Company Information";
        CompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        Cust: Record Customer;
        RespCenter: Record "Responsibility Center";
        VATClause: Record "VAT Clause";
        SellToContact: Record Contact;
        BillToContact: Record Contact;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit SegManagement;
        WorkDescriptionInstream: InStream;
        WorkDescriptionLine: Text;
        CustAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        SalesPersonText: Text[30];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        LineDiscountPctText: Text;
        FormattedVATPct: Text;
        FormattedUnitPrice: Text;
        FormattedQuantity: Text;
        FormattedLineAmount: Text;
        MoreLines: Boolean;
        CopyText: Text[30];
        ShowWorkDescription: Boolean;
        ShowShippingAddr: Boolean;
        LogInteraction: Boolean;
        SalesPrepCreditMemoNoLbl: Label 'Sales - Prepmt. Credit Memo %1';
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvDiscAmount: Decimal;
        TotalPaymentDiscOnVAT: Decimal;
        TransHeaderAmount: Decimal;
        [InDataSet]
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        DisplayShipmentInformation: Boolean;
        CompanyLogoPosition: Integer;
        FirstLineHasBeenOutput: Boolean;
        CalculatedExchRate: Decimal;
        ExchangeRateText: Text;
        ExchangeRateTxt: Label 'Exchange rate: %1/%2', Comment = '%1 and %2 are both amounts.';
        VATBaseLCY: Decimal;
        VATAmountLCY: Decimal;
        TotalVATBaseLCY: Decimal;
        TotalVATAmountLCY: Decimal;
        PrevLineAmount: Decimal;
        AppliesToText: Text;
        AppliesToTextLbl: Label 'Applies to Document';
        NoFilterSetErr: Label 'You must specify one or more filters to avoid accidently printing all documents.';
        GreetingLbl: Label 'Hello';
        ClosingLbl: Label 'Sincerely';
        BodyLbl: Label 'Thank you for your business. Your credit memo is attached to this message.';
        QRInvoice: Text;


    local procedure InitializeSalesShipmentLine(): Date
    var
        ReturnReceiptHeader: Record "Return Receipt Header";
        SalesShipmentBuffer2: Record "Sales Shipment Buffer";
    begin
        if Line."Return Receipt No." <> '' then
            if ReturnReceiptHeader.Get(Line."Return Receipt No.") then
                exit(ReturnReceiptHeader."Posting Date");
        if Header."Return Order No." = '' then
            exit(Header."Posting Date");
        if Line.Type = Line.Type::" " then
            exit(0D);

        ShipmentLine.GetLinesForSalesCreditMemoLine(Line, Header);

        ShipmentLine.Reset();
        ShipmentLine.SetRange("Line No.", Line."Line No.");
        if ShipmentLine.Find('-') then begin
            SalesShipmentBuffer2 := ShipmentLine;
            if not DisplayShipmentInformation then
                if ShipmentLine.Next = 0 then begin
                    ShipmentLine.Get(
                      SalesShipmentBuffer2."Document No.", SalesShipmentBuffer2."Line No.", SalesShipmentBuffer2."Entry No.");
                    ShipmentLine.Delete();
                    exit(SalesShipmentBuffer2."Posting Date");
                end;
            ShipmentLine.CalcSums(Quantity);
            if ShipmentLine.Quantity <> Line.Quantity then begin
                ShipmentLine.DeleteAll();
                exit(Header."Posting Date");
            end;
        end;
        exit(Header."Posting Date");
    end;

    local procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.Preview or MailManagement.IsHandlingGetEmailBody);
    end;


    procedure InitializeRequest(NewLogInteraction: Boolean; DisplayAsmInfo: Boolean)
    begin
        LogInteraction := NewLogInteraction;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    local procedure GetUOMText(UOMCode: Code[10]): Text[50]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if not UnitOfMeasure.Get(UOMCode) then
            exit(UOMCode);
        exit(UnitOfMeasure.Description);
    end;

    local procedure CreateReportTotalLines()
    begin
        ReportTotalsLine.DeleteAll();
        if (TotalInvDiscAmount <> 0) or (TotalAmountVAT <> 0) then
            ReportTotalsLine.Add(SubtotalLbl, TotalSubTotal, true, false, false);
        if TotalInvDiscAmount <> 0 then begin
            ReportTotalsLine.Add(InvDiscountAmtLbl, TotalInvDiscAmount, false, false, false);
            if TotalAmountVAT <> 0 then
                ReportTotalsLine.Add(TotalExclVATText, TotalAmount, true, false, false);
        end;
        if TotalAmountVAT <> 0 then
            ReportTotalsLine.Add(VATAmountLine.VATAmountText, TotalAmountVAT, false, true, false);
    end;

    local procedure FormatAddressFields(var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    begin
        FormatAddr.GetCompanyAddr(SalesCrMemoHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.SalesCrMemoBillTo(CustAddr, SalesCrMemoHeader);
        ShowShippingAddr := FormatAddr.SalesCrMemoShipTo(ShipToAddr, CustAddr, SalesCrMemoHeader);
    end;

    procedure LinesTotalAmountExVat(SIH_No: Code[20]): Decimal
    var
        SalesLine: Record "Sales Cr.Memo Line";
    begin
        SalesLine.SetFilter("Document No.", SIH_No);
        SalesLine.SetFilter(Quantity, '>0');
        SalesLine.CalcSums(Amount);
        exit(SalesLine.Amount);
    end;


    local procedure CalculateTotalAmountCN(SIH_no: Code[20]; taxCode: Code[2]): Decimal
    var
        //SIH_tax: Record "LyL GeneralTaxSIH";
        SIL: Record "Sales Cr.Memo Line";
        //  SIH: Record "Sales Invoice Header";
        vatEntry: Record "VAT Entry";
        vatEntryTotal: Decimal;
    begin
        vatEntry.SetFilter("Document No.", SIH_No);
        vatEntry.SetFilter("D365L PR VAT HACIENDA Code", '%1|%2|%3|%4', '05', '06', '07', '01');
        vatEntry.CalcSums(Amount);
        vatEntryTotal := vatEntry.Amount;

        SIL.SetFilter("Document No.", SIH_No);
        SIL.SetFilter(Quantity, '>0');
        SIL.CalcSums(SIL."Line Amount");
        exit(SIL."Line Amount" + vatEntryTotal);
    end;

    procedure calculateTotalTax(SIH_no: Code[20]; taxCode: Code[5]; tarifa: Decimal): Decimal
    var
        ST: Record "VAT Entry";
        SIH: Record "Sales Cr.Memo Header";
        ER: Decimal;
    begin
        SIH.SetFilter("No.", SIH_no);
        SIH.FindFirst();

        ST.SetFilter("Document No.", SIH_no);
        ST.SetFilter("D365L PR VAT HACIENDA Code", taxCode);
        ST.SetRange("D365L PR Tax Above Maximum COL", tarifa);
        if (SIH."Currency Code" <> 'USD') and (SIH."Currency Code" <> '') then begin
            ER := Round((1 / SIH."Currency Factor"), 0.01, '=');
            ST.CalcSums(Amount);
            exit(Round((ST.Amount / ER), 0.01, '='));
        end else begin
            ST.CalcSums(Amount);
            exit(ST.Amount);
        end;
    end;
}
