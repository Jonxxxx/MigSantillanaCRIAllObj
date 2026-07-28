report 34002106 "Contabilizar Nominas - new"
{
    AdditionalSearchTerms = 'Post Payroll';
    ApplicationArea = Basic, Suite, BasicHR;
    Caption = 'Post Payroll';
    ProcessingOnly = true;
    UsageCategory = Tasks;

    dataset
    {
        dataitem("Cab. nomina"; 34002117)
        {
            DataItemTableView = SORTING("No. empleado", Ano, Periodo, "Tipo Nomina");
            RequestFilterFields = "No. empleado", Periodo, "Frecuencia de pago", "Tipo de nomina";
            dataitem("Lin. nomina"; 34002118)
            {
                DataItemLink = "No. Documento" = FIELD("No. Documento"),
                               "No. empleado" = FIELD("No. empleado"),
                               "Tipo de nomina" = FIELD("Tipo de nomina"),
                               Periodo = FIELD(Periodo);
                DataItemTableView = SORTING("No. empleado", "Tipo nomina", Periodo, "No. Orden")
                                    WHERE("Concepto salarial" = FILTER(<> ''),
                                          Cantidad = FILTER(<> 0),
                                          Excluir de listados=CONST(false));

                trigger OnAfterGetRecord()
                var
                    NoCuenta: Code[20];
                    TotRecDistrib: Integer;
                    ImporteDistrib: Decimal;
                    DistribAcumulado: Decimal;
                    Secuencia: Integer;
                begin
                    IF NOT HayNominas THEN
                        EXIT;

                    CxCMod := FALSE;

                    CxCEmpl.SETRANGE("Employee No.", "No. empleado");
                    CxCEmpl.SETRANGE(Pendiente, TRUE);
                    IF CxCEmpl.FINDFIRST THEN;



                    ConceptosSalariales.GET("Concepto salarial");


                    //Del Historico de Nominas
                    IF GpoContEmpl.GET(Empleado."Posting Group") THEN BEGIN
                        ConfGpoContEmpl.RESET;
                        //    ConfGpoContEmpl.SETRANGE("Shortcut Dimension",ConfNomina."Dimension Conceptos Salariales");
                        ConfGpoContEmpl.SETRANGE(Codigo, GpoContEmpl.Codigo);
                        ConfGpoContEmpl.SETRANGE("Codigo Concepto Salarial", "Concepto salarial");
                        IF ConfGpoContEmpl.FINDFIRST THEN BEGIN
                            IF ConfGpoContEmpl."Tipo Cuenta Cuota Obrera" <> ConfGpoContEmpl."Tipo Cuenta Cuota Obrera"::Cliente THEN BEGIN
                                ConfGpoContEmpl.TESTFIELD("No. Cuenta Cuota Obrera");
                                NoCuenta := ConfGpoContEmpl."No. Cuenta Cuota Obrera";
                            END
                            ELSE BEGIN
                                Empleado.TESTFIELD("Codigo Cliente");
                                NoCuenta := Empleado."Codigo Cliente";
                                TipoCta := 2;
                            END;
                            CASE ConfGpoContEmpl."Tipo Cuenta Cuota Obrera" OF
                                0:
                                    TipoCta := 0;
                                ELSE
                                    TipoCta := 2;
                            END;

                            IF ConceptosSalariales."Validar Contrapartida CO" THEN BEGIN
                                ConfGpoContEmpl.TESTFIELD("No. Cuenta Contrapartida CO");
                                CASE ConfGpoContEmpl."Tipo Cuenta Contrapartida CO" OF
                                    0:
                                        TipoContrapartida := 0;
                                    ELSE
                                        TipoContrapartida := 2;
                                END;

                                NoCuentaContrapartida := ConfGpoContEmpl."No. Cuenta Contrapartida CO";
                            END;
                        END
                        ELSE
                            IF "Concepto salarial" <> ConfNomina."Concepto CxC Empl." THEN BEGIN
                                CASE ConceptosSalariales."Tipo Cuenta Cuota Obrera" OF
                                    0:
                                        TipoCta := 0;
                                    1:
                                        TipoCta := 2;
                                    ELSE
                                        TipoCta := 1;
                                END;

                                IF TipoCta <> 1 THEN  //Cliente
                                   BEGIN
                                    ConceptosSalariales.TESTFIELD("No. Cuenta Cuota Obrera");
                                    NoCuenta := ConceptosSalariales."No. Cuenta Cuota Obrera";
                                END;

                                IF ConceptosSalariales."Validar Contrapartida CO" THEN BEGIN
                                    ConceptosSalariales.TESTFIELD("No. Cuenta Contrapartida CO");
                                    CASE ConceptosSalariales."Tipo Cuenta Contrapartida CO" OF
                                        0:
                                            TipoContrapartida := 0;
                                        ELSE
                                            TipoContrapartida := 2;
                                    END;

                                    NoCuentaContrapartida := ConceptosSalariales."No. Cuenta Contrapartida CO";
                                END;
                            END;
                    END
                    ELSE BEGIN
                        ConceptosSalariales.GET("Concepto salarial");
                        CASE ConceptosSalariales."Tipo Cuenta Cuota Obrera" OF
                            0:
                                TipoCta := 0;
                            1:
                                TipoCta := 2;
                            ELSE
                                TipoCta := 1;
                        END;

                        IF TipoCta <> 1 THEN  //Cliente
                           BEGIN
                            ConceptosSalariales.TESTFIELD("No. Cuenta Cuota Obrera");
                            NoCuenta := ConceptosSalariales."No. Cuenta Cuota Obrera";
                        END;

                        IF ConceptosSalariales."Validar Contrapartida CO" THEN BEGIN
                            ConceptosSalariales.TESTFIELD("No. Cuenta Contrapartida CO");
                            CASE ConceptosSalariales."Tipo Cuenta Contrapartida CO" OF
                                0:
                                    TipoContrapartida := 0;
                                ELSE
                                    TipoContrapartida := 2;
                            END;

                            NoCuentaContrapartida := ConceptosSalariales."No. Cuenta Contrapartida CO";
                        END;

                        IF "Concepto salarial" = ConfNomina."Concepto CxC Empl." THEN BEGIN
                            TipoCta := 1;
                            NoCuenta := Empleado."Codigo Cliente";
                        END;

                        //Para salir del paso en Hemingway
                        IF ("Concepto salarial" = ConfNomina."Concepto CxC Empl.") OR
                           (ConceptosSalariales."Tipo Cuenta Cuota Obrera" = 2) OR
                          (("Concepto salarial" = '212') OR ("Concepto salarial" = '213') OR ("Concepto salarial" = '214') OR ("Concepto salarial" = '215')) THEN BEGIN
                            TipoCta := 1;
                            IF ConceptosSalariales."No. Cuenta Cuota Obrera" <> '' THEN
                                NoCuenta := ConceptosSalariales."No. Cuenta Cuota Obrera"
                            ELSE BEGIN
                                Empleado.TESTFIELD("Codigo Cliente");
                                NoCuenta := Empleado."Codigo Cliente";
                            END;
                        END;

                    END;


                    //MESSAGE('%1 %2',RelEmpWorkType."Employee No.", "Cab. nomina"."No. empleado");
                    //Para la distribucion % del concepto salarial entre diferentes valores de Dim.
                    TotRecDistrib := 0;
                    DistribAcumulado := 0;
                    ImporteDistrib := Total;
                    Secuencia := 0;

                    DistribEDEmp.RESET;
                    DistribEDEmp.SETRANGE("Employee no.", Empleado."No.");
                    DistribEDEmp.SETRANGE("Concepto salarial", "Concepto salarial");
                    TotRecDistrib := DistribEDEmp.COUNT;
                    IF DistribEDEmp.FINDSET THEN
                        REPEAT
                            Secuencia += 1;
                            IF TotRecDistrib = Secuencia THEN
                                Total := ROUND(ImporteDistrib - DistribAcumulado, 0.01)
                            ELSE BEGIN
                                Total := ROUND(ImporteDistrib * DistribEDEmp."% a distribuir" / 100, 0.01);
                                DistribAcumulado += Total;
                            END;

                            //Para los que son de proyectos
                            IF (gDCA."Cod. Empleado" = "Cab. nomina"."No. empleado") AND ("Cab. nomina"."Tipo Nomina" = "Cab. nomina"."Tipo Nomina"::Normal) THEN BEGIN
                                IF ("Tipo concepto" = "Tipo concepto"::Ingresos) OR
                                   (("Concepto salarial" <> ConfNomina."Concepto ISR") AND ("Concepto salarial" <> ConfNomina."Concepto AFP") AND
                                   ("Concepto salarial" <> ConfNomina."Concepto SFS") AND ("Concepto salarial" <> ConfNomina."Concepto INFOTEP")) THEN BEGIN
                                    LlenaDatosCOjOB("Concepto salarial", TipoCta, NoCuenta, Total, FALSE, "No. empleado");
                                    IF ConceptosSalariales."Validar Contrapartida CO" THEN
                                        LlenaDatosCOjOB("Concepto salarial", TipoContrapartida, NoCuentaContrapartida, Total, TRUE,
                                                 "No. empleado");
                                END;
                            END
                            ELSE BEGIN
                                LlenaDatosCO("Concepto salarial", TipoCta, NoCuenta, Total, FALSE, "No. empleado");
                                //Para los que son de proyectos
                                IF ConceptosSalariales."Validar Contrapartida CO" THEN
                                    LlenaDatosCO("Concepto salarial", TipoContrapartida, NoCuentaContrapartida, Total, TRUE,
                                                 "No. empleado");
                            END;
                        UNTIL DistribEDEmp.NEXT = 0
                    ELSE BEGIN
                        //Para los que son de proyectos
                        IF (gDCA."Cod. Empleado" = "Cab. nomina"."No. empleado") AND ("Cab. nomina"."Tipo Nomina" = "Cab. nomina"."Tipo Nomina"::Normal) THEN BEGIN
                            IF ("Tipo concepto" = "Tipo concepto"::Ingresos) OR
                               (("Concepto salarial" <> ConfNomina."Concepto ISR") AND ("Concepto salarial" <> ConfNomina."Concepto AFP") AND
                               ("Concepto salarial" <> ConfNomina."Concepto SFS") AND ("Concepto salarial" <> ConfNomina."Concepto INFOTEP")) THEN BEGIN
                                LlenaDatosCOjOB("Concepto salarial", TipoCta, NoCuenta, Total, FALSE, "No. empleado");
                                IF ConceptosSalariales."Validar Contrapartida CO" THEN
                                    LlenaDatosCOjOB("Concepto salarial", TipoContrapartida, NoCuentaContrapartida, Total, TRUE,
                                             "No. empleado");
                            END;
                        END
                        ELSE BEGIN
                            LlenaDatosCO("Concepto salarial", TipoCta, NoCuenta, Total, FALSE, "No. empleado");
                            //Para los que son de proyectos
                            IF ConceptosSalariales."Validar Contrapartida CO" THEN
                                LlenaDatosCO("Concepto salarial", TipoContrapartida, NoCuentaContrapartida, Total, TRUE,
                                             "No. empleado");
                        END;
                    END;

                    InsertaAporteCooperativa("Lin. nomina");
                    InsertaDescCooperativa("Lin. nomina");

                    CLEAR(NoCuenta);
                    CLEAR(TipoCta);
                    CLEAR(NoCuentaContrapartida);
                    CLEAR(TipoContrapartida);
                end;

                trigger OnPostDataItem()
                var
                    ProvJob: Record 34002119;
                begin
                    IF (gDCA."Cod. Empleado" = "Cab. nomina"."No. empleado") AND ("Cab. nomina"."Tipo Nomina" = "Cab. nomina"."Tipo Nomina"::Normal) THEN BEGIN
                        CalcularDtosCOTSSJob(DATE2DMY(inicial, 3), "Cab. nomina"."No. empleado"); //Para calcular TSS
                        CalcularISRJob(DATE2DMY(inicial, 3), "Cab. nomina"."No. empleado"); //Para calcular ISR
                        CalcularDtosCPTSSJob(DATE2DMY(inicial, 3), "Cab. nomina"."No. empleado"); //Para calcular Cuotas Patronales
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    IF NOT HayNominas THEN
                        EXIT;

                    CxCEmpl.RESET;
                    CxCEmpl.SETCURRENTKEY("Employee No.", Pendiente);

                    SETFILTER("Job No.", "Cab. nomina".GETFILTER("Job No."));
                end;
            }
            dataitem(Prorrata; 34002115)
            {
                DataItemLink = "No. empleado" = FIELD("No. empleado");
                DataItemTableView = SORTING("No. empleado", "Perfil salarial", "Concepto salarial", Cargo)
                                    WHERE(Prorratear = CONST(true));
                dataitem("Conceptos Salariales Provision"; 34002119)
                {
                    DataItemLink = Codigo = FIELD("Concepto salarial");
                    DataItemTableView = SORTING(Codigo, "Gpo. Contable Empleado");

                    trigger OnAfterGetRecord()
                    var
                        ConceptosProrr: Record 34002119;
                        ConceptosFormula: Record 34002144;
                        PS: Record 34002115;
                        Fecha: Record 2000000007;
                        TempHistLinNom: Record 34002118 temporary;
                        Acumulado: Decimal;
                        FechaFin: Date;
                        CantEmpl: Integer;
                        DiasVacaciones: Decimal;
                        MontoVacaciones: Decimal;
                        Diastxt: Text[30];
                        FIni: Date;
                        Acumulado2: Decimal;
                    begin
                        IF "Cab. nomina"."Tipo Nomina" <> "Cab. nomina"."Tipo Nomina"::Normal THEN
                            CurrReport.SKIP;

                        Empleado.GET("Lin. nomina"."No. empleado");
                        IF GpoContable.GET(Empleado."Posting Group") THEN
                            IF GpoContEmpl."Excluir contabilizacion" THEN
                                CurrReport.SKIP;

                        Acumulado := 0;
                        CLEAR(HistLinNom);
                        HistLinNom.RESET;
                        HistLinNom.SETCURRENTKEY("No. empleado", "Tipo concepto", Periodo, "Concepto salarial");
                        HistLinNom.SETRANGE("No. empleado", "Cab. nomina"."No. empleado");
                        HistLinNom.SETRANGE(Periodo, "Cab. nomina".Periodo);
                        HistLinNom.SETRANGE("Concepto salarial", Codigo);
                        IF "Cab. nomina".GETFILTER("Job No.") <> '' THEN
                            HistLinNom.SETFILTER("Job No.", "Cab. nomina".GETFILTER("Job No."));
                        IF HistLinNom.FINDSET THEN
                            REPEAT
                                Acumulado += HistLinNom.Total;
                            UNTIL HistLinNom.NEXT = 0;

                        Empleado.Salario := 0;
                        CLEAR(HistLinNom);
                        HistLinNom.RESET;
                        HistLinNom.SETCURRENTKEY("No. empleado", "Tipo concepto", Periodo, "Concepto salarial");
                        HistLinNom.SETRANGE("No. empleado", "Cab. nomina"."No. empleado");
                        HistLinNom.SETRANGE(Periodo, "Cab. nomina".Periodo);
                        //HistLinNom.SETRANGE("Concepto salarial",Codigo);
                        IF "Cab. nomina".GETFILTER("Job No.") <> '' THEN
                            HistLinNom.SETFILTER("Job No.", "Cab. nomina".GETFILTER("Job No."));
                        HistLinNom.SETRANGE("Salario Base", TRUE);
                        IF HistLinNom.FINDSET THEN
                            REPEAT
                                Empleado.Salario += HistLinNom.Total;
                            UNTIL HistLinNom.NEXT = 0
                        ELSE
                            Empleado.CALCFIELDS(Salario);

                        Acumulado /= 12;
                        CASE ConfNomina."Nomina de Pais" OF
                            'BO':
                                BEGIN
                                    IF Empleado."Employment Date" = 0D THEN
                                        ERROR(Err001, Empleado.FIELDCAPTION("Employment Date"), Empleado.TABLECAPTION, Empleado."No.");

                                    CalculoFechas.CalculoEntreFechas(Empleado."Employment Date", final, Anos, Meses, Dias);

                                    IF ConfNomina."Concepto Incentivos" = Codigo THEN BEGIN
                                        Empleado.Salario := 0;
                                        Acumulado2 := 0;

                                        //Se busca el acumulado de los 3 ultimos meses
                                        FIni := DMY2DATE(1, DATE2DMY(CALCDATE('-3M', "Cab. nomina".Periodo), 2), DATE2DMY(CALCDATE('-3M', "Cab. nomina".Periodo), 3));
                                        CLEAR(HistLinNom);
                                        HistLinNom.RESET;
                                        HistLinNom.SETCURRENTKEY("No. empleado", "Tipo concepto", Periodo, "Concepto salarial");
                                        HistLinNom.SETRANGE("No. empleado", "Cab. nomina"."No. empleado");
                                        HistLinNom.SETRANGE(Periodo, FIni, CALCDATE('-1D', "Cab. nomina".Periodo));
                                        IF "Cab. nomina".GETFILTER("Job No.") <> '' THEN
                                            HistLinNom.SETFILTER("Job No.", "Cab. nomina".GETFILTER("Job No."));
                                        HistLinNom.SETRANGE("Aplica para Regalia", TRUE);
                                        //        MESSAGE('%1',HistLinNom.GETFILTERS);
                                        IF HistLinNom.FINDSET THEN
                                            REPEAT
                                                Empleado.Salario += HistLinNom.Total;
                                            UNTIL HistLinNom.NEXT = 0;

                                        //Se calculan los dias transcurridos al presente periodo y hasta el mes anterior
                                        IF Empleado."Fecha despues quinquenios" <> 0D THEN BEGIN
                                            DiasVacaciones := final - Empleado."Fecha despues quinquenios";
                                            Dias := CALCDATE('-1D', inicial) - Empleado."Fecha despues quinquenios";
                                        END
                                        ELSE BEGIN
                                            DiasVacaciones := final - Empleado."Employment Date";
                                            Dias := CALCDATE('-1D', inicial) - Empleado."Employment Date";
                                        END;

                                        //Salario promedio de los ultimos 3 meses
                                        Empleado.Salario /= 3;

                                        //Importe de Indemnizacion acumulada actual
                                        MontoVacaciones := ROUND((Empleado.Salario * Dias / 365), 0.01);
                                        //        error('%1\ %2\ %3\ %4\ %5',empleado.salario,diasvacaciones,montovacaciones,final,Empleado."Employment Date");
                                        //Importe de Indemnizacion acumulada mes anterior

                                        FIni := DMY2DATE(1, DATE2DMY(CALCDATE('-2M', inicial), 2), DATE2DMY(CALCDATE('-2M', inicial), 3));
                                        CLEAR(HistLinNom);
                                        CLEAR(Empleado.Salario);
                                        HistLinNom.SETCURRENTKEY("No. empleado", "Tipo concepto", Periodo, "Concepto salarial");
                                        HistLinNom.SETRANGE("No. empleado", "Cab. nomina"."No. empleado");
                                        HistLinNom.SETRANGE(Periodo, FIni, "Cab. nomina".GETRANGEMAX(Periodo));
                                        HistLinNom.SETRANGE("Aplica para Regalia", TRUE);
                                        //        message('%1',histlinnom.getfilters);
                                        IF HistLinNom.FINDSET THEN
                                            REPEAT
                                                Empleado.Salario += HistLinNom.Total;
                                            UNTIL HistLinNom.NEXT = 0;

                                        //Salario promedio de los ultimos 3 meses
                                        Empleado.Salario /= 3;

                                        Acumulado2 := ROUND((Empleado.Salario * DiasVacaciones / 365), 0.01);

                                        Acumulado := ROUND(Acumulado2 - MontoVacaciones, 0.01);
                                        //        ERROR('aa%1 %2 %3 %4',Acumulado,Acumulado2,MontoVacaciones);
                                        //message('Ind %1 %2 %3 %4 %5',acumulado,montovacaciones,acumulado2,DIAS,DIASVACACIONES);
                                    END
                                    ELSE
                                        IF ConfNomina."Concepto Regalia" = Codigo THEN BEGIN
                                            Empleado.Salario := 0;
                                            Acumulado2 := 0;

                                            //Se busca el acumulado de los 3 ultimos meses
                                            FIni := DMY2DATE(1, DATE2DMY(CALCDATE('-3M', "Cab. nomina".Periodo), 2), DATE2DMY(CALCDATE('-3M', "Cab. nomina".Periodo), 3));
                                            CLEAR(HistLinNom);
                                            HistLinNom.RESET;
                                            HistLinNom.SETCURRENTKEY("No. empleado", "Tipo concepto", Periodo, "Concepto salarial");
                                            HistLinNom.SETRANGE("No. empleado", "Cab. nomina"."No. empleado");
                                            HistLinNom.SETRANGE(Periodo, FIni, CALCDATE('-1D', "Cab. nomina".Periodo));
                                            HistLinNom.SETRANGE("Aplica para Regalia", TRUE);
                                            IF HistLinNom.FINDSET THEN
                                                REPEAT
                                                    Empleado.Salario += HistLinNom.Total;
                                                UNTIL HistLinNom.NEXT = 0;

                                            //Se calculan los dias transcurridos al presente periodo y hasta el mes anterior

                                            IF Anos <> 0 THEN BEGIN
                                                DiasVacaciones := final - DMY2DATE(1, 1, DATE2DMY(final, 3));
                                                Dias := CALCDATE('-1D', inicial) - DMY2DATE(1, 1, DATE2DMY(final, 3));
                                            END
                                            ELSE BEGIN
                                                DiasVacaciones := final - DMY2DATE(1, DATE2DMY(Empleado."Employment Date", 2), DATE2DMY(Empleado."Employment Date", 3));
                                                Dias := CALCDATE('-1D', inicial) - DMY2DATE(1, DATE2DMY(Empleado."Employment Date", 2),
                                                                  DATE2DMY(Empleado."Employment Date", 3));
                                            END;

                                            //Salario promedio de los ultimos 3 meses
                                            Empleado.Salario /= 3;

                                            //Importe de regalia acumulada actual
                                            MontoVacaciones := ROUND((Empleado.Salario * Dias / 365), 0.01);

                                            //Importe de regalia acumulada mes anterior

                                            FIni := DMY2DATE(1, DATE2DMY(CALCDATE('-2M', "Cab. nomina".Periodo), 2),
                                                              DATE2DMY(CALCDATE('-2M', "Cab. nomina".Periodo), 3));

                                            CLEAR(HistLinNom);
                                            CLEAR(Empleado.Salario);
                                            HistLinNom.SETCURRENTKEY("No. empleado", "Tipo concepto", Periodo, "Concepto salarial");
                                            HistLinNom.SETRANGE("No. empleado", "Cab. nomina"."No. empleado");
                                            HistLinNom.SETRANGE(Periodo, FIni, "Cab. nomina".GETRANGEMAX(Periodo));
                                            HistLinNom.SETRANGE("Aplica para Regalia", TRUE);
                                            IF HistLinNom.FINDSET THEN
                                                REPEAT
                                                    Empleado.Salario += HistLinNom.Total;
                                                UNTIL HistLinNom.NEXT = 0;

                                            //Salario promedio de los ultimos 3 meses
                                            Empleado.Salario /= 3;
                                            Acumulado2 := ROUND((Empleado.Salario * DiasVacaciones / 365), 0.01);

                                            Acumulado := ROUND(Acumulado2 - MontoVacaciones, 0.01);

                                            //        ERROR('bb %1 %2 %3 %4 %5',Acumulado,MontoVacaciones,Acumulado2,Dias,DiasVacaciones);
                                            //        message('reg %1 %2 %3 %4 %5',acumulado,montovacaciones,acumulado2,DIAS,DIASVACACIONES);
                                        END;
                                END;
                            'DO':
                                BEGIN
                                    CASE "Tipo provision" OF
                                        0: //Variable
                                            BEGIN
                                                IF ConfNomina."Concepto Vacaciones" = Codigo THEN BEGIN
                                                    Acumulado := ProvisionaVacaciones;
                                                END
                                                ELSE
                                                    IF ConfNomina."Concepto Regalia" = Codigo THEN BEGIN
                                                        Acumulado := ProvisionaRegalia;
                                                    END
                                                    ELSE
                                                        IF ConfNomina."Concepto Bonificacion" = Codigo THEN BEGIN
                                                            Acumulado := ProvisionaBonificacion;
                                                        END
                                            END;
                                        1://Fijo
                                            BEGIN
                                            END;
                                        2: //Formula
                                            BEGIN
                                                /*
                                               PS.RESET;
                                               PS.SETRANGE("No. empleado",Empleado."No.");
                                               PS.SETRANGE("Concepto salarial",Codigo);
                                               PS.FINDFIRST;
                                               PS.VALIDATE("F´Š¢rmula Calculo","F´Š¢rmula Calculo");
                                               Acumulado         := PS.Importe;
                                               */
                                                ConceptosFormula.FIND('-');
                                                ConceptosFormula.DELETEALL;
                                                TempHistLinNom.RESET;
                                                TempHistLinNom.VALIDATE("No. empleado", Empleado."No.");
                                                TempHistLinNom.VALIDATE("Concepto salarial", Codigo);
                                                TempHistLinNom.VALIDATE(Periodo, inicial);
                                                TempHistLinNom.VALIDATE(F´Š¢rmula, "F´Š¢rmula Calculo");

                                                Acumulado := TempHistLinNom.Total;
                                                /*
                                                IF DiasTranscurridos < 25 THEN
                                                  BEGIN
                                                    IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) OR
                                                       (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::"Bi-Semanal") THEN
                                                        Acumulado /= 2
                                                  END;
                                                 */
                                            END;
                                    END;
                                END;
                            'GT':
                                BEGIN
                                    CASE "Tipo provision" OF
                                        0:
                                            ; //Variable
                                        1:
                                            ; //Fijo
                                        2: //F´Š¢rmula
                                            BEGIN
                                                PS.RESET;
                                                PS.SETRANGE("No. empleado", Empleado."No.");
                                                PS.SETRANGE("Concepto salarial", Codigo);
                                                PS.FINDFIRST;
                                                PS.VALIDATE("F´Š¢rmula Calculo", "F´Š¢rmula Calculo");
                                                Acumulado := PS.Importe;
                                            END;
                                    END;
                                END;
                            'EC':
                                BEGIN
                                    CASE "Tipo provision" OF
                                        0: //Variable
                                            BEGIN
                                                PS.RESET;
                                                PS.SETRANGE("No. empleado", Empleado."No.");
                                                PS.SETRANGE("Concepto salarial", Codigo);
                                                PS.FINDFIRST;

                                                IF Empleado."Fin contrato" <> 0D THEN BEGIN
                                                    IF (((DATE2DMY(Empleado."Employment Date", 2) = DATE2DMY(FechaRegistro, 2)) AND
                                                         (DATE2DMY(Empleado."Employment Date", 3) = DATE2DMY(FechaRegistro, 3)))) AND
                                                       (((DATE2DMY(Empleado."Fin contrato", 2) = DATE2DMY(FechaRegistro, 2)) AND
                                                         (DATE2DMY(Empleado."Fin contrato", 3) = DATE2DMY(FechaRegistro, 3)))) THEN BEGIN
                                                        CalculoFechas.CalculoEntreFechas(Empleado."Employment Date", Empleado."Fin contrato", Anos, Meses, Dias);
                                                    END
                                                    ELSE
                                                        IF (((DATE2DMY(Empleado."Fin contrato", 2) = DATE2DMY(FechaRegistro, 2)) AND
                                                             (DATE2DMY(Empleado."Fin contrato", 3) = DATE2DMY(FechaRegistro, 3)))) AND
                                                             (Empleado."Fin contrato" <> 0D) THEN BEGIN
                                                            Dias := DATE2DMY(Empleado."Fin contrato", 1);
                                                            IF DATE2DMY(FechaRegistro, 2) = 2 THEN
                                                                Dias := 30 - Dias;
                                                        END;
                                                END
                                                ELSE
                                                    IF (((DATE2DMY(Empleado."Employment Date", 2) = DATE2DMY(FechaRegistro, 2)) AND
                                                         (DATE2DMY(Empleado."Employment Date", 3) = DATE2DMY(FechaRegistro, 3)) AND
                                                         (Empleado."Fin contrato" = 0D))) THEN BEGIN
                                                        Dias := DATE2DMY(Empleado."Employment Date", 1);
                                                        IF DATE2DMY(FechaRegistro, 2) = 2 THEN
                                                            Dias := 30 - Dias;
                                                        IF (Dias > 30) OR (Dias = 0) THEN
                                                            Dias := 30;
                                                    END
                                                    ELSE
                                                        CalculoFechas.CalculoEntreFechas(Empleado."Employment Date", final, Anos, Meses, Dias);
                                                IF (Anos >= 1) OR (Meses >= 1) THEN
                                                    Dias := 30;
                                                //         message('%1 %2 %3 %4',empleado."no.",dias,meses,anos);
                                                PS.Importe := ConfNomina."Salario Minimo" / 360;
                                                PS.Importe *= Dias;
                                                Acumulado := ROUND(PS.Importe, ConfContabilidad."Amount Rounding Precision");
                                            END;

                                        1: //Fijo
                                            BEGIN
                                                PS.RESET;
                                                PS.SETRANGE("No. empleado", Empleado."No.");
                                                PS.SETRANGE("Concepto salarial", Codigo);
                                                PS.FINDFIRST;
                                                IF Empleado."Fin contrato" <> 0D THEN BEGIN
                                                    IF (((DATE2DMY(Empleado."Employment Date", 2) = DATE2DMY(FechaRegistro, 2)) AND
                                                         (DATE2DMY(Empleado."Employment Date", 3) = DATE2DMY(FechaRegistro, 3)))) AND
                                                       (((DATE2DMY(Empleado."Fin contrato", 2) = DATE2DMY(FechaRegistro, 2)) AND
                                                         (DATE2DMY(Empleado."Fin contrato", 3) = DATE2DMY(FechaRegistro, 3)))) THEN BEGIN
                                                        CalculoFechas.CalculoEntreFechas(Empleado."Employment Date", Empleado."Fin contrato", Anos, Meses, Dias);
                                                        EVALUATE(PS.Importe, "F´Š¢rmula Calculo");
                                                        Acumulado := ROUND((PS.Importe / 30) * Dias, ConfContabilidad."Amount Rounding Precision");
                                                    END
                                                    ELSE
                                                        IF (((DATE2DMY(Empleado."Fin contrato", 2) = DATE2DMY(FechaRegistro, 2)) AND
                                                             (DATE2DMY(Empleado."Fin contrato", 3) = DATE2DMY(FechaRegistro, 3)))) AND
                                                             (Empleado."Fin contrato" <> 0D) THEN BEGIN
                                                            Dias := DATE2DMY(Empleado."Fin contrato", 1);
                                                            IF DATE2DMY(FechaRegistro, 2) = 2 THEN
                                                                Dias := 30 - Dias + 1;

                                                            EVALUATE(PS.Importe, "F´Š¢rmula Calculo");
                                                            Acumulado := ROUND((PS.Importe / 30) * Dias, ConfContabilidad."Amount Rounding Precision");
                                                        END;
                                                END
                                                ELSE
                                                    IF (((DATE2DMY(Empleado."Employment Date", 2) = DATE2DMY(FechaRegistro, 2)) AND
                                                         (DATE2DMY(Empleado."Employment Date", 3) = DATE2DMY(FechaRegistro, 3)) AND
                                                         (Empleado."Fin contrato" = 0D))) THEN BEGIN
                                                        Dias := DATE2DMY(Empleado."Employment Date", 1);
                                                        //             IF DATE2DMY(FechaRegistro,2) = 2 THEN
                                                        Dias := 30 - Dias + 1;

                                                        EVALUATE(PS.Importe, "F´Š¢rmula Calculo");
                                                        Acumulado := ROUND((PS.Importe / 30) * Dias, ConfContabilidad."Amount Rounding Precision");
                                                    END
                                                    ELSE BEGIN
                                                        EVALUATE(Acumulado, "F´Š¢rmula Calculo");
                                                    END;
                                                //            message('%1 %2 %3 %4 %5',dias,Empleado."Employment Date",fecharegistro);
                                            END;
                                        2: //F´Š¢rmula
                                            BEGIN
                                                PS.RESET;
                                                PS.SETRANGE("No. empleado", Empleado."No.");
                                                PS.SETRANGE("Concepto salarial", Codigo);
                                                PS.FINDFIRST;
                                                PS.VALIDATE("F´Š¢rmula Calculo", "F´Š¢rmula Calculo");
                                                Acumulado := PS.Importe;
                                            END;
                                    END;
                                END;
                            'PY':
                                BEGIN
                                    CASE "Tipo provision" OF
                                        0:
                                            ; //Variable
                                        1:
                                            ; //Fijo
                                        2: //F´Š¢rmula
                                            BEGIN
                                                PS.RESET;
                                                PS.SETRANGE("No. empleado", Empleado."No.");
                                                PS.SETRANGE("Concepto salarial", Codigo);
                                                PS.FINDFIRST;
                                                PS.VALIDATE("F´Š¢rmula Calculo", "F´Š¢rmula Calculo");
                                                Acumulado := PS.Importe;
                                            END;
                                    END;
                                END;
                            'HN':
                                BEGIN
                                    CASE "Tipo provision" OF
                                        0:
                                            ; //Variable
                                        1:
                                            ; //Fijo
                                        2: //F´Š¢rmula
                                            BEGIN
                                                PS.RESET;
                                                PS.SETRANGE("No. empleado", Empleado."No.");
                                                PS.SETRANGE("Concepto salarial", Codigo);
                                                PS.FINDFIRST;
                                                PS.VALIDATE("F´Š¢rmula Calculo", "F´Š¢rmula Calculo");
                                                Acumulado := PS.Importe;
                                            END;
                                    END;
                                END;
                            'PR':
                                BEGIN
                                    CASE "Tipo provision" OF
                                        0: //Variable
                                            BEGIN
                                                IF Empleado."Employment Date" = 0D THEN
                                                    ERROR(Err001, Empleado.FIELDCAPTION("Employment Date"), Empleado.TABLECAPTION, Empleado."No.");

                                                DiasVacaciones := CalculoFechas.CalculoDiaVacaciones(Empleado."No.", DATE2DMY(Empleado."Employment Date", 2),
                                                                                                     DATE2DMY(WORKDATE, 3), MontoVacaciones, Empleado."Employment Date", final);
                                                Empleado.Salario /= 23.83;
                                                MontoVacaciones := (Empleado.Salario * DiasVacaciones) / 12;
                                                Acumulado := MontoVacaciones;

                                            END;
                                        1:
                                            ; //Fijo
                                        2: //F´Š¢rmula
                                            BEGIN
                                                PS.RESET;
                                                PS.SETRANGE("No. empleado", Empleado."No.");
                                                PS.SETRANGE("Concepto salarial", Codigo);
                                                PS.FINDFIRST;
                                                PS.VALIDATE("F´Š¢rmula Calculo", "F´Š¢rmula Calculo");
                                                Acumulado := PS.Importe;
                                            END;
                                    END;

                                END;
                        END;

                        IF Acumulado <> 0 THEN BEGIN
                            IF (gDCA."Cod. Empleado" = "Cab. nomina"."No. empleado") AND ("Cab. nomina"."Tipo Nomina" = "Cab. nomina"."Tipo Nomina"::Normal) THEN
                                InsertaProvisionJob(Codigo, Acumulado)
                            ELSE
                                InsertaProvision(Codigo, Acumulado);
                        END;

                    end;

                    trigger OnPreDataItem()
                    begin
                        IF "Cab. nomina"."Tipo Nomina" <> "Cab. nomina"."Tipo Nomina"::Normal THEN
                            CurrReport.SKIP;

                        "Conceptos Salariales Provision".SETRANGE(Codigo, Prorrata."Concepto salarial");
                        IF Empleado."Posting Group" <> '' THEN
                            "Conceptos Salariales Provision".SETRANGE("Gpo. Contable Empleado", Empleado."Posting Group");
                    end;
                }

                trigger OnPreDataItem()
                begin
                    Prorrata.SETRANGE("No. empleado", "Cab. nomina"."No. empleado");
                    Prorrata.SETRANGE(Prorratear, TRUE);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF NOT "Repetir Contabiliz." THEN
                    IF "No. Contabilizacion" <> '' THEN BEGIN
                        HayNominas := FALSE;
                        EXIT;
                    END;

                Contador := Contador + 1;
                Ventana.UPDATE(1, ROUND(Contador / AModificar * 10000, 1));

                Empleado.GET("No. empleado");
                Empresa.GET(Empleado.Company);

                IF NumDoc = '' THEN
                    NumDoc := GestNumSerie.GetNextNo(ConfNomina."No. serie nominas", final, TRUE);

                "No. Contabilizacion" := NumDoc;
                MODIFY();
                HayNominas := TRUE;

                Contrato.RESET;
                Contrato.SETRANGE("No. empleado", Empleado."No.");
                Contrato.FINDLAST;

                gDCA.RESET;
                gDCA.SETRANGE("Cod. Empleado", "No. empleado");
                IF GETFILTER("Job No.") <> '' THEN
                    gDCA.SETFILTER("Job No.", GETFILTER("Job No."));
                IF NOT gDCA.FINDFIRST THEN
                    gDCA.INIT;
            end;

            trigger OnPreDataItem()
            begin
                IF FechaRegistro = 0D THEN
                    ERROR('Debe entrar fecha de registro');

                IF CodSeccion = '' THEN
                    ERROR('Favor de introducir la seccion del diario');
                /*
                IF NOT "Repetir Contabiliz." THEN
                  "Cab. nomina".SETRANGE("No. Contabilizacion",'');
                */
                AModificar := COUNT;

                Ventana.OPEN(Text003);

                Contador := 0;
                Contador2 := 0;
                NoLinea := 0;

                ConfNomina.GET();
                Tiposdenominas.GET("Cab. nomina".GETRANGEMIN("Tipo de nomina"));

            end;
        }
        dataitem("Historico Cab. nomina"; 34002117)
        {
            DataItemTableView = SORTING("No. empleado", Ano, Periodo, "Tipo de nomina");
            dataitem("Lin. Aportes Empresas"; 34002122)
            {
                DataItemLink = "No. Empleado" = FIELD("No. empleado"),
                               Periodo = FIELD(Periodo),
                               "Tipo de nomina" = FIELD("Tipo de nomina");
                DataItemTableView = SORTING("No. Documento", "No. Empleado", "No. orden");

                trigger OnAfterGetRecord()
                var
                    NoCuenta: Code[20];
                begin
                    IF NOT HayNominas THEN
                        EXIT;

                    Empleado.GET("No. Empleado");

                    ConceptosSalariales.GET("Concepto Salarial");

                    //Del Historico de Cuota Patronal
                    IF GpoContEmpl.GET(Empleado."Posting Group") THEN BEGIN
                        //    ConfGpoContEmpl.SETRANGE("Shortcut Dimension",ConfNomina."Dimension Conceptos Salariales");
                        ConfGpoContEmpl.RESET;
                        ConfGpoContEmpl.SETRANGE(Codigo, GpoContEmpl.Codigo);
                        ConfGpoContEmpl.SETRANGE("Codigo Concepto Salarial", "Concepto Salarial");
                        IF ConfGpoContEmpl.FINDFIRST THEN BEGIN
                            ConfGpoContEmpl.TESTFIELD("No. Cuenta Cuota Patronal");
                            NoCuenta := ConfGpoContEmpl."No. Cuenta Cuota Patronal";
                            CASE ConfGpoContEmpl."Tipo Cuenta Cuota Patronal" OF
                                0:
                                    TipoCta := 0;
                                ELSE
                                    TipoCta := 2;
                            END;

                            IF ConceptosSalariales."Validar Contrapartida CP" THEN BEGIN
                                ConfGpoContEmpl.TESTFIELD("No. Cuenta Contrapartida CP");
                                CASE ConfGpoContEmpl."Tipo Cuenta Contrapartida CP" OF
                                    0:
                                        TipoContrapartida := 0;
                                    ELSE
                                        TipoContrapartida := 2;
                                END;

                                NoCuentaContrapartida := ConfGpoContEmpl."No. Cuenta Contrapartida CP";
                            END;
                        END
                        ELSE BEGIN
                            CASE ConceptosSalariales."Tipo Cuenta Cuota Patronal" OF
                                0:
                                    TipoCta := 0;
                                ELSE
                                    TipoCta := 2;
                            END;
                            ConceptosSalariales.TESTFIELD("No. Cuenta Cuota Patronal");
                            NoCuenta := ConceptosSalariales."No. Cuenta Cuota Patronal";
                            IF ConceptosSalariales."Validar Contrapartida CP" THEN BEGIN
                                ConceptosSalariales.TESTFIELD("No. Cuenta Contrapartida CP");
                                CASE ConceptosSalariales."Tipo Cuenta Contrapartida CP" OF
                                    0:
                                        TipoContrapartida := 0;
                                    ELSE
                                        TipoContrapartida := 2;
                                END;

                                NoCuentaContrapartida := ConceptosSalariales."No. Cuenta Contrapartida CP";
                            END;
                        END;
                    END
                    ELSE BEGIN
                        CASE ConceptosSalariales."Tipo Cuenta Cuota Patronal" OF
                            0:
                                TipoCta := 0;
                            ELSE
                                TipoCta := 2;
                        END;
                        ConceptosSalariales.TESTFIELD("No. Cuenta Cuota Patronal");
                        NoCuenta := ConceptosSalariales."No. Cuenta Cuota Patronal";
                        IF ConceptosSalariales."Validar Contrapartida CP" THEN BEGIN
                            ConceptosSalariales.TESTFIELD("No. Cuenta Contrapartida CP");
                            CASE ConceptosSalariales."Tipo Cuenta Contrapartida CP" OF
                                0:
                                    TipoContrapartida := 0;
                                ELSE
                                    TipoContrapartida := 2;
                            END;

                            NoCuentaContrapartida := ConceptosSalariales."No. Cuenta Contrapartida CP";
                        END;
                    END;

                    //MESSAGE('%1 %2 %3 %$ %5',"Concepto Salarial",NoCuenta,NoCuentaContrapartida,Importe);
                    IF (gDCA."Cod. Empleado" <> "Cab. nomina"."No. empleado") AND ("Historico Cab. nomina"."Tipo Nomina" = "Historico Cab. nomina"."Tipo Nomina"::Normal) THEN BEGIN

                        LlenaDatosCp("Concepto Salarial", TipoCta, NoCuenta, Importe, FALSE, "No. Empleado");
                        IF ConceptosSalariales."Validar Contrapartida CP" THEN
                            LlenaDatosCp("Concepto Salarial", TipoContrapartida, NoCuentaContrapartida, Importe, TRUE, "No. Empleado");
                    END;

                    CLEAR(NoCuenta);
                    CLEAR(TipoCta);
                    CLEAR(NoCuentaContrapartida);
                    CLEAR(TipoContrapartida);
                end;

                trigger OnPreDataItem()
                begin
                    IF NOT HayNominas THEN
                        EXIT;
                    //MESSAGE('Paso1 %1 bb%2 cc%3 dd%4',HayNominas,GETFILTERS,"Cab. nomina".getfilters);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Contador2 := Contador2 + 1;
                Ventana.UPDATE(2, ROUND(Contador2 / NumRecords * 10000, 1));

                tmpContab.DELETEALL;
            end;

            trigger OnPostDataItem()
            begin
                HayNominas := FALSE;
            end;

            trigger OnPreDataItem()
            begin
                COPYFILTERS("Cab. nomina");
                NumRecords := COUNT;
            end;
        }
        dataitem("Temp Contabilizacion Nom."; 34002123)
        {
            DataItemTableView = SORTING(Step, "No. Cuenta", "Cod. Empleado", "Valor Dim 1", "Valor Dim 2", "Valor Dim 3", "Valor Dim 4", "Valor Dim 5", "Valor Dim 6", "No. Linea", "Forma de Cobro")
                                WHERE(Step = CONST(1));

            trigger OnAfterGetRecord()
            begin
                IF "Forma de Cobro" <> "Forma de Cobro"::"Transferencia Banc." THEN BEGIN
                    TotalDbCk += "Importe Db CK";
                    TotalCrCk += "Importe Cr CK";
                END
                ELSE BEGIN
                    TotalDb += "Importe Db";
                    TotalCr += "Importe Cr";
                END;

                "Cab. nomina".RESET;
                "Cab. nomina".SETRANGE("No. empleado", "Cod. Empleado");
                "Cab. nomina".FINDLAST;

                InsertaLinDiario("Temp Contabilizacion Nom.");
            end;

            trigger OnPostDataItem()
            begin
                "Importe Db" := TotalDb;
                "Importe Cr" := TotalCr;
                "Importe Db CK" := TotalDbCk;
                "Importe Cr CK" := TotalCrCk;

                InsertaContrapartidaCO("Temp Contabilizacion Nom.");
            end;

            trigger OnPreDataItem()
            begin
                NoLinea := 0;
                //COMMIT;
                //CurrReport.BREAK;

                TotalDb := 0;
                TotalCr := 0;
                TotalDbCk := 0;
                TotalCrCk := 0;
            end;
        }
        dataitem(TempContabNom; 34002123)
        {
            DataItemTableView = SORTING(Step, "No. Cuenta", "Cod. Empleado", "Valor Dim 1", "Valor Dim 2", "Valor Dim 3", "Valor Dim 4", "Valor Dim 5", "Valor Dim 6", "No. Linea", "Forma de Cobro")
                                WHERE(Step = CONST(2));

            trigger OnAfterGetRecord()
            begin
                TotalDb += "Importe Db";
                TotalCr += "Importe Cr";

                "Cab. nomina".RESET;
                "Cab. nomina".SETRANGE("No. empleado", "Cod. Empleado");
                "Cab. nomina".FINDLAST;

                InsertaLinDiario(TempContabNom);
            end;

            trigger OnPostDataItem()
            begin
                "Importe Db" := TotalDb;
                "Importe Cr" := TotalCr;

                InsertaContrapartidaCP(TempContabNom);
            end;

            trigger OnPreDataItem()
            begin
                //CurrReport.BREAK;
                TotalDb := 0;
                TotalCr := 0;
                TotalCrCk := 0;
                TotalDbCk := 0;
            end;
        }
        dataitem("Temp Contabilizacion Job"; 34002123)
        {
            DataItemTableView = SORTING(Step, "No. Cuenta", "Cod. Empleado", "Valor Dim 1", "Valor Dim 2", "Valor Dim 3", "Valor Dim 4", "Valor Dim 5", "Valor Dim 6", "No. Linea", "Forma de Cobro")
                                WHERE(Step = CONST(3));

            trigger OnAfterGetRecord()
            begin
                TotalDb += "Importe Db";
                TotalCr += "Importe Cr";
                TotalDbCk += "Importe Db CK";
                TotalCrCk += "Importe Cr CK";

                "Cab. nomina".RESET;
                "Cab. nomina".SETRANGE("No. empleado", "Cod. Empleado");
                "Cab. nomina".FINDLAST;

                insertalindiariojOB("Temp Contabilizacion Job");
            end;

            trigger OnPostDataItem()
            begin
                "Importe Db" := TotalDb;
                "Importe Cr" := TotalCr;
                "Importe Db CK" := TotalDbCk;
                "Importe Cr CK" := TotalCrCk;

                InsertaContrapartidaCOJob("Temp Contabilizacion Job");
            end;

            trigger OnPreDataItem()
            begin
                NoLinea := 0;
                //COMMIT;
                //CurrReport.BREAK;

                TotalDb := 0;
                TotalCr := 0;
                TotalDbCk := 0;
                TotalCrCk := 0;
            end;
        }
        dataitem(TempContabJob; 34002123)
        {
            DataItemTableView = SORTING(Step, "No. Cuenta", "Cod. Empleado", "Valor Dim 1", "Valor Dim 2", "Valor Dim 3", "Valor Dim 4", "Valor Dim 5", "Valor Dim 6", "No. Linea", "Forma de Cobro")
                                WHERE(Step = CONST(4));

            trigger OnAfterGetRecord()
            begin
                TotalDb += "Importe Db";
                TotalCr += "Importe Cr";
                TotalDbCk += "Importe Db CK";
                TotalCrCk += "Importe Cr CK";

                "Cab. nomina".RESET;
                "Cab. nomina".SETRANGE("No. empleado", "Cod. Empleado");
                "Cab. nomina".FINDLAST;

                insertalindiariojOB(TempContabJob);
            end;

            trigger OnPostDataItem()
            begin
                "Importe Db" := TotalDb;
                "Importe Cr" := TotalCr;
                "Importe Db CK" := TotalDbCk;
                "Importe Cr CK" := TotalCrCk;

                InsertaContrapartidaCPJob(TempContabJob);
            end;

            trigger OnPreDataItem()
            begin
                //CurrReport.BREAK;
                TotalDb := 0;
                TotalCr := 0;
                TotalDbCk := 0;
                TotalCrCk := 0;
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
                field("Libro Diario"; "Repetir Contabiliz.")
                {
                    Caption = 'Repeat Journal Post';
                }
                field(CodSeccion; CodSeccion)
                {
                    Caption = 'Batch Journal name';

                    trigger OnLookup(var Text: Text): Boolean
                    begin

                        ConfNomina.GET();
                        Seccion.SETRANGE(Seccion."Journal Template Name", ConfNomina."Journal Template Name");
                        IF PAGE.RUNMODAL(PAGE::"General Journal Batches", Seccion) = ACTION::LookupOK THEN
                            CodSeccion := Seccion.Name
                        ELSE
                            CodSeccion := '';
                    end;
                }
                field(FechaRegistro; FechaRegistro)
                {
                    Caption = 'Posting Date';
                }
                field(CodDivisa; CodDivisa)
                {
                    Caption = 'Currency code';
                    TableRelation = Currency;
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin

            ConfNomina.GET();
            Seccion.SETRANGE(Seccion."Journal Template Name", ConfNomina."Journal Template Name");
            CodSeccion := ConfNomina."Journal Batch Name";
            FechaRegistro := WORKDATE;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        "Repetir Contabiliz." := FALSE;
        Divisa.InitRoundingPrecision;

        DC.SETCURRENTKEY(DC.Orden);
        DC.FIND('-');
        REPEAT
            Indice += 1;
            CodDim[Indice] := DC."Cod. Dimension";
        UNTIL DC.NEXT = 0;
    end;

    trigger OnPostReport()
    begin
        Ventana.CLOSE;
        //CalculoFechas.InicializaConceptosSalariales;
        MESSAGE(Text002);
    end;

    trigger OnPreReport()
    var
        AA: Integer;
        MM: Integer;
    begin
        ConfContabilidad.GET();
        ConfNomina.GET();

        inicial := "Cab. nomina".GETRANGEMIN(Periodo);
        final := "Cab. nomina".GETRANGEMAX(Periodo);

        IF inicial = final THEN
            ERROR(Err003);

        CalculoFechas.CalculoEntreFechas(inicial, final, AA, MM, DiasTranscurridos);

        LibrosDiarios.GET(ConfNomina."Journal Template Name");

        //Verifico si existe una linea
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE("Journal Template Name", ConfNomina."Journal Template Name");
        GenJnlLine.SETRANGE("Journal Batch Name", CodSeccion);
        IF (GenJnlLine.FINDSET) AND (GenJnlLine.COUNT < 3) THEN
            GenJnlLine.DELETEALL;
        ;

        GenJnlLine.RESET;
        GenJnlLine.SETRANGE("Journal Template Name", ConfNomina."Journal Template Name");
        GenJnlLine.SETRANGE("Journal Batch Name", CodSeccion);
        IF GenJnlLine.FINDLAST THEN
            NoLinea := GenJnlLine."Line No.";

        IF ContabNom.FIND('-') THEN
            ContabNom.DELETEALL;

        IF TempContabNom.FIND('-') THEN
            TempContabNom.DELETEALL;

        IF "Temp Contabilizacion Job".FIND('-') THEN
            "Temp Contabilizacion Job".DELETEALL;

        IF TempContabJob.FIND('-') THEN
            TempContabJob.DELETEALL;
    end;

    var
        ConfContab: Record 98;
        ConfNomina: Record 34002103;
        LibrosDiarios: Record 80;
        Empleado: Record 5200;
        Empresa: Record 34002100;
        CxCEmpl: Record 34002146;
        Seccion: Record 232;
        GenJnlLine: Record 81;
        GpoContEmpl: Record 34002104;
        ConfContabilidad: Record 98;
        ConfGpoContEmpl: Record 34002105;
        ConfCodOrigen: Record 242;
        DC: Record 34002132;
        recDimSet: Record 480;
        TempDimSetEntry: Record 480 temporary;
        Contrato: Record 34002109;
        ConceptosSalariales: Record 34002111;
        Divisa: Record 4;
        GpoContable: Record 34002104;
        DefDim: Record 352;
        TiposCotizacion: Record 34002129;
        JobJNL: Record 81;
        DCA: Record 34002163;
        gDCA: Record 34002163;
        recTmpDimEntry: Record 480 temporary;
        PerfilSal: Record 34002115;
        tmpContab: Record 34002123 temporary;
        ContabNom: Record 34002123;
        HistLinNom: Record 34002118;
        Tiposdenominas: Record 34002158;
        DistribEDEmp: Record 34002190;
        cduDim: Codeunit 408;
        GestNumSerie: Codeunit 396;
        CalculoFechas: Codeunit 34002104;
        CodOrigen: Code[20];
        inicial: Date;
        final: Date;
        "Repetir Contabiliz.": Boolean;
        i: Integer;
        concepto: array[10, 15] of Decimal;
        NumDoc: Code[20];
        HayNominas: Boolean;
        NoCuentaContrapartida: Code[20];
        CodSeccion: Code[20];
        TipoContrapartida: Integer;
        FechaRegistro: Date;
        Ventana: Dialog;
        AModificar: Decimal;
        Contador: Decimal;
        Text001: Label 'Net to income';
        Text002: Label 'Posting finished';
        Text003: Label 'Processing Employee Quote  @1@@@@@@@@@@@@@ \Processing Employer Quote  @2@@@@@@@@@@@@@';
        Text007: Label 'Copy Dimensions';
        Contador2: Decimal;
        TipoCta: Integer;
        CxCMod: Boolean;
        NoLinea: Integer;
        NumLin: Integer;
        RangoLinea: Integer;
        Err001: Label 'Configure %1 to %2 %3';
        NoEmpl: Code[20];
        NoLin: Integer;
        CodDim: array[6] of Code[20];
        Indice: Integer;
        NumRecords: Integer;
        Err002: Label 'Missing Account No.';
        TotalDb: Decimal;
        TotalCr: Decimal;
        TotalDbCk: Decimal;
        TotalCrCk: Decimal;
        DiasTranscurridos: Integer;
        Anos: Integer;
        Meses: Integer;
        Dias: Integer;
        Err003: Label 'Specify a range of dates in the period filter';
        PrimeraQ: Boolean;
        SegundaQ: Boolean;
        CodDivisa: Code[20];

    procedure LlenaDatosCO(cConceptoSal: Code[20]; iTipoCuenta: Integer; cCodCuenta: Code[20]; dImporte: Decimal; Contrapartida: Boolean; CodEmpleado: Code[20])
    var
        DimExiste: Boolean;
    begin
        //LlenadatosCO
        CLEAR(ContabNom);
        ContabNom.SETRANGE(Step, 1);
        ContabNom.SETRANGE("Tipo Cuenta", iTipoCuenta);
        ContabNom.SETRANGE("No. Cuenta", cCodCuenta);
        ContabNom.SETRANGE("Forma de Cobro", "Cab. nomina"."Forma de Cobro");

        recDimSet.RESET;
        recDimSet.SETFILTER("Dimension Set ID", '%1|%2', "Cab. nomina"."Dimension Set ID", "Lin. nomina"."Dimension Set ID");
        IF recDimSet.FINDSET(FALSE, FALSE) THEN
            REPEAT
                DimExiste := FALSE;
                IF ConceptosSalariales."Contabilizacion x Dimension" THEN BEGIN
                    IF recDimSet."Dimension Code" = CodDim[1] THEN BEGIN
                        // contabnom.SETRANGE("Cod. Dim 1",recDimSet."Dimension Code");
                        IF (DistribEDEmp."Dimension Code" <> '') AND (DistribEDEmp."Dimension Code" = CodDim[1]) THEN BEGIN
                            ContabNom.SETRANGE("Valor Dim 1", DistribEDEmp.Codigo);
                            DimExiste := TRUE;
                        END
                        ELSE BEGIN
                            ContabNom.SETRANGE("Valor Dim 1", recDimSet."Dimension Value Code");
                            IF (ConceptosSalariales.Provisionar) AND (recDimSet."Dimension Code" = ConfNomina."Dimension Conceptos Salariales") THEN
                                ContabNom.SETRANGE("Valor Dim 1", cConceptoSal);
                        END;
                    END;

                    IF recDimSet."Dimension Code" = CodDim[2] THEN BEGIN
                        //  contabnom.SETRANGE("Cod. Dim 2",recDimSet."Dimension Code");
                        IF (DistribEDEmp."Dimension Code" <> '') AND (DistribEDEmp."Dimension Code" = CodDim[2]) THEN BEGIN
                            ContabNom.SETRANGE("Valor Dim 2", DistribEDEmp.Codigo);
                            DimExiste := TRUE;
                        END
                        ELSE BEGIN
                            ContabNom.SETRANGE("Valor Dim 2", recDimSet."Dimension Value Code");
                            IF (ConceptosSalariales.Provisionar) AND (recDimSet."Dimension Code" = ConfNomina."Dimension Conceptos Salariales") THEN
                                ContabNom.SETRANGE("Valor Dim 2", cConceptoSal);
                        END;
                    END;

                    IF recDimSet."Dimension Code" = CodDim[3] THEN BEGIN
                        //  contabnom.SETRANGE("Cod. Dim 3",recDimSet."Dimension Code");
                        IF (DistribEDEmp."Dimension Code" <> '') AND (DistribEDEmp."Dimension Code" = CodDim[3]) THEN BEGIN
                            ContabNom.SETRANGE("Valor Dim 3", DistribEDEmp.Codigo);
                            DimExiste := TRUE;
                        END
                        ELSE BEGIN
                            ContabNom.SETRANGE("Valor Dim 3", recDimSet."Dimension Value Code");
                            IF (ConceptosSalariales.Provisionar) AND (recDimSet."Dimension Code" = ConfNomina."Dimension Conceptos Salariales") THEN
                                ContabNom.SETRANGE("Valor Dim 3", cConceptoSal);
                        END;
                    END;

                    IF recDimSet."Dimension Code" = CodDim[4] THEN BEGIN
                        // contabnom.SETRANGE("Cod. Dim 4",recDimSet."Dimension Code");
                        IF (DistribEDEmp."Dimension Code" <> '') AND (DistribEDEmp."Dimension Code" = CodDim[4]) THEN BEGIN
                            ContabNom.SETRANGE("Valor Dim 4", DistribEDEmp.Codigo);
                            DimExiste := TRUE;
                        END
                        ELSE BEGIN
                            ContabNom.SETRANGE("Valor Dim 4", recDimSet."Dimension Value Code");
                            IF (ConceptosSalariales.Provisionar) AND (recDimSet."Dimension Code" = ConfNomina."Dimension Conceptos Salariales") THEN
                                ContabNom.SETRANGE("Valor Dim 4", cConceptoSal);
                        END;
                    END;

                    IF recDimSet."Dimension Code" = CodDim[5] THEN BEGIN
                        //  contabnom.SETRANGE("Cod. Dim 5",recDimSet."Dimension Code");
                        IF (DistribEDEmp."Dimension Code" <> '') AND (DistribEDEmp."Dimension Code" = CodDim[5]) THEN BEGIN
                            ContabNom.SETRANGE("Valor Dim 5", DistribEDEmp.Codigo);
                            DimExiste := TRUE;
                        END
                        ELSE BEGIN
                            ContabNom.SETRANGE("Valor Dim 5", recDimSet."Dimension Value Code");
                            IF (ConceptosSalariales.Provisionar) AND (recDimSet."Dimension Code" = ConfNomina."Dimension Conceptos Salariales") THEN
                                ContabNom.SETRANGE("Valor Dim 5", cConceptoSal);
                        END;
                    END;

                    IF recDimSet."Dimension Code" = CodDim[6] THEN BEGIN
                        // contabnom.SETRANGE("Cod. Dim 6",recDimSet."Dimension Code");
                        IF (DistribEDEmp."Dimension Code" <> '') AND (DistribEDEmp."Dimension Code" = CodDim[6]) THEN BEGIN
                            ContabNom.SETRANGE("Valor Dim 6", DistribEDEmp.Codigo);
                            DimExiste := TRUE;
                        END
                        ELSE BEGIN
                            ContabNom.SETRANGE("Valor Dim 6", recDimSet."Dimension Value Code");
                            IF (ConceptosSalariales.Provisionar) AND (recDimSet."Dimension Code" = ConfNomina."Dimension Conceptos Salariales") THEN
                                ContabNom.SETRANGE("Valor Dim 6", cConceptoSal);
                        END;
                    END;

                    IF (NOT DimExiste) AND (DistribEDEmp."Dimension Code" <> '') THEN
                        ContabNom.SETRANGE("Valor Dim 6", DistribEDEmp.Codigo);
                END;
            UNTIL recDimSet.NEXT = 0;

        IF NOT ConceptosSalariales."Contabilizacion Resumida" THEN
            ContabNom.SETRANGE("Cod. Empleado", CodEmpleado);

        IF ContabNom.FINDFIRST THEN BEGIN
            IF NOT Contrapartida THEN BEGIN
                IF "Cab. nomina"."Forma de Cobro" <> "Cab. nomina"."Forma de Cobro"::"Transferencia Banc." THEN BEGIN
                    IF dImporte > 0 THEN
                        ContabNom."Importe Db CK" += dImporte
                    ELSE
                        ContabNom."Importe Cr CK" += ABS(dImporte);
                END
                ELSE BEGIN
                    IF dImporte > 0 THEN
                        ContabNom."Importe Db" += dImporte
                    ELSE
                        ContabNom."Importe Cr" += ABS(dImporte);
                END;
            END
            ELSE BEGIN
                IF "Cab. nomina"."Forma de Cobro" <> "Cab. nomina"."Forma de Cobro"::"Transferencia Banc." THEN BEGIN
                    IF dImporte < 0 THEN
                        ContabNom."Importe Cr CK" += ABS(dImporte)
                    ELSE
                        ContabNom."Importe Db CK" += dImporte;
                END
                ELSE BEGIN
                    IF dImporte < 0 THEN
                        ContabNom."Importe Cr" += ABS(dImporte)
                    ELSE
                        ContabNom."Importe Db" += dImporte;
                END;
            END;
        END
        ELSE BEGIN
            NoLin += 100;

            CLEAR(ContabNom);
            ContabNom."Tipo Cuenta" := iTipoCuenta;
            ContabNom."No. Cuenta" := cCodCuenta;
            ContabNom."No. Linea" := NoLin;
            ContabNom."Cod. Empleado" := CodEmpleado;
            ContabNom.Contrapartida := Contrapartida;
            ContabNom.Step := 1;

            IF NOT ConceptosSalariales."Contabilizacion Resumida" THEN
                ContabNom.Descripcion := COPYSTR(Empleado."No." + ' ' + Empleado."Full Name", 1, 50)
            ELSE
                ContabNom.Descripcion := ConceptosSalariales.Descripcion;

            IF NOT Contrapartida THEN BEGIN
                IF "Cab. nomina"."Forma de Cobro" <> "Cab. nomina"."Forma de Cobro"::"Transferencia Banc." THEN BEGIN
                    IF dImporte > 0 THEN
                        ContabNom."Importe Db CK" := dImporte
                    ELSE
                        ContabNom."Importe Cr CK" := ABS(dImporte);
                END
                ELSE BEGIN
                    IF dImporte > 0 THEN
                        ContabNom."Importe Db" := dImporte
                    ELSE
                        ContabNom."Importe Cr" := ABS(dImporte);
                END;
            END
            ELSE BEGIN
                IF "Cab. nomina"."Forma de Cobro" <> "Cab. nomina"."Forma de Cobro"::"Transferencia Banc." THEN BEGIN
                    IF dImporte > 0 THEN
                        ContabNom."Importe Db CK" := dImporte
                    ELSE
                        ContabNom."Importe Cr CK" := ABS(dImporte);

                END
                ELSE BEGIN
                    IF dImporte > 0 THEN
                        ContabNom."Importe Db" := dImporte
                    ELSE
                        ContabNom."Importe Cr" := ABS(dImporte);
                END;
            END;

            recDimSet.RESET;
            recDimSet.SETFILTER("Dimension Set ID", '%1|%2', "Cab. nomina"."Dimension Set ID", "Lin. nomina"."Dimension Set ID");
            IF recDimSet.FINDSET(FALSE, FALSE) THEN
                REPEAT
                    IF ConceptosSalariales."Contabilizacion x Dimension" THEN BEGIN
                        IF recDimSet."Dimension Code" = CodDim[1] THEN BEGIN
                            ContabNom."Cod. Dim 1" := recDimSet."Dimension Code";
                            IF (DistribEDEmp."Dimension Code" <> '') AND (DistribEDEmp."Dimension Code" = CodDim[1]) THEN
                                ContabNom."Valor Dim 1" := DistribEDEmp.Codigo
                            ELSE
                                ContabNom."Valor Dim 1" := recDimSet."Dimension Value Code";
                        END
                        ELSE
                            IF recDimSet."Dimension Code" = CodDim[2] THEN BEGIN
                                ContabNom."Cod. Dim 2" := recDimSet."Dimension Code";
                                IF (DistribEDEmp."Dimension Code" <> '') AND (DistribEDEmp."Dimension Code" = CodDim[2]) THEN
                                    ContabNom."Valor Dim 2" := DistribEDEmp.Codigo
                                ELSE
                                    ContabNom."Valor Dim 2" := recDimSet."Dimension Value Code";
                            END
                            ELSE
                                IF recDimSet."Dimension Code" = CodDim[3] THEN BEGIN
                                    ContabNom."Cod. Dim 3" := recDimSet."Dimension Code";
                                    IF (DistribEDEmp."Dimension Code" <> '') AND (DistribEDEmp."Dimension Code" = CodDim[3]) THEN
                                        ContabNom."Valor Dim 3" := DistribEDEmp.Codigo
                                    ELSE
                                        ContabNom."Valor Dim 3" := recDimSet."Dimension Value Code";
                                END
                                ELSE
                                    IF recDimSet."Dimension Code" = CodDim[4] THEN BEGIN
                                        ContabNom."Cod. Dim 4" := recDimSet."Dimension Code";
                                        IF (DistribEDEmp."Dimension Code" <> '') AND (DistribEDEmp."Dimension Code" = CodDim[4]) THEN
                                            ContabNom."Valor Dim 4" := DistribEDEmp.Codigo
                                        ELSE
                                            ContabNom."Valor Dim 4" := recDimSet."Dimension Value Code";
                                    END
                                    ELSE
                                        IF recDimSet."Dimension Code" = CodDim[5] THEN BEGIN
                                            ContabNom."Cod. Dim 5" := recDimSet."Dimension Code";
                                            IF (DistribEDEmp."Dimension Code" <> '') AND (DistribEDEmp."Dimension Code" = CodDim[5]) THEN
                                                ContabNom."Valor Dim 5" := DistribEDEmp.Codigo
                                            ELSE
                                                ContabNom."Valor Dim 5" := recDimSet."Dimension Value Code";
                                        END
                                        ELSE
                                            IF recDimSet."Dimension Code" = CodDim[6] THEN BEGIN
                                                ContabNom."Cod. Dim 6" := recDimSet."Dimension Code";
                                                IF (DistribEDEmp."Dimension Code" <> '') AND (DistribEDEmp."Dimension Code" = CodDim[6]) THEN
                                                    ContabNom."Valor Dim 6" := DistribEDEmp.Codigo
                                                ELSE
                                                    ContabNom."Valor Dim 6" := recDimSet."Dimension Value Code";
                                            END;

                        IF (NOT DimExiste) AND (DistribEDEmp."Dimension Code" <> '') THEN BEGIN
                            ContabNom."Cod. Dim 6" := DistribEDEmp."Dimension Code";
                            ContabNom."Valor Dim 6" := DistribEDEmp.Codigo;
                        END;

                        ContabNom."Dimension Set ID" := recDimSet."Dimension Set ID";
                    END;
                UNTIL recDimSet.NEXT = 0
        END;

        //   MESSAGE('%1 %2 %3 %4',cConceptoSal,contabnom."Valor Dim 4",ConceptosSalariales.Prorratear);
        //MESSAGE('%1',"Temp Contabilizacion Nom.");
        IF ConceptosSalariales.Provisionar THEN BEGIN
            FOR i := 1 TO 6 DO BEGIN
                IF ConfNomina."Dimension Conceptos Salariales" = CodDim[i] THEN BEGIN
                    IF ContabNom."Cod. Dim 1" = CodDim[i] THEN
                        ContabNom."Valor Dim 1" := cConceptoSal
                    ELSE
                        IF ContabNom."Cod. Dim 2" = CodDim[i] THEN
                            ContabNom."Valor Dim 2" := cConceptoSal
                        ELSE
                            IF ContabNom."Cod. Dim 3" = CodDim[i] THEN
                                ContabNom."Valor Dim 3" := cConceptoSal
                            ELSE
                                IF ContabNom."Cod. Dim 4" = CodDim[i] THEN
                                    ContabNom."Valor Dim 4" := cConceptoSal
                                ELSE
                                    IF ContabNom."Cod. Dim 5" = CodDim[i] THEN
                                        ContabNom."Valor Dim 5" := cConceptoSal
                                    ELSE
                                        IF ContabNom."Cod. Dim 6" = CodDim[i] THEN
                                            ContabNom."Valor Dim 6" := cConceptoSal;
                END;
            END;
        END;
        //Para las Dim del perfil de salario (linea del concepto salarial)
        //Para las Dim por Grupo contable
        DefDim.RESET;
        DefDim.SETFILTER("Table ID", '%1|%2|%3', 34002105, 34002111, 34002115);
        IF Empleado."Posting Group" <> '' THEN
            DefDim.SETFILTER("No.", Empleado."Posting Group" + '*' + cConceptoSal + '*')
        ELSE
            DefDim.SETFILTER("No.", '*' + cConceptoSal + '*');
        IF DefDim.FINDSET THEN
            REPEAT
                IF CodDim[1] = DefDim."Dimension Code" THEN BEGIN
                    ContabNom."Cod. Dim 1" := DefDim."Dimension Code";
                    IF (DistribEDEmp."Dimension Code" <> '') AND (DefDim."Dimension Code" = DistribEDEmp."Dimension Code") THEN
                        ContabNom."Valor Dim 1" := DistribEDEmp.Codigo
                    ELSE
                        ContabNom."Valor Dim 1" := DefDim."Dimension Value Code";
                END
                ELSE
                    IF CodDim[2] = DefDim."Dimension Code" THEN BEGIN
                        ContabNom."Cod. Dim 2" := DefDim."Dimension Code";
                        IF (DistribEDEmp."Dimension Code" <> '') AND (DefDim."Dimension Code" = DistribEDEmp."Dimension Code") THEN
                            ContabNom."Valor Dim 2" := DistribEDEmp.Codigo
                        ELSE
                            ContabNom."Valor Dim 2" := DefDim."Dimension Value Code";
                    END
                    ELSE
                        IF CodDim[3] = DefDim."Dimension Code" THEN BEGIN
                            ContabNom."Cod. Dim 3" := DefDim."Dimension Code";
                            IF (DistribEDEmp."Dimension Code" <> '') AND (DefDim."Dimension Code" = DistribEDEmp."Dimension Code") THEN
                                ContabNom."Valor Dim 3" := DistribEDEmp.Codigo
                            ELSE
                                ContabNom."Valor Dim 3" := DefDim."Dimension Value Code";
                        END
                        ELSE
                            IF CodDim[4] = DefDim."Dimension Code" THEN BEGIN
                                ContabNom."Cod. Dim 4" := DefDim."Dimension Code";
                                IF (DistribEDEmp."Dimension Code" <> '') AND (DefDim."Dimension Code" = DistribEDEmp."Dimension Code") THEN
                                    ContabNom."Valor Dim 4" := DistribEDEmp.Codigo
                                ELSE
                                    ContabNom."Valor Dim 4" := DefDim."Dimension Value Code";
                            END
                            ELSE
                                IF CodDim[5] = DefDim."Dimension Code" THEN BEGIN
                                    ContabNom."Cod. Dim 5" := DefDim."Dimension Code";
                                    IF (DistribEDEmp."Dimension Code" <> '') AND (DefDim."Dimension Code" = DistribEDEmp."Dimension Code") THEN
                                        ContabNom."Valor Dim 5" := DistribEDEmp.Codigo
                                    ELSE
                                        ContabNom."Valor Dim 5" := DefDim."Dimension Value Code";
                                END
                                ELSE
                                    IF CodDim[6] = DefDim."Dimension Code" THEN BEGIN
                                        ContabNom."Cod. Dim 6" := DefDim."Dimension Code";
                                        IF (DistribEDEmp."Dimension Code" <> '') AND (DefDim."Dimension Code" = DistribEDEmp."Dimension Code") THEN
                                            ContabNom."Valor Dim 6" := DistribEDEmp.Codigo
                                        ELSE
                                            ContabNom."Valor Dim 6" := DefDim."Dimension Value Code";
                                    END;

                IF (NOT DimExiste) AND (DistribEDEmp."Dimension Code" <> '') THEN
                    ContabNom."Valor Dim 6" := DistribEDEmp.Codigo;

            UNTIL DefDim.NEXT = 0;
        ContabNom."Forma de Cobro" := "Cab. nomina"."Forma de Cobro";

        IF NOT ContabNom.INSERT THEN
            ContabNom.MODIFY;
    end;

    procedure LlenaDatosCp(cConceptoSal: Code[20]; iTipoCuenta: Integer; cCodCuenta: Code[20]; dImporte: Decimal; Contrapartida: Boolean; CodEmpleado: Code[20])
    begin
        //LlenadatosCP
        CLEAR(TempContabNom);
        TempContabNom.SETRANGE("Tipo Cuenta", iTipoCuenta);
        TempContabNom.SETRANGE("No. Cuenta", cCodCuenta);
        TempContabNom.SETRANGE(Step, 2);


        HistLinNom.RESET;
        HistLinNom.SETCURRENTKEY("No. empleado", "Tipo nomina", Periodo, "No. Orden");
        HistLinNom.SETRANGE("No. empleado", "Lin. Aportes Empresas"."No. Empleado");
        HistLinNom.SETFILTER("Tipo de nomina", "Cab. nomina".GETFILTER("Tipo de nomina"));
        HistLinNom.SETRANGE("No. Documento", "Lin. Aportes Empresas"."No. Documento");
        HistLinNom.SETRANGE(Periodo, "Lin. Aportes Empresas".Periodo);
        HistLinNom.SETRANGE("Concepto salarial", "Lin. Aportes Empresas"."Concepto Salarial");
        IF NOT HistLinNom.FINDFIRST THEN
            HistLinNom.INIT;


        recDimSet.RESET;
        recDimSet.SETRANGE("Dimension Set ID", "Lin. Aportes Empresas"."Dimension Set ID");
        IF recDimSet.FINDSET(FALSE, FALSE) THEN
            REPEAT
                IF recDimSet."Dimension Code" = CodDim[1] THEN BEGIN
                    TempContabNom.SETRANGE("Cod. Dim 1", recDimSet."Dimension Code");
                    TempContabNom.SETRANGE("Valor Dim 1", recDimSet."Dimension Value Code");
                    IF ConceptosSalariales.Provisionar AND (recDimSet."Dimension Code" = ConfNomina."Dimension Conceptos Salariales") THEN
                        ContabNom.SETRANGE("Valor Dim 1", cConceptoSal);
                END;

                IF recDimSet."Dimension Code" = CodDim[2] THEN BEGIN
                    TempContabNom.SETRANGE("Cod. Dim 2", recDimSet."Dimension Code");
                    TempContabNom.SETRANGE("Valor Dim 2", recDimSet."Dimension Value Code");
                    IF ConceptosSalariales.Provisionar AND (recDimSet."Dimension Code" = ConfNomina."Dimension Conceptos Salariales") THEN
                        ContabNom.SETRANGE("Valor Dim 1", cConceptoSal);

                END;

                IF ConceptosSalariales."Contabilizacion x Dimension" THEN BEGIN
                    IF recDimSet."Dimension Code" = CodDim[3] THEN BEGIN
                        TempContabNom.SETRANGE("Cod. Dim 3", recDimSet."Dimension Code");
                        TempContabNom.SETRANGE("Valor Dim 3", recDimSet."Dimension Value Code");
                        IF ConceptosSalariales.Provisionar AND (recDimSet."Dimension Code" = ConfNomina."Dimension Conceptos Salariales") THEN
                            ContabNom.SETRANGE("Valor Dim 1", cConceptoSal);
                    END;

                    IF recDimSet."Dimension Code" = CodDim[4] THEN BEGIN
                        TempContabNom.SETRANGE("Cod. Dim 4", recDimSet."Dimension Code");
                        TempContabNom.SETRANGE("Valor Dim 4", recDimSet."Dimension Value Code");
                        IF ConceptosSalariales.Provisionar AND (recDimSet."Dimension Code" = ConfNomina."Dimension Conceptos Salariales") THEN
                            ContabNom.SETRANGE("Valor Dim 1", cConceptoSal);
                    END;

                    IF recDimSet."Dimension Code" = CodDim[5] THEN BEGIN
                        TempContabNom.SETRANGE("Cod. Dim 5", recDimSet."Dimension Code");
                        TempContabNom.SETRANGE("Valor Dim 5", recDimSet."Dimension Value Code");
                        IF ConceptosSalariales.Provisionar AND (recDimSet."Dimension Code" = ConfNomina."Dimension Conceptos Salariales") THEN
                            ContabNom.SETRANGE("Valor Dim 1", cConceptoSal);
                    END;

                    IF recDimSet."Dimension Code" = CodDim[6] THEN BEGIN
                        TempContabNom.SETRANGE("Cod. Dim 6", recDimSet."Dimension Code");
                        TempContabNom.SETRANGE("Valor Dim 6", recDimSet."Dimension Value Code");
                        IF ConceptosSalariales.Provisionar AND (recDimSet."Dimension Code" = ConfNomina."Dimension Conceptos Salariales") THEN
                            ContabNom.SETRANGE("Valor Dim 1", cConceptoSal);
                    END;
                END;
                IF NOT ConceptosSalariales."Contabilizacion Resumida" THEN
                    TempContabNom.SETRANGE("Cod. Empleado", CodEmpleado);

            UNTIL recDimSet.NEXT = 0;

        IF TempContabNom.FINDFIRST THEN BEGIN
            IF "Cab. nomina"."Forma de Cobro" <> "Cab. nomina"."Forma de Cobro"::"Transferencia Banc." THEN BEGIN
                IF NOT Contrapartida THEN
                    TempContabNom."Importe Cr CK" += ABS(dImporte)
                ELSE
                    TempContabNom."Importe Db CK" += ABS(dImporte);
            END
            ELSE BEGIN
                IF NOT Contrapartida THEN
                    TempContabNom."Importe Cr" += ABS(dImporte)
                ELSE
                    TempContabNom."Importe Db" += ABS(dImporte);
            END
        END
        ELSE BEGIN
            NoLin += 100;

            CLEAR(TempContabNom);
            TempContabNom."Tipo Cuenta" := iTipoCuenta;
            TempContabNom."No. Cuenta" := cCodCuenta;
            TempContabNom."No. Linea" := NoLin;
            TempContabNom."Cod. Empleado" := CodEmpleado;
            TempContabNom.Contrapartida := Contrapartida;
            TempContabNom.Step := 2;

            IF NOT ConceptosSalariales."Contabilizacion Resumida" THEN
                TempContabNom.Descripcion := COPYSTR(Empleado."No." + ' ' + Empleado."Full Name", 1, 50)
            ELSE
                TempContabNom.Descripcion := ConceptosSalariales.Descripcion;

            IF "Cab. nomina"."Forma de Cobro" <> "Cab. nomina"."Forma de Cobro"::"Transferencia Banc." THEN BEGIN
                IF NOT Contrapartida THEN
                    TempContabNom."Importe Cr CK" := ABS(dImporte)
                ELSE
                    TempContabNom."Importe Db CK" := ABS(dImporte);
            END
            ELSE BEGIN
                IF NOT Contrapartida THEN
                    TempContabNom."Importe Cr" := ABS(dImporte)
                ELSE
                    TempContabNom."Importe Db" := ABS(dImporte);
            END;
            recDimSet.RESET;
            recDimSet.SETRANGE("Dimension Set ID", "Lin. Aportes Empresas"."Dimension Set ID");
            IF recDimSet.FINDSET(FALSE, FALSE) THEN
                REPEAT
                    IF recDimSet."Dimension Code" = CodDim[1] THEN //Siempre llevara la primera DIM (Departamento)
                       BEGIN
                        TempContabNom."Cod. Dim 1" := recDimSet."Dimension Code";
                        TempContabNom."Valor Dim 1" := recDimSet."Dimension Value Code";
                    END;

                    IF recDimSet."Dimension Code" = CodDim[2] THEN //Siempre llevara la segunda DIM (Concepto Sal.)
                       BEGIN
                        TempContabNom."Cod. Dim 2" := recDimSet."Dimension Code";
                        TempContabNom."Valor Dim 2" := recDimSet."Dimension Value Code";
                    END;

                    IF ConceptosSalariales."Contabilizacion x Dimension" THEN BEGIN
                        IF recDimSet."Dimension Code" = CodDim[3] THEN BEGIN
                            TempContabNom."Cod. Dim 3" := recDimSet."Dimension Code";
                            TempContabNom."Valor Dim 3" := recDimSet."Dimension Value Code";
                        END
                        ELSE
                            IF recDimSet."Dimension Code" = CodDim[4] THEN BEGIN
                                TempContabNom."Cod. Dim 4" := recDimSet."Dimension Code";
                                TempContabNom."Valor Dim 4" := recDimSet."Dimension Value Code";
                            END
                            ELSE
                                IF recDimSet."Dimension Code" = CodDim[5] THEN BEGIN
                                    TempContabNom."Cod. Dim 5" := recDimSet."Dimension Code";
                                    TempContabNom."Valor Dim 5" := recDimSet."Dimension Value Code";
                                END
                                ELSE
                                    IF recDimSet."Dimension Code" = CodDim[6] THEN BEGIN
                                        TempContabNom."Cod. Dim 6" := recDimSet."Dimension Code";
                                        TempContabNom."Valor Dim 6" := recDimSet."Dimension Value Code";
                                    END;
                        TempContabNom."Dimension Set ID" := recDimSet."Dimension Set ID";
                    END;
                UNTIL recDimSet.NEXT = 0;
        END;

        IF NOT TempContabNom.INSERT THEN
            TempContabNom.MODIFY;
    end;

    procedure InsertaLinDiario(TmpContNom: Record 34002123)
    var
        DefDim: Record 352;
        DimMgt: Codeunit 408;
        CLE: Record 21;
        Encontrado: Boolean;
    begin
        GenJnlLine.RESET;
        GenJnlLine.INIT;
        GenJnlLine."Journal Template Name" := ConfNomina."Journal Template Name";
        GenJnlLine."Journal Batch Name" := CodSeccion;
        GenJnlLine."Posting Date" := FechaRegistro;
        IF TmpContNom."Tipo Cuenta" = 0 THEN
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account"
        ELSE
            IF TmpContNom."Tipo Cuenta" = 1 THEN
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer
            ELSE
                IF TmpContNom."Tipo Cuenta" = 2 THEN
                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::Vendor;

        NoLinea += 100;
        GenJnlLine."Line No." := NoLinea;

        GenJnlLine.VALIDATE("Account No.", TmpContNom."No. Cuenta");
        GenJnlLine.TESTFIELD("Account No.");
        GenJnlLine."Document No." := NumDoc;
        GenJnlLine.Description := COPYSTR(TmpContNom.Descripcion, 1, 50);

        IF CodDivisa <> '' THEN
            GenJnlLine.VALIDATE("Currency Code", CodDivisa);

        IF "Cab. nomina"."Shortcut Dimension 1 Code" <> '' THEN
            GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Cab. nomina"."Shortcut Dimension 1 Code");

        IF "Cab. nomina"."Shortcut Dimension 2 Code" <> '' THEN
            GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", "Cab. nomina"."Shortcut Dimension 2 Code");

        IF TmpContNom."Importe Db" <> 0 THEN
            GenJnlLine.VALIDATE("Debit Amount", TmpContNom."Importe Db")
        ELSE
            IF TmpContNom."Importe Cr" <> 0 THEN
                GenJnlLine.VALIDATE("Credit Amount", TmpContNom."Importe Cr")
            ELSE
                IF TmpContNom."Importe Db CK" <> 0 THEN
                    GenJnlLine.VALIDATE("Debit Amount", TmpContNom."Importe Db CK")
                ELSE
                    GenJnlLine.VALIDATE("Credit Amount", TmpContNom."Importe Cr CK");

        //Adicionado para Hemingway para liquidar documentos pendientes
        /*
        IF GenJnlLine."Account Type" = GenJnlLine."Account Type"::Customer THEN
           BEGIN
             Encontrado := FALSE;
             CLE.RESET;
             CLE.SETCURRENTKEY("Customer No.",Open,Positive,"Due Date","Currency Code");
             CLE.SETRANGE("Customer No.",GenJnlLine."Account No.");
             CLE.SETRANGE(Open,TRUE);
             CLE.SETRANGE(Positive,TRUE);
             IF CLE.FINDSET THEN
                REPEAT
        
                UNTIL CLE.NEXT = 0 OR Encontrado;
           END;
        */

        IF GenJnlLine.Amount <> 0 THEN BEGIN
            GenJnlLine.INSERT(TRUE);

            //DimMgt.GetDimensionSet(TempDimSetEntry,GenJnlLine."Dimension Set ID");

            CLEAR(TempDimSetEntry);
            TempDimSetEntry.DELETEALL;

            //Busco DefDim del Maestro
            DefDim.RESET;
            CASE TmpContNom."Tipo Cuenta" OF
                0: //Cuenta
                    BEGIN
                        DefDim.SETRANGE("Table ID", 15);
                    END;
                1: //Cliente
                    BEGIN
                        DefDim.SETRANGE("Table ID", 18);
                    END;
                2: //Proveedor
                    BEGIN
                        //IF TmpContNom."Importe Db" <> 0 THEN
                        //  GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment
                        // ELSE
                        //  GenJnlLine."Document Type" := GenJnlLine."Document Type"::Refund;

                        //GenJnlLine."External Document No." := FORMAT(TODAY) + '-' + FORMAT(NoLin);
                        DefDim.SETRANGE("Table ID", 23);
                    END;
            END;

            DefDim.SETRANGE("Value Posting", DefDim."Value Posting"::"Same Code");
            DefDim.SETRANGE("No.", TmpContNom."No. Cuenta");
            IF DefDim.FINDSET THEN
                REPEAT
                    UpdateDimSet(DefDim."Dimension Code", DefDim."Dimension Value Code");
                UNTIL DefDim.NEXT = 0;


            IF (TmpContNom."Cod. Dim 1" <> '') AND (TmpContNom."Valor Dim 1" <> '') THEN BEGIN
                UpdateDimSet(TmpContNom."Cod. Dim 1", TmpContNom."Valor Dim 1");
                IF ConfContabilidad."Global Dimension 1 Code" = TmpContNom."Cod. Dim 1" THEN
                    GenJnlLine."Shortcut Dimension 1 Code" := TmpContNom."Valor Dim 1"
                ELSE
                    IF ConfContabilidad."Global Dimension 2 Code" = TmpContNom."Cod. Dim 1" THEN
                        GenJnlLine."Shortcut Dimension 2 Code" := TmpContNom."Valor Dim 1"
            END;

            IF (TmpContNom."Cod. Dim 2" <> '') AND (TmpContNom."Valor Dim 2" <> '') THEN BEGIN
                TmpContNom.TESTFIELD("Cod. Dim 2");
                //    UpdateDimSet(TempDimSetEntry,TmpContNom."Cod. Dim 2",TmpContNom."Valor Dim 2");
                UpdateDimSet(TmpContNom."Cod. Dim 2", TmpContNom."Valor Dim 2");
                IF ConfContabilidad."Global Dimension 1 Code" = TmpContNom."Cod. Dim 2" THEN
                    GenJnlLine."Shortcut Dimension 1 Code" := TmpContNom."Valor Dim 2"
                ELSE
                    IF ConfContabilidad."Global Dimension 2 Code" = TmpContNom."Cod. Dim 2" THEN
                        GenJnlLine."Shortcut Dimension 2 Code" := TmpContNom."Valor Dim 2"
            END;

            IF (TmpContNom."Cod. Dim 3" <> '') AND (TmpContNom."Valor Dim 3" <> '') THEN BEGIN
                TmpContNom.TESTFIELD("Cod. Dim 3");
                UpdateDimSet(TmpContNom."Cod. Dim 3", TmpContNom."Valor Dim 3");
                IF ConfContabilidad."Global Dimension 1 Code" = TmpContNom."Cod. Dim 3" THEN
                    GenJnlLine."Shortcut Dimension 1 Code" := TmpContNom."Valor Dim 3"
                ELSE
                    IF ConfContabilidad."Global Dimension 2 Code" = TmpContNom."Cod. Dim 3" THEN
                        GenJnlLine."Shortcut Dimension 2 Code" := TmpContNom."Valor Dim 3"
            END;

            IF (TmpContNom."Cod. Dim 4" <> '') AND (TmpContNom."Valor Dim 4" <> '') THEN BEGIN
                TmpContNom.TESTFIELD("Cod. Dim 4");
                UpdateDimSet(TmpContNom."Cod. Dim 4", TmpContNom."Valor Dim 4");
                IF ConfContabilidad."Global Dimension 1 Code" = TmpContNom."Cod. Dim 4" THEN
                    GenJnlLine."Shortcut Dimension 1 Code" := TmpContNom."Valor Dim 4"
                ELSE
                    IF ConfContabilidad."Global Dimension 2 Code" = TmpContNom."Cod. Dim 4" THEN
                        GenJnlLine."Shortcut Dimension 2 Code" := TmpContNom."Valor Dim 4"
            END;

            IF (TmpContNom."Cod. Dim 5" <> '') AND (TmpContNom."Valor Dim 5" <> '') THEN BEGIN
                UpdateDimSet(TmpContNom."Cod. Dim 5", TmpContNom."Valor Dim 5");
                IF ConfContabilidad."Global Dimension 1 Code" = TmpContNom."Cod. Dim 5" THEN
                    GenJnlLine."Shortcut Dimension 1 Code" := TmpContNom."Valor Dim 5"
                ELSE
                    IF ConfContabilidad."Global Dimension 2 Code" = TmpContNom."Cod. Dim 5" THEN
                        GenJnlLine."Shortcut Dimension 2 Code" := TmpContNom."Valor Dim 5"
            END;

            IF (TmpContNom."Cod. Dim 6" <> '') AND (TmpContNom."Valor Dim 6" <> '') THEN BEGIN
                UpdateDimSet(TmpContNom."Cod. Dim 6", TmpContNom."Valor Dim 6");
                IF ConfContabilidad."Global Dimension 1 Code" = TmpContNom."Cod. Dim 6" THEN
                    GenJnlLine."Shortcut Dimension 1 Code" := TmpContNom."Valor Dim 6"
                ELSE
                    IF ConfContabilidad."Global Dimension 2 Code" = TmpContNom."Cod. Dim 6" THEN
                        GenJnlLine."Shortcut Dimension 2 Code" := TmpContNom."Valor Dim 6"
            END;

            GenJnlLine."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);

            GenJnlLine.MODIFY;
        END;

    end;

    procedure InsertaProvision(ConceptoSal: Code[20]; ImportProrr: Decimal)
    var
        NoCuenta: Code[20];
        CSP: Record 34002119;
    begin
        //Del Diario de pagos
        ConceptosSalariales.GET(ConceptoSal);

        //Del Historico de Nominas
        IF GpoContEmpl.GET(Empleado."Posting Group") THEN BEGIN
            ConfGpoContEmpl.SETRANGE(Codigo, GpoContEmpl.Codigo);
            ConfGpoContEmpl.SETRANGE("Codigo Concepto Salarial", ConceptoSal);
            IF ConfGpoContEmpl.FINDFIRST THEN BEGIN
                ConfGpoContEmpl.TESTFIELD("No. Cuenta Cuota Obrera");
                NoCuenta := ConfGpoContEmpl."No. Cuenta Cuota Obrera";
                CASE ConfGpoContEmpl."Tipo Cuenta Cuota Obrera" OF
                    0:
                        TipoCta := 0;
                    ELSE
                        TipoCta := 2;
                END;

                IF (ConceptosSalariales."Validar Contrapartida CO") AND (NOT ConfGpoContEmpl.Provisionar) THEN BEGIN
                    ConfGpoContEmpl.TESTFIELD("No. Cuenta Contrapartida CO");
                    CASE ConfGpoContEmpl."Tipo Cuenta Contrapartida CO" OF
                        0:
                            TipoContrapartida := 0;
                        ELSE
                            TipoContrapartida := 2;
                    END;

                    NoCuentaContrapartida := ConfGpoContEmpl."No. Cuenta Contrapartida CO";
                END;

                IF ConfGpoContEmpl.Provisionar THEN BEGIN
                    "Conceptos Salariales Provision".TESTFIELD("No. Cuenta");
                    NoCuenta := "Conceptos Salariales Provision"."No. Cuenta";

                    CSP.RESET;
                    CSP.SETRANGE(Codigo, ConceptoSal);
                    CSP.SETRANGE("Gpo. Contable Empleado", ConfGpoContEmpl.Codigo);
                    IF CSP.FINDFIRST THEN BEGIN
                        CSP.TESTFIELD("No. Cuenta");
                        NoCuenta := CSP."No. Cuenta";
                        TipoCta := 0;
                        ConceptosSalariales."Validar Contrapartida CO" := CSP."Validar Contrapartida";
                        IF CSP."Validar Contrapartida" THEN BEGIN
                            CSP.TESTFIELD("No. Cuenta Contrapartida");
                            TipoContrapartida := 0;
                            NoCuentaContrapartida := CSP."No. Cuenta Contrapartida";
                        END;
                    END;

                END;
            END
            ELSE BEGIN
                CASE ConceptosSalariales."Tipo Cuenta Cuota Obrera" OF
                    0:
                        TipoCta := 0;
                    1:
                        TipoCta := 1;
                    ELSE
                        TipoCta := 2;
                END;

                IF TipoCta <> 1 THEN //Cliente
                   BEGIN
                    ConceptosSalariales.TESTFIELD("No. Cuenta Cuota Obrera");
                    NoCuenta := ConceptosSalariales."No. Cuenta Cuota Obrera";
                END;

                IF ConceptosSalariales."Validar Contrapartida CO" THEN BEGIN
                    ConceptosSalariales.TESTFIELD("No. Cuenta Contrapartida CO");
                    CASE ConceptosSalariales."Tipo Cuenta Contrapartida CO" OF
                        0:
                            TipoContrapartida := 0;
                        ELSE
                            TipoContrapartida := 2;
                    END;

                    NoCuentaContrapartida := ConceptosSalariales."No. Cuenta Contrapartida CO";
                END;
            END;
        END
        ELSE BEGIN
            CASE ConceptosSalariales."Tipo Cuenta Cuota Obrera" OF
                0:
                    TipoCta := 0;
                1:
                    TipoCta := 1;
                ELSE
                    TipoCta := 2;
            END;

            IF TipoCta <> 1 THEN //Cliente
               BEGIN
                "Conceptos Salariales Provision".TESTFIELD("No. Cuenta");
                NoCuenta := "Conceptos Salariales Provision"."No. Cuenta";
            END;

            IF "Conceptos Salariales Provision"."Validar Contrapartida" THEN BEGIN
                "Conceptos Salariales Provision".TESTFIELD("No. Cuenta Contrapartida");
                TipoContrapartida := 0;
                NoCuentaContrapartida := "Conceptos Salariales Provision"."No. Cuenta Contrapartida";
            END;
        END;

        IF NoCuenta = '' THEN
            ERROR(Err002);

        LlenaDatosCO(ConceptoSal, TipoCta, NoCuenta, ImportProrr, FALSE,
                      "Cab. nomina"."No. empleado");

        IF "Conceptos Salariales Provision"."Validar Contrapartida" THEN BEGIN
            LlenaDatosCO(ConceptoSal, TipoContrapartida, NoCuentaContrapartida, ImportProrr * -1,
               TRUE, "Cab. nomina"."No. empleado");
        END;
    end;

    procedure CxC()
    begin
        /*
        IF ConceptosSalariales.Codigo = ConfNomina."Concepto Salarial CxC Empl." THEN
           BEGIN
            GenJnlLine.RESET;
            IF CxCEmpl."Tipo Contrapartida" <> CxCEmpl."Tipo Contrapartida"::Cliente THEN
               BEGIN
                IF CxCEmpl."Tipo Contrapartida" = CxCEmpl."Tipo Contrapartida"::Proveedor THEN
                   GenJnlLine."Account Type"   := GenJnlLine."Account Type"::Vendor
                ELSE
                IF CxCEmpl."Tipo Contrapartida" = CxCEmpl."Tipo Contrapartida"::Cuenta THEN
                   GenJnlLine."Account Type"   := GenJnlLine."Account Type"::"G/L Account"
                ELSE
                   GenJnlLine."Account Type"   := GenJnlLine."Account Type"::"Bank Account";
        
                GenJnlLine.RESET;
                GenJnlLine.SETCURRENTKEY("Journal Template Name","Journal Batch Name","Posting Date","Account No.");
                GenJnlLine.SETRANGE("Journal Template Name", ConfNomina."Journal Template Name");
                GenJnlLine.SETRANGE("Journal Batch Name", CodSeccion);
                GenJnlLine.SETRANGE("Posting Date", FechaRegistro);
                GenJnlLine.SETRANGE("Account No.",CxCEmpl."Cta. Contrapartida");
                IF GenJnlLine.FINDFIRST THEN
                   BEGIN
                    GenJnlLine."Credit Amount" += total;
                    GenJnlLine.VALIDATE("Credit Amount");
                    GenJnlLine.MODIFY;
                    CxCMod := TRUE;
                   END;
               END
            ELSE
               BEGIN
                GenJnlLine."Account Type"      := GenJnlLine."Account Type"::Customer;
                GenJnlLine."Account No."       := Empleado."Codigo Cliente";
               END;
        
            GenJnlLine.VALIDATE("Account No.");
           END;
        */

    end;

    procedure InsertaContrapartidaCO(TmpContNomCont: Record 34002123)
    begin
        // GRN Graba contrapartida por el neto para pagos transferencias
        GenJnlLine.INIT;
        IF (TmpContNomCont."Importe Db" <> 0) OR (TmpContNomCont."Importe Cr" <> 0) THEN BEGIN
            ConfNomina.TESTFIELD("Cod. Cta. Nominas Pago Transf.");
            NoLinea += 1000;
            GenJnlLine."Journal Template Name" := ConfNomina."Journal Template Name";
            GenJnlLine."Journal Batch Name" := CodSeccion;
            GenJnlLine."Posting Date" := FechaRegistro;
            GenJnlLine."Document No." := NumDoc;
            GenJnlLine."Line No." := NoLinea;
            GenJnlLine.Description := Text001;
            IF (Tiposdenominas."Tipo de nomina" = Tiposdenominas."Tipo de nomina"::Prestaciones) THEN BEGIN
                ConfNomina.TESTFIELD("Cta. Nominas Otros Pagos");
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                GenJnlLine.VALIDATE("Account No.", ConfNomina."Cta. Nominas Otros Pagos");
            END
            ELSE BEGIN
                IF (ConfNomina."Tipo cuenta" = ConfNomina."Tipo cuenta"::Cuenta) THEN
                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account"
                ELSE
                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";

                GenJnlLine.VALIDATE("Account No.", ConfNomina."Cod. Cta. Nominas Pago Transf.");
            END;
            IF CodDivisa <> '' THEN
                GenJnlLine.VALIDATE("Currency Code", CodDivisa);
            GenJnlLine."Credit Amount" := ROUND(TmpContNomCont."Importe Db" - TmpContNomCont."Importe Cr",
                                                        Divisa."Amount Rounding Precision");
            GenJnlLine.VALIDATE("Credit Amount");
            IF GenJnlLine."Amount (LCY)" <> 0 THEN
                GenJnlLine.INSERT;
        END;

        // GRN Graba contrapartida por el neto para pagos diferentes transferencias
        GenJnlLine.INIT;
        IF (TmpContNomCont."Importe Db CK" <> 0) OR (TmpContNomCont."Importe Cr CK" <> 0) THEN BEGIN
            ConfNomina.TESTFIELD(ConfNomina."Cta. Nominas Otros Pagos");
            NoLinea += 1000;
            GenJnlLine."Journal Template Name" := ConfNomina."Journal Template Name";
            GenJnlLine."Journal Batch Name" := CodSeccion;
            GenJnlLine."Posting Date" := FechaRegistro;
            GenJnlLine."Document No." := NumDoc;
            GenJnlLine."Line No." := NoLinea;
            GenJnlLine.Description := Text001;
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";

            GenJnlLine.VALIDATE("Account No.", ConfNomina."Cta. Nominas Otros Pagos");
            IF CodDivisa <> '' THEN
                GenJnlLine.VALIDATE("Currency Code", CodDivisa);
            GenJnlLine."Credit Amount" := ROUND(TmpContNomCont."Importe Db CK" - TmpContNomCont."Importe Cr CK",
                                                        Divisa."Amount Rounding Precision");
            GenJnlLine.VALIDATE("Credit Amount");
            IF GenJnlLine."Amount (LCY)" <> 0 THEN
                GenJnlLine.INSERT;
        END;
    end;

    procedure InsertaContrapartidaCP(TmpContNomCont: Record 34002123)
    begin
        // GRN Graba contrapartida por el neto para pagos transferencias

        //MESSAGE('dbck %1   crck %2   db %3   cr %4',TmpContNomCont."Importe Db",TmpContNomCont."Importe Cr",
        //    TmpContNomCont."Importe Db CK"\,TmpContNomCont."Importe Cr CK");

        TmpContNomCont."Importe Db" := ROUND(TmpContNomCont."Importe Db", Divisa."Amount Rounding Precision");
        TmpContNomCont."Importe Cr" := ROUND(TmpContNomCont."Importe Cr", Divisa."Amount Rounding Precision");
        TmpContNomCont."Importe Db CK" := ROUND(TmpContNomCont."Importe Db CK", Divisa."Amount Rounding Precision");
        TmpContNomCont."Importe Cr CK" := ROUND(TmpContNomCont."Importe Cr CK", Divisa."Amount Rounding Precision");

        //   MESSAGE('dbck %1   crck %2   db %3   cr %4',TmpContNomCont."Importe Db",TmpContNomCont."Importe Cr",
        //   TmpContNomCont."Importe Db CK",TmpContNomCont."Importe Cr CK");

        GenJnlLine.INIT;
        IF ((TmpContNomCont."Importe Db" <> 0) OR (TmpContNomCont."Importe Cr" <> 0)) AND
            (TmpContNomCont."Importe Db" <> TmpContNomCont."Importe Cr") THEN BEGIN
            ConfNomina.TESTFIELD("Cod. Cta. Nominas Pago Transf.");
            NoLinea += 1000;
            GenJnlLine."Journal Template Name" := ConfNomina."Journal Template Name";
            GenJnlLine."Journal Batch Name" := CodSeccion;
            GenJnlLine."Posting Date" := FechaRegistro;
            GenJnlLine."Document No." := NumDoc;
            GenJnlLine."Line No." := NoLinea;
            GenJnlLine.Description := Text001;
            IF ConfNomina."Tipo cuenta" = ConfNomina."Tipo cuenta"::Cuenta THEN
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account"
            ELSE
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
            IF CodDivisa <> '' THEN
                GenJnlLine.VALIDATE("Currency Code", CodDivisa);
            GenJnlLine.VALIDATE("Account No.", ConfNomina."Cod. Cta. Nominas Pago Transf.");
            GenJnlLine."Debit Amount" := ROUND(TmpContNomCont."Importe Db", Divisa."Amount Rounding Precision");
            GenJnlLine.VALIDATE("Debit Amount");
            IF GenJnlLine."Amount (LCY)" <> 0 THEN
                GenJnlLine.INSERT;
        END;

        // GRN Graba contrapartida por el neto para pagos diferentes transferencias
        GenJnlLine.INIT;
        IF ((TmpContNomCont."Importe Db CK" <> 0) OR (TmpContNomCont."Importe Cr CK" <> 0)) AND
            (TmpContNomCont."Importe Db CK" <> TmpContNomCont."Importe Cr CK") THEN BEGIN
            ConfNomina.TESTFIELD(ConfNomina."Cta. Nominas Otros Pagos");
            NoLinea += 1000;
            GenJnlLine."Journal Template Name" := ConfNomina."Journal Template Name";
            GenJnlLine."Journal Batch Name" := CodSeccion;
            GenJnlLine."Posting Date" := FechaRegistro;
            GenJnlLine."Document No." := NumDoc;
            GenJnlLine."Line No." := NoLinea;
            GenJnlLine.Description := Text001;
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
            IF CodDivisa <> '' THEN
                GenJnlLine.VALIDATE("Currency Code", CodDivisa);
            GenJnlLine.VALIDATE("Account No.", ConfNomina."Cta. Nominas Otros Pagos");
            GenJnlLine."Debit Amount" := ROUND(TmpContNomCont."Importe Db CK", Divisa."Amount Rounding Precision");
            GenJnlLine.VALIDATE("Debit Amount");
            IF GenJnlLine."Amount (LCY)" <> 0 THEN
                GenJnlLine.INSERT;
        END;
    end;

    procedure UpdateDimSet(DimCode: Code[20]; DimValueCode: Code[20])
    var
        DimVal: Record 349;
    begin
        IF (DimCode = '') OR (DimValueCode = '') THEN
            EXIT;

        DimVal.GET(DimCode, DimValueCode);

        TempDimSetEntry.VALIDATE("Dimension Code", DimCode);
        TempDimSetEntry.VALIDATE("Dimension Value Code", DimValueCode);
        TempDimSetEntry.VALIDATE("Dimension Value ID", DimVal."Dimension Value ID");

        IF TempDimSetEntry.INSERT THEN;
    end;

    local procedure ProvisionaVacaciones(): Decimal
    var
        Fecha: Record 2000000007;
        DiasVacaciones: Integer;
        MontoVacacionesMesAnt: Decimal;
        MontoVacaciones: Decimal;
        FechaFin: Date;
        AnosAntiguedad: Integer;
        MesesAntiguedad: Integer;
        FechaDic: Date;
        FechaContrato: Date;
        Acumulado: Decimal;
    begin
        ConfNomina.GET();
        /*IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal THEN
           IF DATE2DMY(inicial,1) = 1 THEN
              EXIT;
              */
        Empleado.CALCFIELDS(Salario);
        IF Empleado."Employment Date" = 0D THEN
            ERROR(Err001, Empleado.FIELDCAPTION("Employment Date"), Empleado.TABLECAPTION, Empleado."No.");

        IF Empleado."Employment Date" = 0D THEN
            ERROR(Err001, Empleado.FIELDCAPTION("Employment Date"), Empleado.TABLECAPTION, Empleado."No.");

        IF Empleado."Employment Date" > inicial THEN
            DiasVacaciones := CalculoFechas.CalculoDiaVacaciones(Empleado."No.", DATE2DMY(Empleado."Employment Date", 2),
                                                                DATE2DMY(inicial, 3), MontoVacaciones, Empleado."Employment Date", final)
        ELSE
            DiasVacaciones := CalculoFechas.CalculoDiaVacaciones(Empleado."No.", DATE2DMY(inicial, 2),
                                                                DATE2DMY(inicial, 3), MontoVacaciones, Empleado."Employment Date", final);

        Acumulado := 0;

        //Busco los ingresos del periodo
        HistLinNom.RESET;
        HistLinNom.SETRANGE("No. empleado", Empleado."No.");
        HistLinNom.SETRANGE("Aplica para Regalia", TRUE);
        HistLinNom.SETRANGE(Periodo, DMY2DATE(1, DATE2DMY(inicial, 2), DATE2DMY(inicial, 3)), final);
        IF "Cab. nomina".GETFILTER("Job No.") <> '' THEN
            HistLinNom.SETFILTER("Job No.", "Cab. nomina".GETFILTER("Job No."));

        IF HistLinNom.FINDSET THEN
            REPEAT
                Acumulado += HistLinNom.Total;
            UNTIL HistLinNom.NEXT = 0;

        IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal THEN
            Acumulado := Acumulado / 12
        ELSE
            IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::"Bi-Semanal" THEN
                Acumulado := Acumulado / 26
            ELSE
                Acumulado /= 12;


        IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::"Bi-Semanal" THEN
            Empleado.Salario := Acumulado;

        Empleado.Salario := Acumulado / 23.83;

        IF DiasTranscurridos < 25 THEN BEGIN
            IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) OR
               (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::"Bi-Semanal") THEN
                MontoVacaciones := Empleado.Salario * DiasVacaciones
        END
        ELSE
            MontoVacaciones := Empleado.Salario * DiasVacaciones;

        //ERROR('%1 %2',MontoVacaciones,Empleado.Salario * DiasVacaciones/12);
        //error('%1 %2 %3 %4 %5 %6',Empleado."No.","Cab. nomina".Fin,DiasVacaciones,AnosAntiguedad,MesesAntiguedad,MontoVacaciones);
        //Cuando es vacaciones colectivas, el derecho se obtiene a partir del quinto mes
        //ERROR('%1',MontoVacaciones);

        EXIT(MontoVacaciones);


        /*GRN Esto Seccion hizo para elmufdi y ya No va
        ConfNomina.GET();
        Empleado.CALCFIELDS(Salario);
        IF Empleado."Employment Date" = 0D THEN
           ERROR(Err001,Empleado.FIELDCAPTION("Employment Date"),Empleado.TABLECAPTION,Empleado."No.");
        
        
        FechaContrato := Empleado."Employment Date";
        IF (FechaContrato >= inicial) AND (FechaContrato < final) THEN
           EXIT;
        
        IF DATE2DMY(Empleado."Employment Date",3) <> DATE2DMY(WORKDATE,3) THEN
           BEGIN
            FechaDic := DMY2DATE(31,12,DATE2DMY(WORKDATE,3));
            CalculoFechas.CalculoEntreFechas(Empleado."Employment Date",FechaDic,Anos,Meses,Dias);
            AnosAntiguedad := Anos;
            MesesAntiguedad := Meses;
          END;
        //Cuando es vacaciones colectivas, el Calculo se obtiene a partir del quinto mes
        IF NOT ConfNomina."Vacaciones colectivas" THEN
           BEGIN
            CalculoFechas.CalculoEntreFechas(Empleado."Employment Date","Cab. nomina".Fin,Anos,Meses,Dias);
            IF (Anos = 0) AND (Meses = 5) THEN
                 DiasVacaciones := CalculoFechas.CalculoDiaVacaciones(Empleado."No.",DATE2DMY(Empleado."Employment Date",2),
                                                          DATE2DMY(WORKDATE,3),MontoVacaciones,Empleado."Employment Date")
            ELSE
            IF (Anos = 0) AND ((Meses > 5) AND (Meses < 12)) THEN
                DiasVacaciones := 1
            ELSE
              DiasVacaciones := CalculoFechas.CalculoDiaVacaciones(Empleado."No.",DATE2DMY(Empleado."Employment Date",2),
                                                              DATE2DMY(WORKDATE,3),MontoVacaciones,Empleado."Employment Date");
           END
        ELSE
           BEGIN
            FechaFin := DMY2DATE(31,12,DATE2DMY(WORKDATE,3));
            CalculoFechas.CalculoEntreFechas(Empleado."Employment Date",FechaFin,Anos,Meses,Dias);
            IF (Anos = 0) AND (Meses = 5) THEN
                 DiasVacaciones := CalculoFechas.CalculoDiaVacaciones(Empleado."No.",DATE2DMY(Empleado."Employment Date",2),
                                                          DATE2DMY(WORKDATE,3),MontoVacaciones,Empleado."Employment Date")
            ELSE
            IF (Anos = 0) AND ((Meses > 5) AND (Meses < 12)) THEN
                DiasVacaciones := 1
            ELSE
              DiasVacaciones := CalculoFechas.CalculoDiaVacaciones(Empleado."No.",DATE2DMY(Empleado."Employment Date",2),
                                                              DATE2DMY(WORKDATE,3),MontoVacaciones,Empleado."Employment Date");
           END;
        
        //MESSAGE('%1 %2 %3 %4',Empleado."No.","Cab. nomina".Fin,DiasVacaciones);
        
        Empleado.Salario /= 23.83;
        
        IF DiasTranscurridos < 25 THEN
          BEGIN
            IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal THEN
              MontoVacaciones := (Empleado.Salario * DiasVacaciones) * 0.5
            ELSE
            IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::"Bi-Semanal" THEN
              MontoVacaciones := (Empleado.Salario * DiasVacaciones) * 0.5
          END
        ELSE
          MontoVacaciones := Empleado.Salario * DiasVacaciones;
        
        //Cuando es vacaciones colectivas, el derecho se obtiene a partir del quinto mes
        IF ConfNomina."Vacaciones colectivas" THEN
           BEGIN
            // Primero se busca el acumulado del mes anterior
            IF DATE2DMY(Empleado."Employment Date",3) <> DATE2DMY(WORKDATE,3) THEN
               BEGIN
                FechaDic := DMY2DATE(31,12,DATE2DMY(WORKDATE,3));
                CalculoFechas.CalculoEntreFechas(Empleado."Employment Date",FechaDic,Anos,Meses,Dias);
                AnosAntiguedad := Anos;
                MesesAntiguedad := Meses;
                FechaContrato := DMY2DATE(1,1,DATE2DMY(WORKDATE,3));
              END;
        
            IF (DATE2DMY(Empleado."Employment Date",2) = DATE2DMY(WORKDATE,2)) AND
               (DATE2DMY(Empleado."Employment Date",3) = DATE2DMY(WORKDATE,3)) THEN
               EXIT;
        
            FechaFin := CALCDATE('-1M',"Cab. nomina".Fin);
            Fecha.RESET;
            Fecha.SETRANGE("Period Type",Fecha."Period Type"::Month);
            Fecha.SETRANGE("Period Start",DMY2DATE(1,DATE2DMY(FechaFin,2),DATE2DMY(FechaFin,3)));
            IF Fecha.FINDFIRST THEN
               FechaFin:= NORMALDATE(Fecha."Period End");
        
        
            IF  FechaContrato > FechaFin THEN
               EXIT;
        
            CalculoFechas.CalculoEntreFechas(FechaContrato,FechaFin,Anos,Meses,Dias);
        
            IF (Anos = 0) AND (Meses = 5) THEN
                DiasVacaciones := CalculoFechas.CalculoDiaVacaciones(Empleado."No.",DATE2DMY(FechaFin,2),
                                                          DATE2DMY(FechaFin,3),MontoVacaciones,FechaContrato)
            ELSE
              BEGIN
                DiasVacaciones := CalculoFechas.CalculoDiaVacaciones(Empleado."No.",DATE2DMY(FechaFin,2),
                                                              DATE2DMY(FechaFin,3),MontoVacaciones,FechaContrato);
              END;
        
            IF AnosAntiguedad >= 5 THEN
               BEGIN
                CASE DiasVacaciones OF
                  6:
                   DiasVacaciones := 7;
                  7:
                   DiasVacaciones := 9;
                  8:
                   DiasVacaciones := 10;
                  9:
                   DiasVacaciones := 12;
                  10:
                   DiasVacaciones := 13;
                  11:
                   DiasVacaciones := 15;
                  12:
                   DiasVacaciones := 16;
                  14:
                   DiasVacaciones := 18;
                END;
               END;
            MontoVacacionesMesAnt := (Empleado.Salario * DiasVacaciones);
        // MESSAGE('%1 %2 %3 %4 %5 %6 %7 %8',Empleado."No.","Cab. nomina".Fin,DiasVacaciones,AnosAntiguedad,MesesAntiguedad,DiasTranscurridos,MontoVacaciones,MontoVacacionesMesAnt);
        {
            IF DiasTranscurridos < 25 THEN
              BEGIN
                IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal THEN
                  MontoVacacionesMesAnt := (Empleado.Salario * DiasVacaciones) * 0.5
                ELSE
                IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::"Bi-Semanal" THEN
                  MontoVacacionesMesAnt := (Empleado.Salario * DiasVacaciones) * 0.5
              END
            ELSE
              MontoVacacionesMesAnt := (Empleado.Salario * DiasVacaciones);
        }
            IF DATE2DMY("Cab. nomina".Fin,2) < 5 THEN
               MontoVacacionesMesAnt := 0;
        
           END;
        
           //Se busca el acumulado al periodo actual
             IF DATE2DMY(Empleado."Employment Date",3) <> DATE2DMY(WORKDATE,3) THEN
               BEGIN
                FechaDic := DMY2DATE(31,12,DATE2DMY(WORKDATE,3));
                CalculoFechas.CalculoEntreFechas(Empleado."Employment Date",FechaDic,Anos,Meses,Dias);
                AnosAntiguedad := Anos;
                MesesAntiguedad := Meses;
                Empleado."Employment Date" := DMY2DATE(1,1,DATE2DMY(WORKDATE,3));
              END;
        
            FechaFin := "Cab. nomina".Fin;
            Fecha.RESET;
            Fecha.SETRANGE("Period Type",Fecha."Period Type"::Month);
            Fecha.SETRANGE("Period Start",DMY2DATE(1,DATE2DMY(FechaFin,2),DATE2DMY(FechaFin,3)));
            IF Fecha.FINDFIRST THEN
               FechaFin:= NORMALDATE(Fecha."Period End");
        
            CalculoFechas.CalculoEntreFechas(Empleado."Employment Date",FechaFin,Anos,Meses,Dias);
        {
            //Para cuando el dia es el ultimo del mes
            IF DATE2DMY(FechaFin,1) = Dias THEN
               Meses += 1;
        }
            IF (Anos = 0) AND (Meses = 5) THEN
                DiasVacaciones := CalculoFechas.CalculoDiaVacaciones(Empleado."No.",DATE2DMY(FechaFin,2),
                                                          DATE2DMY(FechaFin,3),MontoVacaciones,Empleado."Employment Date")
        {    ELSE
            IF (Anos = 0) AND ((Meses > 5) AND (Meses < 12)) THEN
                DiasVacaciones := 1
        }
            ELSE
              BEGIN
                DiasVacaciones := CalculoFechas.CalculoDiaVacaciones(Empleado."No.",DATE2DMY(FechaFin,2),
                                                              DATE2DMY(FechaFin,3),MontoVacaciones,Empleado."Employment Date");
              END;
        
            IF AnosAntiguedad >= 5 THEN
               BEGIN
                CASE DiasVacaciones OF
                  6:
                   DiasVacaciones := 7;
                  7:
                   DiasVacaciones := 9;
                  8:
                   DiasVacaciones := 10;
                  9:
                   DiasVacaciones := 12;
                  10:
                   DiasVacaciones := 13;
                  11:
                   DiasVacaciones := 15;
                  12:
                   DiasVacaciones := 16;
                  14:
                   DiasVacaciones := 18;
                END;
               END;
        //    MontoVacaciones := (Empleado.Salario * DiasVacaciones);
        // MESSAGE('%1 %2 %3 %4 %5 %6 %7 %8',Empleado."No.","Cab. nomina".Fin,DiasVacaciones,AnosAntiguedad,MesesAntiguedad,DiasTranscurridos,MontoVacaciones,MontoVacacionesMesAnt);
        
        
        {
            IF DiasTranscurridos < 25 THEN
              BEGIN
                IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal THEN
                  MontoVacaciones := (Empleado.Salario * DiasVacaciones) * 0.5
                ELSE
                IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::"Bi-Semanal" THEN
                  MontoVacaciones := (Empleado.Salario * DiasVacaciones) * 0.5
              END
            ELSE
        }
            MontoVacaciones := Empleado.Salario * DiasVacaciones;
        
            IF DATE2DMY("Cab. nomina".Fin,2) < 5 THEN
               MontoVacaciones := 0;
        
        ERROR('%1 %2 %3 %4 %5',MontoVacaciones,MontoVacacionesMesAnt,MontoVacaciones - MontoVacacionesMesAnt,DiasVacaciones,Empleado.Salario);
            MontoVacaciones := MontoVacaciones - MontoVacacionesMesAnt;
        
        IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) OR
           (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::"Bi-Semanal") THEN
          MontoVacaciones /= 2;
        
        //ERROR('%1 %2 %3 %4 %5',MontoVacaciones,MontoVacacionesMesAnt,MontoVacaciones - MontoVacacionesMesAnt,DiasVacaciones,Contrato."Frecuencia de pago");
        
        EXIT(MontoVacaciones);
        */

    end;

    local procedure ProvisionaRegalia(): Decimal
    var
        DiasVacaciones: Integer;
        MontoVacaciones: Decimal;
        Acumulado: Decimal;
    begin
        IF Empleado."Employment Date" = 0D THEN
            ERROR(Err001, Empleado.FIELDCAPTION("Employment Date"), Empleado.TABLECAPTION, Empleado."No.");

        Acumulado := 0;
        //Busco los ingresos del periodo
        //Busqueda de todos los conceptos que cotizan para el calculo del Regalia
        HistLinNom.RESET;
        HistLinNom.SETRANGE("No. empleado", Empleado."No.");
        IF (ConfNomina."Registro de provision" = ConfNomina."Registro de provision"::"Bi-Semanal") OR
           (ConfNomina."Registro de provision" = ConfNomina."Registro de provision"::Quincenal) THEN BEGIN
            IF (Tiposdenominas."Dia inicio 1ra" > Tiposdenominas."Dia inicio 2da") AND (SegundaQ) AND (Tiposdenominas."Tipo de nomina" = Tiposdenominas."Tipo de nomina"::Regular) THEN
                HistLinNom.SETRANGE(Periodo, DMY2DATE(Tiposdenominas."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', inicial), 2), DATE2DMY(CALCDATE('-1M', final), 3)), final)
            ELSE
                IF (Tiposdenominas."Dia inicio 1ra" > Tiposdenominas."Dia inicio 2da") AND (Tiposdenominas."Tipo de nomina" = Tiposdenominas."Tipo de nomina"::Prestaciones) THEN
                    HistLinNom.SETRANGE(Periodo, DMY2DATE(Tiposdenominas."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', inicial), 2), DATE2DMY(CALCDATE('-1M', final), 3)), final)
                ELSE
                    HistLinNom.SETRANGE(Periodo, inicial, final);
        END
        ELSE
            HistLinNom.SETRANGE(Periodo, inicial, final);

        IF "Cab. nomina".GETFILTER("Job No.") <> '' THEN
            HistLinNom.SETFILTER("Job No.", "Cab. nomina".GETFILTER("Job No."));
        HistLinNom.SETFILTER("Tipo de nomina", "Cab. nomina".GETFILTER("Tipo de nomina"));
        HistLinNom.SETRANGE("Aplica para Regalia", TRUE);
        IF HistLinNom.FINDSET THEN
            REPEAT
                Acumulado += HistLinNom.Total;
            UNTIL HistLinNom.NEXT = 0;

        IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) OR
           (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::"Bi-Semanal") THEN
            Acumulado := Acumulado / 12
        /*ELSE
        IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::"Bi-Semanal" THEN
            Acumulado := Acumulado / 26
        */
        ELSE
            Acumulado /= 12;
        /*
        IF ConfNomina."Registro de provision" = ConfNomina."Registro de provision"::Quincenal
          BEGIN
            IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) OR
               (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::"Bi-Semanal") THEN
               Acumulado /= 2;
          END;
        */
        Acumulado := ROUND(Acumulado, 0.01);
        EXIT(Acumulado);

    end;

    local procedure ProvisionaBonificacion(): Decimal
    var
        DiasBonific: Integer;
        Acumulado: Decimal;
    begin

        //Busqueda de todos los conceptos que cotizan para el calculo del Regalia
        HistLinNom.RESET;
        HistLinNom.SETRANGE("No. empleado", Empleado."No.");
        IF (ConfNomina."Registro de provision" = ConfNomina."Registro de provision"::"Bi-Semanal") OR
           (ConfNomina."Registro de provision" = ConfNomina."Registro de provision"::Quincenal) THEN BEGIN
            IF (Tiposdenominas."Dia inicio 1ra" > Tiposdenominas."Dia inicio 2da") AND (SegundaQ) AND (Tiposdenominas."Tipo de nomina" = Tiposdenominas."Tipo de nomina"::Regular) THEN
                HistLinNom.SETRANGE(Periodo, DMY2DATE(Tiposdenominas."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', inicial), 2), DATE2DMY(CALCDATE('-1M', final), 3)), final)
            ELSE
                IF (Tiposdenominas."Dia inicio 1ra" > Tiposdenominas."Dia inicio 2da") AND (Tiposdenominas."Tipo de nomina" = Tiposdenominas."Tipo de nomina"::Prestaciones) THEN
                    HistLinNom.SETRANGE(Periodo, DMY2DATE(Tiposdenominas."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', inicial), 2), DATE2DMY(CALCDATE('-1M', final), 3)), final)
                ELSE
                    HistLinNom.SETRANGE(Periodo, inicial, final);
        END
        ELSE
            HistLinNom.SETRANGE(Periodo, inicial, final);

        IF "Cab. nomina".GETFILTER("Job No.") <> '' THEN
            HistLinNom.SETFILTER("Job No.", "Cab. nomina".GETFILTER("Job No."));
        HistLinNom.SETFILTER("Tipo de nomina", "Cab. nomina".GETFILTER("Tipo de nomina"));
        HistLinNom.SETRANGE("Aplica para Regalia", TRUE);
        IF HistLinNom.FINDSET THEN
            REPEAT
                Acumulado += HistLinNom.Total;
            UNTIL HistLinNom.NEXT = 0;
        //Busco los dias que tocan
        DiasBonific := CalculoFechas.CalculoDiasBonificacion(Empleado."No.", final);

        //Reviso datos del contrato
        IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) OR
           (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::"Bi-Semanal") THEN
            Acumulado /= 12
        ELSE
            IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Semanal) THEN
                Acumulado /= 26
            ELSE
                Acumulado /= 12;

        Acumulado /= 23.83;

        Acumulado := Acumulado * DiasBonific;
        /*
        IF DiasTranscurridos < 25 THEN
          BEGIN
            IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) OR
               (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::"Bi-Semanal") THEN
               Acumulado /= 2;
          END;
        */
        Acumulado := ROUND(Acumulado, 0.01);

        EXIT(Acumulado);

    end;

    procedure insertalindiariojOB(TmpContNom: Record 34002123)
    var
        Date: Record 2000000007;
        Date2: Record 2000000007;
        TSH: Record 950;
        TSL: Record 951;
        TSD: Record 952;
        Res: Record 156;
        ResourcesSetup: Record 314;
        REP: Record 34002171;
        DefDim: Record 352;
        JPL: Record 1003;
        DimMgt: Codeunit 408;
        EsImpuesto: Boolean;
    begin
        //GRN ResourcesSetup.GET();
        //GRN Res.GET(CodRecurso);

        //EsImpuesto := FALSE;
        /*
        REP.RESET;
        REP.SETRANGE("Employee No.",TmpContNom."Cod. Empleado");
        REP.SETRANGE("Concepto salarial",TmpContNom.Concepto);
        IF NOT REP.FINDFIRST THEN
           REP.INIT;
        
        
        IF TmpContNom.Concepto = '' THEN
           REP.INIT;
        
        TiposCotizacion.RESET;
        TiposCotizacion.SETRANGE(Codigo,TmpContNom.Concepto);
        IF TiposCotizacion.FINDLAST THEN
           EsImpuesto := TRUE;
        */

        NumLin += 1000;
        JobJNL.INIT;
        JobJNL.VALIDATE("Journal Template Name", ConfNomina."Job Journal Template Name");
        JobJNL.VALIDATE("Journal Batch Name", ConfNomina."Job Journal Batch Name");
        JobJNL."Line No." := NumLin;
        JobJNL.VALIDATE("Posting Date", FechaRegistro);
        JobJNL."Account Type" := JobJNL."Account Type"::"G/L Account";
        JobJNL."Document No." := NumDoc;
        JobJNL.VALIDATE("Account No.", TmpContNom."No. Cuenta");

        JobJNL.VALIDATE("Job No.", TmpContNom."Job code");
        JobJNL.VALIDATE("Job Task No.", TmpContNom."Job task");
        JobJNL."Job Line Type" := JobJNL."Job Line Type"::Billable;

        IF JobJNL."Job No." <> '' THEN
            JobJNL.VALIDATE("Job Quantity", 1);

        //Busco la linea de planificacion
        IF TmpContNom."Job code" <> '' THEN BEGIN
            JPL.RESET;
            JPL.SETRANGE("Job No.", TmpContNom."Job code");
            JPL.SETRANGE("Job Task No.", TmpContNom."Job task");
            JPL.SETRANGE(Type, JPL.Type::"G/L Account");
            JPL.SETRANGE("No.", ConfNomina."Cta. Lin. Planif. Proyectos");
            JPL.FINDFIRST;
            JobJNL.VALIDATE("Job Planning Line No.", JPL."Line No.");
        END;

        IF TmpContNom."Importe Db" <> 0 THEN
            JobJNL.VALIDATE(Amount, TmpContNom."Importe Db")
        ELSE
            IF TmpContNom."Importe Cr" <> 0 THEN
                JobJNL.VALIDATE(Amount, TmpContNom."Importe Cr" * -1)
            ELSE
                IF TmpContNom."Importe Db CK" <> 0 THEN
                    JobJNL.VALIDATE(Amount, TmpContNom."Importe Db CK")
                ELSE
                    IF TmpContNom."Importe Cr CK" <> 0 THEN
                        JobJNL.VALIDATE(Amount, TmpContNom."Importe Cr CK" * -1);

        IF JobJNL.INSERT(TRUE) THEN;

        CLEAR(TempDimSetEntry);
        TempDimSetEntry.DELETEALL;

        //Busco DefDim del Maestro
        DefDim.RESET;
        CASE TmpContNom."Tipo Cuenta" OF
            0: //Cuenta
                BEGIN
                    DefDim.SETRANGE("Table ID", 15);
                END;
            1: //Cliente
                BEGIN
                    DefDim.SETRANGE("Table ID", 18);
                END;
            2: //Proveedor
                BEGIN
                    DefDim.SETRANGE("Table ID", 23);
                END;
        END;

        DefDim.SETRANGE("Value Posting", DefDim."Value Posting"::"Same Code");
        DefDim.SETRANGE("No.", TmpContNom."No. Cuenta");
        IF DefDim.FINDSET THEN
            REPEAT
                UpdateDimSet(DefDim."Dimension Code", DefDim."Dimension Value Code");
            UNTIL DefDim.NEXT = 0;

        IF (TmpContNom."Cod. Dim 1" <> '') AND (TmpContNom."Valor Dim 1" <> '') THEN BEGIN
            UpdateDimSet(TmpContNom."Cod. Dim 1", TmpContNom."Valor Dim 1");
            IF ConfContabilidad."Global Dimension 1 Code" = TmpContNom."Cod. Dim 1" THEN
                JobJNL."Shortcut Dimension 1 Code" := TmpContNom."Valor Dim 1"
            ELSE
                IF ConfContabilidad."Global Dimension 2 Code" = TmpContNom."Cod. Dim 1" THEN
                    JobJNL."Shortcut Dimension 2 Code" := TmpContNom."Valor Dim 1"
        END;

        IF (TmpContNom."Cod. Dim 2" <> '') AND (TmpContNom."Valor Dim 2" <> '') THEN BEGIN
            TmpContNom.TESTFIELD("Cod. Dim 2");
            //    UpdateDimSet(TempDimSetEntry,TmpContNom."Cod. Dim 2",TmpContNom."Valor Dim 2");
            UpdateDimSet(TmpContNom."Cod. Dim 2", TmpContNom."Valor Dim 2");
            IF ConfContabilidad."Global Dimension 1 Code" = TmpContNom."Cod. Dim 2" THEN
                JobJNL."Shortcut Dimension 1 Code" := TmpContNom."Valor Dim 2"
            ELSE
                IF ConfContabilidad."Global Dimension 2 Code" = TmpContNom."Cod. Dim 2" THEN
                    JobJNL."Shortcut Dimension 2 Code" := TmpContNom."Valor Dim 2"
        END;

        IF (TmpContNom."Cod. Dim 3" <> '') AND (TmpContNom."Valor Dim 3" <> '') THEN BEGIN
            TmpContNom.TESTFIELD("Cod. Dim 3");
            UpdateDimSet(TmpContNom."Cod. Dim 3", TmpContNom."Valor Dim 3");
            IF ConfContabilidad."Global Dimension 1 Code" = TmpContNom."Cod. Dim 3" THEN
                JobJNL."Shortcut Dimension 1 Code" := TmpContNom."Valor Dim 3"
            ELSE
                IF ConfContabilidad."Global Dimension 2 Code" = TmpContNom."Cod. Dim 3" THEN
                    JobJNL."Shortcut Dimension 2 Code" := TmpContNom."Valor Dim 3"
        END;

        IF (TmpContNom."Cod. Dim 4" <> '') AND (TmpContNom."Valor Dim 4" <> '') THEN BEGIN
            TmpContNom.TESTFIELD("Cod. Dim 4");
            UpdateDimSet(TmpContNom."Cod. Dim 4", TmpContNom."Valor Dim 4");
            IF ConfContabilidad."Global Dimension 1 Code" = TmpContNom."Cod. Dim 4" THEN
                JobJNL."Shortcut Dimension 1 Code" := TmpContNom."Valor Dim 4"
            ELSE
                IF ConfContabilidad."Global Dimension 2 Code" = TmpContNom."Cod. Dim 4" THEN
                    JobJNL."Shortcut Dimension 2 Code" := TmpContNom."Valor Dim 4"
        END;

        IF (TmpContNom."Cod. Dim 5" <> '') AND (TmpContNom."Valor Dim 5" <> '') THEN BEGIN
            UpdateDimSet(TmpContNom."Cod. Dim 5", TmpContNom."Valor Dim 5");
            IF ConfContabilidad."Global Dimension 1 Code" = TmpContNom."Cod. Dim 5" THEN
                JobJNL."Shortcut Dimension 1 Code" := TmpContNom."Valor Dim 5"
            ELSE
                IF ConfContabilidad."Global Dimension 2 Code" = TmpContNom."Cod. Dim 5" THEN
                    JobJNL."Shortcut Dimension 2 Code" := TmpContNom."Valor Dim 5"
        END;

        IF (TmpContNom."Cod. Dim 6" <> '') AND (TmpContNom."Valor Dim 6" <> '') THEN BEGIN
            UpdateDimSet(TmpContNom."Cod. Dim 6", TmpContNom."Valor Dim 6");
            IF ConfContabilidad."Global Dimension 1 Code" = TmpContNom."Cod. Dim 6" THEN
                JobJNL."Shortcut Dimension 1 Code" := TmpContNom."Valor Dim 6"
            ELSE
                IF ConfContabilidad."Global Dimension 2 Code" = TmpContNom."Cod. Dim 6" THEN
                    JobJNL."Shortcut Dimension 2 Code" := TmpContNom."Valor Dim 6"
        END;
        /*
        IF (TmpContNom."Cod. Dim 1" <> '') AND (TmpContNom."Valor Dim 1" <>'') THEN
          UpdateDimSet(TmpContNom."Cod. Dim 1",TmpContNom."Valor Dim 1");
        
        IF (TmpContNom."Cod. Dim 2" <> '') AND (TmpContNom."Valor Dim 2" <>'') THEN
           BEGIN
            TmpContNom.TESTFIELD("Cod. Dim 2");
        //    UpdateDimSet(TempDimSetEntry,TmpContNom."Cod. Dim 2",TmpContNom."Valor Dim 2");
            UpdateDimSet(TmpContNom."Cod. Dim 2",TmpContNom."Valor Dim 2");
           END;
        
        IF (TmpContNom."Cod. Dim 3" <> '') AND (TmpContNom."Valor Dim 3" <>'') THEN
           BEGIN
            TmpContNom.TESTFIELD("Cod. Dim 3");
            UpdateDimSet(TmpContNom."Cod. Dim 3",TmpContNom."Valor Dim 3");
           END;
        
        IF (TmpContNom."Cod. Dim 4" <> '') AND (TmpContNom."Valor Dim 4" <>'') THEN
           BEGIN
            TmpContNom.TESTFIELD("Cod. Dim 4");
            UpdateDimSet(TmpContNom."Cod. Dim 4",TmpContNom."Valor Dim 4");
           END;
        
        IF (TmpContNom."Cod. Dim 5" <> '') AND (TmpContNom."Valor Dim 5" <>'') THEN
          UpdateDimSet(TmpContNom."Cod. Dim 5",TmpContNom."Valor Dim 5");
        
        IF (TmpContNom."Cod. Dim 6" <> '') AND (TmpContNom."Valor Dim 6" <>'') THEN
          UpdateDimSet(TmpContNom."Cod. Dim 6",TmpContNom."Valor Dim 6");
        */
        IF JobJNL."Job No." <> '' THEN BEGIN
            //Inserto Dim del proyecto
            DefDim.RESET;
            DefDim.SETRANGE("Value Posting", DefDim."Value Posting"::"Same Code");
            DefDim.SETRANGE("No.", TmpContNom."Job code");
            IF DefDim.FINDSET THEN
                REPEAT
                    UpdateDimSet(DefDim."Dimension Code", DefDim."Dimension Value Code");
                UNTIL DefDim.NEXT = 0;
        END;

        JobJNL."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);
        JobJNL.MODIFY;

    end;

    procedure LlenaDatosCOjOB(cConceptoSal: Code[20]; iTipoCuenta: Integer; cCodCuenta: Code[20]; dImporte: Decimal; Contrapartida: Boolean; CodEmpleado: Code[20])
    var
        REP: Record 34002171;
        TmpDCA: Record 34002123 temporary;
        NoCuenta: Code[20];
        ImporteTotalSalario: Decimal;
        ImporteTarea: Decimal;
        ImporteBase: Decimal;
        RateSalario: Decimal;
    begin
        //LlenadatosCO
        ConfNomina.TESTFIELD("Cta. Lin. Planif. Proyectos");

        CLEAR("Temp Contabilizacion Nom.");
        ContabNom.SETRANGE("Tipo Cuenta", iTipoCuenta);
        ContabNom.SETRANGE("No. Cuenta", cCodCuenta);
        ContabNom.SETRANGE(Concepto, cConceptoSal);
        ContabNom.SETRANGE("Forma de Cobro", "Cab. nomina"."Forma de Cobro");
        //contabnom.SETRANGE("Job code","Cab. nomina"."Job No.");
        ContabNom.SETRANGE(Step, 3);

        //Tabla temporal para poder calcula la distribucion de la provision
        tmpContab.SETRANGE("Tipo Cuenta", iTipoCuenta);
        tmpContab.SETRANGE("No. Cuenta", cCodCuenta);
        tmpContab.SETRANGE(Concepto, cConceptoSal);
        tmpContab.SETRANGE("Cod. Empleado", CodEmpleado);
        tmpContab.SETRANGE("Forma de Cobro", "Cab. nomina"."Forma de Cobro");
        //tmpcontab.SETRANGE("Job code","Cab. nomina"."Job No.");
        tmpContab.SETRANGE(Step, 3);

        DCA.RESET;
        DCA.SETFILTER("Fecha registro", "Cab. nomina".GETFILTER(Periodo));
        DCA.SETRANGE("Cod. Empleado", CodEmpleado);
        DCA.SETFILTER("Job No.", "Cab. nomina".GETFILTER("Job No."));
        IF cConceptoSal = ConfNomina."Concepto Horas Ext. 100%" THEN
            DCA.SETFILTER("Horas extras al 100", '<>%1', 0)
        ELSE
            IF cConceptoSal = ConfNomina."Concepto Horas Ext. 35%" THEN
                DCA.SETFILTER("Horas extras al 35", '<>%1', 0)
            ELSE
                IF cConceptoSal = ConfNomina."Concepto Dias feriados" THEN
                    DCA.SETFILTER("Horas feriadas", '<>%1', 0)
                ELSE
                    IF cConceptoSal = ConfNomina."Concepto Sal. Base" THEN
                        DCA.SETFILTER("Horas regulares", '<>%1', 0)
                    ELSE
                        DCA.SETFILTER("Horas regulares", '999999');

        IF DCA.FINDSET THEN
            REPEAT
                FiltraDimSet("Cab. nomina"."Dimension Set ID", "Lin. nomina"."Dimension Set ID", CodEmpleado); //Nueva programacion

                dImporte := 0;

                PerfilSal.RESET;
                PerfilSal.SETRANGE("Concepto salarial", cConceptoSal);
                PerfilSal.SETRANGE("No. empleado", DCA."Cod. Empleado");
                PerfilSal.FINDFIRST;

                IF NOT ConceptosSalariales."No distribuir en proyectos" THEN BEGIN
                    ContabNom.SETRANGE("Job code", DCA."Job No.");
                    ContabNom.SETRANGE("Job task", DCA."Job Task No.");
                    tmpContab.SETRANGE("Job code", DCA."Job No.");
                    tmpContab.SETRANGE("Job task", DCA."Job Task No.");
                END;

                IF (DCA."Horas extras al 100" <> 0) AND (cConceptoSal = ConfNomina."Concepto Horas Ext. 100%") THEN BEGIN
                    dImporte += PerfilSal.Importe * DCA."Horas extras al 100";
                END
                ELSE
                    IF (DCA."Horas extras al 35" <> 0) AND (cConceptoSal = ConfNomina."Concepto Horas Ext. 35%") THEN BEGIN
                        dImporte += PerfilSal.Importe * DCA."Horas extras al 35";
                    END
                    ELSE
                        IF (DCA."Horas feriadas" <> 0) AND (cConceptoSal = ConfNomina."Concepto Dias feriados") THEN BEGIN
                            dImporte += PerfilSal.Importe * DCA."Horas feriadas";
                        END
                        ELSE
                            IF (DCA."Horas regulares" <> 0) THEN BEGIN
                                dImporte += PerfilSal.Importe * DCA."Horas regulares";
                            END;

                IF ContabNom.FINDFIRST THEN BEGIN
                    IF NOT Contrapartida THEN BEGIN
                        IF "Cab. nomina"."Forma de Cobro" <> "Cab. nomina"."Forma de Cobro"::"Transferencia Banc." THEN BEGIN
                            IF dImporte > 0 THEN
                                ContabNom."Importe Db CK" += dImporte
                            ELSE
                                ContabNom."Importe Cr CK" += ABS(dImporte);
                        END
                        ELSE BEGIN
                            IF dImporte > 0 THEN
                                ContabNom."Importe Db" += dImporte
                            ELSE
                                ContabNom."Importe Cr" += ABS(dImporte);
                        END;
                    END
                    ELSE
                        IF "Cab. nomina"."Forma de Cobro" <> "Cab. nomina"."Forma de Cobro"::"Transferencia Banc." THEN BEGIN
                            IF dImporte > 0 THEN
                                ContabNom."Importe Db CK" := dImporte
                            ELSE
                                ContabNom."Importe Cr CK" := ABS(dImporte);

                        END
                        ELSE BEGIN
                            IF dImporte > 0 THEN
                                ContabNom."Importe Db" := dImporte
                            ELSE
                                ContabNom."Importe Cr" := ABS(dImporte);
                        END;
                END
                ELSE BEGIN
                    NoLin += 100;

                    CLEAR("Temp Contabilizacion Nom.");
                    ContabNom."Tipo Cuenta" := iTipoCuenta;
                    ContabNom."No. Cuenta" := cCodCuenta;
                    ContabNom."No. Linea" := NoLin;
                    ContabNom."Cod. Empleado" := CodEmpleado;
                    ContabNom.Concepto := cConceptoSal;
                    IF NOT ConceptosSalariales."No distribuir en proyectos" THEN BEGIN
                        ContabNom."Job code" := DCA."Job No.";
                        ContabNom."Job task" := DCA."Job Task No.";
                    END;

                    ContabNom."Forma de Cobro" := "Cab. nomina"."Forma de Cobro";
                    ContabNom.Step := 3;


                    IF NOT ConceptosSalariales."Contabilizacion Resumida" THEN
                        ContabNom.Descripcion := COPYSTR(Empleado."No." + ' ' + Empleado."Full Name", 1, 50)
                    ELSE
                        ContabNom.Descripcion := ConceptosSalariales.Descripcion;

                    IF NOT Contrapartida THEN BEGIN
                        IF "Cab. nomina"."Forma de Cobro" <> "Cab. nomina"."Forma de Cobro"::"Transferencia Banc." THEN BEGIN
                            IF dImporte > 0 THEN
                                ContabNom."Importe Db CK" += dImporte
                            ELSE
                                ContabNom."Importe Cr CK" += ABS(dImporte);
                        END
                        ELSE BEGIN
                            IF dImporte > 0 THEN
                                ContabNom."Importe Db" += dImporte
                            ELSE
                                ContabNom."Importe Cr" += ABS(dImporte);
                        END;
                    END
                    ELSE
                        IF "Cab. nomina"."Forma de Cobro" <> "Cab. nomina"."Forma de Cobro"::"Transferencia Banc." THEN BEGIN
                            IF dImporte > 0 THEN
                                ContabNom."Importe Db CK" := dImporte
                            ELSE
                                ContabNom."Importe Cr CK" := ABS(dImporte);

                        END
                        ELSE BEGIN
                            IF dImporte > 0 THEN
                                ContabNom."Importe Db" := dImporte
                            ELSE
                                ContabNom."Importe Cr" := ABS(dImporte);
                        END;
                    LlenaDimSet("Cab. nomina"."Dimension Set ID", "Lin. nomina"."Dimension Set ID"); //Nueva programacion

                END;

                IF dImporte <> 0 THEN BEGIN
                    IF NOT ContabNom.INSERT THEN
                        ContabNom.MODIFY;
                END;
                IF tmpContab.FINDFIRST THEN BEGIN
                    IF NOT Contrapartida THEN BEGIN
                        IF dImporte > 0 THEN
                            tmpContab."Importe Db" += dImporte
                        ELSE
                            tmpContab."Importe Cr" += ABS(dImporte);
                    END
                    ELSE BEGIN
                        IF dImporte > 0 THEN
                            tmpContab."Importe Cr" += dImporte
                        ELSE
                            tmpContab."Importe Db" += ABS(dImporte);
                    END;
                END
                ELSE BEGIN
                    NoLin += 100;

                    CLEAR("Temp Contabilizacion Nom.");
                    tmpContab."Tipo Cuenta" := iTipoCuenta;
                    tmpContab."No. Cuenta" := cCodCuenta;
                    tmpContab."No. Linea" := NoLin;
                    tmpContab."Cod. Empleado" := CodEmpleado;
                    tmpContab.Concepto := cConceptoSal;
                    IF NOT ConceptosSalariales."No distribuir en proyectos" THEN BEGIN
                        tmpContab."Job code" := DCA."Job No.";
                        tmpContab."Job task" := DCA."Job Task No.";
                    END;
                    tmpContab."Forma de Cobro" := "Cab. nomina"."Forma de Cobro";
                    tmpContab.Step := 3;

                    IF NOT ConceptosSalariales."Contabilizacion Resumida" THEN
                        tmpContab.Descripcion := COPYSTR(Empleado."No." + ' ' + Empleado."Full Name", 1, 50)
                    ELSE
                        tmpContab.Descripcion := ConceptosSalariales.Descripcion;

                    IF NOT Contrapartida THEN BEGIN
                        IF dImporte > 0 THEN
                            tmpContab."Importe Db" := dImporte
                        ELSE
                            tmpContab."Importe Cr" := ABS(dImporte);
                    END
                    ELSE BEGIN
                        IF dImporte > 0 THEN
                            tmpContab."Importe Cr" := dImporte
                        ELSE
                            tmpContab."Importe Db" := ABS(dImporte);
                    END;
                END;
                IF dImporte <> 0 THEN BEGIN
                    IF NOT tmpContab.INSERT THEN
                        tmpContab.MODIFY;
                END;
            UNTIL DCA.NEXT = 0

        ELSE
            IF NOT ConceptosSalariales."No distribuir en proyectos" THEN BEGIN
                ImporteTotalSalario := 0;
                RateSalario := 0;
                ImporteTarea := 0;
                ImporteBase := dImporte;

                //Busco el total del ingreso por concepto de salario para tener estimacion del % a distribuir por tarea
                HistLinNom.RESET;
                HistLinNom.SETRANGE("No. empleado", "Cab. nomina"."No. empleado");
                HistLinNom.SETRANGE(Periodo, inicial, final);
                HistLinNom.SETRANGE("Salario Base", TRUE);
                HistLinNom.SETRANGE("Tipo nomina", "Cab. nomina"."Tipo Nomina");
                HistLinNom.SETFILTER("Job No.", "Cab. nomina".GETFILTER("Job No."));
                IF HistLinNom.FINDSET THEN
                    REPEAT
                        ImporteTotalSalario := HistLinNom.Total;
                        RateSalario := HistLinNom."Importe Base";
                    UNTIL HistLinNom.NEXT = 0;

                //Busco todas las combinaciones de proyectos y tareas para el empleado
                TmpDCA.DELETEALL;

                DCA.RESET;
                DCA.SETRANGE("Fecha registro", inicial, final);
                DCA.SETRANGE("Cod. Empleado", "Cab. nomina"."No. empleado");
                DCA.SETFILTER("Job No.", "Cab. nomina".GETFILTER("Job No."));
                DCA.SETFILTER("Horas regulares", '>%1', 0);
                //IF DCA.FINDSET THEN
                DCA.FINDSET;
                REPEAT
                    TmpDCA.RESET;
                    TmpDCA.SETRANGE("Cod. Empleado", DCA."Cod. Empleado");
                    IF NOT ConceptosSalariales."No distribuir en proyectos" THEN BEGIN
                        TmpDCA.SETRANGE("Valor Dim 2", DCA."Job No.");
                        TmpDCA.SETRANGE("Valor Dim 3", DCA."Job Task No.");
                    END;

                    IF TmpDCA.FINDFIRST THEN
                        TmpDCA.Importe += DCA."Horas regulares" * RateSalario
                    ELSE BEGIN
                        TmpDCA.INIT;
                        TmpDCA."Cod. Empleado" := DCA."Cod. Empleado";
                        IF NOT ConceptosSalariales."No distribuir en proyectos" THEN BEGIN
                            TmpDCA."Valor Dim 2" := DCA."Job No.";
                            TmpDCA."Valor Dim 3" := DCA."Job Task No.";
                            TmpDCA.Importe += DCA."Horas regulares" * RateSalario;
                        END;
                    END;
                    IF NOT TmpDCA.INSERT THEN
                        TmpDCA.MODIFY;
                UNTIL DCA.NEXT = 0;
                //Para distribuir Importe
                TmpDCA.RESET;
                TmpDCA.FIND('-');
                REPEAT
                    ContabNom.RESET;
                    ContabNom.SETRANGE("Tipo Cuenta", iTipoCuenta);
                    ContabNom.SETRANGE("No. Cuenta", cCodCuenta);
                    ContabNom.SETRANGE(Concepto, cConceptoSal);
                    ContabNom.SETRANGE("Forma de Cobro", "Cab. nomina"."Forma de Cobro");
                    ContabNom.SETFILTER("Job code", "Cab. nomina".GETFILTER("Job No."));

                    ContabNom.SETRANGE(Step, 3);

                    FiltraDimSet("Cab. nomina"."Dimension Set ID", "Lin. nomina"."Dimension Set ID", CodEmpleado); //Nueva programacion
                    PerfilSal.RESET;
                    PerfilSal.SETRANGE("Concepto salarial", cConceptoSal);
                    PerfilSal.SETRANGE("No. empleado", CodEmpleado);
                    PerfilSal.FINDFIRST;

                    ImporteTarea := TmpDCA.Importe / ImporteTotalSalario; //Represento el % sobre el ingreso total
                    dImporte := ImporteBase * ImporteTarea; //Calculo la proporcion que toca a este prorrateo

                    IF NOT ConceptosSalariales."No distribuir en proyectos" THEN BEGIN
                        ContabNom.SETRANGE("Job code", TmpDCA."Valor Dim 2");
                        ContabNom.SETRANGE("Job task", TmpDCA."Valor Dim 3");
                    END;

                    IF ContabNom.FINDFIRST THEN BEGIN
                        IF NOT Contrapartida THEN BEGIN
                            IF dImporte > 0 THEN
                                ContabNom."Importe Db" += dImporte
                            ELSE
                                ContabNom."Importe Cr" += ABS(dImporte);
                        END
                        ELSE BEGIN
                            IF dImporte > 0 THEN
                                ContabNom."Importe Cr" += dImporte
                            ELSE
                                ContabNom."Importe Db" += ABS(dImporte);
                        END;
                    END
                    ELSE BEGIN
                        NoLin += 100;

                        CLEAR("Temp Contabilizacion Nom.");
                        ContabNom."Tipo Cuenta" := iTipoCuenta;
                        ContabNom."No. Cuenta" := cCodCuenta;
                        ContabNom."No. Linea" := NoLin;
                        ContabNom."Cod. Empleado" := CodEmpleado;
                        ContabNom.Concepto := cConceptoSal;
                        ContabNom."Forma de Cobro" := "Cab. nomina"."Forma de Cobro";
                        IF NOT ConceptosSalariales."No distribuir en proyectos" THEN BEGIN
                            ContabNom."Job code" := TmpDCA."Valor Dim 2";
                            ContabNom."Job task" := TmpDCA."Valor Dim 3";
                        END;
                        ContabNom.Step := 3;

                        IF NOT ConceptosSalariales."Contabilizacion Resumida" THEN
                            ContabNom.Descripcion := COPYSTR(Empleado."No." + ' ' + Empleado."Full Name", 1, 50)
                        ELSE
                            ContabNom.Descripcion := ConceptosSalariales.Descripcion;

                        IF NOT Contrapartida THEN BEGIN
                            IF dImporte > 0 THEN
                                ContabNom."Importe Db" := dImporte
                            ELSE
                                ContabNom."Importe Cr" := ABS(dImporte);
                        END
                        ELSE BEGIN
                            IF dImporte > 0 THEN
                                ContabNom."Importe Cr" := dImporte
                            ELSE
                                ContabNom."Importe Db" := ABS(dImporte);
                        END;

                        LlenaDimSet("Cab. nomina"."Dimension Set ID", "Lin. nomina"."Dimension Set ID");
                    END;
                    IF dImporte <> 0 THEN BEGIN
                        IF NOT ContabNom.INSERT THEN
                            ContabNom.MODIFY;
                    END;
                UNTIL TmpDCA.NEXT = 0;
            END
            ELSE BEGIN
                FiltraDimSet("Cab. nomina"."Dimension Set ID", "Lin. nomina"."Dimension Set ID", CodEmpleado); //Nueva programacion
                                                                                                               //    contabnom.FINDFIRST;
                IF ContabNom.FINDFIRST THEN
                    LlenaTempExiste(Contrapartida, dImporte)
                ELSE
                    LlenaTempNOExiste(iTipoCuenta, cCodCuenta, CodEmpleado, Contrapartida, dImporte, cConceptoSal, 3);
            END;
    end;

    procedure InsertaProvisionJob(ConceptoSal: Code[20]; ImportProrr: Decimal)
    var
        CSP: Record 34002119;
        TmpDCA: Record 34002123 temporary;
        NoCuenta: Code[20];
        ImporteTotalSalario: Decimal;
        ImporteTarea: Decimal;
    begin
        //Del Diario de pagos
        ConceptosSalariales.GET(ConceptoSal);
        //Del Historico de Nominas
        IF GpoContEmpl.GET(Empleado."Posting Group") THEN BEGIN
            ConfGpoContEmpl.SETRANGE(Codigo, GpoContEmpl.Codigo);
            ConfGpoContEmpl.SETRANGE("Codigo Concepto Salarial", ConceptoSal);
            IF ConfGpoContEmpl.FINDFIRST THEN BEGIN
                ConfGpoContEmpl.TESTFIELD("No. Cuenta Cuota Obrera");
                NoCuenta := ConfGpoContEmpl."No. Cuenta Cuota Obrera";
                CASE ConfGpoContEmpl."Tipo Cuenta Cuota Obrera" OF
                    0:
                        TipoCta := 0;
                    ELSE
                        TipoCta := 2;
                END;

                IF (ConceptosSalariales."Validar Contrapartida CO") AND (NOT ConfGpoContEmpl.Provisionar) THEN BEGIN
                    ConfGpoContEmpl.TESTFIELD("No. Cuenta Contrapartida CO");
                    CASE ConfGpoContEmpl."Tipo Cuenta Contrapartida CO" OF
                        0:
                            TipoContrapartida := 0;
                        ELSE
                            TipoContrapartida := 2;
                    END;

                    NoCuentaContrapartida := ConfGpoContEmpl."No. Cuenta Contrapartida CO";
                END;

                IF ConfGpoContEmpl.Provisionar THEN BEGIN
                    "Conceptos Salariales Provision".TESTFIELD("No. Cuenta");
                    NoCuenta := "Conceptos Salariales Provision"."No. Cuenta";

                    CSP.RESET;
                    CSP.SETRANGE(Codigo, ConceptoSal);
                    CSP.SETRANGE("Gpo. Contable Empleado", ConfGpoContEmpl.Codigo);
                    IF CSP.FINDFIRST THEN BEGIN
                        CSP.TESTFIELD("No. Cuenta");
                        NoCuenta := CSP."No. Cuenta";
                        TipoCta := 0;
                        ConceptosSalariales."Validar Contrapartida CO" := CSP."Validar Contrapartida";
                        IF CSP."Validar Contrapartida" THEN BEGIN
                            CSP.TESTFIELD("No. Cuenta Contrapartida");
                            TipoContrapartida := 0;
                            NoCuentaContrapartida := CSP."No. Cuenta Contrapartida";
                        END;
                    END;

                END;
            END
            ELSE BEGIN
                CASE ConceptosSalariales."Tipo Cuenta Cuota Obrera" OF
                    0:
                        TipoCta := 0;
                    1:
                        TipoCta := 1;
                    ELSE
                        TipoCta := 2;
                END;

                IF TipoCta <> 1 THEN //Cliente
                   BEGIN
                    ConceptosSalariales.TESTFIELD("No. Cuenta Cuota Obrera");
                    NoCuenta := ConceptosSalariales."No. Cuenta Cuota Obrera";
                END;

                IF ConceptosSalariales."Validar Contrapartida CO" THEN BEGIN
                    ConceptosSalariales.TESTFIELD("No. Cuenta Contrapartida CO");
                    CASE ConceptosSalariales."Tipo Cuenta Contrapartida CO" OF
                        0:
                            TipoContrapartida := 0;
                        ELSE
                            TipoContrapartida := 2;
                    END;

                    NoCuentaContrapartida := ConceptosSalariales."No. Cuenta Contrapartida CO";
                END;
            END;
        END
        ELSE BEGIN
            CASE ConceptosSalariales."Tipo Cuenta Cuota Obrera" OF
                0:
                    TipoCta := 0;
                1:
                    TipoCta := 1;
                ELSE
                    TipoCta := 2;
            END;

            IF TipoCta <> 1 THEN //Cliente
               BEGIN
                "Conceptos Salariales Provision".TESTFIELD("No. Cuenta");
                NoCuenta := "Conceptos Salariales Provision"."No. Cuenta";
            END;

            IF "Conceptos Salariales Provision"."Validar Contrapartida" THEN BEGIN
                "Conceptos Salariales Provision".TESTFIELD("No. Cuenta Contrapartida");
                TipoContrapartida := 0;
                NoCuentaContrapartida := "Conceptos Salariales Provision"."No. Cuenta Contrapartida";
            END;
        END;

        IF NoCuenta = '' THEN
            ERROR(Err002);

        ImporteTotalSalario := 0;
        ImporteTarea := 0;

        //Busco el total del ingreso por concepto de salario para tener estimacion del % a distribuir por tarea
        HistLinNom.RESET;
        HistLinNom.SETRANGE("No. empleado", "Cab. nomina"."No. empleado");
        HistLinNom.SETRANGE(Periodo, inicial, final);
        HistLinNom.SETRANGE("Salario Base", TRUE);
        HistLinNom.SETRANGE("Tipo nomina", "Cab. nomina"."Tipo Nomina");
        HistLinNom.SETFILTER("Job No.", "Cab. nomina".GETFILTER("Job No."));
        IF HistLinNom.FINDSET THEN
            REPEAT
                ImporteTotalSalario := HistLinNom.Total;
            UNTIL HistLinNom.NEXT = 0;

        //Busco todas las combinaciones de proyectos y tareas para el empleado
        TmpDCA.DELETEALL;

        DCA.RESET;
        DCA.SETRANGE("Fecha registro", inicial, final);
        DCA.SETRANGE("Cod. Empleado", "Cab. nomina"."No. empleado");
        DCA.SETFILTER("Job No.", "Cab. nomina".GETFILTER("Job No."));
        DCA.SETFILTER("Horas regulares", '>%1', 0);
        //IF DCA.FINDSET THEN
        DCA.FINDSET;
        REPEAT
            TmpDCA.INIT;
            TmpDCA."Cod. Empleado" := DCA."Cod. Empleado";
            TmpDCA."Valor Dim 2" := DCA."Job No.";
            TmpDCA."Valor Dim 3" := DCA."Job Task No.";
            IF TmpDCA.INSERT THEN;
        UNTIL DCA.NEXT = 0;

        //Para distribuir Importe
        TmpDCA.FIND('-');
        REPEAT
            tmpContab.RESET;
            tmpContab.SETRANGE("Cod. Empleado", "Cab. nomina"."No. empleado");
            tmpContab.SETRANGE(Concepto, ConfNomina."Concepto Sal. Base");
            tmpContab.SETRANGE("Job code", TmpDCA."Valor Dim 2");
            tmpContab.SETRANGE("Job task", TmpDCA."Valor Dim 3");
            tmpContab.FINDFIRST;

            ImporteTarea := (tmpContab."Importe Db" + tmpContab."Importe Db CK") / ImporteTotalSalario; //Represento el % sobre el ingreso total
            ImporteTarea := ImportProrr * ImporteTarea; //Calculo la proporcion que toca a este prorrateo


            LlenaDatosProvisionJOB(ConceptoSal, TipoCta, NoCuenta, ImporteTarea, FALSE,
                                      "Cab. nomina"."No. empleado", tmpContab."Job code", tmpContab."Job task");
            IF ConceptosSalariales."Validar Contrapartida CO" THEN
                LlenaDatosProvisionJOB(ConceptoSal, TipoContrapartida, NoCuentaContrapartida, ImporteTarea * -1, TRUE,
                                 "Cab. nomina"."No. empleado", '', '');

        UNTIL TmpDCA.NEXT = 0;
    end;

    procedure LlenaDatosProvisionJOB(cConceptoSal: Code[20]; iTipoCuenta: Integer; cCodCuenta: Code[20]; dImporte: Decimal; Contrapartida: Boolean; CodEmpleado: Code[20]; JobNo: Code[20]; JobTask: Code[20])
    var
        REP: Record 34002171;
    begin
        //LlenadatosCO
        ConfNomina.TESTFIELD("Cta. Lin. Planif. Proyectos");

        CLEAR("Temp Contabilizacion Nom.");
        ContabNom.SETRANGE("Tipo Cuenta", iTipoCuenta);
        ContabNom.SETRANGE("No. Cuenta", cCodCuenta);
        ContabNom.SETRANGE("Forma de Cobro", "Cab. nomina"."Forma de Cobro");
        ContabNom.SETRANGE("Job code", JobNo);
        ContabNom.SETRANGE("Job task", JobTask);
        ContabNom.SETRANGE(Concepto, cConceptoSal);
        ContabNom.SETRANGE("Cod. Empleado", CodEmpleado);
        ContabNom.SETRANGE(Step, 3);

        IF ContabNom.FINDFIRST THEN BEGIN
            IF NOT Contrapartida THEN BEGIN
                IF "Cab. nomina"."Forma de Cobro" <> "Cab. nomina"."Forma de Cobro"::"Transferencia Banc." THEN BEGIN
                    IF dImporte > 0 THEN
                        ContabNom."Importe Db CK" += dImporte
                    ELSE
                        ContabNom."Importe Cr CK" += ABS(dImporte);
                END
                ELSE BEGIN
                    IF dImporte > 0 THEN
                        ContabNom."Importe Db" += dImporte
                    ELSE
                        ContabNom."Importe Cr" += ABS(dImporte);
                END;
            END
            ELSE BEGIN
                IF "Cab. nomina"."Forma de Cobro" <> "Cab. nomina"."Forma de Cobro"::"Transferencia Banc." THEN BEGIN
                    IF dImporte > 0 THEN
                        ContabNom."Importe Db CK" += dImporte
                    ELSE
                        ContabNom."Importe Cr CK" += ABS(dImporte);
                END
                ELSE BEGIN
                    IF dImporte > 0 THEN
                        ContabNom."Importe Db" += dImporte
                    ELSE
                        ContabNom."Importe Cr" += ABS(dImporte);
                END;
            END;
        END
        ELSE BEGIN
            NoLin += 100;
            CLEAR("Temp Contabilizacion Nom.");
            ContabNom."Tipo Cuenta" := iTipoCuenta;
            ContabNom."No. Cuenta" := cCodCuenta;
            ContabNom."No. Linea" := NoLin;
            ContabNom."Cod. Empleado" := CodEmpleado;
            ContabNom.Step := 3;
            ContabNom."Job code" := JobNo;
            ContabNom."Job task" := JobTask;
            ContabNom.Contrapartida := Contrapartida;
            ContabNom.Concepto := cConceptoSal;
            ContabNom."Forma de Cobro" := "Cab. nomina"."Forma de Cobro";

            IF NOT ConceptosSalariales."Contabilizacion Resumida" THEN
                ContabNom.Descripcion := COPYSTR(Empleado."No." + ' ' + Empleado."Full Name", 1, 50)
            ELSE
                ContabNom.Descripcion := ConceptosSalariales.Descripcion;

            IF NOT Contrapartida THEN BEGIN
                IF "Cab. nomina"."Forma de Cobro" <> "Cab. nomina"."Forma de Cobro"::"Transferencia Banc." THEN BEGIN
                    IF dImporte > 0 THEN
                        ContabNom."Importe Db CK" := dImporte
                    ELSE
                        ContabNom."Importe Cr CK" := ABS(dImporte);
                END
                ELSE BEGIN
                    IF dImporte > 0 THEN
                        ContabNom."Importe Db" := dImporte
                    ELSE
                        ContabNom."Importe Cr" := ABS(dImporte);
                END;
            END
            ELSE BEGIN
                IF "Cab. nomina"."Forma de Cobro" <> "Cab. nomina"."Forma de Cobro"::"Transferencia Banc." THEN BEGIN
                    IF dImporte > 0 THEN
                        ContabNom."Importe Db CK" := dImporte
                    ELSE
                        ContabNom."Importe Cr CK" := ABS(dImporte);

                END
                ELSE BEGIN
                    IF dImporte > 0 THEN
                        ContabNom."Importe Db" := dImporte
                    ELSE
                        ContabNom."Importe Cr" := ABS(dImporte);
                END;
            END;

            recDimSet.RESET;
            //    recDimSet.SETFILTER("Dimension Set ID",'%1|%2',"Cab. nomina"."Dimension Set ID",DimSetId);
            recDimSet.SETFILTER("Dimension Set ID", '%1|%2', "Cab. nomina"."Dimension Set ID", HistLinNom."Dimension Set ID");
            IF recDimSet.FINDSET(FALSE, FALSE) THEN
                REPEAT
                    IF ConceptosSalariales."Contabilizacion x Dimension" THEN BEGIN
                        IF recDimSet."Dimension Code" = CodDim[1] THEN BEGIN
                            ContabNom."Cod. Dim 1" := recDimSet."Dimension Code";
                            ContabNom."Valor Dim 1" := recDimSet."Dimension Value Code";
                        END
                        ELSE
                            IF recDimSet."Dimension Code" = CodDim[2] THEN BEGIN
                                ContabNom."Cod. Dim 2" := recDimSet."Dimension Code";
                                ContabNom."Valor Dim 2" := recDimSet."Dimension Value Code";
                            END
                            ELSE
                                IF recDimSet."Dimension Code" = CodDim[3] THEN BEGIN
                                    ContabNom."Cod. Dim 3" := recDimSet."Dimension Code";
                                    ContabNom."Valor Dim 3" := recDimSet."Dimension Value Code";
                                END
                                ELSE
                                    IF recDimSet."Dimension Code" = CodDim[4] THEN BEGIN
                                        ContabNom."Cod. Dim 4" := recDimSet."Dimension Code";
                                        ContabNom."Valor Dim 4" := recDimSet."Dimension Value Code";
                                    END
                                    ELSE
                                        IF recDimSet."Dimension Code" = CodDim[5] THEN BEGIN
                                            ContabNom."Cod. Dim 5" := recDimSet."Dimension Code";
                                            ContabNom."Valor Dim 5" := recDimSet."Dimension Value Code";
                                        END
                                        ELSE
                                            IF recDimSet."Dimension Code" = CodDim[6] THEN BEGIN
                                                ContabNom."Cod. Dim 6" := recDimSet."Dimension Code";
                                                ContabNom."Valor Dim 6" := recDimSet."Dimension Value Code";
                                            END;
                        ContabNom."Dimension Set ID" := recDimSet."Dimension Set ID";
                    END;
                UNTIL recDimSet.NEXT = 0
        END;

        //   MESSAGE('%1 %2 %3 %4',cConceptoSal,contabnom."Valor Dim 4",ConceptosSalariales.Prorratear);
        //MESSAGE('%1',"Temp Contabilizacion Nom.");
        IF ConceptosSalariales.Provisionar THEN BEGIN
            FOR i := 1 TO 6 DO BEGIN
                IF ConfNomina."Dimension Conceptos Salariales" = CodDim[i] THEN BEGIN
                    IF ContabNom."Cod. Dim 1" = CodDim[i] THEN
                        ContabNom."Valor Dim 1" := cConceptoSal
                    ELSE
                        IF ContabNom."Cod. Dim 2" = CodDim[i] THEN
                            ContabNom."Valor Dim 2" := cConceptoSal
                        ELSE
                            IF ContabNom."Cod. Dim 3" = CodDim[i] THEN
                                ContabNom."Valor Dim 3" := cConceptoSal
                            ELSE
                                IF ContabNom."Cod. Dim 4" = CodDim[i] THEN
                                    ContabNom."Valor Dim 4" := cConceptoSal
                                ELSE
                                    IF ContabNom."Cod. Dim 5" = CodDim[i] THEN
                                        ContabNom."Valor Dim 5" := cConceptoSal
                                    ELSE
                                        IF ContabNom."Cod. Dim 6" = CodDim[i] THEN
                                            ContabNom."Valor Dim 6" := cConceptoSal;
                END;
            END;
        END;
        //Para las Dim del perfil de salario (linea del concepto salarial)
        //Para las Dim por Grupo contable
        DefDim.RESET;
        DefDim.SETFILTER("Table ID", '%1|%2|%3', 34002105, 34002111, 34002115);
        IF Empleado."Posting Group" <> '' THEN
            DefDim.SETFILTER("No.", Empleado."Posting Group" + '*' + cConceptoSal + '*')
        ELSE
            DefDim.SETFILTER("No.", '*' + cConceptoSal + '*');
        IF DefDim.FINDSET THEN
            REPEAT
                // ERROR('%1\%2',DefDim.GETFILTERS,DefDim);
                IF CodDim[1] = DefDim."Dimension Code" THEN BEGIN
                    ContabNom."Cod. Dim 1" := DefDim."Dimension Code";
                    ContabNom."Valor Dim 1" := DefDim."Dimension Value Code";
                END
                ELSE
                    IF CodDim[2] = DefDim."Dimension Code" THEN BEGIN
                        ContabNom."Cod. Dim 2" := DefDim."Dimension Code";
                        ContabNom."Valor Dim 2" := DefDim."Dimension Value Code";
                    END
                    ELSE
                        IF CodDim[3] = DefDim."Dimension Code" THEN BEGIN
                            ContabNom."Cod. Dim 3" := DefDim."Dimension Code";
                            ContabNom."Valor Dim 3" := DefDim."Dimension Value Code";
                        END
                        ELSE
                            IF CodDim[4] = DefDim."Dimension Code" THEN BEGIN
                                ContabNom."Cod. Dim 4" := DefDim."Dimension Code";
                                ContabNom."Valor Dim 4" := DefDim."Dimension Value Code";
                            END
                            ELSE
                                IF CodDim[5] = DefDim."Dimension Code" THEN BEGIN
                                    ContabNom."Cod. Dim 5" := DefDim."Dimension Code";
                                    ContabNom."Valor Dim 5" := DefDim."Dimension Value Code";
                                END
                                ELSE
                                    IF CodDim[6] = DefDim."Dimension Code" THEN BEGIN
                                        ContabNom."Cod. Dim 6" := DefDim."Dimension Code";
                                        ContabNom."Valor Dim 6" := DefDim."Dimension Value Code";
                                    END;
            UNTIL DefDim.NEXT = 0;

        IF NOT ContabNom.INSERT THEN
            ContabNom.MODIFY;
    end;

    procedure LlenaDatosDescJob(cConceptoSal: Code[20]; iTipoCuenta: Integer; cCodCuenta: Code[20]; dImporte: Decimal; Contrapartida: Boolean; CodEmpleado: Code[20]; JobNo: Code[20]; JobTask: Code[20]; Paso: Integer; DimSetId: Integer)
    begin
        //LlenadatosCOJOB
        CLEAR("Temp Contabilizacion Nom.");
        ContabNom.SETRANGE("Tipo Cuenta", iTipoCuenta);
        ContabNom.SETRANGE("No. Cuenta", cCodCuenta);
        ContabNom.SETRANGE("Forma de Cobro", "Cab. nomina"."Forma de Cobro");
        ContabNom.SETRANGE("Job code", JobNo);
        ContabNom.SETRANGE("Job task", JobTask);
        ContabNom.SETRANGE(Step, Paso);

        recDimSet.RESET;
        recDimSet.SETFILTER("Dimension Set ID", '%1|%2', "Cab. nomina"."Dimension Set ID", DimSetId);
        IF recDimSet.FINDSET(FALSE, FALSE) THEN
            REPEAT
                IF ConceptosSalariales."Contabilizacion x Dimension" THEN BEGIN
                    IF recDimSet."Dimension Code" = CodDim[1] THEN BEGIN
                        ContabNom.SETRANGE("Cod. Dim 1", recDimSet."Dimension Code");
                        ContabNom.SETRANGE("Valor Dim 1", recDimSet."Dimension Value Code");
                    END;

                    IF recDimSet."Dimension Code" = CodDim[2] THEN BEGIN
                        ContabNom.SETRANGE("Cod. Dim 2", recDimSet."Dimension Code");
                        ContabNom.SETRANGE("Valor Dim 2", recDimSet."Dimension Value Code");
                    END;

                    IF recDimSet."Dimension Code" = CodDim[3] THEN BEGIN
                        ContabNom.SETRANGE("Cod. Dim 3", recDimSet."Dimension Code");
                        ContabNom.SETRANGE("Valor Dim 3", recDimSet."Dimension Value Code");
                    END;

                    IF recDimSet."Dimension Code" = CodDim[4] THEN BEGIN
                        ContabNom.SETRANGE("Cod. Dim 4", recDimSet."Dimension Code");
                        ContabNom.SETRANGE("Valor Dim 4", recDimSet."Dimension Value Code");
                    END;

                    IF recDimSet."Dimension Code" = CodDim[5] THEN BEGIN
                        ContabNom.SETRANGE("Cod. Dim 5", recDimSet."Dimension Code");
                        ContabNom.SETRANGE("Valor Dim 5", recDimSet."Dimension Value Code");
                    END;

                    IF recDimSet."Dimension Code" = CodDim[6] THEN BEGIN
                        ContabNom.SETRANGE("Cod. Dim 6", recDimSet."Dimension Code");
                        ContabNom.SETRANGE("Valor Dim 6", recDimSet."Dimension Value Code");
                    END;
                    IF NOT ConceptosSalariales."Contabilizacion Resumida" THEN
                        ContabNom.SETRANGE("Cod. Empleado", CodEmpleado);

                END;
            UNTIL recDimSet.NEXT = 0;

        IF ContabNom.FINDFIRST THEN BEGIN
            IF NOT Contrapartida THEN BEGIN
                IF "Cab. nomina"."Forma de Cobro" <> "Cab. nomina"."Forma de Cobro"::"Transferencia Banc." THEN BEGIN
                    IF dImporte > 0 THEN
                        ContabNom."Importe Db CK" += dImporte
                    ELSE
                        ContabNom."Importe Cr CK" += ABS(dImporte);
                END
                ELSE BEGIN
                    IF dImporte > 0 THEN
                        ContabNom."Importe Db" += dImporte
                    ELSE
                        ContabNom."Importe Cr" += ABS(dImporte);
                END;
            END
            ELSE BEGIN
                IF "Cab. nomina"."Forma de Cobro" <> "Cab. nomina"."Forma de Cobro"::"Transferencia Banc." THEN BEGIN
                    IF dImporte > 0 THEN
                        ContabNom."Importe Db CK" += dImporte
                    ELSE
                        ContabNom."Importe Cr CK" += ABS(dImporte);
                END
                ELSE BEGIN
                    IF dImporte > 0 THEN
                        ContabNom."Importe Db" += dImporte
                    ELSE
                        ContabNom."Importe Cr" += ABS(dImporte);
                END;
            END;
        END
        ELSE BEGIN
            NoLin += 100;

            CLEAR("Temp Contabilizacion Nom.");
            ContabNom."Tipo Cuenta" := iTipoCuenta;
            ContabNom."No. Cuenta" := cCodCuenta;
            ContabNom."No. Linea" := NoLin;
            ContabNom."Cod. Empleado" := CodEmpleado;
            ContabNom.Step := Paso;
            ContabNom."Job code" := JobNo;
            ContabNom."Job task" := JobTask;
            ContabNom."Forma de Cobro" := "Cab. nomina"."Forma de Cobro";
            ContabNom.Concepto := cConceptoSal;
            ContabNom.Contrapartida := Contrapartida;
            IF NOT ConceptosSalariales."Contabilizacion Resumida" THEN
                ContabNom.Descripcion := COPYSTR(Empleado."No." + ' ' + Empleado."Full Name", 1, 50)
            ELSE
                ContabNom.Descripcion := ConceptosSalariales.Descripcion;

            IF NOT Contrapartida THEN BEGIN
                IF "Cab. nomina"."Forma de Cobro" <> "Cab. nomina"."Forma de Cobro"::"Transferencia Banc." THEN BEGIN
                    IF dImporte > 0 THEN
                        ContabNom."Importe Db CK" := dImporte
                    ELSE
                        ContabNom."Importe Cr CK" := ABS(dImporte);
                END
                ELSE BEGIN
                    IF dImporte > 0 THEN
                        ContabNom."Importe Db" := dImporte
                    ELSE
                        ContabNom."Importe Cr" := ABS(dImporte);
                END;
            END
            ELSE BEGIN
                IF "Cab. nomina"."Forma de Cobro" <> "Cab. nomina"."Forma de Cobro"::"Transferencia Banc." THEN BEGIN
                    IF dImporte > 0 THEN
                        ContabNom."Importe Db CK" := dImporte
                    ELSE
                        ContabNom."Importe Cr CK" := ABS(dImporte);

                END
                ELSE BEGIN
                    IF dImporte > 0 THEN
                        ContabNom."Importe Db" := dImporte
                    ELSE
                        ContabNom."Importe Cr" := ABS(dImporte);
                END;
            END;

            recDimSet.RESET;
            recDimSet.SETFILTER("Dimension Set ID", '%1|%2', "Cab. nomina"."Dimension Set ID", DimSetId);
            IF recDimSet.FINDSET(FALSE, FALSE) THEN
                REPEAT
                    IF ConceptosSalariales."Contabilizacion x Dimension" THEN BEGIN
                        IF recDimSet."Dimension Code" = CodDim[1] THEN BEGIN
                            ContabNom."Cod. Dim 1" := recDimSet."Dimension Code";
                            ContabNom."Valor Dim 1" := recDimSet."Dimension Value Code";
                        END
                        ELSE
                            IF recDimSet."Dimension Code" = CodDim[2] THEN BEGIN
                                ContabNom."Cod. Dim 2" := recDimSet."Dimension Code";
                                ContabNom."Valor Dim 2" := recDimSet."Dimension Value Code";
                            END
                            ELSE
                                IF recDimSet."Dimension Code" = CodDim[3] THEN BEGIN
                                    ContabNom."Cod. Dim 3" := recDimSet."Dimension Code";
                                    ContabNom."Valor Dim 3" := recDimSet."Dimension Value Code";
                                END
                                ELSE
                                    IF recDimSet."Dimension Code" = CodDim[4] THEN BEGIN
                                        ContabNom."Cod. Dim 4" := recDimSet."Dimension Code";
                                        ContabNom."Valor Dim 4" := recDimSet."Dimension Value Code";
                                    END
                                    ELSE
                                        IF recDimSet."Dimension Code" = CodDim[5] THEN BEGIN
                                            ContabNom."Cod. Dim 5" := recDimSet."Dimension Code";
                                            ContabNom."Valor Dim 5" := recDimSet."Dimension Value Code";
                                        END
                                        ELSE
                                            IF recDimSet."Dimension Code" = CodDim[6] THEN BEGIN
                                                ContabNom."Cod. Dim 6" := recDimSet."Dimension Code";
                                                ContabNom."Valor Dim 6" := recDimSet."Dimension Value Code";
                                            END;
                        ContabNom."Dimension Set ID" := recDimSet."Dimension Set ID";
                    END;
                UNTIL recDimSet.NEXT = 0
        END;

        //   MESSAGE('%1 %2 %3 %4',cConceptoSal,contabnom."Valor Dim 4",ConceptosSalariales.Prorratear);
        //MESSAGE('%1',"Temp Contabilizacion Nom.");
        IF ConceptosSalariales.Provisionar THEN BEGIN
            FOR i := 1 TO 6 DO BEGIN
                IF ConfNomina."Dimension Conceptos Salariales" = CodDim[i] THEN BEGIN
                    IF ContabNom."Cod. Dim 1" = CodDim[i] THEN
                        ContabNom."Valor Dim 1" := cConceptoSal
                    ELSE
                        IF ContabNom."Cod. Dim 2" = CodDim[i] THEN
                            ContabNom."Valor Dim 2" := cConceptoSal
                        ELSE
                            IF ContabNom."Cod. Dim 3" = CodDim[i] THEN
                                ContabNom."Valor Dim 3" := cConceptoSal
                            ELSE
                                IF ContabNom."Cod. Dim 4" = CodDim[i] THEN
                                    ContabNom."Valor Dim 4" := cConceptoSal
                                ELSE
                                    IF ContabNom."Cod. Dim 5" = CodDim[i] THEN
                                        ContabNom."Valor Dim 5" := cConceptoSal
                                    ELSE
                                        IF ContabNom."Cod. Dim 6" = CodDim[i] THEN
                                            ContabNom."Valor Dim 6" := cConceptoSal;
                END;
            END;
        END;
        //Para las Dim del perfil de salario (linea del concepto salarial)
        //Para las Dim por Grupo contable
        DefDim.RESET;
        DefDim.SETFILTER("Table ID", '%1|%2|%3', 34002105, 34002111, 34002115);
        IF Empleado."Posting Group" <> '' THEN
            DefDim.SETFILTER("No.", Empleado."Posting Group" + '*' + cConceptoSal + '*')
        ELSE
            DefDim.SETFILTER("No.", '*' + cConceptoSal + '*');
        IF DefDim.FINDSET THEN
            REPEAT
                IF CodDim[1] = DefDim."Dimension Code" THEN BEGIN
                    ContabNom."Cod. Dim 1" := DefDim."Dimension Code";
                    ContabNom."Valor Dim 1" := DefDim."Dimension Value Code";
                END
                ELSE
                    IF CodDim[2] = DefDim."Dimension Code" THEN BEGIN
                        ContabNom."Cod. Dim 2" := DefDim."Dimension Code";
                        ContabNom."Valor Dim 2" := DefDim."Dimension Value Code";
                    END
                    ELSE
                        IF CodDim[3] = DefDim."Dimension Code" THEN BEGIN
                            ContabNom."Cod. Dim 3" := DefDim."Dimension Code";
                            ContabNom."Valor Dim 3" := DefDim."Dimension Value Code";
                        END
                        ELSE
                            IF CodDim[4] = DefDim."Dimension Code" THEN BEGIN
                                ContabNom."Cod. Dim 4" := DefDim."Dimension Code";
                                ContabNom."Valor Dim 4" := DefDim."Dimension Value Code";
                            END
                            ELSE
                                IF CodDim[5] = DefDim."Dimension Code" THEN BEGIN
                                    ContabNom."Cod. Dim 5" := DefDim."Dimension Code";
                                    ContabNom."Valor Dim 5" := DefDim."Dimension Value Code";
                                END
                                ELSE
                                    IF CodDim[6] = DefDim."Dimension Code" THEN BEGIN
                                        ContabNom."Cod. Dim 6" := DefDim."Dimension Code";
                                        ContabNom."Valor Dim 6" := DefDim."Dimension Value Code";
                                    END;
            UNTIL DefDim.NEXT = 0;

        IF NOT ContabNom.INSERT THEN
            ContabNom.MODIFY;
    end;

    procedure InsertaContrapartidaCOJob(TmpContNomCont: Record 34002123)
    begin
        // GRN Graba contrapartida por el neto para pagos transferencias
        TmpContNomCont."Importe Db" := ROUND(TmpContNomCont."Importe Db", Divisa."Amount Rounding Precision");
        TmpContNomCont."Importe Cr" := ROUND(TmpContNomCont."Importe Cr", Divisa."Amount Rounding Precision");
        TmpContNomCont."Importe Db CK" := ROUND(TmpContNomCont."Importe Db CK", Divisa."Amount Rounding Precision");
        TmpContNomCont."Importe Cr CK" := ROUND(TmpContNomCont."Importe Cr CK", Divisa."Amount Rounding Precision");

        IF (TmpContNomCont."Importe Db" <> 0) OR (TmpContNomCont."Importe Cr" <> 0) THEN BEGIN
            ConfNomina.TESTFIELD("Cod. Cta. Nominas Pago Transf.");
            NumLin += 1000;

            JobJNL.INIT;
            JobJNL.VALIDATE("Journal Template Name", ConfNomina."Job Journal Template Name");
            JobJNL.VALIDATE("Journal Batch Name", ConfNomina."Job Journal Batch Name");
            JobJNL."Line No." := NumLin;
            JobJNL.VALIDATE("Posting Date", FechaRegistro);
            JobJNL."Document No." := NumDoc;
            JobJNL."Account Type" := JobJNL."Account Type"::"G/L Account";
            JobJNL.VALIDATE("Account No.", ConfNomina."Cod. Cta. Nominas Pago Transf.");

            //    JobJNL.VALIDATE(Quantity,1);
            JobJNL."Credit Amount" := ROUND(TmpContNomCont."Importe Db" - TmpContNomCont."Importe Cr",
                                                        Divisa."Amount Rounding Precision");
            JobJNL.VALIDATE("Credit Amount");
            //    IF JobJNL.INSERT(TRUE) THEN;
            JobJNL.INSERT(TRUE);

        END;

        //ERROR('a%1 b%2 c%3 d%4',TmpContNomCont."Importe Db", TmpContNomCont."Importe Cr",TmpContNomCont."Importe Db ck", TmpContNomCont."Importe Cr ck");
        // GRN Graba contrapartida por el neto para pagos diferentes transferencias
        GenJnlLine.INIT;
        IF (TmpContNomCont."Importe Db CK" <> 0) OR (TmpContNomCont."Importe Cr CK" <> 0) THEN BEGIN
            ConfNomina.TESTFIELD(ConfNomina."Cta. Nominas Otros Pagos");
            NumLin += 1000;
            JobJNL.INIT;
            JobJNL.VALIDATE("Journal Template Name", ConfNomina."Job Journal Template Name");
            JobJNL.VALIDATE("Journal Batch Name", ConfNomina."Job Journal Batch Name");
            JobJNL."Line No." := NumLin;
            JobJNL.VALIDATE("Posting Date", FechaRegistro);
            JobJNL."Account Type" := JobJNL."Account Type"::"G/L Account";
            JobJNL."Document No." := NumDoc;
            JobJNL.VALIDATE("Account No.", ConfNomina."Cta. Nominas Otros Pagos");
            JobJNL.Description := Text001;
            JobJNL."Credit Amount" := ROUND(TmpContNomCont."Importe Db CK" - TmpContNomCont."Importe Cr CK",
                                                        Divisa."Amount Rounding Precision");

            JobJNL.VALIDATE("Credit Amount");
            JobJNL.INSERT(TRUE);
        END;
    end;

    procedure InsertaContrapartidaCPJob(TmpContNomCont: Record 34002123)
    begin
        // GRN Graba contrapartida por el neto para pagos transferencias
        /*
            error('dbck %1   crck %2   db %3   cr %4',TmpContNomCont."Importe Db",TmpContNomCont."Importe Cr",
            TmpContNomCont."Importe Db CK",TmpContNomCont."Importe Cr CK");
        */
        TmpContNomCont."Importe Db" := ROUND(TmpContNomCont."Importe Db", Divisa."Amount Rounding Precision");
        TmpContNomCont."Importe Cr" := ROUND(TmpContNomCont."Importe Cr", Divisa."Amount Rounding Precision");
        TmpContNomCont."Importe Db CK" := ROUND(TmpContNomCont."Importe Db CK", Divisa."Amount Rounding Precision");
        TmpContNomCont."Importe Cr CK" := ROUND(TmpContNomCont."Importe Cr CK", Divisa."Amount Rounding Precision");

        JobJNL.INIT;
        IF ((TmpContNomCont."Importe Db" <> 0) OR (TmpContNomCont."Importe Cr" <> 0)) AND
            (TmpContNomCont."Importe Db" <> TmpContNomCont."Importe Cr") THEN BEGIN
            ConfNomina.TESTFIELD("Cod. Cta. Nominas Pago Transf.");
            NumLin += 1000;
            JobJNL."Journal Template Name" := ConfNomina."Job Journal Template Name";
            JobJNL."Journal Batch Name" := ConfNomina."Job Journal Batch Name";
            JobJNL."Posting Date" := FechaRegistro;
            JobJNL."Document No." := NumDoc;
            JobJNL."Line No." := NumLin;
            JobJNL.Description := Text001;
            JobJNL."Account Type" := JobJNL."Account Type"::"G/L Account";
            JobJNL.VALIDATE("Account No.", ConfNomina."Cod. Cta. Nominas Pago Transf.");
            JobJNL."Debit Amount" := ROUND(TmpContNomCont."Importe Cr", Divisa."Amount Rounding Precision");
            JobJNL.VALIDATE("Debit Amount");
            JobJNL.INSERT;
        END;

        // GRN Graba contrapartida por el neto para pagos diferentes transferencias
        JobJNL.INIT;
        IF ((TmpContNomCont."Importe Db CK" <> 0) OR (TmpContNomCont."Importe Cr CK" <> 0)) AND
            (TmpContNomCont."Importe Db CK" <> TmpContNomCont."Importe Cr CK") THEN BEGIN
            ConfNomina.TESTFIELD(ConfNomina."Cta. Nominas Otros Pagos");
            NumLin += 1000;
            JobJNL."Journal Template Name" := ConfNomina."Job Journal Template Name";
            JobJNL."Journal Batch Name" := ConfNomina."Job Journal Batch Name";
            JobJNL."Posting Date" := FechaRegistro;
            JobJNL."Document No." := NumDoc;
            JobJNL."Line No." := NumLin;
            JobJNL.Description := Text001;
            JobJNL."Account Type" := JobJNL."Account Type"::"G/L Account";
            JobJNL.VALIDATE("Account No.", ConfNomina."Cta. Nominas Otros Pagos");
            JobJNL."Debit Amount" := ROUND(TmpContNomCont."Importe Cr CK", Divisa."Amount Rounding Precision");
            JobJNL.VALIDATE("Debit Amount");
            JobJNL.INSERT;
        END;

    end;

    procedure CalcularDtosCOTSSJob(Ano: Integer; CodEmp: Code[20])
    var
        LinNominasES: Record 34002118;
        DeduccGob: Record 34002129;
        CabAportesEmpresa: Record 34002121;
        LinAportesEmpresa: Record 34002122;
        LinAportesEmpresa2: Record 34002122;
        Puestos: Record 34002110;
        TmpDCA: Record 34002123 temporary;
        NoLin: Integer;
        MontoAplicar: Decimal;
        IndSkip: Boolean;
        ImporteCotizacion2: Decimal;
        ImporteImpuestos: Decimal;
        ImporteImpuestosemp: Decimal;
        ImporteCotizacionEmp: Decimal;
        ImporteCotizacion: Decimal;
        Importecotizacionmes: Decimal;
        SFSMes: Decimal;
        AFPMes: Decimal;
        ImporteTotal: Decimal;
        "%Cot": Decimal;
        Lintabla: Decimal;
        NoCuenta: Code[20];
        ImporteIngreso: Decimal;
        ImporteDto: Decimal;
        ImporteTarea: Decimal;
    begin
        //Las retenciones legales solo van al Diario, no se distribuyen
        TiposCotizacion.RESET;
        TiposCotizacion.SETRANGE(Ano, DATE2DMY(final, 3));
        TiposCotizacion.SETFILTER("Porciento Empleado", '<>%1', 0);
        IF TiposCotizacion.FINDSET THEN
            REPEAT
                ImporteIngreso := 0;
                ImporteDto := 0;
                //Envio los importes descontados integros al Diario y sin distribuir
                IF (TiposCotizacion.Codigo = ConfNomina."Concepto AFP") OR (TiposCotizacion.Codigo = ConfNomina."Concepto SFS") THEN BEGIN
                    LinNominasES.RESET;
                    LinNominasES.SETRANGE(Periodo, inicial, final);
                    LinNominasES.SETRANGE("No. empleado", CodEmp);
                    LinNominasES.SETRANGE("Concepto salarial", TiposCotizacion.Codigo);
                    LinNominasES.SETRANGE("Tipo nomina", LinNominasES."Tipo nomina");
                    LinNominasES.SETFILTER("Job No.", "Cab. nomina".GETFILTER("Job No."));
                    IF LinNominasES.FINDSET THEN
                        REPEAT
                            ImporteDto += LinNominasES.Total;
                        UNTIL LinNominasES.NEXT = 0;

                    //Busco la cuenta que se debe afectar
                    ConceptosSalariales.GET(TiposCotizacion.Codigo);
                    IF GpoContEmpl.GET(Empleado."Posting Group") THEN BEGIN
                        ConfGpoContEmpl.RESET;
                        ConfGpoContEmpl.SETRANGE(Codigo, GpoContEmpl.Codigo);
                        ConfGpoContEmpl.SETRANGE("Codigo Concepto Salarial", TiposCotizacion.Codigo);
                        IF ConfGpoContEmpl.FINDFIRST THEN BEGIN
                            ConfGpoContEmpl.TESTFIELD("No. Cuenta Cuota Obrera");
                            NoCuenta := ConfGpoContEmpl."No. Cuenta Cuota Obrera";
                            CASE ConfGpoContEmpl."Tipo Cuenta Cuota Obrera" OF
                                0:
                                    TipoCta := 0;
                                ELSE
                                    TipoCta := 2;
                            END;

                            IF ConceptosSalariales."Validar Contrapartida CO" THEN BEGIN
                                ConfGpoContEmpl.TESTFIELD("No. Cuenta Contrapartida CO");
                                CASE ConfGpoContEmpl."Tipo Cuenta Contrapartida CO" OF
                                    0:
                                        TipoContrapartida := 0;
                                    ELSE
                                        TipoContrapartida := 2;
                                END;

                                NoCuentaContrapartida := ConfGpoContEmpl."No. Cuenta Contrapartida CO";
                            END;
                        END;
                    END
                    ELSE BEGIN
                        CASE ConceptosSalariales."Tipo Cuenta Cuota Obrera" OF
                            0:
                                TipoCta := 0;
                            1:
                                TipoCta := 2;
                            ELSE
                                TipoCta := 1;
                        END;

                        IF TipoCta <> 1 THEN  //Cliente
                           BEGIN
                            ConceptosSalariales.TESTFIELD("No. Cuenta Cuota Obrera");
                            NoCuenta := ConceptosSalariales."No. Cuenta Cuota Obrera";
                        END;

                        IF ConceptosSalariales."Validar Contrapartida CO" THEN BEGIN
                            ConceptosSalariales.TESTFIELD("No. Cuenta Contrapartida CO");
                            CASE ConceptosSalariales."Tipo Cuenta Contrapartida CO" OF
                                0:
                                    TipoContrapartida := 0;
                                ELSE
                                    TipoContrapartida := 2;
                            END;

                            NoCuentaContrapartida := ConceptosSalariales."No. Cuenta Contrapartida CO";
                        END;
                    END;

                    LlenaDatosDescJob(TiposCotizacion.Codigo, TipoCta, NoCuenta, ImporteDto, FALSE,
                                      LinNominasES."No. empleado", '', '', 3, LinNominasES."Dimension Set ID");
                    IF ConceptosSalariales."Validar Contrapartida CO" THEN
                        LlenaDatosDescJob(TiposCotizacion.Codigo, TipoContrapartida, NoCuentaContrapartida, ImporteDto * -1, TRUE,
                                LinNominasES."No. empleado", '', '', 3, LinNominasES."Dimension Set ID");
                END;
            UNTIL TiposCotizacion.NEXT = 0;


        /*No se distribuyen las retenciones a empleados
        //En base al descuento, busco los ingresos que le aplican
        //limpiar valores de las variables de los ingresos globales
        TiposCotizacion.RESET;
        TiposCotizacion.SETRANGE(Ano,DATE2DMY(final,3));
        TiposCotizacion.SETFILTER("Porciento Empleado",'<>%1',0);
        IF TiposCotizacion.FINDSET THEN
           REPEAT
            ImporteIngreso := 0;
            ImporteDto := 0;
            //Busco el total de los ingresos que aplican
            LinNominasES.RESET;
            IF ConfNomina."Concepto AFP" = TiposCotizacion.Codigo THEN
                LinNominasES.SETRANGE("Cotiza AFP",TRUE)
            ELSE
            IF ConfNomina."Concepto SFS" = TiposCotizacion.Codigo THEN
                LinNominasES.SETRANGE("Cotiza SFS",TRUE);
        
            LinNominasES.SETRANGE(Periodo,inicial,final);
            LinNominasES.SETRANGE("No. empleado",CodEmp);
            LinNominasES.SETRANGE("Tipo concepto",LinNominasES."Tipo concepto"::Ingresos);
            LinNominasES.SETRANGE("Tipo nomina",LinNominasES."Tipo nomina");
            IF LinNominasES.FINDSET THEN
              REPEAT
                ImporteIngreso += LinNominasES.Total;
              UNTIL LinNominasES.NEXT = 0;
        
            //Busco el total del descuento
            LinNominasES.RESET;
            LinNominasES.SETRANGE(Periodo,inicial,final);
            LinNominasES.SETRANGE("No. empleado",CodEmp);
            LinNominasES.SETRANGE("Concepto salarial",TiposCotizacion.Codigo);
            LinNominasES.SETRANGE("Tipo nomina",LinNominasES."Tipo nomina");
            IF LinNominasES.FINDFIRST THEN
              ImporteDto += LinNominasES.Total;
        
        
            //Busco todas las combinaciones de proyectos y tareas para el empleado
            TmpDCA.DELETEALL;
            DCA.RESET;
            DCA.SETRANGE("Fecha registro",inicial,final);
            DCA.SETRANGE("Cod. Empleado",CodEmp);
            IF DCA.FINDSET THEN
              REPEAT
                TmpDCA.INIT;
                TmpDCA."Cod. Empleado" := DCA."Cod. Empleado";
                TmpDCA."Valor Dim 2" := DCA."Job No.";
                TmpDCA."Valor Dim 3" := DCA."Job Task No.";
                IF TmpDCA.INSERT THEN;
              UNTIL DCA.NEXT = 0;
        
              //Para distribuir TSS
               TmpDCA.FIND('-');
               REPEAT
                ImporteTarea := 0;
                DCA.RESET;
                DCA.SETRANGE("Fecha registro",inicial,final);
                DCA.SETRANGE("Cod. Empleado",CodEmp);
                DCA.SETRANGE("Job No.",TmpDCA."Valor Dim 2");
                DCA.SETRANGE("Job Task No.",TmpDCA."Valor Dim 3");
                IF DCA.FINDSET THEN
                  REPEAT
                    //Busco importe a distribuir por los ingresos que aplican al impuesto
                    LinNominasES.RESET;
                    IF ConfNomina."Concepto AFP" = TiposCotizacion.Codigo THEN
                       LinNominasES.SETRANGE("Cotiza AFP",TRUE)
                    ELSE
                    IF ConfNomina."Concepto SFS" = TiposCotizacion.Codigo THEN
                       LinNominasES.SETRANGE("Cotiza SFS",TRUE);
        
                    LinNominasES.SETRANGE(Periodo,inicial,final);
                    LinNominasES.SETRANGE("No. empleado",CodEmp);
                    LinNominasES.SETRANGE("Tipo concepto",LinNominasES."Tipo concepto"::Ingresos);
                    LinNominasES.SETRANGE("Tipo nomina",LinNominasES."Tipo nomina");
                    IF LinNominasES.FINDSET THEN
                      REPEAT
                        IF LinNominasES."Concepto salarial" = ConfNomina."Concepto Sal. Base" THEN
                           ImporteTarea += DCA."Horas regulares" * LinNominasES."Importe Base";
                        //ELSE
        
                      UNTIL LinNominasES.NEXT = 0;
                  UNTIL DCA.NEXT = 0;
                ImporteTarea := ImporteTarea/ImporteIngreso; //Represento el % sobre el ingreso total de la base de impuesto
                ImporteTarea := ImporteDto * ImporteTarea; //Calculo la proporcion que toca a este impuesto
        
                //Busco la cuenta que se debe afectar
                ConceptosSalariales.GET(TiposCotizacion.Codigo);
                IF GpoContEmpl.GET(Empleado."Posting Group") THEN
                    BEGIN
                    ConfGpoContEmpl.RESET;
                    ConfGpoContEmpl.SETRANGE(Codigo,GpoContEmpl.Codigo);
                    ConfGpoContEmpl.SETRANGE("Codigo Concepto Salarial",TiposCotizacion.Codigo);
                    IF ConfGpoContEmpl.FINDFIRST THEN
                        BEGIN
                        ConfGpoContEmpl.TESTFIELD("No. Cuenta Cuota Obrera");
                        NoCuenta                  := ConfGpoContEmpl."No. Cuenta Cuota Obrera";
                        CASE ConfGpoContEmpl."Tipo Cuenta Cuota Obrera" OF
                          0:
                          TipoCta := 0;
                          ELSE
                          TipoCta := 2;
                        END;
        
                        IF ConceptosSalariales."Validar Contrapartida CO" THEN
                            BEGIN
                            ConfGpoContEmpl.TESTFIELD("No. Cuenta Contrapartida CO");
                            CASE ConfGpoContEmpl."Tipo Cuenta Contrapartida CO" OF
                              0:
                              TipoContrapartida   := 0;
                              ELSE
                              TipoContrapartida   := 2;
                            END;
        
                            NoCuentaContrapartida := ConfGpoContEmpl."No. Cuenta Contrapartida CO";
                            END;
                        END;
                    END
                ELSE
                   BEGIN
                    CASE ConceptosSalariales."Tipo Cuenta Cuota Obrera" OF
                     0:
                      TipoCta := 0;
                     1:
                      TipoCta := 2;
                     ELSE
                      TipoCta := 1;
                    END;
        
                    IF TipoCta <> 1 THEN  //Cliente
                       BEGIN
                        ConceptosSalariales.TESTFIELD("No. Cuenta Cuota Obrera");
                        NoCuenta := ConceptosSalariales."No. Cuenta Cuota Obrera";
                       END;
        
                    IF ConceptosSalariales."Validar Contrapartida CO" THEN
                       BEGIN
                        ConceptosSalariales.TESTFIELD("No. Cuenta Contrapartida CO");
                        CASE ConceptosSalariales."Tipo Cuenta Contrapartida CO" OF
                         0:
                          TipoContrapartida       := 0;
                         ELSE
                          TipoContrapartida       := 2;
                         END;
        
                        NoCuentaContrapartida     := ConceptosSalariales."No. Cuenta Contrapartida CO";
                      END;
                   END;
        
                LlenaDatosDescJob(TiposCotizacion.Codigo,TipoCta,NoCuenta,ImporteTarea,LinNominasES."No. Documento" + LinNominasES."No. empleado",FALSE,
                                  LinNominasES."No. empleado",DCA."Job No.",DCA."Job Task No.",3,LinNominasES."Dimension Set ID");
                IF ConceptosSalariales."Validar Contrapartida CO" THEN
                   LlenaDatosDescJob(TiposCotizacion.Codigo,TipoContrapartida,NoCuentaContrapartida,ImporteTarea*-1,LinNominasES."No. Documento" + LinNominasES."No. empleado",TRUE,
                            LinNominasES."No. empleado",'','',3,LinNominasES."Dimension Set ID");
        
               UNTIL TmpDCA.NEXT = 0;
           UNTIL TiposCotizacion.NEXT = 0;
        */

    end;

    procedure CalcularDtosCPTSSJob(Ano: Integer; CodEmp: Code[20])
    var
        LinNominasES: Record 34002118;
        DeduccGob: Record 34002129;
        CabAportesEmpresa: Record 34002121;
        LinAportesEmpresa: Record 34002122;
        Puestos: Record 34002110;
        TmpDCA: Record 34002123 temporary;
        NoLin: Integer;
        MontoAplicar: Decimal;
        IndSkip: Boolean;
        ImporteCotizacion2: Decimal;
        ImporteImpuestos: Decimal;
        ImporteImpuestosemp: Decimal;
        ImporteCotizacionEmp: Decimal;
        ImporteCotizacion: Decimal;
        Importecotizacionmes: Decimal;
        SFSMes: Decimal;
        AFPMes: Decimal;
        ImporteTotal: Decimal;
        "%Cot": Decimal;
        Lintabla: Decimal;
        NoCuenta: Code[20];
        ImporteIngreso: Decimal;
        ImporteDto: Decimal;
        ImporteTarea: Decimal;
        TotHorasReg: Decimal;
    begin
        //En base al descuento, busco los ingresos que le aplican       AQUI
        //limpiar valores de las variables de los ingresos globales
        TiposCotizacion.RESET;
        TiposCotizacion.SETRANGE(Ano, DATE2DMY(inicial, 3));
        TiposCotizacion.SETFILTER("Porciento Empresa", '<>%1', 0);
        IF TiposCotizacion.FINDSET THEN
            REPEAT
                ImporteIngreso := 0;
                ImporteDto := 0;
                TotHorasReg := 0;
                //Busco la cuenta que se debe afectar
                ConceptosSalariales.GET(TiposCotizacion.Codigo);
                IF GpoContEmpl.GET(Empleado."Posting Group") THEN BEGIN
                    ConfGpoContEmpl.RESET;
                    ConfGpoContEmpl.SETRANGE(Codigo, GpoContEmpl.Codigo);
                    ConfGpoContEmpl.SETRANGE("Codigo Concepto Salarial", TiposCotizacion.Codigo);
                    IF ConfGpoContEmpl.FINDFIRST THEN BEGIN
                        ConfGpoContEmpl.TESTFIELD("No. Cuenta Cuota Patronal");
                        NoCuenta := ConfGpoContEmpl."No. Cuenta Cuota Patronal";
                        CASE ConfGpoContEmpl."Tipo Cuenta Cuota Patronal" OF
                            0:
                                TipoCta := 0;
                            ELSE
                                TipoCta := 2;
                        END;
                        //            ERROR('%1',ConceptosSalariales."Validar Contrapartida CP");
                        IF ConceptosSalariales."Validar Contrapartida CP" THEN BEGIN
                            ConfGpoContEmpl.TESTFIELD("No. Cuenta Contrapartida CP");
                            CASE ConfGpoContEmpl."Tipo Cuenta Contrapartida CP" OF
                                0:
                                    TipoContrapartida := 0;
                                ELSE
                                    TipoContrapartida := 2;
                            END;

                            NoCuentaContrapartida := ConfGpoContEmpl."No. Cuenta Contrapartida CP";
                        END;
                    END;
                END
                ELSE BEGIN
                    CASE ConceptosSalariales."Tipo Cuenta Cuota Patronal" OF
                        0:
                            TipoCta := 0;
                        1:
                            TipoCta := 2;
                        ELSE
                            TipoCta := 1;
                    END;

                    IF TipoCta <> 1 THEN  //Cliente
                        BEGIN
                        ConceptosSalariales.TESTFIELD("No. Cuenta Cuota Patronal");
                        NoCuenta := ConceptosSalariales."No. Cuenta Cuota Patronal";
                    END;

                    IF ConceptosSalariales."Validar Contrapartida CP" THEN BEGIN
                        ConceptosSalariales.TESTFIELD("No. Cuenta Contrapartida CP");
                        CASE ConceptosSalariales."Tipo Cuenta Contrapartida CP" OF
                            0:
                                TipoContrapartida := 0;
                            ELSE
                                TipoContrapartida := 2;
                        END;

                        NoCuentaContrapartida := ConceptosSalariales."No. Cuenta Contrapartida CP";
                    END;
                END;

                //Busco el total del descuento
                LinAportesEmpresa.RESET;
                LinAportesEmpresa.SETRANGE(Periodo, inicial, final);
                LinAportesEmpresa.SETRANGE("No. Empleado", CodEmp);
                LinAportesEmpresa.SETRANGE("Concepto Salarial", TiposCotizacion.Codigo);
                LinAportesEmpresa.SETRANGE("Tipo Nomina", LinNominasES."Tipo nomina");
                LinAportesEmpresa.SETFILTER("Job No.", "Cab. nomina".GETFILTER("Job No."));
                IF LinAportesEmpresa.FINDFIRST THEN BEGIN
                    ImporteDto := LinAportesEmpresa.Importe;
                    ImporteIngreso := LinAportesEmpresa."Base Imponible";
                END;

                //Si no tiene aporte del empleado, no lo considero para distribuirlo
                //    IF TiposCotizacion."Porciento Empleado" <> 0 THEN
                BEGIN
                    //Busco todas las combinaciones de proyectos y tareas para el empleado

                    TmpDCA.DELETEALL;
                    DCA.RESET;
                    DCA.SETRANGE("Fecha registro", inicial, final);
                    DCA.SETRANGE("Cod. Empleado", CodEmp);
                    DCA.SETFILTER("Job No.", "Cab. nomina".GETFILTER("Job No."));
                    IF DCA.FINDSET THEN
                        REPEAT
                            TmpDCA.INIT;
                            TmpDCA."Cod. Empleado" := DCA."Cod. Empleado";
                            TmpDCA."Valor Dim 2" := DCA."Job No.";
                            TmpDCA."Valor Dim 3" := DCA."Job Task No.";
                            TmpDCA."Valor Dim 4" := FORMAT(DCA."Fecha registro");
                            TmpDCA.Importe := DCA."Horas regulares";
                            TotHorasReg += DCA."Horas regulares";
                            IF TmpDCA.INSERT THEN;
                        UNTIL DCA.NEXT = 0;

                    ImporteDto := ImporteDto / TotHorasReg;

                    //Para distribuir Aporte del patron
                    TmpDCA.FIND('-');
                    REPEAT
                        ImporteTarea := 0;
                        /*
                                    DCA.RESET;
                                    DCA.SETRANGE("Fecha registro",inicial,final);
                                    DCA.SETRANGE("Cod. Empleado",CodEmp);
                                    DCA.SETRANGE("Job No.",TmpDCA."Valor Dim 2");
                                    DCA.SETRANGE("Job Task No.",TmpDCA."Valor Dim 3");
                            //        IF DCA.FINDSET THEN
                                    DCA.FINDSET;
                                      REPEAT
                                        //Busco importe a distribuir por los ingresos que aplican al impuesto
                                        LinNominasES.RESET;
                                        IF ConfNomina."Concepto AFP" = TiposCotizacion.Codigo THEN
                                           LinNominasES.SETRANGE("Cotiza AFP",TRUE)
                                        ELSE
                                        IF ConfNomina."Concepto SFS" = TiposCotizacion.Codigo THEN
                                           LinNominasES.SETRANGE("Cotiza SFS",TRUE)
                                        ELSE
                                        IF ConfNomina."Concepto INFOTEP" = TiposCotizacion.Codigo THEN
                                            LinNominasES.SETRANGE("Cotiza Infotep",TRUE)
                                        ELSE
                                        IF ConfNomina."Concepto SRL" = TiposCotizacion.Codigo THEN
                                            LinNominasES.SETRANGE("Cotiza SRL",TRUE);

                                        LinNominasES.SETRANGE(Periodo,inicial,final);
                                        LinNominasES.SETRANGE("No. empleado",CodEmp);
                                        LinNominasES.SETRANGE("Tipo concepto",LinNominasES."Tipo concepto"::Ingresos);
                                        LinNominasES.SETRANGE("Tipo nomina",LinNominasES."Tipo nomina");
                                        LinNominasES.SETRANGE("Job No.",DCA."Job No.");
                                        IF LinNominasES.FINDSET THEN
                                          REPEAT
                            //                IF LinNominasES."Concepto salarial" = ConfNomina."Concepto Sal. Base" THEN
                                               ImporteTarea += DCA."Horas regulares" * LinNominasES."Importe Base";
                        //                       IF TiposCotizacion.Codigo = '203' THEN
                        //   MESSAGE('%1 %2 %3 %4 %5',ImporteTarea,DCA."Horas regulares",LinNominasES."Importe Base");

                                            //ELSE

                                          UNTIL LinNominasES.NEXT = 0;
                                      UNTIL DCA.NEXT = 0;
                        //IF TiposCotizacion.Codigo = '203' THEN
                           //ERROR('%1 %2 %3 %4 %5',ImporteTarea,ImporteIngreso,ImporteTarea,ImporteDto);
                                      ImporteTarea := ImporteTarea/ImporteIngreso; //Represento el % sobre el ingreso total de la base de impuesto
                                      ImporteTarea := ImporteDto * ImporteTarea; //Calculo la proporcion que toca a este impuesto
                        */


                        ImporteTarea := ImporteDto * TmpDCA.Importe; //Calculo la proporcion que toca a este impuesto


                        LlenaDatosDescJob(TiposCotizacion.Codigo, TipoCta, NoCuenta, ImporteTarea, FALSE, CodEmp,
                                          '', '', 4, LinAportesEmpresa."Dimension Set ID");
                        IF ConceptosSalariales."Validar Contrapartida CP" THEN
                            LlenaDatosDescJob(TiposCotizacion.Codigo, TipoContrapartida, NoCuentaContrapartida, ImporteTarea * -1, TRUE,
                                     CodEmp, TmpDCA."Valor Dim 2", TmpDCA."Valor Dim 3", 4, LinAportesEmpresa."Dimension Set ID");

                    UNTIL TmpDCA.NEXT = 0;
                END;
            /*
                  ELSE
                      BEGIN
                        LinNominasES.RESET;
                        LinNominasES.SETRANGE(Periodo,inicial,final);
                        LinNominasES.SETRANGE("No. empleado",CodEmp);
                        LinNominasES.SETRANGE("Tipo concepto",LinNominasES."Tipo concepto"::Ingresos);
                        LinNominasES.SETRANGE("Tipo nomina",LinNominasES."Tipo nomina");
                        LinNominasES.FINDFIRST;
                        ImporteTarea := ImporteDto;
                        DCA."Job No." := '';
                        DCA."Job Task No." := '';
                        LlenaDatosDescJob(TiposCotizacion.Codigo,TipoCta,NoCuenta,ImporteTarea,FALSE,LinNominasES."No. empleado",
                                          DCA."Job No.",DCA."Job Task No.",4,LinAportesEmpresa."Dimension Set ID");
                        IF ConceptosSalariales."Validar Contrapartida CP" THEN
                           LlenaDatosDescJob(TiposCotizacion.Codigo,TipoContrapartida,NoCuentaContrapartida,ImporteTarea*-1,TRUE,
                                    LinNominasES."No. empleado",'','',4,LinAportesEmpresa."Dimension Set ID");

                      END;
            */
            UNTIL TiposCotizacion.NEXT = 0;

    end;

    procedure CalcularISRJob(Ano: Integer; CodEmp: Code[20])
    var
        LinNominasES: Record 34002118;
        TmpDCA: Record 34002123 temporary;
        NoCuenta: Code[20];
        ImporteIngreso: Decimal;
        ImporteDto: Decimal;
        ImporteTarea: Decimal;
    begin
        //Las retenciones legales solo van al Diario, no se distribuyen
        ImporteDto := 0;


        LinNominasES.RESET;
        LinNominasES.SETRANGE(Periodo, inicial, final);
        LinNominasES.SETRANGE("No. empleado", CodEmp);
        LinNominasES.SETRANGE("Concepto salarial", ConfNomina."Concepto ISR");
        LinNominasES.SETRANGE("Tipo nomina", LinNominasES."Tipo nomina");
        IF LinNominasES.FINDSET THEN
            REPEAT
                ImporteDto += LinNominasES.Total;
            UNTIL LinNominasES.NEXT = 0;

        IF ImporteDto = 0 THEN
            EXIT;

        //Busco la cuenta que se debe afectar
        ConceptosSalariales.GET(ConfNomina."Concepto ISR");
        IF GpoContEmpl.GET(Empleado."Posting Group") THEN BEGIN
            ConfGpoContEmpl.RESET;
            ConfGpoContEmpl.SETRANGE(Codigo, GpoContEmpl.Codigo);
            ConfGpoContEmpl.SETRANGE("Codigo Concepto Salarial", ConfNomina."Concepto ISR");
            IF ConfGpoContEmpl.FINDFIRST THEN BEGIN
                ConfGpoContEmpl.TESTFIELD("No. Cuenta Cuota Obrera");
                NoCuenta := ConfGpoContEmpl."No. Cuenta Cuota Obrera";
                CASE ConfGpoContEmpl."Tipo Cuenta Cuota Obrera" OF
                    0:
                        TipoCta := 0;
                    ELSE
                        TipoCta := 2;
                END;

                IF ConceptosSalariales."Validar Contrapartida CO" THEN BEGIN
                    ConfGpoContEmpl.TESTFIELD("No. Cuenta Contrapartida CO");
                    CASE ConfGpoContEmpl."Tipo Cuenta Contrapartida CO" OF
                        0:
                            TipoContrapartida := 0;
                        ELSE
                            TipoContrapartida := 2;
                    END;

                    NoCuentaContrapartida := ConfGpoContEmpl."No. Cuenta Contrapartida CO";
                END;
            END;
        END
        ELSE BEGIN
            CASE ConceptosSalariales."Tipo Cuenta Cuota Obrera" OF
                0:
                    TipoCta := 0;
                1:
                    TipoCta := 2;
                ELSE
                    TipoCta := 1;
            END;

            IF TipoCta <> 1 THEN  //Cliente
                BEGIN
                ConceptosSalariales.TESTFIELD("No. Cuenta Cuota Obrera");
                NoCuenta := ConceptosSalariales."No. Cuenta Cuota Obrera";
            END;

            IF ConceptosSalariales."Validar Contrapartida CO" THEN BEGIN
                ConceptosSalariales.TESTFIELD("No. Cuenta Contrapartida CO");
                CASE ConceptosSalariales."Tipo Cuenta Contrapartida CO" OF
                    0:
                        TipoContrapartida := 0;
                    ELSE
                        TipoContrapartida := 2;
                END;

                NoCuentaContrapartida := ConceptosSalariales."No. Cuenta Contrapartida CO";
            END;
        END;


        LlenaDatosDescJob(LinNominasES."Concepto salarial", TipoCta, NoCuenta, ImporteDto, FALSE,
                          LinNominasES."No. empleado", '', '', 3, LinNominasES."Dimension Set ID");
        IF ConceptosSalariales."Validar Contrapartida CO" THEN
            LlenaDatosDescJob(LinNominasES."Concepto salarial", TipoContrapartida, NoCuentaContrapartida, ImporteDto * -1, TRUE,
                    LinNominasES."No. empleado", '', '', 3, LinNominasES."Dimension Set ID");




        /*Las retenciones a empleados no se distribuyen
        //En base al descuento, busco los ingresos que le aplican
        //limpiar valores de las variables de los ingresos globales
        ImporteIngreso := 0;
        ImporteDto := 0;
        //Busco el importe total de la base de calculo del ISR OJO OJO OJO, para cuando es un importe manual solo asi funcionaria
        {LinNominasES.RESET;
        LinNominasES.SETRANGE(Periodo,inicial,final);
        LinNominasES.SETRANGE("No. empleado",CodEmp);
        LinNominasES.SETRANGE("Tipo concepto",LinNominasES."Tipo concepto"::Ingresos);
        LinNominasES.SETRANGE("Tipo nomina",LinNominasES."Tipo nomina");
        LinNominasES.SETRANGE("Cotiza ISR",TRUE);
        }
        ConfNomina.TESTFIELD("Concepto ISR");
        LinNominasES.RESET;
        LinNominasES.SETRANGE(Periodo,inicial,final);
        LinNominasES.SETRANGE("No. empleado",CodEmp);
        LinNominasES.SETRANGE("Tipo concepto",LinNominasES."Tipo concepto"::Deducciones);
        LinNominasES.SETRANGE("Tipo nomina",LinNominasES."Tipo nomina");
        LinNominasES.SETRANGE("Concepto salarial",ConfNomina."Concepto ISR");
        IF LinNominasES.FINDSET THEN
          REPEAT
            ImporteIngreso += LinNominasES."Importe Base";
          UNTIL LinNominasES.NEXT = 0;
        
        //Busco el total del descuento
        LinNominasES.RESET;
        LinNominasES.SETRANGE(Periodo,inicial,final);
        LinNominasES.SETRANGE("No. empleado",CodEmp);
        LinNominasES.SETRANGE("Concepto salarial",ConfNomina."Concepto ISR");
        LinNominasES.SETRANGE("Tipo nomina",LinNominasES."Tipo nomina");
        IF LinNominasES.FINDFIRST THEN
          ImporteDto += LinNominasES.Total;
        
        
        //Busco todas las combinaciones de proyectos y tareas para el empleado
        TmpDCA.DELETEALL;
        DCA.RESET;
        DCA.SETRANGE("Fecha registro",inicial,final);
        DCA.SETRANGE("Cod. Empleado",CodEmp);
        IF DCA.FINDSET THEN
          REPEAT
            TmpDCA.INIT;
            TmpDCA."Cod. Empleado" := DCA."Cod. Empleado";
            TmpDCA."Valor Dim 2" := DCA."Job No.";
            TmpDCA."Valor Dim 3" := DCA."Job Task No.";
            IF TmpDCA.INSERT THEN;
          UNTIL DCA.NEXT = 0;
        
        //Para distribuir ISR
        TmpDCA.FIND('-');
        REPEAT
          ImporteTarea := 0;
          DCA.RESET;
          DCA.SETRANGE("Fecha registro",inicial,final);
          DCA.SETRANGE("Cod. Empleado",CodEmp);
          DCA.SETRANGE("Job No.",TmpDCA."Valor Dim 2");
          DCA.SETRANGE("Job Task No.",TmpDCA."Valor Dim 3");
          IF DCA.FINDSET THEN
            REPEAT
              //Busco importe a distribuir por los ingresos que aplican al impuesto
              LinNominasES.RESET;
              LinNominasES.SETRANGE(Periodo,inicial,final);
              LinNominasES.SETRANGE("No. empleado",CodEmp);
              LinNominasES.SETRANGE("Tipo concepto",LinNominasES."Tipo concepto"::Ingresos);
              LinNominasES.SETRANGE("Tipo nomina",LinNominasES."Tipo nomina");
              LinNominasES.SETRANGE("Cotiza ISR",TRUE);
              IF LinNominasES.FINDSET THEN
                REPEAT
                  IF LinNominasES."Concepto salarial" = ConfNomina."Concepto Horas Ext. 100%" THEN
                     ImporteTarea += DCA."Horas extras al 100" * LinNominasES."Importe Base"
                  ELSE
                  IF LinNominasES."Concepto salarial" = ConfNomina."Concepto Horas Ext. 35%" THEN
                     ImporteTarea += DCA."Horas extras al 35" * LinNominasES."Importe Base"
                  ELSE
                  IF LinNominasES."Concepto salarial" = ConfNomina."Concepto Dias feriados" THEN
                     ImporteTarea += DCA."Horas feriadas" * LinNominasES."Importe Base"
                  ELSE
                  IF LinNominasES."Concepto salarial" = ConfNomina."Concepto Sal. Base" THEN
                     ImporteTarea += DCA."Horas regulares" * LinNominasES."Importe Base";
        //          MESSAGE('%1 %2',ImporteTarea);
                UNTIL LinNominasES.NEXT = 0;
            UNTIL DCA.NEXT = 0;
        
          ImporteTarea := ImporteTarea/ImporteIngreso; //Represento el % sobre el ingreso total de la base de impuesto
          ImporteTarea := ImporteDto * ImporteTarea; //Calculo la proporcion que toca a este impuesto
        
          //Busco la cuenta que se debe afectar
          ConceptosSalariales.GET(ConfNomina."Concepto ISR");
          IF GpoContEmpl.GET(Empleado."Posting Group") THEN
              BEGIN
              ConfGpoContEmpl.RESET;
              ConfGpoContEmpl.SETRANGE(Codigo,GpoContEmpl.Codigo);
              ConfGpoContEmpl.SETRANGE("Codigo Concepto Salarial",ConfNomina."Concepto ISR");
              IF ConfGpoContEmpl.FINDFIRST THEN
                  BEGIN
                  ConfGpoContEmpl.TESTFIELD("No. Cuenta Cuota Obrera");
                  NoCuenta                  := ConfGpoContEmpl."No. Cuenta Cuota Obrera";
                  CASE ConfGpoContEmpl."Tipo Cuenta Cuota Obrera" OF
                    0:
                    TipoCta := 0;
                    ELSE
                    TipoCta := 2;
                  END;
        
                  IF ConceptosSalariales."Validar Contrapartida CO" THEN
                      BEGIN
                      ConfGpoContEmpl.TESTFIELD("No. Cuenta Contrapartida CO");
                      CASE ConfGpoContEmpl."Tipo Cuenta Contrapartida CO" OF
                        0:
                        TipoContrapartida   := 0;
                        ELSE
                        TipoContrapartida   := 2;
                      END;
        
                      NoCuentaContrapartida := ConfGpoContEmpl."No. Cuenta Contrapartida CO";
                      END;
                  END;
              END
          ELSE
              BEGIN
              CASE ConceptosSalariales."Tipo Cuenta Cuota Obrera" OF
                0:
                TipoCta := 0;
                1:
                TipoCta := 2;
                ELSE
                TipoCta := 1;
              END;
        
              IF TipoCta <> 1 THEN  //Cliente
                  BEGIN
                  ConceptosSalariales.TESTFIELD("No. Cuenta Cuota Obrera");
                  NoCuenta := ConceptosSalariales."No. Cuenta Cuota Obrera";
                  END;
        
              IF ConceptosSalariales."Validar Contrapartida CO" THEN
                  BEGIN
                  ConceptosSalariales.TESTFIELD("No. Cuenta Contrapartida CO");
                  CASE ConceptosSalariales."Tipo Cuenta Contrapartida CO" OF
                    0:
                    TipoContrapartida       := 0;
                    ELSE
                    TipoContrapartida       := 2;
                    END;
        
                  NoCuentaContrapartida     := ConceptosSalariales."No. Cuenta Contrapartida CO";
                END;
              END;
          IF ImporteTarea <> 0 THEN
             BEGIN
              LlenaDatosDescJob(ConfNomina."Concepto ISR",TipoCta,NoCuenta,ImporteTarea,LinNominasES."No. Documento" + LinNominasES."No. empleado",FALSE,
                                LinNominasES."No. empleado",DCA."Job No.",DCA."Job Task No.",3,LinNominasES."Dimension Set ID");
              IF ConceptosSalariales."Validar Contrapartida CO" THEN
                  LlenaDatosDescJob(ConfNomina."Concepto ISR",TipoContrapartida,NoCuentaContrapartida,ImporteTarea*-1,LinNominasES."No. Documento" + LinNominasES."No. empleado",TRUE,
                          LinNominasES."No. empleado",DCA."Job No.",DCA."Job Task No.",3,LinNominasES."Dimension Set ID");
             END;
        UNTIL TmpDCA.NEXT = 0;
        */

    end;

    local procedure FiltraDimSet(DimSet1: Integer; Dimset2: Integer; CodEmpleado: Code[20])
    begin
        recDimSet.RESET;
        recDimSet.SETFILTER("Dimension Set ID", '%1|%2', DimSet1, Dimset2);
        IF recDimSet.FINDSET(FALSE, FALSE) THEN
            REPEAT
                IF ConceptosSalariales."Contabilizacion x Dimension" THEN BEGIN
                    IF recDimSet."Dimension Code" = CodDim[1] THEN BEGIN
                        ContabNom.SETRANGE("Cod. Dim 1", recDimSet."Dimension Code");
                        ContabNom.SETRANGE("Valor Dim 1", recDimSet."Dimension Value Code");
                    END;

                    IF recDimSet."Dimension Code" = CodDim[2] THEN BEGIN
                        ContabNom.SETRANGE("Cod. Dim 2", recDimSet."Dimension Code");
                        ContabNom.SETRANGE("Valor Dim 2", recDimSet."Dimension Value Code");
                    END;

                    IF recDimSet."Dimension Code" = CodDim[3] THEN BEGIN
                        ContabNom.SETRANGE("Cod. Dim 3", recDimSet."Dimension Code");
                        ContabNom.SETRANGE("Valor Dim 3", recDimSet."Dimension Value Code");
                    END;

                    IF recDimSet."Dimension Code" = CodDim[4] THEN BEGIN
                        ContabNom.SETRANGE("Cod. Dim 4", recDimSet."Dimension Code");
                        ContabNom.SETRANGE("Valor Dim 4", recDimSet."Dimension Value Code");
                    END;

                    IF recDimSet."Dimension Code" = CodDim[5] THEN BEGIN
                        ContabNom.SETRANGE("Cod. Dim 5", recDimSet."Dimension Code");
                        ContabNom.SETRANGE("Valor Dim 5", recDimSet."Dimension Value Code");
                    END;

                    IF recDimSet."Dimension Code" = CodDim[6] THEN BEGIN
                        ContabNom.SETRANGE("Cod. Dim 6", recDimSet."Dimension Code");
                        ContabNom.SETRANGE("Valor Dim 6", recDimSet."Dimension Value Code");
                    END;

                    IF NOT ConceptosSalariales."Contabilizacion Resumida" THEN
                        ContabNom.SETRANGE("Cod. Empleado", CodEmpleado);
                END;
            UNTIL recDimSet.NEXT = 0;
    end;

    local procedure LlenaDimSet(DimSet1: Integer; Dimset2: Integer)
    begin
        recDimSet.RESET;
        recDimSet.SETFILTER("Dimension Set ID", '%1|%2', "Cab. nomina"."Dimension Set ID", "Lin. nomina"."Dimension Set ID");
        IF recDimSet.FINDSET(FALSE, FALSE) THEN
            REPEAT
                IF ConceptosSalariales."Contabilizacion x Dimension" THEN BEGIN
                    IF recDimSet."Dimension Code" = CodDim[1] THEN //Siempre llevara la primera DIM
                        BEGIN
                        ContabNom."Cod. Dim 1" := recDimSet."Dimension Code";
                        ContabNom."Valor Dim 1" := recDimSet."Dimension Value Code";
                    END
                    ELSE
                        IF recDimSet."Dimension Code" = CodDim[2] THEN //Siempre llevara la segunda DIM
                            BEGIN
                            ContabNom."Cod. Dim 2" := recDimSet."Dimension Code";
                            ContabNom."Valor Dim 2" := recDimSet."Dimension Value Code";
                        END
                        ELSE
                            IF recDimSet."Dimension Code" = CodDim[3] THEN BEGIN
                                ContabNom."Cod. Dim 3" := recDimSet."Dimension Code";
                                ContabNom."Valor Dim 3" := recDimSet."Dimension Value Code";
                            END
                            ELSE
                                IF recDimSet."Dimension Code" = CodDim[4] THEN BEGIN
                                    ContabNom."Cod. Dim 4" := recDimSet."Dimension Code";
                                    ContabNom."Valor Dim 4" := recDimSet."Dimension Value Code";
                                END
                                ELSE
                                    IF recDimSet."Dimension Code" = CodDim[5] THEN BEGIN
                                        ContabNom."Cod. Dim 5" := recDimSet."Dimension Code";
                                        ContabNom."Valor Dim 5" := recDimSet."Dimension Value Code";
                                    END
                                    ELSE
                                        IF recDimSet."Dimension Code" = CodDim[6] THEN BEGIN
                                            ContabNom."Cod. Dim 6" := recDimSet."Dimension Code";
                                            ContabNom."Valor Dim 6" := recDimSet."Dimension Value Code";
                                        END;
                    ContabNom."Dimension Set ID" := recDimSet."Dimension Set ID";
                END;
            UNTIL recDimSet.NEXT = 0
    end;

    local procedure LlenaTempExiste(Contrapartida: Boolean; dImporte: Decimal)
    begin
        IF NOT Contrapartida THEN BEGIN
            IF "Cab. nomina"."Forma de Cobro" <> "Cab. nomina"."Forma de Cobro"::"Transferencia Banc." THEN BEGIN
                IF dImporte > 0 THEN
                    ContabNom."Importe Db CK" += dImporte
                ELSE
                    ContabNom."Importe Cr CK" += ABS(dImporte);
            END
            ELSE BEGIN
                IF dImporte > 0 THEN
                    ContabNom."Importe Db" += dImporte
                ELSE
                    ContabNom."Importe Cr" += ABS(dImporte);
            END;
        END
        ELSE
            IF "Cab. nomina"."Forma de Cobro" <> "Cab. nomina"."Forma de Cobro"::"Transferencia Banc." THEN BEGIN
                IF dImporte > 0 THEN
                    ContabNom."Importe Cr CK" += dImporte
                ELSE
                    ContabNom."Importe Db CK" += ABS(dImporte);
            END
            ELSE
                IF dImporte > 0 THEN
                    ContabNom."Importe Cr" += dImporte
                ELSE
                    ContabNom."Importe Db" += ABS(dImporte);

        ContabNom.MODIFY;
    end;

    local procedure LlenaTempNOExiste(iTipoCuenta: Integer; cCodCuenta: Code[20]; CodEmpleado: Code[20]; Contrapartida: Boolean; dImporte: Decimal; cConceptoSal: Code[20]; Paso: Integer)
    begin
        NoLin += 100;

        CLEAR("Temp Contabilizacion Nom.");
        ContabNom."Tipo Cuenta" := iTipoCuenta;
        ContabNom."No. Cuenta" := cCodCuenta;
        ContabNom."No. Linea" := NoLin;
        ContabNom."Cod. Empleado" := CodEmpleado;
        ContabNom.Contrapartida := Contrapartida;
        ContabNom.Step := Paso;

        IF NOT ConceptosSalariales."Contabilizacion Resumida" THEN
            ContabNom.Descripcion := COPYSTR(Empleado."No." + ' ' + Empleado."Full Name", 1, 50)
        ELSE
            ContabNom.Descripcion := ConceptosSalariales.Descripcion;

        IF NOT Contrapartida THEN BEGIN
            IF "Cab. nomina"."Forma de Cobro" <> "Cab. nomina"."Forma de Cobro"::"Transferencia Banc." THEN BEGIN
                IF dImporte > 0 THEN
                    ContabNom."Importe Db CK" := dImporte
                ELSE
                    ContabNom."Importe Cr CK" := ABS(dImporte);
            END
            ELSE BEGIN
                IF dImporte > 0 THEN
                    ContabNom."Importe Db" := dImporte
                ELSE
                    ContabNom."Importe Cr" := ABS(dImporte);
            END;
        END
        ELSE BEGIN
            IF "Cab. nomina"."Forma de Cobro" <> "Cab. nomina"."Forma de Cobro"::"Transferencia Banc." THEN BEGIN
                IF dImporte > 0 THEN
                    ContabNom."Importe Db CK" := dImporte
                ELSE
                    ContabNom."Importe Cr CK" := ABS(dImporte);

            END
            ELSE BEGIN
                IF dImporte > 0 THEN
                    ContabNom."Importe Db" := dImporte
                ELSE
                    ContabNom."Importe Cr" := ABS(dImporte);
            END;
        END;
        LlenaDimSet("Cab. nomina"."Dimension Set ID", "Lin. nomina"."Dimension Set ID");
        IF ConceptosSalariales.Provisionar THEN BEGIN
            FOR i := 1 TO 6 DO BEGIN
                IF ConfNomina."Dimension Conceptos Salariales" = CodDim[i] THEN BEGIN
                    IF ContabNom."Cod. Dim 1" = CodDim[i] THEN
                        ContabNom."Valor Dim 1" := cConceptoSal
                    ELSE
                        IF ContabNom."Cod. Dim 2" = CodDim[i] THEN
                            ContabNom."Valor Dim 2" := cConceptoSal
                        ELSE
                            IF ContabNom."Cod. Dim 3" = CodDim[i] THEN
                                ContabNom."Valor Dim 3" := cConceptoSal
                            ELSE
                                IF ContabNom."Cod. Dim 4" = CodDim[i] THEN
                                    ContabNom."Valor Dim 4" := cConceptoSal
                                ELSE
                                    IF ContabNom."Cod. Dim 5" = CodDim[i] THEN
                                        ContabNom."Valor Dim 5" := cConceptoSal
                                    ELSE
                                        IF ContabNom."Cod. Dim 6" = CodDim[i] THEN
                                            ContabNom."Valor Dim 6" := cConceptoSal;
                END;
            END;
        END;

        //Para las Dim del perfil de salario (linea del concepto salarial)
        //Para las Dim por Grupo contable
        DefDim.RESET;
        DefDim.SETFILTER("Table ID", '%1|%2|%3', 34002105, 34002111, 34002115);
        IF Empleado."Posting Group" <> '' THEN
            DefDim.SETFILTER("No.", Empleado."Posting Group" + '*' + cConceptoSal + '*')
        ELSE
            DefDim.SETFILTER("No.", '*' + cConceptoSal + '*');

        IF DefDim.FINDSET THEN
            REPEAT
                IF CodDim[1] = DefDim."Dimension Code" THEN BEGIN
                    ContabNom."Cod. Dim 1" := DefDim."Dimension Code";
                    ContabNom."Valor Dim 1" := DefDim."Dimension Value Code";
                END
                ELSE
                    IF CodDim[2] = DefDim."Dimension Code" THEN BEGIN
                        ContabNom."Cod. Dim 2" := DefDim."Dimension Code";
                        ContabNom."Valor Dim 2" := DefDim."Dimension Value Code";
                    END
                    ELSE
                        IF CodDim[3] = DefDim."Dimension Code" THEN BEGIN
                            ContabNom."Cod. Dim 3" := DefDim."Dimension Code";
                            ContabNom."Valor Dim 3" := DefDim."Dimension Value Code";
                        END
                        ELSE
                            IF CodDim[4] = DefDim."Dimension Code" THEN BEGIN
                                ContabNom."Cod. Dim 4" := DefDim."Dimension Code";
                                ContabNom."Valor Dim 4" := DefDim."Dimension Value Code";
                            END
                            ELSE
                                IF CodDim[5] = DefDim."Dimension Code" THEN BEGIN
                                    ContabNom."Cod. Dim 5" := DefDim."Dimension Code";
                                    ContabNom."Valor Dim 5" := DefDim."Dimension Value Code";
                                END
                                ELSE
                                    IF CodDim[6] = DefDim."Dimension Code" THEN BEGIN
                                        ContabNom."Cod. Dim 6" := DefDim."Dimension Code";
                                        ContabNom."Valor Dim 6" := DefDim."Dimension Value Code";
                                    END;
            UNTIL DefDim.NEXT = 0;

        ContabNom."Forma de Cobro" := "Cab. nomina"."Forma de Cobro";
        ContabNom.INSERT;
        //IF NOT contabnom.INSERT THEN
        //contabnom.MODIFY;
    end;

    local procedure InsertaAporteCooperativa(LinNomCoop: Record 34002118)
    var
        Movcooperativa: Record 34002196;
        Movcooperativa2: Record 34002196;
        Miembroscooperativa: Record 34002195;
    begin
        IF NOT ConfNomina."Mod. cooperativa activo" THEN
            EXIT;
        IF (LinNomCoop."Concepto salarial" <> ConfNomina."Concepto Cuota cooperativa") THEN
            EXIT;

        IF NOT Movcooperativa2.FINDLAST THEN
            Movcooperativa2.INIT;

        Miembroscooperativa.GET(LinNomCoop."No. empleado");

        Movcooperativa."No. Movimiento" := Movcooperativa2."No. Movimiento" + 1;
        Movcooperativa."Tipo miembro" := Miembroscooperativa."Tipo de miembro";
        Movcooperativa."Employee No." := LinNomCoop."No. empleado";
        Movcooperativa."Fecha registro" := LinNomCoop.Periodo;
        Movcooperativa."No. documento" := "Cab. nomina"."No. Documento";
        Movcooperativa."Tipo transaccion" := Movcooperativa."Tipo transaccion"::Aporte;
        Movcooperativa.Importe := ABS(LinNomCoop.Total);
        Movcooperativa."Concepto salarial" := LinNomCoop."Concepto salarial";
        Movcooperativa.INSERT;
    end;

    local procedure InsertaDescCooperativa(LinNomCoop: Record 34002118)
    var
        Movcooperativa: Record 34002196;
        Movcooperativa2: Record 34002196;
        Miembroscooperativa: Record 34002195;
        HistCabPrestcooperativa: Record 34002199;
    begin
        IF NOT ConfNomina."Mod. cooperativa activo" THEN
            EXIT;

        HistCabPrestcooperativa.RESET;
        HistCabPrestcooperativa.SETRANGE("Employee No.", LinNomCoop."No. empleado");
        HistCabPrestcooperativa.SETRANGE(Status, HistCabPrestcooperativa.Status::Activo);
        HistCabPrestcooperativa.SETRANGE("Concepto Salarial", LinNomCoop."Concepto salarial");
        IF NOT HistCabPrestcooperativa.FINDFIRST THEN
            EXIT;

        IF NOT Movcooperativa2.FINDLAST THEN
            Movcooperativa2.INIT;

        Miembroscooperativa.GET(LinNomCoop."No. empleado");

        Movcooperativa."No. Movimiento" := Movcooperativa2."No. Movimiento" + 1;
        Movcooperativa."Tipo miembro" := Miembroscooperativa."Tipo de miembro";
        Movcooperativa."Employee No." := LinNomCoop."No. empleado";
        Movcooperativa."Fecha registro" := LinNomCoop.Periodo;
        Movcooperativa."No. documento" := HistCabPrestcooperativa."No. Prestamo";
        Movcooperativa."Tipo transaccion" := Movcooperativa."Tipo transaccion"::Cuota;
        Movcooperativa.Importe := LinNomCoop.Total;
        Movcooperativa."Concepto salarial" := LinNomCoop."Concepto salarial";
        Movcooperativa.INSERT;
    end;
}

