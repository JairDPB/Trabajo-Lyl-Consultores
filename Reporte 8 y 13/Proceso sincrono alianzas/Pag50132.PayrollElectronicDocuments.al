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
                // Tipo
                field("Tipo"; Rec."Tipo") { ApplicationArea = All; }

                // Periodo
                field("FechaIngreso"; Rec."FechaIngreso") { ApplicationArea = All; }
                field("FechaLiquidacionInicio"; Rec."FechaLiquidacionInicio") { ApplicationArea = All; }
                field("FechaLiquidacionFin"; Rec."FechaLiquidacionFin") { ApplicationArea = All; }
                field("TiempoLaborado"; Rec."TiempoLaborado") { ApplicationArea = All; }
                field("FechaGen"; Rec."FechaGen") { ApplicationArea = All; }

                // NumeroSecuenciaXML
                field("CodigoTrabajador"; Rec."CodigoTrabajador") { ApplicationArea = All; }
                field("Prefijo"; Rec."Prefijo") { ApplicationArea = All; }
                field("Consecutivo"; Rec."Consecutivo") { ApplicationArea = All; }
                field("Numero"; Rec."Numero") { ApplicationArea = All; }

                // LugarGeneracionXML
                field("Pais"; Rec."Pais") { ApplicationArea = All; }
                field("DepartamentoEstado"; Rec."DepartamentoEstado") { ApplicationArea = All; }
                field("MunicipioCiudad"; Rec."MunicipioCiudad") { ApplicationArea = All; }
                field("Idioma"; Rec."Idioma") { ApplicationArea = All; }

                // InformacionGeneral
                field("Version"; Rec."Version") { ApplicationArea = All; }
                field("Ambiente"; Rec."Ambiente") { ApplicationArea = All; }
                field("TipoXML"; Rec."TipoXML") { ApplicationArea = All; }
                field("HoraGen"; Rec."HoraGen") { ApplicationArea = All; }
                field("PeriodoNomina"; Rec."PeriodoNomina") { ApplicationArea = All; }
                field("TipoMoneda"; Rec."TipoMoneda") { ApplicationArea = All; }

                // Empleador
                field("RazonSocial"; Rec."RazonSocial") { ApplicationArea = All; }
                field("NIT"; Rec."NIT") { ApplicationArea = All; }
                field("DV"; Rec."DV") { ApplicationArea = All; }
                field("PaisEmpleador"; Rec."PaisEmpleador") { ApplicationArea = All; }
                field("DepartamentoEmpleador"; Rec."DepartamentoEmpleador") { ApplicationArea = All; }
                field("MunicipioEmpleador"; Rec."MunicipioEmpleador") { ApplicationArea = All; }
                field("DireccionEmpleador"; Rec."DireccionEmpleador") { ApplicationArea = All; }

                // Trabajador
                field("TipoTrabajador"; Rec."TipoTrabajador") { ApplicationArea = All; }
                field("SubTipoTrabajador"; Rec."SubTipoTrabajador") { ApplicationArea = All; }
                field("AltoRiesgoPension"; Rec."AltoRiesgoPension") { ApplicationArea = All; }
                field("TipoDocumento"; Rec."TipoDocumento") { ApplicationArea = All; }
                field("NumeroDocumento"; Rec."NumeroDocumento") { ApplicationArea = All; }
                field("PrimerApellido"; Rec."PrimerApellido") { ApplicationArea = All; }
                field("SegundoApellido"; Rec."SegundoApellido") { ApplicationArea = All; }
                field("PrimerNombre"; Rec."PrimerNombre") { ApplicationArea = All; }
                field("LugarTrabajoPais"; Rec."LugarTrabajoPais") { ApplicationArea = All; }
                field("LugarTrabajoDepartamento"; Rec."LugarTrabajoDepartamentoEstado") { ApplicationArea = All; }
                field("LugarTrabajoMunicipio"; Rec."LugarTrabajoMunicipioCiudad") { ApplicationArea = All; }
                field("LugarTrabajoDireccion"; Rec."LugarTrabajoDireccion") { ApplicationArea = All; }
                field("SalarioIntegral"; Rec."SalarioIntegral") { ApplicationArea = All; }
                field("TipoContrato"; Rec."TipoContrato") { ApplicationArea = All; }
                field("Sueldo"; Rec."Sueldo") { ApplicationArea = All; }

                // Pago
                field("Forma"; Rec."Forma") { ApplicationArea = All; }
                field("Metodo"; Rec."Metodo") { ApplicationArea = All; }
                field("Banco"; Rec."Banco") { ApplicationArea = All; }
                field("TipoCuenta"; Rec."TipoCuenta") { ApplicationArea = All; }
                field("NumeroCuenta"; Rec."NumeroCuenta") { ApplicationArea = All; }

                // FechasPagos
                field("FechaPago"; Rec."FechaPago") { ApplicationArea = All; }

                // Devengados - Basico
                field("DiasTrabajados"; Rec."DiasTrabajados") { ApplicationArea = All; }
                field("SueldoTrabajado"; Rec."SueldoTrabajado") { ApplicationArea = All; }

                // Devengados - Cesantias
                field("CesantiasPago"; Rec."CesantiasPago") { ApplicationArea = All; }
                field("CesantiasPorcentaje"; Rec."CesantiasPorcentaje") { ApplicationArea = All; }
                field("CesantiasPagoIntereses"; Rec."CesantiasPagoIntereses") { ApplicationArea = All; }

                // Deducciones - Salud
                field("SaludPorcentaje"; Rec."SaludPorcentaje") { ApplicationArea = All; }
                field("SaludDeduccion"; Rec."SaludDeduccion") { ApplicationArea = All; }

                // Deducciones - FondoPension
                field("PensionPorcentaje"; Rec."PensionPorcentaje") { ApplicationArea = All; }
                field("PensionDeduccion"; Rec."PensionDeduccion") { ApplicationArea = All; }

                // Deducciones - FondoSP
                field("FondoSPPorcentaje"; Rec."FondoSPPorcentaje") { ApplicationArea = All; }
                field("FondoSPDeduccion"; Rec."FondoSPDeduccion") { ApplicationArea = All; }
                field("FondoSPPorcentajeSub"; Rec."FondoSPPorcentajeSub") { ApplicationArea = All; }
                field("FondoSPDeduccionSub"; Rec."FondoSPDeduccionSub") { ApplicationArea = All; }

                // Deducciones - Otras
                field("PagosTerceros"; Rec."PagosTerceros") { ApplicationArea = All; }
                field("OtrasDeducciones"; Rec."OtrasDeducciones") { ApplicationArea = All; }
                field("RetencionFuente"; Rec."RetencionFuente") { ApplicationArea = All; }
                field("AFC"; Rec."AFC") { ApplicationArea = All; }
                field("Cooperativa"; Rec."Cooperativa") { ApplicationArea = All; }

                // Totales
                field("DevengadosTotal"; Rec."DevengadosTotal") { ApplicationArea = All; }
                field("DeduccionesTotal"; Rec."DeduccionesTotal") { ApplicationArea = All; }
                field("ComprobanteTotal"; Rec."ComprobanteTotal") { ApplicationArea = All; }
            }
        }
    }
}