codeunit 34002135 "Genera formatos elect. legales"
{

    trigger OnRun()
    begin
        //RDAutodeterminacion(12,2018,'100');
    end;

    var
        ConfContab: Record 98;
        ConfNomina: Record 34002103;
        Empl: Record 5200;
        EC: Record 34002100;
        HCN: Record 34002117;
        Fecha: Record 2000000007;
        EmpRel: Record 34002150;
        TipoNom: Record 34002158;
        EmpresaCot: Record 34002100;
        FuncNom: Codeunit 34002104;
        //TODO: Ver ClientTypeManagement: Codeunit 4;
        Archivo: File;
        PathENV: Text;
        FileVar: File;
        IStream: InStream;
        StreamOut: OutStream;
        Lin_Body: Text[366];
        Lin_Body_DGT: Text[527];
        CERO: Text[100];
        Blanco: Text[30];
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
        NombreArchivo: Text[1024];
        NombreArchivo2: Text[1024];
        //TODO: Ver FileSystemObject: Automation;
        DestinationFileName: Text[200];
        PrimeraVez: Boolean;
        SecuenciaTrans: Code[10];
        FechaTrans: Date;
        Text001: Label 'Generating file #1########## @2@@@@@@@@@@@@@';
        CantLineas: Integer;
        Text002: Label 'File %1 has been generated';
        RNC: Code[13];
        Text003: Label ', please check';
        Text004: Label 'File downloaded';
        Err001: Label 'Payroll key must have a length of 3 positions';
        CalcFecha: Label '+1Y';

    procedure RDAutodeterminacion(var HCN: Record 34002117; TSSAno: Integer; ClaveNomina: Code[3])
    var
        HLN: Record 34002118;
        SaldosFavor: Record 34002128;
        HistAccionesdepersonal: Record 34002159;
        EmployeeAbsence: Record 5207;
        CauseofAbsence: Record 5206;
        Conceptossalariales: Record 34002111;
        SalarioCotizable: Decimal;
        SalarioISR: Decimal;
        SalarioInfotep: Decimal;
        OtrasRemuneraciones: Decimal;
        RemOtrosAgentes: Decimal;
        IngresosExentos: Decimal;
        SaldoFavorISR: Decimal;
        Preaviso_Cesantia: Decimal;
        Regalia: Decimal;
    begin
        ConfNomina.GET();
        ConfContab.GET();
        TipoNom.RESET;
        TipoNom.SETRANGE("Tipo de nomina", TipoNom."Tipo de nomina"::Regular);
        TipoNom.FINDFIRST;
        TipoNom.TESTFIELD("Dia inicio 1ra");

        IF STRLEN(ClaveNomina) < 3 THEN
            ERROR(Err001);
        EC.FINDFIRST;
        EC.TESTFIELD("RNC/CED");
        RNC := DELCHR(EC."RNC/CED", '=', '-');

        Blanco := ' ';
        CERO := '0';
        PrimeraVez := TRUE;
        Empl.INIT;
        CantLineas := 1;
        ConfNomina.TESTFIELD("Path Archivos Electronicos");

        IF COPYSTR(ConfNomina."Path Archivos Electronicos", STRLEN(ConfNomina."Path Archivos Electronicos"), 1) <> '\' THEN
            ConfNomina."Path Archivos Electronicos" += '\';

        //TODO: Ver PathENV := TEMPORARYPATH;
        FechaTrans := HCN.GETRANGEMAX(Periodo);

        Fecha.RESET;
        Fecha.SETRANGE("Period Type", Fecha."Period Type"::Month);
        Fecha.SETRANGE("Period Start", DMY2DATE(1, DATE2DMY(FechaTrans, 2), DATE2DMY(FechaTrans, 3)));
        Fecha.FINDFIRST;

        NombreArchivo := 'AM_' + RNC + '_' + FORMAT(FechaTrans, 0, '<Month,2>') + FORMAT(FechaTrans, 0, '<Year4>') + '.txt';
        NombreArchivo2 := NombreArchivo;
        //TODO: Ver Archivo.TEXTMODE(TRUE);
        //TODO: Ver Archivo.CREATE(PathENV + NombreArchivo);
        //TODO: Ver Archivo.TRUNC;

        //Creo la cabecera
        Lin_Body := 'E';
        Lin_Body += 'AM';
        Lin_Body += FORMAT(Blanco, 11 - STRLEN(RNC), '<Filler character, >') + RNC;
        Lin_Body += FORMAT(FechaTrans, 0, '<Month,2><Year4>');
        //TODO: Ver Archivo.WRITE(Lin_Body);

        FechaTrans := HCN.GETRANGEMIN(Periodo);

        Fecha.RESET;
        Fecha.SETRANGE("Period Type", Fecha."Period Type"::Month);
        Fecha.SETRANGE("Period Start", DMY2DATE(1, DATE2DMY(FechaTrans, 2), DATE2DMY(FechaTrans, 3)));
        Fecha.FINDFIRST;

        HCN.RESET;
        HCN.SETRANGE(Periodo, FechaTrans, Fecha."Period End");
        CounterTotal := HCN.COUNT;
        Window.OPEN(Text001);
        HCN.FINDSET;
        REPEAT
            Counter := Counter + 1;
            Window.UPDATE(1, HLN."No. empleado");
            Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));
            IF HCN."No. empleado" <> Empl."No." THEN BEGIN
                SalarioCotizable := 0;
                SalarioISR := 0;
                OtrasRemuneraciones := 0;
                SalarioInfotep := 0;
                Preaviso_Cesantia := 0;
                Regalia := 0;
                Empl.GET(HCN."No. empleado");
                Empl.TESTFIELD("Birth Date");
                Empl.TESTFIELD("Document ID");

                //Creo el detalle
                CLEAR(Lin_Body);
                Lin_Body := 'D';
                Lin_Body += ClaveNomina;
                CASE Empl."Document Type" OF
                    0: //Cedula
                        Lin_Body += 'C';
                    1: //Pasaporte
                        Lin_Body += 'P';
                    ELSE
                        Lin_Body += 'N';
                END;

                Empl."Document ID" := DELCHR(Empl."Document ID", '=', '-');
                Empl."First Name" := FuncNom.Ascii2Ansi(Empl."First Name");
                Empl."Middle Name" := FuncNom.Ascii2Ansi(Empl."Middle Name");
                Empl."Last Name" := FuncNom.Ascii2Ansi(Empl."Last Name");
                Empl."Second Last Name" := FuncNom.Ascii2Ansi(Empl."Second Last Name");

                Lin_Body += COPYSTR(Empl."Document ID" + PADSTR(Blanco, 25 - STRLEN(Empl."Document ID")), 1, 25);
                IF STRLEN(Empl."First Name" + ' ' + Empl."Middle Name") <= 50 THEN
                    Lin_Body += Empl."First Name" + ' ' + Empl."Middle Name" + FORMAT(Blanco, 50 - STRLEN(Empl."First Name" + ' ' + Empl."Middle Name"), '<Filler character, >')
                ELSE
                    Lin_Body += COPYSTR(Empl."First Name" + ' ' + Empl."Middle Name", 1, 50);
                Lin_Body += Empl."Last Name" + FORMAT(Blanco, 40 - STRLEN(Empl."Last Name"), '<Filler character, >');
                Lin_Body += Empl."Second Last Name" + FORMAT(Blanco, 40 - STRLEN(Empl."Second Last Name"), '<Filler character, >');
                CASE Empl.Gender OF
                    1: //Femenino
                        Lin_Body += 'F'
                    ELSE
                        Lin_Body += 'M';
                END;

                Lin_Body += FORMAT(Empl."Birth Date", 0, '<Day,2><Month,2><Year4>');
                CLEAR(HLN);
                HLN.SETRANGE("No. empleado", HCN."No. empleado");
                // HLN.SETRANGE("Tipo de nomina",HCN."Tipo de nomina");
                HLN.SETRANGE(Periodo, Fecha."Period Start", Fecha."Period End");
                HLN.SETRANGE("Tipo concepto", HLN."Tipo concepto"::Ingresos);
                IF HLN.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                        Conceptossalariales.GET(HLN."Concepto salarial");
                        IF (NOT Empl."Excluido Cotizacion TSS") AND (Conceptossalariales."Sujeto Cotizacion") THEN
                            SalarioCotizable += ROUND(HLN.Total, 0.01);
                    UNTIL HLN.NEXT = 0;

                Lin_Body += PADSTR('', 16 - STRLEN(FORMAT(SalarioCotizable, 0, '<Integer><Decimals,3>')), CERO) + FORMAT(SalarioCotizable, 0, '<Integer><Decimals,3>');
                SalarioCotizable := 0; //Para el campo de aporte voluntario
                Lin_Body += PADSTR('', 16 - STRLEN(FORMAT(SalarioCotizable, 0, '<Integer><Decimals,3>')), CERO) + FORMAT(SalarioCotizable, 0, '<Integer><Decimals,3>');

                //ISR
                CLEAR(HLN);
                HLN.SETRANGE("No. empleado", HCN."No. empleado");
                //HLN.SETRANGE("Tipo de nomina",HCN."Tipo de nomina");
                HLN.SETRANGE(Periodo, Fecha."Period Start", Fecha."Period End");
                HLN.SETRANGE("Cotiza ISR", TRUE);
                HLN.SETRANGE("Salario Base", TRUE);
                HLN.SETRANGE("Tipo concepto", HLN."Tipo concepto"::Ingresos);
                IF HLN.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                        IF NOT Empl."Excluido Cotizacion ISR" THEN
                            SalarioISR += ROUND(HLN.Total, 0.01);
                    UNTIL HLN.NEXT = 0;
                Lin_Body += PADSTR('', 16 - STRLEN(FORMAT(SalarioISR, 0, '<Integer><Decimals,3>')), CERO) + FORMAT(SalarioISR, 0, '<Integer><Decimals,3>');

                //Otras remuneraciones
                CLEAR(HLN);
                HLN.SETRANGE("No. empleado", HCN."No. empleado");
                // HLN.SETRANGE("Tipo de nomina",HCN."Tipo de nomina");
                HLN.SETRANGE(Periodo, Fecha."Period Start", Fecha."Period End");
                HLN.SETRANGE("Cotiza ISR", TRUE);
                HLN.SETRANGE("Salario Base", FALSE);
                HLN.SETRANGE("Tipo concepto", HLN."Tipo concepto"::Ingresos);
                IF HLN.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                        OtrasRemuneraciones += ROUND(HLN.Total, 0.01);
                    UNTIL HLN.NEXT = 0;
                Lin_Body += PADSTR('', 16 - STRLEN(FORMAT(OtrasRemuneraciones, 0, '<Integer><Decimals,3>')), CERO) + FORMAT(OtrasRemuneraciones, 0, '<Integer><Decimals,3>');

                RemOtrosAgentes := 0;
                EmpRel.SETRANGE("Cod. Empleado", HCN."No. empleado");
                IF EmpRel.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                        CLEAR(HLN);
                        HLN.CHANGECOMPANY(EmpRel.Empresa);
                        HLN.SETRANGE("No. empleado", EmpRel."Cod. Empleado");
                        //HLN.SETRANGE("Tipo de nomina",HCN."Tipo de nomina");
                        HLN.SETRANGE(Periodo, Fecha."Period Start", Fecha."Period End");
                        HLN.SETRANGE("Cotiza ISR", TRUE);
                        //HLN.SETRANGE("Tipo concepto",HLN."Tipo concepto"::Ingresos);
                        IF HLN.FINDSET(FALSE, FALSE) THEN
                            REPEAT
                                RemOtrosAgentes += ROUND(HLN.Total, 0.01);
                            UNTIL HLN.NEXT = 0;
                    UNTIL EmpRel.NEXT = 0;
                RemOtrosAgentes += Empl."Salario Empresas Externas";

                //Agente de retencion
                EmpresaCot.GET(Empl.Company);
                IF RemOtrosAgentes <> 0 THEN BEGIN
                    Empl."RNC Agente de Retencion ISR" := DELCHR(Empl."RNC Agente de Retencion ISR", '=', '-');
                    IF Empl."RNC Agente de Retencion ISR" = '' THEN
                        Empl."RNC Agente de Retencion ISR" := DELCHR(EmpresaCot."RNC/CED", '=', '-');
                END;


                Lin_Body += COPYSTR(Empl."RNC Agente de Retencion ISR" + PADSTR(Blanco, 11 - STRLEN(Empl."RNC Agente de Retencion ISR")), 1, 11);
                Lin_Body += PADSTR('', 16 - STRLEN(FORMAT(RemOtrosAgentes, 0, '<Integer><Decimals,3>')), CERO) + FORMAT(RemOtrosAgentes, 0, '<Integer><Decimals,3>');

                //Ingresos exentos
                CLEAR(HLN);
                HLN.SETRANGE("No. empleado", HCN."No. empleado");
                //HLN.SETRANGE("Tipo de nomina",HCN."Tipo de nomina");
                HLN.SETRANGE(Periodo, Fecha."Period Start", Fecha."Period End");
                HLN.SETRANGE("Cotiza ISR", FALSE);
                HLN.SETRANGE("Sujeto Cotizacion", FALSE);
                HLN.SETRANGE("Tipo concepto", HLN."Tipo concepto"::Ingresos);
                HLN.SETFILTER("Concepto salarial", '<>%1&<>%2&<>%3&<>%4', ConfNomina."Concepto Regalia", ConfNomina."Concepto Cesantia", ConfNomina."Concepto Preaviso", ConfNomina."Concepto Dieta");
                IF HLN.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                        IngresosExentos += ROUND(HLN.Total, 0.01);
                    UNTIL HLN.NEXT = 0;
                Lin_Body += PADSTR('', 16 - STRLEN(FORMAT(IngresosExentos, 0, '<Integer><Decimals,3>')), CERO) + FORMAT(IngresosExentos, 0, '<Integer><Decimals,3>');
                //      IF IngresosExentos <> 0 THEN
                //         ERROR('aqui');
                //GRN Busco el saldo a favor
                SaldosFavor.RESET;
                SaldosFavor.SETRANGE(Ano, HCN.Ano);
                SaldosFavor.SETRANGE("Cod. Empleado", HCN."No. empleado");
                IF SaldosFavor.FINDFIRST THEN
                    SaldoFavorISR := ROUND(SaldosFavor."Importe Pendiente", 0.01);
                Lin_Body += PADSTR('', 16 - STRLEN(FORMAT(SaldoFavorISR, 0, '<Integer><Decimals,3>')), CERO) + FORMAT(SaldoFavorISR, 0, '<Integer><Decimals,3>');

                //Salario cotizable Infotep
                CLEAR(HLN);
                HLN.SETRANGE("No. empleado", HCN."No. empleado");
                //HLN.SETRANGE("Tipo de nomina",HCN."Tipo de nomina");
                HLN.SETRANGE(Periodo, Fecha."Period Start", Fecha."Period End");
                HLN.SETRANGE("Cotiza Infotep", TRUE);
                HLN.SETRANGE("Tipo concepto", HLN."Tipo concepto"::Ingresos);
                IF HLN.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                        SalarioInfotep += ROUND(HLN.Total, 0.01);
                    UNTIL HLN.NEXT = 0;
                Lin_Body += PADSTR('', 16 - STRLEN(FORMAT(SalarioInfotep, 0, '<Integer><Decimals,3>')), CERO) + FORMAT(SalarioInfotep, 0, '<Integer><Decimals,3>');

                //Para los tipos de ingresos
                IF (Empl."Employment Date" > Fecha."Period Start") OR
                   (Empl."Termination Date" <> 0D) OR (Empl."Fin contrato" <> 0D) THEN
                    Lin_Body += '0004'
                ELSE
                    IF Empl."Tipo pago" = Empl."Tipo pago"::"Sueldo fijo" THEN
                        Lin_Body += '0003'
                    ELSE
                        IF Empl."Tipo Empleado" = Empl."Tipo Empleado"::Temporal THEN
                            Lin_Body += '0002'
                        ELSE
                            Lin_Body += '0001';

                //Regalia
                CLEAR(HLN);
                HLN.SETRANGE("No. empleado", HCN."No. empleado");
                //HLN.SETRANGE("Tipo de nomina",HCN."Tipo de nomina");
                HLN.SETRANGE(Periodo, Fecha."Period Start", Fecha."Period End");
                HLN.SETRANGE("Concepto salarial", ConfNomina."Concepto Regalia");
                HLN.SETRANGE("Tipo concepto", HLN."Tipo concepto"::Ingresos);
                IF HLN.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                        Regalia += ROUND(HLN.Total, 0.01);
                    UNTIL HLN.NEXT = 0;
                Lin_Body += '01' + PADSTR('', 16 - STRLEN(FORMAT(Regalia, 0, '<Integer><Decimals,3>')), CERO) + FORMAT(Regalia, 0, '<Integer><Decimals,3>');

                //Preaviso, cesantia,viaticos, indemnizaciones
                CLEAR(HLN);
                HLN.SETRANGE("No. empleado", HCN."No. empleado");
                //HLN.SETRANGE("Tipo de nomina",HCN."Tipo de nomina");
                HLN.SETRANGE(Periodo, Fecha."Period Start", Fecha."Period End");
                HLN.SETRANGE("Cotiza ISR", FALSE);
                HLN.SETRANGE("Sujeto Cotizacion", FALSE);
                HLN.SETRANGE("Tipo concepto", HLN."Tipo concepto"::Ingresos);
                HLN.SETFILTER("Concepto salarial", '%1|%2|%3', ConfNomina."Concepto Cesantia", ConfNomina."Concepto Preaviso", ConfNomina."Concepto Dieta");
                IF HLN.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                        Preaviso_Cesantia += ROUND(HLN.Total, 0.01);
                    UNTIL HLN.NEXT = 0;
                Lin_Body += '02' + PADSTR('', 16 - STRLEN(FORMAT(Preaviso_Cesantia, 0, '<Integer><Decimals,3>')), CERO) + FORMAT(Preaviso_Cesantia, 0, '<Integer><Decimals,3>');

                //Pension alimenticia
                //Lin_Body += PADSTR('',16 - STRLEN(FORMAT(Preaviso_Cesantia,0,'<Integer><Decimals,3>')),CERO) + FORMAT(IngresosExentos,0,'<Integer><Decimals,3>');
                Lin_Body += '030000000000000.00';

                //TODO: Ver Archivo.WRITE(Lin_Body);

                CantLineas += 1;
            END;
        UNTIL HCN.NEXT = 0;


        //Pie de archivo
        CLEAR(Lin_Body);
        Lin_Body += 'S';
        CantLineas += 1;
        Lin_Body += PADSTR('', 6 - STRLEN(FORMAT(CantLineas, 0, '<Integer>')), CERO) + FORMAT(CantLineas, 0, '<Integer>');
        //TODO: Ver Archivo.WRITE(Lin_Body);
        //TODO: Ver Archivo.CLOSE;

        //TODO: Ver NombreArchivo := TEMPORARYPATH + NombreArchivo;
        NombreArchivo2 := ConfNomina."Path Archivos Electronicos" + 'TSS\' + NombreArchivo2;
        RenameFile;

        MESSAGE('%1 %2 %3', Text002, NombreArchivo2, Text003);
    end;

    procedure RDDGT3(var DGTMes: Integer; var DGTAno: Integer)
    var
        SalarioCotizable: Decimal;
    begin
        ConfNomina.GET();
        ConfContab.GET();
        EC.FINDFIRST;
        EC.TESTFIELD("RNC/CED");
        EC.TESTFIELD("ID RNL");
        RNC := DELCHR(EC."RNC/CED", '=', '-');

        Blanco := ' ';
        CERO := '0';
        PrimeraVez := TRUE;
        Empl.INIT;
        CantLineas := 1;
        ConfNomina.TESTFIELD("Path Archivos Electronicos");

        IF COPYSTR(ConfNomina."Path Archivos Electronicos", STRLEN(ConfNomina."Path Archivos Electronicos"), 1) <> '\' THEN
            ConfNomina."Path Archivos Electronicos" += '\';

        FechaTrans := DMY2DATE(1, DGTMes, DGTAno);
        //TODO: Ver PathENV := TEMPORARYPATH;

        Fecha.RESET;
        Fecha.SETRANGE("Period Type", Fecha."Period Type"::Month);
        Fecha.SETRANGE("Period Start", DMY2DATE(1, DATE2DMY(FechaTrans, 2), DATE2DMY(FechaTrans, 3)));
        Fecha.FINDFIRST;

        NombreArchivo := 'DGT3-' + RNC + '-' + FORMAT(FechaTrans, 0, '<Month,2>') + FORMAT(FechaTrans, 0, '<Year4>') + '.txt';
        NombreArchivo2 := NombreArchivo;
        //TODO: Ver Archivo.TEXTMODE(TRUE);
        //TODO: Ver Archivo.CREATE(PathENV + NombreArchivo);
        //TODO: Ver Archivo.TRUNC;

        //Creo la cabecera
        Lin_Body_DGT := 'E';
        Lin_Body_DGT += 'T3';
        Lin_Body_DGT += FORMAT(Blanco, 11 - STRLEN(RNC), '<Filler character, >') + RNC;
        Lin_Body_DGT += FORMAT(FechaTrans, 0, '<Month,2><Year4>');
        //TODO: Ver Archivo.WRITE(Lin_Body_DGT);

        Empl.RESET;
        Empl.SETRANGE("Employment Date", Fecha."Period Start", Fecha."Period End");
        CounterTotal := Empl.COUNT;
        Window.OPEN(Text001);

        Empl.FINDSET;
        REPEAT
            Counter := Counter + 1;
            Window.UPDATE(1, Empl."No.");
            Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

            //Creo el detalle
            CLEAR(Lin_Body_DGT);
            Lin_Body_DGT := 'D';
            Lin_Body_DGT += 'NI';
            CASE Empl."Document Type" OF
                0: //Cedula
                    Lin_Body_DGT += 'C';
                1: //Pasaporte
                    Lin_Body_DGT += 'P';
                ELSE
                    Lin_Body_DGT += 'N';
            END;
            Empl."Document ID" := DELCHR(Empl."Document ID", '=', '-');
            Empl."First Name" := FuncNom.Ascii2Ansi(Empl."First Name");
            Empl."Middle Name" := FuncNom.Ascii2Ansi(Empl."Middle Name");
            Empl."Last Name" := FuncNom.Ascii2Ansi(Empl."Last Name");
            Empl."Second Last Name" := FuncNom.Ascii2Ansi(Empl."Second Last Name");

            Lin_Body_DGT += COPYSTR(Empl."Document ID" + PADSTR(Blanco, 25 - STRLEN(Empl."Document ID")), 1, 25);
            Lin_Body_DGT += COPYSTR(Empl."First Name" + ' ' + Empl."Middle Name" + PADSTR(Blanco, 50 - STRLEN(Empl."First Name" + ' ' + Empl."Middle Name")), 1, 50);
            Lin_Body_DGT += COPYSTR(Empl."Last Name" + PADSTR(Blanco, 40 - STRLEN(Empl."Last Name")), 1, 40);
            Lin_Body_DGT += COPYSTR(Empl."Second Last Name" + PADSTR(Blanco, 40 - STRLEN(Empl."Second Last Name")), 1, 40);
            Lin_Body_DGT += FORMAT(Empl."Birth Date", 0, '<Day,2><Month,2><Year4>');
            CASE Empl.Gender OF
                1: //Femenino
                    Lin_Body_DGT += 'F'
                ELSE
                    Lin_Body_DGT += 'M';
            END;

            Lin_Body_DGT += FORMAT(Empl."Birth Date", 0, '<Day,2><Month,2><Year4>');
            Lin_Body_DGT += PADSTR('', 16 - STRLEN(FORMAT(SalarioCotizable, 0, '<Integer><Decimals,3>')), CERO) + FORMAT(SalarioCotizable, 0, '<Integer><Decimals,3>');
            Lin_Body_DGT += FORMAT(Empl."Employment Date", 0, '<Day,2><Month,2><Year4>');
            //TODO: Ver Lin_Body_DGT += COPYSTR(PADSTR(Blanco, 6 - STRLEN(Empl."Puesto Segun MT")) + Empl."Cod. Puesto MT", 1, 6);
            //TODO: Ver Lin_Body_DGT += COPYSTR(PADSTR(Blanco, 150 - STRLEN(Empl."Puesto Segun MT")) + Empl."Puesto Segun MT", 1, 150);
            //Para calcular las vacaciones
            IF DATE2DMY(Empl."Employment Date", 3) = DATE2DMY(TODAY, 3) THEN BEGIN
                Empl."Employment Date" := CALCDATE(CalcFecha, Empl."Employment Date");
                Lin_Body_DGT += FORMAT(Empl."Employment Date", 0, '<Day,2><Month,2><Year4>');
            END
            ELSE BEGIN
                Empl."Employment Date" := DMY2DATE(DATE2DMY(Empl."Employment Date", 1), DATE2DMY(Empl."Employment Date", 2), DATE2DMY(TODAY, 3));
                Lin_Body_DGT += FORMAT(Empl."Employment Date", 0, '<Day,2><Month,2><Year4>');
            END;

            Lin_Body_DGT += PADSTR(Blanco, 6); //Turno
            Lin_Body_DGT += PADSTR(Blanco, 2) + COPYSTR(EC."ID RNL", MAXSTRLEN(EC."ID RNL") - 4, 5); // RNL
            Lin_Body_DGT += PADSTR(Blanco, 150); //Observacion
            //TODO: Ver Archivo.WRITE(Lin_Body_DGT);
            CantLineas += 1;

        UNTIL Empl.NEXT = 0;


        //Pie de archivo
        CLEAR(Lin_Body_DGT);
        Lin_Body_DGT += 'S';

        Lin_Body_DGT += PADSTR('', 6 - STRLEN(FORMAT(CantLineas, 0, '<Integer>')), CERO) + FORMAT(CantLineas, 0, '<Integer>');
        //TODO: Ver Archivo.WRITE(Lin_Body_DGT);
        //TODO: Ver Archivo.CLOSE;

        //TODO: Ver NombreArchivo := TEMPORARYPATH + NombreArchivo;
        NombreArchivo2 := ConfNomina."Path Archivos Electronicos" + 'DGT\' + NombreArchivo2;
        //TODO: Ver RenameFile;
        MESSAGE('%1 %2 %3', Text002, NombreArchivo2, Text003);
    end;

    procedure RDDGT4(var DGTMes: Integer; var DGTAno: Integer)
    var
        SalarioCotizable: Decimal;
        HAP: Record 34002159;
        HayDatos: Boolean;
    begin
        ConfNomina.GET();
        ConfContab.GET();
        EC.FINDFIRST;
        EC.TESTFIELD("RNC/CED");
        EC.TESTFIELD("ID RNL");
        RNC := DELCHR(EC."RNC/CED", '=', '-');

        Blanco := ' ';
        CERO := '0';
        PrimeraVez := TRUE;
        Empl.INIT;
        CantLineas := 1;
        ConfNomina.TESTFIELD("Path Archivos Electronicos");

        IF COPYSTR(ConfNomina."Path Archivos Electronicos", STRLEN(ConfNomina."Path Archivos Electronicos"), 1) <> '\' THEN
            ConfNomina."Path Archivos Electronicos" += '\';

        FechaTrans := DMY2DATE(1, DGTMes, DGTAno);
        //TODO: Ver PathENV := TEMPORARYPATH;

        Fecha.RESET;
        Fecha.SETRANGE("Period Type", Fecha."Period Type"::Month);
        Fecha.SETRANGE("Period Start", DMY2DATE(1, DATE2DMY(FechaTrans, 2), DATE2DMY(FechaTrans, 3)));
        Fecha.FINDFIRST;

        NombreArchivo := 'DGT4-' + RNC + '-' + FORMAT(FechaTrans, 0, '<Month,2>') + FORMAT(FechaTrans, 0, '<Year4>') + '.txt';
        NombreArchivo2 := NombreArchivo;
        //TODO: Ver Archivo.TEXTMODE(TRUE);
        //TODO: Ver Archivo.CREATE(PathENV + NombreArchivo);
        //TODO: Ver Archivo.TRUNC;

        //Creo la cabecera
        Lin_Body_DGT := 'E';
        Lin_Body_DGT += 'T4';
        Lin_Body_DGT += FORMAT(Blanco, 11 - STRLEN(RNC), '<Filler character, >') + RNC;
        Lin_Body_DGT += FORMAT(FechaTrans, 0, '<Month,2><Year4>');
        //TODO: Ver Archivo.WRITE(Lin_Body_DGT);

        Empl.RESET;
        Empl.SETRANGE("Employment Date", Fecha."Period Start", Fecha."Period End");
        CounterTotal := Empl.COUNT;
        Window.OPEN(Text001);

        Empl.FINDSET;
        REPEAT
            Counter := Counter + 1;
            Window.UPDATE(1, Empl."No.");
            Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));
            HayDatos := FALSE;

            //Creo el detalle
            CLEAR(Lin_Body_DGT);
            Lin_Body_DGT := 'D';

            IF Empl."Employment Date" >= Fecha."Period Start" THEN BEGIN
                HayDatos := TRUE;
                Lin_Body_DGT += 'NI';
            END
            ELSE
                IF Empl."Termination Date" >= Fecha."Period Start" THEN BEGIN
                    HayDatos := TRUE;
                    Lin_Body_DGT += 'NS';
                END
                ELSE BEGIN
                    HAP.RESET;
                    HAP.SETRANGE("No. empleado", Empl."No.");
                    HAP.SETRANGE("Fecha efectividad", Fecha."Period Start", Fecha."Period End");
                    IF HAP.FINDFIRST THEN BEGIN
                        Lin_Body_DGT += 'NC';
                        HayDatos := TRUE;
                    END
                    ELSE
                        HAP.INIT;
                END;

            IF HayDatos THEN BEGIN
                CASE Empl."Document Type" OF
                    0: //Cedula
                        Lin_Body_DGT += 'C';
                    1: //Pasaporte
                        Lin_Body_DGT += 'P';
                    ELSE
                        Lin_Body_DGT += 'N';
                END;
                Empl."Document ID" := DELCHR(Empl."Document ID", '=', '-');
                Empl."First Name" := FuncNom.Ascii2Ansi(Empl."First Name");
                Empl."Middle Name" := FuncNom.Ascii2Ansi(Empl."Middle Name");
                Empl."Last Name" := FuncNom.Ascii2Ansi(Empl."Last Name");
                Empl."Second Last Name" := FuncNom.Ascii2Ansi(Empl."Second Last Name");

                Lin_Body_DGT += COPYSTR(Empl."Document ID" + PADSTR(Blanco, 25 - STRLEN(Empl."Document ID")), 1, 25);
                Lin_Body_DGT += COPYSTR(Empl."First Name" + ' ' + Empl."Middle Name" + PADSTR(Blanco, 50 - STRLEN(Empl."First Name" + ' ' + Empl."Middle Name")), 1, 50);
                Lin_Body_DGT += COPYSTR(Empl."Last Name" + PADSTR(Blanco, 40 - STRLEN(Empl."Last Name")), 1, 40);
                Lin_Body_DGT += COPYSTR(Empl."Second Last Name" + PADSTR(Blanco, 40 - STRLEN(Empl."Second Last Name")), 1, 40);
                Lin_Body_DGT += FORMAT(Empl."Birth Date", 0, '<Day,2><Month,2><Year4>');
                CASE Empl.Gender OF
                    1: //Femenino
                        Lin_Body_DGT += 'F'
                    ELSE
                        Lin_Body_DGT += 'M';
                END;

                Lin_Body_DGT += FORMAT(Empl."Birth Date", 0, '<Day,2><Month,2><Year4>');
                Lin_Body_DGT += PADSTR('', 16 - STRLEN(FORMAT(SalarioCotizable, 0, '<Integer><Decimals,3>')), CERO) + FORMAT(SalarioCotizable, 0, '<Integer><Decimals,3>');
                Lin_Body_DGT += FORMAT(Empl."Employment Date", 0, '<Day,2><Month,2><Year4>');
                IF Empl."Termination Date" <> 0D THEN
                    Lin_Body_DGT += FORMAT(Empl."Termination Date", 0, '<Day,2><Month,2><Year4>')
                ELSE
                    Lin_Body_DGT += '00000000';
                Lin_Body_DGT += COPYSTR(PADSTR(Blanco, 6 - STRLEN(Empl."Cod. Puesto MT")) + Empl."Cod. Puesto MT", 1, 6);
                //TODO: Ver Lin_Body_DGT += COPYSTR(PADSTR(Blanco, 150 - STRLEN(Empl."Puesto Segun MT")) + Empl."Puesto Segun MT", 1, 150);
                //Para calcular las vacaciones
                IF DATE2DMY(Empl."Employment Date", 3) = DATE2DMY(TODAY, 3) THEN BEGIN
                    Empl."Employment Date" := CALCDATE(CalcFecha, Empl."Employment Date");
                    Lin_Body_DGT += FORMAT(Empl."Employment Date", 0, '<Day,2><Month,2><Year4>');
                END;

                Lin_Body_DGT += PADSTR(Blanco, 6); //Turno
                Lin_Body_DGT += PADSTR(Blanco, 2) + COPYSTR(EC."ID RNL", MAXSTRLEN(EC."ID RNL") - 4, 5); // RNL
                //TODO: Ver Lin_Body_DGT += COPYSTR(PADSTR(Blanco, 3 - STRLEN(Empl."Cod. Nacionalidad MT")) + Empl."Cod. Nacionalidad MT", 1, 3);
                IF HAP."Fecha accion" <> 0D THEN
                    Lin_Body_DGT += FORMAT(HAP."Fecha accion", 0, '<Day,2><Month,2><Year4>')
                ELSE
                    Lin_Body_DGT += '00000000';
                //TODO: Ver Archivo.WRITE(Lin_Body_DGT);
                CantLineas += 1;
            END;
        UNTIL Empl.NEXT = 0;


        //Pie de archivo
        CLEAR(Lin_Body_DGT);
        Lin_Body_DGT += 'S';

        Lin_Body_DGT += PADSTR('', 6 - STRLEN(FORMAT(CantLineas, 0, '<Integer>')), CERO) + FORMAT(CantLineas, 0, '<Integer>');
        //TODO: Ver Archivo.WRITE(Lin_Body_DGT);
        //TODO: Ver Archivo.CLOSE;

        //TODO: Ver  IF ClientTypeManagement.GetCurrentClientType = CLIENTTYPE::Windows THEN BEGIN
        //TODO: Ver  NombreArchivo := TEMPORARYPATH + NombreArchivo;
        NombreArchivo2 := ConfNomina."Path Archivos Electronicos" + 'DGT\' + NombreArchivo2;
        //TODO: Ver RenameFile;
        MESSAGE('%1 %2 %3', Text002, NombreArchivo2, Text003);
        //TODO: Ver END
        //TODO: Ver    ELSE
        //TODO: Ver        MESSAGE(Text004);
    end;

    procedure RenameFile()
    var
    //TODO: Ver FileManagement: Codeunit 419;
    begin
        //TODO: Ver FileManagement.DownloadToFile(NombreArchivo, NombreArchivo2);
    end;
}

