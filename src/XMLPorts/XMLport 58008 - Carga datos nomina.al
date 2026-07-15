xmlport 58008 "Carga datos nomina"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(CargaDatosNomina)
        {
            tableelement(Employee; 5200)
            {
                XmlName = 'Empleado';
                fieldelement(E_No; Employee."No.")
                {
                }
                fieldelement(E_FirstName; Employee."First Name")
                {
                }
                fieldelement(E_MiddleName; Employee."Middle Name")
                {
                }
                fieldelement(E_LastName; Employee."Last Name")
                {
                }
                fieldelement(E_Initials; Employee.Initials)
                {
                }
                fieldelement(E_JobTitle; Employee."Job Title")
                {
                }
                fieldelement(E_SearchName; Employee."Search Name")
                {
                }
                fieldelement(E_Address; Employee.Address)
                {
                }
                fieldelement(E_Address2; Employee."Address 2")
                {
                }
                fieldelement(E_City; Employee.City)
                {
                }
                fieldelement(E_PostCode; Employee."Post Code")
                {
                }
                fieldelement(E_County; Employee.County)
                {
                }
                fieldelement(E_PhoneNo; Employee."Phone No.")
                {
                }
                fieldelement(E_MobilePhoneNo; Employee."Mobile Phone No.")
                {
                }
                fieldelement(E_EMail; Employee."E-Mail")
                {
                }
                fieldelement(E_AltAddressCode; Employee."Alt. Address Code")
                {
                }
                fieldelement(E_AltAddressStartDate; Employee."Alt. Address Start Date")
                {
                }
                fieldelement(E_AltAddressEndDate; Employee."Alt. Address End Date")
                {
                }
                fieldelement(E_BirthDate; Employee."Birth Date")
                {
                }
                fieldelement(E_SocialSecurityNo; Employee."Social Security No.")
                {
                }
                fieldelement(E_UnionCode; Employee."Union Code")
                {
                }
                fieldelement(E_UnionMembershipNo; Employee."Union Membership No.")
                {
                }
                fieldelement(E_Gender; Employee.Gender)
                {
                }
                fieldelement(E_CountryRegionCode; Employee."Country/Region Code")
                {
                }
                fieldelement(E_ManagerNo; Employee."Manager No.")
                {
                }
                fieldelement(E_EmplymtContractCode; Employee."Emplymt. Contract Code")
                {
                }
                fieldelement(E_StatisticsGroupCode; Employee."Statistics Group Code")
                {
                }
                fieldelement(E_EmploymentDate; Employee."Employment Date")
                {
                }
                fieldelement(E_Status; Employee.Status)
                {
                }
                fieldelement(E_InactiveDate; Employee."Inactive Date")
                {
                }
                fieldelement(E_CauseInactivityCode; Employee."Cause of Inactivity Code")
                {
                }
                fieldelement(E_TerminationDate; Employee."Termination Date")
                {
                }
                fieldelement(E_GroundsTermCode; Employee."Grounds for Term. Code")
                {
                }
                fieldelement(E_GlobalDimension1Code; Employee."Global Dimension 1 Code")
                {
                }
                fieldelement(E_GlobalDimension2Code; Employee."Global Dimension 2 Code")
                {
                }
                fieldelement(E_ResourceNo; Employee."Resource No.")
                {
                }
                fieldelement(E_Comment; Employee.Comment)
                {
                }
                fieldelement(E_LastDateModified; Employee."Last Date Modified")
                {
                }
                fieldelement(E_DateFilter; Employee."Date Filter")
                {
                }
                fieldelement(E_GlobalDimension1Filter; Employee."Global Dimension 1 Filter")
                {
                }
                fieldelement(E_GlobalDimension2Filter; Employee."Global Dimension 2 Filter")
                {
                }
                fieldelement(E_CauseAbsenceFilter; Employee."Cause of Absence Filter")
                {
                }
                fieldelement(E_TotalAbsenceBase; Employee."Total Absence (Base)")
                {
                }
                fieldelement(E_Extension; Employee.Extension)
                {
                }
                fieldelement(E_EmployeeNoFilter; Employee."Employee No. Filter")
                {
                }
                fieldelement(E_Pager; Employee.Pager)
                {
                }
                fieldelement(E_FaxNo; Employee."Fax No.")
                {
                }
                fieldelement(E_CompanyEMail; Employee."Company E-Mail")
                {
                }
                fieldelement(E_Title; Employee.Title)
                {
                }
                fieldelement(E_SalespersPurchCode; Employee."Salespers./Purch. Code")
                {
                }
                fieldelement(E_NoSeries; Employee."No. Series")
                {
                }
                /* TODO: Ver
                fieldelement(E_Categoria; Employee."Categoria old")
                {
                }
                fieldelement(E_Tiempo; Employee."Tiempo old")
                {
                }
                fieldelement(E_PermisoTrabajoMT; Employee.Field51000)
                {
                }
                fieldelement(E_LugarNacimientoMT; Employee.Field51001)
                {
                }
                fieldelement(E_EtniaMT; Employee.Field51002)
                {
                }
                fieldelement(E_IdiomaMT; Employee.Field51003)
                {
                }
                fieldelement(E_NumeroHijosMT; Employee.Field51004)
                {
                }
                fieldelement(E_Profesion; Employee.Field51006)
                {
                }
                fieldelement(E_PuestoSegunMT; Employee.Field51007)
                {
                }
                fieldelement(E_Company; Employee.Company)
                {
                }
                fieldelement(E_SecondLastName; Employee."Second Last Name")
                {
                }
                fieldelement(E_WorkingCenter; Employee."Working Center")
                {
                }
                fieldelement(E_FullName; Employee."Full Name")
                {
                }
                fieldelement(E_DocumentType; Employee."Document Type")
                {
                }
                fieldelement(E_DocumentID; Employee."Document ID")
                {
                }
                fieldelement(E_EmployeeLevel; Employee."Employee Level")
                {
                }
                fieldelement(E_PostingGroup; Employee."Posting Group")
                {
                }
                fieldelement(E_JobTypeCode; Employee."Job Type Code")
                {
                }
                fieldelement(E_AltaContrato; Employee."Alta contrato")
                {
                }
                fieldelement(E_FinContrato; Employee."Fin contrato")
                {
                }
                fieldelement(E_EstadoContrato; Employee."Estado Contrato")
                {
                }
                fieldelement(E_CalcularNomina; Employee."Calcular Nomina")
                {
                }
                fieldelement(E_FechaSalidaEmpresa; Employee."Fecha salida empresa")
                {
                }
                fieldelement(E_TelefonoCsoEmergencia; Employee."Telefono caso emergencia")
                {
                }
                fieldelement(E_Nacionalidad; Employee.Nacionalidad)
                {
                }
                fieldelement(E_IncentivosPuntos; Employee."Incentivos/Puntos")
                {
                }
                fieldelement(E_LugarNacimiento; Employee."Lugar nacimiento")
                {
                }
                fieldelement(E_EstadoCivil; Employee."Estado civil")
                {
                }
                fieldelement(E_Banco; Employee."Disponible 1")
                {
                }
                fieldelement(E_TipoCuenta; Employee."Disponible 2")
                {
                }
                fieldelement(E_Cuenta; Employee.Cuenta)
                {
                }
                fieldelement(E_FormaCobro; Employee."Forma de Cobro")
                {
                }
                fieldelement(E_TotalIngresos; Employee."Total ingresos")
                {
                }
                fieldelement(E_TotalDeducciones; Employee."Total deducciones")
                {
                }
                fieldelement(E_MesNacimiento; Employee."Mes Nacimiento")
                {
                }
                fieldelement(E_TotalISR; Employee."Total ISR")
                {
                }
                fieldelement(E_TipoEmpleado; Employee."Tipo Empleado")
                {
                }
                fieldelement(E_Salario; Employee.Salario)
                {
                }
                fieldelement(E_AcumuladoSalario; Employee."Acumulado Salario")
                {
                }
                fieldelement(E_CodigoCliente; Employee."Codigo Cliente")
                {
                }
                fieldelement(E_ExcluidoCotizacionTSS; Employee."Excluído Cotizacion TSS")
                {
                }
                fieldelement(E_ExcluidoCotizacionISR; Employee."Excluído Cotizacion ISR")
                {
                }
                fieldelement(E_NoSeguridadSocial; Employee."Dia nacimiento")
                {
                }
                fieldelement(E_CodARS; Employee."Cod. ARS")
                {
                }
                fieldelement(E_CodAFP; Employee."Cod. AFP")
                {
                }
                fieldelement(E_Departamento; Employee.Departamento)
                {
                }
                fieldelement(E_SubDepartamento; Employee."Sub-Departamento")
                {
                }
                fieldelement(E_AgenteRetencionISR; Employee."Agente de Retencion ISR")
                {
                }
                fieldelement(E_RNCAgenteRetencionISR; Employee."RNC Agente de Retencion ISR")
                {
                }
                fieldelement(E_CodSupervisor; Employee."Cod. Supervisor")
                {
                }
                fieldelement(E_NombreSupervisor; Employee."Nombre Supervisor")
                {
                }
                fieldelement(E_Shift; Employee.Shift)
                {
                }
                fieldelement(E_SalarioEmpresasExternas; Employee."Salario Empresas Externas")
                {
                }
                fieldelement(E_AporteVoluntarioIncomeTax; Employee."Aporte Voluntario Income Tax")
                {
                }
                fieldelement(E_LanguageCode; Employee."Language Code")
                {
                }
            }
            tableelement(Table34002100; 34002100)
            {
                XmlName = 'EmpresasCotizacion';
                fieldelement(EC_EmpresaCotizacion; "Empresas Cotizacion"."Empresa cotizacion")
                {
                }
                fieldelement(EC_NombreEmpresaCotizacion; "Empresas Cotizacion"."Nombre Empresa cotizacion")
                {
                }
                fieldelement(EC_Direccion; "Empresas Cotizacion"."Direccion")
                {
                }
                fieldelement(EC_Numero; "Empresas Cotizacion"."Número")
                {
                }
                fieldelement(EC_CodigoPostal; "Empresas Cotizacion"."Codigo Postal")
                {
                }
                fieldelement(EC_Municipio; "Empresas Cotizacion".Municipio)
                {
                }
                fieldelement(EC_Provincia; "Empresas Cotizacion".Provincia)
                {
                }
                fieldelement(EC_Telefono; "Empresas Cotizacion"."Teléfono")
                {
                }
                fieldelement(EC_DomicilioFiscal; "Empresas Cotizacion"."Domicilio fiscal")
                {
                }
                fieldelement(EC_CodPais; "Empresas Cotizacion"."Cod. país")
                {
                }
                fieldelement(EC_TipoDocumento; "Empresas Cotizacion"."Tipo de documento")
                {
                }
                fieldelement(EC_RNCCED; "Empresas Cotizacion"."RNC/CED")
                {
                }
                fieldelement(EC_GrupoContable; "Empresas Cotizacion"."Grupo contable")
                {
                }
                fieldelement(EC_EsquemaPercepcion; "Empresas Cotizacion"."Esquema percepcion")
                {
                }
                fieldelement(EC_Banco; "Empresas Cotizacion".Banco)
                {
                }
                fieldelement(EC_Cuenta; "Empresas Cotizacion".Cuenta)
                {
                }
                fieldelement(EC_FormaPago; "Empresas Cotizacion"."Forma de Pago")
                {
                }
                fieldelement(EC_IDVolantePago; "Empresas Cotizacion"."ID  Volante Pago")
                {
                }
                fieldelement(EC_Comentario; "Empresas Cotizacion".Comentario)
                {
                }
                fieldelement(EC_GlobalDimension1Code; "Empresas Cotizacion"."Global Dimension 1 Code")
                {
                }
                fieldelement(EC_GlobalDimension2Code; "Empresas Cotizacion"."Global Dimension 2 Code")
                {
                }
                fieldelement(EC_UltNoContabilizacion; "Empresas Cotizacion"."Ult. No. Contabilizacion")
                {
                }
                fieldelement(EC_Fax; "Empresas Cotizacion".Fax)
                {
                }
                fieldelement(EC_EMail; "Empresas Cotizacion"."E-Mail")
                {
                }
                fieldelement(EC_IDRNL; "Empresas Cotizacion"."ID RNL")
                {
                }
                fieldelement(EC_IDTSS; "Empresas Cotizacion"."ID TSS")
                {
                }
                fieldelement(EC_TipoEmpresaTrabajo; "Empresas Cotizacion"."Tipo Empresa de Trabajo")
                {
                }
                fieldelement(EC_TipoPagoNomina; "Empresas Cotizacion"."Tipo Pago Nomina")
                {
                }
                fieldelement(EC_TasaRiesgo; "Empresas Cotizacion"."Tasa de Riesgo (%)")
                {
                }
                fieldelement(EC_SalarioMinimoTSS; "Empresas Cotizacion"."Salario Mínimo TSS")
                {
                }
                fieldelement(EC_EmployerIdentificationNumber; "Empresas Cotizacion"."Employer Identification Number")
                {
                }
                fieldelement(EC_IdentificadorEmpresa; "Empresas Cotizacion"."Identificador Empresa")
                {
                }
                fieldelement(EC_PathArchivoNomina; "Empresas Cotizacion"."Path archivo Nomina")
                {
                }
            }
            tableelement(Table34002101; 34002101)
            {
                XmlName = 'CentrosTabajo';
                fieldelement(CT_EmpresaCotizacion; "Centros de Trabajo"."Empresa cotizacion")
                {
                }
                fieldelement(CT_CentroTrabajo; "Centros de Trabajo"."Centro de trabajo")
                {
                }
                fieldelement(CT_Direccion; "Centros de Trabajo"."Direccion")
                {
                }
                fieldelement(CT_CP; "Centros de Trabajo"."C.P.")
                {
                }
                fieldelement(CT_Poblacion; "Centros de Trabajo"."Poblacion")
                {
                }
                fieldelement(CT_Provincia; "Centros de Trabajo".Provincia)
                {
                }
            }
            tableelement(Table34002103; 34002103)
            {
                XmlName = 'ConfiguracionNominas';
                fieldelement(CN_Codigo; "Configuracion nominas".Codigo)
                {
                }
                fieldelement(CN_NoSerieNominas; "Configuracion nominas"."No. serie nominas")
                {
                }
                fieldelement(CN_NoSserieCxC; "Configuracion nominas"."No. serie CxC")
                {
                }
                fieldelement(CN_NoSerieRegCxC; "Configuracion nominas"."No. serie reg. CxC")
                {
                }
                fieldelement(CN_JournalTemplateName; "Configuracion nominas"."Journal Template Name")
                {
                }
                fieldelement(CN_JournalBatchName; "Configuracion nominas"."Journal Batch Name")
                {
                }
                fieldelement(CN_DimensionConceptosSalariales; "Configuracion nominas"."Dimension Conceptos Salariales")
                {
                }
                fieldelement(CN_IncidenciasAusenciaPropinas; "Configuracion nominas"."Incidencias Ausencia Propinas")
                {
                }
                fieldelement(CN_IncidenciasDtoNomina; "Configuracion nominas"."Incidencias Dto. Nomina")
                {
                }
                fieldelement(CN_ConceptoSalarialIncentivos; "Configuracion nominas"."Concepto Incentivos")
                {
                }
                fieldelement(CN_ImpuestosManuales; "Configuracion nominas"."Impuestos manuales")
                {
                }
                fieldelement(CN_ConceptoSalarialCxCEmpl; "Configuracion nominas"."Concepto CxC Empl.")
                {
                }
                fieldelement(CN_Incidencia; "Configuracion nominas"."Concepto ISR Cobrado en exceso")
                {
                }
                fieldelement(CN_ConceptoSalBase; "Configuracion nominas"."Concepto Sal. Base")
                {
                }
                fieldelement(CN_ConceptoISR; "Configuracion nominas"."Concepto ISR")
                {
                }
                fieldelement(CN_ConceptoARS; "Configuracion nominas"."Concepto Retroactivo")
                {
                }
                fieldelement(CN_ConceptoInasistencia; "Configuracion nominas"."Concepto Inasistencia")
                {
                }
                fieldelement(CN_ConceptoAFP; "Configuracion nominas"."Concepto AFP")
                {
                }
                fieldelement(CN_ConceptoSFS; "Configuracion nominas"."Concepto SFS")
                {
                }
                fieldelement(CN_ConceptoRegalia; "Configuracion nominas"."Concepto Regalia")
                {
                }
                fieldelement(CN_ConceptoBonificacion; "Configuracion nominas"."Concepto Bonificacion")
                {
                }
                fieldelement(CN_ConceptoVacaciones; "Configuracion nominas"."Concepto Vacaciones")
                {
                }
                fieldelement(CN_ConceptoHorasExt100; "Configuracion nominas"."Concepto Horas Ext. 100%")
                {
                }
                fieldelement(CN_ConceptoHorasExt35; "Configuracion nominas"."Concepto Horas Ext. 35%")
                {
                }
                fieldelement(CN_ConceptoHorasExt15; "Configuracion nominas"."Concepto Sal. hora")
                {
                }
                fieldelement(CN_ConceptoSRL; "Configuracion nominas"."Concepto SRL")
                {
                }
                fieldelement(CN_ConceptoINFOTEP; "Configuracion nominas"."Concepto INFOTEP")
                {
                }
                fieldelement(CN_ConceptoOtrosIngresos3; "Configuracion nominas"."Concepto Dias feriados")
                {
                }
                fieldelement(CN_ConceptoOtrosIngresos4; "Configuracion nominas"."Concepto Horas nocturnas")
                {
                }
                fieldelement(CN_ConceptoOtrosIngresos5; "Configuracion nominas"."Job Journal Template Name")
                {
                }
                fieldelement(CN_ConceptoOtrasDeducciones1; "Configuracion nominas"."Job Journal Batch Name")
                {
                }
                fieldelement(CN_ConceptoOtrasDeducciones2; "Configuracion nominas"."Concepto Dieta")
                {
                }
                fieldelement(CN_ConceptoOtrasDeducciones3; "Configuracion nominas"."Concepto Transporte")
                {
                }
                fieldelement(CN_SalarioMinimo; "Configuracion nominas"."Salario Minimo")
                {
                }
                fieldelement(CN_SecuenciaArchivoBatch; "Configuracion nominas"."Secuencia de archivo Batch")
                {
                }
                fieldelement(CN_FechaSecuencia; "Configuracion nominas"."Fecha secuencia")
                {
                }
                fieldelement(CN_MetodoCalculoAusencias; "Configuracion nominas"."Método cálculo ausencias")
                {
                }
                fieldelement(CN_NoSerieEmpleados; "Configuracion nominas"."Concepto devolucion ISR")
                {
                }
                fieldelement(CN_TasaCambioCalculoDivisa; "Configuracion nominas"."Tasa Cambio Calculo Divisa")
                {
                }
                fieldelement(CN_MetodoCalculoIngresos; "Configuracion nominas"."Metodo calculo Ingresos")
                {
                }
                fieldelement("CN_MetodoCáaculoBajas"; "Configuracion nominas"."Metodo calculo Salidas")
                {
                }
                fieldelement(CN_CodBcoNominasPagoTransf; "Configuracion nominas"."Cod. Cta. Nominas Pago Transf.")
                {
                }
                fieldelement(CN_CodCtaNominasOtrosPagos; "Configuracion nominas"."Cta. Nominas Otros Pagos")
                {
                }
                fieldelement(CN_WebPageTSS; "Configuracion nominas"."Web Page TSS")
                {
                }
                fieldelement(CN_WebPageDGII; "Configuracion nominas"."Web Page DGII")
                {
                }
                fieldelement(CN_PathArchivosElectronicos; "Configuracion nominas"."Path Archivos Electronicos")
                {
                }
                fieldelement(CN_ImporteAnualIHSSBaseISR; "Configuracion nominas"."Importe Anual IHSS Base ISR")
                {
                }
                fieldelement(CN_Disponible; "Configuracion nominas"."% dif. Ingresos y descuentos")
                {
                }
                fieldelement(CN_Disponible2; "Configuracion nominas"."Tipo cuenta")
                {
                }
                fieldelement(CN_Disponible3; "Configuracion nominas"."Vacaciones colectivas")
                {
                }
                fieldelement(CN_TextoEemailRecibos; "Configuracion nominas"."Texto email recibos")
                {
                }
                fieldelement(CN_TiempoEsperaEnvioEemail; "Configuracion nominas"."Tiempo espera Envio email")
                {
                }
                fieldelement(CN_JournalTemplateNameCK; "Configuracion nominas"."Journal Template Name CK")
                {
                }
                fieldelement(CN_JournalBatchNameCK; "Configuracion nominas"."Journal Batch Name CK")
                {
                }
                fieldelement(CN_TipoCtaOtrosPagos; "Configuracion nominas"."Tipo Cta. Otros Pagos")
                {
                }
                fieldelement(CN_CodeunitCalculoNomina; "Configuracion nominas"."Codeunit calculo nomina")
                {
                }
                fieldelement(CN_NominaPais; "Configuracion nominas"."Nomina de Pais")
                {
                }
                fieldelement(CN_DimensionArea; "Configuracion nominas"."No. serie Sol. Prest. Coop.")
                {
                }
                fieldelement(CN_DimensionActividad; "Configuracion nominas"."No. serie Hist. Prest. Coop.")
                {
                }
                fieldelement(CN_DimensionSubActividad; "Configuracion nominas"."Concepto Cuota cooperativa")
                {
                }
                fieldelement(CN_DimensionOperacion; "Configuracion nominas"."Mod. cooperativa activo")
                {
                }
            }
            tableelement(Table34002109; 34002109)
            {
                XmlName = 'Contratos';
                fieldelement(C_EmpresaCotizacion; Contratos."Empresa cotizacion")
                {
                }
                fieldelement(C_NoEempleado; Contratos."No. empleado")
                {
                }
                fieldelement(C_NoOOrden; Contratos."No. Orden")
                {
                }
                fieldelement(C_CodContrato; Contratos."Cod. contrato")
                {
                }
                fieldelement(C_Disponible; Contratos.Disponible)
                {
                }
                fieldelement(C_Descripcion; Contratos."Descripcion")
                {
                }
                fieldelement(C_FechaInicio; Contratos."Fecha inicio")
                {
                }
                fieldelement(C_Duracion; Contratos.Duracion)
                {
                }
                fieldelement(C_FechaFinalizacion; Contratos."Fecha finalizacion")
                {
                }
                fieldelement(C_Cargo; Contratos.Cargo)
                {
                }
                fieldelement(C_CentroTrabajo; Contratos."Centro trabajo")
                {
                }
                fieldelement(C_MotivoBaja; Contratos."Motivo baja")
                {
                }
                fieldelement(C_Finalizado; Contratos.Finalizado)
                {
                }
                fieldelement(C_DiasPreaviso; Contratos."Días preaviso")
                {
                }
                fieldelement(C_PeriodoPrueba; Contratos."Período prueba")
                {
                }
                fieldelement(C_Jornada; Contratos.Jornada)
                {
                }
                fieldelement(C_TipoPagoNomina; Contratos."Frecuencia de pago")
                {
                }
                fieldelement(C_DiasSemana; Contratos."Días semana")
                {
                }
                fieldelement(C_HorasDia; Contratos."Horas dia")
                {
                }
                fieldelement(C_HorasSemana; Contratos."Horas semana")
                {
                }
                fieldelement(C_CausaBaja; Contratos."Causa de la Baja")
                {
                }
                fieldelement(C_Indefinido; Contratos.Indefinido)
                {
                }
                fieldelement(C_Activo; Contratos.Activo)
                {
                }
            }
            tableelement(Table34002110; 34002110)
            {
                XmlName = 'PuestosLaborales';
                fieldelement(PL_Codigo; "Puestos laborales"."Codigo")
                {
                }
                fieldelement(PL_Descripcion; "Puestos laborales"."Descripcion")
                {
                }
                fieldelement(PL_NivelSalarialMinimo; "Puestos laborales"."Cod. nivel")
                {
                }
                fieldelement(PL_CodSupervisor; "Puestos laborales"."Cod. Supervisor")
                {
                }
                fieldelement(PL_NombreCompleto; "Puestos laborales"."Nombre Completo")
                {
                }
                fieldelement(PL_IncluyeDiasFeriados; "Puestos laborales"."Incluye Dias Feriados")
                {
                }
                fieldelement(PL_Exento; "Puestos laborales".Exento)
                {
                }
                fieldelement(PL_TotalEmpleados; "Puestos laborales"."Total Empleados")
                {
                }
            }
            tableelement(Table34002111; 34002111)
            {
                XmlName = 'ConceptosSalariales';
                fieldelement(CS_ShortcutDimension; "Conceptos salariales"."Shortcut Dimension")
                {
                }
                fieldelement(CS_Codigo; "Conceptos salariales"."Codigo")
                {
                }
                fieldelement(CS_Descripcion; "Conceptos salariales"."Descripcion")
                {
                }
                fieldelement(CS_TipoConcepto; "Conceptos salariales"."Tipo concepto")
                {
                }
                fieldelement(CS_SalarioBase; "Conceptos salariales"."Salario Base")
                {
                }
                fieldelement("CS_SujetoCotizacion"; "Conceptos salariales"."Sujeto Cotizacion")
                {
                }
                fieldelement(CS_TextoInformativo; "Conceptos salariales"."Texto Informativo")
                {
                }
                fieldelement("CS_FilaImpresionNomina"; "Conceptos salariales"."Fila Impresion Nomina")
                {
                }
                fieldelement("CS_ColImpresionNomina"; "Conceptos salariales"."Col. Impresion Nomina")
                {
                }
                fieldelement("CS_ImprimirDescripcion"; "Conceptos salariales"."Imprimir Descripcion")
                {
                }
                fieldelement(CS_Provisionar; "Conceptos salariales".Provisionar)
                {
                }
                fieldelement(CS_NoCuentaCuotaObrera; "Conceptos salariales"."No. Cuenta Cuota Obrera")
                {
                }
                fieldelement("CS_ContabilizacionResumida"; "Conceptos salariales"."Contabilizacion Resumida")
                {
                }
                fieldelement("CS_ContabilizacionDimension"; "Conceptos salariales"."Contabilizacion x Dimension")
                {
                }
                fieldelement(CS_SumarRestarCuentaSalarios; "Conceptos salariales"."Sumar/Restar a cuenta salarios")
                {
                }
                fieldelement(CS_CotizaAFP; "Conceptos salariales"."Cotiza AFP")
                {
                }
                fieldelement(CS_CotizaSRL; "Conceptos salariales"."Cotiza SRL")
                {
                }
                fieldelement(CS_CotizaINFOTEP; "Conceptos salariales"."Cotiza INFOTEP")
                {
                }
                fieldelement(CS_CotizaISR; "Conceptos salariales"."Cotiza ISR")
                {
                }
                fieldelement(CS_CotizaSFS; "Conceptos salariales"."Cotiza SFS")
                {
                }
                fieldelement(CS_TipoCuentaCuotaObrera; "Conceptos salariales"."Tipo Cuenta Cuota Obrera")
                {
                }
                fieldelement(CS_TipoCuentaCuotaPatronal; "Conceptos salariales"."Tipo Cuenta Cuota Patronal")
                {
                }
                fieldelement(CS_NoCuentaCuotaPatronal; "Conceptos salariales"."No. Cuenta Cuota Patronal")
                {
                }
                fieldelement(CS_TipoCuentaContrapartidaCO; "Conceptos salariales"."Tipo Cuenta Contrapartida CO")
                {
                }
                fieldelement(CS_NoCuentaContrapartidaCO; "Conceptos salariales"."No. Cuenta Contrapartida CO")
                {
                }
                fieldelement(CS_TipoCuentaContrapartidaCP; "Conceptos salariales"."Tipo Cuenta Contrapartida CP")
                {
                }
                fieldelement(CS_NoCuentaContrapartidaCP; "Conceptos salariales"."No. Cuenta Contrapartida CP")
                {
                }
                fieldelement(CS_ValidarContrapartidaCO; "Conceptos salariales"."Validar Contrapartida CO")
                {
                }
                fieldelement(CS_ValidarContrapartidaCP; "Conceptos salariales"."Validar Contrapartida CP")
                {
                }
                fieldelement(CS_AplicaParaRegalia; "Conceptos salariales"."Aplica para Regalia")
                {
                }
                fieldelement(CS_CotizaSUTA; "Conceptos salariales"."Cotiza SUTA")
                {
                }
                fieldelement(CS_CotizaFUTA; "Conceptos salariales"."Cotiza FUTA")
                {
                }
                fieldelement(CS_CotizaMEDICARE; "Conceptos salariales"."Cotiza MEDICARE")
                {
                }
                fieldelement(CS_CotizaFICA; "Conceptos salariales"."Cotiza FICA")
                {
                }
                fieldelement(CS_CotizaSINOT; "Conceptos salariales"."Cotiza SINOT")
                {
                }
                fieldelement(CS_CotizaCHOFERIL; "Conceptos salariales"."Cotiza CHOFERIL")
                {
                }
                fieldelement(CS_CotizaINCOMETAX; "Conceptos salariales"."Cotiza INCOMETAX")
                {
                }
                fieldelement(CS_ExcluirListados; "Conceptos salariales"."Excluir de listados")
                {
                }
            }
            tableelement(Table34002112; 34002112)
            {
                XmlName = 'ConfiguracionListados';
                fieldelement(CL_IDReporte; "Configuracion Listados"."ID Reporte")
                {
                }
                fieldelement(CL_NoColumna; "Configuracion Listados"."No. Columna")
                {
                }
                fieldelement(CL_TituloColumna; "Configuracion Listados"."Titulo Columna")
                {
                }
                fieldelement(CL_ConceptoSalarial; "Configuracion Listados"."Concepto Salarial")
                {
                }
                fieldelement(CL_TotalIngresos; "Configuracion Listados"."Total Ingresos")
                {
                }
                fieldelement(CL_TotalDeducciones; "Configuracion Listados"."Total Deducciones")
                {
                }
                fieldelement(CL_OtrosIngresos; "Configuracion Listados"."Otros Ingresos")
                {
                }
                fieldelement(CL_OtrasDeducciones; "Configuracion Listados"."Otras Deducciones")
                {
                }
                fieldelement(CL_NombreReporte; "Configuracion Listados"."Nombre Reporte")
                {
                }
            }
            tableelement(Table34002115; 34002115)
            {
                XmlName = 'PerfilSalarial';
                fieldelement("PS_EmpresaCotizacion"; "Perfil Salarial"."Empresa cotizacion")
                {
                }
                fieldelement(PS_NoEempleado; "Perfil Salarial"."No. empleado")
                {
                }
                fieldelement(PS_PerfilSalarial; "Perfil Salarial"."Perfil salarial")
                {
                }
                fieldelement(PS_NoLinea; "Perfil Salarial"."No. Linea")
                {
                }
                fieldelement(PS_Cargo; "Perfil Salarial".Cargo)
                {
                }
                fieldelement(PS_ConceptoSalarial; "Perfil Salarial"."Concepto salarial")
                {
                }
                fieldelement("PS_Descripcion"; "Perfil Salarial"."Descripcion")
                {
                }
                fieldelement(PS_Cantidad; "Perfil Salarial".Cantidad)
                {
                }
                fieldelement(PS_Importe; "Perfil Salarial".Importe)
                {
                }
                fieldelement(PS_TipoConcepto; "Perfil Salarial"."Tipo concepto")
                {
                }
                fieldelement("PS_SujetoCotizacion"; "Perfil Salarial"."Sujeto Cotizacion")
                {
                }
                fieldelement(PS_CotizaISR; "Perfil Salarial"."Cotiza ISR")
                {
                }
                fieldelement(PS_TextoInformativo; "Perfil Salarial"."Texto Informativo")
                {
                }
                fieldelement(PS_Prorratear; "Perfil Salarial".Prorratear)
                {
                }
                fieldelement("PS_FormulaCálculo"; "Perfil Salarial"."Formula cálculo")
                {
                }
                fieldelement("PS_PeríodoGenerac."; "Perfil Salarial"."Período generac.")
                {
                }
                fieldelement(PS_Imprimir; "Perfil Salarial".Imprimir)
                {
                }
                fieldelement("PS_InicioPeríodo"; "Perfil Salarial"."Inicio Período")
                {
                }
                fieldelement("PS_FinPeríodo"; "Perfil Salarial"."Fin Período")
                {
                }
                fieldelement(PS_Mes; "Perfil Salarial".Mes)
                {
                }
                fieldelement(PS_MesInicio; "Perfil Salarial"."Mes Inicio")
                {
                }
                fieldelement(PS_MesFin; "Perfil Salarial"."Mes Fin")
                {
                }
                fieldelement(PS_DeducirDias; "Perfil Salarial"."Deducir dias")
                {
                }
                fieldelement(PS_PrimeraQuincena; "Perfil Salarial"."1ra Quincena")
                {
                }
                fieldelement(PS_SegundaQuincena; "Perfil Salarial"."2da Quincena")
                {
                }
                fieldelement(PS_Status; "Perfil Salarial".Status)
                {
                }
                fieldelement("PS_TipoNomina"; "Perfil Salarial"."Tipo Nomina")
                {
                }
                fieldelement(PS_CotizaAFP; "Perfil Salarial"."Cotiza AFP")
                {
                }
                fieldelement(PS_CotizaSFS; "Perfil Salarial"."Cotiza SFS")
                {
                }
                fieldelement(PS_SalarioBase; "Perfil Salarial"."Salario Base")
                {
                }
                fieldelement(PS_CurrencyCode; "Perfil Salarial"."Currency Code")
                {
                }
                fieldelement(PS_ISRPagoEmpleado; "Perfil Salarial"."% ISR Pago Empleado")
                {
                }
                fieldelement(PS_CotizaINFOTEP; "Perfil Salarial"."Cotiza INFOTEP")
                {
                }
                fieldelement(PS_RetencionIngresoSalario; "Perfil Salarial"."% Retencion Ingreso Salario")
                {
                }
                fieldelement(PS_ImporteAcumulado; "Perfil Salarial"."Importe Acumulado")
                {
                }
                fieldelement(PS_FiltroFecha; "Perfil Salarial"."Filtro Fecha")
                {
                }
                fieldelement(PS_CotizaSRL; "Perfil Salarial"."Cotiza SRL")
                {
                }
                fieldelement(PS_AplicaParaRegalia; "Perfil Salarial"."Aplica para Regalia")
                {
                }
                fieldelement(PS_CotizaSUTA; "Perfil Salarial".Field39)
                {
                }
                fieldelement(PS_CotizaFUTA; "Perfil Salarial"."Job No.")
                {
                }
                fieldelement(PS_CotizaMEDICARE; "Perfil Salarial".Field41)
                {
                }
                fieldelement(PS_CotizaFICA; "Perfil Salarial"."Cotiza FICA")
                {
                }
                fieldelement(PS_CotizaSINOT; "Perfil Salarial".Field43)
                {
                }
                fieldelement(PS_CotizaCHOFERIL; "Perfil Salarial".Field44)
                {
                }
                fieldelement(PS_CotizaINCOMETAX; "Perfil Salarial".Field45)
                {
                }
                fieldelement(PS_ExcluirListados; "Perfil Salarial"."Excluir de listados")
                {
                }
            }
            tableelement(Table34002131; 34002131)
            {
                XmlName = 'TablaRetencionISR';
                fieldelement(TISR_Ano; "Tabla retencion ISR".Ano)
                {
                }
                fieldelement(TISR_NoOrden; "Tabla retencion ISR"."No. orden")
                {
                }
                fieldelement("TISR_ImporteMáximo"; "Tabla retencion ISR"."Importe Máximo")
                {
                }
                fieldelement("TISR_ImporteRetencion"; "Tabla retencion ISR"."Importe retencion")
                {
                }
                fieldelement("TISR_Retencion"; "Tabla retencion ISR"."% Retencion")
                {
                }
            }
            tableelement(Table34002129; 34002129)
            {
                XmlName = 'TiposCotizacion';
                fieldelement(TC_Ano; "Tipos de Cotizacion".Ano)
                {
                }
                fieldelement("TC_Codigo"; "Tipos de Cotizacion"."Codigo")
                {
                }
                fieldelement("TC_Descripcion"; "Tipos de Cotizacion"."Descripcion")
                {
                }
                fieldelement(TC_PorcientoEmpresa; "Tipos de Cotizacion"."Porciento Empresa")
                {
                }
                fieldelement(TC_PorcientoEmpleado; "Tipos de Cotizacion"."Porciento Empleado")
                {
                }
                fieldelement(TC_CuotaEmpresa; "Tipos de Cotizacion"."Cuota Empresa")
                {
                }
                fieldelement(TC_CuotaEmpleado; "Tipos de Cotizacion"."Cuota Empleado")
                {
                }
                fieldelement(TC_BaseAplicar; "Tipos de Cotizacion"."Base aplicar")
                {
                }
                fieldelement(TC_TopeSalarialAcumuladoAnual; "Tipos de Cotizacion"."Tope Salarial/Acumulado Anual")
                {
                }
                fieldelement(TC_AcumulaPor; "Tipos de Cotizacion"."Acumula por")
                {
                }
                fieldelement(TC_ControlEscalas; "Tipos de Cotizacion"."Control por escalas")
                {
                }
                fieldelement(TC_PorcientoEmpresaPensionados; "Tipos de Cotizacion"."Porciento Empresa Pensionados")
                {
                }
                fieldelement(TC_PorcientoEmpleadoPensionados; "Tipos de Cotizacion"."Porciento Empleado Pensionados")
                {
                }
            }
            tableelement(Table5218; Table5218)
            {
                XmlName = 'HumanResourcesSetup';
                fieldelement(HRS_PrimaryKey; "Human Resources Setup"."Primary Key")
                {
                }
                fieldelement(HRS_EmployeeNos; "Human Resources Setup"."Employee Nos.")
                {
                }
                fieldelement(HRS_BaseUnitMeasure; "Human Resources Setup"."Base Unit of Measure")
                {
                }
                fieldelement(HRS_CandidateNos; "Human Resources Setup"."Candidate Nos.")
                {
                }
            }
            tableelement(Table352; Table352)
            {
                XmlName = 'DefaultDimension';
                fieldelement(DD_TableID; "Default Dimension"."Table ID")
                {
                }
                fieldelement(DD_No; "Default Dimension"."No.")
                {
                }
                fieldelement(DD_DimensionCode; "Default Dimension"."Dimension Code")
                {
                }
                fieldelement(DD_DimensionValueCode; "Default Dimension"."Dimension Value Code")
                {
                }
                fieldelement(DD_ValuePosting; "Default Dimension"."Value Posting")
                {
                }
                fieldelement(DD_TableCaption; "Default Dimension"."Table Caption")
                {
                }
                fieldelement(DD_MultiSelectionAction; "Default Dimension"."Multi Selection Action")
                {
                }
            }
            tableelement(Table5211; Table5211)
            {
                XmlName = 'EmploymentContract';
                fieldelement(EC_Code; "Employment Contract".Code)
                {
                }
                fieldelement(EC_Description; "Employment Contract".Description)
                {
                }
                fieldelement(EC_NoContracts; "Employment Contract"."No. of Contracts")
                {
                }
                fieldelement(EC_Indefinite; "Employment Contract".Undefined)
                {
                }
            }
            tableelement(Table349; 349)
            {
                XmlName = 'DimensionValue';
                fieldelement(DV_DimensionCode; "Dimension Value"."Dimension Code")
                {
                }
                fieldelement(DV_Code; "Dimension Value".Code)
                {
                }
                fieldelement(DV_Name; "Dimension Value".Name)
                {
                }
                fieldelement(DV_ValueType; "Dimension Value"."Dimension Value Type")
                {
                }
                fieldelement(DV_Totaling; "Dimension Value".Totaling)
                {
                }
                fieldelement(DV_Blocked; "Dimension Value".Blocked)
                {
                }
                fieldelement(DV_ConsolidationCode; "Dimension Value"."Consolidation Code")
                {
                }
                fieldelement(DV_Indentation; "Dimension Value".Indentation)
                {
                }
                fieldelement(DV_GlobalDimensionNo; "Dimension Value"."Global Dimension No.")
                {
                }
                fieldelement(DV_MapToICDimensionCode; "Dimension Value"."Map-to IC Dimension Code")
                {
                }
                fieldelement(DV_MapToICDimensionValueCode; "Dimension Value"."Map-to IC Dimension Value Code")
                {
                }
                fieldelement(DV_DimensionValueID; "Dimension Value"."Dimension Value ID")
                {
                }
            }
            tableelement(Table34002107; 34002107)
            {
                XmlName = 'ParametrosCalculoDias';
                fieldelement(PCD_Codigo; "Parametros Calculo Dias".Codigo)
                {
                }
                fieldelement(PCD_Descripcion; "Parametros Calculo Dias".Descripcion)
                {
                }
                fieldelement(PCD_Valor; "Parametros Calculo Dias".Valor)
                {
                }
            }
            tableelement(Table34002135; 34002135)
            {
                XmlName = 'Departamentos';
                fieldelement(D_Codigo; Departamentos.Codigo)
                {
                }
                fieldelement(D_Descripcion; Departamentos.Descripcion)
                {
                }
            }
            tableelement(Table34002136; 34002136)
            {
                XmlName = 'Sub-Departamentos';
                fieldelement(SD_CodDepartamento; "Sub-Departamentos"."Cod. Departamento")
                {
                }
                fieldelement(SD_Codigo; "Sub-Departamentos".Codigo)
                {
                }
                fieldelement(SD_Descripcion; "Sub-Departamentos".Descripcion)
                {
                }
            }
            tableelement(Table34002104; 34002104)
            {
                XmlName = 'GruposContablesEmpleados';
                fieldelement("GCE_Codigo"; "Grupos Contables Empleados"."Codigo")
                {
                }
                fieldelement("GCE_Descripcion"; "Grupos Contables Empleados"."Descripcion")
                {
                }
            }
            tableelement(Table34002105; 34002105)
            {
                XmlName = 'DistCtasGpoContEmpl';
                fieldelement("DCGCE_Codigo"; "Dist. Ctas. Gpo. Cont. Empl."."Codigo")
                {
                }
                fieldelement("DCGCE_Descripcion"; "Dist. Ctas. Gpo. Cont. Empl."."Descripcion")
                {
                }
                fieldelement(DCGCE_ShortcutDimension; "Dist. Ctas. Gpo. Cont. Empl."."Shortcut Dimension")
                {
                }
                fieldelement("DCGCE_CodigoConceptoSalarial"; "Dist. Ctas. Gpo. Cont. Empl."."Codigo Concepto Salarial")
                {
                }
                fieldelement(DCGCE_TipoCuentaCuotaObrera; "Dist. Ctas. Gpo. Cont. Empl."."Tipo Cuenta Cuota Obrera")
                {
                }
                fieldelement(DCGCE_NoCuentaCuotaObrera; "Dist. Ctas. Gpo. Cont. Empl."."No. Cuenta Cuota Obrera")
                {
                }
                fieldelement(DCGCE_TipoCuentaCuotaPatronal; "Dist. Ctas. Gpo. Cont. Empl."."Tipo Cuenta Cuota Patronal")
                {
                }
                fieldelement(DCGCE_NoCuentaCuotaPatronal; "Dist. Ctas. Gpo. Cont. Empl."."No. Cuenta Cuota Patronal")
                {
                }
                fieldelement(DCGCE_TipoCuentaContrapartidaCO; "Dist. Ctas. Gpo. Cont. Empl."."Tipo Cuenta Contrapartida CO")
                {
                }
                fieldelement(DCGCE_NoCuentaContrapartidaCO; "Dist. Ctas. Gpo. Cont. Empl."."No. Cuenta Contrapartida CO")
                {
                }
                fieldelement(DCGCE_TipoCuentaContrapartidaCP; "Dist. Ctas. Gpo. Cont. Empl."."Tipo Cuenta Contrapartida CP")
                {
                }
                fieldelement(DCGCE_NoCuentaContrapartidaCP; "Dist. Ctas. Gpo. Cont. Empl."."No. Cuenta Contrapartida CP")
                {
                }
                fieldelement(DCGCE_ADistribuir; "Dist. Ctas. Gpo. Cont. Empl."."% a Distribuir")
                {
                }
                fieldelement(DCGCE_NoLinea; "Dist. Ctas. Gpo. Cont. Empl."."No. Linea")
                {
                }
                fieldelement(DCGCE_Provisionar; "Dist. Ctas. Gpo. Cont. Empl.".Provisionar)
                {
                }
            }
            tableelement(Table34002108; 34002108)
            {
                XmlName = 'DistribIngresoPagosElect';
                fieldelement(DIPE_NoEempleado; "Distrib. Ingreso Pagos Elect."."No. empleado")
                {
                }
                fieldelement(DIPE_CodBanco; "Distrib. Ingreso Pagos Elect."."Cod. Banco")
                {
                }
                fieldelement(DIPE_TipoCuenta; "Distrib. Ingreso Pagos Elect."."Tipo Cuenta")
                {
                }
                fieldelement(DIPE_NumeroCuenta; "Distrib. Ingreso Pagos Elect."."Numero Cuenta")
                {
                }
                fieldelement(DIPE_TipoImporte; "Distrib. Ingreso Pagos Elect."."Nro. tarjeta")
                {
                }
                fieldelement(DIPE_Importe; "Distrib. Ingreso Pagos Elect.".Importe)
                {
                }
                */
            }

            trigger OnAfterAssignVariable()
            begin
                /*
                IF SubDepto <> '' THEN
                   BEGIN
                   IF STRPOS(SubDepto,' ') <> 0 THEN
                      SubDepto := COPYSTR(SubDepto,STRPOS(SubDepto,' ')+1,4)
                   ELSE
                   IF STRPOS(SubDepto,'-') <> 0 THEN
                      SubDepto := COPYSTR(SubDepto,STRPOS(SubDepto,'-') +1,4)
                
                   END;
                
                IF STRPOS(Depto,'-') <> 0 THEN
                   Depart.SETFILTER(Descripcion,COPYSTR(Depto,STRPOS(Depto,'-') +1,3) + '*');
                Depart.FINDFIRST;
                
                Empl.GET(CodEmpl);
                Empl.Departamento := Depart.Codigo;
                
                IF SubDepto <> '' THEN
                   BEGIN
                SubDe.SETRANGE("Cod. Departamento",Depart.Codigo);
                SubDe.SETFILTER(Descripcion,'*' + SubDepto + '*');
                SubDe.FINDFIRST;
                   END;
                Empl."Sub-Departamento" := SubDe.Codigo;
                Empl.MODIFY;
                */

            end;
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

    var
        Empl: Record 5200;
    /*TODO: Ver
    esqsal: Record 34002115;
    contra: Record 34002109;
    CARGOS: Record 34002110;
    Depart: Record 34002135;
    SubDe: Record 34002136;*/
}

