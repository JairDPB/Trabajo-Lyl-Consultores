codeunit 88101 "D365L Install Check Report"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        SetCheckReport();
    end;

    local procedure SetCheckReport()
    var
        ReportSelections: Record "Report Selections";
    begin
        ReportSelections.Reset();
        ReportSelections.SetRange(Usage, ReportSelections.Usage::"B.Check");
        if ReportSelections.FindFirst() then begin
            ReportSelections."Report ID" := 88101;
            ReportSelections.Modify(true);
        end else begin
            ReportSelections.Init();
            ReportSelections.Usage := ReportSelections.Usage::"B.Check";
            ReportSelections.Sequence := '1';
            ReportSelections."Report ID" := 88101;
            ReportSelections.Insert(true);
        end;
    end;
}