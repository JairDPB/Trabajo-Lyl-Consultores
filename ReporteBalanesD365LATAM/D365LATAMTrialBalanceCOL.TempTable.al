table 90148 "D365LATAM TrialBalanceCOL"
{
    DataClassification = ToBeClassified;
    TableType = Temporary;

    fields
    {
        field(80629; ID; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(80620; "G_L_Account_No_"; Code[20]) { DataClassification = ToBeClassified; }
        field(80621; "G_L_Account_Name"; Text[200]) { DataClassification = ToBeClassified; }
        field(80622; "Shortcut_Dimension_3_Code"; Code[25]) { DataClassification = ToBeClassified; }
        field(80623; Amount; Decimal) { DataClassification = ToBeClassified; }
        field(80624; "Debit_Amount"; Decimal) { DataClassification = ToBeClassified; }
        field(80625; "Credit_Amount"; Decimal) { DataClassification = ToBeClassified; }
        field(80626; "Posting_Date"; Date) { DataClassification = ToBeClassified; }
        field(80627; "InitialBalance_debit"; Decimal) { DataClassification = ToBeClassified; }
        field(80630; "InitialBalance_credit"; Decimal) { DataClassification = ToBeClassified; }
        field(80628; "Dimension_Value_Name"; Text[100]) { DataClassification = ToBeClassified; }
        field(80631; AccountType; Integer) { DataClassification = ToBeClassified; }
        field(80632; AccountTotailng; Text[50]) { DataClassification = ToBeClassified; }
        field(80633; "Amount_credit"; Decimal) { DataClassification = ToBeClassified; }
        field(80634; "Amount_debit"; Decimal) { DataClassification = ToBeClassified; }
        field(80635; "Shortcut_Dimension_4_Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(80636; AltAccount; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(80637; Nitcode; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
    }
}