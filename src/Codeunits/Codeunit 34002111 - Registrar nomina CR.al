codeunit 34002111 "Registrar nomina CR"
{
    TableNo = 34002115;

    trigger OnRun()
    begin
        GlobalRec.COPY(Rec);
        CODIGO;
        Rec.COPY(GlobalRec);
    end;

    var
        ConfNominas: Record 34002103;
        ConceptosSal: Record 34002111;
        GlobalRec: Record 34002115;
        DfltDimension: Record 352;
        RegEmpCotiz: Record 34002100;
        Calendar: Record 34002134;
        Empleado: Record 5200;
        PerfilSal: Record 34002115;
        PerfilSalImp: Record 34002115;
        Fecha: Record 2000000007;
        CabNomina: Record 34002117;
        LinNomina: Record 34002118;
        Contrato: Record 34002109;
        Ausencia: Record 34002116;
        CurrExchange: Record 330;
        CalcDias: Record 34002107;
        Cargos: Record 34002110;
        recTmpDimEntry: Record 480 temporary;
        cduDim: Codeunit 408;
        Generar: Boolean;
        "Periodo": Integer;
        PerInici: Date;
        PerFinal: Date;
        Tipcalculo: Integer;
        dia: Integer;
        mes: Integer;
        Ano: Integer;
        InicioPer: Date;
        FinPer: Date;
        "DiasAusencia100%": Decimal;
        FechaIniAusencia: Date;
        FechaFinAusencia: Date;
        LinTabla: Integer;
        TotalAusencia: Decimal;
        TotalISR: array[3, 3] of Decimal;
        TotalIngresos: Decimal;
        IngresoSalario: Decimal;
        ImporteLinea: Decimal;
        DiasMes: Integer;
        "%Cot": Decimal;
        ImporteTotal: Decimal;
        ImporteBaseImp: Decimal;
        PrimeraQ: Boolean;
        SegundaQ: Boolean;
        ImporteCotizacion: Decimal;
        Err001: Label '%1 is an invalid number to calculate the payroll for Employee %2';
        ImporteCotizacionRec: Decimal;
        Err002: Label 'Starting Date must be day 1st or 16th';

    procedure CODIGO()
    begin
        ConfNominas.GET();
        ConfNominas.TESTFIELD("Concepto ISR");

        Contrato.RESET;
        Contrato.SETRANGE("No. empleado", GlobalRec."No. empleado");
        Contrato.SETRANGE(Activo, TRUE);
        Contrato.FINDFIRST;

        PrimeraQ := FALSE;
        SegundaQ := FALSE;
        ImporteCotizacion := 0;
        ImporteTotal := 0;
        "%Cot" := 0;
        ImporteBaseImp := 0;

        WITH GlobalRec DO BEGIN
            Empleado.GET("No. empleado");
            //  empleado.TESTFIELD("Global Dimension 1 Code");
            //  empleado.TESTFIELD("Global Dimension 2 Code");

            PerInici := GlobalRec."Inicio Periodo";
            PerFinal := GlobalRec."Fin Periodo";
            dia := DATE2DMY(PerInici, 1);
            IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal THEN
                IF (dia <> 1) AND (dia <> 16) THEN
                    ERROR(Err002);
            Mes := DATE2DMY(PerInici, 2);
            Ano := DATE2DMY(PerInici, 3);

            IF (Empleado."Termination Date" <> 0D) AND (Empleado."Termination Date" < PerInici) AND
               (Empleado."Calcular Nomina") THEN BEGIN
                IF Contrato."Fecha finalizacion" = 0D THEN BEGIN
                    Empleado."Calcular Nomina" := FALSE;
                    Empleado."Fin contrato" := Empleado."Termination Date";
                    Empleado.MODIFY;

                    Contrato."Fecha finalizacion" := Empleado."Termination Date";
                    Contrato.Finalizado := TRUE;
                    Contrato.MODIFY;
                    EXIT;
                END;
            END;

            CalculaDiasVacaciones;
            CrearCabecera;
            // --------------------

            PerfilSal.SETRANGE("No. empleado", GlobalRec."No. empleado");
            PerfilSal.SETRANGE("Perfil salarial", GlobalRec."Perfil salarial");
            PerfilSal.SETFILTER(Cantidad, '<>0');
            PerfilSal.SETRANGE("Tipo concepto", PerfilSal."Tipo concepto"::Ingresos);

            IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal THEN
                IF dia = 1 THEN BEGIN
                    IF GlobalRec."Tipo Nomina" = GlobalRec."Tipo Nomina"::Normal THEN
                        PerfilSal.SETRANGE("1ra Quincena", TRUE);

                    PrimeraQ := TRUE;
                END
                ELSE BEGIN
                    IF GlobalRec."Tipo Nomina" = GlobalRec."Tipo Nomina"::Normal THEN
                        PerfilSal.SETRANGE("2da Quincena", TRUE);

                    SegundaQ := TRUE;
                END;

            IF PerfilSal.FINDSET(FALSE, FALSE) THEN
                REPEAT
                    //Para la bonificacion
                    IF GlobalRec."Tipo Nomina" = 2 THEN BEGIN
                        CalculoBonificacion;
                        IF NOT ConfNominas."Impuestos manuales" THEN
                            CalcularISR;
                        EXIT;
                    END;

                    //Para la Regalia
                    IF GlobalRec."Tipo Nomina" = 1 THEN BEGIN
                        CalculoRegalia;
                        EXIT;
                    END;

                    CalcularIngresos;
                UNTIL PerfilSal.NEXT = 0;

            //GRN Elimino Cabecera de los empleados que no tengan ingresos o deducciones
            CabNomina.CALCFIELDS("Total Ingresos");
            //MESSAGE('%1',CabNomina."Total Ingresos");
            IF CabNomina."Total Ingresos" = 0 THEN BEGIN
                DfltDimension.RESET;
                DfltDimension.SETRANGE("Table ID", 5200);
                DfltDimension.SETRANGE("No.", GlobalRec."No. empleado");
                IF DfltDimension.FINDSET(TRUE, FALSE) THEN
                    REPEAT
                        DfltDimension.DELETE;
                    UNTIL DfltDimension.NEXT = 0;

                CabNomina.DELETE;
            END;

            PerfilSal.SETRANGE("Tipo concepto", PerfilSal."Tipo concepto"::Deducciones);
            IF PerfilSal.FINDSET(FALSE, FALSE) THEN
                REPEAT
                    //Para la bonificacion
                    IF GlobalRec."Tipo Nomina" = 2 THEN BEGIN
                        CalculoBonificacion;
                        EXIT;
                    END;

                    //Para la Regalia
                    IF GlobalRec."Tipo Nomina" = 1 THEN BEGIN
                        CalculoRegalia;
                        EXIT;
                    END;

                    CalcularPrestamos;
                    CalcularDescuentos;
                UNTIL PerfilSal.NEXT = 0;

            IF Empleado."Calcular Nomina" THEN BEGIN
                CalcularDtosLegales;
                //      IF NOT Empleado."Excluido Cotizacion SFS" THEN
                IF NOT ConfNominas."Impuestos manuales" THEN
                    CalcularISR;
            END;

            IF Empleado."Termination Date" <> 0D THEN BEGIN
                IF Contrato."Fecha finalizacion" = 0D THEN BEGIN
                    Empleado."Calcular Nomina" := FALSE;
                    Empleado."Fin contrato" := Empleado."Termination Date";
                    Empleado.MODIFY;

                    Contrato."Fecha finalizacion" := Empleado."Termination Date";
                    Contrato.Finalizado := TRUE;
                    Contrato.MODIFY;
                END;
            END;
        END;

        RegistraIncidencias;
    end;

    procedure CrearCabecera()
    var
        CompanyTaxes: Record 34002121;
        GestNoSer: Codeunit "No. Series";
    begin
        IF CabNomina."No. Documento" = '' THEN BEGIN
            ConfNominas.TESTFIELD("No. serie nominas");
            //TODO: Ver GestNoSer.InitSeries(ConfNominas."No. serie nominas", ConfNominas."No. serie nominas", 0D, CabNomina."No. Documento",
            //TODO: Ver                      ConfNominas."No. serie nominas");
        END;

        //Create Payroll Header
        CabNomina."No. empleado" := GlobalRec."No. empleado";
        CabNomina.Ano := Ano;
        CabNomina.Periodo := GlobalRec."Inicio Periodo";
        CabNomina."Tipo Nomina" := GlobalRec."Tipo Nomina";
        CabNomina."Empresa cotizacion" := GlobalRec."Empresa cotizacion";
        CabNomina."Centro trabajo" := Empleado."Working Center";
        //Revisar CabNomina."Grupo cotizac"      := empleado."Nivel Empleado";
        //CabNomina."Horas jornada"      :=
        //CabNomina."Base ISR"           :=
        CabNomina.Inicio := GlobalRec."Inicio Periodo";
        CabNomina.Fin := GlobalRec."Fin Periodo";
        CabNomina."Fecha Entrada" := Empleado."Employment Date";
        CabNomina."Fecha Salida" := Empleado."Termination Date";
        CabNomina.Nombre := Empleado."Full Name";
        CabNomina.Cargo := Empleado."Job Type Code";
        //CabNomina."Fecha antigüedad"   := empleado."Disponible 5";
        //CabNomina."No. Contabilizacion":=
        CabNomina."Tipo Empleado" := Empleado."Tipo Empleado";
        CabNomina.Banco := Empleado."Disponible 1";
        CabNomina."Tipo Cuenta" := Empleado."Disponible 2";
        CabNomina.Cuenta := Empleado.Cuenta;
        CabNomina."Forma de Cobro" := Empleado."Forma de Cobro";
        CabNomina.VALIDATE("Shortcut Dimension 1 Code", Empleado."Global Dimension 1 Code");
        CabNomina.VALIDATE("Shortcut Dimension 2 Code", Empleado."Global Dimension 2 Code");
        CabNomina.Departamento := Empleado.Departamento;
        CabNomina."Sub-Departamento" := Empleado."Sub-Departamento";

        recTmpDimEntry.DELETEALL;
        InsertarDimTempDef(5200);
        CabNomina."Dimension Set ID" := cduDim.GetDimensionSetID(recTmpDimEntry);

        CabNomina.INSERT;

        Contrato.SETRANGE("No. empleado", Empleado."No.");
        //GRN Contrato.SETRANGE("Centro trabajo",Empleado."Working Center");
        Contrato.SETRANGE(Finalizado, FALSE);
        Contrato.FINDFIRST;


        //Create Company's Taxes Header
        CompanyTaxes."No. Documento" := CabNomina."No. Documento";
        CompanyTaxes."Unidad cotizacion" := CabNomina."Empresa cotizacion";
        CompanyTaxes.Periodo := CabNomina.Periodo;
        IF CompanyTaxes.INSERT THEN;
    end;

    procedure CalcularIngresos()
    var
        LinNominasES: Record 34002118;
        Incidencias: Record 5207;
        Incidencias2: Record 5207;
        Puestos: Record 34002110;
        CauseAbs: Record 5206;
        MovNovAD: Record 34002114;
        MovNovAD2: Record 34002114;
        HistVac: Record 34002141;
        ImporteIncid: Decimal;
        DiasIncid: Decimal;
        DiasPago: Decimal;
        CantidadDiasEnt: Decimal;
        CantidadDiasSal: Decimal;
        DiasAusencia: Decimal;
        DiasCal: Decimal;
        DiaEntrada: Integer;
    begin
        CantidadDiasEnt := 0;
        CantidadDiasSal := 0;
        DiasPago := 0;
        DiasIncid := 0;
        DiasCal := 0;


        Empleado.TESTFIELD("Job Type Code");
        Puestos.GET(Empleado.Departamento, Empleado."Job Type Code");

        IF (PerfilSal."Tipo concepto" = PerfilSal."Tipo concepto"::Ingresos) AND
           (PerfilSal."Tipo Nomina" = GlobalRec."Tipo Nomina") THEN BEGIN
            PerfilSal.TESTFIELD(Cantidad);
            PerfilSal.TESTFIELD(Importe);

            ImporteTotal := PerfilSal.Cantidad * ROUND(PerfilSal.Importe);
            ImporteBaseImp := ImporteTotal;

            IF PerfilSal."Currency Code" <> '' THEN
                IF ConfNominas."Tasa Cambio Calculo Divisa" <> 0 THEN BEGIN
                    ImporteTotal := ROUND(PerfilSal.Importe) * ConfNominas."Tasa Cambio Calculo Divisa";
                    ImporteBaseImp := ImporteTotal;
                END
                ELSE BEGIN
                    CurrExchange.SETRANGE("Currency Code", PerfilSal."Currency Code");
                    CurrExchange.SETRANGE("Starting Date", 0D, PerFinal);
                    CurrExchange.FINDLAST;
                    ImporteTotal := ROUND(PerfilSal.Importe) * CurrExchange."Relational Exch. Rate Amount";
                    ImporteBaseImp := ImporteTotal;
                END;


            IF PerfilSal."Salario Base" THEN BEGIN
                IF PerfilSal."Currency Code" <> '' THEN BEGIN
                    IF ConfNominas."Tasa Cambio Calculo Divisa" <> 0 THEN BEGIN
                        IngresoSalario := PerfilSal.Importe * ConfNominas."Tasa Cambio Calculo Divisa";
                        ImporteTotal := IngresoSalario;
                        ImporteBaseImp := ImporteTotal;
                    END
                    ELSE BEGIN
                        CurrExchange.SETRANGE("Currency Code", PerfilSal."Currency Code");
                        CurrExchange.SETRANGE("Starting Date", 0D, PerFinal);
                        CurrExchange.FINDLAST;
                        IngresoSalario := PerfilSal.Importe * CurrExchange."Relational Exch. Rate Amount";
                        ImporteTotal := IngresoSalario;
                        ImporteBaseImp := ImporteTotal;
                    END;

                    IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) AND
                       (PerfilSal."1ra Quincena") AND (PerfilSal."2da Quincena") THEN

                        //GRN            IF Contrato."Tipo Pago Nomina" = Contrato."Tipo Pago Nomina"::Quincenal THEN
                        ImporteTotal /= 2;
                END
                ELSE BEGIN
                    IngresoSalario := PerfilSal.Importe;

                    IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) AND
                       (PerfilSal."1ra Quincena") AND (PerfilSal."2da Quincena") THEN

                        //GRN           IF Contrato."Tipo Pago Nomina" = Contrato."Tipo Pago Nomina"::Quincenal THEN
                        IF PerfilSal."1ra Quincena" AND PerfilSal."2da Quincena" THEN
                            ImporteTotal /= 2;
                END;

                IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal THEN BEGIN
                    CantidadDiasEnt := 15;

                    //GRN            IF (Empleado."Employment Date" > DMY2DATE(1,DATE2DMY(PerInici,2),DATE2DMY(PerInici,3))) THEN
                    IF (Empleado."Employment Date" > PerInici) THEN BEGIN
                        CantidadDiasEnt := PerFinal - Empleado."Employment Date" + 1;

                        CantidadDiasEnt := CantidadDiasEnt - DiasAusencia;
                        IF CantidadDiasEnt > 15 THEN
                            CantidadDiasEnt := 15
                        ELSE
                            IF CantidadDiasEnt <= 0 THEN
                                ERROR(Err001, CantidadDiasEnt, Empleado."No.");

                        //message('%1 %2 %3 %4',cantidaddiasent);
                        /* Fecha.RESET;
                         Fecha.SETRANGE("Period Type",0); //Dia
                         Fecha.SETRANGE("Period Start",Empleado."Employment Date",PerFinal);
         //                Fecha.setrange("Period End",closingdate(perfinal));
                         Fecha.SETRANGE("Period No.",6,7);//Sabado y Domingo
                         IF Fecha.FINDSET THEN
                            REPEAT
                             CASE Fecha."Period No." OF
                              6:
                               CantidadDiasEnt -= 0.5;
                              7:
                               CantidadDiasEnt -= 1;
                             END;
         //                    message('%1 %2 %3 %4',cantidaddiasent,Fecha."Period No.");
                          UNTIL Fecha.NEXT = 0;
         */
                        DiasPago := CantidadDiasEnt;
                        ImporteBaseImp := ImporteTotal;
                    END;
                END
                ELSE
                    IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Mensual THEN BEGIN
                        CantidadDiasEnt := 30;
                        IF Empleado."Employment Date" > PerInici THEN BEGIN
                            EVALUATE(DiaEntrada, FORMAT(DATE2DMY(Empleado."Employment Date", 1)));
                            CantidadDiasEnt := 30 - DiaEntrada + 1;

                            CantidadDiasEnt := CantidadDiasEnt - DiasAusencia;

                            IF CantidadDiasEnt <= 0 THEN
                                ERROR(Err001, CantidadDiasEnt, Empleado."No.");

                            //message('%1 %2 %3 %4',cantidaddiasent);
                            IF Puestos."Método cálculo Ingresos" = '' THEN
                                CalcDias.GET(ConfNominas."Metodo calculo Ingresos")
                            ELSE
                                CalcDias.GET(Puestos."Método cálculo Ingresos");

                            IF CalcDias.Valor <> 30 THEN BEGIN
                                Fecha.RESET;
                                Fecha.SETRANGE("Period Type", 0); //Dia
                                Fecha.SETRANGE("Period Start", Empleado."Employment Date", PerFinal);
                                //                Fecha.setrange("Period End",closingdate(perfinal));
                                Fecha.SETRANGE("Period No.", 6, 7);//Sabado y Domingo
                                IF Fecha.FINDSET THEN
                                    REPEAT
                                        CASE Fecha."Period No." OF
                                            6:
                                                CantidadDiasEnt -= 0.5;
                                            7:
                                                CantidadDiasEnt -= 1;
                                        END;
                                    //                        message('%1 %2 %3 %4',cantidaddiasent,Fecha."Period No.");
                                    UNTIL Fecha.NEXT = 0;
                            END;

                            DiasPago := CantidadDiasEnt;
                            ImporteBaseImp := ImporteTotal;

                        END;
                    END;

                //Para deducir las incidencias
                CLEAR(Incidencias);
                Incidencias.SETRANGE("Employee No.", Empleado."No.");
                Incidencias.SETFILTER("From Date", '>=%1', DMY2DATE(1, DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)));
                Incidencias.SETFILTER("To Date", '<=%1', PerFinal);
                Incidencias.SETRANGE(Closed, FALSE);
                Incidencias.SETFILTER("% To deduct", '<>%1', 0);
                IF Incidencias.FINDSET(FALSE, FALSE) THEN BEGIN
                    REPEAT
                        DiasIncid += (Incidencias."To Date" - Incidencias."From Date" + 1) *
                                               Incidencias."% To deduct" / 100;
                        Incidencias2.COPY(Incidencias);
                        Incidencias2.Closed := TRUE;
                        Incidencias2.MODIFY;
                    UNTIL Incidencias.NEXT = 0;

                    IF DiasIncid <= 0 THEN
                        DiasIncid := 1;
                    CalcDias.GET(ConfNominas."Método cálculo ausencias");
                    ImporteIncid := IngresoSalario / CalcDias.Valor * DiasIncid;
                    ImporteTotal := ImporteTotal - ImporteIncid;
                END;
                /*
                        //Para guardar y descontar los dias de Vacaciones disfrutadas
                        CLEAR(Incidencias);
                        Incidencias.SETRANGE("Employee No.",Empleado."No.");
                        Incidencias.SETFILTER("From Date",'>=%1',DMY2DATE(1,DATE2DMY(PerInici,2),DATE2DMY(PerInici,3)));
                        Incidencias.SETFILTER("To Date",'<=%1',PerFinal);
                        Incidencias.SETRANGE("% To deduct",0);
                        Incidencias.SETRANGE(Closed,FALSE);
                        IF Incidencias.FINDSET(FALSE,FALSE) THEN
                           REPEAT
                            CauseAbs.GET(Incidencias."Cause of Absence Code");
                            CASE CauseAbs."Dias laborables" OF

                            2: //Vacaciones
                             BEGIN
                              Incidencias.TESTFIELD("From Date");
                              Incidencias.TESTFIELD("To Date");
                              HistVac.INIT;
                              HistVac."No. empleado" := Incidencias."Employee No.";
                              HistVac."Fecha Inicio" := Incidencias."From Date";
                              HistVac."Fecha Fin"    := Incidencias."To Date";
                              HistVac.Dias           := Incidencias.Quantity *-1;
                              IF NOT HistVac.INSERT THEN
                                 HistVac.MODIFY;

                              MovNovAD.INIT;
                              MovNovAD.VALIDATE("Tipo de accion",Incidencias."Employee No.");
                              MovNovAD."Editar salario" := CauseAbs."Dias laborables";
                              MovNovAD."Editar cargo" := Incidencias."From Date";
                              MovNovAD."Transferir entre empresas"    := Incidencias."To Date";
                              IF NOT MovNovAD.INSERT THEN
                                 MovNovAD.MODIFY;
                             END;
                            END;
                           UNTIL Incidencias.NEXT = 0;
                           */
                IF Empleado."Termination Date" <> 0D THEN
                    IF (Empleado."Termination Date" >= PerInici) AND (Empleado."Termination Date" < PerFinal) THEN BEGIN
                        IF Empleado."Employment Date" >= PerInici THEN
                            CantidadDiasSal := Empleado."Termination Date" - Empleado."Employment Date" + 1
                        ELSE
                            CantidadDiasSal := Empleado."Termination Date" - PerInici + 1;

                        CantidadDiasEnt := CantidadDiasEnt - CantidadDiasSal + 1;
                        IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal THEN BEGIN
                            IF CantidadDiasSal > 15 THEN
                                CantidadDiasSal := 0;

                            //Para no incluir en el calculo los dias con incidencias
                            Fecha.RESET;
                            Incidencias.RESET;
                            Incidencias.SETRANGE("Employee No.", Empleado."No.");
                            Incidencias.SETFILTER("From Date", '>=%1', DMY2DATE(1, DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)));
                            Incidencias.SETFILTER("To Date", '<=%1', PerFinal);
                            Incidencias.SETFILTER("% To deduct", '<>%1', 0);
                            IF Incidencias.FINDSET THEN
                                Fecha.SETRANGE("Period Start", Incidencias."To Date", PerFinal)
                            ELSE
                                IF Empleado."Employment Date" >= PerInici THEN
                                    Fecha.SETRANGE("Period Start", Empleado."Employment Date", PerFinal)
                                ELSE
                                    IF Empleado."Termination Date" <= PerFinal THEN
                                        Fecha.SETRANGE("Period Start", PerInici, Empleado."Termination Date")
                                    ELSE
                                        Fecha.SETRANGE("Period Start", PerInici, PerFinal);

                            Fecha.SETRANGE("Period No.", 6, 7);
                            IF Fecha.FINDSET THEN
                                REPEAT
                                    CASE Fecha."Period No." OF
                                        6:
                                            CantidadDiasSal -= 0.5;
                                        7:
                                            CantidadDiasSal -= 1;
                                    END;
                                UNTIL Fecha.NEXT = 0;
                            //GRN              MESSAGE('%1 %2 %3 %4',cantidaddiassal,diaspago,DiasIncid,calendar.COUNT);
                            Cargos.GET(Empleado."Job Type Code");
                            IF Cargos."Incluye Dias Feriados" THEN BEGIN
                                Calendar.RESET;
                                IF Incidencias."To Date" <> 0D THEN
                                    Calendar.SETRANGE(Fecha, Incidencias."To Date", PerFinal)
                                ELSE
                                    Calendar.SETRANGE(Fecha, PerInici, PerFinal);
                                IF Calendar.FINDSET THEN
                                    REPEAT
                                        IF Calendar.Fecha > Incidencias."To Date" THEN
                                            IF Empleado."Termination Date" <> 0D THEN BEGIN
                                                IF (Empleado."Termination Date" >= PerInici) AND
                                                   (Empleado."Termination Date" >= Calendar.Fecha) THEN
                                                    DiasCal += 1;
                                            END
                                            ELSE
                                                DiasCal += 1;
                                    UNTIL Calendar.NEXT = 0;
                            END;
                        END;

                        DiasPago := CantidadDiasSal - DiasIncid - DiasCal;

                    END;

                IF DiasPago <> 0 THEN BEGIN
                    IF Empleado."Employment Date" >= PerInici THEN BEGIN
                        IF Puestos."Método cálculo Ingresos" = '' THEN
                            CalcDias.GET(ConfNominas."Metodo calculo Ingresos")
                        ELSE
                            CalcDias.GET(Puestos."Método cálculo Ingresos");

                        ImporteTotal := IngresoSalario / CalcDias.Valor * (DiasPago - DiasIncid);
                        ImporteBaseImp := ImporteTotal;
                    END;

                    IF (Empleado."Termination Date" >= PerInici) AND (Empleado."Termination Date" <= PerFinal) THEN BEGIN
                        CalcDias.GET(ConfNominas."Metodo calculo Salidas");
                        //                MESSAGE('%1 %2 %3',CalcDias.Valor, IngresoSalario, DiasPago);
                        ImporteTotal := IngresoSalario / CalcDias.Valor * DiasPago;
                        ImporteBaseImp := ImporteTotal;
                    END;
                END;
            END;

            LinTabla += 10;
            InsertNomina(PerfilSal);
        END;

    end;

    procedure CalcularDescuentos()
    begin
        //MESSAGE('%1 %2',PerfilSal."Tipo Nomina" , GlobalRec."Tipo Nomina" );
        IF (PerfilSal."Tipo concepto" = PerfilSal."Tipo concepto"::Deducciones) AND (PerfilSal.Cantidad <> 0) AND
           (PerfilSal.Importe <> 0) AND (NOT PerfilSal."Sujeto Cotizacion") AND (PerfilSal."Tipo Nomina" = GlobalRec."Tipo Nomina") THEN BEGIN
            PerfilSal.Importe := PerfilSal.Cantidad * ROUND(PerfilSal.Importe);
            ImporteTotal := PerfilSal.Importe * -1;

            IF PerfilSal."Currency Code" <> '' THEN BEGIN
                IF ConfNominas."Tasa Cambio Calculo Divisa" <> 0 THEN BEGIN
                    PerfilSal.Importe := ROUND(PerfilSal.Importe) * ConfNominas."Tasa Cambio Calculo Divisa";
                    ImporteTotal := PerfilSal.Importe * -1;
                END
                ELSE BEGIN
                    CurrExchange.SETRANGE("Currency Code", PerfilSal."Currency Code");
                    CurrExchange.SETRANGE("Starting Date", 0D, PerFinal);
                    CurrExchange.FINDLAST;
                    PerfilSal.Importe := ROUND(PerfilSal.Importe) * CurrExchange."Relational Exch. Rate Amount";
                    ImporteTotal := PerfilSal.Importe * -1;
                END;
            END;

            IF PerfilSal."% Retencion Ingreso Salario" <> 0 THEN BEGIN
                Empleado.SETRANGE("Date Filter", DMY2DATE(1, DATE2DMY(PerInici, 2), DATE2DMY(PerFinal, 3)), PerFinal);
                Empleado.CALCFIELDS("Acumulado Salario");
                PerfilSal.Importe := Empleado."Acumulado Salario";
                ImporteTotal := (Empleado."Acumulado Salario") * PerfilSal."% Retencion Ingreso Salario" / 100;
                IF PerfilSal."1ra Quincena" AND PerfilSal."2da Quincena" THEN
                    ImporteTotal /= 2;
            END;
            LinTabla += 10;
            InsertNomina(PerfilSal);
        END;
    end;

    procedure CalcularDtosLegales()
    var
        LinNominasES: Record 34002118;
        LinAportesEmpresa2: Record 34002122;
        DeduccGob: Record 34002129;
        CabAportesEmpresa: Record 34002121;
        LinAportesEmpresa: Record 34002122;
        PerfilSalTr: Record 34002115;
        NoLin: Integer;
        MontoAplicar: Decimal;
        IndSkip: Boolean;
        ImporteCotizacion2: Decimal;
        ImporteImpuestos: Decimal;
        ImporteImpuestosemp: Decimal;
        ImporteCotizacionEmp: Decimal;
    begin
        DeduccGob.RESET;
        DeduccGob.SETRANGE(Ano, Ano);
        IF DeduccGob.FINDSET(FALSE, FALSE) THEN
            REPEAT
                IndSkip := FALSE;
                ImporteCotizacion := 0;
                ImporteCotizacionEmp := 0;
                PerfilSalTr.RESET;
                PerfilSalTr.SETRANGE("No. empleado", GlobalRec."No. empleado");
                PerfilSalTr.SETRANGE("Concepto salarial", DeduccGob.Codigo);
                PerfilSalTr.FINDFIRST;
                //    PerfilSalTr."Sujeto Cotizacion",Contrato."Tipo Pago Nomina",PerfilSalTr."1ra Quincena",PerfilSalTr."2da Quincena");
                //GRN    IF (PerfilSalTr."Sujeto Cotizacion") AND (Contrato."Tipo Pago Nomina" = Contrato."Tipo Pago Nomina"::Quincenal) THEN

                LinNominasES.RESET;
                LinNominasES.SETRANGE("No. empleado", GlobalRec."No. empleado");
                LinNominasES.SETRANGE("Tipo Nomina", GlobalRec."Tipo Nomina");

                IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Mensual THEN BEGIN
                    LinNominasES.SETRANGE(Periodo, DMY2DATE(1, DATE2DMY(PerInici, 2), DATE2DMY(PerFinal, 3)), PerFinal);
                    LinNominasES.SETRANGE("Sujeto Cotizacion", TRUE);
                    IF ConfNominas."Concepto AFP" = DeduccGob.Codigo THEN
                        LinNominasES.SETRANGE("Cotiza AFP", TRUE)
                    ELSE
                        IF ConfNominas."Concepto INFOTEP" = DeduccGob.Codigo THEN BEGIN
                            LinNominasES.SETRANGE("Cotiza Infotep", TRUE);
                            IF GlobalRec."Tipo Nomina" = GlobalRec."Tipo Nomina"::Bonificacion THEN BEGIN
                                DeduccGob."Porciento Empresa" /= 2;
                                DeduccGob."Porciento Empleado" := DeduccGob."Porciento Empresa";
                            END;
                        END
                        ELSE
                            IF ConfNominas."Concepto SRL" = DeduccGob.Codigo THEN
                                LinNominasES.SETRANGE("Cotiza SRL", TRUE)
                            ELSE
                                IF ConfNominas."Concepto SFS" = DeduccGob.Codigo THEN
                                    LinNominasES.SETRANGE("Cotiza SFS", TRUE);

                    IF Empleado."Excluido Cotizacion TSS" THEN
                        IndSkip := TRUE;

                    IF LinNominasES.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            ImporteCotizacion += LinNominasES.Total;
                            ImporteCotizacionEmp += LinNominasES.Total;
                        UNTIL LinNominasES.NEXT = 0;
                    // MESSAGE('pas a   %1 %2 %3 %4',ImporteCotizacion,PerfilSal."Concepto salarial");
                END
                ELSE

                    IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal THEN BEGIN
                        IF (PerfilSalTr."1ra Quincena") AND (NOT PerfilSalTr."2da Quincena") AND (PrimeraQ) THEN BEGIN
                            LinNominasES.SETRANGE(Periodo, DMY2DATE(1, DATE2DMY(PerInici, 2), DATE2DMY(PerFinal, 3)), PerFinal);
                            LinNominasES.SETRANGE("Sujeto Cotizacion", TRUE);
                            IF ConfNominas."Concepto AFP" = DeduccGob.Codigo THEN
                                LinNominasES.SETRANGE("Cotiza AFP", TRUE)
                            ELSE
                                IF ConfNominas."Concepto INFOTEP" = DeduccGob.Codigo THEN BEGIN
                                    LinNominasES.SETRANGE("Cotiza Infotep", TRUE);
                                    IF GlobalRec."Tipo Nomina" = GlobalRec."Tipo Nomina"::Bonificacion THEN BEGIN
                                        //                    IF ConfNominas."Metodo Calculo SS" = ConfNominas."Metodo Calculo SS"::Balanceado THEN
                                        //                       DeduccGob."Porciento Empresa"   /= 2;
                                        DeduccGob."Porciento Empleado" := DeduccGob."Porciento Empresa";
                                    END;
                                END
                                ELSE
                                    IF ConfNominas."Concepto SRL" = DeduccGob.Codigo THEN
                                        LinNominasES.SETRANGE("Cotiza SRL", TRUE)
                                    ELSE
                                        IF ConfNominas."Concepto SFS" = DeduccGob.Codigo THEN
                                            LinNominasES.SETRANGE("Cotiza SFS", TRUE);

                            IF Empleado."Excluido Cotizacion TSS" THEN
                                IndSkip := TRUE;

                            IF LinNominasES.FINDSET(FALSE, FALSE) THEN
                                REPEAT
                                    IF Empleado."Employment Date" >= PerInici THEN BEGIN
                                        ImporteCotizacion += LinNominasES.Total;
                                        ImporteCotizacionEmp += LinNominasES.Total;
                                    END
                                    ELSE BEGIN
                                        ImporteCotizacion += LinNominasES.Total;
                                        ImporteCotizacionEmp += LinNominasES.Total; //Ojo, importe base
                                    END;
                                UNTIL LinNominasES.NEXT = 0;
                            //    MESSAGE('pas a   %1 %2 %3 %4',ImporteCotizacion,PerfilSal."Concepto salarial");
                        END
                        ELSE
                            IF (NOT PerfilSalTr."1ra Quincena") AND (PerfilSalTr."2da Quincena") AND (SegundaQ) THEN BEGIN
                                LinNominasES.SETRANGE(Periodo, DMY2DATE(1, DATE2DMY(PerInici, 2), DATE2DMY(PerFinal, 3)), PerFinal);
                                LinNominasES.SETRANGE("Sujeto Cotizacion", TRUE);
                                IF ConfNominas."Concepto AFP" = DeduccGob.Codigo THEN
                                    LinNominasES.SETRANGE("Cotiza AFP", TRUE)
                                ELSE
                                    IF ConfNominas."Concepto INFOTEP" = DeduccGob.Codigo THEN BEGIN
                                        LinNominasES.SETRANGE("Cotiza Infotep", TRUE);
                                        IF GlobalRec."Tipo Nomina" = GlobalRec."Tipo Nomina"::Bonificacion THEN BEGIN
                                            //                   IF ConfNominas."Metodo Calculo SS" = ConfNominas."Metodo Calculo SS"::Balanceado THEN
                                            //                      DeduccGob."Porciento Empresa"   /= 2;
                                            DeduccGob."Porciento Empleado" := DeduccGob."Porciento Empresa";
                                        END;
                                    END
                                    ELSE
                                        IF ConfNominas."Concepto SRL" = DeduccGob.Codigo THEN
                                            LinNominasES.SETRANGE("Cotiza SRL", TRUE)
                                        ELSE
                                            IF ConfNominas."Concepto SFS" = DeduccGob.Codigo THEN
                                                LinNominasES.SETRANGE("Cotiza SFS", TRUE);

                                IF Empleado."Excluido Cotizacion TSS" THEN
                                    IndSkip := TRUE;

                                IF LinNominasES.FINDSET(FALSE, FALSE) THEN
                                    REPEAT
                                        ImporteCotizacion += LinNominasES.Total;
                                        ImporteCotizacionEmp += LinNominasES.Total;
                                    UNTIL LinNominasES.NEXT = 0;
                                //                 MESSAGE('pas 2   %1 %2 %3 %4',ImporteCotizacion,LinNominasES.Total,LinNominasES.Periodo);
                            END
                            ELSE
                                IF (PerfilSalTr."1ra Quincena") AND (PerfilSalTr."2da Quincena") THEN BEGIN
                                    LinNominasES.SETRANGE(Periodo, DMY2DATE(1, DATE2DMY(PerInici, 2), DATE2DMY(PerFinal, 3)), PerFinal);
                                    IF ConfNominas."Concepto AFP" = DeduccGob.Codigo THEN
                                        LinNominasES.SETRANGE("Cotiza AFP", TRUE)
                                    ELSE
                                        IF ConfNominas."Concepto INFOTEP" = DeduccGob.Codigo THEN BEGIN
                                            LinNominasES.SETRANGE("Cotiza Infotep", TRUE);
                                            IF GlobalRec."Tipo Nomina" = GlobalRec."Tipo Nomina"::Bonificacion THEN BEGIN
                                                //                   IF ConfNominas."Metodo Calculo SS" = ConfNominas."Metodo Calculo SS"::Balanceado THEN
                                                //                      DeduccGob."Porciento Empresa"   /= 2;
                                                DeduccGob."Porciento Empleado" := DeduccGob."Porciento Empresa";
                                            END;
                                        END
                                        ELSE
                                            IF ConfNominas."Concepto SRL" = DeduccGob.Codigo THEN
                                                LinNominasES.SETRANGE("Cotiza SRL", TRUE)
                                            ELSE
                                                IF ConfNominas."Concepto SFS" = DeduccGob.Codigo THEN
                                                    LinNominasES.SETRANGE("Cotiza SFS", TRUE);

                                    IF Empleado."Excluido Cotizacion TSS" THEN
                                        IndSkip := TRUE;
                                    IF LinNominasES.FINDSET(FALSE, FALSE) THEN
                                        REPEAT
                                            IF LinNominasES."Salario Base" AND PrimeraQ THEN BEGIN
                                                ImporteCotizacion := LinNominasES.Total;
                                                ImporteCotizacionEmp := LinNominasES.Total;
                                            END
                                            ELSE BEGIN
                                                ImporteCotizacionEmp += LinNominasES.Total;
                                                ImporteCotizacion += LinNominasES.Total;
                                            END;
                                        UNTIL LinNominasES.NEXT = 0;

                                    //GRN Para verificar el acumulado del mes en la segunda Quinc. y no descontar mas del tope
                                    IF SegundaQ THEN BEGIN
                                        /*GRN 29/08/2011
                                        ImporteCotizacion2 := ImporteCotizacion;
                                        //Busco el importe cotizable
                                        LinNominasES.RESET;
                                        LinNominasES.SETRANGE("No. empleado",GlobalRec."No. empleado");
                                        LinNominasES.SETRANGE("Tipo Nomina",GlobalRec."Tipo Nomina");
                                        LinNominasES.SETRANGE(Periodo,DMY2DATE(1,DATE2DMY(PerInici,2),DATE2DMY(PerInici,3)));
                                        IF ConfNominas."Concepto AFP" = DeduccGob.Codigo THEN
                                           LinNominasES.SETRANGE("Cotiza AFP",TRUE)
                                        ELSE
                                        IF ConfNominas."Concepto INFOTEP" = DeduccGob.Codigo THEN
                                           BEGIN
                                            LinNominasES.SETRANGE("Cotiza Infotep",TRUE);
                                            IF GlobalRec."Tipo Nomina" = GlobalRec."Tipo Nomina"::Bonificacion THEN
                                               BEGIN
                                                DeduccGob."Porciento Empresa"   /= 2;
                                                DeduccGob."Porciento Empleado"  := DeduccGob."Porciento Empresa";
                                               END;
                                           END
                                        ELSE
                                        IF ConfNominas."Concepto SRL" = DeduccGob.Codigo THEN
                                           LinNominasES.SETRANGE("Cotiza SRL",TRUE)
                                        ELSE
                                        IF ConfNominas."Concepto SFS" = DeduccGob.Codigo THEN
                                          LinNominasES.SETRANGE("Cotiza SFS",TRUE);

                                        IF Empleado."Excluido Cotizacion TSS" THEN
                                           IndSkip := TRUE;
                                        //message('aqui %1 %2 %3 %4',importecotizacion,importecotizacion2,DeduccGob.Codigo);
                                        IF LinNominasES.FINDSET THEN
                                           REPEAT
                                            ImporteCotizacion2 += LinNominasES.Total;
                                           UNTIL LinNominasES.NEXT = 0;
                                        */
                                        ImporteImpuestos := 0;

                                        //Busco el importe cobrado del impuesto
                                        LinNominasES.RESET;
                                        LinNominasES.SETRANGE("No. empleado", GlobalRec."No. empleado");
                                        LinNominasES.SETRANGE("Tipo Nomina", GlobalRec."Tipo Nomina");
                                        LinNominasES.SETRANGE(Periodo, DMY2DATE(1, DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)));
                                        LinNominasES.SETRANGE("Concepto salarial", DeduccGob.Codigo);
                                        IF LinNominasES.FINDSET THEN
                                            REPEAT
                                                ImporteImpuestos += LinNominasES.Total;
                                            UNTIL LinNominasES.NEXT = 0;
                                    END;
                                END
                    END;

                //GRN    IF (PerfilSalTr."1ra Quincena") AND (PerfilSalTr."2da Quincena") and (PerfilSalTr."salario base")THEN
                //GRN       ImporteCotizacion *= 2;

                IF (ImporteCotizacion > DeduccGob."Tope Salarial/Acumulado Anual") AND (DeduccGob."Tope Salarial/Acumulado Anual" <> 0) THEN BEGIN
                    ImporteCotizacion := DeduccGob."Tope Salarial/Acumulado Anual";
                    MontoAplicar := ImporteCotizacion * DeduccGob."Porciento Empleado" / 100;
                    IF (ABS(ImporteImpuestos) >= MontoAplicar) AND (ImporteImpuestos <> 0) AND (MontoAplicar <> 0) THEN
                        IndSkip := TRUE;
                END;

                IF (ImporteCotizacion > DeduccGob."Tope Salarial/Acumulado Anual") AND (DeduccGob."Tope Salarial/Acumulado Anual" <> 0) THEN
                    ImporteCotizacion := DeduccGob."Tope Salarial/Acumulado Anual";

                IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal THEN BEGIN
                    IF ((PerfilSalTr."1ra Quincena" <> PrimeraQ) AND (PrimeraQ) AND
                       ((Empleado."Fecha salida empresa" = 0D) OR (Empleado."Fecha salida empresa" >= PerFinal))) THEN
                        IndSkip := TRUE;

                    IF (NOT PerfilSalTr."1ra Quincena") AND (PerfilSalTr."2da Quincena") AND (PrimeraQ) THEN
                        IndSkip := TRUE;

                    IF ((PerfilSalTr."2da Quincena" <> SegundaQ) AND (SegundaQ) AND
                       ((Empleado."Fecha salida empresa" = 0D) OR (Empleado."Fecha salida empresa" >= PerFinal))) THEN
                        IndSkip := TRUE;
                END;

                //Employee
                IF (DeduccGob."Porciento Empleado" <> 0) OR
                   (DeduccGob."Porciento Empleado Pensionados" <> 0) THEN BEGIN

                    //       message('bb %1 %2 %3 %4 %5 %6 %7',
                    //       DeduccGob.Codigo,montoaplicar,importeimpuestos,indskip,importecotizacion,importecotizacionemp);
                    IF Empleado.Pensionado THEN
                        MontoAplicar := ImporteCotizacionEmp * DeduccGob."Porciento Empleado Pensionados" / 100
                    ELSE
                        MontoAplicar := ImporteCotizacionEmp * DeduccGob."Porciento Empleado" / 100;

                    IF (ImporteCotizacion >= DeduccGob."Tope Salarial/Acumulado Anual") AND (DeduccGob."Tope Salarial/Acumulado Anual" <> 0) THEN BEGIN
                        ImporteCotizacion := DeduccGob."Tope Salarial/Acumulado Anual";
                        ImporteCotizacionEmp := ImporteCotizacion;
                        IF Empleado.Pensionado THEN
                            MontoAplicar := ImporteCotizacionEmp * DeduccGob."Porciento Empleado Pensionados" / 100
                        ELSE
                            MontoAplicar := ImporteCotizacion * DeduccGob."Porciento Empleado" / 100;
                        //24/11/11            MontoAplicar         += ImporteImpuestos;
                        IF MontoAplicar < 0 THEN
                            MontoAplicar := 0;
                    END;

                    IF NOT IndSkip THEN BEGIN
                        PerfilSalTr.Importe := ImporteCotizacion;
                        PerfilSalTr.Cantidad := 1;

                        //            MontoAplicar         := ImporteImpuestos;
                        //           message('cc %1 %2 %3 %4 %5',importetotal,montoaplicar);
                        ImporteTotal := MontoAplicar * -1;
                        IF Empleado.Pensionado THEN
                            "%Cot" := DeduccGob."Porciento Empleado Pensionados"
                        ELSE
                            "%Cot" := DeduccGob."Porciento Empleado";
                        LinTabla += 10;
                        //            message('cc %1 %2 %3 %4 %5',importetotal);
                        IF ImporteTotal <> 0 THEN
                            InsertNomina(PerfilSalTr);
                    END;
                END;

                //Employer
                NoLin += 10;
                LinAportesEmpresa."No. Documento" := CabNomina."No. Documento";
                LinAportesEmpresa."No. orden" := NoLin;
                LinAportesEmpresa."Empresa cotizacion" := CabNomina."Empresa cotizacion";
                LinAportesEmpresa.Periodo := CabNomina.Periodo;
                LinAportesEmpresa."No. Empleado" := CabNomina."No. empleado";
                LinAportesEmpresa.VALIDATE("Concepto Salarial", DeduccGob.Codigo);
                IF Empleado.Pensionado THEN
                    LinAportesEmpresa."% Cotizable" := DeduccGob."Porciento Empresa Pensionados"
                ELSE
                    LinAportesEmpresa."% Cotizable" := DeduccGob."Porciento Empresa";
                LinAportesEmpresa."Base Imponible" := ImporteCotizacionEmp;
                IF Empleado.Pensionado THEN
                    LinAportesEmpresa.Importe := ImporteCotizacionEmp * DeduccGob."Porciento Empresa Pensionados" / 100
                ELSE
                    LinAportesEmpresa.Importe := ImporteCotizacionEmp * DeduccGob."Porciento Empresa" / 100;
                LinAportesEmpresa.Descripcion := PerfilSalTr.Descripcion;

                IF ((Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) AND
                   (PerfilSalTr."1ra Quincena") AND (PerfilSalTr."2da Quincena") AND (PrimeraQ)) OR
                   (Empleado."Fecha salida empresa" <> 0D) THEN BEGIN
                    //            IF ConfNominas."Metodo Calculo SS" = ConfNominas."Metodo Calculo SS"::Balanceado THEN
                    //               LinAportesEmpresa.Importe           /= 2;
                END
                ELSE
                    IF ((Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) AND
                       (PerfilSalTr."1ra Quincena") AND (PerfilSalTr."2da Quincena")) AND
                       (SegundaQ) THEN BEGIN
                        //Busco el importe cobrado del impuesto
                        ImporteImpuestosemp := 0;
                        LinAportesEmpresa2.RESET;
                        LinAportesEmpresa2.SETRANGE("No. Empleado", GlobalRec."No. empleado");
                        LinAportesEmpresa2.SETRANGE(Periodo, DMY2DATE(1, DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)));
                        LinAportesEmpresa2.SETRANGE("Concepto Salarial", DeduccGob.Codigo);
                        IF LinAportesEmpresa2.FINDSET THEN
                            REPEAT
                                ImporteImpuestosemp += LinAportesEmpresa2.Importe;
                            UNTIL LinAportesEmpresa2.NEXT = 0;

                        LinAportesEmpresa.Importe -= ImporteImpuestosemp;
                    END;

                IF (LinAportesEmpresa.Importe <> 0) AND (NOT IndSkip) THEN BEGIN
                    recTmpDimEntry.DELETEALL;
                    //         InsertarDimTemp(ConfNominas."Dimension Conceptos Salariales",PerfilSal."Concepto salarial");               JML : Esta dimension no es necesaria
                    InsertarDimTemp(ConfNominas."Dimension Conceptos Salariales", LinAportesEmpresa."Concepto Salarial");
                    InsertarDimTempDef(5200);
                    LinAportesEmpresa."Dimension Set ID" := cduDim.GetDimensionSetID(recTmpDimEntry);
                    LinAportesEmpresa.INSERT;
                END;

            UNTIL DeduccGob.NEXT = 0;

    end;

    procedure ReCalcularDtosLegales()
    var
        LinNominasES: Record 34002118;
        DeduccGob: Record 34002129;
        CabAportesEmpresa: Record 34002121;
        LinAportesEmpresa: Record 34002122;
        PerfilSalTr: Record 34002115;
        PerfilSalTr2: Record 34002115;
        NoLin: Integer;
        MontoAplicar: Decimal;
        IndSkip: Boolean;
    begin
        ImporteCotizacionRec := 0;

        DeduccGob.RESET;
        DeduccGob.SETRANGE(Ano, Ano);
        //DeduccGob.SETFILTER("Porciento Empresa",'<>%1',0);
        IF DeduccGob.FINDSET(FALSE, FALSE) THEN
            REPEAT
                PerfilSalTr.RESET;
                PerfilSalTr.SETRANGE("No. empleado", GlobalRec."No. empleado");
                PerfilSalTr.SETRANGE("Concepto salarial", DeduccGob.Codigo);
                PerfilSalTr.SETRANGE("Cotiza ISR", TRUE);
                IF PerfilSalTr.FINDFIRST THEN
                    IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal THEN BEGIN
                        IF (PerfilSalTr."1ra Quincena") AND (PerfilSalTr."2da Quincena") AND (PrimeraQ) THEN BEGIN
                            PerfilSalTr2.RESET;
                            PerfilSalTr2.SETRANGE("No. empleado", GlobalRec."No. empleado");
                            PerfilSalTr2.SETRANGE("Tipo concepto", PerfilSalTr2."Tipo concepto"::Deducciones);
                            PerfilSalTr2.SETRANGE("Cotiza ISR", TRUE);
                            IF PerfilSalTr2.FINDSET(FALSE, FALSE) THEN
                                REPEAT
                                    IndSkip := FALSE;
                                    //Verifico si el concepto ya llego al tope para el mes
                                    LinNominasES.RESET;
                                    LinNominasES.SETRANGE("No. empleado", GlobalRec."No. empleado");
                                    LinNominasES.SETRANGE("Tipo Nomina", GlobalRec."Tipo Nomina");
                                    LinNominasES.SETRANGE(Periodo, PerInici, PerFinal);
                                    LinNominasES.SETRANGE("Concepto salarial", PerfilSalTr2."Concepto salarial");
                                    IF LinNominasES.FINDFIRST THEN
                                        REPEAT
                                            IF LinNominasES."Importe Base" >= DeduccGob."Tope Salarial/Acumulado Anual" THEN
                                                IndSkip := TRUE;

                                            IF NOT IndSkip THEN
                                                MontoAplicar := IngresoSalario * DeduccGob."Porciento Empleado" / 100;
                                        UNTIL LinNominasES.NEXT = 0;
                                UNTIL PerfilSalTr2.NEXT = 0;
                            ImporteCotizacionRec += MontoAplicar;
                        END;
                    END;
            UNTIL DeduccGob.NEXT = 0;
        ImporteCotizacionRec *= -1;
    end;

    procedure CalcularISR()
    var
        "RetencionISR": Record 34002131;
        SaldoFavor: Record 34002128;
        SaldoFavor2: Record 34002128;
        HistLinNom: Record 34002118;
        HistLinNomISR: Record 34002118;
        BKSaldoFavor: Record 34002130;
        LinAportesEmpresa: Record 34002122;
        EmpresasRel: Record 34002150;
        EmpresasRel2: Record 34002150;
        LinEsqPercepISR: Record 34002115;
        LinEsqPercepISR2: Record 34002115;
        HistLinCompany: Record 34002118;
        Indice: Integer;
        Importe1: Decimal;
        Importe2: Decimal;
        Importe3: Decimal;
        RangoISR: array[5] of Decimal;
        ImporteRetencion: array[5] of Decimal;
        "%Calcular": array[5] of Integer;
        ImporteFijo: array[5] of Decimal;
        t: Integer;
        NoLinImp: Integer;
        Base: Decimal;
        TotalCompany: Decimal;
        Err002: Label 'Employee %1 doesn''t have posted payroll in company %2, please verify';
        ImporteISR: Decimal;
    begin
        //CalculoISR
        Importe1 := 0;
        TotalCompany := 0;
        CLEAR(TotalISR);
        LinTabla += 10;
        LinNomina.INIT;
        "%Cot" := 0;

        //Busco si es quincenal cuando se deduce el ISR
        LinEsqPercepISR2.RESET;
        LinEsqPercepISR2.SETRANGE("No. empleado", GlobalRec."No. empleado");
        LinEsqPercepISR2.SETRANGE("Concepto salarial", ConfNominas."Concepto ISR");
        IF NOT LinEsqPercepISR2.FINDFIRST THEN
            LinEsqPercepISR2.INIT;

        IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal THEN
            IngresoSalario := IngresoSalario / 2;

        //Busqueda de todos los conceptos que cotizan para el calculo del ISR
        HistLinNom.RESET;
        HistLinNom.SETRANGE("No. empleado", GlobalRec."No. empleado");
        HistLinNom.SETRANGE("Tipo Nomina", Tipcalculo);
        //GRN 2012 HistLinNom.SETRANGE(Periodo,DMY2DATE(1,DATE2DMY(PerInici,2),DATE2DMY(PerInici,3)),PerFinal);
        HistLinNom.SETRANGE(Periodo, PerInici, PerFinal);
        HistLinNom.SETRANGE("Cotiza ISR", TRUE);
        IF HistLinNom.FINDSET(FALSE, FALSE) THEN
            REPEAT
                LinEsqPercepISR.RESET;
                LinEsqPercepISR.SETRANGE("No. empleado", GlobalRec."No. empleado");
                LinEsqPercepISR.SETRANGE("Concepto salarial", HistLinNom."Concepto salarial");
                LinEsqPercepISR.FINDFIRST;
                IF LinEsqPercepISR."1ra Quincena" AND LinEsqPercepISR."2da Quincena" THEN BEGIN
                    /*GRN 12/04/2012
                            IF HistLinNom."Salario Base" AND PrimeraQ THEN
                               HistLinNom.Total += IngresoSalario;
                    */
                    //Solo si el ISR se deduce en ambas quincenas
                    IF (HistLinNom.Total <> 0) AND (LinEsqPercepISR2."1ra Quincena" AND LinEsqPercepISR2."2da Quincena") THEN
                        TotalISR[1] [1] += ROUND(HistLinNom.Total, 0.01)
                    ELSE
                        IF HistLinNom.Total <> 0 THEN BEGIN
                            IF HistLinNom."Tipo concepto" = HistLinNom."Tipo concepto"::Deducciones THEN
                                TotalISR[1] [1] += ROUND(HistLinNom.Total, 0.01)
                            ELSE
                                IF (HistLinNom."Tipo concepto" = HistLinNom."Tipo concepto"::Ingresos) AND
                                   (NOT HistLinNom."Salario Base") THEN
                                    TotalISR[1] [1] += ROUND(HistLinNom.Total, 0.01)
                                ELSE
                                    TotalISR[1] [1] += ROUND(HistLinNom.Total, 0.01)
                        END;
                END
                ELSE
                    IF HistLinNom.Total <> 0 THEN BEGIN
                        TotalISR[1] [1] += ROUND(HistLinNom.Total, 0.01);
                    END;
            UNTIL HistLinNom.NEXT = 0;

        //ReCalcularDtosLegales; //Para el caso de que el ISR solo se paga en 1ra, se calculan AFP y SFS para el mes.

        TotalISR[1] [1] += ImporteCotizacionRec;

        TotalISR[1] [1] += TotalCompany;
        Base := TotalISR[1] [1];
        //ERROR('%1 %2 %3 %4',BASE,TOTALISR[1][1],TOTALCOMPANY);
        // Cálculo del ISR. Busqueda de Rangos ISR
        Indice := 1;
        RetencionISR.SETRANGE(Ano, FORMAT(Ano, 4, '<Standard Format,0>'));
        RetencionISR.FINDSET(FALSE, FALSE);
        REPEAT
            RangoISR[Indice] := RetencionISR."Importe Máximo";
            ImporteRetencion[Indice] := RetencionISR."Importe retencion";
            "%Calcular"[Indice] := RetencionISR."% Retencion";
            ImporteFijo[Indice] := RetencionISR."Importe retencion";
            Indice += 1;
        UNTIL RetencionISR.NEXT = 0;

        IF TotalISR[1] [1] < (RangoISR[1]) THEN
            EXIT;

        IF (TotalISR[1] [1] >= RangoISR[1]) AND (TotalISR[1] [1] < RangoISR[2]) AND (RangoISR[2] <> 0) THEN BEGIN
            Importe1 := (TotalISR[1] [1] - RangoISR[1]) * "%Calcular"[1] / 100;
            Importe1 += ImporteRetencion[1] + ImporteFijo[1];
            "%Cot" := "%Calcular"[1];
        END
        ELSE
            IF (TotalISR[1] [1] >= RangoISR[2]) AND (TotalISR[1] [1] < RangoISR[3]) AND (RangoISR[3] <> 0) OR
               (TotalISR[1] [1] >= RangoISR[2]) AND (RangoISR[3] = 0) THEN BEGIN
                Importe1 := (TotalISR[1] [1] - RangoISR[2]) * "%Calcular"[2] / 100;
                Importe1 += ImporteRetencion[2] + ImporteFijo[1];
                "%Cot" := "%Calcular"[2];
            END
            ELSE
                IF (TotalISR[1] [1] >= RangoISR[3]) AND (TotalISR[1] [1] < RangoISR[4]) AND (RangoISR[4] <> 0) OR
                   (TotalISR[1] [1] >= RangoISR[3]) AND (RangoISR[4] = 0) THEN BEGIN
                    Importe1 := (TotalISR[1] [1] - RangoISR[3]) * "%Calcular"[3] / 100;
                    Importe1 += ImporteRetencion[3] + ImporteFijo[2] + ImporteFijo[1];
                    "%Cot" := "%Calcular"[3];
                END
                ELSE
                    IF ((TotalISR[1] [1] >= RangoISR[4]) AND (TotalISR[1] [1] < RangoISR[5]) AND
                        (RangoISR[5] <> 0)) OR ((TotalISR[1] [1] >= RangoISR[4]) AND (RangoISR[5] = 0)) THEN BEGIN
                        Importe1 := (TotalISR[1] [1] - RangoISR[4]) * "%Calcular"[4] / 100;
                        Importe1 += ImporteRetencion[4] + ImporteFijo[3] + ImporteFijo[2] + ImporteFijo[1];
                        "%Cot" := "%Calcular"[4];
                    END
                    ELSE
                        IF (TotalISR[1] [1]) >= (RangoISR[5]) THEN BEGIN
                            Importe1 := (TotalISR[1] [1] - RangoISR[5]) * "%Calcular"[5] / 100;
                            Importe1 += ImporteRetencion[5] + ImporteFijo[4] + ImporteFijo[3] + ImporteFijo[2] + ImporteFijo[1];
                            "%Cot" := "%Calcular"[5];
                        END;


        Importe1 := ROUND(Importe1, 0.01);
        //Aqui se buscan los saldos a favor del empleado y si encuentra uno se pasa a una tabla
        //que sirve de BK al importe
        SaldoFavor.RESET;
        SaldoFavor.SETRANGE("Cod. Empleado", GlobalRec."No. empleado");
        SaldoFavor.SETRANGE(Ano, DATE2DMY(PerInici, 3));
        SaldoFavor.SETFILTER("Importe Pendiente", '>0');
        IF SaldoFavor.FINDFIRST THEN BEGIN
            BKSaldoFavor.TRANSFERFIELDS(SaldoFavor);
            IF NOT BKSaldoFavor.INSERT THEN
                BKSaldoFavor.MODIFY;
        END;

        TotalISR[1] [1] := Importe1;

        ConceptosSal.SETRANGE(Codigo, ConfNominas."Concepto ISR");
        ConceptosSal.FINDFIRST;

        PerfilSalImp.RESET;
        PerfilSalImp.INIT;

        PerfilSalImp.SETRANGE("No. empleado", GlobalRec."No. empleado");
        PerfilSalImp.SETRANGE("Concepto salarial", ConfNominas."Concepto ISR");
        IF NOT PerfilSalImp.FINDFIRST THEN
            EXIT;

        IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal THEN
            IF ((PerfilSalImp."1ra Quincena" <> PrimeraQ) AND PrimeraQ) OR ((PerfilSalImp."2da Quincena" <> SegundaQ) AND SegundaQ) THEN
                EXIT;

        IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) AND
           (PerfilSalImp."1ra Quincena") AND (PerfilSalImp."2da Quincena") THEN
            TotalISR[1] [1] := ROUND(TotalISR[1] [1], 0.01)
        ELSE BEGIN
            HistLinNomISR.RESET;
            HistLinNomISR.SETRANGE("No. empleado", GlobalRec."No. empleado");
            HistLinNomISR.SETRANGE("Tipo Nomina", Tipcalculo);
            HistLinNomISR.SETRANGE(Periodo, DMY2DATE(1, DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)), PerFinal);
            HistLinNomISR.SETRANGE("Concepto salarial", ConfNominas."Concepto ISR");
            IF HistLinNomISR.FINDFIRST THEN
                TotalISR[1] [1] := TotalISR[1] [1] + HistLinNomISR.Total;
        END;

        IF ABS(TotalISR[1] [1]) >= SaldoFavor."Importe Pendiente" THEN BEGIN
            TotalISR[1] [1] -= SaldoFavor."Importe Pendiente";
            SaldoFavor."Importe Pendiente" := 0;
        END
        ELSE BEGIN
            SaldoFavor."Importe Pendiente" -= TotalISR[1] [1];
            TotalISR[1] [1] := 0;
        END;

        PerfilSalImp.Cantidad := 1;
        PerfilSalImp.Importe := Base;
        ImporteTotal := TotalISR[1] [1] * -1;

        IF PerfilSalImp."% ISR Pago Empleado" <> 0 THEN BEGIN
            PerfilSalImp.Importe := ROUND(TotalISR[1] [1] * PerfilSalImp."% ISR Pago Empleado" / 100, 0.01);
            ImporteTotal := PerfilSalImp.Importe * -1;

            //Employer
            LinAportesEmpresa.SETRANGE("No. Documento", CabNomina."No. Documento");
            LinAportesEmpresa.SETRANGE("No. Empleado", CabNomina."No. empleado");
            IF LinAportesEmpresa.FINDLAST THEN
                NoLinImp := LinAportesEmpresa."No. orden";

            NoLinImp += 10;
            LinAportesEmpresa.INIT;
            LinAportesEmpresa."No. Documento" := CabNomina."No. Documento";
            LinAportesEmpresa."No. orden" := NoLinImp;
            LinAportesEmpresa."Empresa cotizacion" := CabNomina."Empresa cotizacion";
            LinAportesEmpresa.Periodo := CabNomina.Periodo;
            LinAportesEmpresa."No. Empleado" := CabNomina."No. empleado";
            LinAportesEmpresa.VALIDATE("Concepto Salarial", PerfilSalImp."Concepto salarial");
            LinAportesEmpresa."% Cotizable" := ROUND("%Cot" * (100 - PerfilSalImp."% ISR Pago Empleado") / 100, 0.01);
            LinAportesEmpresa."Base Imponible" := IngresoSalario;
            LinAportesEmpresa.Importe := ROUND(TotalISR[1] [1] * (100 - PerfilSalImp."% ISR Pago Empleado") / 100, 0.01);

            recTmpDimEntry.DELETEALL;
            InsertarDimTemp(ConceptosSal."Shortcut Dimension", PerfilSalImp."Concepto salarial");
            InsertarDimTempDef(5200);
            LinAportesEmpresa."Dimension Set ID" := cduDim.GetDimensionSetID(recTmpDimEntry);

            LinAportesEmpresa.INSERT;
            "%Cot" := ROUND("%Cot" * PerfilSalImp."% ISR Pago Empleado" / 100, 0.01);

        END;

        //Modifico el Saldo ISR a Favor
        SaldoFavor2.COPYFILTERS(SaldoFavor);
        IF SaldoFavor2.FINDSET(TRUE, FALSE) THEN BEGIN
            SaldoFavor2.TRANSFERFIELDS(SaldoFavor);
            SaldoFavor2."Importe Pendiente" := SaldoFavor."Importe Pendiente";
            SaldoFavor2.MODIFY;
        END;

        InsertNomina(PerfilSalImp);

    end;

    procedure CalcularPrestamos()
    var
        LinPerfilSal: Record 34002115;
        rPrestamos: Record 34002145;
        rHistLinPrestamo: Record 34002147;
        rHistCabPrestamo: Record 34002146;
    begin
        //CalcularPrestamos

        rHistCabPrestamo.RESET;
        rHistCabPrestamo.SETRANGE("Employee No.", PerfilSal."No. empleado");
        rHistCabPrestamo.SETRANGE(Pendiente, TRUE);
        IF rHistCabPrestamo.FINDSET THEN
            REPEAT
                //Busca la cuota del prestamo

                LinPerfilSal.SETRANGE("No. empleado", PerfilSal."No. empleado");
                LinPerfilSal.SETRANGE("Concepto salarial", rHistCabPrestamo."Concepto Salarial");
                LinPerfilSal.FINDFIRST;

                rHistLinPrestamo.SETRANGE("Codigo Empleado", rHistCabPrestamo."Employee No.");
                rHistLinPrestamo.SETRANGE("No. Préstamo", rHistCabPrestamo."No. Préstamo");
                IF (rHistLinPrestamo.FINDLAST) AND (LinPerfilSal."Tipo concepto" <> 0) THEN BEGIN
                    rHistLinPrestamo."No. Linea" += 100;
                    rHistLinPrestamo."Tipo CxC" := rHistCabPrestamo."Tipo CxC";
                    rHistLinPrestamo."No. Cuota" += 1;
                    rHistLinPrestamo."Fecha Transaccion" := PerInici;
                    rHistLinPrestamo."Codigo Empleado" := LinPerfilSal."No. empleado";
                    rHistLinPrestamo.Importe := -LinPerfilSal.Importe;
                    rHistLinPrestamo.VALIDATE(Importe);
                    rHistCabPrestamo.CALCFIELDS("Importe Pendiente");
                    IF rHistCabPrestamo."Importe Pendiente" + rHistLinPrestamo.Importe = 0 THEN BEGIN
                        rHistCabPrestamo.Pendiente := FALSE;
                        rHistCabPrestamo.MODIFY;
                    END;

                    rHistLinPrestamo.INSERT;
                END;
            UNTIL rHistCabPrestamo.NEXT = 0;
    end;

    procedure CalculoBonificacion()
    var
        linperfilsal: Record 34002115;
    begin
        // Bonificacion
        PerfilSal.RESET;
        PerfilSal.SETRANGE("Empresa cotizacion", GlobalRec."Empresa cotizacion");
        PerfilSal.SETRANGE("No. empleado", GlobalRec."No. empleado");
        PerfilSal.SETRANGE("Perfil salarial", GlobalRec."Perfil salarial");
        PerfilSal.SETRANGE("Tipo Nomina", GlobalRec."Tipo Nomina");
        PerfilSal.SETFILTER(Cantidad, '<>%1', 0);
        IF PerfilSal.FINDSET(FALSE, FALSE) THEN
            REPEAT
                IF PerfilSal."Tipo concepto" = PerfilSal."Tipo concepto"::Deducciones THEN
                    ImporteTotal := (PerfilSal.Cantidad * ROUND(PerfilSal.Importe)) * -1
                ELSE
                    ImporteTotal := PerfilSal.Cantidad * ROUND(PerfilSal.Importe);

                LinTabla += 10;
                InsertNomina(PerfilSal);
            UNTIL PerfilSal.NEXT = 0;
    end;

    procedure CalculoRegalia()
    begin
        /*1.-  Ingresos    */
        //  TipCalcNom := 1;
        PerfilSal.RESET;
        PerfilSal.SETRANGE("Empresa cotizacion", GlobalRec."Empresa cotizacion");
        PerfilSal.SETRANGE("No. empleado", GlobalRec."No. empleado");
        PerfilSal.SETRANGE("Perfil salarial", GlobalRec."Perfil salarial");
        PerfilSal.SETRANGE("Tipo concepto", 0); /*Ingresos  */
        PerfilSal.SETRANGE("Tipo Nomina", GlobalRec."Tipo Nomina");
        IF PerfilSal.FINDSET(FALSE, FALSE) THEN
            REPEAT
                ImporteTotal := PerfilSal.Cantidad * ROUND(PerfilSal.Importe);
                InsertNomina(PerfilSal);
            UNTIL PerfilSal.NEXT = 0;

    end;

    procedure InsertNomina(perfSalario: Record 34002115)
    begin
        //InsertNomina
        LinNomina."Empresa cotizacion" := perfSalario."Empresa cotizacion";
        LinNomina."No. empleado" := perfSalario."No. empleado";
        LinNomina."No. Documento" := CabNomina."No. Documento";
        LinNomina.Periodo := PerInici;
        LinNomina."No. Orden" := LinTabla;
        LinNomina.Ano := Ano;
        LinNomina."Concepto salarial" := perfSalario."Concepto salarial";
        LinNomina.Descripcion := perfSalario.Descripcion;
        LinNomina.Cantidad := perfSalario.Cantidad;
        LinNomina."Importe Base" := perfSalario.Importe;
        LinNomina."Currency Code" := perfSalario."Currency Code";
        LinNomina.Total := ImporteTotal;
        LinNomina."Tipo concepto" := perfSalario."Tipo concepto";
        LinNomina."Salario Base" := perfSalario."Salario Base";
        LinNomina."Cotiza ISR" := perfSalario."Cotiza ISR";
        LinNomina."Cotiza SFS" := perfSalario."Cotiza SFS";
        LinNomina."Cotiza AFP" := perfSalario."Cotiza AFP";
        LinNomina."Cotiza SRL" := perfSalario."Cotiza SRL";
        LinNomina."Cotiza Infotep" := perfSalario."Cotiza INFOTEP";
        LinNomina."Sujeto Cotizacion" := perfSalario."Sujeto Cotizacion";
        LinNomina.Formula := perfSalario."Formula cálculo";
        LinNomina.Imprimir := perfSalario.Imprimir;
        LinNomina."Inicio periodo" := PerInici;
        LinNomina."Fin periodo" := PerFinal;
        LinNomina."Tipo Nomina" := perfSalario."Tipo Nomina";
        LinNomina."% Cotizable" := "%Cot";
        LinNomina."% Pago Empleado" := perfSalario."% ISR Pago Empleado";
        LinNomina.Departamento := Empleado.Departamento;
        LinNomina."Sub-Departamento" := Empleado."Sub-Departamento";
        LinNomina.INSERT;

        ConceptosSal.SETRANGE(Codigo, perfSalario."Concepto salarial");
        ConceptosSal.FINDFIRST;
    end;

    procedure InsertarDimTemp(DimCode: Code[20]; DimValue: Code[20])
    var
        recDimVal: Record 349;
    begin
        recDimVal.GET(DimCode, DimValue);
        recTmpDimEntry."Dimension Code" := DimCode;
        recTmpDimEntry."Dimension Value Code" := DimValue;
        recTmpDimEntry."Dimension Value ID" := recDimVal."Dimension Value ID";
        IF recTmpDimEntry.INSERT THEN;
    end;

    procedure InsertarDimTempDef(intPrmTabla: Integer)
    var
        recDfltDim: Record 352;
    begin
        recDfltDim.RESET;
        recDfltDim.SETRANGE("Table ID", intPrmTabla);
        recDfltDim.SETRANGE("No.", GlobalRec."No. empleado");
        IF recDfltDim.FINDSET(FALSE, FALSE) THEN
            REPEAT
                InsertarDimTemp(recDfltDim."Dimension Code", recDfltDim."Dimension Value Code");
            UNTIL recDfltDim.NEXT = 0;
    end;

    procedure CalculaDiasVacaciones()
    var
        HistVac: Record 34002141;
        FuncNomina: Codeunit 34002104;
        AnoCalculado: Integer;
        MesCalculado: Integer;
        DiaCalculado: Integer;
        DiasVac: Integer;
    begin

        DiasVac := FuncNomina.CalculoDiaVacacionesCR(Empleado."No.", DATE2DMY(PerFinal, 2), DATE2DMY(PerFinal, 3), 0);

        IF DiasVac <> 0 THEN BEGIN
            HistVac.RESET;
            HistVac.SETRANGE("No. empleado", Empleado."No.");
            HistVac.SETRANGE("Fecha Inicio", DMY2DATE(1, 1, DATE2DMY(PerFinal, 3)));
            IF HistVac.FINDFIRST THEN BEGIN
                IF HistVac.Dias <> DiasVac THEN BEGIN
                    HistVac.Dias := DiasVac;
                    HistVac.MODIFY;
                END;
            END
            ELSE BEGIN
                HistVac.INIT;
                HistVac."No. empleado" := Empleado."No.";
                HistVac."Fecha Inicio" := DMY2DATE(1, 1, DATE2DMY(PerFinal, 3));
                HistVac."Fecha Fin" := DMY2DATE(31, 12, DATE2DMY(PerFinal, 3));
                HistVac.Dias := DiasVac;
                HistVac.INSERT;
            END;
        END;
    end;

    procedure RegistraIncidencias()
    var
        Incidencias: Record 5207;
        MovNovedades: Record 34002114;
        CA: Record 5206;
    begin
        //Ingreso
        //Salida
        //Vacaciones
        //Licencia Voluntaria
        //Licencia Maternidad
        //Licencia x Discapacidad
        //Actualizacion de datos
        //Permiso de trabajo
        /*
        //Para registrar las incidencias
        Incidencias.RESET;
        Incidencias.SETRANGE("Employee No.",Empleado."No.");
        Incidencias.SETFILTER("From Date",'>=%1',DMY2DATE(1,DATE2DMY(PerInici,2),DATE2DMY(PerInici,3)));
        Incidencias.SETFILTER("To Date",'<=%1',PerFinal);
        //Incidencias.SETRANGE(Closed,TRUE);
        IF Incidencias.FINDSET(TRUE,FALSE) THEN
           REPEAT
            CLEAR(MovNovedades);
            MovNovedades.VALIDATE("Tipo de accion",Empleado."No.");
        //    MovNovedades."Empresa cotizacion" := Empleado.Company;
            MovNovedades."ID Documento" := FORMAT(CabNomina.Periodo,0,'<Month,2><Year4>');
            CA.GET(Incidencias."Cause of Absence Code");
            MovNovedades."Editar salario" := CA."Dias laborables";
            MovNovedades.VALIDATE("Editar cargo" ,Incidencias."From Date");
            MovNovedades.VALIDATE("Transferir entre empresas",Incidencias."To Date");
        //    MovNovedades."Salario SS"
        //    MovNovedades."Salario ISR"
        
            IF MovNovedades.INSERT THEN;
        
            IF NOT Incidencias.Closed THEN
               BEGIN
                Incidencias.Closed := TRUE;
                Incidencias.MODIFY;
               END;
           UNTIL Incidencias.NEXT = 0;
        */

    end;
}

