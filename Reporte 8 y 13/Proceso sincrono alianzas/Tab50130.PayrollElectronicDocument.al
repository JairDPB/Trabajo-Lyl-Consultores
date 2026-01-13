table 50130 "Payroll Electronic Document"
{
    DataClassification = CustomerContent;

    fields
    {
        // Tipo
        field(1; "Tipo"; Code[10]) { }

        // Periodo
        field(10; "FechaIngreso"; Date) { }
        field(11; "FechaLiquidacionInicio"; Date) { }
        field(12; "FechaLiquidacionFin"; Date) { }
        field(13; "TiempoLaborado"; Integer) { }
        field(14; "FechaGen"; Date) { }

        // NumeroSecuenciaXML
        field(20; "CodigoTrabajador"; Code[20]) { }
        field(21; "Prefijo"; Code[10]) { }
        field(22; "Consecutivo"; Code[20]) { }
        field(23; "Numero"; Code[30]) { }  // CLAVE PARA RELACIÓN

        // LugarGeneracionXML
        field(30; "Pais"; Code[10]) { }
        field(31; "DepartamentoEstado"; Code[10]) { }
        field(32; "MunicipioCiudad"; Code[10]) { }
        field(33; "Idioma"; Code[10]) { }

        // InformacionGeneral
        field(40; "Version"; Text[100]) { }
        field(41; "Ambiente"; Code[10]) { }
        field(42; "TipoXML"; Code[10]) { }
        field(43; "HoraGen"; Time) { }
        field(44; "PeriodoNomina"; Code[10]) { }
        field(45; "TipoMoneda"; Code[10]) { }

        // Empleador
        field(50; "RazonSocial"; Text[100]) { }
        field(51; "NIT"; Code[20]) { }
        field(52; "DV"; Code[2]) { }
        field(53; "PaisEmpleador"; Code[10]) { }
        field(54; "DepartamentoEmpleador"; Code[10]) { }
        field(55; "MunicipioEmpleador"; Code[10]) { }
        field(56; "DireccionEmpleador"; Text[100]) { }

        // Trabajador
        field(60; "TipoTrabajador"; Code[10]) { }
        field(61; "SubTipoTrabajador"; Code[10]) { }
        field(62; "AltoRiesgoPension"; Boolean) { }
        field(63; "TipoDocumento"; Code[10]) { }
        field(64; "NumeroDocumento"; Code[20]) { }
        field(65; "PrimerApellido"; Text[50]) { }
        field(66; "SegundoApellido"; Text[50]) { }
        field(67; "PrimerNombre"; Text[50]) { }
        field(68; "LugarTrabajoPais"; Code[10]) { }
        field(69; "LugarTrabajoDepartamento"; Code[10]) { }
        field(70; "LugarTrabajoMunicipio"; Code[10]) { }
        field(71; "LugarTrabajoDireccion"; Text[100]) { }
        field(72; "SalarioIntegral"; Boolean) { }
        field(73; "TipoContrato"; Code[10]) { }
        field(74; "Sueldo"; Decimal) { AutoFormatType = 1; }

        // Pago
        field(80; "Forma"; Code[10]) { }
        field(81; "Metodo"; Code[10]) { }
        field(82; "Banco"; Text[50]) { }
        field(83; "TipoCuenta"; Text[30]) { }
        field(84; "NumeroCuenta"; Code[30]) { }

        // FechasPagos
        field(90; "FechaPago"; Date) { }

        // Devengados - Basico
        field(100; "DiasTrabajados"; Integer) { }
        field(101; "SueldoTrabajado"; Decimal) { AutoFormatType = 1; }

        // Devengados - Cesantias
        field(110; "CesantiasPago"; Decimal) { AutoFormatType = 1; }
        field(111; "CesantiasPorcentaje"; Decimal) { }
        field(112; "CesantiasPagoIntereses"; Decimal) { AutoFormatType = 1; }

        // Deducciones - Salud
        field(120; "SaludPorcentaje"; Decimal) { }
        field(121; "SaludDeduccion"; Decimal) { AutoFormatType = 1; }

        // Deducciones - FondoPension
        field(130; "PensionPorcentaje"; Decimal) { }
        field(131; "PensionDeduccion"; Decimal) { AutoFormatType = 1; }

        // Deducciones - FondoSP
        field(140; "FondoSPPorcentaje"; Decimal) { }
        field(141; "FondoSPDeduccion"; Decimal) { AutoFormatType = 1; }
        field(142; "FondoSPPorcentajeSub"; Decimal) { }
        field(143; "FondoSPDeduccionSub"; Decimal) { AutoFormatType = 1; }

        // Deducciones - Otras
        field(150; "PagosTerceros"; Decimal) { AutoFormatType = 1; }
        field(151; "OtrasDeducciones"; Decimal) { AutoFormatType = 1; }
        field(152; "RetencionFuente"; Decimal) { AutoFormatType = 1; }
        field(153; "AFC"; Decimal) { AutoFormatType = 1; }
        field(154; "Cooperativa"; Decimal) { AutoFormatType = 1; }

        // Totales
        field(160; "DevengadosTotal"; Decimal) { AutoFormatType = 1; }
        field(161; "DeduccionesTotal"; Decimal) { AutoFormatType = 1; }
        field(162; "ComprobanteTotal"; Decimal) { AutoFormatType = 1; }
    }

    keys
    {
        key(PK; "Numero")
        {
            Clustered = true;
        }
    }
}
