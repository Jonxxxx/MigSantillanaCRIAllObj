report 34002117 "Recibo Pago Sobres"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/Recibo Pago Sobres.rdl';
    Permissions = TableData 34002117 = rimd,
                  TableData 34002118 = rimd;

    dataset
    {
        dataitem("Historico Cab. nomina"; 34002117)
        {
            CalcFields = "Total Ingresos";
            DataItemTableView = SORTING("No. empleado", Ano, Periodo, "Tipo Nomina");
            RequestFilterFields = "No. empleado", "Tipo de nomina", Periodo;
            column(No__empleado___________Nombre; "No. empleado" + ', ' + Nombre)
            {
            }
            column(rEmpleado__Document_ID_; rEmpleado."Document ID")
            {
            }
            column(TODAY; TODAY)
            {
            }
            column(TIME; TIME)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Hist_rico_Cab__n_mina__Hist_rico_Cab__n_mina__Inicio; "Historico Cab. nomina".Inicio)
            {
            }
            column(Hist_rico_Cab__n_mina__Hist_rico_Cab__n_mina__Fin; "Historico Cab. nomina".Fin)
            {
            }
            column(No__empleado___________Nombre_Control1000000011; "No. empleado" + ', ' + Nombre)
            {
            }
            column(Hist_rico_Cab__n_mina__Hist_rico_Cab__n_mina__Inicio_Control1000000015; "Historico Cab. nomina".Inicio)
            {
            }
            column(Hist_rico_Cab__n_mina__Hist_rico_Cab__n_mina__Fin_Control1000000018; "Historico Cab. nomina".Fin)
            {
            }
            column(TIME_Control1000000020; TIME)
            {
            }
            column(COMPANYNAME_Control1000000022; COMPANYNAME)
            {
            }
            column(TODAY_Control1000000023; TODAY)
            {
            }
            column(Hist_rico_Cab__n_mina___Total_Ingresos_____Hist_rico_Cab__n_mina___Total_deducciones_; "Historico Cab. nomina"."Total Ingresos" + "Historico Cab. nomina"."Total deducciones")
            {
            }
            column(Hist_rico_Cab__n_mina___Total_Ingresos_____Hist_rico_Cab__n_mina___Total_deducciones__Control1000000010; "Historico Cab. nomina"."Total Ingresos" + "Historico Cab. nomina"."Total deducciones")
            {
            }
            column(No__empleado___________NombreCaption; No__empleado___________NombreCaptionLbl)
            {
            }
            column(rEmpleado__Document_ID_Caption; rEmpleado__Document_ID_CaptionLbl)
            {
            }
            column(TODAYCaption; TODAYCaptionLbl)
            {
            }
            column(TIMECaption; TIMECaptionLbl)
            {
            }
            column(Recibo_de_n_mina_per_odoCaption; Recibo_de_n_mina_per_odoCaptionLbl)
            {
            }
            column(alCaption; alCaptionLbl)
            {
            }
            column(INCOMECaption; INCOMECaptionLbl)
            {
            }
            column(INCOMECaption_Control1000000013; INCOMECaption_Control1000000013Lbl)
            {
            }
            column(alCaption_Control1000000017; alCaption_Control1000000017Lbl)
            {
            }
            column(No__empleado___________Nombre_Control1000000011Caption; No__empleado___________Nombre_Control1000000011CaptionLbl)
            {
            }
            column(TODAY_Control1000000023Caption; TODAY_Control1000000023CaptionLbl)
            {
            }
            column(TIME_Control1000000020Caption; TIME_Control1000000020CaptionLbl)
            {
            }
            column(Hist_rico_Cab__n_mina___Total_Ingresos_____Hist_rico_Cab__n_mina___Total_deducciones_Caption; Hist_rico_Cab__n_mina___Total_Ingresos_____Hist_rico_Cab__n_mina___Total_deducciones_CaptionLbl)
            {
            }
            column(Hist_rico_Cab__n_mina___Total_Ingresos_____Hist_rico_Cab__n_mina___Total_deducciones__Control1000000010Caption; Hist_rico_Cab__n_mina___Total_Ingresos_____Hist_rico_Cab__n_mina___Total_deducciones__Control1000000010CaptionLbl)
            {
            }
            column(Recibido_ConformeCaption; Recibido_ConformeCaptionLbl)
            {
            }
            column(Recibido_ConformeCaption_Control1000000035; Recibido_ConformeCaption_Control1000000035Lbl)
            {
            }
            column(Historico_Cab__nomina_No__empleado; "No. empleado")
            {
            }
            column(Historico_Cab__nomina_Ano; Ano)
            {
            }
            column(Historico_Cab__nomina_Per_odo; Periodo)
            {
            }
            column(Historico_Cab__nomina_Tipo_Nomina; "Tipo Nomina")
            {
            }
            dataitem(Ingresos; 34002118)
            {
                DataItemLink = "No. empleado" = FIELD("No. empleado"),
                               "Tipo nomina" = FIELD("Tipo Nomina"),
                               Periodo = FIELD(Periodo);
                DataItemTableView = SORTING("No. empleado", "Tipo nomina", Periodo, "No. Orden")
                                    WHERE("Tipo concepto" = CONST(Ingresos));
                column(Ingresos__Descripci_n_; Descripcion)
                {
                }
                column(Ingresos_Total; Total)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(Ingresos__Descripci_n__Control1000000026; Descripcion)
                {
                }
                column(Ingresos_Total_Control1000000027; Total)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(Ingresos_Total_Control54; Total)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(Ingresos_Total_Control1000000031; Total)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(V1Caption; V1CaptionLbl)
                {
                }
                column(Total_IncomesCaption; Total_IncomesCaptionLbl)
                {
                }
                column(Total_IncomesCaption_Control1000000032; Total_IncomesCaption_Control1000000032Lbl)
                {
                }
                column(Ingresos_No__empleado; "No. empleado")
                {
                }
                column(Ingresos_Tipo_nomina; "Tipo nomina")
                {
                }
                column(Ingresos_Periodo; Periodo)
                {
                }
                column(Ingresos_No__Orden; "No. Orden")
                {
                }
            }
            dataitem(Deducciones; 34002118)
            {
                DataItemLink = "No. empleado" = FIELD("No. empleado"),
                               "Tipo nomina" = FIELD("Tipo Nomina"),
                               Periodo = FIELD(Periodo);
                DataItemTableView = SORTING("No. empleado", "Tipo nomina", Periodo, "No. Orden")
                                    WHERE("Tipo concepto" = CONST(Deducciones));
                column(Deducciones__Descripci_n_; Descripcion)
                {
                }
                column(ABS_Total_; ABS(Total))
                {
                    DecimalPlaces = 2 : 2;
                }
                column(Deducciones__Descripci_n__Control1000000029; Descripcion)
                {
                }
                column(ABS_Total__Control1000000030; ABS(Total))
                {
                    DecimalPlaces = 2 : 2;
                }
                column(ABS_Total__Control1000000007; ABS(Total))
                {
                    DecimalPlaces = 2 : 2;
                }
                column(ABS_Total__Control1000000033; ABS(Total))
                {
                    DecimalPlaces = 2 : 2;
                }
                column(DEDUCTIONSCaption; DEDUCTIONSCaptionLbl)
                {
                }
                column(DEDUCTIONSCaption_Control1000000028; DEDUCTIONSCaption_Control1000000028Lbl)
                {
                }
                column(V2Caption; V2CaptionLbl)
                {
                }
                column(Total_DeductionsCaption; Total_DeductionsCaptionLbl)
                {
                }
                column(Total_DeductionsCaption_Control1000000034; Total_DeductionsCaption_Control1000000034Lbl)
                {
                }
                column(Deducciones_No__empleado; "No. empleado")
                {
                }
                column(Deducciones_Tipo_nomina; "Tipo nomina")
                {
                }
                column(Deducciones_Periodo; Periodo)
                {
                }
                column(Deducciones_No__Orden; "No. Orden")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                IF NOT rCargos.GET(Cargo) THEN
                    rCargos.INIT;

                rEmpleado.GET("No. empleado");
                NoSobre += 1;
            end;

            trigger OnPreDataItem()
            begin
                rEmpresa.GET();
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
        rEmpleado: Record 5200;
        rEmpresa: Record 79;
        rCargos: Record 34002110;
        NoSobre: Integer;
        No__empleado___________NombreCaptionLbl: Label 'Employee';
        rEmpleado__Document_ID_CaptionLbl: Label 'Document';
        TODAYCaptionLbl: Label 'Date:';
        TIMECaptionLbl: Label 'Time:';
        Recibo_de_n_mina_per_odoCaptionLbl: Label 'Recibo de nomina periodo';
        alCaptionLbl: Label 'al';
        INCOMECaptionLbl: Label 'INCOME';
        INCOMECaption_Control1000000013Lbl: Label 'INCOME';
        alCaption_Control1000000017Lbl: Label 'al';
        No__empleado___________Nombre_Control1000000011CaptionLbl: Label 'Employee';
        TODAY_Control1000000023CaptionLbl: Label 'Date:';
        TIME_Control1000000020CaptionLbl: Label 'Time:';
        Hist_rico_Cab__n_mina___Total_Ingresos_____Hist_rico_Cab__n_mina___Total_deducciones_CaptionLbl: Label 'Net Income';
        Hist_rico_Cab__n_mina___Total_Ingresos_____Hist_rico_Cab__n_mina___Total_deducciones__Control1000000010CaptionLbl: Label 'Net Income';
        Recibido_ConformeCaptionLbl: Label 'Recibido Conforme';
        Recibido_ConformeCaption_Control1000000035Lbl: Label 'Recibido Conforme';
        V1CaptionLbl: Label '1';
        Total_IncomesCaptionLbl: Label 'Total Incomes';
        Total_IncomesCaption_Control1000000032Lbl: Label 'Total Incomes';
        DEDUCTIONSCaptionLbl: Label 'DEDUCTIONS';
        DEDUCTIONSCaption_Control1000000028Lbl: Label 'DEDUCTIONS';
        V2CaptionLbl: Label '2';
        Total_DeductionsCaptionLbl: Label 'Total Deductions';
        Total_DeductionsCaption_Control1000000034Lbl: Label 'Total Deductions';
}

