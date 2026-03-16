page 50101 "D365L_Import Saldos Subpage"
{
    PageType = ListPart;
    SourceTable = "D365L_Import Saldos Line";
    Caption = 'Líneas de Importación';
    AutoSplitKey = true; 

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Line No."; Rec."Line No.") { ApplicationArea = All; Visible = false; }
                field("Excel Line No."; Rec."Excel Line No.") { ApplicationArea = All; }
                field("Posting Date"; Rec."Posting Date") { ApplicationArea = All; }
                field("Document No."; Rec."Document No.") { ApplicationArea = All; }
                field("G/L Account No."; Rec."G/L Account No.") { ApplicationArea = All; }
                field("NIT"; Rec."NIT") { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; }
                field(Amount; Rec.Amount) { ApplicationArea = All; }
                field("Line Status"; Rec."Line Status") { ApplicationArea = All; }
                field("User Message"; Rec."User Message") { ApplicationArea = All; }
            }
        }
    }
}