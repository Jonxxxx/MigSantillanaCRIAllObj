xmlport 52000 "Config. nomina can"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(ConfigNominaCan)
        {
            tableelement(Table34002103;Table34002103)
            {
                XmlName = 'ConfiguracionNominas';
                fieldelement(CN_Codigo;"Configuración nominas".Codigo)
                {
                }
                fieldelement(CN_NoSerieNominas;"Configuración nominas"."No. serie nominas")
                {
                }
                fieldelement(CN_NoSerieCxC;"Configuración nominas"."No. serie CxC")
                {
                }
                fieldelement(CN_NoSerieRegCxC;"Configuración nominas"."No. serie reg. CxC")
                {
                }
                fieldelement(CN_JournalTemplateName;"Configuración nominas"."Journal Template Name")
                {
                }
                fieldelement(CN_JournalBatchName;"Configuración nominas"."Journal Batch Name")
                {
                }
                fieldelement(CN_DimensionConceptosSalariales;"Configuración nominas"."Dimension Conceptos Salariales")
                {
                }
                fieldelement(CN_IncidenciasAusenciaPropinas;"Configuración nominas"."Incidencias Ausencia Propinas")
                {
                }
                fieldelement(CN_IncidenciasDtoNomina;"Configuración nominas"."Incidencias Dto. Nomina")
                {
                }
                fieldelement(CN_ConceptoSalarialIncentivos;"Configuración nominas"."Concepto Incentivos")
                {
                }
                fieldelement(CN_ImpuestosManuales;"Configuración nominas"."Impuestos manuales")
                {
                }
                fieldelement(CN_ConceptoSalarialCxCEmpl;"Configuración nominas"."Concepto CxC Empl.")
                {
                }
                fieldelement(CN_Incidencia;"Configuración nominas"."Concepto ISR Cobrado en exceso")
                {
                }
                fieldelement(CN_ConceptoSalBase;"Configuración nominas"."Concepto Sal. Base")
                {
                }
                fieldelement(CN_ConceptoISR;"Configuración nominas"."Concepto ISR")
                {
                }
                fieldelement(CN_ConceptoARS;"Configuración nominas"."Concepto Retroactivo")
                {
                }
                fieldelement(CN_ConceptoInasistencia;"Configuración nominas"."Concepto Inasistencia")
                {
                }
                fieldelement(CN_ConceptoAFP;"Configuración nominas"."Concepto AFP")
                {
                }
                fieldelement(CN_ConceptoSFS;"Configuración nominas"."Concepto SFS")
                {
                }
                fieldelement(CN_ConceptoRegalia;"Configuración nominas"."Concepto Regalia")
                {
                }
                fieldelement(CN_ConceptoBonificacion;"Configuración nominas"."Concepto Bonificacion")
                {
                }
                fieldelement(CN_ConceptoVacaciones;"Configuración nominas"."Concepto Vacaciones")
                {
                }
                fieldelement(CN_ConceptoHorasExt100;"Configuración nominas"."Concepto Horas Ext. 100%")
                {
                }
                fieldelement(CN_ConceptoHorasExt35;"Configuración nominas"."Concepto Horas Ext. 35%")
                {
                }
                fieldelement(CN_ConceptoHorasExt15;"Configuración nominas"."Concepto Sal. hora")
                {
                }
                fieldelement(CN_ConceptoSRL;"Configuración nominas"."Concepto SRL")
                {
                }
                fieldelement(CN_ConceptINFOTEP;"Configuración nominas"."Concepto INFOTEP")
                {
                }
                fieldelement(CN_ConceptoOtrosIngresos3;"Configuración nominas"."Concepto Dias feriados")
                {
                }
                fieldelement(CN_ConceptoOtrosIngresos4;"Configuración nominas"."Concepto Horas nocturnas")
                {
                }
                fieldelement(CN_ConceptoOtrosIngresos5;"Configuración nominas"."Job Journal Template Name")
                {
                }
                fieldelement(CN_ConceptoOtrasDeducciones1;"Configuración nominas"."Job Journal Batch Name")
                {
                }
                fieldelement(CN_ConceptoOtrasDeducciones2;"Configuración nominas"."Concepto Dieta")
                {
                }
                fieldelement(CN_ConceptoOtrasDeducciones3;"Configuración nominas"."Concepto Transporte")
                {
                }
                fieldelement(CN_SalarioMinimo;"Configuración nominas"."Salario Minimo")
                {
                }
                fieldelement(CN_SecuenciaArchivoBatch;"Configuración nominas"."Secuencia de archivo Batch")
                {
                }
                fieldelement(CN_FechaSecuencia;"Configuración nominas"."Fecha secuencia")
                {
                }
                fieldelement(CN_MetodoCalculoAusencias;"Configuración nominas"."Método cálculo ausencias")
                {
                }
                fieldelement(CN_NoSerieEmpleados;"Configuración nominas"."Concepto devolucion ISR")
                {
                }
                fieldelement(CN_TasaCambioCalculoDivisa;"Configuración nominas"."Tasa Cambio Calculo Divisa")
                {
                }
                fieldelement(CN_MetodoCalculoIngresos;"Configuración nominas"."Metodo calculo Ingresos")
                {
                }
                fieldelement(CN_MetodoCalculoBajas;"Configuración nominas"."Metodo calculo Salidas")
                {
                }
                fieldelement(CN_CodBcoNominasPagoTransf;"Configuración nominas"."Cód. Cta. Nominas Pago Transf.")
                {
                }
                fieldelement(CN_CodCtaNominasOtrosPagos;"Configuración nominas"."Cta. Nominas Otros Pagos")
                {
                }
                fieldelement(CN_WebPageTSS;"Configuración nominas"."Web Page TSS")
                {
                }
                fieldelement(CN_WebPageGII;"Configuración nominas"."Web Page DGII")
                {
                }
                fieldelement(CN_PathArchivosElectronicos;"Configuración nominas"."Path Archivos Electronicos")
                {
                }
                fieldelement(CN_ImportAnualHSSBaseISR;"Configuración nominas"."Importe Anual IHSS Base ISR")
                {
                }
                fieldelement(CN_Disponible;"Configuración nominas"."% dif. Ingresos y descuentos")
                {
                }
                fieldelement(CN_Disponible2;"Configuración nominas"."Tipo cuenta")
                {
                }
                fieldelement(CN_Disponible3;"Configuración nominas"."Vacaciones colectivas")
                {
                }
                fieldelement(CN_TextoEmailRecibos;"Configuración nominas"."Texto email recibos")
                {
                }
                fieldelement(CN_TiempoEsperaEnvioEmail;"Configuración nominas"."Tiempo espera Envio email")
                {
                }
                fieldelement(CN_JournalTemplateNameCK;"Configuración nominas"."Journal Template Name CK")
                {
                }
                fieldelement(CN_JournalBatchNameCK;"Configuración nominas"."Journal Batch Name CK")
                {
                }
                fieldelement(CN_TipoCtaOtrosPagos;"Configuración nominas"."Tipo Cta. Otros Pagos")
                {
                }
            }
            tableelement(Table34002107;Table34002107)
            {
                XmlName = 'ParametrosCalculoDias';
                fieldelement(PCD_Codigo;"Parametros Calculo Dias".Codigo)
                {
                }
                fieldelement(PCD_Descripcion;"Parametros Calculo Dias".Descripcion)
                {
                }
                fieldelement(PCD_Valor;"Parametros Calculo Dias".Valor)
                {
                }
            }
            tableelement(Table34002110;Table34002110)
            {
                XmlName = 'PuestosLaborales';
                fieldelement(PL_Codigo;"Puestos laborales"."Código")
                {
                }
                fieldelement(PL_Descripcion;"Puestos laborales"."Descripción")
                {
                }
                fieldelement(PL_NivelSalarialMinimo;"Puestos laborales"."Cod. nivel")
                {
                }
                fieldelement(PL_CodSupervisor;"Puestos laborales"."Cod. Supervisor")
                {
                }
                fieldelement(PL_NombreCompleto;"Puestos laborales"."Nombre Completo")
                {
                }
            }
            tableelement(Table34002135;Table34002135)
            {
                XmlName = 'Departamentos';
                fieldelement(D_Codigo;Departamentos.Codigo)
                {
                }
                fieldelement(D_Descripcion;Departamentos.Descripcion)
                {
                }
                fieldelement(D_TotalEmpleados;Departamentos."Total Empleados")
                {
                }
            }
            tableelement(Table34002136;Table34002136)
            {
                XmlName = 'SubDepartamentos';
                fieldelement(SD_CodDepartamento;"Sub-Departamentos"."Cod. Departamento")
                {
                }
                fieldelement(SD_Codigo;"Sub-Departamentos".Codigo)
                {
                }
                fieldelement(SD_Descripcion;"Sub-Departamentos".Descripcion)
                {
                }
            }
            tableelement(Table34002131;Table34002131)
            {
                XmlName = 'TablaRetencionISR';
                fieldelement(TISR_Ano;"Tabla retencion ISR".Ano)
                {
                }
                fieldelement(TISR_NoOrden;"Tabla retencion ISR"."No. orden")
                {
                }
                fieldelement(TISR_ImporteMaximo;"Tabla retencion ISR"."Importe Máximo")
                {
                }
                fieldelement(TISR_ImporteRetencion;"Tabla retencion ISR"."Importe retención")
                {
                }
                fieldelement(TISR_Retencion;"Tabla retencion ISR"."% Retención")
                {
                }
            }
            tableelement(Table348;Table348)
            {
                XmlName = 'Dimension';
                fieldelement(Dim_Code;Dimension.Code)
                {
                }
                fieldelement(Dim_Name;Dimension.Name)
                {
                }
                fieldelement(Dim_CodeCaption;Dimension."Code Caption")
                {
                }
                fieldelement(Dim_FilterCaption;Dimension."Filter Caption")
                {
                }
                fieldelement(Dim_Description;Dimension.Description)
                {
                }
                fieldelement(Dim_Blocked;Dimension.Blocked)
                {
                }
                fieldelement(Dim_ConsolidationCode;Dimension."Consolidation Code")
                {
                }
                fieldelement(Dim_MapToICDimensionCode;Dimension."Map-to IC Dimension Code")
                {
                }
            }
            tableelement(Table349;Table349)
            {
                XmlName = 'DimensionValue';
                fieldelement(DV_DimensionCode;"Dimension Value"."Dimension Code")
                {
                }
                fieldelement(DV_Code;"Dimension Value".Code)
                {
                }
                fieldelement(DV_Name;"Dimension Value".Name)
                {
                }
                fieldelement(DV_DimensionValueType;"Dimension Value"."Dimension Value Type")
                {
                }
                fieldelement(DV_Totaling;"Dimension Value".Totaling)
                {
                }
                fieldelement(DV_Blocked;"Dimension Value".Blocked)
                {
                }
                fieldelement(DV_ConsolidationCode;"Dimension Value"."Consolidation Code")
                {
                }
                fieldelement(DV_Indentation;"Dimension Value".Indentation)
                {
                }
                fieldelement(DV_GlobalDimensionNo;"Dimension Value"."Global Dimension No.")
                {
                }
                fieldelement(DV_MapToICDimensionCode;"Dimension Value"."Map-to IC Dimension Code")
                {
                }
                fieldelement(DV_MapToICDimensionValueCode;"Dimension Value"."Map-to IC Dimension Value Code")
                {
                }
            }
            tableelement(Table34002129;Table34002129)
            {
                XmlName = 'TiposCotizacion';
                fieldelement(TC_Ano;"Tipos de Cotización".Ano)
                {
                }
                fieldelement(TC_Codigo;"Tipos de Cotización"."Código")
                {
                }
                fieldelement(TC_Descripcion;"Tipos de Cotización"."Descripción")
                {
                }
                fieldelement(TC_PorcientoEmpresa;"Tipos de Cotización"."Porciento Empresa")
                {
                }
                fieldelement(TC_PorcientoEmpleado;"Tipos de Cotización"."Porciento Empleado")
                {
                }
                fieldelement(TC_CuotaEmpresa;"Tipos de Cotización"."Cuota Empresa")
                {
                }
                fieldelement(TC_CuotaEmpleado;"Tipos de Cotización"."Cuota Empleado")
                {
                }
                fieldelement(TC_BaseAplicar;"Tipos de Cotización"."Base aplicar")
                {
                }
                fieldelement(TC_TopeSalarialAcumuladoAnual;"Tipos de Cotización"."Tope Salarial/Acumulado Anual")
                {
                }
                fieldelement(TC_AcumulaPor;"Tipos de Cotización"."Acumula por")
                {
                }
            }
            tableelement(Table34002134;Table34002134)
            {
                XmlName = 'Calendario';
                fieldelement(C_Fecha;Calendario.Fecha)
                {
                }
                fieldelement(C_Texto;Calendario.Texto)
                {
                }
                fieldelement(C_Festivo;Calendario."No laborable")
                {
                }
                fieldelement(C_DiaDeLaSemana;Calendario."Día de la semana")
                {
                }
                fieldelement(C_Semana;Calendario.Semana)
                {
                }
                fieldelement(C_Generado;Calendario.Generado)
                {
                }
                fieldelement("C_Período";Calendario."Período")
                {
                }
                fieldelement(C_Ano;Calendario.Ano)
                {
                }
                fieldelement(C_Mes;Calendario.Mes)
                {
                }
            }
            tableelement(Table34002113;Table34002113)
            {
                XmlName = 'PerfilSalarioCargo';
                fieldelement(PSC_PuestoDeTrabajo;"Perfil Salario x Cargo"."Puesto de Trabajo")
                {
                }
                fieldelement(PSC_ConceptoSalarial;"Perfil Salario x Cargo"."Concepto salarial")
                {
                }
                fieldelement(PSC_NoDeOrden;"Perfil Salario x Cargo"."No. de Orden")
                {
                }
                fieldelement(PSC_Descripcion;"Perfil Salario x Cargo"."Descripción")
                {
                }
                fieldelement(PSC_Importe;"Perfil Salario x Cargo".Field5)
                {
                }
                fieldelement(PSC_NivelSalarial;"Perfil Salario x Cargo".Field6)
                {
                }
                fieldelement(PSC_TipoConcepto;"Perfil Salario x Cargo"."Tipo concepto")
                {
                }
                fieldelement("PSC_SujetoCotización";"Perfil Salario x Cargo".Field8)
                {
                }
                fieldelement(PSC_CotizaISR;"Perfil Salario x Cargo".Field9)
                {
                }
                fieldelement(PSC_Prorratear;"Perfil Salario x Cargo".Field10)
                {
                }
                fieldelement(PSC_FormulaCalculo;"Perfil Salario x Cargo".Field11)
                {
                }
                fieldelement(PSC_PrimeraQuincena;"Perfil Salario x Cargo"."1ra Quincena")
                {
                }
                fieldelement(PSC_SegundaQuincena;"Perfil Salario x Cargo"."2da Quincena")
                {
                }
                fieldelement(PSC_CotizaAFP;"Perfil Salario x Cargo".Field14)
                {
                }
                fieldelement(PSC_AplicaSRL;"Perfil Salario x Cargo"."Fórmula cálculo")
                {
                }
                fieldelement(PSC_CotizaINFOTEP;"Perfil Salario x Cargo".Field16)
                {
                }
                fieldelement(PSC_CotizaSFS;"Perfil Salario x Cargo".Field17)
                {
                }
                fieldelement(PSC_AplicaParaRegalia;"Perfil Salario x Cargo".Field18)
                {
                }
            }
            tableelement(Table34002108;Table34002108)
            {
                XmlName = 'DistribIngresoPagosElect';
                fieldelement(DIPE_NoEempleado;"Distrib. Ingreso Pagos Elect."."No. empleado")
                {
                }
                fieldelement(DIPE_CodBanco;"Distrib. Ingreso Pagos Elect."."Cod. Banco")
                {
                }
                fieldelement(DIPE_TipoCuenta;"Distrib. Ingreso Pagos Elect."."Tipo Cuenta")
                {
                }
                fieldelement(DIPE_NumeroCuenta;"Distrib. Ingreso Pagos Elect."."Numero Cuenta")
                {
                }
                fieldelement(DIPE_TipoImporte;"Distrib. Ingreso Pagos Elect."."Nro. tarjeta")
                {
                }
                fieldelement(DIPE_Importe;"Distrib. Ingreso Pagos Elect.".Importe)
                {
                }
            }
            tableelement(Table34002167;Table34002167)
            {
                XmlName = 'BancosACHNomina';
                fieldelement(BACHN_CodBanco;"Bancos ACH Nomina"."Cod. Banco")
                {
                }
                fieldelement(BACHN_Descripcion;"Bancos ACH Nomina".Descripcion)
                {
                }
                fieldelement(BACHN_CodInstitucionFinanciera;"Bancos ACH Nomina"."Cod. Institucion Financiera")
                {
                }
            }
            tableelement(Table34002100;Table34002100)
            {
                XmlName = 'EmpresasCotizacion';
                fieldelement("EC_EmpresaCotización";"Empresas Cotización"."Empresa cotización")
                {
                }
                fieldelement("EC_NombreEmpresacotización";"Empresas Cotización"."Nombre Empresa cotización")
                {
                }
                fieldelement(EC_Direccion;"Empresas Cotización"."Dirección")
                {
                }
                fieldelement(EC_Numero;"Empresas Cotización"."Número")
                {
                }
                fieldelement(EC_CodigoPostal;"Empresas Cotización"."Código Postal")
                {
                }
                fieldelement(EC_Municipio;"Empresas Cotización".Municipio)
                {
                }
                fieldelement(EC_Provincia;"Empresas Cotización".Provincia)
                {
                }
                fieldelement("EC_Teléfono";"Empresas Cotización"."Teléfono")
                {
                }
                fieldelement(EC_DomicilioFiscal;"Empresas Cotización"."Domicilio fiscal")
                {
                }
                fieldelement(EC_CodPais;"Empresas Cotización"."Cód. país")
                {
                }
                fieldelement(EC_TipoDocumento;"Empresas Cotización"."Tipo de documento")
                {
                }
                fieldelement(EC_RNCCED;"Empresas Cotización"."RNC/CED")
                {
                }
                fieldelement(EC_GrupoContable;"Empresas Cotización"."Grupo contable")
                {
                }
                fieldelement(EC_EsquemaPercepcion;"Empresas Cotización"."Esquema percepción")
                {
                }
                fieldelement(EC_Banco;"Empresas Cotización".Banco)
                {
                }
                fieldelement(EC_Cuenta;"Empresas Cotización".Cuenta)
                {
                }
                fieldelement(EC_FormaPago;"Empresas Cotización"."Forma de Pago")
                {
                }
                fieldelement(EC_IDVolantePago;"Empresas Cotización"."ID  Volante Pago")
                {
                }
                fieldelement(EC_Comentario;"Empresas Cotización".Comentario)
                {
                }
                fieldelement(EC_GlobalDimension1Code;"Empresas Cotización"."Global Dimension 1 Code")
                {
                }
                fieldelement(EC_GlobalDimension2Code;"Empresas Cotización"."Global Dimension 2 Code")
                {
                }
                fieldelement(EC_UltNoContabilizacion;"Empresas Cotización"."Ult. No. Contabilización")
                {
                }
                fieldelement(EC_Fax;"Empresas Cotización".Fax)
                {
                }
                fieldelement(EC_EMail;"Empresas Cotización"."E-Mail")
                {
                }
                fieldelement(EC_IDRNL;"Empresas Cotización"."ID RNL")
                {
                }
                fieldelement(EC_IDTSS;"Empresas Cotización"."ID TSS")
                {
                }
                fieldelement(EC_TipoEmpresaTrabajo;"Empresas Cotización"."Tipo Empresa de Trabajo")
                {
                }
                fieldelement(EC_TipoPagoNomina;"Empresas Cotización"."Tipo Pago Nomina")
                {
                }
                fieldelement(EC_TasaRiesgo;"Empresas Cotización"."Tasa de Riesgo (%)")
                {
                }
                fieldelement(EC_SalarioMinimoTSS;"Empresas Cotización"."Salario Mínimo TSS")
                {
                }
                fieldelement(EC_EmployerIdentificationNumber;"Empresas Cotización"."Employer Identification Number")
                {
                }
            }
            tableelement(Table34002104;Table34002104)
            {
                XmlName = 'GruposContablesEmpleados';
                fieldelement(GCE_Codigo;"Grupos Contables Empleados"."Código")
                {
                }
                fieldelement(GCE_Descripcion;"Grupos Contables Empleados"."Descripción")
                {
                }
            }
            tableelement(Table34002105;Table34002105)
            {
                XmlName = 'DistCtasGpoContEmpl';
                fieldelement(DCGCE_Codigo;"Dist. Ctas. Gpo. Cont. Empl."."Código")
                {
                }
                fieldelement(DCGCE_Descripcion;"Dist. Ctas. Gpo. Cont. Empl."."Descripción")
                {
                }
                fieldelement(DCGCE_ShortcutDimension;"Dist. Ctas. Gpo. Cont. Empl."."Shortcut Dimension")
                {
                }
                fieldelement(DCGCE_CodigoConceptoSalarial;"Dist. Ctas. Gpo. Cont. Empl."."Código Concepto Salarial")
                {
                }
                fieldelement(DCGCE_TipoCuentaCuotaObrera;"Dist. Ctas. Gpo. Cont. Empl."."Tipo Cuenta Cuota Obrera")
                {
                }
                fieldelement(DCGCE_NoCuentaCuotaObrera;"Dist. Ctas. Gpo. Cont. Empl."."No. Cuenta Cuota Obrera")
                {
                }
                fieldelement(DCGCE_TipoCuentaCuotaPatronal;"Dist. Ctas. Gpo. Cont. Empl."."Tipo Cuenta Cuota Patronal")
                {
                }
                fieldelement(DCGCE_NoCuentaCuotaPatronal;"Dist. Ctas. Gpo. Cont. Empl."."No. Cuenta Cuota Patronal")
                {
                }
                fieldelement(DCGCE_TipoCuentaContrapartidaCO;"Dist. Ctas. Gpo. Cont. Empl."."Tipo Cuenta Contrapartida CO")
                {
                }
                fieldelement(DCGCE_NoCuentaContrapartidaCO;"Dist. Ctas. Gpo. Cont. Empl."."No. Cuenta Contrapartida CO")
                {
                }
                fieldelement(DCGCE_TipoCuentaContrapartidaCP;"Dist. Ctas. Gpo. Cont. Empl."."Tipo Cuenta Contrapartida CP")
                {
                }
                fieldelement(DCGCE_NoCuentaContrapartidaCP;"Dist. Ctas. Gpo. Cont. Empl."."No. Cuenta Contrapartida CP")
                {
                }
                fieldelement(DCGCE_ADistribuir;"Dist. Ctas. Gpo. Cont. Empl."."% a Distribuir")
                {
                }
                fieldelement(DCGCE_NoLinea;"Dist. Ctas. Gpo. Cont. Empl."."No. Linea")
                {
                }
            }
            tableelement(Table34002109;Table34002109)
            {
                XmlName = 'Contratos';
                fieldelement(C_EmpresaCotizacion;Contratos."Empresa cotización")
                {
                }
                fieldelement(C_NoEmpleado;Contratos."No. empleado")
                {
                }
                fieldelement(C_NoOrden;Contratos."No. Orden")
                {
                }
                fieldelement(C_Codcontrato;Contratos."Cód. contrato")
                {
                }
                fieldelement(C_Disponible;Contratos.Disponible)
                {
                }
                fieldelement(C_Descripcion;Contratos."Descripción")
                {
                }
                fieldelement(C_FechaInicio;Contratos."Fecha inicio")
                {
                }
                fieldelement(C_Duracion;Contratos.Duracion)
                {
                }
                fieldelement(C_FechaFinalizacion;Contratos."Fecha finalización")
                {
                }
                fieldelement(C_Cargo;Contratos.Cargo)
                {
                }
                fieldelement(C_CentroTrabajo;Contratos."Centro trabajo")
                {
                }
                fieldelement(C_MotivoBaja;Contratos."Motivo baja")
                {
                }
                fieldelement(C_Finalizado;Contratos.Finalizado)
                {
                }
                fieldelement(C_DiasPreaviso;Contratos."Días preaviso")
                {
                }
                fieldelement(C_PeriodoPrueba;Contratos."Período prueba")
                {
                }
                fieldelement(C_Jornada;Contratos.Jornada)
                {
                }
                fieldelement(C_DiasSemana;Contratos."Días semana")
                {
                }
                fieldelement(C_HorasDia;Contratos."Horas dia")
                {
                }
                fieldelement(C_HorasSemana;Contratos."Horas semana")
                {
                }
                fieldelement(C_CausaBaja;Contratos."Causa de la Baja")
                {
                }
                fieldelement(C_Indefinido;Contratos.Indefinido)
                {
                }
                fieldelement(C_Activo;Contratos.Activo)
                {
                }
            }
            tableelement(Table5200;Table5200)
            {
                XmlName = 'Employee';
                fieldelement(E_No;Employee."No.")
                {
                }
                fieldelement(E_FirstName;Employee."First Name")
                {
                }
                fieldelement(E_LastName;Employee."Last Name")
                {
                }
                fieldelement(E_Initials;Employee.Initials)
                {
                }
                fieldelement(E_JobTitle;Employee."Job Title")
                {
                }
                fieldelement(E_SearchName;Employee."Search Name")
                {
                }
                fieldelement(E_Address;Employee.Address)
                {
                }
                fieldelement(E_Address2;Employee."Address 2")
                {
                }
                fieldelement(E_City;Employee.City)
                {
                }
                fieldelement(E_PostCode;Employee."Post Code")
                {
                }
                fieldelement(E_County;Employee.County)
                {
                }
                fieldelement(E_PhoneNo;Employee."Phone No.")
                {
                }
                fieldelement(E_MobilePhoneNo;Employee."Mobile Phone No.")
                {
                }
                fieldelement(E_EMail;Employee."E-Mail")
                {
                }
                fieldelement(E_AltAddressCode;Employee."Alt. Address Code")
                {
                }
                fieldelement(E_AltAddressStartDate;Employee."Alt. Address Start Date")
                {
                }
                fieldelement(E_AltAddressEndDate;Employee."Alt. Address End Date")
                {
                }
                fieldelement(E_BirthDate;Employee."Birth Date")
                {
                }
                fieldelement(E_SocialSecurityNo;Employee."Social Security No.")
                {
                }
                fieldelement(E_UnionCode;Employee."Union Code")
                {
                }
                fieldelement(E_UnionMembershipNo;Employee."Union Membership No.")
                {
                }
                fieldelement(E_Gender;Employee.Gender)
                {
                }
                fieldelement(E_CountryRegionCode;Employee."Country/Region Code")
                {
                }
                fieldelement(E_ManagerNo;Employee."Manager No.")
                {
                }
                fieldelement(E_EmplymtContractCode;Employee."Emplymt. Contract Code")
                {
                }
                fieldelement(E_StatisticsGroupCode;Employee."Statistics Group Code")
                {
                }
                fieldelement(E_EmploymentDate;Employee."Employment Date")
                {
                }
                fieldelement(E_Status;Employee.Status)
                {
                }
                fieldelement(E_InactiveDate;Employee."Inactive Date")
                {
                }
                fieldelement(E_CauseInactivityCode;Employee."Cause of Inactivity Code")
                {
                }
                fieldelement(E_TerminationDate;Employee."Termination Date")
                {
                }
                fieldelement(E_GroundsTermCode;Employee."Grounds for Term. Code")
                {
                }
                fieldelement(E_GlobalDimension1Code;Employee."Global Dimension 1 Code")
                {
                }
                fieldelement(E_GlobalDimension2Code;Employee."Global Dimension 2 Code")
                {
                }
                fieldelement(E_ResourceNo;Employee."Resource No.")
                {
                }
                fieldelement(E_Comment;Employee.Comment)
                {
                }
                fieldelement(E_LastDateModified;Employee."Last Date Modified")
                {
                }
                fieldelement(E_DateFilter;Employee."Date Filter")
                {
                }
                fieldelement(E_GlobalDimension1Filter;Employee."Global Dimension 1 Filter")
                {
                }
                fieldelement(E_GlobalDimension2Filter;Employee."Global Dimension 2 Filter")
                {
                }
                fieldelement(E_CauseAbsenceFilter;Employee."Cause of Absence Filter")
                {
                }
                fieldelement(E_TotalAbsence;Employee."Total Absence (Base)")
                {
                }
                fieldelement(E_Extension;Employee.Extension)
                {
                }
                fieldelement(E_EmployeeNoFilter;Employee."Employee No. Filter")
                {
                }
                fieldelement(E_Pager;Employee.Pager)
                {
                }
                fieldelement(E_FaxNo;Employee."Fax No.")
                {
                }
                fieldelement(E_CompanyEMail;Employee."Company E-Mail")
                {
                }
                fieldelement(E_Title;Employee.Title)
                {
                }
                fieldelement(E_SalespersPurchCode;Employee."Salespers./Purch. Code")
                {
                }
                fieldelement(E_NoSeries;Employee."No. Series")
                {
                }
                fieldelement(E_Categoria;Employee."Categoria old")
                {
                }
                fieldelement(E_Tiempo;Employee."Tiempo old")
                {
                }
                fieldelement(E_PermisoTrabajoMT;Employee.Field51000)
                {
                }
                fieldelement(E_LugarNacimientoMT;Employee.Field51001)
                {
                }
                fieldelement(E_EtniaMT;Employee.Field51002)
                {
                }
                fieldelement(E_IdiomaMT;Employee.Field51003)
                {
                }
                fieldelement(E_NumeroHijosMT;Employee.Field51004)
                {
                }
                fieldelement(E_NivelAcademicoMT;Employee.Field51005)
                {
                }
                fieldelement(E_Profesion;Employee.Field51006)
                {
                }
                fieldelement(E_PuestoSegunMT;Employee.Field51007)
                {
                }
                fieldelement(E_Company;Employee.Company)
                {
                }
                fieldelement(E_SecondLastName;Employee."Second Last Name")
                {
                }
                fieldelement(E_WorkingCenter;Employee."Working Center")
                {
                }
                fieldelement(E_FullName;Employee."Full Name")
                {
                }
                fieldelement(E_DocumentType;Employee."Document Type")
                {
                }
                fieldelement(E_DocumentID;Employee."Document ID")
                {
                }
                fieldelement(E_EmployeeLevel;Employee."Employee Level")
                {
                }
                fieldelement(E_PostingGroup;Employee."Posting Group")
                {
                }
                fieldelement(E_JobTypeCode;Employee."Job Type Code")
                {
                }
                fieldelement(E_AltaContrato;Employee."Alta contrato")
                {
                }
                fieldelement(E_FinContrato;Employee."Fin contrato")
                {
                }
                fieldelement(E_EstadoContrato;Employee."Estado Contrato")
                {
                }
                fieldelement(E_CalcularNomina;Employee."Calcular Nomina")
                {
                }
                fieldelement(E_FechaSalidaEmpresa;Employee."Fecha salida empresa")
                {
                }
                fieldelement(E_TelefonoCasoEmergencia;Employee."Telefono caso emergencia")
                {
                }
                fieldelement(E_Nacionalidad;Employee.Nacionalidad)
                {
                }
                fieldelement(E_IncentivosPuntos;Employee."Incentivos/Puntos")
                {
                }
                fieldelement(E_LugarNacimiento;Employee."Lugar nacimiento")
                {
                }
                fieldelement(E_EstadoCivil;Employee."Estado civil")
                {
                }
                fieldelement(E_Banco;Employee."Disponible 1")
                {
                }
                fieldelement(E_TipoCuenta;Employee."Disponible 2")
                {
                }
                fieldelement(E_Cuenta;Employee.Cuenta)
                {
                }
                fieldelement(E_FormaCobro;Employee."Forma de Cobro")
                {
                }
                fieldelement(E_TotalIngresos;Employee."Total ingresos")
                {
                }
                fieldelement(E_TotalDeducciones;Employee."Total deducciones")
                {
                }
                fieldelement(E_MesNacimiento;Employee."Mes Nacimiento")
                {
                }
                fieldelement(E_TotalISR;Employee."Total ISR")
                {
                }
                fieldelement(E_TipoEmpleado;Employee."Tipo Empleado")
                {
                }
                fieldelement(E_Salario;Employee.Salario)
                {
                }
                fieldelement(E_AcumuladoSalario;Employee."Acumulado Salario")
                {
                }
                fieldelement(E_CodigoCliente;Employee."Código Cliente")
                {
                }
                fieldelement(E_ExcluidoCotizacionTSS;Employee."Excluído Cotización TSS")
                {
                }
                fieldelement(E_ExcluidoCotizacionISR;Employee."Excluído Cotización ISR")
                {
                }
                fieldelement(E_NoSeguridadSocial;Employee."Dia nacimiento")
                {
                }
                fieldelement(E_CodARS;Employee."Cod. ARS")
                {
                }
                fieldelement(E_CodAFP;Employee."Cod. AFP")
                {
                }
                fieldelement(E_Departamento;Employee.Departamento)
                {
                }
                fieldelement(E_SubDepartamento;Employee."Sub-Departamento")
                {
                }
                fieldelement(E_AgenteRetencionISR;Employee."Agente de Retencion ISR")
                {
                }
                fieldelement(E_RNCAgenteRetencionISR;Employee."RNC Agente de Retencion ISR")
                {
                }
                fieldelement(E_CodSupervisor;Employee."Cod. Supervisor")
                {
                }
                fieldelement(E_NombreSupervisor;Employee."Nombre Supervisor")
                {
                }
                fieldelement(E_Shift;Employee.Shift)
                {
                }
                fieldelement(E_SalarioEmpresasExternas;Employee."Salario Empresas Externas")
                {
                }
                fieldelement(E_AporteVoluntarioIncomeTax;Employee."Aporte Voluntario Income Tax")
                {
                }
                fieldelement(E_LanguageCode;Employee."Language Code")
                {
                }
            }
            tableelement(Table34002111;Table34002111)
            {
                XmlName = 'ConceptosSalariales';
                fieldelement(CS_ShortcutDimension;"Conceptos salariales"."Shortcut Dimension")
                {
                }
                fieldelement(CS_Codigo;"Conceptos salariales"."Código")
                {
                }
                fieldelement(CS_Descripcion;"Conceptos salariales"."Descripción")
                {
                }
                fieldelement(CS_TipoConcepto;"Conceptos salariales"."Tipo concepto")
                {
                }
                fieldelement(CS_SalarioBase;"Conceptos salariales"."Salario Base")
                {
                }
                fieldelement(CS_SujetoCotizacion;"Conceptos salariales"."Sujeto Cotización")
                {
                }
                fieldelement(CS_TextoInformativo;"Conceptos salariales"."Texto Informativo")
                {
                }
                fieldelement(CS_FilaImpresionNomina;"Conceptos salariales"."Fila Impresión Nómina")
                {
                }
                fieldelement(CS_ColImpresionNomina;"Conceptos salariales"."Col. Impresión Nómina")
                {
                }
                fieldelement(CS_ImprimirDescripcion;"Conceptos salariales"."Imprimir descripción")
                {
                }
                fieldelement(CS_Provisionar;"Conceptos salariales".Provisionar)
                {
                }
                fieldelement(CS_NoCuentaCuotaObrera;"Conceptos salariales"."No. Cuenta Cuota Obrera")
                {
                }
                fieldelement(CS_ContabilizacionResumida;"Conceptos salariales"."Contabilización Resumida")
                {
                }
                fieldelement(CS_ContabilizacionDimension;"Conceptos salariales"."Contabilización x Dimensión")
                {
                }
                fieldelement(CS_SumarRestarCuentaSalarios;"Conceptos salariales"."Sumar/Restar a cuenta salarios")
                {
                }
                fieldelement(CS_CotizaAFP;"Conceptos salariales"."Cotiza AFP")
                {
                }
                fieldelement(CS_CotizaSRL;"Conceptos salariales"."Cotiza SRL")
                {
                }
                fieldelement(CS_CotizaINFOTEP;"Conceptos salariales"."Cotiza INFOTEP")
                {
                }
                fieldelement(CS_CotizaISR;"Conceptos salariales"."Cotiza ISR")
                {
                }
                fieldelement(CS_CotizaSFS;"Conceptos salariales"."Cotiza SFS")
                {
                }
                fieldelement(CS_TipoCuentaCuotaObrera;"Conceptos salariales"."Tipo Cuenta Cuota Obrera")
                {
                }
                fieldelement(CS_TipoCuentaCuotaPatronal;"Conceptos salariales"."Tipo Cuenta Cuota Patronal")
                {
                }
                fieldelement(CS_NoCuentaCuotaPatronal;"Conceptos salariales"."No. Cuenta Cuota Patronal")
                {
                }
                fieldelement(CS_TipoCuentaContrapartidaCO;"Conceptos salariales"."Tipo Cuenta Contrapartida CO")
                {
                }
                fieldelement(CS_NoCuentaContrapartidaCO;"Conceptos salariales"."No. Cuenta Contrapartida CO")
                {
                }
                fieldelement(CS_TipoCuentaContrapartidaCP;"Conceptos salariales"."Tipo Cuenta Contrapartida CP")
                {
                }
                fieldelement(CS_NoCuentaContrapartidaCP;"Conceptos salariales"."No. Cuenta Contrapartida CP")
                {
                }
                fieldelement(CS_ValidarContrapartidaCO;"Conceptos salariales"."Validar Contrapartida CO")
                {
                }
                fieldelement(CS_ValidarContrapartidaCP;"Conceptos salariales"."Validar Contrapartida CP")
                {
                }
                fieldelement(CS_AplicaRegalia;"Conceptos salariales"."Aplica para Regalia")
                {
                }
                fieldelement(CS_CotizaSUTA;"Conceptos salariales"."Cotiza SUTA")
                {
                }
                fieldelement(CS_CotizaFUTA;"Conceptos salariales"."Cotiza FUTA")
                {
                }
                fieldelement(CS_CotizaMEDICARE;"Conceptos salariales"."Cotiza MEDICARE")
                {
                }
                fieldelement(CS_CotizaFICA;"Conceptos salariales"."Cotiza FICA")
                {
                }
                fieldelement(CS_CotizaSINOT;"Conceptos salariales"."Cotiza SINOT")
                {
                }
                fieldelement(CS_CotizaCHOFERIL;"Conceptos salariales"."Cotiza CHOFERIL")
                {
                }
                fieldelement(CS_CotizaINCOMETAX;"Conceptos salariales"."Cotiza INCOMETAX")
                {
                }
            }
            tableelement(Table34002115;Table34002115)
            {
                XmlName = 'PerfilSalarial';
                fieldelement(PS_EmpresaCotizacion;"Perfil Salarial"."Empresa cotización")
                {
                }
                fieldelement(PS_NoEmpleado;"Perfil Salarial"."No. empleado")
                {
                }
                fieldelement(PS_PerfilSalarial;"Perfil Salarial"."Perfil salarial")
                {
                }
                fieldelement(PS_NoLinea;"Perfil Salarial"."No. Linea")
                {
                }
                fieldelement(PS_Cargo;"Perfil Salarial".Cargo)
                {
                }
                fieldelement(PS_ConceptoSalarial;"Perfil Salarial"."Concepto salarial")
                {
                }
                fieldelement(PS_Descripcion;"Perfil Salarial"."Descripción")
                {
                }
                fieldelement(PS_Cantidad;"Perfil Salarial".Cantidad)
                {
                }
                fieldelement(PS_Importe;"Perfil Salarial".Importe)
                {
                }
                fieldelement(PS_TipoConcepto;"Perfil Salarial"."Tipo concepto")
                {
                }
                fieldelement(PS_SujetoCotizacion;"Perfil Salarial"."Sujeto Cotización")
                {
                }
                fieldelement(PS_CotizaISR;"Perfil Salarial"."Cotiza ISR")
                {
                }
                fieldelement(PS_TextoInformativo;"Perfil Salarial"."Texto Informativo")
                {
                }
                fieldelement(PS_Prorratear;"Perfil Salarial".Prorratear)
                {
                }
                fieldelement(PS_FormulaCalculo;"Perfil Salarial"."Fórmula cálculo")
                {
                }
                fieldelement("PS_PeriodoGenerac.";"Perfil Salarial"."Período generac.")
                {
                }
                fieldelement(PS_Imprimir;"Perfil Salarial".Imprimir)
                {
                }
                fieldelement("PS_InicioPeríodo";"Perfil Salarial"."Inicio Período")
                {
                }
                fieldelement("PS_FinPeríodo";"Perfil Salarial"."Fin Período")
                {
                }
                fieldelement(PS_Mes;"Perfil Salarial".Mes)
                {
                }
                fieldelement(PS_MesInicio;"Perfil Salarial"."Mes Inicio")
                {
                }
                fieldelement(PS_MesFin;"Perfil Salarial"."Mes Fin")
                {
                }
                fieldelement(PS_DeducirDias;"Perfil Salarial"."Deducir dias")
                {
                }
                fieldelement(PS_PrimeraQuincena;"Perfil Salarial"."1ra Quincena")
                {
                }
                fieldelement(PS_SegundaQuincena;"Perfil Salarial"."2da Quincena")
                {
                }
                fieldelement(PS_Status;"Perfil Salarial".Status)
                {
                }
                fieldelement("PS_TipoNómina";"Perfil Salarial"."Tipo Nómina")
                {
                }
                fieldelement(PS_CotizaAFP;"Perfil Salarial"."Cotiza AFP")
                {
                }
                fieldelement(PS_CotizaSFS;"Perfil Salarial"."Cotiza SFS")
                {
                }
                fieldelement(PS_SalarioBase;"Perfil Salarial"."Salario Base")
                {
                }
                fieldelement(PS_CurrencyCode;"Perfil Salarial"."Currency Code")
                {
                }
                fieldelement(PS_ISRPagoEmpleado;"Perfil Salarial"."% ISR Pago Empleado")
                {
                }
                fieldelement(PS_CotizaINFOTEP;"Perfil Salarial"."Cotiza INFOTEP")
                {
                }
                fieldelement(PS_RetencionIngresoSalario;"Perfil Salarial"."% Retencion Ingreso Salario")
                {
                }
                fieldelement(PS_ImporteAcumulado;"Perfil Salarial"."Importe Acumulado")
                {
                }
                fieldelement(PS_FiltroFecha;"Perfil Salarial"."Filtro Fecha")
                {
                }
                fieldelement(PS_CotizaSRL;"Perfil Salarial"."Cotiza SRL")
                {
                }
                fieldelement(PS_AplicaRegalia;"Perfil Salarial"."Aplica para Regalia")
                {
                }
                fieldelement(PS_CotizaSUTA;"Perfil Salarial".Field39)
                {
                }
                fieldelement(PS_CotizaFUTA;"Perfil Salarial"."Job No.")
                {
                }
                fieldelement(PS_CotizaMEDICARE;"Perfil Salarial".Field41)
                {
                }
                fieldelement(PS_CotizaFICA;"Perfil Salarial"."Cotiza FICA")
                {
                }
                fieldelement(PS_CotizaSINOT;"Perfil Salarial".Field43)
                {
                }
                fieldelement(PS_CotizaCHOFERIL;"Perfil Salarial".Field44)
                {
                }
                fieldelement(PS_CotizaINCOMETAX;"Perfil Salarial".Field45)
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}

