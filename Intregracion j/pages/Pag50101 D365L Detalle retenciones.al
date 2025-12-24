page 50101 "D635L Detalle retenciones"
{
    ApplicationArea = All;
    Caption = 'Detalle retenciones';
    PageType = Card;
    SourceTable = "VAT Entry";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'VAT Entry';

                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }

                field(Base; Rec.Base)
                {
                    ApplicationArea = All;
                }
                field("Bill-to/Pay-to No."; Rec."Bill-to/Pay-to No.")
                {
                    ApplicationArea = All;
                }
            }

            group("Purch. Invoice")
            {
                Caption = 'Purchase Invoice';

                field(PurchAmount; PurchAmount)
                {
                    ApplicationArea = All;
                    Caption = 'Invoice Amount';
                    Editable = false;
                }
            }

            group("Tax Jurisdiction")
            {
                Caption = 'Tax Jurisdiction';

                field(TaxDescription; TaxDescription)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                    Editable = false;
                }

                field(TaxCity; TaxCity)
                {
                    ApplicationArea = All;
                    Caption = 'City';
                    Editable = false;
                }
            }
        }
    }

    var
        PurchInvHeader: Record "Purch. Inv. Header";
        TaxJurisdiction: Record "Tax Jurisdiction";
        PurchAmount: Decimal;
        TaxDescription: Text[100];
        TaxCity: Text[50];

    trigger OnAfterGetRecord()
    begin
        Clear(PurchAmount);
        Clear(TaxDescription);
        Clear(TaxCity);

        // Obtener datos de Purch. Inv. Header
        if PurchInvHeader.Get(Rec."Document No.") then
            PurchAmount := PurchInvHeader.Amount;

        // Obtener datos de Tax Jurisdiction
        if TaxJurisdiction.Get(Rec."Tax Jurisdiction Code") then begin
            TaxDescription := TaxJurisdiction.Description;
            TaxCity := TaxJurisdiction."D365L CO City";
        end;
    end;
}
