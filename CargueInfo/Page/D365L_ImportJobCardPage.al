page 50148 "D365L_Import Job Card"
{
    PageType = Document;
    SourceTable = "D365L_Import Job Header";
    Caption = 'Ficha de Importación';
    UsageCategory = Documents;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Entry No."; Rec."Entry No.") { ApplicationArea = All; Editable = false; }
                field("Entity"; Rec."Entity") { ApplicationArea = All; }
                field("Status"; Rec."Status") { ApplicationArea = All; }
                field("Import DateTime"; Rec."Import DateTime") { ApplicationArea = All; }
                field("Imported By User"; Rec."Imported By User") { ApplicationArea = All; }
                field("Source File Name"; Rec."Source File Name") { ApplicationArea = All; }
            }
            group(Configuracion)
            {
                Caption = 'Configuración de Diario';
                field("Gen. Jnl. Template"; Rec."Gen. Jnl. Template") { ApplicationArea = All; }
                field("Gen. Jnl. Batch"; Rec."Gen. Jnl. Batch") { ApplicationArea = All; }
            }
            group(Estadisticas)
            {
                Caption = 'Estadísticas y Errores';
                field("Has Errors"; Rec."Has Errors") { ApplicationArea = All; }
                field("Lines Count"; Rec."Lines Count") { ApplicationArea = All; }
                field("Valid Lines Count"; Rec."Valid Lines Count") { ApplicationArea = All; }
                field("Error Lines Count"; Rec."Error Lines Count") { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(VerLineas)
            {
                ApplicationArea = All;
                Caption = 'Ver Líneas';
                Image = List;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    LinesPage: Page "D365L_Import Saldos Subpage";
                begin
                    LinesPage.SetHeaderFilter(Rec."Entry No.");
                    LinesPage.Run();
                end;
            }
        }
    }
}