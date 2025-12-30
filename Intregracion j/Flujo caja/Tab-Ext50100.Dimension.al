tableextension 50106 Dimension extends Dimension
{
    fields
    {
        field(50120; "Flujo de caja"; Boolean)
        {
            Caption = 'Flujo de caja';
            DataClassification = CustomerContent;
        
            trigger OnValidate()
                var
                    Dim: Record Dimension;
                begin
                    if "Flujo de caja" then begin
                        Dim.Reset();
                        Dim.SetRange("Flujo de caja", true);
                        Dim.SetFilter(Code, '<>%1', Code);

                        if Dim.FindFirst() then
                            Error('Solo una dimensión puede estar marcada como Flujo de caja.');
                    end;
                end;        
        }
    }
}
