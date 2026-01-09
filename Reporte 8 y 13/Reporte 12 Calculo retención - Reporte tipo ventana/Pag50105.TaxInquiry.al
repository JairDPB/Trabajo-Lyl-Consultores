page 50104 "Tax Inquiry"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Tax Inquiry Buffer";
    SourceTableTemporary = true;
    Caption = 'Consulta de Impuestos';
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    
                    trigger OnDrillDown()
                    begin
                        DrillDownDocument();
                    end;
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                }
                field("Item Code"; Rec."Item Code")
                {
                    ApplicationArea = All;
                    
                    trigger OnDrillDown()
                    begin
                        DrillDownItem();
                    end;
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                }
                field("Quantity"; Rec."Quantity")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ApplicationArea = All;
                }
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    ApplicationArea = All;
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    ApplicationArea = All;
                    Style = Favorable;
                    StyleExpr = true;
                    
                    trigger OnDrillDown()
                    begin
                        DrillDownVATEntries();
                    end;
                }
                field("VAT Withholding"; Rec."VAT Withholding")
                {
                    ApplicationArea = All;
                    Style = Attention;
                    StyleExpr = true;
                    
                    trigger OnDrillDown()
                    begin
                        DrillDownVATEntries();
                    end;
                }
                field("Income Withholding"; Rec."Income Withholding")
                {
                    ApplicationArea = All;
                    Style = Attention;
                    StyleExpr = true;
                    
                    trigger OnDrillDown()
                    begin
                        DrillDownVATEntries();
                    end;
                }
                field("ICA Withholding"; Rec."ICA Withholding")
                {
                    ApplicationArea = All;
                    Style = Attention;
                    StyleExpr = true;
                    
                    trigger OnDrillDown()
                    begin
                        DrillDownVATEntries();
                    end;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(VerDocumento)
            {
                ApplicationArea = All;
                Caption = 'Ver Documento';
                Image = Document;
                ToolTip = 'Abre el documento registrado';
                
                trigger OnAction()
                begin
                    DrillDownDocument();
                end;
            }
            action(VerMovimientosIVA)
            {
                ApplicationArea = All;
                Caption = 'Ver Movimientos IVA';
                Image = VATEntries;
                ToolTip = 'Muestra los movimientos de IVA relacionados';
                
                trigger OnAction()
                begin
                    DrillDownVATEntries();
                end;
            }
        }
    }
    
    var
        VendorFilter: Code[20];
        StartDate: Date;
        EndDate: Date;
    
    procedure SetFilters(VendorNo: Code[20]; PostingDate: Date)
    begin
        // Validar que la fecha no esté vacía
        if PostingDate = 0D then
            Error('No se puede consultar impuestos sin una fecha de registro válida.');
            
        VendorFilter := VendorNo;
        StartDate := CalcDate('<-CM>', PostingDate); // Primer día del mes
        EndDate := CalcDate('<CM>', PostingDate);    // Último día del mes
        LoadData();
    end;
    
    local procedure DrillDownDocument()
    var
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        PostedPurchaseInvoice: Page "Posted Purchase Invoice";
        PostedPurchaseCreditMemo: Page "Posted Purchase Credit Memo";
    begin
        case Rec."Source Type" of
            Rec."Source Type"::Invoice:
                begin
                    PurchInvHeader.Get(Rec."Document No.");
                    PostedPurchaseInvoice.SetRecord(PurchInvHeader);
                    PostedPurchaseInvoice.Run();
                end;
            Rec."Source Type"::"Credit Memo":
                begin
                    PurchCrMemoHdr.Get(Rec."Document No.");
                    PostedPurchaseCreditMemo.SetRecord(PurchCrMemoHdr);
                    PostedPurchaseCreditMemo.Run();
                end;
        end;
    end;
    
    local procedure DrillDownItem()
    var
        Item: Record Item;
        ItemCard: Page "Item Card";
    begin
        if Rec."Item Code" = '' then
            exit;
            
        if Item.Get(Rec."Item Code") then begin
            ItemCard.SetRecord(Item);
            ItemCard.Run();
        end;
    end;
    
    local procedure DrillDownVATEntries()
    var
        VATEntry: Record "VAT Entry";
        VATEntries: Page "VAT Entries";
    begin
        VATEntry.SetRange("Document No.", Rec."Document No.");
        VATEntry.SetRange("Posting Date", StartDate, EndDate);
        
        VATEntries.SetTableView(VATEntry);
        VATEntries.Run();
    end;
    
    local procedure LoadData()
    var
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchInvLine: Record "Purch. Inv. Line";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        VATEntry: Record "VAT Entry";
        EntryCounter: Integer;
    begin
        Rec.Reset();
        Rec.DeleteAll();
        EntryCounter := 0;
        
        // Procesar Facturas de Compra Registradas
        PurchInvHeader.SetRange("Buy-from Vendor No.", VendorFilter);
        PurchInvHeader.SetRange("Posting Date", StartDate, EndDate);
        
        if PurchInvHeader.FindSet() then
            repeat
                PurchInvLine.SetRange("Document No.", PurchInvHeader."No.");
                if PurchInvLine.FindSet() then
                    repeat
                        EntryCounter += 1;
                        Rec.Init();
                        Rec."Entry No." := EntryCounter;
                        Rec."Source Type" := Rec."Source Type"::Invoice;
                        Rec."Document Type" := 'Factura';
                        Rec."Document No." := PurchInvHeader."No.";
                        Rec."Line No." := PurchInvLine."Line No.";
                        Rec."Vendor Invoice No." := PurchInvHeader."Vendor Invoice No.";
                        Rec."Document Date" := PurchInvHeader."Document Date";
                        Rec."Type" := Format(PurchInvLine.Type);
                        Rec."Item Code" := PurchInvLine."No.";
                        Rec."Description" := PurchInvLine.Description;
                        Rec."Quantity" := PurchInvLine.Quantity;
                        Rec."Unit Price" := PurchInvLine."Direct Unit Cost";
                        Rec."Total Amount" := PurchInvLine.Amount;
                        Rec."Tax Area Code" := PurchInvLine."Tax Area Code";
                        Rec."Tax Group Code" := PurchInvLine."Tax Group Code";
                        
                        // Obtener impuestos de VAT Entry
                        GetVATAmounts(PurchInvHeader."No.", PurchInvLine."Line No.");
                        
                        Rec.Insert();
                    until PurchInvLine.Next() = 0;
            until PurchInvHeader.Next() = 0;
        
        // Procesar Notas Crédito Registradas
        PurchCrMemoHdr.SetRange("Buy-from Vendor No.", VendorFilter);
        PurchCrMemoHdr.SetRange("Posting Date", StartDate, EndDate);
        
        if PurchCrMemoHdr.FindSet() then
            repeat
                PurchCrMemoLine.SetRange("Document No.", PurchCrMemoHdr."No.");
                if PurchCrMemoLine.FindSet() then
                    repeat
                        EntryCounter += 1;
                        Rec.Init();
                        Rec."Entry No." := EntryCounter;
                        Rec."Source Type" := Rec."Source Type"::"Credit Memo";
                        Rec."Document Type" := 'Nota Crédito';
                        Rec."Document No." := PurchCrMemoHdr."No.";
                        Rec."Line No." := PurchCrMemoLine."Line No.";
                        Rec."Vendor Invoice No." := PurchCrMemoHdr."Vendor Cr. Memo No.";
                        Rec."Document Date" := PurchCrMemoHdr."Document Date";
                        Rec."Type" := Format(PurchCrMemoLine.Type);
                        Rec."Item Code" := PurchCrMemoLine."No.";
                        Rec."Description" := PurchCrMemoLine.Description;
                        Rec."Quantity" := -PurchCrMemoLine.Quantity; // Negativo para notas crédito
                        Rec."Unit Price" := PurchCrMemoLine."Direct Unit Cost";
                        Rec."Total Amount" := -PurchCrMemoLine.Amount;
                        Rec."Tax Area Code" := PurchCrMemoLine."Tax Area Code";
                        Rec."Tax Group Code" := PurchCrMemoLine."Tax Group Code";
                        
                        GetVATAmounts(PurchCrMemoHdr."No.", PurchCrMemoLine."Line No.");
                        
                        Rec.Insert();
                    until PurchCrMemoLine.Next() = 0;
            until PurchCrMemoHdr.Next() = 0;
    end;
    
    local procedure GetVATAmounts(DocumentNo: Code[20]; LineNo: Integer)
    var
        VATEntry: Record "VAT Entry";
    begin
        // Buscar movimientos de IVA relacionados
        VATEntry.SetRange("Document No.", DocumentNo);
        VATEntry.SetRange("Posting Date", StartDate, EndDate);
        
        if VATEntry.FindSet() then
            repeat
                // IVA estándar
                if VATEntry.Type = VATEntry.Type::Purchase then
                    Rec."VAT Amount" += VATEntry.Amount;
                
                // ReteIVA
                if (VATEntry."VAT Calculation Type" = VATEntry."VAT Calculation Type"::"Reverse Charge VAT") then
                    Rec."VAT Withholding" += VATEntry.Amount;
                
            until VATEntry.Next() = 0;
    end;
}