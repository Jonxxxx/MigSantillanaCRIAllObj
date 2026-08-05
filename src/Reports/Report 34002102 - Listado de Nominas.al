report 55743 "Listado de Nominas"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/Listado de Nominas.rdl';

    dataset
    {
        dataitem("Historico Cab. nomina"; 55758)
        {
            DataItemTableView = SORTING("No. empleado", Ano, Periodo, "Job No.", "Tipo Nomina");
            RequestFilterFields = "Tipo Nomina", Periodo, "No. empleado", "Job No.", "Frecuencia de pago", "Forma de Cobro";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; ConfEmpresa."Nombre Empresa cotizacion")
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(GETFILTERS; GETFILTERS)
            {
            }
            column(Text002___CURRENTKEY; Text002 + CURRENTKEY)
            {
            }
            column(TextoEncabezado_1_; TextoEncabezado[1])
            {
            }
            column(TextoEncabezado_2_; TextoEncabezado[2])
            {
            }
            column(TextoEncabezado_3_; TextoEncabezado[3])
            {
            }
            column(TextoEncabezado_5_; TextoEncabezado[5])
            {
            }
            column(TextoEncabezado_4_; TextoEncabezado[4])
            {
            }
            column(TextoEncabezado_9_; TextoEncabezado[9])
            {
            }
            column(TextoEncabezado_8_; TextoEncabezado[8])
            {
            }
            column(TextoEncabezado_7_; TextoEncabezado[7])
            {
            }
            column(TextoEncabezado_6_; TextoEncabezado[6])
            {
            }
            column(TextoEncabezado_10_; TextoEncabezado[10])
            {
            }
            column(lbl_Salario; lblSalario)
            {
            }
            column("Historico_Lin__nomina__No__empleado_"; "No. empleado")
            {
            }
            column(Historico_Cab__nomina__Nombre; Nombre)
            {
            }
            column(Employment_Date; Empleado."Employment Date")
            {
            }
            column(Job_Title; Empleado."Job Title")
            {
            }
            column(Salario; Salario)
            {
                AutoFormatType = 1;
            }
            column(Valor_1; Valor[1])
            {
                AutoFormatType = 1;
            }
            column(Valor_2; Valor[2])
            {
                AutoFormatType = 1;
            }
            column(Valor_4; Valor[4])
            {
                AutoFormatType = 1;
            }
            column(Valor_3; Valor[3])
            {
                AutoFormatType = 1;
            }
            column(Valor_5; Valor[5])
            {
                AutoFormatType = 1;
            }
            column(Valor_6; Valor[6])
            {
                AutoFormatType = 1;
            }
            column(Valor_7; Valor[7])
            {
                AutoFormatType = 1;
            }
            column(Valor_8; Valor[8])
            {
                AutoFormatType = 1;
            }
            column(Valor_9; Valor[9])
            {
                AutoFormatType = 1;
            }
            column(Valor_10; Valor[10])
            {
                AutoFormatType = 1;
            }
            column(TotalEmpleado; TotalIngresos + TotalDeducciones)
            {
                AutoFormatType = 1;
            }
            column(TotalIngresos___TotalDeducciones_Control1100058; TotalGral)
            {
                AutoFormatType = 1;
            }
            column(TotalEmpl; TotalEmpl)
            {
            }
            column(Valor_1__Control1000000119; Valor[1])
            {
                AutoFormatType = 1;
            }
            column(Valor_2__Control1000000120; Valor[2])
            {
                AutoFormatType = 1;
            }
            column(Valor_3__Control1000000121; Valor[3])
            {
                AutoFormatType = 1;
            }
            column(Valor_4__Control1000000122; Valor[4])
            {
                AutoFormatType = 1;
            }
            column(Valor_5__Control1000000123; Valor[5])
            {
                AutoFormatType = 1;
            }
            column(Valor_6__Control1000000124; Valor[6])
            {
                AutoFormatType = 1;
            }
            column(Valor_7__Control1000000125; Valor[7])
            {
                AutoFormatType = 1;
            }
            column(Valor_8__Control1000000126; Valor[8])
            {
                AutoFormatType = 1;
            }
            column(Valor_9__Control1000000127; Valor[9])
            {
                AutoFormatType = 1;
            }
            column(Valor_10__Control1000000128; Valor[10])
            {
                AutoFormatType = 1;
            }
            column(Payroll_s_ReportCaption; Payroll_s_ReportCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column("Historico_Lin__nomina__No__empleado_Caption"; 'No.')
            {
            }
            column(Historico_Cab__nomina__NombreCaption; Histrico_Cab__nomina__NombreCaptionLbl)
            {
            }
            column(TotalIngresos___TotalDeducciones_Control1100040Caption; TotalIngresos___TotalDeducciones_Control1100040CaptionLbl)
            {
            }
            column(Grand_TotalCaption; Grand_TotalCaptionLbl)
            {
            }
            column(Prepared_by__Caption; Prepared_by__CaptionLbl)
            {
            }
            column(Reviwed_by__Caption; Reviwed_by__CaptionLbl)
            {
            }
            column(Authorized_by__Caption; Authorized_by__CaptionLbl)
            {
            }
            column(Historico_Cab__nomina_Ano; Ano)
            {
            }
            column(Historico_Cab__nomina_Periodo; Periodo)
            {
            }
            column(Historico_Cab__nomina_Tipo_Nomina; "Tipo Nomina")
            {
            }
            column(Employment_Date_Caption; Text001)
            {
            }
            column(Job_Title_Caption; Empleado.FIELDCAPTION("Job Title"))
            {
            }

            trigger OnAfterGetRecord()
            begin

                TotalIngresos := 0;
                TotalDeducciones := 0;
                CLEAR(Valor);

                Empleado.GET("No. empleado");
                Empleado.CALCFIELDS(Salario);
                IF MuestraSalario THEN BEGIN
                    lblSalario := Empleado.FIELDCAPTION(Salario);
                    Salario := Empleado.Salario;
                END;

                IF NOT Depto.GET(Departamento) THEN
                    Depto.Descripcion := Text004;

                IF NOT SubDepto.GET(Departamento, "Sub-Departamento") THEN
                    SubDepto.Descripcion := Text004;

                TotalEmpl += 1;

                recLinNom.RESET;
                recLinNom.SETCURRENTKEY("No. empleado", "Tipo nomina", Periodo, "No. Orden");
                recLinNom.SETRANGE("No. empleado", "No. empleado");
                recLinNom.SETRANGE("No. Documento", "No. Documento");
                recLinNom.SETRANGE("Tipo nomina", "Tipo Nomina");
                recLinNom.SETRANGE(Periodo, Periodo);
                recLinNom.SETRANGE("Job No.", "Job No.");
                recLinNom.SETRANGE("Excluir de listados", FALSE);
                IF recLinNom.FINDSET THEN
                    REPEAT

                        WITH recLinNom DO BEGIN
                            //To find individuals codes
                            ConfigListados.RESET;
                            ConfigListados.SETRANGE("ID Reporte", 55743);
                            ConfigListados.SETFILTER("Concepto Salarial", '*' + "Concepto salarial" + '*');
                            IF ConfigListados.FINDFIRST THEN
                                Valor[ConfigListados."No. Columna"] += Total;

                            //Generic other codes columns
                            ConfigListados.RESET;
                            ConfigListados.SETRANGE("ID Reporte", 55743);
                            ConfigListados.SETFILTER("Concepto Salarial", '*' + "Concepto salarial" + '*');
                            IF NOT ConfigListados.FINDFIRST THEN BEGIN
                                ConfigListados.RESET;
                                ConfigListados.SETRANGE("ID Reporte", 55743);
                                CASE "Tipo concepto" OF
                                    0: //Ingresos
                                        BEGIN
                                            ConfigListados.SETRANGE("Otros Ingresos", TRUE);
                                            ConfigListados.FINDFIRST;
                                            Valor[ConfigListados."No. Columna"] += Total;
                                        END
                                    ELSE BEGIN
                                        ConfigListados.SETRANGE("Otras Deducciones", TRUE);
                                        ConfigListados.FINDFIRST;
                                        Valor[ConfigListados."No. Columna"] += Total;
                                    END;
                                END;
                            END;

                            //Total Incomes and total deductions
                            ConfigListados.RESET;
                            ConfigListados.SETRANGE("ID Reporte", 55743);
                            CASE "Tipo concepto" OF
                                0: //Ingresos
                                    BEGIN
                                        ConfigListados.SETRANGE("Total Ingresos", TRUE);
                                        ConfigListados.FINDFIRST;
                                        Valor[ConfigListados."No. Columna"] += ROUND(Total, 0.01);
                                        TotalIngresos += ROUND(Total, 0.01);
                                        //         TotalIngresos                        += Total;
                                        TotalGral += ROUND(Total, 0.01);
                                    END
                                ELSE BEGIN
                                    ConfigListados.SETRANGE("Total Deducciones", TRUE);
                                    ConfigListados.FINDFIRST;
                                    Valor[ConfigListados."No. Columna"] += ROUND(Total, 0.01);
                                    TotalDeducciones += ROUND(Total, 0.01);
                                    //         TotalDeducciones                     += Total;
                                    TotalGral += ROUND(Total, 0.01);
                                END;
                            END;
                        END;
                    UNTIL recLinNom.NEXT = 0;
            end;

            trigger OnPreDataItem()
            begin
                ConfEmpresa.FINDFIRST;
                MuestraSalario := TRUE;
                IF ConfEmpresa."Tipo Pago Nomina" <> ConfEmpresa."Tipo Pago Nomina"::Quincenal THEN
                    MuestraSalario := FALSE;

                ConfigListados.RESET;
                ConfigListados.SETRANGE("ID Reporte", 55743);
                ConfigListados.FIND('-');
                REPEAT
                    TextoEncabezado[ConfigListados."No. Columna"] := ConfigListados."Titulo Columna";
                UNTIL ConfigListados.NEXT = 0;
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

    labels
    {
    }

    var
        Empleado: Record 5200;
        ConfEmpresa: Record 55741;
        ConfigListados: Record 55753;
        Depto: Record 55776;
        SubDepto: Record 55777;
        recLinNom: Record 55759;
        TextoEncabezado: array[20] of Text[60];
        Valor: array[20] of Decimal;
        TotalIngresos: Decimal;
        TotalDeducciones: Decimal;
        TotalEmpl: Integer;
        Text001: Label 'Employment date';
        Text002: Label 'Order :';
        Text003: Label 'Total %1 %2';
        Text004: Label '-*- Doesn''t exist -*-';
        MuestraSalario: Boolean;
        lblSalario: Text[30];
        Salario: Decimal;
        Text005: Label 'Total';
        Payroll_s_ReportCaptionLbl: Label 'Payroll''s Report';
        CurrReport_PAGENOCaptionLbl: Label 'Pagina';
        Histrico_Cab__nomina__NombreCaptionLbl: Label 'Name';
        TotalIngresos___TotalDeducciones_Control1100040CaptionLbl: Label 'Net Income';
        Grand_TotalCaptionLbl: Label 'Grand Total';
        Prepared_by__CaptionLbl: Label 'Prepared by :';
        Reviwed_by__CaptionLbl: Label 'Reviwed by :';
        Authorized_by__CaptionLbl: Label 'Authorized by :';
        TotalGral: Decimal;
}

