report 55762 "Genera Nomina Electronica-New"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/Genera Nomina Electronica-New.rdl';
    Caption = 'Generate Electronic Payroll';

    dataset
    {
        dataitem(Employee; 5200)
        {
            DataItemTableView = SORTING("No.")
                                WHERE("Forma de Cobro" = FILTER(Cheque | 'Transferencia Banc.'));
            column(Total; Total)
            {
                DecimalPlaces = 2 : 2;
            }
            column(Contador; Contador)
            {

            }
            column(Total_EmpleadosCaption; Total_EmpleadosCaptionLbl)
            {
            }
            column(Employee_No_; "No.")
            {
            }
            dataitem("Historico Cab. nomina"; 55758)
            {
                DataItemLink = "No. empleado" = FIELD("No.");
                DataItemTableView = SORTING("No. empleado", Ano, Periodo, "Tipo Nomina");
                RequestFilterFields = Periodo, "Tipo de nomina";
                column(USERID; USERID)
                {
                }
                column(CurrReport_PAGENO; CurrReport.PAGENO)
                {
                }
                column(COMPANYNAME; COMPANYNAME)
                {
                }
                column(CURRENTDATETIME; CURRENTDATETIME)
                {
                }
                column(TODAY; TODAY)
                {
                }
                column(fechatrans; fechatrans)
                {
                }
                column(Empresa__Nombre_Empresa_cotizacion_; Empresa."Nombre Empresa cotizacion")
                {
                }
                column(Xbancos__Nombre_banco_; Xbancos."Nombre banco")
                {
                }
                column(Empresa__ID__Volante_Pago_; Empresa."ID  Volante Pago")
                {
                }
                column(Empresa_Direccion_________Empresa_nomero; Empresa.Direccion + ', ' + Empresa."Numero")
                {
                }
                column(Historico_Cab__nomina_Fin; Fin)
                {
                }
                column(Historico_Cab__nomina_Inicio; Inicio)
                {
                }
                column(Employee__Document_ID_; Employee."Document ID")
                {
                }
                column(Distrib__Ingreso_Pagos_Elect____Numero_Cuenta_; "Distrib. Ingreso Pagos Elect."."Numero Cuenta")
                {
                }
                column(Employee__Full_Name_; Employee."Full Name")
                {
                }
                column(Total_Ingresos___Total_deducciones_; "Total Ingresos" + "Total deducciones")
                {
                    DecimalPlaces = 2 : 2;
                }
                column(Employee__No__; Employee."No.")
                {
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column(Bank_s_electronic_payroll_paymentCaption; Bank_s_electronic_payroll_paymentCaptionLbl)
                {
                }
                column(Fecha_de_envioCaption; Fecha_de_envioCaptionLbl)
                {
                }
                column(Fecha_de_TransferenciaCaption; Fecha_de_TransferenciaCaptionLbl)
                {
                }
                column(EmpresaCaption; EmpresaCaptionLbl)
                {
                }
                column(Cedula___PasaporteCaption; Cedula___PasaporteCaptionLbl)
                {
                }
                column(NombreCaption; NombreCaptionLbl)
                {
                }
                column(ImporteCaption; ImporteCaptionLbl)
                {
                }
                column(Al__Caption; Al__CaptionLbl)
                {
                }
                column(Periodo_de_nomina_del_Caption; Periodo_de_nomina_del_CaptionLbl)
                {
                }
                column(CuentaCaption; CuentaCaptionLbl)
                {
                }
                column(Employee__No__Caption; Employee__No__CaptionLbl)
                {
                }
                column(Historico_Cab__nomina_No__empleado; "No. empleado")
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
                dataitem("Distrib. Ingreso Pagos Elect."; 55749)
                {
                    DataItemLink = "No. empleado" = FIELD("No. empleado");
                    DataItemTableView = SORTING("No. empleado", "Cod. Banco");
                }

                trigger OnAfterGetRecord()
                begin
                    CALCFIELDS("Total Ingresos", "Total deducciones");
                    IF "Total Ingresos" + "Total deducciones" < 1 THEN
                        CurrReport.SKIP;

                    //Total += ROUND("Total Ingresos" + "Total deducciones",0.01);
                    recLinNom.RESET;
                    recLinNom.SETCURRENTKEY("No. empleado", "Tipo nomina", Periodo, "No. Orden");
                    recLinNom.SETRANGE("No. empleado", "No. empleado");
                    recLinNom.SETRANGE("No. Documento", "No. Documento");
                    recLinNom.SETRANGE("Tipo nomina", "Tipo Nomina");
                    recLinNom.SETRANGE(Periodo, Periodo);
                    recLinNom.SETRANGE("Excluir de listados", FALSE);
                    IF recLinNom.FINDSET THEN
                        REPEAT
                            Total += ROUND(recLinNom.Total, 0.01);
                        UNTIL recLinNom.NEXT = 0;
                    Contador := Contador + 1;
                    "Distrib. Ingreso Pagos Elect.".RESET;
                    "Distrib. Ingreso Pagos Elect.".SETRANGE("No. empleado", "No. empleado");
                    "Distrib. Ingreso Pagos Elect.".FINDFIRST;
                end;

                trigger OnPreDataItem()
                begin
                    //IF TipoBanco  <> TipoBanco::Popular THEN
                    SETRANGE("Forma de Cobro", "Forma de Cobro"::"Transferencia Banc.");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF Empresa.Banco = '' THEN
                    ERROR(Err001);
            end;

            trigger OnPreDataItem()
            begin
                Empresa.FINDFIRST;
                Empresa.TESTFIELD("RNC/CED");
                RNC := DELCHR(Empresa."RNC/CED", '=', '-');
                Xbancos.GET(Empresa.Banco);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(fechatrans; fechatrans)
                {
                    ApplicationArea = All;
                    Caption = 'Efective Date';
                    ToolTip = 'Efective Date';
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

    trigger OnPostReport()
    begin
        ConfNomina.GET();
        ConfNomina.TESTFIELD("Codeunit Archivos Electronicos");

        "Historico Cab. nomina"."Tipo Archivo" := 1;
        "Historico Cab. nomina"."Fecha Pago" := fechatrans;

        CODEUNIT.RUN(ConfNomina."Codeunit Archivos Electronicos", "Historico Cab. nomina");
    end;

    var
        ConfNomina: Record 55744;
        Empresa: Record 55741;
        BancosACH: Record 34002167;
        recLinNom: Record 55759;
        Mes: Integer;
        Concepto: Text[36];
        Libre: Text[30];
        Total: Decimal;
        fechatrans: Date;
        Total1: Decimal;
        Xbancos: Record 55780;
        transac: Integer;
        Lin_Header: Text[500];
        Lin_Body: Text[500];
        FicheroTemporal: File;
        Fichero: File;
        Contador: Integer;
        I: Integer;
        TipoBanco: Option Popular,Leon,Scotiabank,Reservas,BHD;
        dir: Text[30];
        fich: Text[250];
        "Path Documento": Text[250];
        Date: Date;
        Strin: Integer;
        NroBatch: Text[6];
        PageAnt: Integer;
        Blanco: Text[500];
        Err001: Label 'Missing Bank''s information from Company Setup';
        Err002: Label 'The process will be canceled \the bank account is missing for employee %1';
        Text001: Label 'Payroll period ';
        PathENV: Text[250];
        Secuencia: Text[30];
        Text002: Label 'Text documents (*.txt) |*.txt|Word Documents (*.doc*)|*.doc*|All files (*.*)|*.*';
        SecuenciaTrans: Code[7];
        txtHora: Text[30];
        RNC: Text[30];
        NombreArchivo: Text[30];
        Total_EmpleadosCaptionLbl: Label 'Total Employees';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Bank_s_electronic_payroll_paymentCaptionLbl: Label 'Bank''s electronic payroll payment';
        Fecha_de_envioCaptionLbl: Label 'Sent date';
        Fecha_de_TransferenciaCaptionLbl: Label 'Transfer date';
        EmpresaCaptionLbl: Label 'Company';
        Cedula___PasaporteCaptionLbl: Label 'Document ID';
        NombreCaptionLbl: Label 'Name';
        ImporteCaptionLbl: Label 'Amount';
        Al__CaptionLbl: Label 'To :';
        Periodo_de_nomina_del_CaptionLbl: Label 'Payroll period from :';
        CuentaCaptionLbl: Label 'Account';
        Employee__No__CaptionLbl: Label 'Employee no.';
        PrimeraVez: Boolean;
}

