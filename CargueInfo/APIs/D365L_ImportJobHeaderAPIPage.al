page 50102 "D365L_Import Job Header API"
{
    PageType = API;
    Caption = 'Import Job Header API';
    
    APIPublisher = 'LyLConsultores'; 
    APIGroup = 'integraciones';
    APIVersion = 'v1.0';
    
    EntityName = 'importJob';
    EntitySetName = 'importJobs';
    
    SourceTable = "D365L_Import Job Header";
    DelayedInsert = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(id; Rec.SystemId) { ApplicationArea = All; Editable = false; }
                
                // Campos de la cabecera
                field(entryNo; Rec."Entry No.") { ApplicationArea = All; }
                field(entity; Rec.Entity) { ApplicationArea = All; }
                field(status; Rec.Status) { ApplicationArea = All; }
                field(importDateTime; Rec."Import DateTime") { ApplicationArea = All; }
                field(sourceFileName; Rec."Source File Name") { ApplicationArea = All; }
                field(genJnlTemplate; Rec."Gen. Jnl. Template") { ApplicationArea = All; }
                field(genJnlBatch; Rec."Gen. Jnl. Batch") { ApplicationArea = All; }
                part(lines; "D365L_Import Saldos Line API")
                {
                    ApplicationArea = All;
                    Caption = 'Lines';
                    EntityName = 'importSaldoLine';
                    EntitySetName = 'importSaldoLines';
                    SubPageLink = "Job Entry No." = field("Entry No.");
                }
            }
        }
    }
}