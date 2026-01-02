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

    ODataKeyFields = "Posting Date", "G/L Account No.", "Dim 1", "Dim 2", "Dim 3", "Dim 4", "Dim 5", "Dim 6", "Dim 7", "Dim 8", "Is Closing Entry";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(postingDate; Rec."Posting Date") 
                { 
                    Caption = 'Posting Date';
                }
                field(glAccountNo; Rec."G/L Account No.") 
                { 
                    Caption = 'G/L Account No.';
                }
                field(dimension1; Rec."Dim 1") 
                { 
                    Caption = 'Dimension 1';
                }
                field(dimension2; Rec."Dim 2") 
                { 
                    Caption = 'Dimension 2';
                }
                field(dimension3; Rec."Dim 3") 
                { 
                    Caption = 'Dimension 3';
                }
                field(dimension4; Rec."Dim 4") 
                { 
                    Caption = 'Dimension 4';
                }
                field(dimension5; Rec."Dim 5") 
                { 
                    Caption = 'Dimension 5';
                }
                field(dimension6; Rec."Dim 6") 
                { 
                    Caption = 'Dimension 6';
                }
                field(dimension7; Rec."Dim 7") 
                { 
                    Caption = 'Dimension 7';
                }
                field(dimension8; Rec."Dim 8") 
                { 
                    Caption = 'Dimension 8';
                }
                field(amount; Rec.Amount) 
                { 
                    Caption = 'Amount';
                }
                field(debitAmount; Rec."Debit Amount") 
                { 
                    Caption = 'Debit Amount';
                }
                field(creditAmount; Rec."Credit Amount") 
                { 
                    Caption = 'Credit Amount';
                }
                field(isClosingEntry; Rec."Is Closing Entry") 
                { 
                    Caption = 'Is Closing Entry';
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        LoadCU: Codeunit "Load GL Movements";
        PostingDateFilter: Text;
    begin
        // Obtener el filtro de Posting Date desde OData
        PostingDateFilter := Rec.GetFilter("Posting Date");
        
        // Cargar datos con el filtro aplicado
        LoadCU.LoadData(Rec, PostingDateFilter);
    end;
}