report 34002113 "Lista Mov. CxC Empl."
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/Lista Mov. CxC Empl..rdl';

    dataset
    {
        dataitem("Historico Cab. Prestamo"; 34002146)
        {
            CalcFields = "Importe Original";
            DataItemTableView = SORTING("Employee No.", "No. Prestamo")
            WHERE("No. Documento" = FILTER(<> 0));
            RequestFilterFields = "No. Prestamo", "Employee No.";

            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(TIME; TIME)
            {
            }
            column(Hist_rico_Cab__Pr_stamo__No__Pr_stamo_; "No. Prestamo")
            {
            }
            column(Hist_rico_Cab__Pr_stamo__C_digo_Empleado_; "Employee No.")
            {
            }
            column(Hist_rico_Cab__Pr_stamo__Fecha_Registro_CxC_; "Fecha Registro CxC")
            {
            }
            column(Hist_rico_Cab__Pr_stamo__Importe_Cuota_; "Importe Cuota")
            {
            }
            column(Hist_rico_Cab__Pr_stamo__No__Documento_; "No. Documento")
            {
            }
            column(Hist_rico_Cab__Pr_stamo__Importe_Original_; "Importe Original")
            {
            }
            column(Hist_rico_Cab__Pr_stamo__Importe_Pendiente_; "Importe Pendiente")
            {
            }
            column(Emp__Full_Name_; Emp."Full Name")
            {
            }
            column(Detallado; Detallado)
            {
            }
            column(Hist_rico_Cab__Pr_stamo__Hist_rico_Cab__Pr_stamo___Importe_Pendiente_; "Historico Cab. Prestamo"."Importe Pendiente")
            {
            }
            column(Hist_rico_Cab__Pr_stamo__Hist_rico_Cab__Pr_stamo___Importe_Original_; "Historico Cab. Prestamo"."Importe Original")
            {
            }
            column(Movs__CxC_EmpleadosCaption; Movs__CxC_EmpleadosCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Hist_rico_Cab__Pr_stamo__No__Pr_stamo_Caption; FIELDCAPTION("No. Prestamo"))
            {
            }
            column(Hist_rico_Cab__Pr_stamo__C_digo_Empleado_Caption; FIELDCAPTION("Employee No."))
            {
            }
            column(Hist_rico_Cab__Pr_stamo__Fecha_Registro_CxC_Caption; FIELDCAPTION("Fecha Registro CxC"))
            {
            }
            column(Hist_rico_Cab__Pr_stamo__Importe_Cuota_Caption; FIELDCAPTION("Importe Cuota"))
            {
            }
            column(Hist_rico_Cab__Pr_stamo__No__Documento_Caption; FIELDCAPTION("No. Documento"))
            {
            }
            column(Hist_rico_Cab__Pr_stamo__Importe_Original_Caption; FIELDCAPTION("Importe Original"))
            {
            }
            column(Hist_rico_Cab__Pr_stamo__Importe_Pendiente_Caption; Hist_rico_Cab__Pr_stamo__Importe_Pendiente_CaptionLbl)
            {
            }
            column(Hist_rico_L_n__Pr_stamo_ImporteCaption; "Historico Lin. Prestamo".FIELDCAPTION(Importe))
            {
            }
            column(Hist_rico_L_n__Pr_stamo__D_bito_Caption; "Historico Lin. Prestamo".FIELDCAPTION(Debito))
            {
            }
            column(Hist_rico_L_n__Pr_stamo__Cr_dito_Caption; "Historico Lin. Prestamo".FIELDCAPTION(Credito))
            {
            }
            column(Hist_rico_L_n__Pr_stamo__Fecha_Transacci_n_Caption; "Historico Lin. Prestamo".FIELDCAPTION("Fecha Transaccion"))
            {
            }
            column(Hist_rico_L_n__Pr_stamo__No__Cuota_Caption; "Historico Lin. Prestamo".FIELDCAPTION("No. Cuota"))
            {
            }
            column(Emp__Full_Name_Caption; Emp__Full_Name_CaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            dataitem("Historico Lin. Prestamo"; 34002147)
            {
                DataItemLink = "No. Prestamo" = FIELD("No. Prestamo"),
                               "Codigo Empleado" = FIELD("Employee No.");
                DataItemTableView = SORTING("No. Prestamo", "No. Linea");
                column(Hist_rico_L_n__Pr_stamo_Importe; Importe)
                {
                }
                column(Hist_rico_L_n__Pr_stamo__D_bito_; "Historico Lin. Prestamo"."Debito")
                {
                }
                column(Hist_rico_L_n__Pr_stamo__Cr_dito_; "Historico Lin. Prestamo"."Credito")
                {
                }
                column(Hist_rico_L_n__Pr_stamo__No__Cuota_; "No. Cuota")
                {
                }
                column(Hist_rico_L_n__Pr_stamo__Fecha_Transacci_n_; "Fecha Transaccion")
                {
                }
                column("Historico_Lin__Prestamo_No__Prestamo"; "No. Prestamo")
                {
                }
                column("Historico_Lin__Prestamo_No__Linea"; "No. Linea")
                {
                }
                column("Historico_Lin__Prestamo_Codigo_Empleado"; "Codigo Empleado")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                rMovCxC.SETRANGE("No. Prestamo", "No. Prestamo");
                rMovCxC.SETRANGE("No. Documento", "No. Documento");
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
                field(Detallado; Detallado)
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

