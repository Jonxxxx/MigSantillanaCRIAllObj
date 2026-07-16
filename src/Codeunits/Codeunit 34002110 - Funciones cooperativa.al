codeunit 34002110 "Funciones cooperativa"
{
    // Si en A1 pones Tasa (tipo de interes del periodo)
    // en B1 el nPer (número de Periodos)
    // en C1 el Va (Capital inicial)
    // Esta formula:
    // 
    // (A1*(1+A1)^B1)*C1/(((1+A1)^B1)-1)


    trigger OnRun()
    begin
    end;

    var
        ConfNominas: Record 34002103;
        CabPrestamoscoop: Record 34002197;
        LinPrestamoscooperativa: Record 34002198;
        Miembroscooperativa: Record 34002195;
        HistCabPrestcooperativa: Record 34002199;
        PerfilSal: Record 34002115;
        NoSeriesMgt: Codeunit "No. Series";
        Msg001: Label 'Successful employee activation';
        Msg002: Label 'Successful employee inactivation';
        Msg003: Label 'Successful employee retirement';
        Msg004: Label 'Employee %1 has an accumulated savings amount of %2 and a debt of %3, do you want to request a refund payment of this amount?';
        Err001: Label '%1 %2 already have an open loan associated to %3 %4. Please check and/or change the %5.';
        Err002: Label 'Employee %1 does not have enought time as member to opt for a loan';
        Err003: Label 'Loan cannot be approved because total outstanding loan amounts exceed 50% of accumulated savings for employee %1';
        Err004: Label 'Employee %1 exceeds the number of consecutive and outstanding loans issued for the quarter';
        Err005: Label '%1 is less than %2. Payment request is not possible';
        Text001: Label 'Retirement of accumulated savings withdrawal';

    procedure CrearCuotasCoop(CPCoop: Record 34002197)
    var
        HistCabPrestcooperativa: Record 34002199;
        Cuota: Integer;
        MontoCuota: Decimal;
        Capital: Decimal;
        PorcInteres: Decimal;
        ImpInteres: Decimal;
        FechaFin: Date;
        Dividendo: Decimal;
        Divisor: Decimal;
        SaldoIni: Decimal;
    begin
        ConfNominas.GET();

        //Si es reingreso, controles para prestamos
        ConfNominas.TESTFIELD("Tiempo minimo prest. coop.");
        Miembroscooperativa.GET(CPCoop."Employee No.");
        IF (Miembroscooperativa."Fecha reingreso" > CALCDATE('-' + FORMAT(ConfNominas."Tiempo minimo prest. coop."), TODAY)) AND
           (Miembroscooperativa."Fecha reingreso" <> 0D) THEN
            ERROR(STRSUBSTNO(Err002, Miembroscooperativa."Full name"));

        //Validar cantidad de prestamos consecutivos
        HistCabPrestcooperativa.RESET;
        HistCabPrestcooperativa.SETCURRENTKEY("Employee No.", "Fecha Inicio Deduccion");
        HistCabPrestcooperativa.SETRANGE("Employee No.", CPCoop."Employee No.");
        HistCabPrestcooperativa.SETRANGE(Pendiente, TRUE);
        HistCabPrestcooperativa.SETRANGE("Fecha Inicio Deduccion", CALCDATE('-3M', TODAY), TODAY);
        IF HistCabPrestcooperativa.FINDSET THEN
            IF HistCabPrestcooperativa.COUNT >= 3 THEN
                ERROR(STRSUBSTNO(Err004, Miembroscooperativa."Full name"));

        /*
        //Validar que importe no sea mayor a 50% de acumulado
        Miembroscooperativa.CALCFIELDS("Importe pendiente","Ahorro acumulado");
        IF Miembroscooperativa."Ahorro acumulado" /2 < Miembroscooperativa."Importe pendiente" + CPCoop.Importe THEN
           ERROR(STRSUBSTNO(Err003,Miembroscooperativa."Full name"));
        */
        CabPrestamoscoop.GET(CPCoop."No. Prestamo");
        CabPrestamoscoop.TESTFIELD("Employee No.");
        CabPrestamoscoop.TESTFIELD("Tipo prestamo");
        CabPrestamoscoop.TESTFIELD(Importe);
        CabPrestamoscoop.TESTFIELD("Cantidad de Cuotas");
        CabPrestamoscoop.TESTFIELD("Concepto Salarial");
        CabPrestamoscoop.CALCFIELDS("Full name");

        MontoCuota := 0;
        Capital := 0;
        SaldoIni := 0;
        ImpInteres := 0;
        PorcInteres := 0;
        Dividendo := 0;
        Divisor := 0;

        HistCabPrestcooperativa.RESET;
        HistCabPrestcooperativa.SETRANGE("Employee No.", CabPrestamoscoop."Employee No.");
        HistCabPrestcooperativa.SETRANGE("Concepto Salarial", CabPrestamoscoop."Concepto Salarial");
        HistCabPrestcooperativa.SETRANGE(Pendiente, TRUE);
        IF HistCabPrestcooperativa.FINDFIRST THEN
            ERROR(STRSUBSTNO(Err001, CabPrestamoscoop.FIELDCAPTION("Employee No."), CabPrestamoscoop."Employee No." + ', ' +
                  CabPrestamoscoop."Full name", CabPrestamoscoop.FIELDCAPTION("Concepto Salarial"),
                  CabPrestamoscoop."Concepto Salarial", CabPrestamoscoop.FIELDCAPTION("Concepto Salarial")));

        LinPrestamoscooperativa.RESET;
        LinPrestamoscooperativa.SETRANGE("No. Prestamo", CabPrestamoscoop."No. Prestamo");
        IF LinPrestamoscooperativa.FINDSET THEN
            LinPrestamoscooperativa.DELETEALL;

        LinPrestamoscooperativa.RESET;
        LinPrestamoscooperativa.INIT;

        IF CabPrestamoscoop."% Interes" <> 0 THEN BEGIN
            //Esta es la formula financiera para cuando es cuota fija
            //(A1*(1+A1)^B1)*C1/(((1+A1)^B1)-1)
            //P = ((220000 * (0.0475/12)) / (1 - ((1 + (0.0475/12))^(-1 * 30 * 12))))
            PorcInteres := CabPrestamoscoop."% Interes" / 100;
            Dividendo := 1 + PorcInteres;
            Dividendo := POWER(Dividendo, CabPrestamoscoop."Cantidad de Cuotas");
            Dividendo := PorcInteres * Dividendo;

            Divisor := 1 + PorcInteres;
            Divisor := POWER(Divisor, CabPrestamoscoop."Cantidad de Cuotas");
            Divisor := Divisor - 1;

            MontoCuota := Dividendo / Divisor * CabPrestamoscoop.Importe;
        END
        ELSE
            MontoCuota := CabPrestamoscoop.Importe / CabPrestamoscoop."Cantidad de Cuotas";

        Cuota := 1;
        WHILE Cuota <= CabPrestamoscoop."Cantidad de Cuotas" DO BEGIN
            IF LinPrestamoscooperativa."Saldo inicial" = 0 THEN BEGIN
                Capital := CabPrestamoscoop.Importe;
                SaldoIni := Capital;
            END;


            ImpInteres := SaldoIni * PorcInteres;

            LinPrestamoscooperativa.INIT;
            LinPrestamoscooperativa."No. Prestamo" := CabPrestamoscoop."No. Prestamo";
            LinPrestamoscooperativa."No. Cuota" := Cuota;
            LinPrestamoscooperativa."Tipo prestamo" := LinPrestamoscooperativa."Tipo prestamo";
            LinPrestamoscooperativa."Fecha Transaccion" := TODAY;
            LinPrestamoscooperativa."Codigo Empleado" := CabPrestamoscoop."Employee No.";
            LinPrestamoscooperativa."Saldo inicial" := SaldoIni;

            LinPrestamoscooperativa.Interes := ImpInteres;
            LinPrestamoscooperativa."Importe cuota" := MontoCuota;
            LinPrestamoscooperativa.Capital := MontoCuota - ImpInteres;

            LinPrestamoscooperativa.Saldo := LinPrestamoscooperativa."Saldo inicial" + ImpInteres - MontoCuota;
            SaldoIni := LinPrestamoscooperativa.Saldo;
            LinPrestamoscooperativa.INSERT(TRUE);
            Cuota += 1;
        END;

    end;

    procedure RegistrarPrestCoop(CPCoop: Record 34002197)
    var
        HistLinPrestcooperativa: Record 34002200;
        Movcooperativa: Record 34002196;
        Movcooperativa2: Record 34002196;
    begin
        ConfNominas.GET();
        ConfNominas.TESTFIELD("No. serie Hist. Prest. Coop.");

        CabPrestamoscoop.GET(CPCoop."No. Prestamo");
        CabPrestamoscoop.TESTFIELD("Employee No.");
        CabPrestamoscoop.TESTFIELD("Tipo prestamo");
        CabPrestamoscoop.TESTFIELD(Importe);
        CabPrestamoscoop.TESTFIELD("Cantidad de Cuotas");
        CabPrestamoscoop.TESTFIELD("Fecha Inicio Deduccion");
        CabPrestamoscoop.TESTFIELD("Concepto Salarial");

        HistCabPrestcooperativa.INIT;
        HistCabPrestcooperativa.TRANSFERFIELDS(CabPrestamoscoop);
        HistCabPrestcooperativa."No. Prestamo" := NoSeriesMgt.GetNextNo(ConfNominas."No. serie Hist. Prest. Coop.", WORKDATE, TRUE);
        HistCabPrestcooperativa.TESTFIELD("No. Prestamo");
        HistCabPrestcooperativa."No. Solicitud prestamo" := CabPrestamoscoop."No. Prestamo";
        HistCabPrestcooperativa.Pendiente := TRUE;
        HistCabPrestcooperativa.INSERT;

        LinPrestamoscooperativa.RESET;
        LinPrestamoscooperativa.SETRANGE("No. Prestamo", CabPrestamoscoop."No. Prestamo");
        LinPrestamoscooperativa.FINDSET;
        REPEAT
            HistLinPrestcooperativa.INIT;
            HistLinPrestcooperativa.TRANSFERFIELDS(LinPrestamoscooperativa);
            HistLinPrestcooperativa."No. Prestamo" := HistCabPrestcooperativa."No. Prestamo";
            HistLinPrestcooperativa.INSERT(TRUE);
        UNTIL LinPrestamoscooperativa.NEXT = 0;

        PerfilSal.RESET;
        PerfilSal.SETRANGE("No. empleado", CabPrestamoscoop."Employee No.");
        PerfilSal.SETRANGE("Concepto salarial", CabPrestamoscoop."Concepto Salarial");
        PerfilSal.FINDFIRST;
        PerfilSal.TESTFIELD("Tipo concepto", PerfilSal."Tipo concepto"::Deducciones);
        PerfilSal.Cantidad := 1;
        PerfilSal.Importe := HistLinPrestcooperativa."Importe cuota";
        PerfilSal.MODIFY;

        IF NOT Movcooperativa2.FINDLAST THEN
            Movcooperativa2.INIT;

        //Inserto el movimiento
        Movcooperativa.INIT;
        Movcooperativa."No. Movimiento" := Movcooperativa2."No. Movimiento" + 1;
        Movcooperativa."Tipo miembro" := HistCabPrestcooperativa."Tipo de miembro";
        Movcooperativa."Employee No." := HistCabPrestcooperativa."Employee No.";
        Movcooperativa."Fecha registro" := CabPrestamoscoop."Fecha Inicio Deduccion";
        Movcooperativa."No. documento" := HistCabPrestcooperativa."No. Prestamo";
        Movcooperativa."Tipo transaccion" := Movcooperativa."Tipo transaccion"::Préstamo;
        Movcooperativa.Importe := HistCabPrestcooperativa.Importe;
        Movcooperativa."Concepto salarial" := HistCabPrestcooperativa."Concepto Salarial";
        Movcooperativa.INSERT(TRUE);

        //Elimino tablas borrador
        LinPrestamoscooperativa.RESET;
        LinPrestamoscooperativa.SETRANGE("No. Prestamo", CabPrestamoscoop."No. Prestamo");
        LinPrestamoscooperativa.FINDSET;
        LinPrestamoscooperativa.DELETEALL;
        CabPrestamoscoop.DELETE;
    end;

    procedure ActivarMiembro(var Miembroscoop: Record 34002195)
    var
        Miembroscooperativa: Record 34002195;
    begin
        Miembroscooperativa.COPY(Miembroscoop);

        //Para identificarlo como re ingreso
        IF Miembroscooperativa.Status = Miembroscooperativa.Status::Retirado THEN
            Miembroscooperativa."Fecha reingreso" := TODAY;

        ConfNominas.GET();
        ConfNominas.TESTFIELD("Concepto Cuota cooperativa");
        Miembroscooperativa.Status := 1;

        PerfilSal.RESET;
        PerfilSal.SETRANGE("No. empleado", Miembroscooperativa."Employee No.");
        PerfilSal.SETRANGE("Concepto salarial", ConfNominas."Concepto Cuota cooperativa");
        IF NOT PerfilSal.FINDFIRST THEN BEGIN
            PerfilSal.INIT;
            PerfilSal.VALIDATE("No. empleado", Miembroscooperativa."Employee No.");
            PerfilSal.VALIDATE("Concepto salarial", ConfNominas."Concepto Cuota cooperativa");
            PerfilSal.INSERT(TRUE);
        END;
        COMMIT;
        CASE Miembroscooperativa."Tipo de aporte" OF
            Miembroscooperativa."Tipo de aporte"::Fijo:
                BEGIN
                    Miembroscooperativa.TESTFIELD(Importe);
                    PerfilSal.Cantidad := 1;
                    PerfilSal.Importe := Miembroscooperativa.Importe;
                END
            ELSE BEGIN
                Miembroscooperativa.TESTFIELD(Importe);
                PerfilSal.Cantidad := 1;
                PerfilSal."Formula cálculo" := ConfNominas."Concepto Sal. Base" + '*' + FORMAT(Miembroscooperativa.Importe / 100);
                PerfilSal.VALIDATE("Formula cálculo");
            END;
        END;
        PerfilSal."1ra Quincena" := Miembroscooperativa."1ra Quincena";
        PerfilSal."2da Quincena" := Miembroscooperativa."2da Quincena";
        PerfilSal.MODIFY(TRUE);
        Miembroscooperativa.MODIFY(TRUE);
        MESSAGE(Msg001);
    end;

    procedure InActivarMiembro(var Miembroscoop: Record 34002195)
    var
        Miembroscooperativa: Record 34002195;
    begin
        Miembroscooperativa.COPY(Miembroscoop);

        ConfNominas.GET();
        ConfNominas.TESTFIELD("Concepto Cuota cooperativa");
        Miembroscooperativa.Status := 2;
        Miembroscooperativa."Fecha inactivacion" := TODAY;

        PerfilSal.RESET;
        PerfilSal.SETRANGE("No. empleado", Miembroscooperativa."Employee No.");
        PerfilSal.SETRANGE("Concepto salarial", ConfNominas."Concepto Cuota cooperativa");
        PerfilSal.FINDFIRST;
        PerfilSal.Cantidad := 0;
        PerfilSal.MODIFY(TRUE);

        Miembroscooperativa.MODIFY(TRUE);
        MESSAGE(Msg002);
    end;

    procedure RetirarMiembro(var Miembroscoop: Record 34002195)
    var
        Miembroscooperativa: Record 34002195;
        GenJnlLine: Record 81;
        GenJnlLine2: Record 81;
    begin
        Miembroscooperativa.COPY(Miembroscoop);

        ConfNominas.GET();
        Miembroscooperativa.Status := 3;

        PerfilSal.RESET;
        PerfilSal.SETRANGE("No. empleado", Miembroscooperativa."Employee No.");
        PerfilSal.SETRANGE("Concepto salarial", ConfNominas."Concepto Cuota cooperativa");
        PerfilSal.FINDFIRST;
        PerfilSal.Cantidad := 0;
        PerfilSal.MODIFY(TRUE);

        Miembroscooperativa.MODIFY(TRUE);

        Miembroscooperativa.CALCFIELDS("Ahorro acumulado", "Importe pendiente", "Full name");

        IF Miembroscooperativa."Ahorro acumulado" <> 0 THEN BEGIN
            IF CONFIRM(STRSUBSTNO(Msg004, Miembroscooperativa."Full name", FORMAT(Miembroscooperativa."Ahorro acumulado", 0, '<Integer thousand><Decimals,3>'), FORMAT(Miembroscooperativa."Importe pendiente", 0, '<Integer thousand><Decimals,3>')), FALSE) THEN BEGIN
                IF Miembroscooperativa."Ahorro acumulado" < Miembroscooperativa."Importe pendiente" THEN
                    ERROR(STRSUBSTNO(Err005, Miembroscooperativa.FIELDCAPTION("Ahorro acumulado"), Miembroscooperativa.FIELDCAPTION("Importe pendiente")));
                ConfNominas.TESTFIELD("Journal Template Name CK");
                ConfNominas.TESTFIELD("Journal Batch Name CK");
                ConfNominas.TESTFIELD("Cta. Nominas Otros Pagos");
                GenJnlLine2.RESET;
                GenJnlLine2.SETRANGE("Journal Template Name", ConfNominas."Journal Template Name CK");
                GenJnlLine2.SETRANGE("Journal Batch Name", ConfNominas."Journal Batch Name CK");
                IF NOT GenJnlLine2.FINDLAST THEN
                    GenJnlLine2.INIT;

                GenJnlLine.INIT;
                GenJnlLine.VALIDATE("Journal Template Name", ConfNominas."Journal Template Name CK");
                GenJnlLine.VALIDATE("Journal Batch Name", ConfNominas."Journal Batch Name CK");
                GenJnlLine."Line No." := GenJnlLine2."Line No." + 1000;
                GenJnlLine.VALIDATE("Posting Date", WORKDATE);
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Document No." := 'LIQ-A-COOP-' + Miembroscooperativa."Employee No.";
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                //GenJnlLine.VALIDATE("Account No."
                GenJnlLine.Description := Text001;
                GenJnlLine.VALIDATE(Amount, ROUND(Miembroscooperativa."Ahorro acumulado" - Miembroscooperativa."Importe pendiente", 0.01));
                CASE ConfNominas."Tipo Cta. Otros Pagos" OF
                    0: //Cuenta
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                    1: //Banco
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
                    2: //Proveedor
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::Vendor;
                END;
                GenJnlLine.VALIDATE("Bal. Account No.", ConfNominas."Cta. Nominas Otros Pagos");
                GenJnlLine.INSERT(TRUE);
            END;
        END;
        MESSAGE(Msg003);
    end;

    procedure RevisarStatus()
    begin
        Miembroscooperativa.FIND('-');
        REPEAT
            IF Miembroscooperativa.Status = Miembroscooperativa.Status::Inactivo THEN BEGIN
                IF CALCDATE('+30D', Miembroscooperativa."Fecha inactivacion") > TODAY THEN BEGIN
                    Miembroscooperativa."Fecha inactivacion" := 0D;
                    Miembroscooperativa.Status := Miembroscooperativa.Status::Activo;
                    Miembroscooperativa.MODIFY;
                END;
            END;
        UNTIL Miembroscooperativa.NEXT = 0;
    end;
}

