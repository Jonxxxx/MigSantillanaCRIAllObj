report 34002159 "Nominas Totales X Departamento"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/Nominas Totales X Departamento.rdl';
    Caption = '<Nominas por Totales por Departamento>';

    dataset
    {
        dataitem("Historico Cab. nomina"; 34002117)
        {
            DataItemTableView = SORTING("No. empleado", Ano, Periodo, "Tipo Nomina");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Tipo Nomina", Periodo, "No. empleado", "Forma de Cobro";
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
            column(GETFILTERS; GETFILTERS)
            {
            }
            column(Payroll_s_ReportCaption; Payroll_s_ReportCaptionLbl)
            {
            }
            dataitem("Historico Lin. nomina"; 34002118)
            {
                DataItemLink = "No. empleado" = FIELD("No. empleado"),
                               "No. Documento" = FIELD("No. Documento"),
                               "Tipo nomina" = FIELD("Tipo Nomina"),
                               Periodo = FIELD(Periodo);
                DataItemTableView = SORTING("No. empleado", "Tipo nomina", Periodo, "No. Orden")
                                    WHERE("Excluir de listados" = CONST(false));
                column(TextoEncabezadoTotales; "Historico Lin. nomina".Descripcion)
                {
                }
                column(ValorTotales; "Historico Lin. nomina".Total)
                {
                }
                column(Departamento; rDepto.Descripcion)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin

                rDepto.RESET;
                IF NOT rDepto.GET(Departamento) THEN
                    rDepto.Descripcion := Text004;
                /*
                IF NOT rSubDepto.GET(Departamento,"Sub-Departamento") THEN
                  rSubDepto.Descripcion := Text004;
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

    labels
    {
    }

    var
        ConfEmpresa: Record 34002100;
        rDepto: Record 34002135;
        TextoEncabezado: array[20] of Text[60];
        Valor: array[20] of Decimal;
        TotalIngresos: Decimal;
        TotalDeducciones: Decimal;
        TotalEmpl: Integer;
        Text002: Label 'Order :';
        Text003: Label 'Total %1 %2';
        Text004: Label '-*- Doesn''t exist -*-';
        MuestraSalario: Boolean;
        lblSalario: Text[30];
        Salario: Decimal;
        Text005: Label 'Total';
        Payroll_s_ReportCaptionLbl: Label 'Total Department Payroll''s Report ';
        CurrReport_PAGENOCaptionLbl: Label 'Pagina';
        Histrico_Cab__nomina__NombreCaptionLbl: Label 'Name';
        TotalIngresos___TotalDeducciones_Control1100040CaptionLbl: Label 'Net Income';
        Grand_TotalCaptionLbl: Label 'Grand Total';
        Prepared_by__CaptionLbl: Label 'Prepared by :';
        Reviwed_by__CaptionLbl: Label 'Reviwed by :';
        Authorized_by__CaptionLbl: Label 'Authorized by :';
        TotalGral: Decimal;
        Fecha_contratacion: Label 'Hire date';
        ValorTotales: Decimal;
        TextoEncabezadoTotales: Text;
}

