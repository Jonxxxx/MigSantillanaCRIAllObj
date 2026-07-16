codeunit 34002119 "Registrar nomina RD -2"
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
        TiposNom: Record 34002158;
        TN: Record 34002158;
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
        recTmpDimEntry: Record 480 temporary;
        Puestos: Record 34002110;
        TipoNomina: Record 34002158;
        cduDim: Codeunit 408;
        FuncionesNom: Codeunit 34002104;
        Generar: Boolean;
        "Periodo": Integer;
        PerInici: Date;
        PerFinal: Date;
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
        Err002: Label 'Starting Date must be day %1 or %2';
        DimSetID: Integer;
        AFPMes: Decimal;
        SFSMes: Decimal;
        Importecotizacionmes: Decimal;
        Err003: Label 'Total revenue can not be less than total discounts. Please review employee %1';
        Err004: Label 'The difference between Income and Discount exceeds the %1 allowed. Please check employee %2';
        TSSSueldo: Decimal;
        TSSOtros: Decimal;
        Salario: Decimal;
        Anos: Integer;
        Meses: Integer;
        Dias: Integer;
        PromedioSalarioAnual: Decimal;
        PromedioSalarioMensual: Decimal;
        PromedioSalarioDiario: Decimal;
        MontoCesantia: Decimal;
        MontoPreaviso: Decimal;
        MontoRestante: Decimal;
        AnoTrabajo: Integer;
        MesTrabajo: Integer;
        diaTrabajo: Integer;
        Err005: Label 'Starting and ending date must be equal for daily payrolls';
        CDateSymbol: Label 'Y';
        DiasCesantia: Integer;
        DiasPreaviso: Integer;
        DiasSalario: Decimal;
        Text001: Label 'Payment %1 days of retroactive salary';
        Text002: Label '%1 calculated: %2 minus %3 balance on favor';
        ISRCompensado: Decimal;
        Text003: Label 'Minus disc. of ';
        Text004: Label '%1 days previous salary, total %2, plus %3 days of new salary, total %4';
        Text005: Label 'Minus %1 working days, reason %2';
        FechaIniDT: DateTime;
        FechaFinDT: DateTime;

    procedure CODIGO()
    var
        HayNominaObra: Boolean;
    begin
        ConfNominas.GET();
        RegEmpCotiz.FINDFIRST;
        GlobalRec.TESTFIELD("Empresa cotizacion", RegEmpCotiz."Empresa cotizacion");


        TiposNom.GET(GlobalRec."Tipo de nomina");

        GlobalRec.TESTFIELD("Tipo de nomina");
        //IF TiposNom."Validar contrato" THEN
        BEGIN
            Contrato.RESET;
            Contrato.SETRANGE("No. empleado", GlobalRec."No. empleado");
            IF TiposNom."Tipo de nomina" <> TiposNom."Tipo de nomina"::Prestaciones THEN
                Contrato.SETRANGE(Activo, TRUE);
            Contrato.FINDFIRST;
        END;

        IF TiposNom."Cotiza AFP" THEN
            ConfNominas.TESTFIELD("Concepto AFP");

        IF TiposNom."Cotiza ISR" THEN
            ConfNominas.TESTFIELD("Concepto ISR");

        IF TiposNom."Cotiza SFS" THEN
            ConfNominas.TESTFIELD("Concepto SFS");

        PrimeraQ := FALSE;
        SegundaQ := FALSE;
        ImporteCotizacion := 0;
        ImporteTotal := 0;
        "%Cot" := 0;
        ImporteBaseImp := 0;

        WITH GlobalRec DO BEGIN
            Empleado.GET("No. empleado");
            IF (Empleado."Mes Nacimiento" = 0) AND
               (Empleado."Birth Date" <> 0D) THEN BEGIN
                Empleado.VALIDATE("Birth Date");
                Empleado.MODIFY;
            END;

            Empleado.CALCFIELDS(Salario);

            //  empleado.TESTFIELD("Global Dimension 1 Code");
            //  empleado.TESTFIELD("Global Dimension 2 Code");

            PerInici := GlobalRec."Inicio Periodo";
            PerFinal := GlobalRec."Fin Periodo";
            dia := DATE2DMY(PerInici, 1);

            IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) AND (TiposNom."Frecuencia de pago" = TiposNom."Frecuencia de pago"::Quincenal) THEN
                IF (dia <> TiposNom."Dia inicio 1ra") AND (dia <> TiposNom."Dia inicio 2da") AND (TiposNom."Tipo de nomina" <> TiposNom."Tipo de nomina"::Prestaciones) THEN
                    ERROR(STRSUBSTNO(Err002, TiposNom."Dia inicio 1ra", TiposNom."Dia inicio 2da"));
            Mes := DATE2DMY(PerInici, 2);
            Ano := DATE2DMY(PerInici, 3);
            //ERROR('%1 %2',PerInici,PerFinal);


            //Para los empleados en proyectos
            IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::"Bi-Semanal") AND
               (TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Regular) THEN BEGIN
                //HayNominaObra := CalculaNominaProy(GlobalRec."No. empleado",GlobalRec."Job No.",PerInici,PerFinal);
                IF NOT HayNominaObra THEN
                    EXIT;
            END;

            CalculaDiasVacaciones;
            CrearCabecera;
            // --------------------

            PerfilSal.RESET;
            PerfilSal.SETRANGE("No. empleado", GlobalRec."No. empleado");
            PerfilSal.SETRANGE("Perfil salarial", GlobalRec."Perfil salarial");
            PerfilSal.SETFILTER(Cantidad, '<>0');
            PerfilSal.SETRANGE("Tipo concepto", PerfilSal."Tipo concepto"::Ingresos);

            IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal THEN
                IF TiposNom."Dia inicio 1ra" = dia THEN BEGIN
                    IF TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Regular THEN
                        PerfilSal.SETRANGE("1ra Quincena", TRUE);

                    PrimeraQ := TRUE;
                END
                ELSE BEGIN
                    IF TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Regular THEN
                        PerfilSal.SETRANGE("2da Quincena", TRUE);

                    SegundaQ := TRUE;
                END;

            IF PerfilSal.FINDSET(FALSE, FALSE) THEN
                REPEAT
                    //Para las prestaciones
                    IF TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Prestaciones THEN BEGIN
                        //CalcularIngresos;
                        IF TiposNom."Frecuencia de pago" = TiposNom."Frecuencia de pago"::Diaria THEN
                            IF PerInici <> PerFinal THEN
                                ERROR(Err005);
                        Contrato.RESET;
                        Contrato.SETRANGE("No. empleado", Empleado."No.");
                        Contrato.SETRANGE(Finalizado, TRUE);
                        Contrato.SETRANGE("Fecha finalizacion", PerInici, PerFinal);
                        IF Contrato.FINDLAST THEN BEGIN
                            CalculoPrestaciones;
                            CalcularDescuentosPrest;
                            IF NOT ConfNominas."Impuestos manuales" THEN BEGIN
                                /*
                                 TiposNom.RESET;
                                 TiposNom.SETRANGE("Tipo de nomina",TiposNom."Tipo de nomina"::Regular);
                                 TiposNom.SETRANGE("Frecuencia de pago",Contrato."Frecuencia de pago");
                                 TiposNom.FINDFIRST;
                                 */
                                CalcularISR;
                            END;
                            EliminaCabecera;
                        END;
                        EXIT;
                    END;

                    //Para la bonificacion
                    IF TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Bonificacion THEN BEGIN
                        CalculoBonificacion;
                        CalcularDtosLegales;
                        IF NOT ConfNominas."Impuestos manuales" THEN
                            CalcularISR;
                        EliminaCabecera;
                        EXIT;
                    END;

                    //Para la Regalia
                    IF TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Regalia THEN BEGIN
                        CalculoRegalia;
                        EXIT;
                    END;

                    //Para la Propina y otros
                    IF TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Extra THEN BEGIN
                        CalculoOtras;
                        CalcularDtosLegales;
                        IF NOT ConfNominas."Impuestos manuales" THEN
                            CalcularISR;
                        EliminaCabecera;
                        EXIT;
                    END;

                    CalcularIngresos;
                    VerificaRetroactivo;
                UNTIL PerfilSal.NEXT = 0;

            PerfilSal.SETRANGE("Tipo concepto", PerfilSal."Tipo concepto"::Deducciones);
            IF PerfilSal.FINDSET(FALSE, FALSE) THEN
                REPEAT
                    //Para la bonificacion
                    IF (TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Bonificacion) THEN BEGIN
                        CalculoBonificacion;
                        EXIT;
                    END;

                    //Para la Regalia
                    IF (TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Regalia) THEN BEGIN
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


            //Verifico que no se descuente mas de lo que se le paga.

            CabNomina.SETRANGE(Periodo, PerInici, PerFinal);
            /*
              MESSAGE('%1',CabNomina.GETFILTERS);
              CabNomina.CALCFIELDS("Total Ingresos","Total deducciones");
              //MESSAGE('%1 %2',CabNomina."Total Ingresos",CabNomina."Total deducciones");
              IF (CabNomina."Total deducciones" <> 0) AND (CabNomina."Total Ingresos" <> 0) THEN
                 BEGIN
                  IF ABS(CabNomina."Total deducciones") > CabNomina."Total Ingresos" THEN
                     ERROR(STRSUBSTNO(Err003,CabNomina.Nombre));
                END;
            */
            //Verifico que el descuento no sobrepase lo permitido en la configuracion.
            IF ConfNominas."% dif. Ingresos y descuentos" <> 0 THEN BEGIN
                IF (CabNomina."Total deducciones" <> 0) AND (CabNomina."Total Ingresos" <> 0) THEN BEGIN
                    IF ABS(CabNomina."Total deducciones") / CabNomina."Total Ingresos" * 100 > ConfNominas."% dif. Ingresos y descuentos" THEN
                        ERROR(STRSUBSTNO(Err004, ConfNominas.FIELDCAPTION("% dif. Ingresos y descuentos"), CabNomina.Nombre));
                END;
            END;

            IF Empleado."Fin contrato" <> 0D THEN BEGIN
                //   IF Contrato."Fecha finalizacion" = 0D THEN
                BEGIN
                    Empleado."Calcular Nomina" := FALSE;
                    Empleado."Fin contrato" := Empleado."Fin contrato";
                    Empleado.Status := Empleado.Status::Terminated;
                    Empleado.MODIFY;

                    Contrato."Fecha finalizacion" := Empleado."Fin contrato";
                    Contrato.Finalizado := TRUE;
                    Contrato.MODIFY;
                END;
            END;
        END;

        RegistraIncidencias;

        EliminaCabecera;

    end;

    procedure CrearCabecera()
    var
        CompanyTaxes: Record 34002121;
        GestNoSer: Codeunit "No. Series";
        DPE: Record 34002108;
        HCN: Record 34002117;
    begin
        HCN.RESET;
        HCN.SETRANGE("Tipo de nomina", GlobalRec."Tipo de nomina");
        HCN.SETRANGE(Periodo, PerInici, PerFinal);
        HCN.SETRANGE("Frecuencia de pago", TiposNom."Frecuencia de pago");
        IF HCN.FINDFIRST THEN
            CabNomina."No. Documento" := HCN."No. Documento";

        IF CabNomina."No. Documento" = '' THEN BEGIN
            ConfNominas.TESTFIELD("No. serie nominas");
            //TODO: Ver GestNoSer.InitSeries(ConfNominas."No. serie nominas", ConfNominas."No. serie nominas", 0D, CabNomina."No. Documento",
            //TODO: Ver                      ConfNominas."No. serie nominas");
        END;
        //Para buscar los datos del banco
        CLEAR(DPE);
        DPE.SETRANGE("No. empleado", GlobalRec."No. empleado");
        IF DPE.FINDFIRST THEN;

        //Para buscar la semana cuando sea Bi-semanal o semanal
        IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Semanal) AND
          (TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Regular) THEN BEGIN
            Fecha.RESET;
            Fecha.SETRANGE("Period Start", PerInici);
            Fecha.SETRANGE("Period Type", Fecha."Period Type"::Week);
            Fecha.FINDFIRST;
        END
        ELSE
            IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::"Bi-Semanal") AND
                 (TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Regular) THEN BEGIN
            END;

        //Create Payroll Header
        CabNomina."No. empleado" := GlobalRec."No. empleado";
        CabNomina.Ano := Ano;
        CabNomina.Periodo := GlobalRec."Inicio Periodo";
        CabNomina."Tipo Nomina" := GlobalRec."Tipo Nomina";
        CabNomina."Tipo de nomina" := GlobalRec."Tipo de nomina";
        CabNomina."Empresa cotizacion" := Empleado.Company;
        CabNomina."Centro trabajo" := Empleado."Working Center";
        CabNomina.Inicio := PerInici;
        CabNomina.Fin := PerFinal;
        CabNomina."Fecha Entrada" := Empleado."Employment Date";
        CabNomina."Fecha Salida" := Empleado."Fin contrato";
        CabNomina.Nombre := Empleado."Full Name";
        CabNomina.Cargo := Empleado."Job Type Code";
        CabNomina."Tipo Empleado" := Empleado."Tipo Empleado";
        CabNomina.Banco := DPE."Cod. Banco";
        CabNomina."Tipo Cuenta" := DPE."Tipo Cuenta";
        CabNomina."Frecuencia de pago" := Contrato."Frecuencia de pago";
        CabNomina.Cuenta := DPE."Numero Cuenta";
        //CabNomina.Semana                     := Fecha."Period No.";
        CabNomina."Forma de Cobro" := Empleado."Forma de Cobro";
        CabNomina.VALIDATE("Shortcut Dimension 1 Code", Empleado."Global Dimension 1 Code");
        CabNomina.VALIDATE("Shortcut Dimension 2 Code", Empleado."Global Dimension 2 Code");
        CabNomina.Departamento := Empleado.Departamento;
        CabNomina."Sub-Departamento" := Empleado."Sub-Departamento";
        //CabNomina."Job No."                  := GlobalRec."Job No.";
        CLEAR(recTmpDimEntry);
        InsertarDimTempDef(5200);
        CabNomina."Dimension Set ID" := cduDim.GetDimensionSetID(recTmpDimEntry);
        CabNomina.INSERT;

        CabNomina.GET(Ano, Empleado."No.", GlobalRec."Inicio Periodo", GlobalRec."Job No.", GlobalRec."Tipo de nomina");

        /*//GRN 06/04/10
        IF Empleado."fin contrato" <> 0D THEN
           IF Contrato."Fecha finalizacion" = 0D THEN
              BEGIN
               Empleado."Calcular Nomina"    := FALSE;
               Empleado."Fin contrato"       := Empleado."fin contrato";
               Empleado.MODIFY;
        
               Contrato."Fecha finalizacion" := Empleado."fin contrato";
               Contrato.Finalizado           := TRUE;
               Contrato.MODIFY;
              END;
        */

        //Create Company's Taxes Header
        CompanyTaxes."No. Documento" := CabNomina."No. Documento";
        CompanyTaxes."Unidad cotizacion" := CabNomina."Empresa cotizacion";
        CompanyTaxes."Tipo Nomina" := CabNomina."Tipo Nomina";
        CompanyTaxes."Tipo de nomina" := CabNomina."Tipo de nomina";
        CompanyTaxes.Periodo := CabNomina.Periodo;
        CompanyTaxes."Dimension Set ID" := cduDim.GetDimensionSetID(recTmpDimEntry);
        //CompanyTaxes."Frecuencia de pago" := Contrato."Frecuencia de pago";
        //CompanyTaxes."Job No."            := GlobalRec."Job No.";
        DimSetID := CompanyTaxes."Dimension Set ID";
        IF CompanyTaxes.INSERT THEN;


        //Verifico los conceptos con cantidades y sin importes y limpio el valor de cantidad
        PerfilSal.RESET;
        PerfilSal.SETRANGE("No. empleado", GlobalRec."No. empleado");
        PerfilSal.SETRANGE("Perfil salarial", GlobalRec."Perfil salarial");
        PerfilSal.SETFILTER(Cantidad, '<>0');
        PerfilSal.SETRANGE(Importe, 0);
        IF PerfilSal.FINDSET(TRUE, FALSE) THEN
            REPEAT
                PerfilSal.Cantidad := 0;
                PerfilSal.MODIFY;
            UNTIL PerfilSal.NEXT = 0;

    end;

    procedure CalcularIngresos()
    var
        LinNominasES: Record 34002118;
        Incidencias: Record 5207;
        Incidencias2: Record 5207;
        ParamCalcDias: Record 34002107;
        EsqSal: Record 34002115;
        HistAccionesdepersonal: Record 34002159;
        Tiposdeaccionespersonal: Record 34002114;
        ImporteIncid: Decimal;
        DiasIncid: Decimal;
        DiasPago: Decimal;
        CantidadDiasEnt: Decimal;
        CantidadDiasSal: Decimal;
        DiasAusencia: Decimal;
        DiasCal: Decimal;
        DifDias: Decimal;
        DifDias2: Decimal;
        DifSueldo: Decimal;
        NvoSueldo: Decimal;
        SueldoAnt: Decimal;
    begin
        CantidadDiasEnt := 0;
        CantidadDiasSal := 0;
        DiasPago := 0;
        DiasIncid := 0;
        DiasCal := 0;
        IngresoSalario := 0;
        ConfNominas.TESTFIELD("Dias para corte nominas");

        IF Empleado."Employment Date" > CALCDATE('-' + FORMAT(ConfNominas."Dias para corte nominas"), PerFinal) THEN
            EXIT;

        EsqSal.RESET;
        EsqSal.SETRANGE("No. empleado", GlobalRec."No. empleado");
        EsqSal.SETRANGE("Salario Base", TRUE);
        EsqSal.SETFILTER(Cantidad, '<>%1', 0);
        EsqSal.SETFILTER(Importe, '<>%1', 0);
        EsqSal.FINDSET;
        REPEAT
            IngresoSalario += EsqSal.Importe;
        UNTIL EsqSal.NEXT = 0;

        Empleado.TESTFIELD("Job Type Code");
        Puestos.GET(Empleado.Departamento, Empleado."Job Type Code");
        PerfilSal.TESTFIELD("Tipo de nomina");
        IF (PerfilSal."Tipo concepto" = PerfilSal."Tipo concepto"::Ingresos) AND
           (PerfilSal."Tipo de nomina" = GlobalRec."Tipo de nomina") THEN BEGIN
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

            IF (PerfilSal."Salario Base") AND (ConfNominas."Concepto Sal. Base" = PerfilSal."Concepto salarial") THEN BEGIN
                //Para pagar las proporciones de salarios fraccionados
                DifDias := 0;
                DifDias2 := 0;
                DifSueldo := 0;
                NvoSueldo := 0;
                SueldoAnt := 0;

                HistAccionesdepersonal.RESET;
                HistAccionesdepersonal.SETRANGE("No. empleado", GlobalRec."No. empleado");
                HistAccionesdepersonal.SETRANGE("Fecha efectividad", PerInici, PerFinal);
                HistAccionesdepersonal.SETRANGE("Tipo de accion", HistAccionesdepersonal."Tipo de accion"::Cambio);
                IF HistAccionesdepersonal.FINDSET THEN
                    REPEAT
                        Tiposdeaccionespersonal.GET(HistAccionesdepersonal."Tipo de accion", HistAccionesdepersonal."Cod. accion");

                        IF (HistAccionesdepersonal."Sueldo actual" <> 0) AND (HistAccionesdepersonal."Sueldo Nuevo" <> 0) AND
                           (HistAccionesdepersonal."Sueldo actual" < HistAccionesdepersonal."Sueldo Nuevo") AND (HistAccionesdepersonal."Fecha efectividad" <> PerInici) THEN BEGIN
                            DifDias := HistAccionesdepersonal."Fecha efectividad" - PerInici + 1;
                            /*                IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::"Bi-Semanal") OR
                                               (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) THEN
                                               DifSueldo := HistAccionesdepersonal."Sueldo actual" / 23.83
                                            ELSE
                            */
                            DifSueldo := HistAccionesdepersonal."Sueldo actual" / 23.83;

                            DifDias2 := PerFinal - HistAccionesdepersonal."Fecha efectividad";
                            SueldoAnt := ROUND(DifSueldo * DifDias, 0.01);
                            NvoSueldo := ROUND(PerfilSal.Importe / 23.83 * DifDias2, 0.01);
                            DifSueldo := ROUND(((PerfilSal.Importe / 23.83) - DifSueldo) * DifDias, 0.01);
                            PerfilSal.Comentario := STRSUBSTNO(Text004, DifDias, SueldoAnt, DifDias2, NvoSueldo);
                        END
                        ELSE
                            IF Tiposdeaccionespersonal.Suspension THEN BEGIN
                                DifDias := HistAccionesdepersonal."Fecha efectividad" - PerInici + 1;
                                /*                IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::"Bi-Semanal") OR
                                                   (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) THEN
                                                   DifSueldo := HistAccionesdepersonal."Sueldo actual" / 23.83
                                                ELSE
                                */
                                DifSueldo := HistAccionesdepersonal."Sueldo actual" / 23.83;

                                DifSueldo := ROUND(PerfilSal.Importe / 23.83 * DifDias, 0.01);
                                PerfilSal.Comentario := STRSUBSTNO(Text005, DifDias, HistAccionesdepersonal."Cod. accion");

                            END;
                    UNTIL HistAccionesdepersonal.NEXT = 0;

                IF PerfilSal."Currency Code" <> '' THEN BEGIN
                    IF ConfNominas."Tasa Cambio Calculo Divisa" <> 0 THEN BEGIN
                        //IngresoSalario += PerfilSal.Importe * ConfNominas."Tasa Cambio Calculo Divisa";
                        IngresoSalario := IngresoSalario * ConfNominas."Tasa Cambio Calculo Divisa";
                        ImporteTotal := IngresoSalario;
                        ImporteBaseImp := ImporteTotal;
                    END
                    ELSE BEGIN
                        CurrExchange.SETRANGE("Currency Code", PerfilSal."Currency Code");
                        CurrExchange.SETRANGE("Starting Date", 0D, PerFinal);
                        CurrExchange.FINDLAST;
                        //IngresoSalario := PerfilSal.Importe * CurrExchange."Relational Exch. Rate Amount";
                        ImporteTotal := IngresoSalario;
                        ImporteBaseImp := ImporteTotal;
                    END;

                    IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) AND
                       (PerfilSal."1ra Quincena") AND (PerfilSal."2da Quincena") THEN

                        //GRN            IF Contrato."Tipo Pago Nomina" = Contrato."Tipo Pago Nomina"::Quincenal THEN
                        ImporteTotal /= 2;
                    ImporteTotal -= DifSueldo;
                END
                ELSE BEGIN
                    //IngresoSalario := PerfilSal.Importe;
                    IF ConfNominas."Concepto Sal. Base" = PerfilSal."Concepto salarial" THEN BEGIN
                        ImporteTotal := PerfilSal.Importe;
                        IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) AND
                           (PerfilSal."1ra Quincena") AND (PerfilSal."2da Quincena") THEN BEGIN
                            ImporteTotal /= 2;
                            ImporteTotal -= DifSueldo;
                        END;
                    END
                    ELSE BEGIN
                        ImporteTotal := PerfilSal.Cantidad * PerfilSal.Importe;
                        ImporteTotal -= DifSueldo;
                    END;
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

                        ConfNominas.TESTFIELD("Metodo calculo Ingresos");
                        ParamCalcDias.GET(ConfNominas."Metodo calculo Ingresos");
                        IF ParamCalcDias.Valor <> 30 THEN BEGIN
                            Fecha.RESET;
                            Fecha.SETRANGE("Period Type", 0); //Dia
                            Fecha.SETRANGE("Period Start", Empleado."Employment Date", PerFinal);
                            Fecha.SETRANGE("Period No.", 6, 7);//Sabado y Domingo
                            IF Fecha.FINDSET THEN
                                REPEAT
                                    CASE Fecha."Period No." OF
                                        6:
                                            CantidadDiasEnt -= 0.5;
                                        7:
                                            CantidadDiasEnt -= 1;
                                    END;
                                UNTIL Fecha.NEXT = 0;
                        END;
                        DiasPago := CantidadDiasEnt;
                        ImporteBaseImp := ImporteTotal;
                    END;
                END
                ELSE
                    IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Mensual THEN BEGIN
                        CantidadDiasEnt := 30;
                        IF Empleado."Employment Date" > PerInici THEN BEGIN
                            CantidadDiasEnt := PerFinal - Empleado."Employment Date" + 1;

                            CantidadDiasEnt := CantidadDiasEnt - DiasAusencia;

                            IF CantidadDiasEnt <= 0 THEN
                                ERROR(Err001, CantidadDiasEnt, Empleado."No.");

                            IF Puestos."Método cálculo Ingresos" = '' THEN
                                CalcDias.GET(ConfNominas."Metodo calculo Ingresos")
                            ELSE
                                CalcDias.GET(Puestos."Método cálculo Ingresos");

                            IF CalcDias.Valor <> 30 THEN BEGIN
                                Fecha.RESET;
                                Fecha.SETRANGE("Period Type", 0); //Dia
                                Fecha.SETRANGE("Period Start", Empleado."Employment Date", PerFinal);
                                Fecha.SETRANGE("Period No.", 6, 7);//Sabado y Domingo
                                IF Fecha.FINDSET THEN
                                    REPEAT
                                        CASE Fecha."Period No." OF
                                            6:
                                                CantidadDiasEnt -= 0.5;
                                            7:
                                                CantidadDiasEnt -= 1;
                                        END;
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
                        DiasIncid += Incidencias.Quantity * Incidencias."% To deduct" / 100;
                        Incidencias2.COPY(Incidencias);
                        Incidencias2.Closed := TRUE;
                        Incidencias2.MODIFY;
                        Incidencias.TESTFIELD(Description);
                        PerfilSal.Comentario := Text003 + Incidencias.Description;
                    UNTIL Incidencias.NEXT = 0;

                    IF DiasIncid <= 0 THEN
                        DiasIncid := 1;
                    CalcDias.GET(ConfNominas."Método cálculo ausencias");
                    ImporteIncid := IngresoSalario / CalcDias.Valor * DiasIncid;
                    ImporteTotal := ImporteTotal - ImporteIncid;
                END;

                IF Empleado."Fin contrato" <> 0D THEN
                    IF (Empleado."Fin contrato" >= PerInici) AND (Empleado."Fin contrato" <= PerFinal) THEN BEGIN
                        CantidadDiasSal := Empleado."Fin contrato" - PerInici + 1;
                        CantidadDiasEnt := CantidadDiasEnt - CantidadDiasSal + 1;

                        IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal THEN
                            IF CantidadDiasSal > 15 THEN
                                CantidadDiasSal := 0;

                        //Para no incluir en el calculo los dias con incidencias
                        ConfNominas.TESTFIELD("Metodo calculo Ingresos");
                        ParamCalcDias.GET(ConfNominas."Metodo calculo Ingresos");
                        IF ParamCalcDias.Valor <> 30 THEN BEGIN
                            Fecha.RESET;
                            Incidencias.RESET;
                            Incidencias.SETRANGE("Employee No.", Empleado."No.");
                            Incidencias.SETFILTER("% To deduct", '<>%1', 0);
                            Incidencias.SETRANGE(Closed, FALSE);
                            IF Incidencias.FINDSET THEN
                                Fecha.SETRANGE("Period Start", Incidencias."To Date", PerFinal)
                            ELSE
                                IF Empleado."Employment Date" >= PerInici THEN
                                    Fecha.SETRANGE("Period Start", Empleado."Employment Date", PerFinal)
                                ELSE
                                    IF Empleado."Fin contrato" <= PerFinal THEN
                                        Fecha.SETRANGE("Period Start", PerInici, Empleado."Fin contrato")
                                    ELSE
                                        Fecha.SETRANGE("Period Start", PerInici, PerFinal);
                            Fecha.SETRANGE("Period Type", Fecha."Period Type"::Date);
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
                        END;
                        //error('bb %1 %2 %3 %4',cantidaddiassal,diaspago,DiasIncid,calendar.COUNT,fecha.GETFILTERS);
                        IF Puestos."Incluye Dias Feriados" THEN BEGIN
                            Calendar.RESET;
                            IF Incidencias."To Date" <> 0D THEN
                                Calendar.SETRANGE(Fecha, Incidencias."To Date", PerFinal)
                            ELSE
                                Calendar.SETRANGE(Fecha, PerInici, PerFinal);
                            IF Calendar.FINDSET THEN
                                REPEAT
                                    IF Calendar.Fecha > Incidencias."To Date" THEN
                                        IF Empleado."Fin contrato" <> 0D THEN BEGIN
                                            IF (Empleado."Fin contrato" >= PerInici) AND
                                               (Empleado."Fin contrato" >= Calendar.Fecha) THEN
                                                DiasCal += 1;
                                        END
                                        ELSE
                                            DiasCal += 1;
                                UNTIL Calendar.NEXT = 0;
                        END;

                        DiasPago := CantidadDiasSal - DiasPago - DiasIncid - DiasCal;
                        //error('%1 %2 %3 %4',cantidaddiassal,diaspago,DiasIncid,diascal);
                    END;

                IF (Empleado."Fin contrato" = PerFinal) AND ((Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) OR
                   (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::"Bi-Semanal")) THEN
                    IF NOT Incidencias.FINDFIRST THEN
                        DiasPago := 0;

                //MESSAGE('%1 %2 %3 %4',Empleado."Fin contrato", PerFinal,DiasCal);
                IF DiasPago <> 0 THEN BEGIN
                    IF Empleado."Employment Date" >= PerInici THEN BEGIN
                        IF Puestos."Método cálculo Ingresos" = '' THEN
                            CalcDias.GET(ConfNominas."Metodo calculo Ingresos")
                        ELSE
                            CalcDias.GET(Puestos."Método cálculo Ingresos");
                        //                message('%1 %2 %3 %4',ingresosalario, calcdias.valor, diaspago);
                        ImporteTotal := IngresoSalario / CalcDias.Valor * DiasPago;
                        ImporteBaseImp := ImporteTotal;
                    END;

                    IF (Empleado."Fin contrato" >= PerInici) AND (Empleado."Fin contrato" <= PerFinal) THEN BEGIN
                        CalcDias.GET(ConfNominas."Metodo calculo Salidas");
                        //                error('%1 %2 %3',CalcDias.Valor, IngresoSalario, DiasPago);
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
        PerfilSal.TESTFIELD("Tipo de nomina");
        IF (PerfilSal."Tipo concepto" = PerfilSal."Tipo concepto"::Deducciones) AND (PerfilSal.Cantidad <> 0) AND
           (PerfilSal.Importe <> 0) AND (NOT PerfilSal."Sujeto Cotizacion") AND (PerfilSal."Tipo de nomina" = GlobalRec."Tipo de nomina") THEN BEGIN
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
        LinNominasES2: Record 34002118;
        DeduccGob: Record 34002129;
        CabAportesEmpresa: Record 34002121;
        LinAportesEmpresa: Record 34002122;
        LinAportesEmpresa2: Record 34002122;
        PerfilSalTr: Record 34002115;
        HistCabNom: Record 34002117;
        NoLin: Integer;
        MontoAplicar: Decimal;
        IndSkip: Boolean;
        ImporteCotizacion2: Decimal;
        ImporteImpuestos: Decimal;
        ImporteImpuestosemp: Decimal;
        ImporteCotizacionEmp: Decimal;
        MontoMaximoImpEmpl: Decimal;
        MontoMaximoImpEmpr: Decimal;
    begin
        DeduccGob.RESET;
        DeduccGob.SETRANGE(Ano, Ano);
        DeduccGob.FINDSET(FALSE, FALSE);
        REPEAT
            IndSkip := FALSE;
            IF Empleado."Excluido Cotizacion TSS" THEN BEGIN
                IF (DeduccGob.Codigo = ConfNominas."Concepto AFP") OR (DeduccGob.Codigo = ConfNominas."Concepto SFS") OR
                   (DeduccGob.Codigo = ConfNominas."Concepto SRL") THEN
                    IndSkip := TRUE;
            END;

            IF (DeduccGob.Codigo = ConfNominas."Concepto SFS") AND (NOT TiposNom."Cotiza SFS") THEN
                IndSkip := TRUE
            ELSE
                IF (DeduccGob.Codigo = ConfNominas."Concepto AFP") AND (NOT TiposNom."Cotiza AFP") THEN
                    IndSkip := TRUE;

            ImporteCotizacion := 0;
            ImporteCotizacionEmp := 0;
            Importecotizacionmes := 0;
            MontoMaximoImpEmpl := 0;
            MontoMaximoImpEmpr := 0;

            IF DeduccGob."Tope Salarial/Acumulado Anual" <> 0 THEN BEGIN
                IF DeduccGob."Porciento Empleado" <> 0 THEN
                    MontoMaximoImpEmpl := ROUND(DeduccGob."Tope Salarial/Acumulado Anual" * DeduccGob."Porciento Empleado" / 100, 0.01);
                IF DeduccGob."Porciento Empresa" <> 0 THEN
                    MontoMaximoImpEmpr := ROUND(DeduccGob."Tope Salarial/Acumulado Anual" * DeduccGob."Porciento Empresa" / 100, 0.01);
            END;

            PerfilSalTr.RESET;
            PerfilSalTr.SETRANGE("No. empleado", GlobalRec."No. empleado");
            PerfilSalTr.SETRANGE("Concepto salarial", DeduccGob.Codigo);
            PerfilSalTr.FINDFIRST;

            LinNominasES.RESET;
            LinNominasES.SETRANGE("No. empleado", GlobalRec."No. empleado");
            IF NOT SegundaQ THEN
                LinNominasES.SETRANGE("Tipo de nomina", GlobalRec."Tipo de nomina");

            //Para consultar luego las nominas del periodo
            IF SegundaQ THEN BEGIN
                HistCabNom.RESET;
                HistCabNom.SETRANGE("No. empleado", GlobalRec."No. empleado");
                IF (TiposNom."Dia inicio 1ra" > TiposNom."Dia inicio 2da") AND (TiposNom."Dia inicio 1ra" > 0) THEN
                    HistCabNom.SETRANGE(Periodo, DMY2DATE(TiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                ELSE
                    HistCabNom.SETRANGE(Periodo, DMY2DATE(1, DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)), PerFinal)
            END;

            IF (TiposNom."Frecuencia de pago" = TiposNom."Frecuencia de pago"::Mensual) AND ((TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Regalia) OR
               (TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Bonificacion)) THEN BEGIN
                LinNominasES.SETRANGE(Periodo, PerInici, PerFinal);
                IF ConfNominas."Concepto INFOTEP" = DeduccGob.Codigo THEN BEGIN
                    LinNominasES.SETRANGE("Cotiza Infotep", TRUE);
                    IF TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Bonificacion THEN BEGIN
                        DeduccGob."Porciento Empresa" /= 2;
                        DeduccGob."Porciento Empleado" := DeduccGob."Porciento Empresa";
                    END;
                END;

                IF LinNominasES.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                        IF SegundaQ THEN BEGIN
                            HistCabNom.RESET;
                            HistCabNom.SETRANGE("No. empleado", GlobalRec."No. empleado");
                            IF TiposNom."Dia inicio 1ra" <> 0 THEN
                                HistCabNom.SETRANGE(Periodo, DMY2DATE(TiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                            ELSE
                                HistCabNom.SETRANGE(Periodo, PerInici, PerFinal);

                            IF (NOT Empleado."Excluido Cotizacion TSS") AND ((LinNominasES."Cotiza SFS" OR LinNominasES."Cotiza AFP")) THEN BEGIN
                                ImporteCotizacion += LinNominasES.Total;
                                ImporteCotizacionEmp += LinNominasES.Total;
                            END
                            ELSE
                                IF (LinNominasES."Cotiza SRL" OR (LinNominasES."Cotiza Infotep")) THEN BEGIN
                                    ImporteCotizacion += LinNominasES.Total;
                                    ImporteCotizacionEmp += LinNominasES.Total;
                                END;
                        END;
                    UNTIL LinNominasES.NEXT = 0;
            END
            ELSE
                IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Mensual THEN BEGIN
                    IF TiposNom."Dia inicio 1ra" <> 1 THEN
                        LinNominasES.SETRANGE(Periodo, DMY2DATE(TiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                    ELSE
                        LinNominasES.SETRANGE(Periodo, PerInici, PerFinal);
                    IF ConfNominas."Concepto AFP" = DeduccGob.Codigo THEN
                        LinNominasES.SETRANGE("Cotiza AFP", TRUE)
                    ELSE
                        IF ConfNominas."Concepto INFOTEP" = DeduccGob.Codigo THEN BEGIN
                            LinNominasES.SETRANGE("Cotiza Infotep", TRUE);
                            IF TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Bonificacion THEN BEGIN
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

                    IF LinNominasES.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            IF (NOT Empleado."Excluido Cotizacion TSS") AND ((LinNominasES."Cotiza SFS" OR LinNominasES."Cotiza AFP")) THEN BEGIN
                                ImporteCotizacion += LinNominasES.Total;
                                ImporteCotizacionEmp += LinNominasES.Total;
                            END
                            ELSE
                                IF (LinNominasES."Cotiza SRL" OR (LinNominasES."Cotiza Infotep")) THEN BEGIN
                                    ImporteCotizacion += LinNominasES.Total;
                                    ImporteCotizacionEmp += LinNominasES.Total;
                                END;
                        UNTIL LinNominasES.NEXT = 0;
                END
                ELSE
                    IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal THEN BEGIN
                        //GRN Para verificar el acumulado del mes en la segunda Quinc. y no descontar mas del tope
                        //IF SegundaQ THEN
                        BEGIN
                            ImporteImpuestos := 0;

                            //BUSCO EL IMPORTE COBRADO DEL IMPUESTO
                            LinNominasES2.RESET;
                            LinNominasES2.SETRANGE("No. empleado", GlobalRec."No. empleado");
                            IF TiposNom."Dia inicio 1ra" > TiposNom."Dia inicio 2da" THEN
                                LinNominasES2.SETRANGE(Periodo, DMY2DATE(TiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                            ELSE
                                LinNominasES2.SETRANGE(Periodo, DMY2DATE(1, DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)), PerFinal);
                            LinNominasES2.SETRANGE("Concepto salarial", DeduccGob.Codigo);
                            IF LinNominasES2.FINDSET THEN
                                REPEAT
                                    ImporteImpuestos += LinNominasES2.Total;
                                UNTIL LinNominasES2.NEXT = 0;
                        END;

                        IF (PerfilSalTr."1ra Quincena") AND (NOT PerfilSalTr."2da Quincena") AND (PrimeraQ) THEN BEGIN
                            IF TiposNom."Dia inicio 1ra" > TiposNom."Dia inicio 2da" THEN
                                LinNominasES.SETRANGE(Periodo, DMY2DATE(TiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                            ELSE
                                LinNominasES.SETRANGE(Periodo, DMY2DATE(1, DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)), PerFinal);

                            IF ConfNominas."Concepto AFP" = DeduccGob.Codigo THEN
                                LinNominasES.SETRANGE("Cotiza AFP", TRUE)
                            ELSE
                                IF ConfNominas."Concepto INFOTEP" = DeduccGob.Codigo THEN BEGIN
                                    LinNominasES.SETRANGE("Cotiza Infotep", TRUE);
                                    IF TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Bonificacion THEN BEGIN
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

                            IF LinNominasES.FINDSET(FALSE, FALSE) THEN
                                REPEAT
                                    IF (NOT Empleado."Excluido Cotizacion TSS") AND ((LinNominasES."Cotiza SFS" OR LinNominasES."Cotiza AFP")) THEN BEGIN
                                        IF Empleado."Employment Date" >= PerInici THEN BEGIN
                                            ImporteCotizacion += LinNominasES.Total;
                                            ImporteCotizacionEmp += LinNominasES.Total;
                                        END
                                        ELSE BEGIN
                                            ImporteCotizacion += LinNominasES."Importe Base";
                                            ImporteCotizacionEmp += LinNominasES."Importe Base"; //Ojo, importe base
                                        END;
                                    END
                                    ELSE
                                        IF (LinNominasES."Cotiza SRL" OR (LinNominasES."Cotiza Infotep")) THEN BEGIN
                                            IF Empleado."Employment Date" >= PerInici THEN BEGIN
                                                ImporteCotizacion += LinNominasES.Total;
                                                ImporteCotizacionEmp += LinNominasES.Total;
                                            END
                                            ELSE BEGIN
                                                ImporteCotizacion += LinNominasES."Importe Base";
                                                ImporteCotizacionEmp += LinNominasES."Importe Base"; //Ojo, importe base
                                            END;
                                        END;
                                UNTIL LinNominasES.NEXT = 0;
                        END
                        ELSE
                            IF (NOT PerfilSalTr."1ra Quincena") AND (PerfilSalTr."2da Quincena") AND (SegundaQ) THEN BEGIN
                                IF TiposNom."Dia inicio 1ra" > TiposNom."Dia inicio 2da" THEN
                                    LinNominasES.SETRANGE(Periodo, DMY2DATE(TiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                                ELSE
                                    LinNominasES.SETRANGE(Periodo, DMY2DATE(1, DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)), PerFinal);

                                IF ConfNominas."Concepto AFP" = DeduccGob.Codigo THEN
                                    LinNominasES.SETRANGE("Cotiza AFP", TRUE)
                                ELSE
                                    IF ConfNominas."Concepto INFOTEP" = DeduccGob.Codigo THEN BEGIN
                                        LinNominasES.SETRANGE("Cotiza Infotep", TRUE);
                                        IF TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Bonificacion THEN BEGIN
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

                                IF LinNominasES.FINDSET(FALSE, FALSE) THEN
                                    REPEAT
                                        IF (NOT Empleado."Excluido Cotizacion TSS") AND ((LinNominasES."Cotiza SFS" OR LinNominasES."Cotiza AFP")) THEN BEGIN
                                            ImporteCotizacion += LinNominasES.Total;
                                            ImporteCotizacionEmp += LinNominasES.Total;
                                        END
                                        ELSE
                                            IF (LinNominasES."Cotiza SRL" OR (LinNominasES."Cotiza Infotep")) THEN BEGIN
                                                ImporteCotizacion += LinNominasES.Total;
                                                ImporteCotizacionEmp += LinNominasES.Total;
                                            END;
                                    UNTIL LinNominasES.NEXT = 0;
                            END
                            ELSE
                                IF (NOT PerfilSalTr."1ra Quincena") AND (PerfilSalTr."2da Quincena") AND (PrimeraQ) THEN BEGIN
                                    IF TiposNom."Dia inicio 1ra" > TiposNom."Dia inicio 2da" THEN
                                        LinNominasES.SETRANGE(Periodo, DMY2DATE(TiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                                    ELSE
                                        LinNominasES.SETRANGE(Periodo, PerInici, PerFinal);
                                    IF ConfNominas."Concepto AFP" = DeduccGob.Codigo THEN
                                        LinNominasES.SETRANGE("Cotiza AFP", TRUE)
                                    ELSE
                                        IF ConfNominas."Concepto INFOTEP" = DeduccGob.Codigo THEN BEGIN
                                            LinNominasES.SETRANGE("Cotiza Infotep", TRUE);
                                            IF TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Bonificacion THEN BEGIN
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

                                    IF LinNominasES.FINDSET(FALSE, FALSE) THEN
                                        REPEAT
                                            IF (NOT Empleado."Excluido Cotizacion TSS") AND ((LinNominasES."Cotiza SFS" OR LinNominasES."Cotiza AFP")) THEN BEGIN
                                                IF (Puestos."Método cálculo Paga Salario" = Puestos."Método cálculo Paga Salario"::Distribuido) AND
                                                    (ConfNominas."Concepto Sal. Base" = PerfilSal."Concepto salarial") THEN BEGIN
                                                    IF (LinNominasES."Importe Base" > DeduccGob."Tope Salarial/Acumulado Anual") AND
                                                        (DeduccGob."Tope Salarial/Acumulado Anual" <> 0) THEN BEGIN
                                                        ImporteCotizacion += DeduccGob."Tope Salarial/Acumulado Anual" / 2;
                                                        IF (LinNominasES."Concepto salarial" = ConfNominas."Concepto Sal. Base") THEN BEGIN
                                                            IF DeduccGob."Tope Salarial/Acumulado Anual" > LinNominasES."Importe Base" THEN
                                                                TSSSueldo += LinNominasES.Total
                                                            ELSE
                                                                TSSSueldo += DeduccGob."Tope Salarial/Acumulado Anual" / 2
                                                        END
                                                        ELSE
                                                            TSSOtros += LinNominasES.Total;
                                                    END
                                                    ELSE
                                                        IF Empleado."Employment Date" >= PerInici THEN BEGIN
                                                            ImporteCotizacion += LinNominasES.Total;
                                                            Importecotizacionmes += LinNominasES."Importe Base" / 2 + LinNominasES.Total; //IDC
                                                            IF LinNominasES."Salario Base" THEN BEGIN
                                                                IF DeduccGob."Tope Salarial/Acumulado Anual" > LinNominasES."Importe Base" THEN
                                                                    TSSSueldo += LinNominasES.Total
                                                                ELSE
                                                                    TSSSueldo += DeduccGob."Tope Salarial/Acumulado Anual" / 2
                                                            END
                                                            ELSE
                                                                TSSOtros += LinNominasES.Total;
                                                        END
                                                        ELSE
                                                            IF (DATE2DMY(Empleado."Employment Date", 2) = DATE2DMY(PerInici, 2)) AND (DATE2DMY(Empleado."Employment Date", 3) = DATE2DMY(PerInici, 3)) THEN BEGIN
                                                                ImporteCotizacion += LinNominasES.Total;
                                                                Importecotizacionmes += LinNominasES.Total; //IDC
                                                                IF LinNominasES."Salario Base" THEN BEGIN
                                                                    IF DeduccGob."Tope Salarial/Acumulado Anual" > LinNominasES."Importe Base" THEN
                                                                        TSSSueldo += LinNominasES.Total
                                                                    ELSE
                                                                        TSSSueldo += DeduccGob."Tope Salarial/Acumulado Anual" / 2
                                                                END
                                                                ELSE
                                                                    TSSOtros += LinNominasES.Total;
                                                            END
                                                            ELSE
                                                                IF (Empleado."Termination Date" <> 0D) THEN BEGIN
                                                                    IF (DATE2DMY(Empleado."Termination Date", 2) = DATE2DMY(PerInici, 2)) AND (DATE2DMY(Empleado."Termination Date", 3) = DATE2DMY(PerInici, 3)) THEN BEGIN
                                                                        ImporteCotizacion += LinNominasES.Total;
                                                                        Importecotizacionmes += LinNominasES.Total; //IDC
                                                                    END;
                                                                END;
                                                END;
                                            END;
                                        UNTIL LinNominasES.NEXT = 0;
                                END
                                ELSE
                                    IF PerfilSalTr."1ra Quincena" AND PerfilSalTr."2da Quincena" THEN BEGIN
                                        IF TiposNom."Dia inicio 1ra" > TiposNom."Dia inicio 2da" THEN
                                            LinNominasES.SETRANGE(Periodo, DMY2DATE(TiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                                        ELSE
                                            LinNominasES.SETRANGE(Periodo, PerInici, PerFinal);
                                        IF ConfNominas."Concepto AFP" = DeduccGob.Codigo THEN
                                            LinNominasES.SETRANGE("Cotiza AFP", TRUE)
                                        ELSE
                                            IF ConfNominas."Concepto INFOTEP" = DeduccGob.Codigo THEN BEGIN
                                                LinNominasES.SETRANGE("Cotiza Infotep", TRUE);
                                                IF TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Bonificacion THEN BEGIN
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

                                        IF LinNominasES.FINDSET(FALSE, FALSE) THEN
                                            REPEAT
                                                IF SegundaQ THEN BEGIN
                                                    IF (NOT Empleado."Excluido Cotizacion TSS") AND ((LinNominasES."Cotiza SFS" OR LinNominasES."Cotiza AFP")) THEN BEGIN
                                                        IF (Puestos."Método cálculo Paga Salario" = Puestos."Método cálculo Paga Salario"::Distribuido) AND
                                                           (ConfNominas."Concepto Sal. Base" = LinNominasES."Concepto salarial") AND (PrimeraQ) THEN BEGIN
                                                            IF (LinNominasES."Importe Base" > DeduccGob."Tope Salarial/Acumulado Anual") AND
                                                               (DeduccGob."Tope Salarial/Acumulado Anual" <> 0) THEN BEGIN
                                                                ImporteCotizacion += DeduccGob."Tope Salarial/Acumulado Anual" / 2;
                                                                IF (LinNominasES."Concepto salarial" = ConfNominas."Concepto Sal. Base") THEN BEGIN
                                                                    IF DeduccGob."Tope Salarial/Acumulado Anual" > LinNominasES."Importe Base" THEN
                                                                        TSSSueldo += LinNominasES.Total
                                                                    ELSE
                                                                        TSSSueldo += DeduccGob."Tope Salarial/Acumulado Anual" / 2
                                                                END
                                                                ELSE
                                                                    TSSOtros += LinNominasES.Total;
                                                            END
                                                            ELSE
                                                                IF Empleado."Employment Date" >= PerInici THEN BEGIN
                                                                    ImporteCotizacion += LinNominasES.Total;
                                                                    Importecotizacionmes += LinNominasES."Importe Base" / 2 + LinNominasES.Total; //IDC
                                                                    IF LinNominasES."Salario Base" THEN BEGIN
                                                                        IF DeduccGob."Tope Salarial/Acumulado Anual" > LinNominasES."Importe Base" THEN
                                                                            TSSSueldo += LinNominasES.Total
                                                                        ELSE
                                                                            TSSSueldo += DeduccGob."Tope Salarial/Acumulado Anual" / 2
                                                                    END
                                                                    ELSE
                                                                        TSSOtros += LinNominasES.Total;
                                                                END
                                                                ELSE
                                                                    IF (DATE2DMY(Empleado."Employment Date", 2) = DATE2DMY(PerInici, 2)) AND (DATE2DMY(Empleado."Employment Date", 3) = DATE2DMY(PerInici, 3)) AND
                                                                       (SegundaQ) THEN BEGIN
                                                                        ImporteCotizacion += LinNominasES.Total;
                                                                        Importecotizacionmes += LinNominasES.Total; //IDC
                                                                        IF LinNominasES."Salario Base" THEN BEGIN
                                                                            IF DeduccGob."Tope Salarial/Acumulado Anual" > LinNominasES."Importe Base" THEN
                                                                                TSSSueldo += LinNominasES.Total
                                                                            ELSE
                                                                                TSSSueldo += DeduccGob."Tope Salarial/Acumulado Anual" / 2
                                                                        END
                                                                        ELSE
                                                                            TSSOtros += LinNominasES.Total;
                                                                    END
                                                                    ELSE
                                                                        IF (Empleado."Termination Date" <> 0D) THEN BEGIN
                                                                            IF (DATE2DMY(Empleado."Termination Date", 2) = DATE2DMY(PerInici, 2)) AND (DATE2DMY(Empleado."Termination Date", 3) = DATE2DMY(PerInici, 3)) THEN BEGIN
                                                                                ImporteCotizacion += LinNominasES.Total;
                                                                                Importecotizacionmes += LinNominasES.Total; //IDC
                                                                            END;
                                                                        END
                                                                        ELSE
                                                                            IF SegundaQ THEN BEGIN
                                                                                ImporteCotizacion += LinNominasES.Total;
                                                                                // MESSAGE('%1',LinNominasES."Importe Base");
                                                                            END
                                                                            ELSE
                                                                                ImporteCotizacion += LinNominasES.Total;

                                                            ImporteCotizacionEmp := ImporteCotizacion;
                                                        END
                                                        ELSE BEGIN
                                                            ImporteCotizacion += LinNominasES.Total;
                                                            ImporteCotizacionEmp += LinNominasES.Total;
                                                        END;
                                                    END
                                                    ELSE
                                                        IF (LinNominasES."Cotiza SRL" OR (LinNominasES."Cotiza Infotep")) THEN BEGIN
                                                            IF (Puestos."Método cálculo Paga Salario" = Puestos."Método cálculo Paga Salario"::Distribuido) AND
                                                               (ConfNominas."Concepto Sal. Base" = LinNominasES."Concepto salarial") THEN BEGIN
                                                                IF (LinNominasES."Importe Base" > DeduccGob."Tope Salarial/Acumulado Anual") AND
                                                                   (DeduccGob."Tope Salarial/Acumulado Anual" <> 0) THEN
                                                                    ImporteCotizacion += DeduccGob."Tope Salarial/Acumulado Anual" / 2
                                                                ELSE
                                                                    IF Empleado."Employment Date" >= PerInici THEN BEGIN
                                                                        ImporteCotizacion += LinNominasES.Total;
                                                                        Importecotizacionmes += LinNominasES."Importe Base" / 2 + LinNominasES.Total; //IDC
                                                                    END
                                                                    ELSE
                                                                        IF (DATE2DMY(Empleado."Employment Date", 2) = DATE2DMY(PerInici, 2)) AND (DATE2DMY(Empleado."Employment Date", 3) = DATE2DMY(PerInici, 3)) AND
                                                                           (SegundaQ) THEN BEGIN
                                                                            ImporteCotizacion += LinNominasES.Total;
                                                                            Importecotizacionmes += LinNominasES.Total;
                                                                        END
                                                                        ELSE
                                                                            ImporteCotizacion += LinNominasES."Importe Base" / 2;

                                                                ImporteCotizacionEmp := ImporteCotizacion;
                                                            END
                                                            ELSE BEGIN
                                                                ImporteCotizacion += LinNominasES.Total;
                                                                ImporteCotizacionEmp += LinNominasES.Total;
                                                            END;
                                                        END;
                                                END;
                                            UNTIL LinNominasES.NEXT = 0;
                                    END;
                    END
                    ELSE
                        IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Semanal) OR
                           (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::"Bi-Semanal") OR
                           (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Diaria) THEN BEGIN
                            LinNominasES.SETRANGE(Periodo, PerInici, PerFinal);
                            IF ConfNominas."Concepto AFP" = DeduccGob.Codigo THEN
                                LinNominasES.SETRANGE("Cotiza AFP", TRUE)
                            ELSE
                                IF ConfNominas."Concepto INFOTEP" = DeduccGob.Codigo THEN BEGIN
                                    LinNominasES.SETRANGE("Cotiza Infotep", TRUE);
                                    IF TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Bonificacion THEN BEGIN
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

                            IF LinNominasES.FINDSET(FALSE, FALSE) THEN
                                REPEAT
                                    IF (NOT Empleado."Excluido Cotizacion TSS") AND ((LinNominasES."Cotiza SFS" OR LinNominasES."Cotiza AFP")) THEN BEGIN
                                        ImporteCotizacion += LinNominasES.Total;
                                        ImporteCotizacionEmp += LinNominasES.Total;
                                    END
                                    ELSE
                                        IF (LinNominasES."Cotiza SRL" OR (LinNominasES."Cotiza Infotep")) THEN BEGIN
                                            ImporteCotizacion += LinNominasES.Total;
                                            ImporteCotizacionEmp += LinNominasES.Total;
                                        END;
                                UNTIL LinNominasES.NEXT = 0;
                        END;

            //Para los casos en que la comision se paga antes del salario
            //Vendedores, se verifica si la nomina regular se paga antes de comision o no
            IF NOT SegundaQ THEN BEGIN
                TN.RESET;
                TN.SETRANGE("Tipo de nomina", TN."Tipo de nomina"::Regular);
                TN.FINDFIRST;
                LinNominasES.RESET;
                LinNominasES.SETRANGE("No. empleado", GlobalRec."No. empleado");
                IF (TiposNom."Dia inicio 1ra" > TiposNom."Dia inicio 2da") AND (SegundaQ) AND (TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Regular) THEN
                    LinNominasES.SETRANGE(Periodo, DMY2DATE(TiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                ELSE
                    IF (TN."Dia inicio 1ra" > TN."Dia inicio 2da") AND ((TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Prestaciones) OR (TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Bonificacion)) THEN
                        LinNominasES.SETRANGE(Periodo, DMY2DATE(TN."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                    ELSE
                        LinNominasES.SETRANGE(Periodo, PerInici, PerFinal);
                LinNominasES.SETRANGE("Concepto salarial", ConfNominas."Concepto Sal. Base");
                LinNominasES.SETFILTER("Tipo de nomina", '<>%1', GlobalRec."Tipo de nomina");
                IF NOT LinNominasES.FINDFIRST THEN BEGIN
                    //Busco si se le esta pagando en esta nomina
                    LinNominasES.RESET;
                    LinNominasES.SETRANGE("No. empleado", GlobalRec."No. empleado");
                    IF (TiposNom."Dia inicio 1ra" > TiposNom."Dia inicio 2da") AND (SegundaQ) AND (TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Regular) THEN
                        LinNominasES.SETRANGE(Periodo, DMY2DATE(TiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                    ELSE
                        IF (TN."Dia inicio 1ra" > TN."Dia inicio 2da") AND ((TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Prestaciones) OR (TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Bonificacion)) THEN
                            LinNominasES.SETRANGE(Periodo, DMY2DATE(TN."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                        ELSE
                            LinNominasES.SETRANGE(Periodo, PerInici, PerFinal);
                    LinNominasES.SETRANGE("Tipo de nomina", GlobalRec."Tipo de nomina");
                    IF LinNominasES.FINDFIRST THEN BEGIN
                        PerfilSalImp.RESET;
                        PerfilSalImp.SETRANGE("No. empleado", GlobalRec."No. empleado");
                        PerfilSalImp.SETRANGE("Salario Base", TRUE);
                        PerfilSalImp.SETFILTER(Cantidad, '>%1', 0);
                        PerfilSalImp.SETFILTER(Importe, '>%1', 0);
                        PerfilSalImp.SETFILTER("Tipo de nomina", '<>%1', GlobalRec."Tipo de nomina");
                        IF PerfilSalImp.FINDSET THEN
                            REPEAT
                                IF TiposNom."Cotiza AFP" OR TiposNom."Cotiza INFOTEP" OR TiposNom."Cotiza SFS" OR TiposNom."Cotiza SRL" THEN BEGIN
                                    ImporteCotizacion += PerfilSalImp.Importe;
                                    ImporteCotizacionEmp += PerfilSalImp.Importe;
                                END;
                            UNTIL PerfilSalImp.NEXT = 0;
                    END;
                END;
            END;

            IF (MontoMaximoImpEmpl <= ABS(ImporteImpuestos)) AND (DeduccGob."Tope Salarial/Acumulado Anual" <> 0) AND (DeduccGob."Porciento Empleado" <> 0) THEN
                IndSkip := TRUE;

            IF (MontoMaximoImpEmpr <= ABS(ImporteImpuestos)) AND (DeduccGob."Tope Salarial/Acumulado Anual" <> 0) AND (DeduccGob."Porciento Empresa" <> 0) THEN
                IndSkip := TRUE;

            IF (ImporteCotizacion > DeduccGob."Tope Salarial/Acumulado Anual") AND (DeduccGob."Tope Salarial/Acumulado Anual" <> 0) AND
               (DeduccGob."Porciento Empleado" <> 0) AND (ImporteCotizacion > 0) THEN BEGIN
                ImporteCotizacion := DeduccGob."Tope Salarial/Acumulado Anual";
                MontoAplicar := ImporteCotizacion * DeduccGob."Porciento Empleado" / 100;
                IF ABS(ImporteImpuestos) >= MontoAplicar THEN
                    IndSkip := TRUE;
            END;

            IF (ImporteCotizacion > DeduccGob."Tope Salarial/Acumulado Anual") AND (DeduccGob."Tope Salarial/Acumulado Anual" <> 0) AND
               (ImporteCotizacion > 0) THEN
                ImporteCotizacion := DeduccGob."Tope Salarial/Acumulado Anual";

            IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal THEN BEGIN
                IF ((PerfilSalTr."1ra Quincena" <> PrimeraQ) AND (PrimeraQ) AND
                   ((Empleado."Fin contrato" = 0D) OR (Empleado."Fin contrato" >= PerFinal))) THEN
                    IndSkip := TRUE;

                IF (NOT PerfilSalTr."1ra Quincena") AND (PerfilSalTr."2da Quincena") AND (PrimeraQ) THEN
                    IndSkip := TRUE;

                IF ((PerfilSalTr."2da Quincena" <> SegundaQ) AND (SegundaQ) AND
                   ((Empleado."Fin contrato" = 0D) OR (Empleado."Fin contrato" >= PerFinal))) THEN
                    IndSkip := TRUE;
            END;

            //Employee
            IF (DeduccGob."Porciento Empleado" <> 0) AND (ImporteCotizacion <> 0) THEN BEGIN
                MontoAplicar := ROUND((ImporteCotizacion * DeduccGob."Porciento Empleado" / 100) + ImporteImpuestos, 0.01);

                IF ConfNominas."Concepto SFS" = DeduccGob.Codigo THEN BEGIN
                    SFSMes := Importecotizacionmes * DeduccGob."Porciento Empleado" / 100;
                    TSSSueldo += TSSSueldo * DeduccGob."Porciento Empleado" / 100;
                    TSSOtros += TSSOtros * DeduccGob."Porciento Empleado" / 100;
                END
                ELSE
                    IF ConfNominas."Concepto AFP" = DeduccGob.Codigo THEN BEGIN
                        AFPMes := Importecotizacionmes * DeduccGob."Porciento Empleado" / 100;
                        TSSSueldo += TSSSueldo * DeduccGob."Porciento Empleado" / 100;
                        TSSOtros += TSSOtros * DeduccGob."Porciento Empleado" / 100;
                    END;
                //IDC Fin

                IF (ImporteCotizacion >= DeduccGob."Tope Salarial/Acumulado Anual") AND
                   (DeduccGob."Tope Salarial/Acumulado Anual" <> 0) THEN BEGIN
                    ImporteCotizacion := DeduccGob."Tope Salarial/Acumulado Anual";
                    ImporteCotizacionEmp := ImporteCotizacion;
                    MontoAplicar := ImporteCotizacion * DeduccGob."Porciento Empleado" / 100;
                    MontoAplicar += ImporteImpuestos;
                    IF MontoAplicar < 0 THEN
                        MontoAplicar := 0;
                END;

                IF NOT IndSkip THEN BEGIN
                    //                  message('paso2 %1 %2 %3',importeimpuestos,montoaplicar,importecotizacion);
                    PerfilSalTr.Importe := ImporteCotizacion;
                    PerfilSalTr.Cantidad := 1;
                    //            MontoAplicar         += ImporteImpuestos;
                    /*
                                IF ((Contrato."Tipo Pago Nomina" = Contrato."Tipo Pago Nomina"::Quincenal) AND
                                    (PerfilSalTr."1ra Quincena") AND (PerfilSalTr."2da Quincena") AND (PrimeraQ)) OR
                                    (Empleado."fin contrato" <> 0D) THEN
                                    IF Puestos."Método cálculo Paga Salario" = Puestos."Método cálculo Paga Salario"::Distribuido THEN
                                       MontoAplicar     /= 2;
                    */
                    ImporteTotal := MontoAplicar * -1;
                    "%Cot" := DeduccGob."Porciento Empleado";
                    LinTabla += 10;
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
            LinAportesEmpresa."Tipo Nomina" := CabNomina."Tipo Nomina";
            LinAportesEmpresa."Tipo de nomina" := CabNomina."Tipo de nomina";
            LinAportesEmpresa."No. Empleado" := CabNomina."No. empleado";
            LinAportesEmpresa.VALIDATE("Concepto Salarial", DeduccGob.Codigo);
            LinAportesEmpresa."% Cotizable" := DeduccGob."Porciento Empresa";

            IF (ImporteCotizacionEmp > DeduccGob."Tope Salarial/Acumulado Anual") AND
               (DeduccGob."Tope Salarial/Acumulado Anual" <> 0) THEN
                ImporteCotizacionEmp := DeduccGob."Tope Salarial/Acumulado Anual";

            LinAportesEmpresa."Base Imponible" := ImporteCotizacionEmp;
            LinAportesEmpresa.Importe := ROUND(ImporteCotizacionEmp * DeduccGob."Porciento Empresa" / 100, 0.01) * -1;
            LinAportesEmpresa.Descripcion := PerfilSalTr.Descripcion;
            LinAportesEmpresa."Job No." := GlobalRec."Job No.";
            IF ((Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) AND
               (PerfilSalTr."1ra Quincena") AND (PerfilSalTr."2da Quincena")) AND
               (SegundaQ) THEN BEGIN
                //Busco el importe cobrado del impuesto
                ImporteImpuestosemp := 0;
                LinAportesEmpresa2.RESET;
                LinAportesEmpresa2.SETRANGE("No. Empleado", GlobalRec."No. empleado");
                IF TiposNom."Dia inicio 1ra" > TiposNom."Dia inicio 2da" THEN
                    LinAportesEmpresa2.SETRANGE(Periodo, DMY2DATE(TiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                ELSE
                    LinAportesEmpresa2.SETRANGE(Periodo, PerInici, PerFinal);
                //           LinAportesEmpresa2.SETRANGE(Periodo,DMY2DATE(1,DATE2DMY(PerInici,2),DATE2DMY(PerInici,3)));
                LinAportesEmpresa2.SETRANGE("Concepto Salarial", DeduccGob.Codigo);
                IF LinAportesEmpresa2.FINDSET THEN
                    REPEAT
                        ImporteImpuestosemp += LinAportesEmpresa2.Importe;
                    UNTIL LinAportesEmpresa2.NEXT = 0;

                LinAportesEmpresa.Importe -= ROUND(ImporteImpuestosemp, 0.01);
            END;


            IF (LinAportesEmpresa.Importe <> 0) AND (NOT IndSkip) THEN BEGIN
                CLEAR(recTmpDimEntry);
                recTmpDimEntry.DELETEALL;
                InsertarDimTempDef(5200);                                                                      //Para las Dim del empleado
                InsertarDimTemp(ConfNominas."Dimension Conceptos Salariales", PerfilSalTr."Concepto salarial"); //Para el concepto salarial
                InsertarDimTempDefPS(34002115, Empleado."No." + PerfilSalTr."Concepto salarial");                 //Para las Dim del perfil de salario (linea del concepto salarial)
                InsertarDimTempDefPS(34002105, Empleado."Posting Group" + PerfilSalTr."Concepto salarial");    //Para las Dim del grupo contable (linea del concepto salarial)
                InsertarDimTempDefPS(34002111, PerfilSalTr."Concepto salarial");    //Para las Dim de la config. concepto salarial
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
        ImpuestoMes: Decimal;
    begin
        ImporteCotizacionRec := 0;
        MontoAplicar := 0;
        IF Empleado."Excluido Cotizacion TSS" THEN
            EXIT;
        DeduccGob.RESET;
        DeduccGob.SETRANGE(Ano, Ano);
        DeduccGob.SETFILTER("Porciento Empleado", '<>%1', 0);
        DeduccGob.FINDSET;
        REPEAT
            PerfilSalTr.RESET;
            PerfilSalTr.SETRANGE("No. empleado", GlobalRec."No. empleado");
            PerfilSalTr.SETRANGE("Concepto salarial", DeduccGob.Codigo);
            PerfilSalTr.SETRANGE("Cotiza ISR", TRUE);
            PerfilSalTr.FINDFIRST;
            IF (NOT PerfilSalTr."1ra Quincena") AND PerfilSalTr."2da Quincena" AND PrimeraQ THEN BEGIN
                IndSkip := FALSE;
                MontoAplicar := 0;
                LinNominasES.RESET;
                LinNominasES.SETRANGE("No. empleado", GlobalRec."No. empleado");
                LinNominasES.SETRANGE(Periodo, PerInici, PerFinal);
                //LinNominasES.SETRANGE("Concepto salarial",PerfilSalTr."Concepto salarial");
                LinNominasES.SETRANGE("Job No.", GlobalRec."Job No.");
                IF ConfNominas."Concepto AFP" = DeduccGob.Codigo THEN
                    LinNominasES.SETRANGE("Cotiza AFP", TRUE)
                ELSE
                    IF ConfNominas."Concepto SFS" = DeduccGob.Codigo THEN
                        LinNominasES.SETRANGE("Cotiza SFS", TRUE);

                IF LinNominasES.FINDSET THEN
                    REPEAT
                        IF DeduccGob."Tope Salarial/Acumulado Anual" > (LinNominasES."Importe Base" + MontoAplicar) THEN
                            MontoAplicar += LinNominasES."Importe Base"
                        ELSE
                            MontoAplicar := DeduccGob."Tope Salarial/Acumulado Anual";
                    UNTIL LinNominasES.NEXT = 0;

                ImporteCotizacionRec += MontoAplicar * DeduccGob."Porciento Empleado" / 100;
            END;
        UNTIL DeduccGob.NEXT = 0;
        //ERROR('%1',Importecotizacionrec);
        ImporteCotizacionRec *= -1;

        //MESSAGE('%1',ImporteCotizacionRec);
    end;

    procedure CalcularISR()
    var
        "RetencionISR": Record 34002131;
        SaldoFavor: Record 34002128;
        SaldoFavor2: Record 34002128;
        HLNISRCompensado: Record 34002118;
        HistLinNom: Record 34002118;
        HistLinNomISR: Record 34002118;
        BKSaldoFavor: Record 34002130;
        LinAportesEmpresa: Record 34002122;
        EmpresasRel: Record 34002150;
        EmpresasRel2: Record 34002150;
        LinEsqPercepISR: Record 34002115;
        LinEsqPercepISR2: Record 34002115;
        LinEsqPercepTSS: Record 34002115;
        HistCabNom: Record 34002117;
        HistLinCompany: Record 34002118;
        Indice: Integer;
        Importe1: Decimal;
        Importe2: Decimal;
        Importe3: Decimal;
        RangoISR: array[5] of Decimal;
        ImporteRetencion: array[5] of Decimal;
        "%Calcular": array[5] of Integer;
        t: Integer;
        NoLinImp: Integer;
        Base: Decimal;
        TotalCompany: Decimal;
        Err002: Label 'Employee %1 doesn''t have posted payroll in company %2, please verify';
        ImporteISR: Decimal;
        ISRCompensado2: Decimal;
        ISRCalculado: Decimal;
        ISRDevolver: Decimal;
        txtISRCompensado: Text;
        dISRCompensando: Decimal;
        PrimeraVez: Boolean;
        HayNominas: Boolean;
        ISRCobrado: Decimal;
    begin
        //Poner que el acumulado base del ISR sea sobre lo devengado en el mes anterior.
        //Si se pasa del mes, solo calcular los dias trabajados en el mes. y revisar para el llenado de la plantilla de la tss

        //CalculoISR
        IF Empleado."Excluido Cotizacion ISR" THEN
            EXIT;

        Importe1 := 0;
        ISRCompensado := 0;
        ISRCompensado2 := 0;
        TotalCompany := 0;
        ISRCobrado := 0;
        PrimeraVez := TRUE;
        CLEAR(TotalISR);
        LinTabla += 10;
        CLEAR(TotalISR);
        LinNomina.INIT;
        "%Cot" := 0;
        HayNominas := FALSE;

        //Busco si es quincenal cuando se deduce el ISR
        LinEsqPercepISR2.RESET;
        LinEsqPercepISR2.SETRANGE("No. empleado", GlobalRec."No. empleado");
        LinEsqPercepISR2.SETRANGE("Concepto salarial", ConfNominas."Concepto ISR");
        IF NOT LinEsqPercepISR2.FINDFIRST THEN
            LinEsqPercepISR2.INIT;

        IF ((NOT LinEsqPercepISR2."1ra Quincena") AND LinEsqPercepISR2."2da Quincena" AND PrimeraQ) THEN
            EXIT;

        IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal THEN
            //   IF Puestos."Método cálculo Paga Salario" = 0 THEN //Para Normal, se divide el salario
            IngresoSalario := IngresoSalario / 2;

        TN.RESET;
        TN.SETRANGE("Tipo de nomina", TN."Tipo de nomina"::Regular);
        TN.FINDFIRST;

        //Busco lo que se ha descontado en el periodo
        HistLinNom.RESET;
        HistLinNom.SETRANGE("No. empleado", GlobalRec."No. empleado");
        IF (TiposNom."Dia inicio 1ra" > TiposNom."Dia inicio 2da") AND (SegundaQ) AND (TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Regular) THEN
            HistLinNom.SETRANGE(Periodo, DMY2DATE(TiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
        ELSE
            IF (TN."Dia inicio 1ra" > TN."Dia inicio 2da") AND ((TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Prestaciones) OR (TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Bonificacion)) THEN
                HistLinNom.SETRANGE(Periodo, DMY2DATE(TN."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
            ELSE
                IF (TN."Dia inicio 1ra" < TN."Dia inicio 2da") AND (SegundaQ) THEN
                    HistLinNom.SETRANGE(Periodo, DMY2DATE(TN."Dia inicio 1ra", DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)), PerFinal)
                ELSE
                    HistLinNom.SETRANGE(Periodo, PerInici, PerFinal);
        HistLinNom.SETRANGE("Concepto salarial", ConfNominas."Concepto ISR");
        IF HistLinNom.FINDSET(FALSE, FALSE) THEN
            REPEAT
                ISRCobrado := ISRCobrado + (HistLinNom.Total * -1);
            UNTIL HistLinNom.NEXT = 0;

        //Busqueda de todos los conceptos que cotizan para el calculo del ISR
        HistLinNom.RESET;
        HistLinNom.SETRANGE("No. empleado", GlobalRec."No. empleado");
        IF (TiposNom."Dia inicio 1ra" > TiposNom."Dia inicio 2da") AND (SegundaQ) AND (TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Regular) THEN
            HistLinNom.SETRANGE(Periodo, DMY2DATE(TiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
        ELSE
            IF (TN."Dia inicio 1ra" > TN."Dia inicio 2da") AND ((TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Prestaciones) OR (TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Bonificacion)) THEN
                HistLinNom.SETRANGE(Periodo, DMY2DATE(TN."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
            ELSE
                IF (TN."Dia inicio 1ra" < TN."Dia inicio 2da") AND (SegundaQ) THEN
                    HistLinNom.SETRANGE(Periodo, DMY2DATE(TN."Dia inicio 1ra", DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)), PerFinal)
                ELSE
                    HistLinNom.SETRANGE(Periodo, PerInici, PerFinal);
        HistLinNom.SETRANGE("Cotiza ISR", TRUE);
        IF HistLinNom.FINDSET(FALSE, FALSE) THEN
            REPEAT
                IF HistLinNom."Concepto salarial" = ConfNominas."Concepto Sal. Base" THEN
                    HayNominas := TRUE;
                /*
                     IF SegundaQ THEN
                       BEGIN
                        HistCabNom.RESET;
                        HistCabNom.SETRANGE("No. empleado",GlobalRec."No. empleado");
                        HistCabNom.SETRANGE(Periodo,DMY2DATE(TN."Dia inicio 1ra",DATE2DMY(CALCDATE('-1M',PerInici),2),DATE2DMY(CALCDATE('-1M',PerInici),3)),PerFinal);
                        IF NOT HistCabNom.FINDFIRST THEN
                           HistCabNom.INIT
                        ELSE
                        IF DATE2DMY(HistLinNom.Periodo,1) <> TN."Dia inicio 1ra"  THEN
                           HistCabNom."Empresa cotizacion" := CabNomina."Empresa cotizacion";
                       END;
                  */
                //  ELSE
                //    HistCabNom."Empresa cotizacion" := CabNomina."Empresa cotizacion";

                LinEsqPercepISR.RESET;
                LinEsqPercepISR.SETRANGE("No. empleado", GlobalRec."No. empleado");
                LinEsqPercepISR.SETRANGE("Concepto salarial", HistLinNom."Concepto salarial");
                LinEsqPercepISR.FINDFIRST;
                ///MESSAGE('%1 %2\%3',HistCabNom."Empresa cotizacion",cabnomina."Empresa cotizacion",histcabnom.GETFILTERS);
                IF LinEsqPercepISR."1ra Quincena" AND LinEsqPercepISR."2da Quincena" THEN BEGIN
                    //IF (HistCabNom."Empresa cotizacion" = CabNomina."Empresa cotizacion") THEN
                    BEGIN
                        IF (Puestos."Método cálculo Paga Salario" = 0) AND (HistLinNom."Salario Base" AND PrimeraQ) AND (PrimeraVez) THEN BEGIN
                            HistLinNom.Total += IngresoSalario;
                            PrimeraVez := FALSE;
                        END;
                        //Solo si el ISR se deduce en ambas quincenas
                        IF (HistLinNom.Total <> 0) AND (LinEsqPercepISR2."1ra Quincena" AND LinEsqPercepISR2."2da Quincena") AND
                          (HistLinNom."Salario Base") THEN BEGIN
                            IF (HistLinNom."Tipo concepto" = HistLinNom."Tipo concepto"::Deducciones) AND (PrimeraQ) THEN BEGIN
                                IF (Puestos."Método cálculo Paga Salario" = Puestos."Método cálculo Paga Salario"::Distribuido) THEN BEGIN
                                    IF (Empleado."Employment Date" >= PerInici) AND (PrimeraQ) THEN BEGIN
                                        IF HistLinNom."Concepto salarial" = ConfNominas."Concepto AFP" THEN
                                            TotalISR[1] [1] -= AFPMes
                                        ELSE
                                            TotalISR[1] [1] -= SFSMes;
                                    END
                                    ELSE
                                        TotalISR[1] [1] += ROUND(HistLinNom.Total * 2, 0.01)
                                END
                                ELSE
                                    TotalISR[1] [1] += ROUND(HistLinNom.Total, 0.01);
                            END
                            ELSE
                                IF (HistLinNom."Salario Base") THEN
                                    TotalISR[1] [1] += ROUND(HistLinNom.Total, 0.01)
                            //ELSE
                        END
                        ELSE
                            IF (HistLinNom.Total <> 0) AND (NOT HistLinNom."Salario Base") THEN BEGIN
                                IF (HistLinNom."Tipo concepto" = HistLinNom."Tipo concepto"::Deducciones) AND (PrimeraQ) THEN
                                    TotalISR[1] [1] += ROUND(HistLinNom.Total, 0.01)
                                ELSE
                                    IF (HistLinNom."Tipo concepto" = HistLinNom."Tipo concepto"::Ingresos) AND (PrimeraQ) AND
                                        (NOT HistLinNom."Salario Base") THEN
                                        TotalISR[1] [1] += ROUND(HistLinNom.Total, 0.01)
                                    ELSE
                                        TotalISR[1] [1] += ROUND(HistLinNom.Total, 0.01)
                            END
                            ELSE
                                IF HistLinNom.Total <> 0 THEN
                                    TotalISR[1] [1] += ROUND(HistLinNom.Total, 0.01)
                    END;
                END
                ELSE
                    IF HistLinNom.Total <> 0 THEN BEGIN
                        TotalISR[1] [1] += ROUND(HistLinNom.Total, 0.01);
                    END;
            //     MESSAGE('%1 %2 %3 %4',TotalISR[1][1],HistLinNom.Total,HistLinNom."Concepto salarial");
            UNTIL HistLinNom.NEXT = 0;

        //Para los casos en que la comision se paga antes del salario
        HistLinNom.RESET;
        HistLinNom.SETRANGE("No. empleado", GlobalRec."No. empleado");
        IF (TiposNom."Dia inicio 1ra" > TiposNom."Dia inicio 2da") AND (SegundaQ) AND (TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Regular) THEN
            HistLinNom.SETRANGE(Periodo, DMY2DATE(TiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
        ELSE
            IF (TN."Dia inicio 1ra" > TN."Dia inicio 2da") AND ((TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Prestaciones) OR (TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Bonificacion)) THEN
                HistLinNom.SETRANGE(Periodo, DMY2DATE(TN."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
            ELSE
                HistLinNom.SETRANGE(Periodo, PerInici, PerFinal);
        HistLinNom.SETRANGE("Cotiza ISR", TRUE);
        HistLinNom.SETRANGE("Tipo concepto", HistLinNom."Tipo concepto"::Ingresos);
        HistLinNom.SETRANGE("Tipo de nomina", TiposNom.Codigo);
        IF HistLinNom.FINDFIRST AND (NOT HayNominas) THEN BEGIN
            IF (TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Comisiones) AND (NOT HayNominas) AND (TotalISR[1] [1] <> 0) THEN BEGIN
                LinEsqPercepISR2.RESET;
                LinEsqPercepISR2.SETRANGE("No. empleado", GlobalRec."No. empleado");
                LinEsqPercepISR2.SETRANGE("Salario Base", TRUE);
                LinEsqPercepISR2.SETRANGE("Cotiza ISR", TRUE);
                LinEsqPercepISR2.SETFILTER(Cantidad, '>=%1', 1);
                LinEsqPercepISR2.SETFILTER("Tipo de nomina", '<>%1', TiposNom.Codigo);
                IF LinEsqPercepISR2.FINDSET THEN
                    REPEAT
                        TotalISR[1] [1] += LinEsqPercepISR2.Importe;
                    UNTIL LinEsqPercepISR2.NEXT = 0;
            END;
        END;

        //Modificar calculo descuentos cuando es caso vendedores

        IF (HistLinNom.Total <> 0) AND (LinEsqPercepISR2."1ra Quincena" AND LinEsqPercepISR2."2da Quincena") THEN BEGIN
            LinEsqPercepTSS.RESET;
            LinEsqPercepTSS.SETRANGE("No. empleado", GlobalRec."No. empleado");
            LinEsqPercepTSS.SETRANGE("Concepto salarial", ConfNominas."Concepto SFS");
            LinEsqPercepTSS.FINDFIRST;
            IF NOT LinEsqPercepTSS."1ra Quincena" THEN
                ReCalcularDtosLegales;
            //    IF ImporteCotizacionRec <> 0 THEN
            //       IF
        END
        ELSE
            ReCalcularDtosLegales; //Para el caso de que el ISR solo se paga en 1ra, se calculan AFP y SFS para el mes.

        //ERROR('%1 %2',TotalISR[1][1],ImporteCotizacionRec);

        TotalISR[1] [1] += ImporteCotizacionRec;
        /*
        IF (GlobalRec."Tipo Nomina" = GlobalRec."Tipo Nomina"::Normal) OR
           (GlobalRec."Tipo Nomina" = GlobalRec."Tipo Nomina"::Bonificacion) THEN
        */
        IF (TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Regular) OR
           (TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Bonificacion) THEN
            TotalISR[1] [1] += TotalCompany + Empleado."Salario Empresas Externas"
        ELSE
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
            Indice += 1;
        UNTIL RetencionISR.NEXT = 0;

        //ERROR('%1 %2',Totalisr[1][1],RangoISR[1]);

        IF TotalISR[1] [1] < (RangoISR[1] / 12) THEN
            EXIT;

        IF ((TotalISR[1] [1] * 12) >= RangoISR[1]) AND
           ((TotalISR[1] [1] * 12) < (RangoISR[2])) THEN BEGIN
            Importe1 := (TotalISR[1] [1] - (RangoISR[1] / 12)) * "%Calcular"[1] / 100;
            "%Cot" := "%Calcular"[1];
        END
        ELSE
            IF ((TotalISR[1] [1] * 12) >= RangoISR[2]) AND
               ((TotalISR[1] [1] * 12) < RangoISR[3]) THEN BEGIN
                Importe1 := ((TotalISR[1] [1] * 12) - RangoISR[2]) * "%Calcular"[2] / 100;
                Importe1 := ROUND((Importe1 + ImporteRetencion[2]) / 12, 0.01);
                "%Cot" := "%Calcular"[2];
            END
            ELSE
                IF (TotalISR[1] [1] * 12) >= (RangoISR[3]) THEN BEGIN
                    Importe1 := ((TotalISR[1] [1] * 12) - RangoISR[3]) * "%Calcular"[3] / 100;
                    Importe1 := ROUND((Importe1 + ImporteRetencion[3]) / 12, 0.01);
                    "%Cot" := "%Calcular"[3];
                END;

        //Para buscar lo compensando del periodo y saber el pendiente
        txtISRCompensado := '';
        dISRCompensando := 0;
        HLNISRCompensado.RESET;
        HLNISRCompensado.SETRANGE("No. empleado", GlobalRec."No. empleado");
        HLNISRCompensado.SETRANGE("Concepto salarial", ConfNominas."Concepto ISR");
        HLNISRCompensado.SETFILTER(Comentario, '<>%1', '');
        //HLNISRCompensado.SETRANGE(Periodo,DMY2DATE(1,1,DATE2DMY(PerFinal,3)),PerFinal);

        IF (TiposNom."Dia inicio 1ra" > TiposNom."Dia inicio 2da") AND (SegundaQ) AND (TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Regular) THEN
            HLNISRCompensado.SETRANGE(Periodo, DMY2DATE(TiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
        ELSE
            IF (TN."Dia inicio 1ra" > TN."Dia inicio 2da") AND (TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Prestaciones) THEN
                HLNISRCompensado.SETRANGE(Periodo, DMY2DATE(TN."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
            ELSE
                HLNISRCompensado.SETRANGE(Periodo, PerInici, PerFinal);
        IF HLNISRCompensado.FINDLAST THEN BEGIN
            txtISRCompensado := COPYSTR(HLNISRCompensado.Comentario, STRPOS(HLNISRCompensado.Comentario, 'calculado') + 11, 12);
            txtISRCompensado := COPYSTR(txtISRCompensado, 1, STRPOS(txtISRCompensado, '.') + 2);
            IF (DATE2DMY(HLNISRCompensado."Fin periodo", 2) = DATE2DMY(PerInici, 2)) AND (DATE2DMY(HLNISRCompensado."Fin periodo", 3) = DATE2DMY(PerInici, 3)) THEN
                EVALUATE(dISRCompensando, txtISRCompensado);
        END;
        //ERROR('%1',txtISRCompensado);
        //Aqui se buscan los saldos a favor del empleado y si encuentra uno se pasa a una tabla
        //que sirve de BK al importe

        SaldoFavor.RESET;
        SaldoFavor.SETRANGE("Cod. Empleado", GlobalRec."No. empleado");
        SaldoFavor.SETRANGE(Ano, DATE2DMY(PerInici, 3));
        //SaldoFavor.SETFILTER("Importe Pendiente",'>0');
        IF SaldoFavor.FINDFIRST THEN BEGIN
            BKSaldoFavor.TRANSFERFIELDS(SaldoFavor);
            IF NOT BKSaldoFavor.INSERT THEN
                BKSaldoFavor.MODIFY;
        END;

        //message('a%1   b%2   c%3   d%4',Importe1, Importe2, Importe3);
        //TotalISR[1][1] := ROUND(Importe1 + Importe2 + Importe3,0.01);
        TotalISR[1] [1] := Importe1;
        ISRCalculado := TotalISR[1] [1];

        ConceptosSal.SETRANGE(Codigo, ConfNominas."Concepto ISR");
        ConceptosSal.FINDFIRST;

        CLEAR(PerfilSalImp);

        PerfilSalImp.SETRANGE("No. empleado", GlobalRec."No. empleado");
        PerfilSalImp.SETRANGE("Concepto salarial", ConfNominas."Concepto ISR");
        IF NOT PerfilSalImp.FINDFIRST THEN
            EXIT;

        IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) AND
           (TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Regular) THEN
            IF ((PerfilSalImp."1ra Quincena" <> PrimeraQ) AND PrimeraQ) THEN
                EXIT;

        IF ((Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) AND
           (PerfilSalImp."1ra Quincena") AND (PerfilSalImp."2da Quincena") AND (PrimeraQ) AND
           (Puestos."Método cálculo Paga Salario" = 0)) THEN
            TotalISR[1] [1] := ROUND(TotalISR[1] [1] / 2, 0.01)
        ELSE BEGIN
            HistLinNomISR.RESET;
            HistLinNomISR.SETRANGE("No. empleado", GlobalRec."No. empleado");
            IF (TiposNom."Dia inicio 1ra" > TiposNom."Dia inicio 2da") AND (SegundaQ) AND (TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Regular) THEN
                HistLinNomISR.SETRANGE(Periodo, DMY2DATE(TiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
            ELSE
                IF (TN."Dia inicio 1ra" > TN."Dia inicio 2da") AND (TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Prestaciones) THEN
                    HistLinNomISR.SETRANGE(Periodo, DMY2DATE(TN."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                ELSE
                    IF (TiposNom."Dia inicio 1ra" > TiposNom."Dia inicio 2da") AND (TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Bonificacion) THEN
                        HistLinNomISR.SETRANGE(Periodo, DMY2DATE(TiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                    ELSE
                        HistLinNomISR.SETRANGE(Periodo, PerInici, PerFinal);

            HistLinNomISR.SETRANGE("Concepto salarial", ConfNominas."Concepto ISR");
            IF HistLinNomISR.FINDSET THEN
                REPEAT
                    IF ABS(TotalISR[1] [1]) < ABS(HistLinNomISR.Total) THEN
                        ISRDevolver := TotalISR[1] [1] + HistLinNomISR.Total;
                    TotalISR[1] [1] := TotalISR[1] [1] + HistLinNomISR.Total;
                    ISRCompensado += HistLinNomISR."ISR compensado";// - dISRCompensando;
                UNTIL HistLinNomISR.NEXT = 0;
        END;

        IF SaldoFavor."Importe Pendiente" <> 0 THEN BEGIN
            PerfilSalImp.Comentario := STRSUBSTNO(Text002, PerfilSalImp.Descripcion, FORMAT(TotalISR[1] [1], 0, '<Integer thousand><Decimals,3>'), FORMAT(SaldoFavor."Importe Pendiente" + ISRCompensado, 0, '<Integer thousand><Decimals,3>'));
            IF ABS(TotalISR[1] [1]) >= SaldoFavor."Importe Pendiente" THEN
                ISRCompensado2 := ISRCompensado - dISRCompensando + SaldoFavor."Importe Pendiente"
            ELSE
                ISRCompensado2 := ISRCompensado - dISRCompensando + ABS(TotalISR[1] [1]);

            IF ABS(TotalISR[1] [1]) >= SaldoFavor."Importe Pendiente" THEN BEGIN
                TotalISR[1] [1] -= (SaldoFavor."Importe Pendiente" + ISRCompensado);
                SaldoFavor."Importe Pendiente" := 0;
            END
            ELSE BEGIN
                SaldoFavor."Importe Pendiente" -= TotalISR[1] [1] - ISRCompensado;
                TotalISR[1] [1] := 0;
            END;
            ISRCompensado := ISRCompensado2;
        END
        ELSE
            IF ISRCompensado <> 0 THEN
                TotalISR[1] [1] := TotalISR[1] [1] - ISRCompensado;

        //ISRCompensado := ISRCompensado2;
        PerfilSalImp.Cantidad := 1;
        PerfilSalImp.Importe := Base;

        //ERROR('a%1 b%2 c%3',ABS(TotalISR[1][1]), ABS(ISRCalculado),ISRdevolver);

        //Si ya se ha cobrado el importe del impuesto, salgo del proceso
        //MESSAGE('%1 %2 %3 %4',ISRCobrado,Totalisr[1][1],ISRCompensado);
        IF ISRCobrado >= TotalISR[1] [1] THEN
            EXIT;

        IF ISRDevolver < 0 THEN BEGIN
            ConfNominas.TESTFIELD("Concepto devolucion ISR");
            LinEsqPercepTSS.RESET;
            LinEsqPercepTSS.SETRANGE("No. empleado", GlobalRec."No. empleado");
            LinEsqPercepTSS.SETRANGE("Concepto salarial", ConfNominas."Concepto devolucion ISR");
            LinEsqPercepTSS.FINDFIRST;
            LinTabla += 10;
            LinEsqPercepTSS.Cantidad := 1;
            //MESSAGE('%1 %2',ABS(ISRCalculado), ABS(TotalISR[1][1]));
            // LinEsqPercepTSS.Importe := ABS(ISRCalculado) - ABS(TotalISR[1][1]);
            LinEsqPercepTSS.Importe := ABS(ISRDevolver); //ABS(TotalISR[1][1]);
            LinEsqPercepTSS.VALIDATE(Importe);
            LinEsqPercepTSS."Tipo de nomina" := GlobalRec."Tipo de nomina";
            ImporteTotal := LinEsqPercepTSS.Importe;
            InsertNomina(LinEsqPercepTSS);
            EXIT;
        END;

        ImporteTotal := TotalISR[1] [1] * -1;

        IF PerfilSalImp."% ISR Pago Empleado" <> 0 THEN BEGIN
            PerfilSalImp.Importe := ROUND(TotalISR[1] [1] * PerfilSalImp."% ISR Pago Empleado" / 100, 0.01);
            ImporteTotal := PerfilSalImp.Importe * -1;
            //MESSAGE('paso %1 %2 %3',CabNomina."No. empleado");
            //Employer
            ImporteTotal := 0;
            LinAportesEmpresa.RESET;
            //LinAportesEmpresa.SETRANGE("No. Documento", CabNomina."No. Documento");
            //LinAportesEmpresa.SETRANGE("Tipo Nomina",CabNomina."Tipo Nomina");
            LinAportesEmpresa.SETRANGE("Tipo de nomina", CabNomina."Tipo de nomina");
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
            LinAportesEmpresa.Descripcion := PerfilSalImp.Descripcion;
            //LinAportesEmpresa."Job No."            := GlobalRec."Job No.";
            IF LinAportesEmpresa.Importe <> 0 THEN BEGIN
                LinAportesEmpresa.INSERT;
                "%Cot" := ROUND("%Cot" * PerfilSalImp."% ISR Pago Empleado" / 100, 0.01);

                CLEAR(recTmpDimEntry);

                InsertarDimTempDef(5200);                                                                       //Para las Dim del empleado
                InsertarDimTemp(ConfNominas."Dimension Conceptos Salariales", PerfilSalImp."Concepto salarial"); //Para el concepto salarial
                InsertarDimTempDefPS(34002115, Empleado."No." + PerfilSalImp."Concepto salarial");                 //Para las Dim del perfil de salario (linea del concepto salarial)
                InsertarDimTempDefPS(34002105, Empleado."Posting Group" + PerfilSalImp."Concepto salarial");    //Para las Dim del grupo contable (linea del concepto salarial)
                InsertarDimTempDefPS(34002111, PerfilSalImp."Concepto salarial");    //Para las Dim de la config. concepto salarial

                LinAportesEmpresa."Dimension Set ID" := cduDim.GetDimensionSetID(recTmpDimEntry);
            END;
        END;

        //Modifico el Saldo ISR a Favor
        SaldoFavor2.COPYFILTERS(SaldoFavor);
        IF SaldoFavor2.FINDSET(TRUE, FALSE) THEN BEGIN
            SaldoFavor2.TRANSFERFIELDS(SaldoFavor);
            SaldoFavor2."Importe Pendiente" := SaldoFavor."Importe Pendiente";
            SaldoFavor2.MODIFY;
        END;

        PerfilSalImp."Tipo Nomina" := GlobalRec."Tipo Nomina";
        PerfilSalImp."Tipo de nomina" := GlobalRec."Tipo de nomina";
        //IF (ImporteTotal <> 0) OR SaldoFavor."Importe Pendiente" <> 0 THEN
        InsertNomina(PerfilSalImp);

    end;

    procedure CalcularPrestamos()
    var
        LinPerfilSal: Record 34002115;
        Prestamos: Record 34002145;
        HistLinPrestamo: Record 34002147;
        HistCabPrestamo: Record 34002146;
        CheckHistLinPrestamo: Record 34002147;
    begin
        //CalcularPrestamos

        HistCabPrestamo.RESET;
        HistCabPrestamo.SETRANGE("Employee No.", PerfilSal."No. empleado");
        HistCabPrestamo.SETRANGE(Pendiente, TRUE);
        IF HistCabPrestamo.FINDSET THEN
            REPEAT
                //Busca la cuota del prestamo

                LinPerfilSal.SETRANGE("No. empleado", PerfilSal."No. empleado");
                LinPerfilSal.SETRANGE("Concepto salarial", HistCabPrestamo."Concepto Salarial");
                LinPerfilSal.FINDFIRST;

                CheckHistLinPrestamo.RESET;
                CheckHistLinPrestamo.SETRANGE("Codigo Empleado", HistCabPrestamo."Employee No.");
                CheckHistLinPrestamo.SETRANGE("No. Préstamo", HistCabPrestamo."No. Préstamo");
                CheckHistLinPrestamo.SETRANGE("Fecha Transaccion", PerInici);
                IF NOT CheckHistLinPrestamo.FINDFIRST THEN BEGIN
                    HistLinPrestamo.SETRANGE("Codigo Empleado", HistCabPrestamo."Employee No.");
                    HistLinPrestamo.SETRANGE("No. Préstamo", HistCabPrestamo."No. Préstamo");
                    IF (HistLinPrestamo.FINDLAST) AND (LinPerfilSal."Tipo concepto" <> 0) THEN BEGIN
                        HistLinPrestamo."No. Linea" += 100;
                        HistLinPrestamo."Tipo CxC" := HistCabPrestamo."Tipo CxC";
                        HistLinPrestamo."No. Cuota" += 1;
                        HistLinPrestamo."Fecha Transaccion" := PerInici;
                        HistLinPrestamo."Codigo Empleado" := LinPerfilSal."No. empleado";
                        HistLinPrestamo.Importe := -LinPerfilSal.Importe;
                        HistLinPrestamo.VALIDATE(Importe);
                        HistCabPrestamo.CALCFIELDS("Importe Pendiente");
                        IF HistCabPrestamo."Importe Pendiente" + HistLinPrestamo.Importe = 0 THEN BEGIN
                            HistCabPrestamo.Pendiente := FALSE;
                            HistCabPrestamo.MODIFY;
                        END;

                        HistLinPrestamo.INSERT;
                    END;
                END;
            UNTIL HistCabPrestamo.NEXT = 0;
    end;

    procedure CalculoBonificacion()
    var
        linperfilsal: Record 34002115;
    begin
        // Bonificacion
        PerfilSal.RESET;
        //PerfilSal.SETRANGE("Empresa cotizacion",GlobalRec."Empresa cotizacion");
        PerfilSal.SETRANGE("No. empleado", GlobalRec."No. empleado");
        PerfilSal.SETRANGE("Perfil salarial", GlobalRec."Perfil salarial");
        PerfilSal.SETRANGE("Tipo de nomina", GlobalRec."Tipo de nomina");
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
        //  PerfilSal.SETRANGE("Empresa cotizacion",GlobalRec."Empresa cotizacion");
        PerfilSal.SETRANGE("No. empleado", GlobalRec."No. empleado");
        PerfilSal.SETRANGE("Perfil salarial", GlobalRec."Perfil salarial");
        PerfilSal.SETRANGE("Tipo concepto", 0); /*Ingresos  */
        PerfilSal.SETRANGE("Tipo de nomina", GlobalRec."Tipo de nomina");
        IF PerfilSal.FINDSET(FALSE, FALSE) THEN
            REPEAT
                ImporteTotal := PerfilSal.Cantidad * ROUND(PerfilSal.Importe);
                InsertNomina(PerfilSal);
            UNTIL PerfilSal.NEXT = 0;

    end;

    procedure CalculoOtras()
    var
        PerfilSalProp: Record 34002115;
    begin
        // Propina
        PerfilSalProp.RESET;
        PerfilSalProp.SETRANGE("No. empleado", GlobalRec."No. empleado");
        PerfilSalProp.SETRANGE("Tipo de nomina", GlobalRec."Tipo de nomina");
        PerfilSalProp.SETFILTER(Cantidad, '<>%1', 0);
        IF PerfilSalProp.FINDSET(FALSE, FALSE) THEN
            REPEAT
                IF PerfilSalProp."Tipo concepto" = PerfilSalProp."Tipo concepto"::Deducciones THEN
                    ImporteTotal := (PerfilSalProp.Cantidad * PerfilSalProp.Importe) * -1
                ELSE
                    ImporteTotal := PerfilSalProp.Cantidad * PerfilSalProp.Importe;
                LinTabla += 10;
                InsertNomina(PerfilSalProp);
            UNTIL PerfilSalProp.NEXT = 0;
    end;

    procedure InsertNomina(perfSalario: Record 34002115)
    begin
        //InsertNomina
        ConceptosSal.GET(perfSalario."Concepto salarial");

        IF (ImporteTotal = 0) AND (ConceptosSal.Codigo <> ConfNominas."Concepto ISR") THEN
            EXIT;

        LinNomina."Empresa cotizacion" := perfSalario."Empresa cotizacion";
        LinNomina."Tipo Nomina" := GlobalRec."Tipo Nomina";
        LinNomina."Tipo de nomina" := TiposNom.Codigo;
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
        LinNomina.Total := ROUND(ImporteTotal, 0.01);
        LinNomina."Tipo concepto" := perfSalario."Tipo concepto";
        LinNomina."Salario Base" := ConceptosSal."Salario Base";
        LinNomina."Cotiza ISR" := ConceptosSal."Cotiza ISR";
        LinNomina."Cotiza SFS" := ConceptosSal."Cotiza SFS";
        LinNomina."Cotiza AFP" := ConceptosSal."Cotiza AFP";
        LinNomina."Cotiza SRL" := ConceptosSal."Cotiza SRL";
        LinNomina."Cotiza Infotep" := ConceptosSal."Cotiza INFOTEP";
        LinNomina."Sujeto Cotizacion" := ConceptosSal."Sujeto Cotizacion";
        LinNomina."Aplica para Regalia" := ConceptosSal."Aplica para Regalia";
        LinNomina.Formula := perfSalario."Formula cálculo";
        LinNomina.Imprimir := perfSalario.Imprimir;
        LinNomina."Inicio periodo" := PerInici;
        LinNomina."Fin periodo" := PerFinal;
        LinNomina."% Cotizable" := "%Cot";
        LinNomina."% Pago Empleado" := perfSalario."% ISR Pago Empleado";
        LinNomina."Texto Informativo" := perfSalario."Texto Informativo";
        IF perfSalario."Texto Informativo" THEN
            LinNomina.Total := 0;
        LinNomina.Departamento := Empleado.Departamento;
        LinNomina."Sub-Departamento" := Empleado."Sub-Departamento";
        LinNomina."Frecuencia de pago" := Contrato."Frecuencia de pago";
        LinNomina."Job No." := GlobalRec."Job No.";
        LinNomina.Comentario := perfSalario.Comentario;
        LinNomina."ISR compensado" := ISRCompensado;
        ConceptosSal.SETRANGE(Codigo, perfSalario."Concepto salarial");
        ConceptosSal.FINDFIRST;

        recTmpDimEntry.DELETEALL;
        InsertarDimTemp(ConceptosSal."Shortcut Dimension", perfSalario."Concepto salarial");         //Para el concepto salarial
        InsertarDimTempDef(5200);                                                                   //Para las Dim del empleado
        InsertarDimTempDefPS(34002115, Empleado."No." + perfSalario."Concepto salarial");             //Para las Dim del perfil de salario (linea del concepto salarial)
        InsertarDimTempDefPS(34002105, Empleado."Posting Group" + perfSalario."Concepto salarial"); //Para las Dim del grupo contable (linea del concepto salarial)
        InsertarDimTempDefPS(34002111, perfSalario."Concepto salarial");    //Para las Dim de la config. concepto salarial
        //MESSAGE('%1 %2',Empleado."Posting Group",Perfsalario."Concepto salarial");
        LinNomina."Dimension Set ID" := cduDim.GetDimensionSetID(recTmpDimEntry);


        LinNomina.INSERT;
    end;

    procedure InsertarDimTemp(DimCode: Code[20]; DimValue: Code[20])
    var
        recDimVal: Record 349;
    begin
        recDimVal.GET(DimCode, DimValue);
        //message('%1 %2 %3 %4',recDimVal."Dimension Value ID",dimcode,dimsetid,dimvalue);
        IF NOT recTmpDimEntry.GET(DimSetID, DimCode) THEN BEGIN
            CLEAR(recTmpDimEntry);
            recTmpDimEntry.VALIDATE("Dimension Code", DimCode);
            recTmpDimEntry.VALIDATE("Dimension Value Code", DimValue);
            recTmpDimEntry.VALIDATE("Dimension Value ID", recDimVal."Dimension Value ID");
            IF recTmpDimEntry.INSERT(TRUE) THEN;
        END;
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

    procedure InsertarDimTempDefPS(intPrmTabla: Integer; ConceptoSal: Code[20])
    var
        recDfltDim: Record 352;
    begin
        recDfltDim.RESET;
        recDfltDim.SETRANGE("Table ID", intPrmTabla);
        recDfltDim.SETRANGE("No.", ConceptoSal);
        IF recDfltDim.FINDSET(FALSE, FALSE) THEN
            REPEAT
                InsertarDimTemp(recDfltDim."Dimension Code", recDfltDim."Dimension Value Code");
            UNTIL recDfltDim.NEXT = 0;
    end;

    procedure CalculaDiasVacaciones()
    var
        HistVac: Record 34002141;
        Parametrosvacaciones: Record 34002187;
        AnoCalculado: Integer;
        MesCalculado: Integer;
        DiaCalculado: Integer;
        DiasVac: Integer;
        RangoAnos: array[5] of Integer;
        DiasAdicionales: array[5] of Integer;
        Indice: Integer;
        AnosEmpresa: Integer;
        MontoVac: Decimal;
    begin

        //GRN 25/02/2020 DiasVac := FuncionesNom.CalculoDiaVacaciones(Empleado."No.",DATE2DMY(PerFinal,2),DATE2DMY(PerFinal,3),MontoVac,Empleado."Employment Date",PerFinal);
        FuncionesNom.CalculoEntreFechas(Empleado."Employment Date", PerFinal, Anos, Meses, Dias);
        IF Anos >= 1 THEN
            DiasVac := 14
        ELSE
            CASE Meses OF
                0 .. 4:
                    DiasVac := 0;
                5:
                    DiasVac := 6;
                6:
                    DiasVac := 7;
                7:
                    DiasVac := 8;
                8:
                    DiasVac := 9;
                9:
                    DiasVac := 10;
                10:
                    DiasVac := 11;
                11:
                    DiasVac := 12;
                ELSE
                    DiasVac := 14;
            END;
        //Elimino los dias extras que tenga de las vacaciones
        Empleado.CALCFIELDS("Dias Vacaciones");
        IF Empleado."Dias Vacaciones" > 0 THEN BEGIN
            HistVac.RESET;
            HistVac.SETRANGE("No. empleado", Empleado."No.");
            HistVac.SETRANGE("Tipo calculo", HistVac."Tipo calculo"::Adicional);
            HistVac.SETRANGE("Fecha Inicio", CALCDATE('-1A', DMY2DATE(DATE2DMY(Empleado."Employment Date", 1), DATE2DMY(Empleado."Employment Date", 2), DATE2DMY(PerInici, 3))));
            IF HistVac.FINDLAST THEN
                HistVac.DELETE;
        END;

        IF (DiasVac <> 0) AND (DATE2DMY(Empleado."Employment Date", 2) = DATE2DMY(PerInici, 2)) THEN BEGIN
            HistVac.RESET;
            HistVac.SETRANGE("No. empleado", Empleado."No.");
            HistVac.SETRANGE("Fecha Inicio", PerInici, PerFinal);
            IF HistVac.FINDFIRST THEN BEGIN
                IF HistVac.Dias <> DiasVac THEN BEGIN
                    HistVac.Dias := DiasVac;
                    HistVac.MODIFY;
                END;
            END
            ELSE BEGIN
                HistVac.INIT;
                HistVac."No. empleado" := Empleado."No.";
                HistVac."Fecha Inicio" := DMY2DATE(DATE2DMY(Empleado."Employment Date", 1), DATE2DMY(Empleado."Employment Date", 2), DATE2DMY(PerInici, 3));
                HistVac."Fecha Fin" := CALCDATE('+1A', HistVac."Fecha Inicio");
                HistVac.Dias := DiasVac;
                IF HistVac.INSERT THEN;
            END;
            IF Parametrosvacaciones.FINDSET THEN BEGIN
                Indice := 0;
                REPEAT
                    Indice += 1;
                    RangoAnos[Indice] := Parametrosvacaciones.Desde;
                    DiasAdicionales[Indice] := Parametrosvacaciones."Cantidad de dias";
                UNTIL Parametrosvacaciones.NEXT = 0;

                FechaIniDT := CREATEDATETIME(Empleado."Employment Date", 0T);
                FechaFinDT := CREATEDATETIME(PerFinal, 0T);
                AnosEmpresa := FuncionesNom.CalculoEntreFechaDotNet('YYYY', FechaIniDT, FechaFinDT);


                //Insert los dias extras
                IF (AnosEmpresa >= RangoAnos[1]) AND (AnosEmpresa < RangoAnos[2]) AND
                   (RangoAnos[1] > 0) AND (RangoAnos[2] > 0) THEN BEGIN
                    HistVac.INIT;
                    HistVac."No. empleado" := Empleado."No.";
                    HistVac."Fecha Inicio" := DMY2DATE(DATE2DMY(Empleado."Employment Date", 1), DATE2DMY(Empleado."Employment Date", 2), DATE2DMY(PerInici, 3));
                    HistVac."Fecha Fin" := CALCDATE('+1A', HistVac."Fecha Inicio");
                    HistVac."Tipo calculo" := HistVac."Tipo calculo"::Adicional;
                    HistVac.Dias := DiasAdicionales[1];
                    IF HistVac.INSERT THEN;
                END
                ELSE
                    IF ((AnosEmpresa >= RangoAnos[2]) AND (AnosEmpresa < RangoAnos[3]) AND
                       (RangoAnos[2] > 0) AND (RangoAnos[3] > 0)) OR
                       ((AnosEmpresa >= RangoAnos[2]) AND (RangoAnos[2] > 0) AND (RangoAnos[3] = 0)) THEN BEGIN
                        HistVac.INIT;
                        HistVac."No. empleado" := Empleado."No.";
                        HistVac."Fecha Inicio" := DMY2DATE(DATE2DMY(Empleado."Employment Date", 1), DATE2DMY(Empleado."Employment Date", 2), DATE2DMY(PerInici, 3));
                        HistVac."Fecha Fin" := CALCDATE('+1A', HistVac."Fecha Inicio");
                        HistVac."Tipo calculo" := HistVac."Tipo calculo"::Adicional;
                        HistVac.Dias := DiasAdicionales[2];
                        IF HistVac.INSERT THEN;
                    END
                    ELSE
                        IF ((AnosEmpresa >= RangoAnos[3]) AND (AnosEmpresa < RangoAnos[4]) AND
                           (RangoAnos[3] > 0) AND (RangoAnos[4] > 0)) OR
                           ((AnosEmpresa >= RangoAnos[3]) AND (RangoAnos[3] > 0) AND (RangoAnos[4] = 0)) THEN BEGIN
                            HistVac.INIT;
                            HistVac."No. empleado" := Empleado."No.";
                            HistVac."Fecha Inicio" := DMY2DATE(DATE2DMY(Empleado."Employment Date", 1), DATE2DMY(Empleado."Employment Date", 2), DATE2DMY(PerInici, 3));
                            HistVac."Fecha Fin" := CALCDATE('+1A', HistVac."Fecha Inicio");
                            HistVac."Tipo calculo" := HistVac."Tipo calculo"::Adicional;
                            HistVac.Dias := DiasAdicionales[3];
                            IF HistVac.INSERT THEN;
                        END
                        ELSE
                            IF ((AnosEmpresa >= RangoAnos[4]) AND (AnosEmpresa < RangoAnos[5]) AND
                               (RangoAnos[4] > 0) AND (RangoAnos[5] > 0)) OR
                               ((AnosEmpresa >= RangoAnos[4]) AND (RangoAnos[4] > 0) AND (RangoAnos[5] = 0)) THEN BEGIN
                                HistVac.INIT;
                                HistVac."No. empleado" := Empleado."No.";
                                HistVac."Fecha Inicio" := DMY2DATE(DATE2DMY(Empleado."Employment Date", 1), DATE2DMY(Empleado."Employment Date", 2), DATE2DMY(PerInici, 3));
                                HistVac."Fecha Fin" := CALCDATE('+1A', HistVac."Fecha Inicio");
                                HistVac."Tipo calculo" := HistVac."Tipo calculo"::Adicional;
                                HistVac.Dias := DiasAdicionales[4];
                                IF HistVac.INSERT THEN;
                            END
                            ELSE
                                IF (AnosEmpresa >= RangoAnos[5]) AND (RangoAnos[5] > 0) THEN BEGIN
                                    HistVac.INIT;
                                    HistVac."No. empleado" := Empleado."No.";
                                    HistVac."Fecha Inicio" := DMY2DATE(DATE2DMY(Empleado."Employment Date", 1), DATE2DMY(Empleado."Employment Date", 2), DATE2DMY(PerInici, 3));
                                    HistVac."Fecha Fin" := CALCDATE('+1A', HistVac."Fecha Inicio");
                                    HistVac."Tipo calculo" := HistVac."Tipo calculo"::Adicional;
                                    HistVac.Dias := DiasAdicionales[5];
                                    IF HistVac.INSERT THEN;
                                END;
            END;
        END;
    end;

    procedure RegistraIncidencias()
    var
        Incidencias: Record 5207;
        MovNovedades: Record 34002114;
        CA: Record 5206;
    begin
        /*
        //Ingreso
        //Salida
        //Vacaciones
        //Licencia Voluntaria
        //Licencia Maternidad
        //Licencia x Discapacidad
        //Actualizacion de datos
        //Permiso de trabajo
        
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
            MovNovedades.Codigo := Empleado.Company;
            MovNovedades."ID Documento" := FORMAT(CabNomina.Periodo,0,'<Month,2><Year4>');
            CA.GET(Incidencias."Cause of Absence Code");
            MovNovedades."Editar salario" := CA."Tipo de Accion de personal";
            MovNovedades.VALIDATE("Editar cargo" ,Incidencias."From Date");
            MovNovedades.VALIDATE("disponible 1",Incidencias."To Date");
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

    local procedure EliminaCabecera()
    begin
        //GRN Elimino Cabecera de los empleados que no tengan ingresos o deducciones
        CabNomina.RESET;
        CabNomina.SETRANGE("No. empleado", GlobalRec."No. empleado");
        //CabNomina.SETRANGE("Tipo Nomina",GlobalRec."Tipo Nomina");
        CabNomina.SETRANGE("Tipo de nomina", CabNomina."Tipo de nomina");
        CabNomina.SETRANGE("Frecuencia de pago", Contrato."Frecuencia de pago");
        CabNomina.SETRANGE(Inicio, PerInici);
        CabNomina.SETRANGE(Fin, PerFinal);
        //ERROR('%1 %2',CABNOMINA.GETFILTERS,cabnomina."total ingresos");
        IF CabNomina.FINDFIRST THEN BEGIN
            CabNomina.CALCFIELDS("Total Ingresos");
            IF CabNomina."Total Ingresos" = 0 THEN BEGIN
                /*
                DfltDimension.RESET;
                DfltDimension.SETRANGE("Table ID",5200);
                DfltDimension.SETRANGE("No.",GlobalRec."No. empleado");
                IF DfltDimension.FINDSET(TRUE,FALSE) THEN
                   REPEAT
                    DfltDimension.DELETE;
                   UNTIL DfltDimension.NEXT = 0;
                */
                CabNomina.DELETE();
            END;
        END;

    end;

    procedure CalculaNominaProy(CodEmpleado: Code[20]; CodProy: Code[20]; FechaDesde: Date; FechaHasta: Date) CalcularNom: Boolean
    var
        DCA: Record 34002163;
        PerfSal: Record 34002115;
        Text001: Label 'Processing  #1########## @2@@@@@@@@@@@@@';
        Contrato: Record 34002109;
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
        Text002: Label 'All pending records have been processed, please check the data on employees';
        HorReg: Decimal;
        Hor35: Decimal;
        Hor100: Decimal;
        HorFer: Decimal;
        HorNoc: Decimal;
        PagarDieta: Boolean;
        PagarTransporte: Boolean;
        DiasTransporte: Decimal;
    begin
        //Buscamos la configuracion

        /*GRN Se va a realizar por el reporte, solo se procesa aqui la Dieta
        //Verificamos que los conceptos esten configurados
        ConfNominas.TESTFIELD("Concepto Horas Ext. 100%");
        ConfNominas.TESTFIELD("Concepto Horas Ext. 35%");
        ConfNominas.TESTFIELD("Concepto Horas nocturnas");
        ConfNominas.TESTFIELD("Concepto Dias feriados");
        ConfNominas.TESTFIELD("Concepto Sal. Base");
        
        //Leemos la tabla de Distribucion control de asistencia y la de distribucion para calcular el pago por concepto
        Hor100 := 0;
        Hor35  := 0;
        HorFer := 0;
        HorNoc := 0;
        HorReg := 0;
        */

        /*GRN Desde aqui
        //PagarTransporte := Empleado."Incluir pago transporte";
        DiasTransporte := 0;
        
        Contrato.RESET;
        Contrato.SETRANGE("No. empleado",CodEmpleado);
        Contrato.SETRANGE(Activo,TRUE);
        Contrato.SETRANGE("Frecuencia de pago",Contrato."Frecuencia de pago"::"Bi-Semanal");
        IF NOT Contrato.FINDFIRST THEN
           EXIT(FALSE);
        
        ConfNominas.GET();
        ConfNominas.TESTFIELD("Concepto Dieta");
        
        PerfilSal.RESET;
        PerfilSal.SETRANGE("Concepto salarial",ConfNominas."Concepto Dieta");
        PerfilSal.SETRANGE("No. empleado",CodEmpleado);
        IF NOT PerfilSal.FINDFIRST THEN
           EXIT(FALSE);
        
        PerfilSal.Cantidad := 0;
        PerfilSal.MODIFY;
        
        DCA.RESET;
        DCA.SETRANGE("Cod. Empleado",CodEmpleado);
        DCA.SETRANGE("Concepto Salarial",FechaDesde,FechaHasta);
        DCA.SETRANGE("Job No.",CodProy);
        IF DCA.FINDSET THEN
          REPEAT
          //Elimino los valores de la Dieta
        
           PagarDieta := FALSE;
        
            //Para distribuir la Dieta. Se hace por dia, si pasa de 4.5 horas regulares, o es sabado o es feriado, entonces
            IF DCA."Horas feriadas" + DCA."Horas regulares" + DCA."Horas extras al 100" + DCA."Horas extras al 35" + DCA."Horas nocturnas" >  4.5  THEN
               PagarDieta := TRUE;
        
            //ERROR('a %1',PagarDieta);
        
            IF (PagarDieta) AND (NOT Empleado."Calcular dieta por dia") THEN
               BEGIN
                ConfNominas.TESTFIELD("Concepto Dieta");
                PerfilSal.RESET;
                PerfilSal.SETRANGE("Concepto salarial",ConfNominas."Concepto Dieta");
                PerfilSal.SETRANGE("No. empleado",DCA."Cod. Empleado");
                PerfilSal.FINDFIRST;
                PerfilSal.Cantidad += 1;
                //El precio lo tiene el empleado PerfilSal.Importe := ;
                PerfilSal.MODIFY;
               END
            ELSE
            IF Empleado."Calcular dieta por dia" THEN
               BEGIN
                ConfNominas.TESTFIELD("Concepto Dieta");
                PerfilSal.RESET;
                PerfilSal.SETRANGE("Concepto salarial",ConfNominas."Concepto Dieta");
                PerfilSal.SETRANGE("No. empleado",DCA."Cod. Empleado");
                PerfilSal.FINDFIRST;
                PerfilSal.Cantidad += 1;
                //El precio lo tiene el empleado PerfilSal.Importe := ;
                PerfilSal.MODIFY;
               END;
            IF PagarTransporte THEN
               DiasTransporte += 1;
          UNTIL DCA.NEXT = 0
        ELSE
          EXIT(FALSE);
        
        
        IF PagarTransporte AND (DiasTransporte <> 0 ) THEN
           BEGIN
            ConfNominas.TESTFIELD("Concepto Transporte");
            PerfilSal.RESET;
            PerfilSal.SETRANGE("Concepto salarial",ConfNominas."Concepto Transporte");
            PerfilSal.SETRANGE("No. empleado",DCA."Cod. Empleado");
            PerfilSal.FINDFIRST;
            PerfilSal.Cantidad := DiasTransporte;
            //El precio lo tiene el empleado  ;
            PerfilSal.MODIFY;
        
           END;
        
        EXIT(TRUE);
        */

    end;

    local procedure VerificaRetroactivo()
    var
        HLN: Record 34002118;
        PerfilSalario: Record 34002115;
        DiasRetroactivo: Decimal;
    begin
        IF Empleado."Employment Date" < CALCDATE('-1M', PerFinal) THEN
            EXIT;
        IF Empleado."Employment Date" > CALCDATE('-' + FORMAT(ConfNominas."Dias para corte nominas"), PerFinal) THEN
            EXIT;
        IF Empleado."Employment Date" >= PerInici THEN
            EXIT;


        HLN.RESET;
        HLN.SETRANGE("No. empleado", GlobalRec."No. empleado");
        HLN.SETRANGE(Periodo, PerInici);
        HLN.SETRANGE("Concepto salarial", ConfNominas."Concepto Retroactivo");
        IF HLN.FINDFIRST THEN
            EXIT;

        HLN.RESET;
        HLN.SETRANGE("No. empleado", GlobalRec."No. empleado");
        HLN.SETFILTER(Periodo, '<%1', PerInici);
        IF NOT HLN.FINDFIRST THEN BEGIN
            DiasRetroactivo := PerInici - Empleado."Employment Date";
            Fecha.RESET;
            Fecha.SETRANGE("Period Type", 0); //Dia
            Fecha.SETRANGE("Period Start", Empleado."Employment Date", PerInici);
            Fecha.SETRANGE("Period No.", 6, 7);//Sabado y Domingo
            IF Fecha.FINDSET THEN
                REPEAT
                    CASE Fecha."Period No." OF
                        6:
                            DiasRetroactivo -= 0.5;
                        7:
                            DiasRetroactivo -= 1;
                    END;
                UNTIL Fecha.NEXT = 0;

            PerfilSalario.RESET;
            PerfilSalario.SETRANGE("No. empleado", GlobalRec."No. empleado");
            PerfilSalario.SETRANGE("Concepto salarial", ConfNominas."Concepto Retroactivo");
            PerfilSalario.FINDFIRST;
            IF Empleado."Tipo pago" = Empleado."Tipo pago"::"Sueldo fijo" THEN
                PerfilSalario.Importe := Empleado.Salario / 23.83;

            PerfilSalario.VALIDATE(Cantidad, DiasRetroactivo);
            PerfilSalario.Comentario := STRSUBSTNO(Text001, FORMAT(DiasRetroactivo));
            ImporteTotal := PerfilSalario.Cantidad * PerfilSalario.Importe;
            LinTabla += 1000;
            InsertNomina(PerfilSalario);
        END;
    end;

    local procedure CalculoPrestaciones()
    var
        PerfilSalLiq: Record 34002115;
        PerfilSalLiq2: Record 34002115;
        HistLinNom: Record 34002118;
        MontoRegalia: Decimal;
        MontoVacaciones: Decimal;
        CantNom: Decimal;
    begin
        //CalculoPrestaciones
        CantNom := 0;
        LinTabla := 1000;

        FechaIniDT := CREATEDATETIME(Empleado."Employment Date", 0T);
        FechaFinDT := CREATEDATETIME(Contrato."Fecha finalizacion", 0T);

        FuncionesNom.CalculoEntreFechas(Empleado."Employment Date", Contrato."Fecha finalizacion", Anos, Meses, Dias);
        //BuscaSalarioPromedio;
        PerfilSal.RESET;
        PerfilSal.SETRANGE("No. empleado", Empleado."No.");
        PerfilSal.SETRANGE("Tipo concepto", PerfilSal."Tipo concepto"::Ingresos);
        //PerfilSal.SETRANGE("Concepto salarial",ConfNominas."Concepto Sal. Base");
        PerfilSal.SETRANGE("Salario Base", TRUE);
        PerfilSal.FINDSET;
        REPEAT
            Salario += PerfilSal.Importe;
        UNTIL PerfilSal.NEXT = 0;

        HistLinNom.RESET;
        HistLinNom.SETRANGE("No. empleado", Empleado."No.");
        HistLinNom.SETRANGE(Periodo, CALCDATE('-1' + CDateSymbol, DMY2DATE(1, DATE2DMY(Contrato."Fecha finalizacion", 2), DATE2DMY(Contrato."Fecha finalizacion", 3))),
                                    Empleado."Termination Date");
        HistLinNom.SETRANGE("Salario Base", TRUE);
        IF HistLinNom.FINDSET THEN
            REPEAT
                PromedioSalarioAnual += HistLinNom.Total;
                IF HistLinNom."Concepto salarial" = ConfNominas."Concepto Sal. Base" THEN
                    CantNom += 1;
            UNTIL HistLinNom.NEXT = 0;

        IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) OR
           (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::"Bi-Semanal") THEN
            CantNom /= 2
        ELSE
            IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Semanal) THEN
                CantNom /= 52;

        ImporteTotal := 0;
        //Ingresos que no son salarios
        PerfilSal.RESET;
        PerfilSal.SETRANGE("No. empleado", Empleado."No.");
        PerfilSal.SETRANGE("Tipo concepto", PerfilSal."Tipo concepto"::Ingresos);
        //PerfilSal.SETRANGE("Concepto salarial",ConfNominas."Concepto Sal. Base");
        PerfilSal.SETRANGE("Tipo concepto", PerfilSal."Tipo concepto"::Ingresos);
        PerfilSal.SETFILTER(Cantidad, '<>%1', 0);
        PerfilSal.SETFILTER(Importe, '<>%1', 0);
        PerfilSal.SETRANGE("Salario Base", FALSE);
        IF PerfilSal.FINDSET THEN
            REPEAT
                LinTabla += 1000;
                IF (STRPOS(PerfilSal."Concepto salarial", ConfNominas."Concepto Cesantia") = 0) AND
                   (STRPOS(PerfilSal."Concepto salarial", ConfNominas."Concepto Preaviso") = 0) AND
                   (STRPOS(PerfilSal."Concepto salarial", ConfNominas."Concepto Regalia") = 0) AND
                   (STRPOS(PerfilSal."Concepto salarial", ConfNominas."Concepto Vacaciones") = 0) THEN BEGIN
                    PerfilSalLiq.RESET;
                    PerfilSalLiq.SETRANGE("No. empleado", Empleado."No.");
                    PerfilSalLiq.SETRANGE("Concepto salarial", PerfilSal."Concepto salarial");
                    PerfilSalLiq.FINDFIRST;
                    PerfilSalLiq.VALIDATE(Cantidad, PerfilSal.Cantidad);
                    PerfilSalLiq.VALIDATE(Importe, PerfilSal.Importe);
                    PerfilSalLiq."Tipo de nomina" := GlobalRec."Tipo de nomina";
                    ImporteTotal := PerfilSal.Importe * PerfilSal.Cantidad;
                    //PerfilSalLiq.MODIFY(TRUE);
                    InsertNomina(PerfilSalLiq);
                END;
            UNTIL PerfilSal.NEXT = 0;

        PromedioSalarioMensual := PromedioSalarioAnual / CantNom;

        IF DATE2DMY(Contrato."Fecha finalizacion", 2) <> 1 THEN BEGIN
            HistLinNom.RESET;
            HistLinNom.SETRANGE("No. empleado", Empleado."No.");
            HistLinNom.SETRANGE(Periodo, DMY2DATE(1, 1, DATE2DMY(Contrato."Fecha finalizacion", 3)),
                                        Contrato."Fecha finalizacion");
            HistLinNom.SETRANGE("Aplica para Regalia", TRUE);
            IF HistLinNom.FINDSET THEN
                REPEAT
                    MontoRegalia += HistLinNom.Total;
                UNTIL HistLinNom.NEXT = 0;

            MontoRegalia := MontoRegalia / 12;
        END;
        //MESSAGE('%1 %2 %3',PromedioSalarioMensual,PromedioSalarioAnual);
        PromedioSalarioDiario := PromedioSalarioMensual / 23.83;

        PerfilSalLiq2.RESET;
        PerfilSalLiq2.SETRANGE("No. empleado", Empleado."No.");
        PerfilSalLiq2.SETRANGE("Concepto salarial", ConfNominas."Concepto Cesantia");
        IF NOT PerfilSalLiq2.FINDFIRST THEN BEGIN
            PerfilSalLiq.INIT;
            PerfilSalLiq.VALIDATE("No. empleado", Empleado."No.");
            PerfilSalLiq.VALIDATE("Concepto salarial", ConfNominas."Concepto Cesantia");
            PerfilSalLiq."Tipo de nomina" := GlobalRec."Tipo de nomina";
            PerfilSalLiq.INSERT(TRUE);
        END;

        PerfilSalLiq2.RESET;
        PerfilSalLiq2.SETRANGE("No. empleado", Empleado."No.");
        PerfilSalLiq2.SETRANGE("Concepto salarial", ConfNominas."Concepto Preaviso");
        IF NOT PerfilSalLiq2.FINDFIRST THEN BEGIN
            PerfilSalLiq.INIT;
            PerfilSalLiq.VALIDATE("No. empleado", Empleado."No.");
            PerfilSalLiq.VALIDATE("Concepto salarial", ConfNominas."Concepto Preaviso");
            PerfilSalLiq."Tipo de nomina" := GlobalRec."Tipo de nomina";
            PerfilSalLiq.INSERT(TRUE);
        END;

        //Inserto Preaviso
        IF Contrato."Pagar preaviso" THEN BEGIN
            ImporteTotal := 0;
            LinTabla += 1000;
            CalculoPreaviso(MontoPreaviso);
            PerfilSalLiq.RESET;
            PerfilSalLiq.SETRANGE("No. empleado", Empleado."No.");
            PerfilSalLiq.SETRANGE("Concepto salarial", ConfNominas."Concepto Preaviso");
            PerfilSalLiq.FINDFIRST;
            PerfilSalLiq.VALIDATE(Cantidad, DiasPreaviso);
            PerfilSalLiq.VALIDATE(Importe, PromedioSalarioDiario);
            PerfilSalLiq."Tipo de nomina" := GlobalRec."Tipo de nomina";
            ImporteTotal := MontoPreaviso;
            PerfilSalLiq.MODIFY(TRUE);
            InsertNomina(PerfilSalLiq);
        END;

        //Inserto Cesantia
        IF Contrato."Pagar cesantia" THEN BEGIN
            ImporteTotal := 0;
            LinTabla += 1000;
            CalculoCesantia(MontoCesantia);
            PerfilSalLiq.RESET;
            PerfilSalLiq.SETRANGE("No. empleado", Empleado."No.");
            PerfilSalLiq.SETRANGE("Concepto salarial", ConfNominas."Concepto Cesantia");
            PerfilSalLiq.FINDFIRST;
            PerfilSalLiq.VALIDATE(Cantidad, DiasCesantia);
            PerfilSalLiq.VALIDATE(Importe, PromedioSalarioDiario);
            PerfilSalLiq."Tipo de nomina" := GlobalRec."Tipo de nomina";
            ImporteTotal := MontoCesantia;
            PerfilSalLiq.MODIFY(TRUE);
            InsertNomina(PerfilSalLiq);
        END;

        //CalculoVacaciones(MontoVacaciones);

        //Calculo los dias de salario que le faltan
        LinTabla += 1000;
        CompletivoUltSalarioNom(MontoRestante);
        //ERROR('%1 %2',Empleado."No.",MontoRegalia);
        PerfilSalLiq.RESET;
        PerfilSalLiq.SETRANGE("No. empleado", Empleado."No.");
        PerfilSalLiq.SETRANGE("Concepto salarial", ConfNominas."Concepto Sal. Base");
        PerfilSalLiq.FINDFIRST;

        PerfilSalLiq.Cantidad := DiasSalario;
        PerfilSalLiq.Importe := PromedioSalarioDiario;
        PerfilSalLiq."Tipo de nomina" := GlobalRec."Tipo de nomina";
        ImporteTotal := MontoRestante;
        //PerfilSalLiq.MODIFY(TRUE);
        InsertNomina(PerfilSalLiq);

        //Pago de regalia
        LinTabla += 1000;
        CalculoRegaliaPrest(MontoRegalia);
        //ERROR('%1 %2',Empleado."No.",MontoRegalia);
        PerfilSalLiq.RESET;
        PerfilSalLiq.SETRANGE("No. empleado", Empleado."No.");
        PerfilSalLiq.SETRANGE("Concepto salarial", ConfNominas."Concepto Regalia");
        PerfilSalLiq.FINDFIRST;
        PerfilSalLiq.VALIDATE(Cantidad, 1);
        PerfilSalLiq.VALIDATE(Importe, MontoRegalia);
        PerfilSalLiq."Tipo de nomina" := GlobalRec."Tipo de nomina";
        ImporteTotal := MontoRegalia;
        PerfilSalLiq.MODIFY(TRUE);
        InsertNomina(PerfilSalLiq);

        //Pago de vacaciones  REVISAR CONF PRIMA Y VACACIONES
        ImporteTotal := 0;
        LinTabla += 1000;
        PerfilSalLiq.RESET;
        PerfilSalLiq.SETRANGE("No. empleado", Empleado."No.");
        PerfilSalLiq.SETRANGE("Concepto salarial", ConfNominas."Concepto Vacaciones");
        PerfilSalLiq.FINDFIRST;
        PerfilSalLiq."Tipo de nomina" := GlobalRec."Tipo de nomina";
        ImporteTotal := PerfilSalLiq.Cantidad * PerfilSalLiq.Importe;
        //PerfilSalLiq.MODIFY(TRUE);
        InsertNomina(PerfilSalLiq);


        CalcularDtosLegalesLiq;

        /*
          MontoCalculoGral := ROUND((MontoPreaviso + MontoCesantia + MontoRegalia + MontoVacaciones + MontoRestante),
                                     ConfCG."Amount Rounding Precision");
        */

    end;

    procedure CalculoPreaviso(var MontoPreaviso: Decimal)
    var
        FechaCalculo: Date;
        CantidadAnos: Integer;
    begin
        DiasPreaviso := 0;

        IF Anos = 0 THEN
            IF Meses > 0 THEN BEGIN
                IF (Meses >= 3) AND (Meses < 6) THEN
                    DiasPreaviso := 7
                ELSE
                    IF (Meses >= 6) AND (Meses < 12) THEN
                        DiasPreaviso := 14
                    ELSE
                        IF Meses = 12 THEN
                            DiasPreaviso := 28;
            END
            ELSE
                IF Anos > 0 THEN
                    DiasPreaviso := 28
                ELSE
                    EXIT
        ELSE
            DiasPreaviso := 28;

        MontoPreaviso := PromedioSalarioDiario * DiasPreaviso;
    end;

    procedure CalculoCesantia("LMontoCesantia": Decimal)
    var
        Anos: Integer;
        Meses: Integer;
        Dias: Integer;
        SalidaCesantia: Decimal;
    begin
        DiasCesantia := 0;

        FuncionesNom.CalculoEntreFechas(Empleado."Employment Date", Empleado."Termination Date", Anos, Meses, Dias);

        IF Anos = 0 THEN
            IF Meses > 0 THEN BEGIN
                IF (Meses >= 3) AND (Meses < 6) THEN
                    DiasCesantia := 6
                ELSE
                    IF Meses >= 6 THEN
                        DiasCesantia := 13;
            END
            ELSE
                EXIT
        ELSE
            IF (Anos >= 1) AND (Anos < 5) THEN BEGIN
                DiasCesantia := 21 * Anos;

                IF ((Meses >= 3) AND ((Meses <= 6) AND (Dias = 0))) OR
                   ((Meses >= 3) AND (Meses < 6)) THEN
                    DiasCesantia += 6
                ELSE
                    IF (Meses >= 6) AND (Dias > 0) THEN
                        DiasCesantia += 13;
            END
            ELSE
                IF Anos >= 5 THEN BEGIN
                    IF Empleado."Employment Date" < DMY2DATE(29, 5, 92) THEN
                        DiasCesantia := 15 * Anos
                    ELSE
                        DiasCesantia := 23 * Anos;

                    IF (Meses >= 3) AND (Meses <= 6) THEN
                        DiasCesantia += 6
                    ELSE
                        IF Meses >= 7 THEN
                            DiasCesantia += 13;
                END;

        //SalidaCesantia := FORMAT(ROUND(PromedioSalarioDiario * DiasCesantia,0.01));
        MontoCesantia := PromedioSalarioDiario * DiasCesantia;
    end;

    procedure CalculoVacaciones(var MontoVacaciones: Decimal)
    var
        Anos: Integer;
        Meses: Integer;
        Dias: Integer;
        DiasVacaciones: Integer;
    begin
        //Vacaciones
        /*
        DiasVacaciones := 0;
        
        funcionesnom.CálculoEntreFechas(empleado."Employment Date", empleado."Termination Date",Anos, Meses, Dias);
        DiasVacaciones := funcionesnom.CalculoDiaVacaciones(empleado."No.",MesTrabajo,AnoTrabajo,MontoVacaciones,empleado."Employment Date",PerFinal);
        
        PromedioSalarioDiarioVac := "Perfil Salarial".Importe / 23.83;
        MontoVacaciones          := PromedioSalarioDiarioVac * DiasVacaciones;
        */

    end;

    procedure CalculoRegaliaPrest(var MontoRegalia: Decimal)
    var
        Anos: Integer;
        Meses: Integer;
        Dias: Integer;
        FechaIni: Date;
        AcumuladoRegalia: Decimal;
        PerfilSalLiq: Record 34002115;
    begin
        //Regalia
        AcumuladoRegalia := 0;
        TipoNomina.RESET;
        TipoNomina.SETRANGE("Tipo de nomina", TipoNomina."Tipo de nomina"::Regular);
        TipoNomina.SETRANGE("Frecuencia de pago", Contrato."Frecuencia de pago");
        TipoNomina.FINDFIRST;

        LinNomina.RESET;
        LinNomina.SETRANGE("No. empleado", Empleado."No.");
        IF (TipoNomina."Dia inicio 1ra" > TipoNomina."Dia inicio 2da") THEN
            LinNomina.SETRANGE(Periodo, DMY2DATE(TipoNomina."Dia inicio 1ra", 12, DATE2DMY(CALCDATE('-12M', PerInici), 3)), PerFinal)
        ELSE
            LinNomina.SETRANGE(Periodo, PerInici, PerFinal);

        LinNomina.SETRANGE("Aplica para Regalia", TRUE);
        IF LinNomina.FINDSET THEN
            REPEAT
                AcumuladoRegalia += LinNomina.Total;
            UNTIL LinNomina.NEXT = 0;
        MontoRegalia := AcumuladoRegalia / 12;
    end;

    procedure CalcularDescuentosPrest()
    var
        PerfilSalRet: Record 34002115;
    begin
        PerfilSalRet.RESET;
        PerfilSalRet.SETRANGE("No. empleado", GlobalRec."No. empleado");
        PerfilSalRet.SETRANGE("Tipo concepto", PerfilSalRet."Tipo concepto"::Deducciones);
        PerfilSalRet.SETFILTER(Cantidad, '<>%1', 0);
        PerfilSalRet.SETFILTER(Importe, '<>%1', 0);
        IF PerfilSalRet.FINDSET THEN
            REPEAT
                ImporteTotal := PerfilSalRet.Cantidad * PerfilSalRet.Importe * -1;
                LinTabla += 10;
                PerfilSalRet."Tipo de nomina" := GlobalRec."Tipo de nomina";
                InsertNomina(PerfilSalRet);
            UNTIL PerfilSalRet.NEXT = 0;
    end;

    procedure BuscaSalarioPromedio()
    var
        Periodo: array[12] of Decimal;
        Salarios: array[12] of Decimal;
        TotalTiempoTrabajado: Decimal;
        TotalPeriodo: Decimal;
        M: Integer;
        N: Integer;
        UltimoSalario: Decimal;
        ImporteSueldoAcumulado: Decimal;
    begin
        //Salario Promedio
        PerfilSal.SETRANGE("No. empleado", Empleado."No.");
        PerfilSal.SETRANGE("Tipo concepto", PerfilSal."Tipo concepto"::Ingresos);
        PerfilSal.SETRANGE("Concepto salarial", ConfNominas."Concepto Sal. Base");
        IF PerfilSal.FINDFIRST THEN
            UltimoSalario := PerfilSal.Importe;

        PerfilSal.SETRANGE("No. empleado", Empleado."No.");
        PerfilSal.SETRANGE("Tipo concepto", PerfilSal."Tipo concepto"::Ingresos);
        PerfilSal.SETFILTER("Concepto salarial", '<>%1', ConfNominas."Concepto Sal. Base");
        PerfilSal.SETRANGE("Salario Base", TRUE);
        IF PerfilSal.FINDSET THEN
            REPEAT
                UltimoSalario += PerfilSal.Importe;
            UNTIL PerfilSal.NEXT = 0;
        CLEAR(Periodo);
        CLEAR(Salarios);
        M := 0;
        N := 0;
        PromedioSalarioAnual := 0;
        PromedioSalarioMensual := UltimoSalario;
        PromedioSalarioDiario := 0;
        TotalPeriodo := 0;

        LinNomina.RESET;
        LinNomina.SETRANGE("No. empleado", Empleado."No.");
        LinNomina.SETRANGE(Periodo, CALCDATE('-1' + CDateSymbol, DMY2DATE(1, DATE2DMY(Empleado."Termination Date", 2), DATE2DMY(Empleado."Termination Date", 3))),
                                    Empleado."Termination Date");
        LinNomina.SETRANGE("Salario Base", TRUE);
        IF LinNomina.FINDSET THEN
            REPEAT
                PromedioSalarioAnual += LinNomina.Total;
                ImporteSueldoAcumulado += LinNomina.Total;
            UNTIL LinNomina.NEXT = 0;
        /*
        IF ImporteSueldoAcumulado <> 0 THEN
          BEGIN
            PromedioSalarioAnual     := ImporteSueldoAcumulado;
            PromedioSalarioMensual   := ImporteSueldoAcumulado / 12;
            PromedioSalarioDRegalia  := ImporteSueldoAcumulado / 12;
            PromedioSalarioDiario    := PromedioSalarioMensual / 23.83;
          END
        ELSE
          BEGIN
            PromedioSalarioAnual     := UltimoSalario;
            PromedioSalarioMensual   := UltimoSalario;
            PromedioSalarioDRegalia  := UltimoSalario / 12;
            PromedioSalarioDiario    := PromedioSalarioMensual / 23.83;
            PromedioSalarioAnual     := ImporteSueldoAcumulado;
          END;
        */

    end;

    procedure CompletivoUltSalarioNom(var completivoultsalarionomina: Decimal)
    begin
        MontoRestante := 0;
        TipoNomina.RESET;
        TipoNomina.SETRANGE("Tipo de nomina", TipoNomina."Tipo de nomina"::Regular);
        TipoNomina.SETRANGE("Frecuencia de pago", Contrato."Frecuencia de pago");
        TipoNomina.FINDFIRST;

        LinNomina.RESET;
        LinNomina.SETRANGE("No. empleado", Empleado."No.");
        LinNomina.SETRANGE("Tipo de nomina", TipoNomina.Codigo);
        LinNomina.FINDLAST;
        IF LinNomina."Fin periodo" > Contrato."Fecha finalizacion" THEN
            EXIT;

        Fecha.RESET;
        Fecha.SETRANGE("Period Type", 0); //Dia

        IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal THEN BEGIN
            IF TipoNomina."Dia inicio 1ra" > TipoNomina."Dia inicio 2da" THEN BEGIN
                IF (Contrato."Fecha finalizacion" >= DMY2DATE(TipoNomina."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3))) AND
                   (Contrato."Fecha finalizacion" < DMY2DATE(TipoNomina."Dia inicio 2da" - 1, DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3))) THEN BEGIN
                    DiasSalario := Contrato."Fecha finalizacion" - DMY2DATE(TipoNomina."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)) + 1;
                    Fecha.SETRANGE("Period Start", DMY2DATE(TipoNomina."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), Contrato."Fecha finalizacion")
                END
                ELSE
                    IF (Contrato."Fecha finalizacion" >= DMY2DATE(TipoNomina."Dia inicio 2da", DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3))) THEN BEGIN
                        DiasSalario := Contrato."Fecha finalizacion" - DMY2DATE(TipoNomina."Dia inicio 2da", DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)) + 1;
                        Fecha.SETRANGE("Period Start", DMY2DATE(TipoNomina."Dia inicio 2da", DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)), Contrato."Fecha finalizacion");
                    END
                    ELSE
                        IF (Contrato."Fecha finalizacion" <= DMY2DATE(TipoNomina."Dia inicio 2da" - 1, DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3))) THEN BEGIN
                            DiasSalario := Contrato."Fecha finalizacion" - DMY2DATE(TipoNomina."Dia inicio 1ra", DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)) + 1;
                            Fecha.SETRANGE("Period Start", DMY2DATE(TipoNomina."Dia inicio 1ra", DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)), Contrato."Fecha finalizacion")
                        END;
            END
            ELSE BEGIN
                DiasSalario := Contrato."Fecha finalizacion" - PerInici + 1;
                Fecha.SETRANGE("Period Start", DMY2DATE(TipoNomina."Dia inicio 1ra", DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)), Contrato."Fecha finalizacion");
            END;
        END
        ELSE
            DiasSalario := Contrato."Fecha finalizacion" - PerInici + 1;

        Fecha.SETRANGE("Period No.", 6, 7);//Sabado y Domingo
        IF Fecha.FINDSET THEN
            REPEAT
                CASE Fecha."Period No." OF
                    6:
                        DiasSalario -= 0.5;
                    7:
                        DiasSalario -= 1;
                END;
            UNTIL Fecha.NEXT = 0;
        //ERROR('%1\ %2 %3',Fecha.GETFILTERS,DiasSalario);
        IF DiasSalario < 0 THEN
            DiasSalario := 0;
        MontoRestante := ROUND(Salario / 23.83 * DiasSalario, 0.01);
    end;

    procedure CalcularDtosLegalesLiq()
    var
        LinNominasES: Record 34002118;
        DeduccGob: Record 34002129;
        CabAportesEmpresa: Record 34002121;
        LinAportesEmpresa: Record 34002122;
        LinAportesEmpresa2: Record 34002122;
        PerfilSalTr: Record 34002115;
        TiposNomPrest: Record 34002158;
        NoLin: Integer;
        MontoAplicar: Decimal;
        IndSkip: Boolean;
        ImporteCotizacion2: Decimal;
        ImporteImpuestos: Decimal;
        ImporteImpuestosemp: Decimal;
        ImporteCotizacionEmp: Decimal;
    begin
        TiposNomPrest.SETRANGE("Tipo de nomina", TiposNomPrest."Tipo de nomina"::Regular);
        TiposNomPrest.FINDFIRST;

        DeduccGob.RESET;
        DeduccGob.SETRANGE(Ano, Ano);
        DeduccGob.FINDSET(FALSE, FALSE);
        REPEAT
            IndSkip := FALSE;
            IF Empleado."Excluido Cotizacion TSS" THEN BEGIN
                IF (DeduccGob.Codigo = ConfNominas."Concepto AFP") OR (DeduccGob.Codigo = ConfNominas."Concepto SFS") OR
                   (DeduccGob.Codigo = ConfNominas."Concepto SRL") THEN
                    IndSkip := TRUE;
            END;

            ImporteCotizacion := 0;
            ImporteCotizacionEmp := 0;
            Importecotizacionmes := 0;

            PerfilSalTr.RESET;
            PerfilSalTr.SETRANGE("No. empleado", GlobalRec."No. empleado");
            PerfilSalTr.SETRANGE("Concepto salarial", DeduccGob.Codigo);
            PerfilSalTr.FINDFIRST;
            PerfilSalTr."Tipo de nomina" := GlobalRec."Tipo de nomina";

            LinNominasES.RESET;
            LinNominasES.SETRANGE("No. empleado", GlobalRec."No. empleado");
            //    LinNominasES.SETRANGE("Tipo de nomina",GlobalRec."Tipo de nomina");

            IF (DATE2DMY(PerInici, 1) <> 1) AND (DATE2DMY(PerInici, 2) = 1) THEN
                LinNominasES.SETRANGE("Fin periodo", DMY2DATE(DATE2DMY(PerInici, 1), DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), DMY2DATE(31, 12, DATE2DMY(PerFinal, 3)))
            ELSE
                IF (DATE2DMY(PerInici, 1) <> 1) AND (DATE2DMY(PerFinal, 2) <> 1) THEN
                    LinNominasES.SETRANGE("Fin periodo", DMY2DATE(TiposNomPrest."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerFinal), 2), DATE2DMY(PerFinal, 3)), DMY2DATE(31, 12, DATE2DMY(PerFinal, 3)))
                ELSE
                    LinNominasES.SETRANGE("Fin periodo", DMY2DATE(1, 1, DATE2DMY(PerInici, 3)), DMY2DATE(31, 12, DATE2DMY(PerFinal, 3)));
            //ERROR('%1',LinNominases.GETFILTERS);
            IF ConfNominas."Concepto AFP" = DeduccGob.Codigo THEN
                LinNominasES.SETRANGE("Cotiza AFP", TRUE)
            ELSE
                /*IF ConfNominas."Concepto INFOTEP" = DeduccGob.Codigo THEN
                    BEGIN
                    LinNominasES.SETRANGE("Cotiza Infotep",TRUE);
                    IF TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Bonificacion THEN
                        BEGIN
                        DeduccGob."Porciento Empresa"   /= 2;
                        DeduccGob."Porciento Empleado"  := DeduccGob."Porciento Empresa";
                        END;
                    END
                ELSE*/
                IF ConfNominas."Concepto SRL" = DeduccGob.Codigo THEN
                    LinNominasES.SETRANGE("Cotiza SRL", TRUE)
                ELSE
                    IF ConfNominas."Concepto SFS" = DeduccGob.Codigo THEN
                        LinNominasES.SETRANGE("Cotiza SFS", TRUE);

            IF LinNominasES.FINDSET(FALSE, FALSE) THEN
                REPEAT
                    IF (NOT Empleado."Excluido Cotizacion TSS") AND (LinNominasES."Cotiza SFS" OR LinNominasES."Cotiza AFP") THEN BEGIN
                        ImporteCotizacion += LinNominasES.Total;
                        ImporteCotizacionEmp += LinNominasES.Total;
                    END
                    ELSE
                        IF (LinNominasES."Cotiza SRL" OR (LinNominasES."Cotiza Infotep")) THEN BEGIN
                            ImporteCotizacion += LinNominasES.Total;
                            ImporteCotizacionEmp += LinNominasES.Total;
                        END;
                UNTIL LinNominasES.NEXT = 0;

            ImporteImpuestos := 0;

            IF (ImporteCotizacion > DeduccGob."Tope Salarial/Acumulado Anual") AND (DeduccGob."Tope Salarial/Acumulado Anual" <> 0) AND
               (DeduccGob."Porciento Empleado" <> 0) THEN BEGIN
                ImporteCotizacion := DeduccGob."Tope Salarial/Acumulado Anual";
                MontoAplicar := ImporteCotizacion * DeduccGob."Porciento Empleado" / 100;
                IF ABS(ImporteImpuestos) >= MontoAplicar THEN
                    IndSkip := TRUE;
            END;

            IF (ImporteCotizacion > DeduccGob."Tope Salarial/Acumulado Anual") AND (DeduccGob."Tope Salarial/Acumulado Anual" <> 0) THEN
                ImporteCotizacion := DeduccGob."Tope Salarial/Acumulado Anual";

            //Employee
            IF DeduccGob."Porciento Empleado" <> 0 THEN BEGIN
                MontoAplicar := (ImporteCotizacion * DeduccGob."Porciento Empleado" / 100) + ImporteImpuestos;

                IF ConfNominas."Concepto SFS" = DeduccGob.Codigo THEN BEGIN
                    SFSMes := Importecotizacionmes * DeduccGob."Porciento Empleado" / 100;
                    TSSSueldo += TSSSueldo * DeduccGob."Porciento Empleado" / 100;
                    TSSOtros += TSSOtros * DeduccGob."Porciento Empleado" / 100;
                END
                ELSE
                    IF ConfNominas."Concepto AFP" = DeduccGob.Codigo THEN BEGIN
                        AFPMes := Importecotizacionmes * DeduccGob."Porciento Empleado" / 100;
                        TSSSueldo += TSSSueldo * DeduccGob."Porciento Empleado" / 100;
                        TSSOtros += TSSOtros * DeduccGob."Porciento Empleado" / 100;
                    END;
                //IDC Fin

                IF (ImporteCotizacion >= DeduccGob."Tope Salarial/Acumulado Anual") AND
                   (DeduccGob."Tope Salarial/Acumulado Anual" <> 0) THEN BEGIN
                    ImporteCotizacion := DeduccGob."Tope Salarial/Acumulado Anual";
                    ImporteCotizacionEmp := ImporteCotizacion;
                    MontoAplicar := ImporteCotizacion * DeduccGob."Porciento Empleado" / 100;
                    MontoAplicar += ImporteImpuestos;
                    IF MontoAplicar < 0 THEN
                        MontoAplicar := 0;
                END;

                IF NOT IndSkip THEN BEGIN
                    PerfilSalTr.Importe := ImporteCotizacion;
                    PerfilSalTr.Cantidad := 1;

                    ImporteTotal := MontoAplicar * -1;
                    "%Cot" := DeduccGob."Porciento Empleado";
                    LinTabla += 10;
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
            LinAportesEmpresa."Tipo Nomina" := CabNomina."Tipo Nomina";
            LinAportesEmpresa."Tipo de nomina" := CabNomina."Tipo de nomina";
            LinAportesEmpresa."No. Empleado" := CabNomina."No. empleado";
            LinAportesEmpresa.VALIDATE("Concepto Salarial", DeduccGob.Codigo);
            LinAportesEmpresa."% Cotizable" := DeduccGob."Porciento Empresa";

            IF (ImporteCotizacionEmp > DeduccGob."Tope Salarial/Acumulado Anual") AND
               (DeduccGob."Tope Salarial/Acumulado Anual" <> 0) THEN
                ImporteCotizacionEmp := DeduccGob."Tope Salarial/Acumulado Anual";

            LinAportesEmpresa."Base Imponible" := ImporteCotizacionEmp;
            LinAportesEmpresa.Importe := ImporteCotizacionEmp * DeduccGob."Porciento Empresa" / 100 * -1;
            LinAportesEmpresa.Descripcion := PerfilSalTr.Descripcion;
            LinAportesEmpresa."Job No." := GlobalRec."Job No.";
            IF (LinAportesEmpresa.Importe <> 0) AND (NOT IndSkip) THEN BEGIN
                CLEAR(recTmpDimEntry);
                recTmpDimEntry.DELETEALL;
                InsertarDimTempDef(5200);                                                                      //Para las Dim del empleado
                InsertarDimTemp(ConfNominas."Dimension Conceptos Salariales", PerfilSalTr."Concepto salarial"); //Para el concepto salarial
                InsertarDimTempDefPS(34002115, Empleado."No." + PerfilSalTr."Concepto salarial");                 //Para las Dim del perfil de salario (linea del concepto salarial)
                InsertarDimTempDefPS(34002105, Empleado."Posting Group" + PerfilSalTr."Concepto salarial");    //Para las Dim del grupo contable (linea del concepto salarial)
                InsertarDimTempDefPS(34002111, PerfilSalTr."Concepto salarial");    //Para las Dim de la config. concepto salarial
                LinAportesEmpresa."Dimension Set ID" := cduDim.GetDimensionSetID(recTmpDimEntry);

                LinAportesEmpresa.INSERT;
            END;
        UNTIL DeduccGob.NEXT = 0;

    end;
}

