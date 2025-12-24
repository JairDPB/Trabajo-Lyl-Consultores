table 50100 "Temp Budget Report"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "G/L Account No."; Code[20]) {}
        field(2; "Dimension Set ID"; Integer) {}
        field(3; BudgetOriginal; Decimal) {}
        field(4; BudgetAdjustment; Decimal) {}
        field(5; BudgetModified; Decimal) {}
        field(6; ExecutedAmount; Decimal) {}
        field(7; RemainingAmount; Decimal) {}
        field(8; VarianceTxt; Text[50]) {}
    }

    keys
    {
        key(PK; "G/L Account No.", "Dimension Set ID") { Clustered = true; }
    }
}
