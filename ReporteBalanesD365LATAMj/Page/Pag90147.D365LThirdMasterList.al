page 90147 "D365L ThirdMasterList"
{
    PageType = List;
    //  ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "D365L CO Third Master";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("D365L CO Third Master"; Rec."D365L CO Third Master")
                {
                    ApplicationArea = all;
                    Caption = 'Tipo';
                }
                field("D365L CO VAT Registration No."; Rec."D365L CO VAT Registration No.")
                {
                    ApplicationArea = all;
                    Caption = 'No. Identificación';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                    Caption = 'Razón Social';
                }
            }
        }
    }
}