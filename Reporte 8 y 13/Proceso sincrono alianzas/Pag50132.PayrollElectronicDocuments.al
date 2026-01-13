page 50132 "Payroll Electronic Documents"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Payroll Electronic Document";
    Caption = 'Documentos Nómina Electrónica';
    
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Numero"; Rec."Numero") 
                { 
                    ApplicationArea = All;
                }
                field("Tipo"; Rec."Tipo") 
                { 
                    ApplicationArea = All;
                }
                field("FechaGen"; Rec."FechaGen") 
                { 
                    ApplicationArea = All;
                }
                field("CodigoTrabajador"; Rec."CodigoTrabajador") 
                { 
                    ApplicationArea = All;
                }
                field("PrimerNombre"; Rec."PrimerNombre") 
                { 
                    ApplicationArea = All;
                }
                field("PrimerApellido"; Rec."PrimerApellido") 
                { 
                    ApplicationArea = All;
                }
                field("NumeroDocumento"; Rec."NumeroDocumento") 
                { 
                    ApplicationArea = All;
                }
                field("FechaLiquidacionInicio"; Rec."FechaLiquidacionInicio") 
                { 
                    ApplicationArea = All;
                }
                field("FechaLiquidacionFin"; Rec."FechaLiquidacionFin") 
                { 
                    ApplicationArea = All;
                }
                field("DiasTrabajados"; Rec."DiasTrabajados") 
                { 
                    ApplicationArea = All;
                }
                field("DevengadosTotal"; Rec."DevengadosTotal") 
                { 
                    ApplicationArea = All;
                }
                field("DeduccionesTotal"; Rec."DeduccionesTotal") 
                { 
                    ApplicationArea = All;
                }
                field("ComprobanteTotal"; Rec."ComprobanteTotal") 
                { 
                    ApplicationArea = All;
                }
                field("Banco"; Rec."Banco") 
                { 
                    ApplicationArea = All;
                }
                field("NumeroCuenta"; Rec."NumeroCuenta") 
                { 
                    ApplicationArea = All;
                }
            }
        }
    }
}