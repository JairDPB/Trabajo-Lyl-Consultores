codeunit 50100 "Budget Execution Mgt"
{
    procedure GetAccountName(AccountNo: Code[20]): Text[100]
    var
        GLAccount: Record "G/L Account";
    begin
        if GLAccount.Get(AccountNo) then
            exit(GLAccount.Name);
        exit('');
    end;

    procedure GetDimensionValueNames(DimensionSetID: Integer): Text
    var
        DimSetEntry: Record "Dimension Set Entry";
        ResultTxt: Text;
    begin
        DimSetEntry.SetRange("Dimension Set ID", DimensionSetID);
        if DimSetEntry.FindSet() then
            repeat
                ResultTxt +=
                DimSetEntry."Dimension Code" + ':' +
                DimSetEntry."Dimension Value Code" + ' | ';
            until DimSetEntry.Next() = 0;

        exit(ResultTxt);
    end;
}
