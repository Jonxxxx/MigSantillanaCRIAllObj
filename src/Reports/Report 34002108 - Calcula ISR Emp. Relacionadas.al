report 34002108 "Calcula ISR Emp. Relacionadas"
{
    Caption = 'Calculate TAX Related Companies';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Historico Cab. nomina"; 34002117)
        {
            DataItemTableView = SORTING("No. empleado", Ano, Periodo, "Tipo Nomina");
            RequestFilterFields = "Tipo Nomina", Periodo, "No. empleado";

            trigger OnAfterGetRecord()
            begin
                PrimeraQ := DATE2DMY(Periodo, 1) < 16;
                SegundaQ := DATE2DMY(Periodo, 1) >= 16;
                PerInici := Inicio;
                PerFinal := Fin;
                iMes := DATE2DMY(PerInici, 2);
                iAno := DATE2DMY(PerInici, 3);

                Empleado.GET("No. empleado");
                Puestos.GET(Empleado."Job Type Code");

                IF CodEmpl <> "No. empleado" THEN BEGIN
                    TotalCompany := 0;
                    "%Cot" := 0;
                    CLEAR(TotalISR);
                    CodEmpl := "No. empleado";
                END;

                ConfNominas.GET();

                GlobalRec.RESET;
                GlobalRec.SETRANGE("No. empleado", "No. empleado");
                GlobalRec.FINDFIRST;

                Contrato.RESET;
                Contrato.SETRANGE("No. empleado", GlobalRec."No. empleado");
                Contrato.SETRANGE(Activo, TRUE);
                Contrato.FINDFIRST;

                EmpresasRel.RESET;
                EmpresasRel.SETRANGE("Cod. Empleado", GlobalRec."No. empleado");
                IF NOT EmpresasRel.FINDFIRST THEN
                    CurrReport.SKIP
                ELSE
                    IF COMPANYNAME <> EmpresasRel.Empresa THEN
                        CalcularISR;
            end;

            trigger OnPreDataItem()
            begin
                CodEmpl := '';
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
                group()
                {
                    field(PerNomina; PerNomina)
                    {
                        Caption = 'Daily,Weekly,Bi-Weekly,Half Month,Monthly,Yearly';
                    }
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
        MESSAGE(Text001);
    end;

    var
        ConfNominas: Record 34002103;
        Empleado: Record 5200;
        GlobalRec: Record 34002115;
        Contrato: Record 34002109;
        ConceptosSal: Record 34002111;
        PerfilSalImp: Record 34002115;
        EmpresasRel: Record 34002150;
        DfltDimension: Record 352;
        HistLinNom: Record 34002118;
        Puestos: Record 34002110;
        recTmpDimEntry: Record 480 temporary;
        cduDim: Codeunit 408;
        TotalISR: array[3, 3] of Decimal;
        LinTabla: Decimal;
        "%Cot": Decimal;
        PerInici: Date;
        PerFinal: Date;
        IngresoSalario: Decimal;
        TotalCompany: Decimal;
        PrimeraQ: Boolean;
        SegundaQ: Boolean;
        iAno: Integer;
        iMes: Integer;
        ImporteTotal: Decimal;
        CodEmpl: Code[20];
        DimSetID: Integer;
        PerNomina: Option Diaria,Semanal,"Bi-Semanal",Quincenal,Mensual,Anual;
        Text001: Label 'Fin del proceso, favor de verificar los datos historicos';

    procedure CalcularISR()
    var
        RetencionISR: Record 34002131;
        SaldoFavor: Record 34002128;
        SaldoFavor2: Record 34002128;
        HistLinNomISR: Record 34002118;
        BKSaldoFavor: Record 34002130;
        LinAportesEmpresa: Record 34002122;
        EmpresasRel2: Record 34002150;
        LinEsqPercepISR: Record 34002115;
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
        Err002: Label 'Employee %1 doesn''t have posted payroll in company %2, please verify';
    begin
        //CalculoISR
        Importe1 := 0;
        Importe2 := 0;
        Importe3 := 0;

        EmpresasRel.RESET;
        EmpresasRel.SETRANGE("Cod. Empleado", GlobalRec."No. empleado");
        IF EmpresasRel.FINDFIRST THEN BEGIN
            IF COMPANYNAME <> EmpresasRel.Empresa THEN BEGIN
                EmpresasRel2.RESET;
                EmpresasRel2.SETRANGE("Cod. Empleado", GlobalRec."No. empleado");
                EmpresasRel2.FINDSET;
                REPEAT
                    HistLinCompany.RESET;
                    HistLinCompany.CHANGECOMPANY(EmpresasRel2.Empresa);
                    HistLinCompany.SETRANGE("No. empleado", EmpresasRel2."Cod. Empleado en empresa");
                    HistLinCompany.SETRANGE(Periodo, "Historico Cab. nomina".Inicio, "Historico Cab. nomina".Fin);
                    HistLinCompany.SETRANGE("Cotiza ISR", TRUE);
                    HistLinCompany.SETRANGE("Salario Base", TRUE);
                    IF HistLinCompany.FINDSET THEN
                        REPEAT
                            IF Empleado."Employment Date" >= PerInici THEN
                                TotalCompany += HistLinCompany.Total
                            ELSE
                                TotalCompany += HistLinCompany."Importe Base";
                        UNTIL HistLinCompany.NEXT = 0
                    ELSE
                        ERROR(Err002, Empleado."Full Name", EmpresasRel2.Empresa);
                UNTIL EmpresasRel2.NEXT = 0;
            END
            ELSE
                EXIT;
        END;

        //Busqueda de todos los conceptos que cotizan para el calculo del ISR
        HistLinNom.RESET;
        HistLinNom.SETRANGE("No. empleado", GlobalRec."No. empleado");
        HistLinNom.SETRANGE("Tipo nomina", "Historico Cab. nomina"."Tipo Nomina");
        HistLinNom.SETRANGE(Periodo, "Historico Cab. nomina".Inicio, "Historico Cab. nomina".Fin);
        HistLinNom.SETRANGE("Cotiza ISR", TRUE);
        IF HistLinNom.FIND('-') THEN
            REPEAT
                IF HistLinNom.Total <> 0 THEN
                    TotalISR[1] [1] += HistLinNom.Total;
            UNTIL HistLinNom.NEXT = 0;

        ReCalcularTSSDistribuido;

        //TotalCompany += TotalISR[1][1];
        //TotalISR[1][1] := TotalCompany;
        Base := TotalISR[1] [1];

        // Calculo del ISR. Busqueda de Rangos ISR
        Indice := 1;
        RetencionISR.SETRANGE(Ano, FORMAT(iAno, 4, '<Standard Format,0>'));
        RetencionISR.FIND('-');
        REPEAT
            RangoISR[Indice] := RetencionISR."Importe M´Š¢ximo";
            ImporteRetencion[Indice] := RetencionISR."Importe retencion";
            "%Calcular"[Indice] := RetencionISR."% Retencion";
            Indice += 1;
        UNTIL RetencionISR.NEXT = 0;

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

        CLEAR(PerfilSalImp);

        PerfilSalImp.SETRANGE("No. empleado", GlobalRec."No. empleado");
        PerfilSalImp.SETRANGE("Concepto salarial", ConfNominas."Concepto ISR");
        IF NOT PerfilSalImp.FINDFIRST THEN
            EXIT;

        IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal THEN
            IF ((PerfilSalImp."1ra Quincena" <> PrimeraQ) AND PrimeraQ) OR ((PerfilSalImp."2da Quincena" <> SegundaQ) AND SegundaQ) THEN
                EXIT;

        IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) AND
           (PerfilSalImp."1ra Quincena") AND (PerfilSalImp."2da Quincena") AND (PrimeraQ) AND
           (Puestos."M´Š¢todo Calculo Paga Salario" = 0) THEN
            TotalISR[1] [1] := ROUND(TotalISR[1] [1] / 2, 0.01)
        ELSE BEGIN
            HistLinNomISR.RESET;
            HistLinNomISR.SETRANGE("No. empleado", GlobalRec."No. empleado");
            HistLinNomISR.SETRANGE(Periodo, DMY2DATE(1, DATE2DMY(PerInici, 2), DATE2DMY(PerInici, 3)), PerFinal);
            HistLinNomISR.SETRANGE("Concepto salarial", ConfNominas."Concepto ISR");
            IF HistLinNomISR.FINDSET THEN
                REPEAT
                    IF HistLinNomISR.Periodo <> PerInici THEN
                        TotalISR[1] [1] := TotalISR[1] [1] + HistLinNomISR.Total;
                UNTIL HistLinNomISR.NEXT = 0;
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

        //MESSAGE('a %1 %2 %3 %4',TotalISR[1][1],base,"%Cot");

        //GRN Modifico los importes del Calculo del ISR
        HistLinNom.RESET;
        HistLinNom.SETRANGE("No. empleado", GlobalRec."No. empleado");
        HistLinNom.SETRANGE("Tipo nomina", "Historico Cab. nomina"."Tipo Nomina");
        HistLinNom.SETRANGE(Periodo, PerInici, PerFinal);
        HistLinNom.SETRANGE("Concepto salarial", ConfNominas."Concepto ISR");
        IF HistLinNom.FINDFIRST THEN BEGIN
            LinEsqPercepISR.RESET;
            LinEsqPercepISR.SETRANGE("No. empleado", GlobalRec."No. empleado");
            LinEsqPercepISR.SETRANGE("Concepto salarial", HistLinNom."Concepto salarial");
            LinEsqPercepISR.FINDFIRST;

            HistLinNom."Importe Base" := Base;
            HistLinNom.Total := TotalISR[1] [1] * -1;
            HistLinNom."% Cotizable" := "%Cot";
            HistLinNom.MODIFY;
        END;

        IF PerfilSalImp."% ISR Pago Empleado" <> 0 THEN BEGIN
            PerfilSalImp.Importe := ROUND(TotalISR[1] [1] * PerfilSalImp."% ISR Pago Empleado" / 100, 0.01);
            ImporteTotal := PerfilSalImp.Importe * -1;

            //Employer
            LinAportesEmpresa.SETRANGE("No. Documento", "Historico Cab. nomina"."No. Documento");
            LinAportesEmpresa.SETRANGE("No. Empleado", "Historico Cab. nomina"."No. empleado");
            IF LinAportesEmpresa.FINDLAST THEN
                NoLinImp := LinAportesEmpresa."No. orden";

            NoLinImp += 10;
            LinAportesEmpresa.INIT;
            LinAportesEmpresa."No. Documento" := "Historico Cab. nomina"."No. Documento";
            LinAportesEmpresa."No. orden" := NoLinImp;
            LinAportesEmpresa."Empresa cotizacion" := "Historico Cab. nomina"."Empresa cotizacion";
            LinAportesEmpresa.Periodo := "Historico Cab. nomina".Periodo;
            LinAportesEmpresa."No. Empleado" := "Historico Cab. nomina"."No. empleado";
            LinAportesEmpresa.VALIDATE("Concepto Salarial", PerfilSalImp."Concepto salarial");
            LinAportesEmpresa."% Cotizable" := ROUND("%Cot" * (100 - PerfilSalImp."% ISR Pago Empleado") / 100, 0.01);
            LinAportesEmpresa."Base Imponible" := IngresoSalario;
            LinAportesEmpresa.Importe := ROUND(TotalISR[1] [1] * (100 - PerfilSalImp."% ISR Pago Empleado") / 100, 0.01);
            //    LinAportesEmpresa.INSERT;
            "%Cot" := ROUND("%Cot" * PerfilSalImp."% ISR Pago Empleado" / 100, 0.01);
        END;

        //Modifico el Saldo ISR a Favor
        SaldoFavor2.COPYFILTERS(SaldoFavor);
        IF SaldoFavor2.FIND('-') THEN BEGIN
            SaldoFavor2.TRANSFERFIELDS(SaldoFavor);
            SaldoFavor2."Importe Pendiente" := SaldoFavor."Importe Pendiente";
            SaldoFavor2.MODIFY;
        END;
    end;

    procedure InsertaISR(perfSalario: Record 34002115)
    var
        LinNomina: Record 34002118;
    begin
        //GRN Busco Ult. No. de LInea
        HistLinNom.RESET;
        HistLinNom.SETRANGE("No. empleado", GlobalRec."No. empleado");
        HistLinNom.SETRANGE("Tipo nomina", "Historico Cab. nomina"."Tipo Nomina");
        HistLinNom.SETRANGE(Periodo, "Historico Cab. nomina".Inicio, "Historico Cab. nomina".Fin);
        IF HistLinNom.FINDLAST THEN
            LinTabla := HistLinNom."No. Orden" + 100;

        //GRN Modifico los importes del Calculo del ISR

        LinNomina."Empresa cotizacion" := perfSalario."Empresa cotizacion";
        LinNomina."No. empleado" := perfSalario."No. empleado";
        LinNomina."No. Documento" := "Historico Cab. nomina"."No. Documento";
        LinNomina.Periodo := PerInici;
        LinNomina."No. Orden" := LinTabla;
        LinNomina.Ano := "Historico Cab. nomina".Ano;
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
        LinNomina.F´Š¢rmula := perfSalario."F´Š¢rmula Calculo";
        LinNomina.Imprimir := perfSalario.Imprimir;
        LinNomina."Inicio periodo" := PerInici;
        LinNomina."Fin periodo" := PerFinal;
        LinNomina."Tipo nomina" := perfSalario."Tipo nomina";
        LinNomina."% Cotizable" := "%Cot";
        LinNomina."% Pago Empleado" := perfSalario."% ISR Pago Empleado";
        LinNomina.INSERT;

        ConceptosSal.SETRANGE(Codigo, perfSalario."Concepto salarial");
        ConceptosSal.FINDFIRST;

        recTmpDimEntry.DELETEALL;
        InsertarDimTemp(ConceptosSal."Shortcut Dimension", perfSalario."Concepto salarial"); //Para el concepto salarial
        InsertarDimTempDef(5200);                                                           //Para las Dim del empleado
        InsertarDimTempDefPS(34002115, perfSalario."Concepto salarial");                     //Para las Dim del perfil de salario (linea del concepto salarial)
        LinNomina."Dimension Set ID" := cduDim.GetDimensionSetID(recTmpDimEntry);
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
            recTmpDimEntry.INSERT(TRUE);
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
        recDfltDim.SETRANGE("No.", GlobalRec."No. empleado" + ConceptoSal);
        IF recDfltDim.FINDSET(FALSE, FALSE) THEN
            REPEAT
                InsertarDimTemp(recDfltDim."Dimension Code", recDfltDim."Dimension Value Code");
            UNTIL recDfltDim.NEXT = 0;
    end;

    procedure ReCalcularTSSDistribuido()
    var
        LinNominasES: Record 34002118;
        DeduccGob: Record 34002129;
        CabAportesEmpresa: Record 34002121;
        LinAportesEmpresa: Record 34002122;
        PerfilSalTr: Record 34002115;
        PerfilSalTr2: Record 34002115;
        LinEsqPercepISR2: Record 34002115;
        NoLin: Integer;
        MontoAplicar: Decimal;
        IndSkip: Boolean;
        ImpuestoMes: Decimal;
        SFSMesSal: Decimal;
        AFPMesSal: Decimal;
        SFSMes: Decimal;
        AFPMes: Decimal;
        IngresoMes: Decimal;
        Ano: Integer;
        Importecotizacionmes: Decimal;
    begin
        //Funcion para recalcular la TSS para buscar la base de calculo del ISR  (IDC)
        SFSMes := 0;
        AFPMes := 0;
        SFSMesSal := 0;
        AFPMesSal := 0;

        Ano := DATE2DMY("Historico Cab. nomina".Inicio, 3);

        LinEsqPercepISR2.RESET;
        LinEsqPercepISR2.SETRANGE("No. empleado", GlobalRec."No. empleado");
        LinEsqPercepISR2.SETRANGE("Concepto salarial", ConfNominas."Concepto ISR");
        IF NOT LinEsqPercepISR2.FINDFIRST THEN
            LinEsqPercepISR2.INIT;

        //IF (Contrato."Tipo Pago Nomina" = Contrato."Tipo Pago Nomina"::Quincenal) AND (Puestos."M´Š¢todo Calculo Paga Salario" = Puestos."M´Š¢todo Calculo Paga Salario"::Distribuido) AND
        //   (LinEsqPercepISR2."1ra Quincena" AND LinEsqPercepISR2."2da Quincena" AND PrimeraQ) THEN
        BEGIN
            DeduccGob.RESET;
            DeduccGob.SETRANGE(Ano, Ano);
            DeduccGob.SETFILTER("Porciento Empleado", '<>%1', 0);
            IF DeduccGob.FINDSET(FALSE, FALSE) THEN
                REPEAT
                    IndSkip := FALSE;
                    Importecotizacionmes := 0;

                    LinNominasES.RESET;
                    LinNominasES.SETRANGE("No. empleado", GlobalRec."No. empleado");
                    LinNominasES.SETRANGE("Tipo nomina", GlobalRec."Tipo nomina");
                    LinNominasES.SETRANGE(Periodo, PerInici, PerFinal);
                    LinNominasES.SETRANGE("Sujeto Cotizacion", TRUE);
                    IF ConfNominas."Concepto AFP" = DeduccGob.Codigo THEN
                        LinNominasES.SETRANGE("Cotiza AFP", TRUE)
                    ELSE
                        IF ConfNominas."Concepto SFS" = DeduccGob.Codigo THEN
                            LinNominasES.SETRANGE("Cotiza SFS", TRUE);

                    IF Empleado."Exclu´Š¢do Cotizacion TSS" THEN
                        IndSkip := TRUE;

                    IF LinNominasES.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            IF (LinNominasES."Salario Base") AND (Empleado."Employment Date" < PerInici) THEN
                                Importecotizacionmes += LinNominasES."Importe Base"
                            ELSE
                                Importecotizacionmes += LinNominasES.Total
                        UNTIL LinNominasES.NEXT = 0;


                    Importecotizacionmes += TotalCompany;

                    //Employee
                    IF LinNominasES."Salario Base" THEN BEGIN
                        //IDC
                        IF ConfNominas."Concepto SFS" = DeduccGob.Codigo THEN
                            SFSMesSal := Importecotizacionmes * DeduccGob."Porciento Empleado" / 100
                        ELSE
                            IF ConfNominas."Concepto AFP" = DeduccGob.Codigo THEN
                                AFPMesSal := Importecotizacionmes * DeduccGob."Porciento Empleado" / 100;
                        //IDC Fin
                    END
                    ELSE BEGIN
                        //IDC
                        IF ConfNominas."Concepto SFS" = DeduccGob.Codigo THEN
                            SFSMes := Importecotizacionmes * DeduccGob."Porciento Empleado" / 100
                        ELSE
                            IF ConfNominas."Concepto AFP" = DeduccGob.Codigo THEN
                                AFPMes := Importecotizacionmes * DeduccGob."Porciento Empleado" / 100;
                        //IDC Fin
                    END;
                UNTIL DeduccGob.NEXT = 0;

            //Busco todos los ingresos que
            LinNominasES.RESET;
            LinNominasES.SETRANGE("No. empleado", GlobalRec."No. empleado");
            LinNominasES.SETRANGE("Tipo nomina", GlobalRec."Tipo nomina");
            LinNominasES.SETRANGE(Periodo, PerInici, PerFinal);
            LinNominasES.SETRANGE("Sujeto Cotizacion", TRUE);
            LinNominasES.SETRANGE("Tipo concepto", LinNominasES."Tipo concepto"::Ingresos);
            IF LinNominasES.FINDSET THEN
                REPEAT
                    IF LinNominasES."Salario Base" THEN BEGIN
                        IF Empleado."Employment Date" >= PerInici THEN
                            IngresoMes += LinNominasES.Total
                        ELSE
                            IngresoMes += LinNominasES."Importe Base";
                    END
                    ELSE
                        IngresoMes += LinNominasES.Total;
                UNTIL LinNominasES.NEXT = 0;

            TotalISR[1] [1] := ((AFPMes + SFSMes + AFPMesSal + SFSMesSal) * -1) + IngresoMes + TotalCompany;
        END;

        //MESSAGE('bb %1 %2 %3 %4 %5 %6',AFPMes,SFSMes,AFPMesSal,SFSMesSal,IngresoMes,totalcompany);
    end;
}

