page 50125 "D365L Budget Summary API"
{
    PageType = API;
    APIPublisher = 'd365l';
    APIGroup = 'budget';
    APIVersion = 'v1.0';
    EntityName = 'budgetSummary';
    EntitySetName = 'budgetSummaries';
    SourceTable = "D365L Budget Summary Temp";
    SourceTableTemporary = true;
    DelayedInsert = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Date';
                }
                
                field(glAccountNo; Rec."G/L Account No.")
                {
                    Caption = 'G/L Account No';
                }
                
                field(dimension1; Rec."Global Dimension 1")
                {
                    Caption = 'Global Dimension 1 Code';
                }
                
                field(dimension2; Rec."Global Dimension 2")
                {
                    Caption = 'Global Dimension 2 Code';
                }
                
                field(dimension3; Rec."Budget Dimension 1")
                {
                    Caption = 'Budget Dimension 1 Code';
                }
                
                field(dimension4; Rec."Budget Dimension 2")
                {
                    Caption = 'Budget Dimension 2 Code';
                }
                
                field(dimension5; Rec."Budget Dimension 3")
                {
                    Caption = 'Budget Dimension 3 Code';
                }
                
                field(dimension6; Rec."Budget Dimension 4")
                {
                    Caption = 'Budget Dimension 4 Code';
                }
                
                field(originalAmount; Rec."Original Amount API")
                {
                    Caption = 'Monto Original';
                }
                
                field(adjustmentAmount; Rec."Adjustment Amount API")
                {
                    Caption = 'Monto de Ajuste';
                }
                
                field(budgetAmount; Rec."Budget Amount")
                {
                    Caption = 'Monto del Presupuesto';
                }
            }
        }
    }
    
    trigger OnOpenPage()
    begin
        LoadBudgetData();
    end;
    
    local procedure LoadBudgetData()
    var
        BudgetSummaryQry: Query "D365L Budget Summary Qry";
        EntryNo: Integer;
    begin
        Rec.DeleteAll();
        EntryNo := 1;
        BudgetSummaryQry.Open();
        while BudgetSummaryQry.Read() do begin
            Rec.Init();
            Rec."Entry No." := EntryNo;
            EntryNo += 1;
            Rec."Posting Date" := BudgetSummaryQry.PostingDate;
            Rec."G/L Account No." := BudgetSummaryQry.GLAccountNo;
            Rec."Global Dimension 1" := BudgetSummaryQry.GlobalDim1;
            Rec."Global Dimension 2" := BudgetSummaryQry.GlobalDim2;
            Rec."Budget Dimension 1" := BudgetSummaryQry.BudgetDim1;
            Rec."Budget Dimension 2" := BudgetSummaryQry.BudgetDim2;
            Rec."Budget Dimension 3" := BudgetSummaryQry.BudgetDim3;
            Rec."Budget Dimension 4" := BudgetSummaryQry.BudgetDim4;
            Rec."Original Amount API" := BudgetSummaryQry.OriginalAmount;
            Rec."Adjustment Amount API" := BudgetSummaryQry.AdjustmentAmount;
            Rec."Budget Amount" := BudgetSummaryQry.BudgetAmount;
            Rec.Insert();
        end;
        BudgetSummaryQry.Close();
    end;
}

