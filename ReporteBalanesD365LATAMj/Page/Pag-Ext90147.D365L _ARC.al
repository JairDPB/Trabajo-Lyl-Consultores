pageextension 90147 "D365L ARC" extends "Accountant Role Center"
{
    actions
    {
        modify("D365L CO Localization Third Balance Report")
        {
            Visible = false;
        }
    }
}
pageextension 90148 "D365L BRC" extends "Bookkeeper Role Center"
{
    actions
    {
        modify("D365L CO Localization Third Balance Report")
        {
            Visible = false;
        }
    }
}
pageextension 90149 "D365L TMRC" extends "Team Member Role Center"
{
    actions
    {
        modify("D365L CO Localization Third Balance Report")
        {
            Visible = false;
        }
    }
}
pageextension 90150 "D365L BMRC" extends "Business Manager Role Center"
{

    actions
    {
        modify("D365L CO Localization Third Balance Report")
        {
            Visible = false;
        }
        addafter("D365L CO Inventory and Balance Book")
        {
            action("D365L third report V2")
            {
                Caption = 'D365LATAM Reporte Cuenta Tercero Colombia';
                ApplicationArea = All;

                RunObject = report "D365LATAM TrialBalanceCOL";
            }
        }
    }
}