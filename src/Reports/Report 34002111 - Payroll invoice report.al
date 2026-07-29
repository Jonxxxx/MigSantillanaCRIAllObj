report 34002111 "Payroll invoice report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/Payroll invoice report.rdl';
    Caption = 'Payroll invoice report';

    dataset
    {
        dataitem("Historico Cab. nomina"; 34002117)
        {
            DataItemTableView = SORTING("No. empleado", Ano, Periodo, "Tipo Nomina");
            RequestFilterFields = "No. empleado", Ano, Periodo, "Tipo Nomina";
            column(Empl__No__; Empl."No.")
            {
            }
            column(Empl__Document_ID_; Empl."Document ID")
            {
            }
            column(Empl__Full_Name_; Empl."Full Name")
            {
            }
            column(PuestoTrab_Descripcion; PuestoTrab.Descripcion)
            {
            }
            column(Historico_Cab__nomina__Fecha_Entrada_; "Fecha Entrada")
            {
            }
            column(EmpresaCot_Imagen; EmpresaCot.Imagen)
            {
            }
            column(UPPERCASE_txtPeriodo_; UPPERCASE(txtPeriodo))
            {
            }
            column(EmpresaCot_Municipio; EmpresaCot.Municipio)
            {
            }
            column(EmpresaCot_Direccion; EmpresaCot.Direccion)
            {
            }
            column(EmpresaCot__RNC_CED_; EmpresaCot."RNC/CED")
            {
            }
            column(Document_ID_Caption; Document_ID_CaptionLbl)
            {
            }
            column(EMPLOYEECaption; EMPLOYEECaptionLbl)
            {
            }
            column(CargoCaption; CargoCaptionLbl)
            {
            }
            column(Historico_Cab__nomina__Fecha_Entrada_Caption; Historico_Cab__nomina__Fecha_Entrada_CaptionLbl)
            {
            }
            column(DESCRIPTIONCaption; DESCRIPTIONCaptionLbl)
            {
            }
            column(QUANTITYCaption; QUANTITYCaptionLbl)
            {
            }
            column(AMOUNTCaption; AMOUNTCaptionLbl)
            {
            }
            column(YTDCaption; YTDCaptionLbl)
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
            column(Historico_Cab__nomina_No__Documento; "No. Documento")
            {
            }
            dataitem(Ingresos; 34002118)
            {
                DataItemLink = "No. Documento" = FIELD("No. Documento"),
                               "No. empleado" = FIELD("No. empleado"),
                               "Tipo nomina" = FIELD("Tipo Nomina");
                DataItemTableView = SORTING("No. empleado", "Tipo nomina", Periodo, "Tipo concepto", "Concepto salarial")
                                    WHERE("Texto Informativo" = CONST(false));
                column(Ingresos_Descripcion; Descripcion)
                {
                }
                column(Ingresos_Cantidad; Cantidad)
                {
                }
                column(Ingresos_Total; Total)
                {
                }
                column(Acumulado_Total; Acumulado.Total)
                {
                }
                column(Ingresos_Total_Control1000000041; Total)
                {
                }
                column(Text001___FORMAT__Tipo_concepto__; Text001 + FORMAT("Tipo concepto"))
                {
                }
                column(Ingresos_Total_Control1000000042; Total)
                {
                }
                column(I__EARNINGSCaption; I__EARNINGSCaptionLbl)
                {
                }
                column(II__DEDUCTIONSCaption; II__DEDUCTIONSCaptionLbl)
                {
                }
                column(NET_AMOUNTCaption; NET_AMOUNTCaptionLbl)
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
                column(Ingresos_Tipo_concepto; "Tipo concepto")
                {
                }
                column(Ingresos_No__Documento; "No. Documento")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Acumulado.RESET;
                    Acumulado.SETCURRENTKEY("No. empleado", "Tipo concepto", Periodo, "Concepto salarial");
                    Acumulado.SETRANGE("No. empleado", "No. empleado");
                    Acumulado.SETRANGE("Concepto salarial", "Concepto salarial");
                    Acumulado.SETRANGE(Periodo, DMY2DATE(1, 1, Ano), Periodo);
                    Acumulado.CALCSUMS(Total);

                    IF Cantidad = 1 THEN
                        Cantidad := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF DATE2DMY(Inicio, 1) = 1 THEN
                    txtPeriodo := STRSUBSTNO(Text002, FIELDCAPTION("Tipo Nomina") + ' ' + FORMAT("Tipo Nomina"),
                                  Text003 + ', ' + FORMAT(Inicio, 0, '<Month text>, <Year4>'))
                ELSE
                    txtPeriodo := STRSUBSTNO(Text002, FIELDCAPTION("Tipo Nomina") + ' ' + FORMAT("Tipo Nomina"),
                                  Text004 + ', ' + FORMAT(Inicio, 0, '<Month text>, <Year4>'));

                Empl.GET("No. empleado");
                PuestoTrab.GET(Empl."Job Type Code");
            end;

            trigger OnPreDataItem()
            begin
                EmpresaCot.FINDFIRST;
                EmpresaCot.CALCFIELDS(Imagen);
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
        EmpresaCot: Record 34002100;
        Empl: Record 5200;
        Banco: Record 34002139;
        PuestoTrab: Record 34002110;
        Acumulado: Record 34002118;
        txtPeriodo: Text[150];
        Text001: Label 'Total for ';
        Text002: Label 'Receipt for payment of %1 period %2';
        Text003: Label '1st Half month';
        Text004: Label '2nd Half month';
        Document_ID_CaptionLbl: Label 'Document ID:';
        EMPLOYEECaptionLbl: Label 'EMPLOYEE';
        CargoCaptionLbl: Label 'Cargo';
        Historico_Cab__nomina__Fecha_Entrada_CaptionLbl: Label 'Fecha Entrada';
        DESCRIPTIONCaptionLbl: Label 'DESCRIPTION';
        QUANTITYCaptionLbl: Label 'QUANTITY';
        AMOUNTCaptionLbl: Label 'AMOUNT';
        YTDCaptionLbl: Label 'YTD';
        I__EARNINGSCaptionLbl: Label 'I. EARNINGS';
        II__DEDUCTIONSCaptionLbl: Label 'II. DEDUCTIONS';
        NET_AMOUNTCaptionLbl: Label 'NET AMOUNT';
}

