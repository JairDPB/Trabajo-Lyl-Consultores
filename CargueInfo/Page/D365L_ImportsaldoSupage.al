page 50149 "D365L_Import Saldos Subpage"
{
    // ✅ Cambiado de ListPart a List — page independiente
    PageType = List;
    SourceTable = "D365L_Import Saldos Line";
    Caption = 'Líneas de Importación';
    UsageCategory = Lists;
    ApplicationArea = All;
    Editable = true;
    // ✅ Quitar AutoSplitKey ya que no es subpage

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Job Entry No.";   Rec."Job Entry No.")   { ApplicationArea = All; Editable = false; }
                field("Line No.";        Rec."Line No.")         { ApplicationArea = All; Editable = false; }
                field("Excel Line No.";  Rec."Excel Line No.")   { ApplicationArea = All; }
                field("Posting Date";    Rec."Posting Date")     { ApplicationArea = All; }
                field("Document No.";   Rec."Document No.")      { ApplicationArea = All; }
                field("G/L Account No."; Rec."G/L Account No.")  { ApplicationArea = All; }
                field("NIT";             Rec."NIT")              { ApplicationArea = All; }
                field(Description;       Rec.Description)        { ApplicationArea = All; }
                field(Amount;            Rec.Amount)             { ApplicationArea = All; }
                field("Line Status";     Rec."Line Status")      { ApplicationArea = All; }
                field("User Message";    Rec."User Message")     { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            // ✅ NUEVO: volver al header enlazado
            action(VerEncabezado)
            {
                ApplicationArea = All;
                Caption = 'Ver Encabezado';
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    JobHeader: Record "D365L_Import Job Header";
                    JobCard: Page "D365L_Import Job Card";
                begin
                    if JobHeader.Get(Rec."Job Entry No.") then begin
                        JobCard.SetRecord(JobHeader);
                        JobCard.Run();
                    end;
                end;
            }
        }
    }

    // ✅ NUEVO: método para recibir el filtro desde el Job Card
    procedure SetHeaderFilter(EntryNo: Integer)
    begin
        Rec.SetRange("Job Entry No.", EntryNo);
    end;
}