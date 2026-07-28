report 34002113 "Lista Mov. CxC Empl."
{
    DefaultLayout = RDLC;
    RDLCLayout = './Lista Mov. CxC Empl..rdlc';

    dataset
    {
        dataitem("Historico Cab. Pr´Š¢stamo"; 34002146)
        {
            CalcFields = "Importe Original";
            DataItemTableView = SORTING("Employee No.", "No. Pr´Š¢stamo")
                                WHERE(No. Documento=FILTER(<>0));
            RequestFilterFields = "No. Pr´Š¢stamo","Employee No.";
            column(FORMAT_TODAY_0_4_;FORMAT(TODAY,0,4))
            {
            }
            column(COMPANYNAME;COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO;CurrReport.PAGENO)
            {
            }
            column(USERID;USERID)
            {
            }
            column(TIME;TIME)
            {
            }
            column(Hist_rico_Cab__Pr_stamo__No__Pr_stamo_;"No. Pr´Š¢stamo")
            {
            }
            column(Hist_rico_Cab__Pr_stamo__C_digo_Empleado_;"Employee No.")
            {
            }
            column(Hist_rico_Cab__Pr_stamo__Fecha_Registro_CxC_;"Fecha Registro CxC")
            {
            }
            column(Hist_rico_Cab__Pr_stamo__Importe_Cuota_;"Importe Cuota")
            {
            }
            column(Hist_rico_Cab__Pr_stamo__No__Documento_;"No. Documento")
            {
            }
            column(Hist_rico_Cab__Pr_stamo__Importe_Original_;"Importe Original")
            {
            }
            column(Hist_rico_Cab__Pr_stamo__Importe_Pendiente_;"Importe Pendiente")
            {
            }
            column(Emp__Full_Name_;Emp."Full Name")
            {
            }
            column(Detallado;Detallado)
            {
            }
            column(Hist_rico_Cab__Pr_stamo__Hist_rico_Cab__Pr_stamo___Importe_Pendiente_;"Historico Cab. Pr´Š¢stamo"."Importe Pendiente")
            {
            }
            column(Hist_rico_Cab__Pr_stamo__Hist_rico_Cab__Pr_stamo___Importe_Original_;"Historico Cab. Pr´Š¢stamo"."Importe Original")
            {
            }
            column(Movs__CxC_EmpleadosCaption;Movs__CxC_EmpleadosCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Hist_rico_Cab__Pr_stamo__No__Pr_stamo_Caption;FIELDCAPTION("No. Pr´Š¢stamo"))
            {
            }
            column(Hist_rico_Cab__Pr_stamo__C_digo_Empleado_Caption;FIELDCAPTION("Employee No."))
            {
            }
            column(Hist_rico_Cab__Pr_stamo__Fecha_Registro_CxC_Caption;FIELDCAPTION("Fecha Registro CxC"))
            {
            }
            column(Hist_rico_Cab__Pr_stamo__Importe_Cuota_Caption;FIELDCAPTION("Importe Cuota"))
            {
            }
            column(Hist_rico_Cab__Pr_stamo__No__Documento_Caption;FIELDCAPTION("No. Documento"))
            {
            }
            column(Hist_rico_Cab__Pr_stamo__Importe_Original_Caption;FIELDCAPTION("Importe Original"))
            {
            }
            column(Hist_rico_Cab__Pr_stamo__Importe_Pendiente_Caption;Hist_rico_Cab__Pr_stamo__Importe_Pendiente_CaptionLbl)
            {
            }
            column(Hist_rico_L_n__Pr_stamo_ImporteCaption;"Historico Lin. Pr´Š¢stamo".FIELDCAPTION(Importe))
            {
            }
            column(Hist_rico_L_n__Pr_stamo__D_bito_Caption;"Historico Lin. Pr´Š¢stamo".FIELDCAPTION(D´Š¢bito))
            {
            }
            column(Hist_rico_L_n__Pr_stamo__Cr_dito_Caption;"Historico Lin. Pr´Š¢stamo".FIELDCAPTION(Credito))
            {
            }
            column(Hist_rico_L_n__Pr_stamo__Fecha_Transacci_n_Caption;"Historico Lin. Pr´Š¢stamo".FIELDCAPTION("Fecha Transaccion"))
            {
            }
            column(Hist_rico_L_n__Pr_stamo__No__Cuota_Caption;"Historico Lin. Pr´Š¢stamo".FIELDCAPTION("No. Cuota"))
            {
            }
            column(Emp__Full_Name_Caption;Emp__Full_Name_CaptionLbl)
            {
            }
            column(TotalCaption;TotalCaptionLbl)
            {
            }
            dataitem("Historico Lin. Pr´Š¢stamo"; 34002147)
            {
                DataItemLink = No. Pr´Š¢stamo=FIELD(No. Pr´Š¢stamo),
                               "Codigo Empleado"=FIELD("Employee No.");
                DataItemTableView = SORTING("No. Pr´Š¢stamo","No. Linea");
                column(Hist_rico_L_n__Pr_stamo_Importe;Importe)
                {
                }
                column(Hist_rico_L_n__Pr_stamo__D_bito_;D´Š¢bito)
                {
                }
                column(Hist_rico_L_n__Pr_stamo__Cr_dito_;Credito)
                {
                }
                column(Hist_rico_L_n__Pr_stamo__No__Cuota_;"No. Cuota")
                {
                }
                column(Hist_rico_L_n__Pr_stamo__Fecha_Transacci_n_;"Fecha Transaccion")
                {
                }
                column("Historico_Lin__Pr´Š¢stamo_No__Pr´Š¢stamo";"No. Pr´Š¢stamo")
                {
                }
                column("Historico_Lin__Pr´Š¢stamo_No__Linea";"No. Linea")
                {
                }
                column("Historico_Lin__Pr´Š¢stamo_Codigo_Empleado";"Codigo Empleado")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                rMovCxC.SETRANGE("No. Pr´Š¢stamo","No. Pr´Š¢stamo");
                rMovCxC.SETRANGE("No. Documento","No. Documento");
                rMovCxC.FINDFIRST;
                Pendiente := TRUE;

                Emp.GET("Employee No.");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Detallado;Detallado)
                {
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        rMovCxC: Record 34002146;
        TotalFor: Label 'Total para ';
        Emp: Record 5200;
        Detallado: Boolean;
        Pendiente: Boolean;
        Movs__CxC_EmpleadosCaptionLbl: Label 'Movs. CxC Empleados';
        CurrReport_PAGENOCaptionLbl: Label 'Pagina';
        Hist_rico_Cab__Pr_stamo__Importe_Pendiente_CaptionLbl: Label 'Importe pendiente';
        Emp__Full_Name_CaptionLbl: Label 'Full name';
        TotalCaptionLbl: Label 'Total';
}

