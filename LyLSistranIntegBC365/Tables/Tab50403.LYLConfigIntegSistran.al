table 50403 LYLConfigIntegSistran
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; UrlServicio; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(3; KeyServicio; text[50])
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