page 50146 "D365_Hist trabajos importación"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "D365L_Import Job Header";
    Caption = 'Historial Trabajos Importación';
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Número de entrada único del trabajo de importación';
                }
                field("Entity"; Rec."Entity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de entidad importada';
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado actual del trabajo de importación';
                    StyleExpr = StatusStyle;
                }
                field("Import DateTime"; Rec."Import DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha y hora en que se realizó la importación';
                }
                field("Imported By User"; Rec."Imported By User")
                {
                    ApplicationArea = All;
                    ToolTip = 'Usuario que realizó la importación';
                }
                field("Source File Name"; Rec."Source File Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre del archivo origen importado';
                }
                field("Gen. Jnl. Template"; Rec."Gen. Jnl. Template")
                {
                    ApplicationArea = All;
                    ToolTip = 'Plantilla de diario general utilizada';
                }
                field("Gen. Jnl. Batch"; Rec."Gen. Jnl. Batch")
                {
                    ApplicationArea = All;
                    ToolTip = 'Lote de diario general utilizado';
                }
                field("Has Errors"; Rec."Has Errors")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indica si existen errores en el trabajo';
                }
                field("Lines Count"; Rec."Lines Count")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total de líneas importadas';
                }
                field("Valid Lines Count"; Rec."Valid Lines Count")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total de líneas válidas';
                }
                field("Error Lines Count"; Rec."Error Lines Count")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total de líneas con errores';
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Refresh)
            {
                ApplicationArea = All;
                Caption = 'Actualizar';
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                Tooltip = 'Actualiza la lista de trabajos de importación';

                trigger OnAction()
                begin
                    CurrPage.Update(false);
                end;
            }
            action(ExportToExcel)
            {
                ApplicationArea = All;
                Caption = 'Exportar a Excel';
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                Tooltip = 'Exporta el historial a un archivo de Excel';

                trigger OnAction()
                begin
                    Rec.SetAutoCalcFields();
                end;
            }
        }
        area(Navigation)
        {
            action(ViewDetails)
            {
                ApplicationArea = All;
                Caption = 'Ver Detalles';
                Image = Document;
                Promoted = true;
                PromotedCategory = Category4;
                Tooltip = 'Ver los detalles completos del trabajo de importación';

                trigger OnAction()
                begin
                    if Rec."Entry No." <> 0 then
                        Page.Run(Page::"D365L_Import Job Card", Rec);
                end;
            }
            action(ViewLines)
            {
                ApplicationArea = All;
                Caption = 'Ver Líneas';
                Promoted = true;
                PromotedCategory = Category4;
                Tooltip = 'Ver todas las líneas de este trabajo de importación';

                trigger OnAction()
                var
                    ImportLineRec: Record "D365L_Import Saldos Line"; // ✅ Correcto
                begin
                    if Rec."Entry No." <> 0 then begin
                        ImportLineRec.SetRange("Job Entry No.", Rec."Entry No.");
                        Page.Run(Page::"D365L_Import Saldos Subpage", ImportLineRec);
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey("Entry No.");
        Rec.Ascending(false);
    end;

    trigger OnAfterGetRecord()
    begin
        case Rec."Status" of
            Rec."Status"::Pendiente:
                StatusStyle := 'Attention';
            Rec."Status"::Validando:
                StatusStyle := 'Favorable';
            Rec."Status"::ConErrores:
                StatusStyle := 'Unfavorable';
            Rec."Status"::Validado:
                StatusStyle := 'Favorable';
            Rec."Status"::Procesado:
                StatusStyle := 'Strong';
        end;
    end;

    var
        StatusStyle: Text;
}