codeunit 34002118 "Registrar nomina RD"
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
        gTiposNom: Record 34002158;
        gTN: Record 34002158;
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
        HistLinNom2: Record 34002118;
        Incidencias: Record 5207;
        cduDim: Codeunit 408;
        FuncionesNom: Codeunit 34002104;
        Generar: Boolean;
        "Periodo": Integer;
        PerInici: Date;
        PerFinal: Date;
        iDia: Integer;
        iMes: Integer;
        iAno: Integer;
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
        OtrosSalarios: Decimal;
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
        Err004: Label 'The %1  has been exceeded or the discounts are greater than the income. \Please check employee %2\Incomes %3\Discounts %4\Total %5';
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
        Err005: Label 'Starting and ending date must be equal for daily payrolls';
        Err006: Label 'Specify Dimension %1 for Employee %2';
        "CDateSymbol-Y": Label 'Y';
        "CDateSymbol-W": Label 'W';
        DiasCesantia: Integer;
        DiasPreaviso: Integer;
        DiasSalario: Decimal;
        Text001: Label 'Payment %1 days of retroactive salary';
        Text002: Label '%1 calculated: %2 minus %3 %4';
        ISRCompensado: Decimal;
        Text003: Label 'Minus disc. of ';
        Text004: Label '%1 days previous salary, total %2, plus %3 days of new salary, total %4';
        Text005: Label 'Minus %1 working days, reason %2';
        FechaIniDT: DateTime;
        FechaFinDT: DateTime;
        Text006: Label '%1 days calculated by a daily Salary of %2';
        ImporteVacPagado: Decimal;
        DiasDisfruteVac: Decimal;
        Text007: Label 'balance in favor';
        Text008: Label 'vacation''s payment';
        RollOver: Boolean;
        RollBack: Boolean;
        SalDiaDivisa: Decimal;
        DiasVacPrest: Decimal;
        Text009: Label '%1 %2';

    procedure CODIGO()
    var
        HayNominaObra: Boolean;
        lIngresos: Text;
        lDescuentos: Text;
        lTotal: Text;
    begin
        ConfNominas.GET();
        RegEmpCotiz.FINDFIRST;
        GlobalRec.TESTFIELD("Empresa cotizacion", RegEmpCotiz."Empresa cotizacion");

        GlobalRec.TESTFIELD("Tipo de nomina");
        gTiposNom.GET(GlobalRec."Tipo de nomina");

        //IF gTiposNom."Validar contrato" THEN
        BEGIN
            Contrato.RESET;
            Contrato.SETRANGE("No. empleado", GlobalRec."No. empleado");
            IF gTiposNom."Tipo de nomina" <> gTiposNom."Tipo de nomina"::Prestaciones THEN
                Contrato.SETRANGE(Activo, TRUE);
            Contrato.FINDFIRST;
        END;

        IF gTiposNom."Cotiza AFP" THEN
            ConfNominas.TESTFIELD("Concepto AFP");

        IF gTiposNom."Cotiza ISR" THEN
            ConfNominas.TESTFIELD("Concepto ISR");

        IF gTiposNom."Cotiza SFS" THEN
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
            iDia := DATE2DMY(PerInici, 1);

            IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) AND (gTiposNom."Frecuencia de pago" = gTiposNom."Frecuencia de pago"::Quincenal) THEN
                IF (iDia <> gTiposNom."Dia inicio 1ra") AND (iDia <> gTiposNom."Dia inicio 2da") AND (gTiposNom."Tipo de nomina" <> gTiposNom."Tipo de nomina"::Prestaciones) THEN
                    ERROR(STRSUBSTNO(Err002, gTiposNom."Dia inicio 1ra", gTiposNom."Dia inicio 2da"));

            iMes := DATE2DMY(PerInici, 2);
            iAno := DATE2DMY(PerInici, 3);

            //ERROR('%1 %2',PerInici,PerFinal);


            //Para los empleados en proyectos
            IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::"Bi-Semanal") AND
               (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Regular) THEN BEGIN
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

            IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal THEN BEGIN
                IF gTiposNom."Dia inicio 1ra" = iDia THEN BEGIN
                    IF gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Regular THEN
                        PerfilSal.SETRANGE("1ra Quincena", TRUE);

                    PrimeraQ := TRUE;
                END
                ELSE BEGIN
                    IF gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Regular THEN
                        PerfilSal.SETRANGE("2da Quincena", TRUE);

                    SegundaQ := TRUE;
                END;
            END;

            IF PerfilSal.FINDSET(FALSE, FALSE) THEN
                REPEAT
                    //Para las prestaciones
                    IF gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Prestaciones THEN BEGIN
                        //CalcularIngresos;
                        IF gTiposNom."Frecuencia de pago" = gTiposNom."Frecuencia de pago"::Diaria THEN
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
                                CalcularISR;
                            END;
                            EliminaCabecera;
                        END;
                        EXIT;
                    END;

                    //Para la bonificacion
                    IF gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Bonificacion THEN BEGIN
                        CalculoBonificacion;
                        CalcularDtosLegales;
                        IF NOT ConfNominas."Impuestos manuales" THEN
                            CalcularISR;
                        EliminaCabecera;
                        EXIT;
                    END;

                    //Para la Regalia
                    IF gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Regalia THEN BEGIN
                        CalculoRegalia;
                        EXIT;
                    END;

                    //Para las vacaciones automaticas
                    //TODO: Ver 
                    /*
                    IF (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::"6") AND (ConfNominas."Adelantar salario vacaciones") THEN BEGIN
                        PagarVacAut;
                        IF gTiposNom."Cotiza AFP" THEN
                            CalcularDtosLegales;
                        IF NOT ConfNominas."Impuestos manuales" THEN
                            CalcularISR;
                        EliminaCabecera;
                        EXIT;
                    END;*/

                    //Para la Propina y otros
                    IF gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Extra THEN BEGIN
                        CalculoOtras;
                        CalcularDtosLegales;
                        IF NOT ConfNominas."Impuestos manuales" THEN
                            CalcularISR;
                        EliminaCabecera;
                        EXIT;
                    END;
                    IF PerfilSal."Tipo de nomina" = gTiposNom.Codigo THEN BEGIN
                        CalcularIngresos;
                        VerificaRetroactivo;
                    END;
                UNTIL PerfilSal.NEXT = 0;

            PerfilSal.SETRANGE("Tipo concepto", PerfilSal."Tipo concepto"::Deducciones);
            IF PerfilSal.FINDSET(FALSE, FALSE) THEN
                REPEAT
                    //Para la bonificacion
                    IF (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Bonificacion) THEN BEGIN
                        CalculoBonificacion;
                        EXIT;
                    END;

                    //Para la Regalia
                    IF (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Regalia) THEN BEGIN
                        CalculoRegalia;
                        EXIT;
                    END;

                    CalcularPrestamos;
                    CalcularDescuentos;
                UNTIL PerfilSal.NEXT = 0;

            IF Empleado."Calcular Nomina" THEN BEGIN
                CabNomina.RESET;
                CabNomina.SETRANGE("No. empleado", GlobalRec."No. empleado");
                CabNomina.SETRANGE("Tipo de nomina", GlobalRec."Tipo de nomina");
                CabNomina.SETRANGE(Periodo, PerInici, PerFinal);
                CabNomina.CALCFIELDS(CabNomina."Total Ingresos");
                IF CabNomina."Total Ingresos" > 0 THEN BEGIN
                    CalcularDtosLegales;
                    //      IF NOT Empleado."Excluido Cotizacion SFS" THEN
                    IF NOT ConfNominas."Impuestos manuales" THEN
                        CalcularISR;
                END;
            END;

            //Verifico que no se descuente mas de lo que se le paga.
            CabNomina.RESET;
            CabNomina.SETRANGE("No. empleado", GlobalRec."No. empleado");
            CabNomina.SETRANGE("Tipo de nomina", GlobalRec."Tipo de nomina");
            CabNomina.SETRANGE(Periodo, PerInici, PerFinal);
            CabNomina.CALCFIELDS("Total deducciones", CabNomina."Total Ingresos");
            lIngresos := '';
            lDescuentos := '';
            lTotal := '';

            //Verifico que el descuento no sobrepase lo permitido en la configuracion.
            IF ConfNominas."% dif. Ingresos y descuentos" <> 0 THEN BEGIN
                IF (CabNomina."Total deducciones" <> 0) AND (CabNomina."Total Ingresos" <> 0) THEN BEGIN
                    IF ((ABS(CabNomina."Total deducciones") / CabNomina."Total Ingresos" * 100 > ConfNominas."% dif. Ingresos y descuentos") AND (ConfNominas."% dif. Ingresos y descuentos" <> 0)) OR
                      (ABS(CabNomina."Total deducciones") > CabNomina."Total Ingresos") THEN BEGIN
                        LinNomina.RESET;
                        LinNomina.SETRANGE("No. empleado", CabNomina."No. empleado");
                        LinNomina.SETRANGE(Periodo, CabNomina.Periodo);
                        LinNomina.SETRANGE("Tipo de nomina", CabNomina."Tipo de nomina");
                        LinNomina.SETRANGE("No. Documento", CabNomina."No. Documento");
                        LinNomina.FINDSET;
                        REPEAT
                            IF LinNomina."Tipo concepto" = LinNomina."Tipo concepto"::Ingresos THEN
                                lIngresos += ' ' + LinNomina.Descripcion + ', ' + FORMAT(LinNomina.Total, 0, '<Integer Thousand><Decimals,3>')
                            ELSE
                                lDescuentos += ' ' + LinNomina.Descripcion + ', ' + FORMAT(LinNomina.Total, 0, '<Integer Thousand><Decimals,3>');
                        UNTIL LinNomina.NEXT = 0;
                        lTotal := ' ' + FORMAT(ROUND(CabNomina."Total Ingresos" + CabNomina."Total deducciones", 0.01), 0, '<Integer Thousand><Decimals,3>');
                        ERROR(STRSUBSTNO(Err004, ConfNominas.FIELDCAPTION("% dif. Ingresos y descuentos"), CabNomina."No. empleado" + ' - ' + CabNomina.Nombre, lIngresos, lDescuentos, lTotal));
                    END;
                END;
            END
            ELSE BEGIN
                IF (ABS(CabNomina."Total deducciones") > CabNomina."Total Ingresos") THEN BEGIN
                    LinNomina.RESET;
                    LinNomina.SETRANGE("No. empleado", CabNomina."No. empleado");
                    LinNomina.SETRANGE(Periodo, CabNomina.Periodo);
                    LinNomina.SETRANGE("Tipo de nomina", CabNomina."Tipo de nomina");
                    LinNomina.SETRANGE("No. Documento", CabNomina."No. Documento");
                    LinNomina.FINDSET;
                    REPEAT
                        IF LinNomina."Tipo concepto" = LinNomina."Tipo concepto"::Ingresos THEN
                            lIngresos += ' ' + LinNomina.Descripcion + ', ' + FORMAT(LinNomina.Total, 0, '<Integer Thousand><Decimals,3>')
                        ELSE
                            lDescuentos += ' ' + LinNomina.Descripcion + ', ' + FORMAT(LinNomina.Total, 0, '<Integer Thousand><Decimals,3>');
                    UNTIL LinNomina.NEXT = 0;
                    lTotal := ' ' + FORMAT(ROUND(CabNomina."Total Ingresos" + CabNomina."Total deducciones", 0.01), 0, '<Integer Thousand><Decimals,3>');
                    ERROR(STRSUBSTNO(Err004, ConfNominas.FIELDCAPTION("% dif. Ingresos y descuentos"), CabNomina."No. empleado" + ' - ' + CabNomina.Nombre, lIngresos, lDescuentos, lTotal));
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
                    Contrato.VALIDATE(Finalizado, TRUE);
                    Contrato.MODIFY;
                END;
            END;
        END;

        /*
        IF ConfNominas."Proceso recalculo ISR automat." THEN
           REPORT.RUN(REPORT::"Calcula ISR Emp. Relacionadas",FALSE,FALSE,CabNomina);
           */
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
        HCN.SETRANGE("Frecuencia de pago", gTiposNom."Frecuencia de pago");
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
          (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Regular) THEN BEGIN
            Fecha.RESET;
            Fecha.SETRANGE("Period Start", PerInici);
            Fecha.SETRANGE("Period Type", Fecha."Period Type"::Week);
            Fecha.FINDFIRST;
        END
        ELSE
            IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::"Bi-Semanal") AND
                 (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Regular) THEN BEGIN
            END;

        //Create Payroll Header
        CabNomina."No. empleado" := GlobalRec."No. empleado";
        CabNomina.Ano := iAno;
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
        //ERROR('%1 %2',CabNomina.Departamento,Empleado.Departamento);
        //CabNomina."Job No."                  := GlobalRec."Job No.";
        CLEAR(recTmpDimEntry);
        InsertarDimTempDef(5200);
        CabNomina."Dimension Set ID" := cduDim.GetDimensionSetID(recTmpDimEntry);
        CabNomina.INSERT;

        CabNomina.GET(iAno, Empleado."No.", GlobalRec."Inicio Periodo", GlobalRec."Job No.", GlobalRec."Tipo de nomina");

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
        DifVacaciones: Decimal;
        PerFinal2: Date;
    begin
        CantidadDiasEnt := 0;
        CantidadDiasSal := 0;
        DiasPago := 0;
        DiasIncid := 0;
        DiasCal := 0;
        IngresoSalario := 0;
        OtrosSalarios := 0;
        SalDiaDivisa := 0;
        ConfNominas.TESTFIELD("Dias para corte nominas");

        IF Empleado."Employment Date" > CALCDATE('-' + FORMAT(ConfNominas."Dias para corte nominas"), PerFinal) THEN
            EXIT;


        //Para llevar a 30 el mes final
        IF DATE2DMY(PerFinal, 1) = 31 THEN
            PerFinal2 := DMY2DATE(30, DATE2DMY(PerFinal, 2), DATE2DMY(PerFinal, 3));

        //TODO: Ver 
        /*
        IF Empleado."Tipo pago OLD" = Empleado."Tipo pago OLD"::"0" THEN BEGIN
            EsqSal.RESET;
            EsqSal.SETRANGE("No. empleado", GlobalRec."No. empleado");
            EsqSal.SETRANGE("Concepto salarial", ConfNominas."Concepto Sal. Base");
            EsqSal.FINDFIRST;
            EsqSal.TESTFIELD(Cantidad);
            EsqSal.TESTFIELD(Importe);
        END;*/

        EsqSal.RESET;
        EsqSal.SETRANGE("No. empleado", GlobalRec."No. empleado");
        EsqSal.SETRANGE("Salario Base", TRUE);
        EsqSal.SETFILTER(Cantidad, '<>%1', 0);
        EsqSal.SETFILTER(Importe, '<>%1', 0);
        //EsqSal.SETRANGE("Tipo de nomina",GlobalRec."Tipo de nomina");

        EsqSal.FINDSET;
        REPEAT
            IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Mensual THEN BEGIN
                IF EsqSal."Concepto salarial" = ConfNominas."Concepto Sal. Base" THEN
                    IngresoSalario += EsqSal.Importe
                ELSE
                    OtrosSalarios += EsqSal.Importe;
            END
            ELSE
                IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) OR
                   (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::"Bi-Semanal") THEN BEGIN
                    IF (EsqSal."1ra Quincena" AND EsqSal."2da Quincena") AND
                       (EsqSal."Concepto salarial" = ConfNominas."Concepto Sal. Base") THEN
                        IngresoSalario += EsqSal.Importe
                    ELSE
                        OtrosSalarios += EsqSal.Importe;
                END
        UNTIL EsqSal.NEXT = 0;


        Empleado.TESTFIELD("Job Type Code");
        Puestos.GET(Empleado.Departamento, Empleado."Job Type Code");
        PerfilSal.TESTFIELD("Tipo de nomina");
        IF ((PerfilSal."Tipo concepto" = PerfilSal."Tipo concepto"::Ingresos) AND
           (PerfilSal."Tipo de nomina" = GlobalRec."Tipo de nomina")) OR (gTiposNom."Incluir salario" AND PerfilSal."Salario Base") THEN BEGIN
            PerfilSal.TESTFIELD(Cantidad);
            PerfilSal.TESTFIELD(Importe);

            ImporteTotal := PerfilSal.Cantidad * ROUND(PerfilSal.Importe);
            ImporteBaseImp := ImporteTotal;
            SalDiaDivisa := ImporteTotal / 23.83;

            IF PerfilSal."Currency Code" <> '' THEN
                IF ConfNominas."Tasa Cambio Calculo Divisa" <> 0 THEN BEGIN
                    ImporteTotal := ROUND(PerfilSal.Importe) * ConfNominas."Tasa Cambio Calculo Divisa";
                    ImporteBaseImp := ImporteTotal;
                    SalDiaDivisa := ImporteTotal / 23.83;
                END
                ELSE BEGIN
                    CurrExchange.SETRANGE("Currency Code", PerfilSal."Currency Code");
                    CurrExchange.SETRANGE("Starting Date", 0D, PerFinal);
                    CurrExchange.FINDLAST;
                    ImporteTotal := ROUND(PerfilSal.Importe) * CurrExchange."Relational Exch. Rate Amount";
                    ImporteBaseImp := ImporteTotal;
                    SalDiaDivisa := ImporteTotal / 23.83
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
                        SalDiaDivisa := ImporteTotal / 23.83;
                    END
                    ELSE BEGIN
                        CurrExchange.SETRANGE("Currency Code", PerfilSal."Currency Code");
                        CurrExchange.SETRANGE("Starting Date", 0D, PerFinal);
                        CurrExchange.FINDLAST;
                        //IngresoSalario := PerfilSal.Importe * CurrExchange."Relational Exch. Rate Amount";
                        ImporteTotal := IngresoSalario;
                        ImporteBaseImp := ImporteTotal;
                        SalDiaDivisa := ImporteTotal / 23.83;
                    END;

                    IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) AND
                       (PerfilSal."1ra Quincena") AND (PerfilSal."2da Quincena") THEN
                        ImporteTotal /= 2;

                    ImporteTotal -= DifSueldo;
                END;
                //ELSE
                BEGIN
                    IF ConfNominas."Concepto Sal. Base" = PerfilSal."Concepto salarial" THEN BEGIN
                        //Para los casos en que se adelantan las vacaciones
                        IF (ConfNominas."Adelantar salario vacaciones") AND (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Regular) THEN BEGIN
                            DifVacaciones := 0;
                            RollOver := FALSE;
                            ValidaVacPagadas;
                            //ERROR('%1',DiasDisfruteVac);
                            IF DiasDisfruteVac <> 0 THEN BEGIN
                                IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Mensual THEN BEGIN
                                    PerfilSal.Comentario := STRSUBSTNO(Text002, PerfilSal.Descripcion, FORMAT(ROUND(ImporteTotal, 0.01), 0, '<Integer thousand><Decimals,3>'), FORMAT(ROUND(ImporteVacPagado, 0.01), 0, '<Integer thousand><Decimals,3>'), Text008);
                                    PerfilSal.Importe := ImporteTotal;
                                    ImporteTotal := ImporteTotal - ImporteVacPagado;

                                    ImporteBaseImp := ImporteTotal;
                                END
                                ELSE
                                    IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal THEN BEGIN
                                        PerfilSal.Comentario := STRSUBSTNO(Text002, PerfilSal.Descripcion, FORMAT(ROUND(ImporteTotal, 0.01), 0, '<Integer thousand><Decimals,3>'), FORMAT(ROUND(ImporteVacPagado, 0.01), 0, '<Integer thousand><Decimals,3>'), Text008);

                                    END; //%1 calculado: %2, menos %3 de saldo a favor
                            END;
                        END;


                        IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) AND
                           (PerfilSal."1ra Quincena") AND (PerfilSal."2da Quincena") THEN BEGIN
                            ImporteTotal := PerfilSal.Importe;
                            ImporteTotal /= 2;
                            //ERROR('%1 %2 %3',ImporteTotal,DifSueldo,DifVacaciones);
                            ImporteTotal := ImporteTotal - DifSueldo - DifVacaciones;
                        END;
                    END
                    ELSE BEGIN
                        ImporteTotal := PerfilSal.Cantidad * PerfilSal.Importe;
                        ImporteTotal -= DifSueldo - DifVacaciones;
                    END;
                END;

                IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal THEN BEGIN
                    CantidadDiasEnt := 15;

                    IF (Empleado."Employment Date" > PerInici) THEN BEGIN
                        IF (Empleado."Termination Date" <= PerFinal) AND (Empleado."Termination Date" <> 0D) THEN
                            CantidadDiasEnt := Empleado."Termination Date" - Empleado."Employment Date" + 1
                        ELSE
                            CantidadDiasEnt := PerFinal - Empleado."Employment Date" + 1;
                        IF (DATE2DMY(PerFinal, 1) < 30) AND SegundaQ THEN
                            CantidadDiasEnt += 1;

                        CantidadDiasEnt := CantidadDiasEnt - DiasAusencia - DifVacaciones;
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
                            IF (Empleado."Termination Date" <= PerFinal) AND (Empleado."Termination Date" <> 0D) THEN
                                Fecha.SETRANGE("Period Start", Empleado."Employment Date", Empleado."Termination Date")
                            ELSE
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
                            IF (Empleado."Termination Date" <= PerFinal2) AND (Empleado."Termination Date" <> 0D) THEN
                                CantidadDiasEnt := Empleado."Termination Date" - Empleado."Employment Date" + 1
                            ELSE
                                IF DATE2DMY(PerFinal, 1) > 30 THEN
                                    CantidadDiasEnt := 30 - DATE2DMY(Empleado."Employment Date", 1) + 1
                                ELSE
                                    CantidadDiasEnt := 30 - DATE2DMY(Empleado."Employment Date", 1) + 1;

                            CantidadDiasEnt := CantidadDiasEnt - DiasAusencia;

                            IF CantidadDiasEnt <= 0 THEN
                                ERROR(Err001, CantidadDiasEnt, Empleado."No.");

                            IF Puestos."Método cálculo Ingresos" = '' THEN
                                CalcDias.GET(ConfNominas."Metodo calculo Ingresos")
                            ELSE
                                CalcDias.GET(Puestos."Método cálculo Ingresos");

                            //IF CalcDias.Valor <> 30 THEN
                            BEGIN
                                Fecha.RESET;
                                Fecha.SETRANGE("Period Type", 0); //Dia
                                IF (Empleado."Termination Date" <= PerFinal) AND (Empleado."Termination Date" <> 0D) THEN
                                    Fecha.SETRANGE("Period Start", Empleado."Employment Date", Empleado."Termination Date")
                                ELSE
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
                            //error('%1',CantidadDiasEnt);
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
                                IF (Empleado."Employment Date" >= PerInici) THEN BEGIN
                                    IF (Empleado."Termination Date" <= PerFinal) AND (Empleado."Termination Date" <> 0D) THEN
                                        Fecha.SETRANGE("Period Start", Empleado."Employment Date", Empleado."Termination Date")
                                    ELSE
                                        Fecha.SETRANGE("Period Start", Empleado."Employment Date", PerFinal);
                                END
                                ELSE
                                    IF (Empleado."Termination Date" <= PerFinal) AND (Empleado."Termination Date" <> 0D) THEN
                                        Fecha.SETRANGE("Period Start", PerInici, Empleado."Termination Date")
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

                        // DiasPago            := CantidadDiasSal - DiasPago - DiasIncid - DiasCal;
                        //error('%1 %2 %3 %4',cantidaddiassal,diaspago,DiasIncid,diascal);
                    END;

                DiasPago := ABS(DiasPago - CantidadDiasSal - DiasIncid - DiasCal); //OJO

                IF (Empleado."Fin contrato" = PerFinal) AND ((Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) OR
                   (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::"Bi-Semanal")) THEN
                    IF NOT Incidencias.FINDFIRST THEN
                        DiasPago := 0;


                IF DiasPago <> 0 THEN BEGIN
                    IF Empleado."Employment Date" >= PerInici THEN BEGIN
                        IF Puestos."Método cálculo Ingresos" = '' THEN
                            CalcDias.GET(ConfNominas."Metodo calculo Ingresos")
                        ELSE
                            CalcDias.GET(Puestos."Método cálculo Ingresos");
                        //                message('%1 %2 %3 %4',ingresosalario, calcdias.valor, diaspago);
                        ImporteTotal := IngresoSalario / CalcDias.Valor * DiasPago;
                        ImporteBaseImp := ImporteTotal;

                        //Para el comentario
                        IF (DiasPago <> 0) AND ((Empleado."Employment Date" >= PerInici) OR ((Empleado."Termination Date" <> 0D) AND (Empleado."Termination Date" <= PerFinal))) THEN
                            PerfilSal.Comentario := STRSUBSTNO(Text006, DiasPago, ROUND(IngresoSalario / CalcDias.Valor));
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
    var
        HCN: Record 34002117;
    begin
        HCN.RESET;
        HCN.SETRANGE("Tipo de nomina", GlobalRec."Tipo de nomina");
        HCN.SETRANGE(Periodo, PerInici, PerFinal);
        HCN.SETRANGE("No. empleado", GlobalRec."No. empleado");
        IF NOT HCN.FINDFIRST THEN
            EXIT;


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
    begin
        IF Empleado."Excluir Calc. Imp. en Comision" AND (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Comisiones) THEN
            EXIT;
        DeduccGob.RESET;
        DeduccGob.SETRANGE(Ano, iAno);
        DeduccGob.FINDSET(FALSE, FALSE);
        REPEAT
            IndSkip := FALSE;
            IF Empleado."Excluido Cotizacion TSS" THEN BEGIN
                IF (DeduccGob.Codigo = ConfNominas."Concepto AFP") OR (DeduccGob.Codigo = ConfNominas."Concepto SFS") OR
                   (DeduccGob.Codigo = ConfNominas."Concepto SRL") THEN
                    IndSkip := TRUE;
            END;
            IF (NOT gTiposNom."Cotiza AFP") AND (DeduccGob.Codigo = ConfNominas."Concepto AFP") THEN
                IndSkip := TRUE
            ELSE
                IF (NOT gTiposNom."Cotiza SFS") AND (DeduccGob.Codigo = ConfNominas."Concepto SFS") THEN
                    IndSkip := TRUE
                ELSE
                    IF (NOT gTiposNom."Cotiza INFOTEP") AND (DeduccGob.Codigo = ConfNominas."Concepto INFOTEP") THEN
                        IndSkip := TRUE
                    ELSE
                        IF (NOT gTiposNom."Cotiza SRL") AND (DeduccGob.Codigo = ConfNominas."Concepto SRL") THEN
                            IndSkip := TRUE;

            ImporteCotizacion := 0;
            ImporteCotizacionEmp := 0;
            Importecotizacionmes := 0;

            PerfilSalTr.RESET;
            PerfilSalTr.SETRANGE("No. empleado", GlobalRec."No. empleado");
            PerfilSalTr.SETRANGE("Concepto salarial", DeduccGob.Codigo);
            PerfilSalTr.FINDFIRST;

            LinNominasES.RESET;
            LinNominasES.SETRANGE("No. empleado", GlobalRec."No. empleado");


            IF (gTiposNom."Frecuencia de pago" = gTiposNom."Frecuencia de pago"::Mensual) AND ((gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Regalia) OR
               (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Bonificacion)) THEN BEGIN
                LinNominasES.SETRANGE(Periodo, PerInici, PerFinal);
                IF gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Bonificacion THEN
                    LinNominasES.SETRANGE("Tipo de nomina", GlobalRec."Tipo de nomina");

                IF ConfNominas."Concepto INFOTEP" = DeduccGob.Codigo THEN BEGIN

                    LinNominasES.SETRANGE("Cotiza Infotep", TRUE);
                    IF gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Bonificacion THEN BEGIN
                        DeduccGob."Porciento Empresa" /= 2;
                        DeduccGob."Porciento Empleado" := DeduccGob."Porciento Empresa";
                    END;
                END;

                IF (DeduccGob.Codigo = ConfNominas."Concepto SFS") AND (NOT gTiposNom."Cotiza SFS") THEN
                    IndSkip := TRUE
                ELSE
                    IF (DeduccGob.Codigo = ConfNominas."Concepto AFP") AND (NOT gTiposNom."Cotiza AFP") THEN
                        IndSkip := TRUE;

                IF LinNominasES.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                        IF SegundaQ THEN BEGIN
                            HistCabNom.RESET;
                            HistCabNom.SETRANGE("No. empleado", GlobalRec."No. empleado");
                            IF (gTiposNom."Dia inicio 1ra" <> 0) AND (Contrato."Frecuencia de pago" <> Contrato."Frecuencia de pago"::Mensual) THEN
                                HistCabNom.SETRANGE(Periodo, DMY2DATE(gTiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                            ELSE
                                HistCabNom.SETRANGE(Periodo, PerInici, PerFinal);
                            IF NOT HistCabNom.FINDFIRST THEN
                                HistCabNom.INIT
                            ELSE
                                IF DATE2DMY(LinNominasES.Periodo, 1) <> gTiposNom."Dia inicio 1ra" THEN
                                    HistCabNom."Empresa cotizacion" := CabNomina."Empresa cotizacion";
                        END
                        ELSE
                            HistCabNom."Empresa cotizacion" := CabNomina."Empresa cotizacion";

                        IF HistCabNom."Empresa cotizacion" = CabNomina."Empresa cotizacion" THEN BEGIN
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
                // MESSAGE('pas a   %1 %2 %3 %4',ImporteCotizacion,PerfilSal."Concepto salarial");
            END
            ELSE
                IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Mensual THEN BEGIN
                    IF gTiposNom."Dia inicio 1ra" <> 1 THEN
                        LinNominasES.SETRANGE(Periodo, DMY2DATE(gTiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                    ELSE
                        LinNominasES.SETRANGE(Periodo, PerInici, PerFinal);

                    IF ConfNominas."Concepto AFP" = DeduccGob.Codigo THEN
                        LinNominasES.SETRANGE("Cotiza AFP", TRUE)
                    ELSE
                        IF ConfNominas."Concepto INFOTEP" = DeduccGob.Codigo THEN BEGIN
                            LinNominasES.SETRANGE("Cotiza Infotep", TRUE);
                            //LinNominasES.SETRANGE("Tipo de nomina",GlobalRec."Tipo de nomina");
                            IF gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Bonificacion THEN BEGIN
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

                    //       IF Empleado."Excluido Cotizacion TSS" THEN
                    //          IndSkip := TRUE;

                    IF LinNominasES.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            HistCabNom.RESET;
                            HistCabNom.SETRANGE("No. empleado", GlobalRec."No. empleado");
                            IF (gTiposNom."Dia inicio 1ra" <> 0) AND (Contrato."Frecuencia de pago" <> Contrato."Frecuencia de pago"::Mensual) THEN
                                HistCabNom.SETRANGE(Periodo, DMY2DATE(gTiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                            ELSE
                                HistCabNom.SETRANGE(Periodo, PerInici, PerFinal);

                            IF NOT HistCabNom.FINDFIRST THEN
                                HistCabNom.INIT;

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
                    // MESSAGE('pas a   %1 %2 %3 %4',ImporteCotizacion,PerfilSal."Concepto salarial");
                END
                ELSE
                    IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal THEN BEGIN
                        IF (PerfilSalTr."1ra Quincena") AND (NOT PerfilSalTr."2da Quincena") AND (PrimeraQ) THEN BEGIN
                            IF (gTiposNom."Dia inicio 1ra" > gTiposNom."Dia inicio 2da") AND (Contrato."Frecuencia de pago" <> Contrato."Frecuencia de pago"::Mensual) THEN
                                LinNominasES.SETRANGE(Periodo, DMY2DATE(gTiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                            ELSE
                                IF gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Comisiones THEN
                                    LinNominasES.SETRANGE(Periodo, DMY2DATE(gTiposNom."Dia inicio 1ra", DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)), PerFinal)
                                ELSE
                                    LinNominasES.SETRANGE(Periodo, PerInici, PerFinal);
                            IF ConfNominas."Concepto AFP" = DeduccGob.Codigo THEN
                                LinNominasES.SETRANGE("Cotiza AFP", TRUE)
                            ELSE
                                IF ConfNominas."Concepto INFOTEP" = DeduccGob.Codigo THEN BEGIN
                                    LinNominasES.SETRANGE("Cotiza Infotep", TRUE);
                                    IF gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Bonificacion THEN BEGIN
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
                                BEGIN
                                    IF (NOT Empleado."Excluido Cotizacion TSS") AND ((LinNominasES."Cotiza SFS" OR LinNominasES."Cotiza AFP")) THEN BEGIN
                                        IF Empleado."Employment Date" >= PerInici THEN BEGIN
                                            ImporteCotizacion += LinNominasES.Total + (LinNominasES."Importe Base" / 2);
                                            ImporteCotizacionEmp += LinNominasES.Total + (LinNominasES."Importe Base" / 2);
                                        END
                                        ELSE BEGIN
                                            ImporteCotizacion += LinNominasES."Importe Base";
                                            ImporteCotizacionEmp += LinNominasES."Importe Base"; //Ojo, importe base
                                                                                                 //MESSAGE('%1 %2 %3',LinNominasES."Concepto salarial",LinNominasES."Importe Base",ImporteCotizacionEmp);
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
                                END;
                                UNTIL LinNominasES.NEXT = 0;
                        END
                        ELSE
                            IF (NOT PerfilSalTr."1ra Quincena") AND (PerfilSalTr."2da Quincena") AND (SegundaQ) THEN BEGIN
                                IF (gTiposNom."Dia inicio 1ra" > gTiposNom."Dia inicio 2da") AND (Contrato."Frecuencia de pago" <> Contrato."Frecuencia de pago"::Mensual) THEN
                                    LinNominasES.SETRANGE(Periodo, DMY2DATE(gTiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                                ELSE
                                    //           IF gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Comisiones THEN
                                    LinNominasES.SETRANGE(Periodo, DMY2DATE(gTiposNom."Dia inicio 1ra", DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)), PerFinal);
                                //             ELSE
                                //              LinNominasES.SETRANGE(Periodo,PerInici,PerFinal);
                                IF ConfNominas."Concepto AFP" = DeduccGob.Codigo THEN
                                    LinNominasES.SETRANGE("Cotiza AFP", TRUE)
                                ELSE
                                    IF ConfNominas."Concepto INFOTEP" = DeduccGob.Codigo THEN BEGIN
                                        LinNominasES.SETRANGE("Cotiza Infotep", TRUE);
                                        IF gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Bonificacion THEN BEGIN
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
                                IF (NOT PerfilSalTr."1ra Quincena") AND (PerfilSalTr."2da Quincena") AND (PrimeraQ) THEN BEGIN
                                    IF (gTiposNom."Dia inicio 1ra" > gTiposNom."Dia inicio 2da") AND (Contrato."Frecuencia de pago" <> Contrato."Frecuencia de pago"::Mensual) THEN
                                        LinNominasES.SETRANGE(Periodo, DMY2DATE(gTiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                                    ELSE
                                        IF gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Comisiones THEN
                                            LinNominasES.SETRANGE(Periodo, DMY2DATE(gTiposNom."Dia inicio 1ra", DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)), PerFinal)
                                        ELSE
                                            LinNominasES.SETRANGE(Periodo, PerInici, PerFinal);

                                    IF ConfNominas."Concepto AFP" = DeduccGob.Codigo THEN
                                        LinNominasES.SETRANGE("Cotiza AFP", TRUE)
                                    ELSE
                                        IF ConfNominas."Concepto INFOTEP" = DeduccGob.Codigo THEN BEGIN
                                            LinNominasES.SETRANGE("Cotiza Infotep", TRUE);
                                            IF gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Bonificacion THEN BEGIN
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
                                        BEGIN
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
                                                                        Importecotizacionmes += LinNominasES.Total;
                                                                    END;
                                                                END;
                                                END;
                                            END;
                                        END;
                                        UNTIL LinNominasES.NEXT = 0;
                                END
                                ELSE
                                    IF PerfilSalTr."1ra Quincena" AND PerfilSalTr."2da Quincena" THEN BEGIN
                                        IF gTiposNom."Dia inicio 1ra" > gTiposNom."Dia inicio 2da" THEN
                                            LinNominasES.SETRANGE(Periodo, DMY2DATE(gTiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                                        ELSE
                                            IF gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Comisiones THEN
                                                LinNominasES.SETRANGE(Periodo, DMY2DATE(gTiposNom."Dia inicio 1ra", DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)), PerFinal)
                                            ELSE
                                                IF (SegundaQ) AND (gTiposNom."Frecuencia de pago" <> gTiposNom."Frecuencia de pago"::Diaria) THEN
                                                    LinNominasES.SETRANGE(Periodo, DMY2DATE(gTiposNom."Dia inicio 1ra", DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)), PerFinal)
                                                ELSE
                                                    LinNominasES.SETRANGE(Periodo, PerInici, PerFinal);

                                        IF ConfNominas."Concepto AFP" = DeduccGob.Codigo THEN
                                            LinNominasES.SETRANGE("Cotiza AFP", TRUE)
                                        ELSE
                                            IF ConfNominas."Concepto INFOTEP" = DeduccGob.Codigo THEN BEGIN
                                                LinNominasES.SETRANGE("Cotiza Infotep", TRUE);
                                                IF gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Bonificacion THEN BEGIN
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

                                        //  IF Empleado."Excluido Cotizacion TSS" THEN
                                        //     IndSkip := TRUE;

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
                                                                    Importecotizacionmes += LinNominasES."Importe Base" / 2 + LinNominasES.Total;
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
                                                                        Importecotizacionmes += LinNominasES.Total;
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
                                                                            Importecotizacionmes += LinNominasES.Total; //IDC
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
                                                END
                                                ELSE BEGIN
                                                    IF (LinNominasES."Importe Base" > DeduccGob."Tope Salarial/Acumulado Anual") AND
                                                        (DeduccGob."Tope Salarial/Acumulado Anual" <> 0) THEN BEGIN
                                                        ImporteCotizacion += DeduccGob."Tope Salarial/Acumulado Anual" / 2;
                                                        ImporteCotizacionEmp += DeduccGob."Tope Salarial/Acumulado Anual" / 2;
                                                        IF PrimeraQ THEN
                                                            Importecotizacionmes += DeduccGob."Tope Salarial/Acumulado Anual";
                                                    END
                                                    ELSE BEGIN
                                                        ImporteCotizacion += LinNominasES.Total;
                                                        ImporteCotizacionEmp += LinNominasES.Total;
                                                        IF PrimeraQ THEN
                                                            Importecotizacionmes += LinNominasES."Importe Base" / 2 + LinNominasES.Total;
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
                                    IF gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Bonificacion THEN BEGIN
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

                            //  IF Empleado."Excluido Cotizacion TSS" THEN
                            //      IndSkip := TRUE;

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
            IF (NOT SegundaQ) AND (ConfNominas."Metodo Calculo SS" <> ConfNominas."Metodo Calculo SS"::"Ingresos del Periodo") AND (Contrato."Frecuencia de pago" <> Contrato."Frecuencia de pago"::Mensual) THEN BEGIN
                gTN.RESET;
                gTN.SETRANGE("Tipo de nomina", gTN."Tipo de nomina"::Regular);
                gTN.FINDFIRST;
                LinNominasES.RESET;
                LinNominasES.SETRANGE("No. empleado", GlobalRec."No. empleado");
                IF (gTiposNom."Dia inicio 1ra" > gTiposNom."Dia inicio 2da") AND (SegundaQ) AND (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Regular) THEN
                    LinNominasES.SETRANGE(Periodo, DMY2DATE(gTiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                ELSE
                    IF (gTN."Dia inicio 1ra" > gTN."Dia inicio 2da") AND ((gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Prestaciones) OR (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Bonificacion)) THEN
                        LinNominasES.SETRANGE(Periodo, DMY2DATE(gTN."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                    ELSE
                        LinNominasES.SETRANGE(Periodo, PerInici, PerFinal);
                LinNominasES.SETRANGE("Concepto salarial", ConfNominas."Concepto Sal. Base");
                LinNominasES.SETFILTER("Tipo de nomina", '<>%1', GlobalRec."Tipo de nomina");
                IF NOT LinNominasES.FINDFIRST THEN BEGIN
                    //Busco si se le esta pagando en esta nomina
                    LinNominasES.RESET;
                    LinNominasES.SETRANGE("No. empleado", GlobalRec."No. empleado");
                    IF (gTiposNom."Dia inicio 1ra" > gTiposNom."Dia inicio 2da") AND (SegundaQ) AND (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Regular) THEN
                        LinNominasES.SETRANGE(Periodo, DMY2DATE(gTiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                    ELSE
                        IF (gTN."Dia inicio 1ra" > gTN."Dia inicio 2da") AND ((gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Prestaciones) OR (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Bonificacion)) THEN
                            LinNominasES.SETRANGE(Periodo, DMY2DATE(gTN."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
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
                                IF gTiposNom."Cotiza AFP" OR gTiposNom."Cotiza INFOTEP" OR gTiposNom."Cotiza SFS" OR gTiposNom."Cotiza SRL" THEN BEGIN
                                    ImporteCotizacion += PerfilSalImp.Importe;
                                    ImporteCotizacionEmp += PerfilSalImp.Importe;
                                END;
                            UNTIL PerfilSalImp.NEXT = 0;
                    END;
                END;
            END;

            //Verifico que se este pagando en esta misma nomina para este empleado para evitar arrastrar de otras nominas en el aporte patronal
            LinNominasES.RESET;
            LinNominasES.SETRANGE("No. empleado", GlobalRec."No. empleado");
            LinNominasES.SETRANGE(Periodo, PerInici, PerFinal);
            LinNominasES.SETRANGE("Tipo de nomina", GlobalRec."Tipo de nomina");
            IF NOT LinNominasES.FINDFIRST THEN
                IndSkip := TRUE;

            //Busco el importe cobrado del impuesto
            ImporteImpuestos := 0;
            LinNominasES.RESET;
            LinNominasES.SETRANGE("No. empleado", GlobalRec."No. empleado");
            IF (gTiposNom."Dia inicio 1ra" > gTiposNom."Dia inicio 2da") AND (Contrato."Frecuencia de pago" <> Contrato."Frecuencia de pago"::Mensual) THEN
                LinNominasES.SETRANGE(Periodo, DMY2DATE(gTiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
            ELSE
                IF SegundaQ AND (Contrato."Frecuencia de pago" <> Contrato."Frecuencia de pago"::Mensual) THEN BEGIN
                    IF gTiposNom."Frecuencia de pago" = gTiposNom."Frecuencia de pago"::Diaria THEN
                        LinNominasES.SETRANGE(Periodo, PerInici, PerFinal)
                    ELSE
                        LinNominasES.SETRANGE(Periodo, DMY2DATE(gTiposNom."Dia inicio 1ra", DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)), PerFinal)
                END
                ELSE
                    LinNominasES.SETRANGE(Periodo, PerInici, PerFinal);
            LinNominasES.SETRANGE("Concepto salarial", DeduccGob.Codigo);
            IF LinNominasES.FINDSET THEN
                REPEAT
                    ImporteImpuestos += LinNominasES.Total;
                UNTIL LinNominasES.NEXT = 0;

            IF (ImporteCotizacion > DeduccGob."Tope Salarial/Acumulado Anual") AND (DeduccGob."Tope Salarial/Acumulado Anual" <> 0) AND
               (DeduccGob."Porciento Empleado" <> 0) THEN BEGIN
                ImporteCotizacion := DeduccGob."Tope Salarial/Acumulado Anual";
                MontoAplicar := ImporteCotizacion * DeduccGob."Porciento Empleado" / 100;
                IF ABS(ImporteImpuestos) >= MontoAplicar THEN
                    IndSkip := TRUE;
            END;

            IF (ImporteCotizacion > DeduccGob."Tope Salarial/Acumulado Anual") AND (DeduccGob."Tope Salarial/Acumulado Anual" <> 0) THEN
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
            IF DeduccGob."Porciento Empleado" <> 0 THEN BEGIN
                MontoAplicar := (ImporteCotizacion * DeduccGob."Porciento Empleado" / 100) + ImporteImpuestos;
                //ERROR('paso 1 %1 %2 %3 %4 %5',Importecotizacionmes,TSSSueldo,TSSOtros,MontoAplicar,ImporteCotizacion);

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
            IF NOT IndSkip THEN BEGIN
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
                    //   (PerfilSalTr."1ra Quincena") AND (PerfilSalTr."2da Quincena")) AND
                    (SegundaQ)) OR (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Mensual) THEN BEGIN
                    //Busco el importe cobrado del impuesto
                    ImporteImpuestosemp := 0;
                    LinAportesEmpresa2.RESET;
                    LinAportesEmpresa2.SETRANGE("No. Empleado", GlobalRec."No. empleado");

                    IF (gTiposNom."Dia inicio 1ra" > gTiposNom."Dia inicio 2da") AND (gTiposNom."Dia inicio 1ra" <> 0) AND (gTiposNom."Dia inicio 2da" <> 0) THEN
                        LinAportesEmpresa2.SETRANGE(Periodo, DMY2DATE(gTiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                    ELSE
                        IF gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Comisiones THEN
                            LinAportesEmpresa2.SETRANGE(Periodo, DMY2DATE(gTiposNom."Dia inicio 1ra", DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)), PerFinal)
                        ELSE
                            IF (SegundaQ) AND (gTiposNom."Frecuencia de pago" <> gTiposNom."Frecuencia de pago"::Diaria) THEN
                                LinAportesEmpresa2.SETRANGE(Periodo, DMY2DATE(gTiposNom."Dia inicio 1ra", DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)), PerFinal)
                            ELSE
                                LinAportesEmpresa2.SETRANGE(Periodo, PerInici, PerFinal);
                    LinAportesEmpresa2.SETRANGE("Concepto Salarial", DeduccGob.Codigo);

                    IF LinAportesEmpresa2.FINDSET THEN
                        REPEAT
                            ImporteImpuestosemp += LinAportesEmpresa2.Importe;
                        UNTIL LinAportesEmpresa2.NEXT = 0;

                    LinAportesEmpresa.Importe := ROUND(ABS(LinAportesEmpresa.Importe) - ABS(ImporteImpuestosemp), 0.01);
                    IF LinAportesEmpresa.Importe > 0 THEN
                        LinAportesEmpresa.Importe := LinAportesEmpresa.Importe * -1;
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
        DeduccGob.SETRANGE(Ano, iAno);
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
        ISRMes: Decimal;
        SaldoCompensado: Boolean;
        ISRQuincenal: Decimal;
    begin
        //Poner que el acumulado base del ISR sea sobre lo devengado en el mes anterior.
        //Si se pasa del mes, solo calcular los dias trabajados en el mes. y revisar para el llenado de la plantilla de la tss

        //CalculoISR
        IF Empleado."Excluido Cotizacion ISR" THEN
            EXIT;

        //IF Empleado."Excluir Calc. Imp. en Comision" AND (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Comisiones) THEN
        //EXIT;

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

        //Busco si es quincenal cuando se deduce el ISR
        LinEsqPercepISR2.RESET;
        LinEsqPercepISR2.SETRANGE("No. empleado", GlobalRec."No. empleado");
        LinEsqPercepISR2.SETRANGE("Concepto salarial", ConfNominas."Concepto ISR");
        IF NOT LinEsqPercepISR2.FINDFIRST THEN
            LinEsqPercepISR2.INIT;


        IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) AND (gTiposNom."Tipo de nomina" <> gTiposNom."Tipo de nomina"::Bonificacion) THEN BEGIN
            IF (NOT LinEsqPercepISR2."1ra Quincena") AND (PrimeraQ) THEN
                EXIT;

            IF Puestos."Método cálculo Paga Salario" = 0 THEN //Para Normal, se divide el salario
                IngresoSalario := IngresoSalario / 2;
        END;

        gTN.RESET;
        gTN.SETRANGE("Tipo de nomina", gTN."Tipo de nomina"::Regular);
        gTN.FINDFIRST;
        //Busco lo que se ha descontado en el periodo
        IF SegundaQ OR (gTiposNom."Frecuencia de pago" = gTiposNom."Frecuencia de pago"::Mensual) THEN // Cuando se descuenta solo en la segunda
           BEGIN
            HistLinNom.RESET;
            HistLinNom.SETRANGE("No. empleado", GlobalRec."No. empleado");
            IF (gTiposNom."Dia inicio 1ra" > gTiposNom."Dia inicio 2da") AND (SegundaQ) AND (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Regular) THEN
                HistLinNom.SETRANGE(Periodo, DMY2DATE(gTiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
            ELSE
                IF (gTN."Dia inicio 1ra" > gTN."Dia inicio 2da") AND ((gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Prestaciones) OR (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Bonificacion)) THEN
                    HistLinNom.SETRANGE(Periodo, DMY2DATE(gTN."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                ELSE
                    HistLinNom.SETRANGE(Periodo, DMY2DATE(1, DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)), PerFinal);
            HistLinNom.SETRANGE("Concepto salarial", ConfNominas."Concepto ISR");
        END
        ELSE BEGIN
            HistLinNom.RESET;
            HistLinNom.SETRANGE("No. empleado", GlobalRec."No. empleado");
            IF (gTiposNom."Dia inicio 1ra" > gTiposNom."Dia inicio 2da") AND (SegundaQ) AND (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Regular) THEN
                HistLinNom.SETRANGE(Periodo, DMY2DATE(gTiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
            ELSE
                IF (gTN."Dia inicio 1ra" > gTN."Dia inicio 2da") AND ((gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Prestaciones) OR (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Bonificacion)) THEN
                    HistLinNom.SETRANGE(Periodo, DMY2DATE(gTN."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                ELSE
                    IF (gTN."Dia inicio 1ra" < gTN."Dia inicio 2da") AND (SegundaQ) THEN
                        HistLinNom.SETRANGE(Periodo, DMY2DATE(gTN."Dia inicio 1ra", DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)), PerFinal)
                    ELSE
                        HistLinNom.SETRANGE(Periodo, PerInici, PerFinal);
            HistLinNom.SETRANGE("Concepto salarial", ConfNominas."Concepto ISR");
        END;

        IF HistLinNom.FINDSET(FALSE, FALSE) THEN
            REPEAT
                ISRCobrado := ISRCobrado + (HistLinNom.Total * -1) + HistLinNom."ISR compensado";
            UNTIL HistLinNom.NEXT = 0;

        //Busqueda de todos los conceptos que cotizan para el calculo del ISR
        HistLinNom.RESET;
        HistLinNom.SETRANGE("No. empleado", GlobalRec."No. empleado");
        IF NOT SegundaQ THEN BEGIN
            IF (gTiposNom."Dia inicio 1ra" > gTiposNom."Dia inicio 2da") AND (SegundaQ) AND (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Regular) THEN
                HistLinNom.SETRANGE(Periodo, DMY2DATE(gTiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
            ELSE
                IF (gTN."Dia inicio 1ra" > gTN."Dia inicio 2da") AND ((gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Prestaciones) OR (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Bonificacion)) THEN BEGIN
                    HistLinNom.SETRANGE(Periodo, DMY2DATE(gTN."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal);
                    HistLinNom.SETRANGE("Tipo de nomina", gTiposNom.Codigo);
                END
                ELSE
                    IF (gTN."Dia inicio 1ra" < gTN."Dia inicio 2da") AND ((gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Prestaciones) OR (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Bonificacion)) THEN BEGIN
                        HistLinNom.SETRANGE(Periodo, DMY2DATE(gTN."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal);
                        HistLinNom.SETRANGE("Tipo de nomina", gTiposNom.Codigo);
                    END
                    ELSE
                        IF (gTN."Dia inicio 1ra" > gTN."Dia inicio 2da") AND (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Extra) THEN
                            HistLinNom.SETRANGE(Periodo, DMY2DATE(gTN."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                        ELSE
                            HistLinNom.SETRANGE(Periodo, PerInici, PerFinal);
        END
        ELSE
            IF SegundaQ THEN BEGIN
                IF (gTiposNom."Dia inicio 1ra" > gTiposNom."Dia inicio 2da") AND (SegundaQ) AND (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Regular) THEN
                    HistLinNom.SETRANGE(Periodo, DMY2DATE(gTiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                ELSE
                    IF (gTN."Dia inicio 1ra" > gTN."Dia inicio 2da") AND ((gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Prestaciones) OR (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Bonificacion)) THEN
                        HistLinNom.SETRANGE(Periodo, DMY2DATE(gTN."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                    ELSE
                        HistLinNom.SETRANGE(Periodo, DMY2DATE(1, DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)), PerFinal);
            END;
        HistLinNom.SETRANGE("Cotiza ISR", TRUE);

        IF HistLinNom.FINDSET(FALSE, FALSE) THEN
            REPEAT
                LinEsqPercepISR.RESET;
                LinEsqPercepISR.SETRANGE("No. empleado", GlobalRec."No. empleado");
                LinEsqPercepISR.SETRANGE("Concepto salarial", HistLinNom."Concepto salarial");
                LinEsqPercepISR.FINDFIRST;
                IF LinEsqPercepISR."1ra Quincena" AND LinEsqPercepISR."2da Quincena" THEN BEGIN
                    IF ((Puestos."Método cálculo Paga Salario" = 0) AND (HistLinNom."Salario Base" AND PrimeraQ) AND (PrimeraVez) AND
                       (gTiposNom."Frecuencia de pago" = gTiposNom."Frecuencia de pago"::Quincenal)) OR (gTiposNom."Calcular ISR Mes en Bonific") THEN BEGIN
                        HistLinNom.Total += IngresoSalario;
                        PrimeraVez := FALSE;
                    END;

                    //Solo si el ISR se deduce en ambas quincenas
                    IF (HistLinNom.Total <> 0) AND (LinEsqPercepISR2."1ra Quincena" AND LinEsqPercepISR2."2da Quincena") AND
                      (HistLinNom."Salario Base") THEN BEGIN
                        TotalISR[1] [1] += ROUND(HistLinNom.Total, 0.01)
                    END
                    ELSE
                        IF (HistLinNom.Total <> 0) AND ((NOT LinEsqPercepISR2."1ra Quincena") AND LinEsqPercepISR2."2da Quincena") AND
                          (HistLinNom."Salario Base") THEN BEGIN
                            TotalISR[1] [1] += ROUND(HistLinNom.Total, 0.01)
                        END
                        ELSE
                            IF ((HistLinNom.Total <> 0) AND (NOT HistLinNom."Salario Base")) OR (SegundaQ) THEN BEGIN
                                IF (HistLinNom."Concepto salarial" = ConfNominas."Concepto AFP") AND (PrimeraQ) THEN
                                    TotalISR[1] [1] += AFPMes * -1
                                ELSE
                                    IF (HistLinNom."Concepto salarial" = ConfNominas."Concepto SFS") AND (PrimeraQ) THEN
                                        TotalISR[1] [1] += SFSMes * -1
                                    ELSE
                                        TotalISR[1] [1] += ROUND(HistLinNom.Total, 0.01)
                            END;
                END
                ELSE
                    IF HistLinNom.Total <> 0 THEN BEGIN
                        TotalISR[1] [1] += ROUND(HistLinNom.Total, 0.01);
                    END;
            //     MESSAGE('%1 %2 %3 %4',TotalISR[1][1],HistLinNom.Total,HistLinNom."Concepto salarial");
            UNTIL HistLinNom.NEXT = 0;
        //error('%1 %2',TotalISR[1][1],ImporteCotizacionRec);

        //Para los casos en que la comision se paga antes del salario
        IF gTiposNom."Tipo de nomina" <> gTiposNom."Tipo de nomina"::Bonificacion THEN BEGIN
            HistLinNom.RESET;
            HistLinNom.SETRANGE("No. empleado", GlobalRec."No. empleado");
            IF (gTiposNom."Dia inicio 1ra" > gTiposNom."Dia inicio 2da") AND (SegundaQ) AND ((gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Regular) OR
               (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Comisiones)) THEN
                HistLinNom.SETRANGE(Periodo, DMY2DATE(gTiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
            ELSE
                IF (gTN."Dia inicio 1ra" > gTN."Dia inicio 2da") AND ((gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Prestaciones) OR (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Bonificacion)) THEN
                    HistLinNom.SETRANGE(Periodo, DMY2DATE(gTN."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                ELSE
                    IF SegundaQ THEN
                        HistLinNom.SETRANGE(Periodo, DMY2DATE(gTN."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                    ELSE
                        HistLinNom.SETRANGE(Periodo, PerInici, PerFinal);
            HistLinNom.SETRANGE("Cotiza ISR", TRUE);
            HistLinNom.SETRANGE("Tipo concepto", HistLinNom."Tipo concepto"::Ingresos);
            HistLinNom.SETFILTER("Concepto salarial", '%1|%2', ConfNominas."Concepto Sal. Base", ConfNominas."Concepto Sal. hora");
            IF HistLinNom.FINDFIRST THEN
                HayNominas := TRUE;

            IF ConfNominas."Metodo Calculo SS" <> ConfNominas."Metodo Calculo SS"::"Ingresos del Periodo" THEN BEGIN
                HistLinNom.RESET;
                HistLinNom.SETRANGE("No. empleado", GlobalRec."No. empleado");
                IF (gTiposNom."Dia inicio 1ra" > gTiposNom."Dia inicio 2da") AND (SegundaQ) AND (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Regular) THEN
                    HistLinNom.SETRANGE(Periodo, DMY2DATE(gTiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                ELSE
                    IF (gTN."Dia inicio 1ra" > gTN."Dia inicio 2da") AND ((gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Prestaciones) OR (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Bonificacion)) THEN
                        HistLinNom.SETRANGE(Periodo, DMY2DATE(gTN."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                    ELSE
                        IF (SegundaQ) AND (gTN."Dia inicio 1ra" > gTN."Dia inicio 2da") THEN
                            HistLinNom.SETRANGE(Periodo, DMY2DATE(gTN."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                        ELSE
                            IF SegundaQ THEN
                                HistLinNom.SETRANGE(Periodo, DMY2DATE(gTN."Dia inicio 1ra", DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)), PerFinal)
                            ELSE
                                HistLinNom.SETRANGE(Periodo, PerInici, PerFinal);
                HistLinNom.SETRANGE("Cotiza ISR", TRUE);
                HistLinNom.SETRANGE("Tipo concepto", HistLinNom."Tipo concepto"::Ingresos);
                HistLinNom.SETRANGE("Tipo de nomina", gTiposNom.Codigo);
                IF HistLinNom.FINDFIRST AND (NOT HayNominas) THEN BEGIN
                    IF (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Comisiones) AND (NOT HayNominas) AND (TotalISR[1] [1] <> 0) THEN BEGIN
                        LinEsqPercepISR2.RESET;
                        LinEsqPercepISR2.SETRANGE("No. empleado", GlobalRec."No. empleado");
                        LinEsqPercepISR2.SETRANGE("Salario Base", TRUE);
                        LinEsqPercepISR2.SETRANGE("Cotiza ISR", TRUE);
                        LinEsqPercepISR2.SETFILTER(Cantidad, '>=%1', 1);
                        LinEsqPercepISR2.SETFILTER("Tipo de nomina", '<>%1', gTiposNom.Codigo);
                        IF LinEsqPercepISR2.FINDSET THEN
                            REPEAT
                                IF LinEsqPercepISR2."Tipo concepto" = LinEsqPercepISR2."Tipo concepto"::Ingresos THEN
                                    TotalISR[1] [1] += LinEsqPercepISR2.Importe * LinEsqPercepISR2.Cantidad
                                ELSE
                                    TotalISR[1] [1] -= LinEsqPercepISR2.Importe * LinEsqPercepISR2.Cantidad;
                            UNTIL LinEsqPercepISR2.NEXT = 0;
                    END;
                END
                ELSE
                    IF PrimeraQ THEN BEGIN
                        LinEsqPercepISR2.RESET;
                        LinEsqPercepISR2.SETRANGE("No. empleado", GlobalRec."No. empleado");
                        LinEsqPercepISR2.SETRANGE("Salario Base", FALSE);
                        LinEsqPercepISR2.SETRANGE("Cotiza ISR", TRUE);
                        // LinEsqPercepISR2.SETFILTER(Cantidad,'>=%1',1);
                        LinEsqPercepISR2.SETRANGE("Tipo de nomina", gTiposNom.Codigo);
                        LinEsqPercepISR2.SETRANGE("1ra Quincena", FALSE);
                        LinEsqPercepISR2.SETFILTER("Concepto salarial", '%1|%2|%3', ConfNominas."Concepto Dependiente Adicional", ConfNominas."Concepto SFS", ConfNominas."Concepto AFP");
                        IF LinEsqPercepISR2.FINDSET THEN
                            REPEAT
                                IF LinEsqPercepISR2."Tipo concepto" = LinEsqPercepISR2."Tipo concepto"::Ingresos THEN
                                    TotalISR[1] [1] += LinEsqPercepISR2.Importe
                                ELSE
                                    TotalISR[1] [1] -= LinEsqPercepISR2.Importe;
                            UNTIL LinEsqPercepISR2.NEXT = 0;
                    END;
            END;
        END
        ELSE BEGIN
            LinEsqPercepISR2.RESET;
            LinEsqPercepISR2.SETRANGE("No. empleado", GlobalRec."No. empleado");
            LinEsqPercepISR2.SETRANGE("Salario Base", TRUE);
            LinEsqPercepISR2.SETRANGE("Cotiza ISR", TRUE);
            LinEsqPercepISR2.SETFILTER(Cantidad, '>=%1', 1);
            LinEsqPercepISR2.SETFILTER("Tipo de nomina", '<>%1', gTiposNom.Codigo);
            IF LinEsqPercepISR2.FINDSET THEN
                REPEAT
                    IF LinEsqPercepISR2."Tipo concepto" = LinEsqPercepISR2."Tipo concepto"::Ingresos THEN
                        TotalISR[1] [1] += LinEsqPercepISR2.Importe * LinEsqPercepISR2.Cantidad
                    ELSE
                        TotalISR[1] [1] -= LinEsqPercepISR2.Importe * LinEsqPercepISR2.Cantidad;
                UNTIL LinEsqPercepISR2.NEXT = 0;
        END;
        //Modificar calculo descuentos cuando es caso vendedores
        IF (HistLinNom.Total <> 0) AND (LinEsqPercepISR2."1ra Quincena" AND LinEsqPercepISR2."2da Quincena") THEN BEGIN
            LinEsqPercepTSS.RESET;
            LinEsqPercepTSS.SETRANGE("No. empleado", GlobalRec."No. empleado");
            LinEsqPercepTSS.SETRANGE("Concepto salarial", ConfNominas."Concepto SFS");
            LinEsqPercepTSS.FINDFIRST;
            IF NOT LinEsqPercepTSS."1ra Quincena" THEN
                ReCalcularDtosLegales;
        END
        ELSE
            ReCalcularDtosLegales; //Para el caso de que el ISR solo se paga en 1ra, se calculan AFP y SFS para el mes.

        //ERROR('%1 %2',TotalISR[1][1],ImporteCotizacionRec);

        TotalISR[1] [1] += ImporteCotizacionRec;
        /*
        IF (GlobalRec."Tipo Nomina" = GlobalRec."Tipo Nomina"::Normal) OR
           (GlobalRec."Tipo Nomina" = GlobalRec."Tipo Nomina"::Bonificacion) THEN
        */
        IF (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Regular) OR
           (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Bonificacion) THEN
            TotalISR[1] [1] += TotalCompany + Empleado."Salario Empresas Externas"
        ELSE
            TotalISR[1] [1] += TotalCompany;

        Base := TotalISR[1] [1];

        //ERROR('%1 %2 %3 %4',BASE,TOTALISR[1][1],TOTALCOMPANY);
        // Cálculo del ISR. Busqueda de Rangos ISR
        Indice := 1;
        RetencionISR.SETRANGE(Ano, FORMAT(iAno, 4, '<Standard Format,0>'));
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

        LinEsqPercepISR2.RESET;
        LinEsqPercepISR2.SETRANGE("No. empleado", GlobalRec."No. empleado");
        LinEsqPercepISR2.SETRANGE("Concepto salarial", ConfNominas."Concepto ISR");
        LinEsqPercepISR2.FINDFIRST;


        IF (gTiposNom."Dia inicio 1ra" > gTiposNom."Dia inicio 2da") AND (SegundaQ) AND (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Regular) THEN
            HLNISRCompensado.SETRANGE(Periodo, DMY2DATE(gTiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
        ELSE
            IF (gTN."Dia inicio 1ra" > gTN."Dia inicio 2da") AND (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Prestaciones) THEN
                HLNISRCompensado.SETRANGE(Periodo, DMY2DATE(gTN."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
            ELSE
                IF (gTiposNom."Dia inicio 1ra" > gTiposNom."Dia inicio 2da") AND (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Bonificacion) THEN
                    HistLinNomISR.SETRANGE(Periodo, DMY2DATE(gTiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
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

        /*Obsoleto
        SaldoFavor.RESET;
        SaldoFavor.SETRANGE("Cod. Empleado",GlobalRec."No. empleado");
        SaldoFavor.SETRANGE(Ano,DATE2DMY(PerInici,3));
        //SaldoFavor.SETFILTER("Importe Pendiente",'>0');
        IF SaldoFavor.FINDFIRST THEN
           BEGIN
            BKSaldoFavor.TRANSFERFIELDS(SaldoFavor);
            IF NOT BKSaldoFavor.INSERT THEN
               BKSaldoFavor.MODIFY;
           END;
        */
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
           (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Regular) THEN
            IF ((PerfilSalImp."1ra Quincena" <> PrimeraQ) AND PrimeraQ) THEN
                EXIT;

        IF ((Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) AND
           (PerfilSalImp."1ra Quincena") AND (PerfilSalImp."2da Quincena") AND (PrimeraQ) AND
           (Puestos."Método cálculo Paga Salario" = 0)) AND (gTiposNom."Frecuencia de pago" <> gTiposNom."Frecuencia de pago"::Mensual) THEN
            TotalISR[1] [1] := ROUND(TotalISR[1] [1] / 2, 0.01)
        ELSE
            IF (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Prestaciones) THEN BEGIN
                HistLinNomISR.RESET;
                HistLinNomISR.SETRANGE("No. empleado", GlobalRec."No. empleado");
                IF (gTiposNom."Dia inicio 1ra" > gTiposNom."Dia inicio 2da") AND (SegundaQ) AND (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Regular) THEN
                    HistLinNomISR.SETRANGE(Periodo, DMY2DATE(gTiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                ELSE
                    IF ((gTN."Dia inicio 1ra" > gTN."Dia inicio 2da") AND (gTN."Dia inicio 1ra" <> 0) AND (gTN."Dia inicio 2da" <> 0)) AND (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Prestaciones) THEN
                        HistLinNomISR.SETRANGE(Periodo, DMY2DATE(gTN."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                    ELSE
                        IF (gTiposNom."Dia inicio 1ra" > gTiposNom."Dia inicio 2da") AND (gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Bonificacion) THEN
                            HistLinNomISR.SETRANGE(Periodo, DMY2DATE(gTiposNom."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
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
            SaldoCompensado := FALSE;
            PerfilSalImp.Comentario := STRSUBSTNO(Text002, PerfilSalImp.Descripcion, FORMAT(ROUND(TotalISR[1] [1], 0.01), 0, '<Integer thousand><Decimals,3>'), FORMAT(ROUND(SaldoFavor."Importe Pendiente" + ISRCompensado, 0.01), 0, '<Integer thousand><Decimals,3>'), Text007);

            ISRQuincenal := 0;
            //    IF (PerfilSalImp."1ra Quincena" AND PerfilSalImp."2da Quincena" THEN
            //       ISRQuincenal := ABS(TotalISR[1][1]) /2;

            IF (ABS(TotalISR[1] [1]) >= SaldoFavor."Importe Pendiente") AND (ISRQuincenal = 0) THEN
                ISRCompensado2 := ISRCompensado - dISRCompensando + SaldoFavor."Importe Pendiente"
            ELSE
                IF (ISRQuincenal >= SaldoFavor."Importe Pendiente") AND (ISRQuincenal <> 0) AND (SegundaQ) THEN
                    ISRCompensado2 := ISRCompensado - dISRCompensando + SaldoFavor."Importe Pendiente"
                ELSE
                    ISRCompensado2 := TotalISR[1] [1] - ISRCobrado - ISRCompensado;

            IF (ABS(TotalISR[1] [1]) >= SaldoFavor."Importe Pendiente") AND (ISRQuincenal = 0) THEN BEGIN
                TotalISR[1] [1] -= (SaldoFavor."Importe Pendiente" + ISRCompensado);
                SaldoFavor."Importe Pendiente" := 0;
                SaldoCompensado := TRUE;
            END
            ELSE
                IF (ISRQuincenal >= SaldoFavor."Importe Pendiente") AND (ISRQuincenal <> 0) AND (SegundaQ) THEN BEGIN
                    TotalISR[1] [1] -= (SaldoFavor."Importe Pendiente" + ISRCompensado);
                    SaldoFavor."Importe Pendiente" := 0;
                    SaldoCompensado := TRUE;
                END
                ELSE
                    /*IF (PerfilSalImp."1ra Quincena" AND PerfilSalImp."2da Quincena") AND (ISRQuincenal <>0) AND (SegundaQ) THEN
                       BEGIN
                        PerfilSalImp.Comentario := STRSUBSTNO(Text002,PerfilSalImp.Descripcion,FORMAT(ROUND(TotalISR[1][1],0.01),0,'<Integer thousand><Decimals,3>'),
                                                              FORMAT(ROUND(SaldoFavor."Importe Pendiente" + ISRCompensado,0.01),0,'<Integer thousand><Decimals,3>'));
                        SaldoFavor."Importe Pendiente"   -= TotalISR[1][1] /2;
                        TotalISR[1][1]                   := 0;
                        ImporteTotal                     := 0;
                       END
                    ELSE*/
                    IF (PerfilSalImp."1ra Quincena" AND PerfilSalImp."2da Quincena") AND (ISRQuincenal <> 0) AND (PrimeraQ) THEN BEGIN
                        IF SegundaQ THEN BEGIN
                            PerfilSalImp.Comentario := STRSUBSTNO(Text002, PerfilSalImp.Descripcion, FORMAT(ROUND(ISRQuincenal, 0.01), 0, '<Integer thousand><Decimals,3>'),
                                                                  FORMAT(ROUND(SaldoFavor."Importe Pendiente" + ISRCompensado, 0.01), 0, '<Integer thousand><Decimals,3>'), Text007);
                            SaldoFavor."Importe Pendiente" -= TotalISR[1] [1] / 2;
                            TotalISR[1] [1] := 0;
                            ImporteTotal := 0;
                        END
                        ELSE
                            IF ISRQuincenal < SaldoFavor."Importe Pendiente" THEN BEGIN
                                PerfilSalImp.Comentario := STRSUBSTNO(Text002, PerfilSalImp.Descripcion, FORMAT(ROUND(ISRQuincenal, 0.01), 0, '<Integer thousand><Decimals,3>'),
                                                                      FORMAT(ROUND(SaldoFavor."Importe Pendiente" + ISRCompensado, 0.01), 0, '<Integer thousand><Decimals,3>'), Text007);
                                SaldoFavor."Importe Pendiente" -= ISRQuincenal;
                                TotalISR[1] [1] := 0;
                                ImporteTotal := 0;
                            END
                            ELSE BEGIN
                                PerfilSalImp.Comentario := STRSUBSTNO(Text002, PerfilSalImp.Descripcion, FORMAT(ROUND(ISRQuincenal, 0.01), 0, '<Integer thousand><Decimals,3>'),
                                                                      FORMAT(ROUND(SaldoFavor."Importe Pendiente" + ISRCompensado, 0.01), 0, '<Integer thousand><Decimals,3>'), Text007);
                                TotalISR[1] [1] := ISRQuincenal - SaldoFavor."Importe Pendiente";
                                SaldoFavor."Importe Pendiente" := 0;
                                ImporteTotal := 0;
                            END
                    END
                    ELSE BEGIN
                        SaldoFavor."Importe Pendiente" -= TotalISR[1] [1]; // - ISRCompensado2;
                        TotalISR[1] [1] := 0;
                    END;
        END
        ELSE
            IF ISRCompensado <> 0 THEN
                TotalISR[1] [1] := TotalISR[1] [1] - ISRCompensado;

        IF PrimeraQ THEN
            ISRCompensado := ISRCompensado2
        ELSE
            IF TotalISR[1] [1] = 0 THEN
                EXIT;
        //MESSAGE('%1',ISRCompensado);

        //Modifico el Saldo ISR a Favor
        /*
        SaldoFavor2.COPYFILTERS(SaldoFavor);
        IF SaldoFavor2.FINDSET(TRUE,FALSE) THEN
           BEGIN
            SaldoFavor2.GET(SaldoFavor."Cod. Empleado",SaldoFavor.Ano);
            SaldoFavor2."Importe Pendiente" := SaldoFavor."Importe Pendiente";
            SaldoFavor2.MODIFY;
           END;
        */
        //ISRCompensado := ISRCompensado2;
        PerfilSalImp.Cantidad := 1;
        PerfilSalImp.Importe := Base;
        //ERROR('%1',TotalISR[1][1]);
        IF (ISRCobrado >= TotalISR[1] [1]) AND (TotalISR[1] [1] <> 0) AND (gTiposNom."Tipo de nomina" <> gTiposNom."Tipo de nomina"::Prestaciones) AND (NOT SaldoCompensado) THEN
            EXIT
        ELSE
            IF (gTiposNom."Tipo de nomina" <> gTiposNom."Tipo de nomina"::Prestaciones) AND (TotalISR[1] [1] <> 0) THEN BEGIN
                TotalISR[1] [1] := ABS(TotalISR[1] [1]) - ISRCobrado;
                IF TotalISR[1] [1] < 0 THEN
                    TotalISR[1] [1] *= -1;
            END;

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
        //  PerfilSal.SETRANGE("Tipo concepto",0); {Ingresos  }
        PerfilSal.SETRANGE("Tipo de nomina", GlobalRec."Tipo de nomina");
        IF PerfilSal.FINDSET(FALSE, FALSE) THEN
            REPEAT
                ImporteTotal := PerfilSal.Cantidad * ROUND(PerfilSal.Importe);
                LinTabla += 10;
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
        LinNomina."Tipo de nomina" := gTiposNom.Codigo;
        LinNomina."No. empleado" := perfSalario."No. empleado";
        LinNomina."No. Documento" := CabNomina."No. Documento";
        LinNomina.Periodo := PerInici;
        LinNomina."No. Orden" := LinTabla;
        LinNomina.Ano := iAno;
        LinNomina."Concepto salarial" := perfSalario."Concepto salarial";
        LinNomina.Descripcion := perfSalario.Descripcion;
        LinNomina.Cantidad := perfSalario.Cantidad;
        LinNomina."Importe Base" := perfSalario.Importe;
        LinNomina."Currency Code" := perfSalario."Currency Code";
        LinNomina.Total := ROUND(ImporteTotal, 0.01);
        LinNomina."Tipo concepto" := perfSalario."Tipo concepto";
        LinNomina."Salario Base" := ConceptosSal."Salario Base";
        IF gTiposNom."Tipo de nomina" = gTiposNom."Tipo de nomina"::Prestaciones THEN BEGIN
            LinNomina."Cotiza ISR" := perfSalario."Cotiza ISR";
            LinNomina."Cotiza SFS" := perfSalario."Cotiza SFS";
            LinNomina."Cotiza AFP" := perfSalario."Cotiza AFP";
            LinNomina."Cotiza SRL" := perfSalario."Cotiza SRL";
            LinNomina."Cotiza Infotep" := perfSalario."Cotiza INFOTEP";
        END
        ELSE BEGIN
            LinNomina."Cotiza ISR" := ConceptosSal."Cotiza ISR";
            LinNomina."Cotiza SFS" := ConceptosSal."Cotiza SFS";
            LinNomina."Cotiza AFP" := ConceptosSal."Cotiza AFP";
            LinNomina."Cotiza SRL" := ConceptosSal."Cotiza SRL";
            LinNomina."Cotiza Infotep" := ConceptosSal."Cotiza INFOTEP";
        END;
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

        ValidaDimRequeridas(LinNomina."Dimension Set ID");
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
        DiasVacPrest := 0;
        //GRN 25/02/2020 DiasVac := FuncionesNom.CalculoDiaVacaciones(Empleado."No.",DATE2DMY(PerFinal,2),DATE2DMY(PerFinal,3),MontoVac,Empleado."Employment Date",PerFinal);
        FuncionesNom.CalculoEntreFechas(Empleado."Employment Date", PerFinal, Anos, Meses, Dias);

        IF (Anos = 0) AND (Meses <= 4) THEN
            EXIT;

        IF (Empleado."Employment Date" > PerInici) AND
           (Empleado."Employment Date" > PerFinal) THEN
            EXIT
        ELSE
            IF ((DATE2DMY(Empleado."Employment Date", 1) > DATE2DMY(PerInici, 1)) AND
                (DATE2DMY(CALCDATE('-2D', Empleado."Employment Date"), 1) > DATE2DMY(PerFinal, 1)) AND
                (DATE2DMY(Empleado."Employment Date", 2) = DATE2DMY(PerInici, 2))) THEN
                EXIT;

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

        DiasVacPrest := DiasVac; //Para fines de prestaciones

        //Elimino los dias extras que tenga de las vacaciones
        Empleado.CALCFIELDS("Dias Vacaciones");
        IF Empleado."Dias Vacaciones" > 0 THEN BEGIN
            HistVac.RESET;
            HistVac.SETRANGE("No. empleado", Empleado."No.");
            HistVac.SETRANGE("Tipo calculo", HistVac."Tipo calculo"::Adicional);
            IF (DATE2DMY(Empleado."Employment Date", 1) = 29) AND (DATE2DMY(Empleado."Employment Date", 2) = 2) AND (DATE2DMY(Empleado."Employment Date", 3) <> DATE2DMY(PerInici, 3)) THEN BEGIN
                Fecha.RESET;
                Fecha.SETRANGE("Period Type", Fecha."Period Type"::Month);
                Fecha.SETRANGE("Period Start", CALCDATE('-1A', DMY2DATE(1, 2, DATE2DMY(PerInici, 3))));
                Fecha.FINDFIRST;
                IF DATE2DMY(Empleado."Employment Date", 1) > DATE2DMY(PerFinal, 1) THEN
                    HistVac.SETRANGE("Fecha Inicio", CALCDATE('-1A', DMY2DATE(DATE2DMY(PerFinal, 1), DATE2DMY(Empleado."Employment Date", 2), DATE2DMY(PerInici, 3))))
                ELSE
                    HistVac.SETRANGE("Fecha Inicio", CALCDATE('-1A', DMY2DATE(28, DATE2DMY(Empleado."Employment Date", 2), DATE2DMY(PerInici, 3))));
                //HistVac.SETRANGE("Fecha Inicio",DMY2DATE(DATE2DMY(NORMALDATE(Fecha."Period End"),1),2,DATE2DMY(NORMALDATE(Fecha."Period End"),3)));
            END
            ELSE
                HistVac.SETRANGE("Fecha Inicio", CALCDATE('-1A', DMY2DATE(DATE2DMY(Empleado."Employment Date", 1), DATE2DMY(Empleado."Employment Date", 2), DATE2DMY(PerInici, 3))));
            IF HistVac.FINDLAST THEN
                HistVac.DELETE;
        END;

        IF ((DiasVac <> 0) AND (DATE2DMY(Empleado."Employment Date", 2) = DATE2DMY(PerInici, 2)) AND (Anos >= 1)) OR (Anos = 0) THEN BEGIN
            HistVac.RESET;
            HistVac.SETRANGE("No. empleado", Empleado."No.");
            IF DATE2DMY(Empleado."Employment Date", 1) > DATE2DMY(PerFinal, 1) THEN
                HistVac.SETRANGE("Fecha Inicio", CALCDATE('-1A', DMY2DATE(DATE2DMY(PerFinal, 1), DATE2DMY(Empleado."Employment Date", 2), DATE2DMY(PerInici, 3))))
            ELSE
                HistVac.SETRANGE("Fecha Inicio", CALCDATE('-1A', DMY2DATE(DATE2DMY(Empleado."Employment Date", 1), DATE2DMY(Empleado."Employment Date", 2), DATE2DMY(PerInici, 3))));
            //    HistVac.SETRANGE("Fecha Inicio",PerInici,DMY2DATE(DATE2DMY(Empleado."Employment Date",1),DATE2DMY(Empleado."Employment Date",2),DATE2DMY(PerFinal,3)));
            IF HistVac.FINDFIRST THEN BEGIN
                IF HistVac.Dias <> DiasVac THEN BEGIN
                    HistVac.Dias := DiasVac;
                    HistVac.MODIFY;
                END;
            END
            ELSE BEGIN
                HistVac.INIT;
                HistVac."No. empleado" := Empleado."No.";
                IF (DATE2DMY(Empleado."Employment Date", 1) = 29) AND (DATE2DMY(Empleado."Employment Date", 2) = 2) AND (DATE2DMY(Empleado."Employment Date", 3) <> DATE2DMY(PerInici, 3)) THEN BEGIN
                    Fecha.RESET;
                    Fecha.SETRANGE("Period Type", Fecha."Period Type"::Month);
                    Fecha.SETRANGE("Period Start", CALCDATE('-1A', DMY2DATE(1, 2, DATE2DMY(PerInici, 3))));
                    Fecha.FINDFIRST;

                    HistVac."Fecha Inicio" := DMY2DATE(DATE2DMY(NORMALDATE(Fecha."Period End"), 1), 2, DATE2DMY(NORMALDATE(Fecha."Period End"), 3));
                    HistVac."Fecha Fin" := CALCDATE('+1A', HistVac."Fecha Inicio");
                    HistVac.Dias := DiasVac;
                    IF HistVac.INSERT THEN;
                END
                ELSE BEGIN
                    HistVac."Fecha Inicio" := DMY2DATE(DATE2DMY(Empleado."Employment Date", 1), DATE2DMY(Empleado."Employment Date", 2), DATE2DMY(PerInici, 3));
                    HistVac."Fecha Fin" := CALCDATE('+1A', HistVac."Fecha Inicio");
                    HistVac.Dias := DiasVac;
                    IF HistVac.INSERT THEN;
                END;
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
        CabNomina.SETRANGE("Tipo de nomina", GlobalRec."Tipo de nomina");
        CabNomina.SETRANGE(Inicio, PerInici);
        CabNomina.SETRANGE(Fin, PerFinal);
        IF CabNomina.FINDFIRST THEN BEGIN
            CabNomina.CALCFIELDS("Total Ingresos");
            IF CabNomina."Total Ingresos" = 0 THEN BEGIN
                LinNomina.RESET;
                LinNomina.SETRANGE("No. empleado", GlobalRec."No. empleado");
                LinNomina.SETRANGE("Tipo de nomina", CabNomina."Tipo de nomina");
                LinNomina.SETRANGE(Periodo, CabNomina.Periodo);
                IF LinNomina.FINDSET(TRUE, FALSE) THEN
                    LinNomina.DELETEALL;

                CabNomina.DELETE();
            END;
        END;

        ReembolsaRetImp;
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
            //TODO: Ver IF Empleado."Tipo pago OLD" = Empleado."Tipo pago OLD"::"0" THEN
            //TODO: Ver     PerfilSalario.Importe := Empleado.Salario / 23.83;

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
        FiltroNominas: Text;
        E_S_MismoMes: Boolean;
        DtosIncidencias: Decimal;
        DiasInc: Decimal;
    begin
        //CalculoPrestaciones
        CantNom := 0;
        LinTabla := 1000;
        FiltroNominas := '';
        E_S_MismoMes := FALSE;

        FechaIniDT := CREATEDATETIME(Empleado."Employment Date", 0T);
        FechaFinDT := CREATEDATETIME(Contrato."Fecha finalizacion", 0T);

        FuncionesNom.CalculoEntreFechas(Empleado."Employment Date", Contrato."Fecha finalizacion", Anos, Meses, Dias);

        CalculaDiasVacaciones;

        PerfilSal.RESET;
        PerfilSal.SETRANGE("No. empleado", Empleado."No.");
        PerfilSal.SETRANGE("Tipo concepto", PerfilSal."Tipo concepto"::Ingresos);
        //PerfilSal.SETRANGE("Concepto salarial",ConfNominas."Concepto Sal. Base");
        PerfilSal.SETRANGE("Salario Base", TRUE);
        PerfilSal.FINDSET;
        REPEAT
            IF PerfilSal."Concepto salarial" = ConfNominas."Concepto Sal. Base" THEN
                Salario += PerfilSal.Importe
            ELSE
                IF PerfilSal.Cantidad <> 0 THEN
                    Salario += PerfilSal.Importe;
        UNTIL PerfilSal.NEXT = 0;

        gTN.RESET;
        gTN.SETRANGE("Tipo de nomina", gTN."Tipo de nomina"::Regular);
        gTN.FINDSET;
        REPEAT
            IF FiltroNominas = '' THEN
                FiltroNominas += gTN.Codigo
            ELSE
                FiltroNominas += '|' + gTN.Codigo;
        UNTIL gTN.NEXT = 0;

        HistLinNom.RESET;
        HistLinNom.SETRANGE("No. empleado", Empleado."No.");
        IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Mensual THEN BEGIN
            //Verifico si es 1ra o segunda quincena la ultima calculada
            HistLinNom2.RESET;
            HistLinNom2.SETRANGE("No. empleado", Empleado."No.");
            HistLinNom2.SETFILTER("Tipo de nomina", FiltroNominas);
            HistLinNom2.FINDLAST;
            IF DATE2DMY(HistLinNom2.Periodo, 2) <> DATE2DMY(Empleado."Termination Date", 2) THEN
                HistLinNom.SETRANGE(Periodo, CALCDATE('-12M', DMY2DATE(1, DATE2DMY(Empleado."Termination Date", 2), DATE2DMY(Empleado."Termination Date", 3))),
                                         CALCDATE('-1M', Empleado."Termination Date"))
            ELSE
                IF (Empleado."Employment Date" >= DMY2DATE(gTN."Dia inicio 1ra", DATE2DMY(Empleado."Termination Date", 2), DATE2DMY(Empleado."Termination Date", 3))) THEN
                    HistLinNom.SETRANGE(Periodo, DMY2DATE(gTN."Dia inicio 1ra", DATE2DMY(Empleado."Termination Date", 2), DATE2DMY(Empleado."Termination Date", 3)), Empleado."Termination Date")
                ELSE
                    HistLinNom.SETRANGE(Periodo, CALCDATE('-12M', DMY2DATE(1, DATE2DMY(Empleado."Termination Date", 2), DATE2DMY(Empleado."Termination Date", 3))),
                                             CALCDATE('-1M', Empleado."Termination Date"));
        END
        ELSE
            IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal THEN BEGIN
                //Verifico si es 1ra o segunda quincena la ultima calculada
                HistLinNom2.RESET;
                HistLinNom2.SETRANGE("No. empleado", Empleado."No.");
                HistLinNom2.SETFILTER("Tipo de nomina", FiltroNominas);
                HistLinNom2.FINDLAST;
                IF DATE2DMY(HistLinNom2.Periodo, 1) >= 15 THEN
                    HistLinNom.SETRANGE(Periodo, CALCDATE('-12M', DMY2DATE(1, DATE2DMY(Empleado."Termination Date", 2), DATE2DMY(Empleado."Termination Date", 3))),
                                             Empleado."Termination Date")
                ELSE
                    HistLinNom.SETRANGE(Periodo, CALCDATE('-12M', DMY2DATE(16, DATE2DMY(Empleado."Termination Date", 2), DATE2DMY(Empleado."Termination Date", 3))),
                                             Empleado."Termination Date");
            END;
        HistLinNom.SETRANGE("Salario Base", TRUE);
        IF HistLinNom.FINDSET THEN
            REPEAT
                //Verifico si se ha contratado y se ha pagado nomina en el mismo mes.
                IF (Empleado."Employment Date" >= DMY2DATE(gTN."Dia inicio 1ra", DATE2DMY(Empleado."Termination Date", 2), DATE2DMY(Empleado."Termination Date", 3))) THEN
                    E_S_MismoMes := TRUE;
                IF NOT E_S_MismoMes THEN BEGIN
                    PromedioSalarioAnual += HistLinNom.Total;
                    IF HistLinNom."Concepto salarial" = ConfNominas."Concepto Sal. Base" THEN
                        CantNom += 1;
                END;
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
        PerfilSal.SETRANGE("Tipo de nomina", GlobalRec."Tipo de nomina");
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

        IF NOT E_S_MismoMes THEN BEGIN
            PromedioSalarioMensual := PromedioSalarioAnual / CantNom;
            PromedioSalarioDiario := PromedioSalarioMensual / 23.83;
        END;

        IF DATE2DMY(Contrato."Fecha finalizacion", 2) <> 1 THEN BEGIN
            HistLinNom.RESET;
            HistLinNom.SETRANGE("No. empleado", Empleado."No.");
            IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Mensual THEN
                HistLinNom.SETRANGE(Periodo, CALCDATE('-12M', DMY2DATE(1, DATE2DMY(Empleado."Termination Date", 2), DATE2DMY(Empleado."Termination Date", 3))),
                                         Empleado."Termination Date")
            ELSE
                IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal THEN
                    HistLinNom.SETRANGE(Periodo, CALCDATE('-11M', DMY2DATE(1, DATE2DMY(Empleado."Termination Date", 2), DATE2DMY(Empleado."Termination Date", 3))),
                                             Empleado."Termination Date");

            HistLinNom.SETRANGE("Aplica para Regalia", TRUE);
            IF HistLinNom.FINDSET THEN
                REPEAT
                    MontoRegalia += HistLinNom.Total;
                UNTIL HistLinNom.NEXT = 0;

            MontoRegalia := MontoRegalia / 12;
        END;
        //MESSAGE('%1 %2 %3',PromedioSalarioMensual,PromedioSalarioAnual);


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
        IF NOT E_S_MismoMes THEN
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

        //Pago de vacaciones  REVISAR CONFIG PRIMA Y VACACIONES
        IF ConfNominas."Adelantar salario vacaciones" THEN BEGIN
            ImporteTotal := 0;
            LinTabla += 1000;
            Empleado.CALCFIELDS("Dias Vacaciones");

            IF (Anos < 1) THEN
                Empleado."Dias Vacaciones" := DiasVacPrest;

            IF Empleado."Dias Vacaciones" > 0 THEN BEGIN
                PerfilSalLiq.RESET;
                PerfilSalLiq.SETRANGE("No. empleado", Empleado."No.");
                PerfilSalLiq.SETRANGE("Concepto salarial", ConfNominas."Concepto Vacaciones");
                IF PerfilSalLiq.FINDFIRST THEN BEGIN
                    PerfilSalLiq."Tipo de nomina" := GlobalRec."Tipo de nomina";
                    ImporteTotal := ROUND(Empleado."Dias Vacaciones" * Salario / 23.83, 0.01);
                    PerfilSalLiq.Importe := ROUND(Salario / 23.83, 0.01);
                    PerfilSalLiq.Cantidad := Empleado."Dias Vacaciones";
                    //PerfilSalLiq.MODIFY(TRUE);
                    IF ImporteTotal <> 0 THEN
                        InsertNomina(PerfilSalLiq);
                END;
            END;
        END
        ELSE BEGIN
            ImporteTotal := 0;
            LinTabla += 1000;
            PerfilSalLiq.RESET;
            PerfilSalLiq.SETRANGE("No. empleado", Empleado."No.");
            PerfilSalLiq.SETRANGE("Concepto salarial", ConfNominas."Concepto Vacaciones");
            IF PerfilSalLiq.FINDFIRST THEN BEGIN
                PerfilSalLiq."Tipo de nomina" := GlobalRec."Tipo de nomina";
                ImporteTotal := PerfilSalLiq.Cantidad * PerfilSalLiq.Importe;
                //PerfilSalLiq.MODIFY(TRUE);
                IF ImporteTotal <> 0 THEN
                    InsertNomina(PerfilSalLiq);
            END;
        END;


        //Verifico si debemos descontar dias de ausencias

        DtosIncidencias := 0;
        DiasInc := 0;
        Incidencias.RESET;
        Incidencias.SETRANGE("Employee No.", Empleado."No.");
        Incidencias.SETFILTER("From Date", '>=%1', DMY2DATE(1, DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)));
        Incidencias.SETFILTER("To Date", '<=%1', PerFinal);
        Incidencias.SETFILTER("% To deduct", '<>%1', 0);
        IF Incidencias.FINDSET THEN BEGIN
            REPEAT
                DtosIncidencias += ROUND(Empleado.Salario / 23.83 * Incidencias."% To deduct" / 100 * Incidencias.Quantity, 0.01);
                DiasInc += Incidencias.Quantity;
                IF NOT Incidencias.Closed THEN BEGIN
                    Incidencias.Closed := TRUE;
                    Incidencias.MODIFY;
                END;
            UNTIL Incidencias.NEXT = 0;

            //Busco el concepto del descuento
            PerfilSalLiq.RESET;
            PerfilSalLiq.SETRANGE("No. empleado", Empleado."No.");
            PerfilSalLiq.SETRANGE("Concepto salarial", ConfNominas."Concepto Inasistencia");
            PerfilSalLiq.FINDFIRST;

            PerfilSalLiq."Tipo de nomina" := GlobalRec."Tipo de nomina";
            PerfilSalLiq.Importe := ROUND(DtosIncidencias, 0.01);
            PerfilSalLiq.Cantidad := DiasInc;
            PerfilSalLiq.Comentario := STRSUBSTNO(Text009, DiasInc, Incidencias.Description);
            ImporteTotal := DtosIncidencias * -1;
            IF ImporteTotal <> 0 THEN
                InsertNomina(PerfilSalLiq);
        END;

        IF NOT E_S_MismoMes THEN
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
        PerfilSalLiq: Record 34002115;
        lFecha: Record 2000000007;
        Anos: Integer;
        Meses: Integer;
        Dias: Integer;
        FechaFin: Date;
        AcumuladoRegalia: Decimal;
    begin
        //Regalia
        AcumuladoRegalia := 0;
        TipoNomina.RESET;
        TipoNomina.SETRANGE("Tipo de nomina", TipoNomina."Tipo de nomina"::Regular);
        TipoNomina.SETRANGE("Frecuencia de pago", Contrato."Frecuencia de pago");
        TipoNomina.FINDFIRST;

        lFecha.RESET;
        lFecha.SETRANGE("Period Type", lFecha."Period Type"::Month);
        lFecha.SETRANGE("Period Start", DMY2DATE(1, DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)));
        lFecha.FINDFIRST;
        FechaFin := NORMALDATE(lFecha."Period End");

        LinNomina.RESET;
        LinNomina.SETRANGE("No. empleado", Empleado."No.");

        IF (TipoNomina."Dia inicio 1ra" > TipoNomina."Dia inicio 2da") AND (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) THEN
            LinNomina.SETRANGE(Periodo, DMY2DATE(TipoNomina."Dia inicio 1ra", 12, DATE2DMY(CALCDATE('-12M', PerInici), 3)), PerFinal)
        ELSE
            LinNomina.SETRANGE(Periodo, DMY2DATE(1, 1, DATE2DMY(PerInici, 3)), FechaFin);

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
        IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Mensual THEN
            LinNomina.SETRANGE(Periodo, CALCDATE('-12M', DMY2DATE(1, DATE2DMY(Contrato."Fecha finalizacion", 2), DATE2DMY(Contrato."Fecha finalizacion", 3))),
                                     Empleado."Termination Date")
        ELSE
            IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal THEN
                LinNomina.SETRANGE(Periodo, CALCDATE('-51' + "CDateSymbol-W", DMY2DATE(1, DATE2DMY(Contrato."Fecha finalizacion", 2), DATE2DMY(Contrato."Fecha finalizacion", 3))),
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
                IF DATE2DMY(HistLinNom2.Periodo, 1) >= 15 THEN BEGIN
                    DiasSalario := Contrato."Fecha finalizacion" - DMY2DATE(TipoNomina."Dia inicio 1ra", DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)) + 1;
                    Fecha.SETRANGE("Period Start", DMY2DATE(TipoNomina."Dia inicio 1ra", DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)), Contrato."Fecha finalizacion");
                END
                ELSE BEGIN
                    IF (DATE2DMY(Contrato."Fecha finalizacion", 2) = 2) AND ((DATE2DMY(Contrato."Fecha finalizacion", 1) = DATE2DMY(PerFinal, 1))) THEN
                        DiasSalario := 15
                    ELSE
                        DiasSalario := Contrato."Fecha finalizacion" - DMY2DATE(TipoNomina."Dia inicio 2da", DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)) + 1;
                    Fecha.SETRANGE("Period Start", DMY2DATE(TipoNomina."Dia inicio 2da", DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)), Contrato."Fecha finalizacion");
                END;
            END;
        END
        ELSE BEGIN
            FechaIniDT := CREATEDATETIME(DMY2DATE(TipoNomina."Dia inicio 1ra", DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)), 0T);
            FechaFinDT := CREATEDATETIME(Contrato."Fecha finalizacion", 0T);
            DiasSalario := FuncionesNom.CalculoEntreFechaDotNet('d', FechaIniDT, FechaFinDT);
            Fecha.SETRANGE("Period Start", DMY2DATE(TipoNomina."Dia inicio 1ra", DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)), Contrato."Fecha finalizacion");
            DiasSalario += 1;
        END;
        // error('%1',salario);
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
            DiasSalario := 0
        ELSE
            IF (DATE2DMY(Contrato."Fecha finalizacion", 2) = 2) AND ((DATE2DMY(Contrato."Fecha finalizacion", 1) = DATE2DMY(PerFinal, 1))) THEN
                DiasSalario := 15;

        IF (DiasSalario = 15) AND (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) THEN BEGIN
            MontoRestante := ROUND(Salario / 2, 0.01);
            DiasSalario := 1;
        END
        ELSE
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
        DeduccGob.SETRANGE(Ano, iAno);
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

            LinNominasES.RESET;
            LinNominasES.SETRANGE("No. empleado", GlobalRec."No. empleado");
            IF (TiposNomPrest."Dia inicio 1ra" > TiposNomPrest."Dia inicio 2da") AND (Contrato."Frecuencia de pago" <> Contrato."Frecuencia de pago"::Mensual) THEN
                LinNominasES.SETRANGE(Periodo, DMY2DATE(TiposNomPrest."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
            ELSE
                IF SegundaQ AND (Contrato."Frecuencia de pago" <> Contrato."Frecuencia de pago"::Mensual) THEN BEGIN
                    IF TiposNomPrest."Frecuencia de pago" = TiposNomPrest."Frecuencia de pago"::Diaria THEN
                        LinNominasES.SETRANGE(Periodo, PerInici, PerFinal)
                    ELSE
                        LinNominasES.SETRANGE(Periodo, DMY2DATE(TiposNomPrest."Dia inicio 1ra", DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)), PerFinal)
                END
                ELSE
                    IF ((TiposNomPrest."Dia inicio 1ra" > TiposNomPrest."Dia inicio 2da") AND (TiposNomPrest."Dia inicio 1ra" <> 0) AND (TiposNomPrest."Dia inicio 2da" <> 0)) AND (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Mensual) THEN
                        LinNominasES.SETRANGE(Periodo, DMY2DATE(TiposNomPrest."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                    ELSE
                        IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Mensual THEN
                            LinNominasES.SETRANGE(Periodo, DMY2DATE(TiposNomPrest."Dia inicio 1ra", DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)), PerFinal)
                        ELSE
                            LinNominasES.SETRANGE(Periodo, PerInici, PerFinal);

            IF ConfNominas."Concepto AFP" = DeduccGob.Codigo THEN
                LinNominasES.SETRANGE("Cotiza AFP", TRUE)
            ELSE
                IF ConfNominas."Concepto INFOTEP" = DeduccGob.Codigo THEN
                    LinNominasES.SETRANGE("Cotiza Infotep", TRUE)
                ELSE
                    IF ConfNominas."Concepto SRL" = DeduccGob.Codigo THEN
                        LinNominasES.SETRANGE("Cotiza SRL", TRUE)
                    ELSE
                        IF ConfNominas."Concepto SFS" = DeduccGob.Codigo THEN
                            LinNominasES.SETRANGE("Cotiza SFS", TRUE);
            //ERROR('%1',LinNominases.GETFILTERS);
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

                //Busco el importe cobrado del impuesto
                ImporteImpuestos := 0;
                LinNominasES.RESET;
                LinNominasES.SETRANGE("No. empleado", GlobalRec."No. empleado");
                IF (TiposNomPrest."Dia inicio 1ra" > TiposNomPrest."Dia inicio 2da") AND (Contrato."Frecuencia de pago" <> Contrato."Frecuencia de pago"::Mensual) THEN
                    LinNominasES.SETRANGE(Periodo, DMY2DATE(TiposNomPrest."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                ELSE
                    IF SegundaQ AND (Contrato."Frecuencia de pago" <> Contrato."Frecuencia de pago"::Mensual) THEN BEGIN
                        IF TiposNomPrest."Frecuencia de pago" = TiposNomPrest."Frecuencia de pago"::Diaria THEN
                            LinNominasES.SETRANGE(Periodo, PerInici, PerFinal)
                        ELSE
                            LinNominasES.SETRANGE(Periodo, DMY2DATE(TiposNomPrest."Dia inicio 1ra", DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)), PerFinal)
                    END
                    ELSE
                        IF ((TiposNomPrest."Dia inicio 1ra" > TiposNomPrest."Dia inicio 2da") AND (TiposNomPrest."Dia inicio 1ra" <> 0) AND (TiposNomPrest."Dia inicio 2da" <> 0)) AND (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Mensual) THEN
                            LinNominasES.SETRANGE(Periodo, DMY2DATE(TiposNomPrest."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', PerInici), 2), DATE2DMY(CALCDATE('-1M', PerInici), 3)), PerFinal)
                        ELSE
                            IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Mensual THEN
                                LinNominasES.SETRANGE(Periodo, DMY2DATE(TiposNomPrest."Dia inicio 1ra", DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)), PerFinal)
                            ELSE
                                LinNominasES.SETRANGE(Periodo, PerInici, PerFinal);

                LinNominasES.SETRANGE("Concepto salarial", DeduccGob.Codigo);
                IF LinNominasES.FINDSET THEN
                    REPEAT
                        ImporteImpuestos += LinNominasES.Total;
                    UNTIL LinNominasES.NEXT = 0;

                IF (ImporteCotizacion >= DeduccGob."Tope Salarial/Acumulado Anual") AND
                   (DeduccGob."Tope Salarial/Acumulado Anual" <> 0) THEN BEGIN
                    ImporteCotizacion := DeduccGob."Tope Salarial/Acumulado Anual";
                    ImporteCotizacionEmp := ImporteCotizacion;
                    MontoAplicar := ImporteCotizacion * DeduccGob."Porciento Empleado" / 100;
                    MontoAplicar += ImporteImpuestos;
                    IF MontoAplicar < 0 THEN
                        MontoAplicar := 0;
                END;

                IF ABS(ImporteImpuestos) >= MontoAplicar THEN
                    IndSkip := TRUE;
                //ERROR('%1 %2 \%3\%4',ImporteImpuestos,MontoAplicar,LinNominasES.GETFILTERS,ImporteCotizacion);

                IF NOT IndSkip THEN BEGIN
                    PerfilSalTr.Importe := ImporteCotizacion;
                    PerfilSalTr.Cantidad := 1;

                    ImporteTotal := MontoAplicar * -1;
                    "%Cot" := DeduccGob."Porciento Empleado";
                    LinTabla += 10;
                    IF ImporteTotal <> 0 THEN
                        InsertNomina(PerfilSalTr);

                END
                ELSE
                    EXIT;
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

    local procedure ProcesaCooperativa()
    var
        Movcooperativa: Record 34002196;
    begin
    end;

    local procedure ValidaDimRequeridas(DimSetID: Integer)
    var
        DimensionesContab: Record 34002132;
        DimSetEntry: Record 480;
    begin
        DimensionesContab.RESET;
        DimensionesContab.SETRANGE(Requerida, TRUE);
        IF DimensionesContab.FINDSET THEN
            REPEAT
                DimSetEntry.RESET;
                DimSetEntry.SETRANGE("Dimension Set ID", DimSetID);
                DimSetEntry.SETRANGE("Dimension Code", DimensionesContab."Cod. Dimension");
                IF NOT DimSetEntry.FINDFIRST THEN
                    ERROR(STRSUBSTNO(Err006, DimensionesContab."Cod. Dimension", Empleado."No." + ' - ' + Empleado."Full Name"));
            UNTIL DimensionesContab.NEXT = 0;
    end;

    local procedure ValidaVacPagadas()
    var
        HistLinNomVac: Record 34002118;
        HistLinNomVac2: Record 34002118;
        TiposNomVac: Record 34002158;
        EmployeeAbsence: Record 5207;
        CauseofAbsence: Record 5206;
        MesVac: Integer;
        MesNom: Integer;
        DiasDtoVac: Decimal;
        SalNetoCalc: Decimal;
        SalBruto: Decimal;
    begin
        RollOver := FALSE;
        RollBack := FALSE;
        Empleado.CALCFIELDS(Salario);

        TiposNomVac.RESET;
        TiposNomVac.SETRANGE("Tipo de nomina", TiposNomVac."Tipo de nomina"::Regular);
        IF NOT TiposNomVac.FINDFIRST THEN
            EXIT;

        ImporteVacPagado := 0;
        //DiasDisfruteVac := FuncionesNom.CalculoDiaVacaciones(GlobalRec."No. empleado",iMes,iAno,ImporteVacPagado,Empleado."Employment Date",PerFinal);
        MesVac := DATE2DMY(Contrato."Fecha inicio", 2);
        IF MesVac + 1 > 12 THEN
            MesVac := 0;

        //Busco rango de los dias de vacaciones disfrutados en registro de ausencias
        CauseofAbsence.RESET;
        CauseofAbsence.SETRANGE("Tipo de novedad TSS", CauseofAbsence."Tipo de novedad TSS"::Vacaciones);
        CauseofAbsence.FINDFIRST;

        CLEAR(Incidencias);
        Incidencias.SETCURRENTKEY("Employee No.", "From Date");
        Incidencias.SETRANGE("Employee No.", Empleado."No.");
        Incidencias.SETFILTER("From Date", '>=%1', DMY2DATE(1, DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)));
        Incidencias.SETRANGE("Cause of Absence Code", CauseofAbsence.Code);
        IF Incidencias.FINDFIRST THEN
            IF DATE2DMY(Incidencias."To Date", 2) > DATE2DMY(PerInici, 2) THEN
                RollOver := TRUE;

        IF NOT RollOver THEN BEGIN
            CLEAR(Incidencias);
            Incidencias.SETCURRENTKEY("From Date", "To Date");
            Incidencias.SETRANGE("Employee No.", Empleado."No.");
            Incidencias.SETFILTER("To Date", '<=%1', PerFinal);
            Incidencias.SETRANGE("Cause of Absence Code", CauseofAbsence.Code);
            IF Incidencias.FINDLAST THEN
                IF DATE2DMY(Incidencias."From Date", 2) + 1 = DATE2DMY(PerInici, 2) THEN
                    RollBack := TRUE;
        END;

        HistLinNomVac.RESET;
        HistLinNomVac.SETRANGE("No. empleado", GlobalRec."No. empleado");
        HistLinNomVac.SETFILTER(Periodo, '<=%1', PerInici);
        HistLinNomVac.SETRANGE("Concepto salarial", ConfNominas."Concepto Vacaciones");
        IF HistLinNomVac.FINDLAST THEN BEGIN
            IF DATE2DMY(HistLinNomVac.Periodo, 2) = DATE2DMY(PerFinal, 2) THEN BEGIN
                DiasDisfruteVac := HistLinNomVac.Cantidad;
                //ImporteVacPagado := HistLinNomVac.Total;
                ImporteVacPagado := ROUND(Empleado.Salario / 23.83 * DiasDisfruteVac, 0.01);
            END;

            //Calculo los dias a pagar en el presente mes
            IF RollOver THEN BEGIN
                Fecha.RESET;
                Fecha.SETRANGE("Period Type", 0); //Dia
                IF (DATE2DMY(PerFinal, 1) < 31) OR (DATE2DMY(PerFinal, 1) < 30) THEN
                    Fecha.SETRANGE("Period Start", Incidencias."From Date", PerFinal)
                ELSE
                    Fecha.SETRANGE("Period Start", Incidencias."From Date", DMY2DATE(30, DATE2DMY(PerFinal, 2), DATE2DMY(PerFinal, 3)));
                Fecha.SETRANGE("Period No.", 1, 6);//Sabado
                IF Fecha.FINDSET THEN
                    REPEAT
                        CASE Fecha."Period No." OF
                            6:
                                DiasDtoVac += 0.5;
                            ELSE
                                DiasDtoVac += 1;
                        END;
                    UNTIL Fecha.NEXT = 0;

                //ImporteVacPagado := HistLinNomVac."Importe Base" * DiasDtoVac;
                //ImporteVacPagado := HistLinNomVac."Importe Base" * DiasDtoVac;
                ImporteVacPagado := ROUND(Empleado.Salario / 23.83 * DiasDtoVac, 0.01);
            END
            ELSE
                IF RollBack THEN BEGIN
                    //Buscos lo descontado anteriormente
                    HistLinNomVac2.RESET;
                    HistLinNomVac2.SETCURRENTKEY("No. empleado", "Tipo concepto", Periodo, "Concepto salarial");
                    HistLinNomVac2.SETRANGE("No. empleado", GlobalRec."No. empleado");
                    HistLinNomVac2.SETRANGE(Periodo, CALCDATE('-1M', PerInici), CALCDATE('-1D', PerInici));
                    HistLinNomVac2.SETRANGE("Concepto salarial", ConfNominas."Concepto Vacaciones");
                    IF HistLinNomVac2.FINDLAST THEN BEGIN
                        IF DATE2DMY(HistLinNomVac2.Periodo, 2) + 1 = DATE2DMY(PerFinal, 2) THEN BEGIN
                            ImporteVacPagado := HistLinNomVac2."Importe Base" - HistLinNomVac2.Total;
                            ImporteVacPagado := HistLinNomVac.Total - ImporteVacPagado;
                            DiasDisfruteVac := 1;
                        END;
                    END;
                END
        END;
    end;

    local procedure PagarVacAut()
    var
        EmployeeAbsence: Record 5207;
        CauseofAbsence: Record 5206;
        MontoVac: Decimal;
    begin
        //Busco rango de los dias de vacaciones a disfrutar en registro de ausencias
        CauseofAbsence.RESET;
        CauseofAbsence.SETRANGE("Tipo de novedad TSS", CauseofAbsence."Tipo de novedad TSS"::Vacaciones);
        CauseofAbsence.FINDFIRST;

        CLEAR(Incidencias);
        Incidencias.SETCURRENTKEY("Employee No.", "From Date");
        Incidencias.SETRANGE("Employee No.", Empleado."No.");
        Incidencias.SETFILTER("From Date", '>=%1', DMY2DATE(1, DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)));
        Incidencias.SETRANGE("Cause of Absence Code", CauseofAbsence.Code);
        IF Incidencias.FINDFIRST THEN BEGIN
            CalculaDiasVacaciones;
            DiasVacPrest := FuncionesNom.CalculoDiaVacaciones(Empleado."No.", DATE2DMY(PerFinal, 2), DATE2DMY(PerFinal, 3), MontoVac, Empleado."Employment Date", PerFinal);
            Empleado.CALCFIELDS(Salario);
            ImporteTotal := Empleado.Salario / 23.83;
            ImporteTotal := ImporteTotal * DiasVacPrest;
            ImporteTotal := ImporteTotal / 14;
            PerfilSal.RESET;
            PerfilSal.SETRANGE("No. empleado", GlobalRec."No. empleado");
            PerfilSal.SETRANGE("Concepto salarial", ConfNominas."Concepto Vacaciones");
            PerfilSal.SETRANGE("Tipo de nomina", GlobalRec."Tipo de nomina");
            PerfilSal.FINDFIRST;

            PerfilSal.Cantidad := Incidencias.Quantity;
            PerfilSal.Importe := ROUND(ImporteTotal, 0.01);

            ImporteTotal := ROUND(Incidencias.Quantity * ImporteTotal, 0.01);
            LinTabla += 10;
            InsertNomina(PerfilSal);
        END;
    end;

    local procedure Calculaantiguedad()
    var
        FechaIniDT: DateTime;
        FechaFinDT: DateTime;
        lDate: Date;
    begin
        lDate := TODAY;
        FuncionesNom.CalculoEntreFechas(Empleado."Employment Date", lDate, Anos, Meses, Dias);
    end;

    local procedure ReembolsaRetImp()
    var
        TotalImpyRet: Decimal;
    begin
        //GRN Reembolso las retenciones e impuestos para pagar solo neto

        TotalImpyRet := 0;
        LinNomina.RESET;
        LinNomina.SETRANGE("No. empleado", GlobalRec."No. empleado");
        LinNomina.SETRANGE("Tipo de nomina", CabNomina."Tipo de nomina");
        LinNomina.SETRANGE("Inicio periodo", PerInici);
        LinNomina.SETRANGE("Fin periodo", PerFinal);
        LinNomina.SETFILTER("Concepto salarial", '%1|%2|%3', ConfNominas."Concepto AFP", ConfNominas."Concepto SFS", ConfNominas."Concepto ISR");
        IF LinNomina.FINDSET THEN
            REPEAT
                TotalImpyRet += LinNomina.Total;
            UNTIL LinNomina.NEXT = 0;

        IF TotalImpyRet <> 0 THEN BEGIN
            ConfNominas.TESTFIELD("Concepto Reembolso gtos.");
            PerfilSal.RESET;
            PerfilSal.SETRANGE("No. empleado", GlobalRec."No. empleado");
            PerfilSal.SETRANGE("Concepto salarial", ConfNominas."Concepto Reembolso gtos.");
            PerfilSal.FINDFIRST;
            PerfilSal.Cantidad := 1;
            PerfilSal.Importe := ABS(TotalImpyRet);

            LinTabla += 10;
            ImporteTotal := PerfilSal.Importe;
            InsertNomina(PerfilSal);
        END;
    end;
}

