query 50122 "D365L Budget Summary Qry"
{
    QueryType = Normal;
    
    elements
    {
        dataitem(BudgetEntry; "G/L Budget Entry")
        {
            column(postingDate; Date) 
            { 
                Caption = 'Posting Date';
            }
            
            column(glAccountNo; "G/L Account No.") 
            { 
                Caption = 'G/L Account No';
            }
            
            column(globalDim1; "Global Dimension 1 Code") 
            { 
                Caption = 'Global Dimension 1';
            }
            
            column(globalDim2; "Global Dimension 2 Code") 
            { 
                Caption = 'Global Dimension 2';
            }
            
            column(budgetDim1; "Budget Dimension 1 Code") 
            { 
                Caption = 'Budget Dimension 1';
            }
            
            column(budgetDim2; "Budget Dimension 2 Code") 
            { 
                Caption = 'Budget Dimension 2';
            }
            
            column(budgetDim3; "Budget Dimension 3 Code") 
            { 
                Caption = 'Budget Dimension 3';
            }
            
            column(budgetDim4; "Budget Dimension 4 Code") 
            { 
                Caption = 'Budget Dimension 4';
            }

            column(originalAmount; "D365L Original Amount API")
            {
                Caption = 'Monto Original';
                Method = Sum;
            }
            column(adjustmentAmount; "D365L Adjustment API")
            {
                Caption = 'Monto de Ajuste';
                Method = Sum;
            }
            column(budgetAmount; "Amount")
            {
                Caption = 'Monto del Presupuesto';
                Method = Sum;
            }
        }
    }
}