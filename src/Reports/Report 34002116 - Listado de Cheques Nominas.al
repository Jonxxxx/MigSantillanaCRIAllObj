report 34002116 "Listado de Cheques Nominas"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/Listado de Cheques Nominas.rdl';
    Caption = 'Listado de Cheques Nominas';

    dataset
    {
        dataitem("Historico Cab. nomina"; 34002117)
        {
            CalcFields = "Total Ingresos";
            DataItemTableView = SORTING("No. empleado", Ano, Periodo, "Tipo Nomina");
            RequestFilterFields = "Tipo de nomina", "No. empleado", Periodo;
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
            column(Historico_Cab__nomina__No__empleado_; "No. empleado")
            {
            }
            column(Historico_Cab__nomina_Nombre; Nombre)
            {
            }
            column(Historico_Cab__nomina__Tipo_operac__; "Tipo de nomina")
            {
            }
            column(Historico_Cab__nomina_Periodo; Periodo)
            {
            }
            column(Historico_Cab__nomina__Shortcut_Dimension_1_Code_; "Shortcut Dimension 1 Code")
            {
            }
            column(Historico_Cab__nomina__Shortcut_Dimension_2_Code_; "Shortcut Dimension 2 Code")
            {
            }
            column(Historico_Cab__nomina_Cargo; Cargo)
            {
            }
            column(Historico_Cab__nomina__Total_Ingresos_; "Total Ingresos")
            {
            }
            column(Historico_Cab__nomina__Total_deducciones_; "Total deducciones")
            {
            }
            column(Total_Ingresos_____Total_deducciones_; "Total Ingresos" + "Total deducciones")
            {
            }
            column(Total_Ingresos_____Total_deducciones__Control1000000007; "Total Ingresos" + "Total deducciones")
            {
            }
            column(Historico_Cab__nomina__Total_Ingresos__Control1000000010; "Total Ingresos")
            {
            }
            column(Historico_Cab__nomina__Total_deducciones__Control1000000013; "Total deducciones")
            {
            }
            column(Report_of_payment_with_check_to_employeeCaption; Report_of_payment_with_check_to_employeeCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Historico_Cab__nomina__No__empleado_Caption; FIELDCAPTION("No. empleado"))
            {
            }
            column(Historico_Cab__nomina_NombreCaption; FIELDCAPTION(Nombre))
            {
            }
            column(Historico_Cab__nomina__Tipo_operac__Caption; FIELDCAPTION("Tipo de nomina"))
            {
            }
            column(Historico_Cab__nomina_PeriodoCaption; FIELDCAPTION(Periodo))
            {
            }
            column(Historico_Cab__nomina__Shortcut_Dimension_1_Code_Caption; FIELDCAPTION("Shortcut Dimension 1 Code"))
            {
            }
            column(Historico_Cab__nomina__Shortcut_Dimension_2_Code_Caption; FIELDCAPTION("Shortcut Dimension 2 Code"))
            {
            }
            column(Historico_Cab__nomina_CargoCaption; FIELDCAPTION(Cargo))
            {
            }
            column(Historico_Cab__nomina__Total_Ingresos_Caption; FIELDCAPTION("Total Ingresos"))
            {
            }
            column(Historico_Cab__nomina__Total_deducciones_Caption; FIELDCAPTION("Total deducciones"))
            {
            }
            column(Total_Ingresos_____Total_deducciones_Caption; Total_Ingresos_____Total_deducciones_CaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Historico_Cab__nomina_Ano; Ano)
            {
            }
            column(Historico_Cab__nomina_Tipo_Nomina; "Tipo Nomina")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF GenerarCK THEN BEGIN
                    GenJnlLine.INIT;
                    GenJnlLine.VALIDATE("Journal Template Name", ConfNom."Journal Template Name CK");
                    GenJnlLine.VALIDATE("Journal Batch Name", ConfNom."Journal Batch Name CK");
                    GenJnlLine.VALIDATE("Posting Date", Fin);
                    GenJnlLine."Line No." := NoLin;
                    GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account");
                    GenJnlLine.VALIDATE("Account No.", ConfNom."Cta. Nominas Otros Pagos");
                    GenJnlLine.VALIDATE("Document Type", GenJnlLine."Document Type"::Payment);
                    GenJnlLine.VALIDATE("Document No.", "No. Documento");
                    GenJnlLine.VALIDATE(Amount, "Total Ingresos" + "Total deducciones");
                    GenJnlLine.VALIDATE("Bal. Account Type", GenJnlLine."Bal. Account Type"::"Bank Account");
                    GenJnlLine.VALIDATE("Bal. Account No.", EmpresasCot.Banco);
                    GenJnlLine.VALIDATE("Bank Payment Type", 1);
                    IF Tiposdenominas."Tipo de nomina" = Tiposdenominas."Tipo de nomina"::Prestaciones THEN
                        GenJnlLine.VALIDATE(Description, Text002)
                    ELSE
                        GenJnlLine.VALIDATE(Description, STRSUBSTNO(Text001, "Tipo de nomina", Inicio, Fin));
                    GenJnlLine.Beneficiario := Nombre;
                    NoLin += 1000;
                    GenJnlLine.INSERT;
                END;
            end;

            trigger OnPreDataItem()
            begin
                ConfNom.GET();
                ConfNom.TESTFIELD("Journal Template Name CK");
                ConfNom.TESTFIELD("Journal Batch Name CK");
                EmpresasCot.FINDFIRST;
                EmpresasCot.TESTFIELD(Banco);
                GenJnlLine.RESET;
                GenJnlLine.SETRANGE("Journal Template Name", ConfNom."Journal Template Name CK");
                GenJnlLine.SETRANGE("Journal Batch Name", ConfNom."Journal Batch Name CK");
                IF GenJnlLine.FINDLAST THEN
                    NoLin := GenJnlLine."Line No."
                ELSE
                    NoLin := 1000;

                NoLin += 1000;
                Tiposdenominas.GET("Historico Cab. nomina".GETRANGEMAX("Tipo de nomina"));
                IF Tiposdenominas."Tipo de nomina" <> Tiposdenominas."Tipo de nomina"::Prestaciones THEN
                    SETRANGE("Forma de Cobro", "Forma de Cobro"::Cheque);
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
                field(Mes; GenerarCK)
                {
                    ApplicationArea = All;
                    Caption = 'Request Check';
                    ToolTip = 'Request Check';
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
        ConfNom: Record 34002103;
        EmpresasCot: Record 34002100;
        GenJnlLine: Record 81;
        Tiposdenominas: Record 34002158;
        GenerarCK: Boolean;
        NoLin: Integer;
        Text001: Label 'Payment of %1 for period %2 - %3';
        Report_of_payment_with_check_to_employeeCaptionLbl: Label 'Report of payment with check to employee';
        CurrReport_PAGENOCaptionLbl: Label 'Pagina';
        Total_Ingresos_____Total_deducciones_CaptionLbl: Label 'Net Amount';
        TotalCaptionLbl: Label 'Total';
        Text002: Label 'Payment of end of labor contract';
}

