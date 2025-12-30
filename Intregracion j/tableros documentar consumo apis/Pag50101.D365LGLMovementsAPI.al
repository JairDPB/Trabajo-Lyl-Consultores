page 50121 "D365L GL Movements API"
{
    PageType = API;
    DelayedInsert = true;
    SourceTable = "D365L GL Movements Buffer";
    SourceTableTemporary = true;

    APIPublisher = 'd365l';
    APIGroup = 'finance';
    APIVersion = 'v1.0';
    EntityName = 'glMovement';
    EntitySetName = 'glMovements';

    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(postingDate; Rec."Posting Date") { }
                field(glAccountNo; Rec."G/L Account No.") { }
                field(dimension1; Rec."Dim 1") { }
                field(dimension2; Rec."Dim 2") { }
                field(dimension3; Rec."Dim 3") { }
                field(dimension4; Rec."Dim 4") { }
                field(dimension5; Rec."Dim 5") { }
                field(dimension6; Rec."Dim 6") { }
                field(dimension7; Rec."Dim 7") { }
                field(dimension8; Rec."Dim 8") { }
                field(amount; Rec.Amount) { }
                field(debitAmount; Rec."Debit Amount") { }
                field(creditAmount; Rec."Credit Amount") { }
                field(isClosingEntry; Rec."Is Closing Entry") { }
            }
        }
    }

    trigger OnOpenPage()
    begin
        LoadData();
    end;

    local procedure LoadData()
    var
        GLEntry: Record "G/L Entry";
        Buffer: Record "D365L GL Movements Buffer";
        SourceCodeSetup: Record "Source Code Setup";
        IsClosing: Boolean;
    begin
        SourceCodeSetup.Get();

        GLEntry.Reset();

        // 🔹 Permite filtro OData por Posting Date
        CurrPage.SetSelectionFilter(GLEntry);

        if GLEntry.FindSet() then
            repeat
                IsClosing :=
                (GLEntry."Source Code" = SourceCodeSetup."Close Income Statement");

                Buffer.Reset();
                Buffer.SetRange("Posting Date", GLEntry."Posting Date");
                Buffer.SetRange("G/L Account No.", GLEntry."G/L Account No.");
                Buffer.SetRange("Dim 1", GLEntry."Global Dimension 1 Code");
                Buffer.SetRange("Dim 2", GLEntry."Global Dimension 2 Code");
                Buffer.SetRange("Dim 3", GLEntry."Shortcut Dimension 3 Code");
                Buffer.SetRange("Dim 4", GLEntry."Shortcut Dimension 4 Code");
                Buffer.SetRange("Dim 5", GLEntry."Shortcut Dimension 5 Code");
                Buffer.SetRange("Dim 6", GLEntry."Shortcut Dimension 6 Code");
                Buffer.SetRange("Dim 7", GLEntry."Shortcut Dimension 7 Code");
                Buffer.SetRange("Dim 8", GLEntry."Shortcut Dimension 8 Code");
                Buffer.SetRange("Is Closing Entry", IsClosing);

                if not Buffer.FindFirst() then begin
                    Buffer.Init();
                    Buffer."Posting Date" := GLEntry."Posting Date";
                    Buffer."G/L Account No." := GLEntry."G/L Account No.";
                    Buffer."Dim 1" := GLEntry."Global Dimension 1 Code";
                    Buffer."Dim 2" := GLEntry."Global Dimension 2 Code";
                    Buffer."Dim 3" := GLEntry."Shortcut Dimension 3 Code";
                    Buffer."Dim 4" := GLEntry."Shortcut Dimension 4 Code";
                    Buffer."Dim 5" := GLEntry."Shortcut Dimension 5 Code";
                    Buffer."Dim 6" := GLEntry."Shortcut Dimension 6 Code";
                    Buffer."Dim 7" := GLEntry."Shortcut Dimension 7 Code";
                    Buffer."Dim 8" := GLEntry."Shortcut Dimension 8 Code";
                    Buffer."Is Closing Entry" := IsClosing;
                    Buffer.Insert();
                end;

                Buffer.Amount += GLEntry.Amount;
                Buffer."Debit Amount" += GLEntry."Debit Amount";
                Buffer."Credit Amount" += GLEntry."Credit Amount";
                Buffer.Modify();

            until GLEntry.Next() = 0;
    end;
}
