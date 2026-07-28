report 34002119 "Lista acumulado Regalia"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Lista acumulado Regalia.rdlc';

    dataset
    {
        dataitem(Employee; 5200)
        {
            CalcFields = Salario, "Acumulado Salario";
            DataItemTableView = SORTING("No.")
                                WHERE(Status = CONST(Active));
            RequestFilterFields = "No.", "Posting Group";
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
            column(TotImporte; TotImporte)
            {
                AutoFormatType = 1;
            }
            column(Employee__No__; "No.")
            {
            }
            column(Employee__Full_Name_; "Full Name")
            {
            }
            column(AcumuladoSalario; AcumuladoSalario)
            {
                AutoFormatType = 1;
            }
            column(Employee_Salario; Salario)
            {
                AutoFormatType = 1;
            }
            column(Employee__Employment_Date_; "Employment Date")
            {
                AutoFormatType = 1;
            }
            column(TotImporte_Control25; TotImporte)
            {
                AutoFormatType = 1;
            }
            column(AcumuladoSalario_Control9; AcumuladoSalario)
            {
                AutoFormatType = 1;
            }
            column(TotEmpleados; TotEmpleados)
            {
                DecimalPlaces = 0 : 0;
            }
            column(Acumulado_de_regalia_por_empleadoCaption; Acumulado_de_regalia_por_empleadoCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(TotImporteCaption; TotImporteCaptionLbl)
            {
            }
            column(Employee__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(AcumuladoSalarioCaption; AcumuladoSalarioCaptionLbl)
            {
            }
            column(Employee__Full_Name_Caption; FIELDCAPTION("Full Name"))
            {
            }
            column(Employee_SalarioCaption; FIELDCAPTION(Salario))
            {
            }
            column(Employee__Employment_Date_Caption; FIELDCAPTION("Employment Date"))
            {
            }
            column(Total_Gral_Caption; Total_Gral_CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            var
                MontoVac: Decimal;
                DiasVac: Decimal;
                tDias: Integer;
            begin
                TotImporte := 0;
                UltIngresosxQuincena := 0;
                UltIngresosOtros := 0;
                TotNominas := 0;

                //Busco el contrato para saber la frecuencia de pago
                Contrato.RESET;
                Contrato.SETRANGE("No. empleado", "No.");
                IF NOT Contrato.FINDLAST THEN
                    Contrato.INIT;

                IF ("Proyectar salario 12") AND (Contrato.Activo) THEN BEGIN
                    IF DATE2DMY(Contrato."Fecha inicio", 3) < Anotrabajo THEN BEGIN
                        IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) OR
                           (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::"Bi-Semanal") THEN
                            CantidadDeNominas := 24
                        ELSE
                            IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Semanal THEN
                                CantidadDeNominas := 52
                            ELSE
                                CantidadDeNominas := 12;
                    END
                    ELSE BEGIN
                        IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) OR
                           (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::"Bi-Semanal") THEN BEGIN
                            CantidadDeNominas := DATE2DMY(Contrato."Fecha inicio", 2);
                            CantidadDeNominas := CantidadDeNominas * 2;
                            CantidadDeNominas := 24 - CantidadDeNominas;
                        END
                        ELSE
                            IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Semanal THEN BEGIN
                                Fecha.RESET;
                                Fecha.SETRANGE("Period Type", Fecha."Period Type"::Week);
                                Fecha.SETFILTER("Period Start", '>=%1', Contrato."Fecha inicio");
                                Fecha.FINDFIRST;
                                CantidadDeNominas := 52 - Fecha."Period No.";
                            END
                            ELSE
                                CantidadDeNominas := 12 - DATE2DMY(Contrato."Fecha inicio", 2);
                    END;

                    //Busco todas las nominas generadas
                    HistLinNom.RESET;
                    HistLinNom.SETCURRENTKEY("No. empleado", "Tipo concepto", Periodo, Total);
                    HistLinNom.SETRANGE("No. empleado", "No.");
                    // HistLinNom.SETRANGE("Tipo nomina",HistLinNom."Tipo nomina"::Normal);
                    IF (TiposNom."Dia inicio 1ra" <> 1) THEN
                        HistLinNom.SETRANGE(Periodo, DMY2DATE(TiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', Fecha."Period Start"), 2), DATE2DMY(CALCDATE('-1M', Fecha."Period Start"), 3)), DMY2DATE(TiposNom."Dia inicio 2da", 12, DATE2DMY(Fecha."Period Start", 3)))
                    ELSE
                        HistLinNom.SETRANGE(Periodo, DMY2DATE(1, 1, DATE2DMY(NORMALDATE(Fecha."Period End"), 3)), DMY2DATE(31, 12, DATE2DMY(NORMALDATE(Fecha."Period End"), 3)));
                    HistLinNom.SETRANGE("Aplica para Regalia", TRUE);
                    IF HistLinNom.FINDSET THEN
                        REPEAT
                            Mes := DATE2DMY(HistLinNom.Periodo, 2);
                            TotImporte += HistLinNom.Total;
                        UNTIL HistLinNom.NEXT = 0;

                    //Busco la cantidad de nominas
                    HistCabNom.RESET;
                    HistCabNom.SETRANGE("No. empleado", "No.");
                    HistCabNom.SETRANGE("Tipo de nomina", TiposNom.Codigo);
                    IF (TiposNom."Dia inicio 1ra" <> 1) THEN
                        HistCabNom.SETRANGE(Periodo, DMY2DATE(TiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', Fecha."Period Start"), 2), DATE2DMY(CALCDATE('-1M', Fecha."Period Start"), 3)), DMY2DATE(TiposNom."Dia inicio 2da", 12, DATE2DMY(Fecha."Period Start", 3)))
                    ELSE
                        HistCabNom.SETRANGE(Periodo, DMY2DATE(1, 1, DATE2DMY(NORMALDATE(Fecha."Period End"), 3)), DMY2DATE(31, 12, DATE2DMY(NORMALDATE(Fecha."Period End"), 3)));

                    //      HistCabNom.SETRANGE(Periodo,DMY2DATE(1,1,Anotrabajo),DMY2DATE(31,12,Anotrabajo));
                    IF HistCabNom.FINDSET THEN
                        REPEAT
                            TotNominas += 1;
                        UNTIL HistCabNom.NEXT = 0;

                    HistCabNom.RESET;
                    HistCabNom.SETRANGE("No. empleado", "No.");
                    //HistCabNom.SETRANGE("Tipo Nomina",HistCabNom."Tipo Nomina"::Normal);
                    HistCabNom.SETRANGE(Periodo, DMY2DATE(1, 1, Anotrabajo), DMY2DATE(31, 12, Anotrabajo));
                    IF HistCabNom.FINDLAST THEN BEGIN
                        HistLinNom.RESET;
                        HistLinNom.SETCURRENTKEY("No. empleado", "Tipo concepto", Periodo, Total);
                        HistLinNom.SETRANGE("No. empleado", "No.");
                        //HistLinNom.SETRANGE("Tipo nomina",HistLinNom."Tipo nomina"::Normal);
                        HistLinNom.SETRANGE(Periodo, DMY2DATE(1, DATE2DMY(HistCabNom.Periodo, 2), DATE2DMY(HistCabNom.Periodo, 3)), HistCabNom.Periodo);
                        HistLinNom.SETRANGE("Aplica para Regalia", TRUE);
                        IF HistLinNom.FINDSET THEN
                            REPEAT
                                LinEsqSalarial.RESET;
                                LinEsqSalarial.SETRANGE("No. empleado", "No.");
                                LinEsqSalarial.SETRANGE("Concepto salarial", HistLinNom."Concepto salarial");
                                LinEsqSalarial.FINDFIRST;
                                IF (ConfNominas."Concepto Sal. Base" = HistLinNom."Concepto salarial") AND
                                   (DATE2DMY(HistLinNom.Periodo, 1) > 1) THEN BEGIN
                                    IF (LinEsqSalarial."1ra Quincena" AND LinEsqSalarial."2da Quincena") OR
                                      (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Mensual) THEN
                                        UltIngresosxQuincena += HistLinNom.Total
                                    ELSE
                                        UltIngresosOtros += HistLinNom.Total;
                                END
                                ELSE
                                    IF (ConfNominas."Concepto Sal. Base" <> HistLinNom."Concepto salarial") THEN BEGIN
                                        IF LinEsqSalarial."1ra Quincena" AND LinEsqSalarial."2da Quincena" THEN
                                            UltIngresosxQuincena += HistLinNom.Total
                                        ELSE
                                            UltIngresosOtros += HistLinNom.Total;
                                    END;
                            UNTIL HistLinNom.NEXT = 0;


                        AcumuladoSalario := TotImporte;

                        IF Mes <> 12 THEN BEGIN
                            IF DATE2DMY(Contrato."Fecha inicio", 3) < Anotrabajo THEN BEGIN
                                IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) OR
                                   (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::"Bi-Semanal") THEN BEGIN
                                    TotNominas := CantidadDeNominas - TotNominas;
                                END
                                ELSE
                                    IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Semanal THEN
                                        TotNominas := CantidadDeNominas - TotNominas
                                    ELSE
                                        TotNominas := CantidadDeNominas - TotNominas;
                            END
                            ELSE BEGIN
                                IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) OR
                                   (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::"Bi-Semanal") THEN BEGIN
                                    TotNominas := (12 - Mes) * 2;
                                END
                                ELSE
                                    IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Semanal THEN BEGIN
                                        TotNominas := CantidadDeNominas - TotNominas;
                                        TotNominas := 52 - TotNominas;
                                    END
                                    ELSE BEGIN
                                        TotNominas := CantidadDeNominas - TotNominas;
                                        TotNominas := 12 - TotNominas;
                                    END;
                            END;

                            //Mes := 12 - Mes;
                            TotImporte := TotImporte + (UltIngresosxQuincena * TotNominas) + UltIngresosOtros;
                            AcumuladoSalario := TotImporte;
                            TotImporte := TotImporte / 12;
                        END
                        ELSE
                            IF ((Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) OR
                                (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::"Bi-Semanal")) AND
                                (Mes = 12) AND ((TotNominas = 11) OR (TotNominas = 23)) THEN
                                TotImporte := (TotImporte + UltIngresosxQuincena) / 12
                            ELSE
                                TotImporte /= 12;
                    END;
                END
                ELSE BEGIN
                    //Busco todas las nominas generadas
                    HistLinNom.RESET;
                    HistLinNom.SETCURRENTKEY("No. empleado", "Tipo concepto", Periodo, Total);
                    HistLinNom.SETRANGE("No. empleado", "No.");
                    HistLinNom.SETRANGE("Tipo nomina", HistLinNom."Tipo nomina"::Normal);
                    HistLinNom.SETRANGE(Periodo, DMY2DATE(1, 1, Anotrabajo), DMY2DATE(31, 12, Anotrabajo));
                    HistLinNom.SETRANGE("Aplica para Regalia", TRUE);
                    IF HistLinNom.FINDSET THEN
                        REPEAT
                            TotImporte += HistLinNom.Total;
                        UNTIL HistLinNom.NEXT = 0;
                    AcumuladoSalario := TotImporte;
                    TotImporte := TotImporte / 12;
                END;

                TotImporte := ROUND(TotImporte, 0.01);
                IF AplicarNomina THEN BEGIN
                    LinEsqSalarial.RESET;
                    LinEsqSalarial.SETRANGE("No. empleado", "No.");
                    LinEsqSalarial.SETRANGE("Concepto salarial", ConfNominas."Concepto Regalia");
                    LinEsqSalarial.FINDFIRST;
                    LinEsqSalarial.Cantidad := 1;
                    LinEsqSalarial.Importe := TotImporte;
                    LinEsqSalarial."Tipo nomina" := LinEsqSalarial."Tipo nomina"::Regalia;
                    LinEsqSalarial.MODIFY;
                END;
            end;

            trigger OnPreDataItem()
            begin
                ConfNominas.GET();
                TiposNom.RESET;
                TiposNom.SETRANGE("Tipo de nomina", TiposNom."Tipo de nomina"::Regular);
                TiposNom.FINDFIRST;

                IF AplicarNomina THEN
                    ConfNominas.TESTFIELD("Concepto Regalia");
                CurrReport.CREATETOTALS(TotImporte, AcumuladoSalario, AcumuladoAusencias);
                IF Anotrabajo = 0 THEN
                    ERROR(Err001);

                Fecha.RESET;
                Fecha.SETRANGE("Period Type", Fecha."Period Type"::Year);
                Fecha.SETRANGE("Period Start", DMY2DATE(1, 1, Anotrabajo));
                Fecha.FINDFIRST;

                IF (TiposNom."Dia inicio 1ra" <> 1) THEN
                    SETRANGE("Date Filter", DMY2DATE(TiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', Fecha."Period Start"), 2), DATE2DMY(CALCDATE('-1M', Fecha."Period Start"), 3)), DMY2DATE(TiposNom."Dia inicio 2da", 12, DATE2DMY(Fecha."Period Start", 3)))
                ELSE
                    SETRANGE("Date Filter", DMY2DATE(1, 1, DATE2DMY(NORMALDATE(Fecha."Period End"), 3)), DMY2DATE(31, 12, DATE2DMY(NORMALDATE(Fecha."Period End"), 3)));

                //Verifico que el historico tenga los datos segun la configuracion
                ConceptosSal.RESET;
                ConceptosSal.SETRANGE("Aplica para Regalia", TRUE);
                ConceptosSal.FINDSET;
                REPEAT
                    HistLinNom.RESET;
                    HistLinNom.SETRANGE("Concepto salarial", ConceptosSal.Codigo);
                    HistLinNom.SETFILTER(Periodo, GETFILTER("Date Filter"));
                    IF HistLinNom.FINDSET THEN
                        REPEAT
                            IF HistLinNom."Aplica para Regalia" <> ConceptosSal."Aplica para Regalia" THEN BEGIN
                                HistLinNom."Aplica para Regalia" := ConceptosSal."Aplica para Regalia";
                                HistLinNom.MODIFY;
                            END;
                        UNTIL HistLinNom.NEXT = 0;
                UNTIL ConceptosSal.NEXT = 0;
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
                field("Ano a generar"; Anotrabajo)
                {
                }
                field("Aplicar a nomina"; AplicarNomina)
                {
                }
                field("Proyecto salario 12"; "Proyectar salario 12")
                {
                    Caption = 'Estimate 12th salary';
                }
                field("Concepto Regalia"; ConfNominas."Concepto Regalia")
                {
                    TableRelation = "Conceptos salariales";
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
        ConfNominas: Record 34002103;
        LinEsqSalarial: Record 34002115;
        ConceptosSal: Record 34002111;
        Fecha: Record 2000000007;
        Contrato: Record 34002109;
        HistCabNom: Record 34002117;
        HistLinNom: Record 34002118;
        TiposNom: Record 34002158;
        FuncionesNom: Codeunit 34002104;
        TotImporte: Decimal;
        Anotrabajo: Integer;
        AplicarNomina: Boolean;
        ConceptoSal: Code[10];
        "Proyectar salario 12": Boolean;
        SalarioActual: Decimal;
        AcumuladoSalario: Decimal;
        AcumuladoAusencias: Decimal;
        TotEmpleados: Decimal;
        Err001: Label 'You must select the working year to do the calculation';
        Mes: Integer;
        TotNominas: Integer;
        Acumulado_de_regalia_por_empleadoCaptionLbl: Label 'Acumulado de regalia por empleado';
        CurrReport_PAGENOCaptionLbl: Label 'Pagina';
        TotImporteCaptionLbl: Label 'Regalia a pagar';
        AcumuladoSalarioCaptionLbl: Label 'Acumulado Regalia';
        Total_Gral_CaptionLbl: Label 'Total Gral.';
        UltIngresosxQuincena: Decimal;
        UltIngresosOtros: Decimal;
        CantidadDeNominas: Integer;
}

