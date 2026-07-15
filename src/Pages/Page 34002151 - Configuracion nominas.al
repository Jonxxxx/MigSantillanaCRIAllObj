page 34002151 "Configuracion nominas"
{
    PageType = Card;
    SourceTable = 34002103;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Método cálculo ausencias"; "Método cálculo ausencias")
                {
                    Importance = Additional;
                }
                field("Metodo calculo Ingresos"; "Metodo calculo Ingresos")
                {
                    Importance = Additional;
                }
                field("Metodo calculo Salidas"; "Metodo calculo Salidas")
                {
                    Importance = Additional;
                }
                field("Dimension Conceptos Salariales"; "Dimension Conceptos Salariales")
                {
                }
                field("Tasa Cambio Calculo Divisa"; "Tasa Cambio Calculo Divisa")
                {
                }
                field("Path Archivos Electronicos"; "Path Archivos Electronicos")
                {
                }
                field("Texto email recibos"; "Texto email recibos")
                {
                }
                field("Tiempo espera Envio email"; "Tiempo espera Envio email")
                {
                }
                field("Salario Minimo"; "Salario Minimo")
                {
                }
                field("Impuestos manuales"; "Impuestos manuales")
                {
                    Importance = Additional;
                }
                field("Metodo Calculo SS"; "Metodo Calculo SS")
                {
                }
                field("Nomina de Pais"; "Nomina de Pais")
                {
                    Importance = Additional;
                }
                field("ID Informe de nomina"; "ID Informe de nomina")
                {
                    Importance = Additional;
                }
                field("Codeunit calculo nomina"; "Codeunit calculo nomina")
                {
                    Importance = Additional;
                }
                field("Codeunit Archivos Electronicos"; "Codeunit Archivos Electronicos")
                {
                    Importance = Additional;
                }
                field("XML importa datos ponchador"; "XML importa datos ponchador")
                {
                    Importance = Additional;
                }
                field("Usar Acciones de personal"; "Usar Acciones de personal")
                {
                    Importance = Additional;
                }
                field("Calcular horas reg. asistencia"; "Calcular horas reg. asistencia")
                {
                    Importance = Additional;
                }
                field("Dias para corte nominas"; "Dias para corte nominas")
                {
                    Importance = Additional;
                }
                field("Multiempresa activo"; "Multiempresa activo")
                {
                    Importance = Additional;
                }
                field("Habilitar numeradores globales"; "Habilitar numeradores globales")
                {
                    Importance = Additional;
                }
                field("Mod. cooperativa activo"; "Mod. cooperativa activo")
                {
                    Importance = Additional;
                }
                field("Adelantar salario vacaciones"; "Adelantar salario vacaciones")
                {
                    Importance = Additional;
                }
                field("Tiempo minimo prest. coop."; "Tiempo minimo prest. coop.")
                {
                    Importance = Additional;
                }
                field("Integracion ponche activa"; "Integracion ponche activa")
                {
                    Importance = Additional;
                }
                field("CU Procesa datos ponchador"; "CU Procesa datos ponchador")
                {
                    Importance = Additional;
                }
                field("Completar horas ponchador"; "Completar horas ponchador")
                {
                    Importance = Additional;
                }
                field("Horas de almuerzo"; "Horas de almuerzo")
                {
                    Importance = Additional;
                }
                field("Prioridad correos"; "Prioridad correos")
                {
                    Importance = Additional;
                }
                field("Act. Excluido TSS automatico"; "Act. Excluido TSS automatico")
                {
                    Importance = Additional;
                }
            }
            group("Salary Wages")
            {
                Caption = 'Salary Wages';
                field("Concepto Sal. Base"; "Concepto Sal. Base")
                {
                }
                field("Concepto Sal. hora"; "Concepto Sal. hora")
                {
                }
                field("Concepto Retroactivo"; "Concepto Retroactivo")
                {
                }
                field("Concepto ISR"; "Concepto ISR")
                {
                }
                field("Concepto devolucion ISR"; "Concepto devolucion ISR")
                {
                }
                field("Concepto ISR Cobrado en exceso"; "Concepto ISR Cobrado en exceso")
                {
                }
                field("Concepto AFP"; "Concepto AFP")
                {
                }
                field("Concepto SFS"; "Concepto SFS")
                {
                }
                field("Concepto SRL"; "Concepto SRL")
                {
                }
                field("Concepto INFOTEP"; "Concepto INFOTEP")
                {
                }
                field("Concepto Antiguedad Laboral"; "Concepto Antiguedad Laboral")
                {
                    Visible = NominaHN;
                }
                field("Concepto CxC Empl."; "Concepto CxC Empl.")
                {
                }
                field("Concepto Cuota cooperativa"; "Concepto Cuota cooperativa")
                {
                }
                field("Concepto Vacaciones"; "Concepto Vacaciones")
                {
                }
                field("Concepto Inasistencia"; "Concepto Inasistencia")
                {
                    Importance = Additional;
                }
                field("Concepto Regalia"; "Concepto Regalia")
                {
                }
                field("Concepto Bonificacion"; "Concepto Bonificacion")
                {
                }
                field("Concepto Preaviso"; "Concepto Preaviso")
                {
                }
                field("Concepto Cesantia"; "Concepto Cesantia")
                {
                }
                field("Concepto Horas Ext. 35%"; "Concepto Horas Ext. 35%")
                {
                }
                field("Concepto Horas Ext. 100%"; "Concepto Horas Ext. 100%")
                {
                }
                field("Concepto Dias feriados"; "Concepto Dias feriados")
                {
                }
                field("Concepto Horas nocturnas"; "Concepto Horas nocturnas")
                {
                }
                field("Concepto Incentivos"; "Concepto Incentivos")
                {
                }
                field("Concepto Reembolso gtos."; "Concepto Reembolso gtos.")
                {
                    Importance = Additional;
                }
            }
            group(Government)
            {
                Caption = 'Government';
                field("Web Page TSS"; "Web Page TSS")
                {
                }
                field("Web Page DGII"; "Web Page DGII")
                {
                }
            }
            group(Payments)
            {
                Caption = 'Payments';
                field("Journal Template Name"; "Journal Template Name")
                {
                }
                field("Journal Batch Name"; "Journal Batch Name")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Secc: Record 232;
                    begin
                        Secc.RESET;
                        Secc.SETRANGE("Journal Template Name", "Journal Template Name");
                        IF PAGE.RUNMODAL(PAGE::"General Journal Batches", Secc) = ACTION::LookupOK THEN
                            "Journal Batch Name" := Secc.Name
                        ELSE
                            "Journal Batch Name" := '';
                    end;
                }
                field("Tipo cuenta"; "Tipo cuenta")
                {
                }
                field("Cod. Cta. Nominas Pago Transf."; "Cod. Cta. Nominas Pago Transf.")
                {
                }
                field("Tipo Cta. Otros Pagos"; "Tipo Cta. Otros Pagos")
                {
                }
                field("Cta. Nominas Otros Pagos"; "Cta. Nominas Otros Pagos")
                {
                }
                field("Journal Template Name CK"; "Journal Template Name CK")
                {
                }
                field("Journal Batch Name CK"; "Journal Batch Name CK")
                {
                }
            }
            group(Numbering)
            {
                Caption = 'Numbering';
                field("No. serie nominas"; "No. serie nominas")
                {
                }
                field("No. serie CxC"; "No. serie CxC")
                {
                }
                field("No. serie reg. CxC"; "No. serie reg. CxC")
                {
                }
                field("No. serie Sol. Prest. Coop."; "No. serie Sol. Prest. Coop.")
                {
                }
                field("No. serie Hist. Prest. Coop."; "No. serie Hist. Prest. Coop.")
                {
                }
            }
            group(Job)
            {
                Caption = 'Job';
                field("Job Journal Template Name"; "Job Journal Template Name")
                {
                }
                field("Job Journal Batch Name"; "Job Journal Batch Name")
                {
                }
            }
            group(Captions)
            {
                Caption = 'Captions';
                field("Caption Depto"; "Caption Depto")
                {
                }
                field("Caption Sub Depto"; "Caption Sub Depto")
                {
                }
                field("Caption ISR"; "Caption ISR")
                {
                }
                field("Caption INFOTEP"; "Caption INFOTEP")
                {
                }
                field("Caption AFP"; "Caption AFP")
                {
                }
                field("Caption SFS"; "Caption SFS")
                {
                }
                field("Caption SRL"; "Caption SRL")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Calendar")
            {
                Caption = '&Calendar';
                action("Vacation parameters")
                {
                    Caption = 'Vacation parameters';
                    Image = NumberSetup;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 34002205;
                }
            }
        }
    }

    var
        [InDataSet]
        NominaHN: Boolean;
}

