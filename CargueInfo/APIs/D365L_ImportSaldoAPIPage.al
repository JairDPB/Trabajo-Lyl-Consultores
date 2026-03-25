page 50140 "D365L_Import Saldos Line API"
{
    PageType = API;
    Caption = 'Import Saldos Line API';
    
    APIPublisher = 'LyLConsultores'; 
    APIGroup = 'integraciones';
    APIVersion = 'v1.0';
    
    EntityName = 'importSaldoLine';
    EntitySetName = 'importSaldoLines';
    
    SourceTable = "D365L_Import Saldos Line";
    DelayedInsert = true; 
    ODataKeyFields = SystemId; 

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(id; Rec.SystemId) { ApplicationArea = All; Editable = false; }
                field(jobEntryNo; Rec."Job Entry No.") { ApplicationArea = All; }
                field(lineNo; Rec."Line No.") { ApplicationArea = All; }
                field(excelLineNo; Rec."Excel Line No.") { ApplicationArea = All; }
                field(postingDate; Rec."Posting Date") { ApplicationArea = All; }
                field(glAccountNo; Rec."G/L Account No.") { ApplicationArea = All; }
                field(documentNo; Rec."Document No.") { ApplicationArea = All; }
                field(description; Rec.Description) { ApplicationArea = All; }
                field(amount; Rec.Amount) { ApplicationArea = All; }
                field(nit; Rec."NIT") { ApplicationArea = All; }
                field(lineStatus; Rec."Line Status") { ApplicationArea = All; }
            }
        }
    }
}