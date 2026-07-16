codeunit 34002125 "Genera Formatos  E. Nomina RD"
{
    Permissions = TableData 23 = rimd,
                  TableData 81 = rimd,
                  TableData 98 = rimd,
                  TableData 270 = rm,
                  TableData 5200 = rimd;
    TableNo = 34002117;

    trigger OnRun()
    begin
        GHCN.COPY(Rec);
        CASE GHCN."Tipo Archivo" OF
            1:
                FormatoBanco(GHCN);
            2:
                NovedadesCambioSueldo;
            3:
                NovedadesVarSueldo;
        END;
    end;

    var
        ConfContab: Record 98;
        Empl: Record 5200;
        EC: Record 34002100;
        GHCN: Record 34002117;
        GHLN: Record 34002118;
        Fecha: Record 2000000007;
        BcoACH: Record 34002167;
        VLE: Record 25;
        BankAccount: Record 270;
        BankAccount2: Record 270;
        GenJnlLine: Record 81;
        CompanyInfo: Record 79;
        VendorBank: Record 288;
        Vendor: Record 23;
        FuncNom: Codeunit 34002104;
        Archivo: File;
        FileVar: File;
        IStream: InStream;
        StreamOut: OutStream;
        Lin_Body: Text[320];
        Lin_Body2: Text[400];
        CERO: Text[100];
        Blanco: Text[30];
        Window: Dialog;
        Text001: Label 'Generating file #1########## @2@@@@@@@@@@@@@';
        CounterTotal: Integer;
        Counter: Integer;
        SettleDate: Date;
        Text002: Label 'PAYMENT PAYROLL FROM %1 TO %2';
        Text003: Label 'PAYROLL FROM %1 TO %2';
        MSG001: Label 'La generacion del archivo del banco se ha realizado con éxito.';
        Err002: Label 'You must specify the Bank as balance account';
        NombreArchivo: Text[1024];
        NombreArchivo2: Text[1024];
        recDimEntry: Record 480;
        TotalGeneral: Decimal;
        Tracenumber: Text[30];
        PathENV: Text[1024];
        ExportAmount: Decimal;
        Err003: Label 'The date in the journal should be the same or later than today, please check';
        PrimeraVez: Boolean;
        SecuenciaTrans: Code[10];

    procedure FormatoBanco(var CN: Record 34002117)
    var
        Empresa: Record 34002100;
        ConfNomina: Record 34002103;
        DIPG: Record 34002108;
        HCN: Record 34002117;
        HCN2: Record 34002117;
        HLN: Record 34002118;
        Banco: Record 270;
        BcoNom: Record 34002139;
        NetoBanco: Decimal;
        Err001: Label 'Missing Bank''s information from Company Setup';
        RNC: Text;
        FechaTrans: Date;
        PathENV: Text[1024];
        Mes: Integer;
        Secuencia: Text[30];
        Total: Decimal;
        Concepto: Text[40];
        Contador: Integer;
    begin
        ConfNomina.GET();
        ConfContab.GET();
        Empresa.FINDFIRST;
        Empresa.TESTFIELD("RNC/CED");
        RNC := DELCHR(Empresa."RNC/CED", '=', '-');

        IF Empresa.Banco = '' THEN
            ERROR(Err001);

        BcoNom.GET(Empresa.Banco);
        BcoNom.TESTFIELD(Formato);

        Blanco := ' ';
        CERO := '0';
        PrimeraVez := TRUE;

        EC.GET(GHCN."Empresa cotizacion");
        EC.TESTFIELD("Identificador Empresa");

        ConfNomina.TESTFIELD("Path Archivos Electronicos");

        IF COPYSTR(ConfNomina."Path Archivos Electronicos", STRLEN(ConfNomina."Path Archivos Electronicos"), 1) <> '\' THEN
            ConfNomina."Path Archivos Electronicos" += '\';

        FechaTrans := GHCN."Fecha Pago";
        //TODO: Ver PathENV := TEMPORARYPATH;

        NombreArchivo := 'PE' + Empresa."Identificador Empresa" + '01' + FORMAT(FechaTrans, 0, '<Month,2>') + FORMAT(FechaTrans, 0, '<Day,2>') + DELCHR(FORMAT(TIME), '=', ' ampmAMPM:.');

        Mes := DATE2DMY(FechaTrans, 2);
        Mes := Mes * 2;

        BankAccount.GET(Empresa.Banco);

        IF ConfNomina."Secuencia de archivo Batch" = '' THEN BEGIN
            IF Mes < 10 THEN
                Secuencia := '000000' + FORMAT(Mes)
            ELSE
                Secuencia := '00000' + FORMAT(Mes);

            BankAccount.Secuencia := INCSTR(Secuencia);
            BankAccount.MODIFY;
        END
        ELSE BEGIN
            ConfNomina."Secuencia de archivo Batch" := INCSTR(ConfNomina."Secuencia de archivo Batch");
            ConfNomina.MODIFY;
            Secuencia := ConfNomina."Secuencia de archivo Batch";
        END;

        IF (UPPERCASE(BcoNom.Formato) = 'BR') OR (UPPERCASE(BcoNom.Formato) = 'RESERVAS') THEN BEGIN
            NombreArchivo := 'NOM-BR-' + Empresa."Empresa cotizacion" + '-' + FuncNom.FechaCorta(FechaTrans) + '.txt';
            NombreArchivo2 := NombreArchivo;
        END
        ELSE
            IF (UPPERCASE(BcoNom.Formato) = 'BLH') OR (UPPERCASE(BcoNom.Formato) = 'LOPEZDEHARO') THEN BEGIN
                NombreArchivo := '0' + BankAccount.Formato; //Identificador de empresa
                NombreArchivo += FORMAT(GHCN.Periodo, 0, '<Year4><Month,2><Day,2>'); //Fecha creacion de archivo
                NombreArchivo += FORMAT(TIME, 0, '<Hours24,2><Minutes,2><Seconds,2>'); //Hora creacion de archivo
                NombreArchivo += 'S';//Tipo de archivo ==> Envio(S) Respuesta(R)
                NombreArchivo += '.txt';
                NombreArchivo2 := NombreArchivo;
            END
            ELSE BEGIN
                NombreArchivo += Secuencia + 'E.txt';
                NombreArchivo2 := NombreArchivo;
                SecuenciaTrans := '0000000';
            END;

        //TODO: Ver Archivo.TEXTMODE(TRUE);
        //TODO: Ver Archivo.CREATE(PathENV + NombreArchivo);
        //TODO: Ver Archivo.TRUNC;


        HCN.RESET;
        //HCN.COPYFILTERS(CN);
        HCN.SETFILTER("No. empleado", CN.GETFILTER("No. empleado"));
        HCN.SETFILTER(Periodo, CN.GETFILTER(Periodo));
        HCN.SETFILTER("Tipo de nomina", CN.GETFILTER("Tipo de nomina"));
        HCN.SETFILTER("Job No.", CN.GETFILTER("Job No."));
        HCN.SETRANGE("Forma de Cobro", 3);// Transferencias de banco
        //HCN.SETRANGE(Banco,CN.Banco);
        CounterTotal := HCN.COUNT;

        Window.OPEN(Text001);
        //ERROR('%1',HCN.GETFILTERS);
        //IF HCN.FINDSET THEN
        HCN.FINDSET;
        REPEAT
            Counter := Counter + 1;
            Window.UPDATE(1, HCN."No. empleado");
            Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

            Empl.GET(HCN."No. empleado");

            DIPG.RESET;
            DIPG.SETRANGE("No. empleado", HCN."No. empleado");
            DIPG.FINDFIRST;
            IF (BcoNom.Formato = 'Popular') OR (BcoNom.Formato = 'BPD') THEN BEGIN
                IF PrimeraVez THEN BEGIN
                    PrimeraVez := FALSE;
                    //Creo la cabecera
                    /*
                    HCN2.RESET;
                    HCN2.SETFILTER(Periodo,GHCN.GETFILTER(Periodo));
                    HCN2.SETFILTER("Tipo Nomina",GHCN.GETFILTER("Tipo Nomina"));
                    HCN2.SETRANGE("Forma de Cobro",3);// Transferencias de banco
                    */
                    HCN2.RESET;
                    HCN2.COPYFILTERS(HCN);
                    CounterTotal := HCN.COUNT;
                    HCN2.FINDSET;
                    REPEAT
                        HCN2.CALCFIELDS("Total Ingresos", "Total deducciones");
                        //              TotalGeneral += ROUND(HCN2."Total Ingresos" + HCN2."Total deducciones",0.01);
                        GHLN.RESET;
                        GHLN.SETFILTER(Periodo, HCN2.GETFILTER(Periodo));
                        GHLN.SETFILTER("Tipo Nomina", HCN2.GETFILTER("Tipo Nomina"));
                        GHLN.SETFILTER("Job No.", HCN2.GETFILTER("Job No."));
                        GHLN.SETRANGE("No. empleado", HCN2."No. empleado");
                        IF GHLN.FINDSET THEN
                            REPEAT
                                TotalGeneral += ROUND(GHLN.Total, 0.01);
                            UNTIL GHLN.NEXT = 0;
                    UNTIL HCN2.NEXT = 0;

                    //TotalGeneral := ROUND(TotalGeneral,0.01);
                    Lin_Body := 'H';
                    Lin_Body += FORMAT(RNC, 15);
                    Lin_Body += FORMAT(Empresa."Nombre Empresa cotizacion", 35);
                    Lin_Body += Secuencia + '01';
                    Lin_Body += FORMAT(FechaTrans, 0, '<Year4><Month,2><Day,2>');
                    Lin_Body += '000000000000000000000000';
                    Lin_Body += FORMAT(CounterTotal, 11, '<Integer,11><Filler Character,0>');
                    Lin_Body += FORMAT(TotalGeneral * 100, 13, '<integer,13><Filler Character,0>');
                    Lin_Body += '000000000000000';
                    Lin_Body += FORMAT(TODAY, 0, '<Year4><Month,2><Day,2>');
                    Lin_Body += FORMAT(TIME, 4, '<hours24,2><Minutes,2>');
                    Lin_Body += FORMAT(Empresa."E-Mail", 40);
                    Lin_Body += FORMAT(Blanco, 136);
                    //TODO: Ver //TODO: Ver Archivo.WRITE(Lin_Body);
                END;
                //Creo el detalle
                SecuenciaTrans := INCSTR(SecuenciaTrans);
                CLEAR(Lin_Body);
                Lin_Body := 'N';
                Lin_Body += FORMAT(RNC, 15);
                Lin_Body += FORMAT(Secuencia, 7);
                Lin_Body += FORMAT(SecuenciaTrans, 7);

                //tipo cuenta ==> 0= ahorro, 1= Corriente, 2 = cheque
                IF (DIPG."Numero Cuenta" <> '') AND (DIPG."Tipo Cuenta" <> 2) THEN
                    Lin_Body += FORMAT(DIPG."Numero Cuenta") + FORMAT(Blanco, 20 - STRLEN(DIPG."Numero Cuenta"))
                ELSE
                    IF DIPG."Tipo Cuenta" <> 2 THEN
                        ERROR(Err002, Empl."No." + ', ' + Empl."Full Name")
                    ELSE
                        IF DIPG."Tipo Cuenta" = 2 THEN
                            Lin_Body += FORMAT(Blanco, 20);

                IF DIPG."Tipo Cuenta" = 0 THEN
                    Lin_Body += '2'
                ELSE
                    IF DIPG."Tipo Cuenta" = 1 THEN
                        Lin_Body += '1'
                    ELSE
                        Lin_Body += '5';

                Lin_Body += '214'; //Moneda 214=RD$, 840=USD, 978=Euro
                BcoACH.GET(DIPG."Cod. Banco");
                Lin_Body += BcoACH."ACH Reservas";
                Lin_Body += FORMAT(BcoACH."Digito Chequeo");

                IF DIPG."Tipo Cuenta" = 0 THEN
                    Lin_Body += '32'
                ELSE
                    IF DIPG."Tipo Cuenta" = 1 THEN
                        Lin_Body += '22'
                    ELSE
                        Lin_Body += '12';

                //16/06/15          HCN.CALCFIELDS("Total Ingresos","Total deducciones");
                //16/06/15       Total    := ROUND(HCN."Total Ingresos" + HCN."Total deducciones",0.01);
                CLEAR(Total);
                GHLN.RESET;
                GHLN.SETFILTER(Periodo, HCN2.GETFILTER(Periodo));
                GHLN.SETFILTER("Tipo de nomina", HCN.GETFILTER("Tipo de nomina"));
                GHLN.SETRANGE("No. empleado", HCN."No. empleado");
                IF GHLN.FINDSET THEN
                    REPEAT
                        Total += ROUND(GHLN.Total, 0.01);
                    UNTIL GHLN.NEXT = 0;

                Lin_Body += FORMAT(Total * 100, 13, '<integer,13><Filler Character,0>');
                CASE Empl."Document Type" OF
                    0: //Cedula
                        Lin_Body += 'CE';
                    1: //Pasaporte
                        Lin_Body += 'PS';
                    ELSE //Pasaporte
                        Lin_Body += 'RN';
                END;
                Empl."Document ID" := DELCHR(Empl."Document ID", '=', ' -');
                Lin_Body += Empl."Document ID" + FORMAT(Blanco, 15 - STRLEN(Empl."Document ID"), '<Text>');
                //Lin_Body += FORMAT(Blanco,17,'<Text,17>');
                Empl."Full Name" := FuncNom.Ascii2Ansi(Empl."Full Name");
                Lin_Body += FORMAT(COPYSTR(Empl."Full Name", 1, 35), 35);
                Lin_Body += FORMAT(FechaTrans, 12, '<Year4><Month,2><Day,2><Filler Character,0>');
                Concepto := STRSUBSTNO(Text002, GHCN.Inicio, GHCN.Fin);
                Lin_Body += FORMAT(COPYSTR(Concepto, 1, 40), 40);
                Lin_Body += FORMAT(Blanco, 4);

                IF Empl."E-Mail" <> '' THEN
                    Lin_Body += '1'
                ELSE
                    Lin_Body += ' ';

                IF Empl."Company E-Mail" <> '' THEN
                    Lin_Body += FORMAT(Empl."Company E-Mail", 40)
                ELSE
                    Lin_Body += FORMAT(Empl."E-Mail", 40);

                Lin_Body += FORMAT(Blanco, 12);
                Lin_Body += '00';
                Lin_Body += FORMAT(Blanco, 78);
                //TODO: Ver Archivo.WRITE(Lin_Body);

                Contador := Contador + 1;
            END
            ELSE
                IF (BcoNom.Formato = 'BHD') THEN BEGIN
                    //Creo el detalle
                    //tipo cuenta ==> 0= ahorro, 1= Corriente, 2 = cheque
                    CLEAR(Lin_Body);
                    DIPG.TESTFIELD("Numero Cuenta");
                    Lin_Body += DIPG."Numero Cuenta";
                    Lin_Body += ';' + COPYSTR(Empl."Full Name", 1, 50);
                    Lin_Body += ';' + Empl."No.";
                    HCN.CALCFIELDS("Total Ingresos", "Total deducciones");
                    Total := ROUND(HCN."Total Ingresos" + HCN."Total deducciones", 0.01);

                    Lin_Body += ';' + FORMAT(Total, 0, '<Integer><Decimals,3>');
                    Lin_Body += ';' + STRSUBSTNO(Text002, GHCN.Inicio, GHCN.Fin);
                    //TODO: Ver Archivo.WRITE(Lin_Body);
                    Contador := Contador + 1;
                END
                ELSE
                    IF (UPPERCASE(BcoNom.Formato) = 'BR') OR (UPPERCASE(BcoNom.Formato) = 'RESERVAS') THEN BEGIN
                        //Creo el detalle
                        //tipo cuenta ==> 0= ahorro, 1= Corriente, 2 = cheque
                        CLEAR(Lin_Body);
                        IF DIPG."Tipo Cuenta" = 0 THEN
                            Lin_Body += 'CA'
                        ELSE
                            Lin_Body += 'CC';
                        Lin_Body += 'DOP'; //Moneda
                        Lin_Body += DELCHR(BankAccount."Bank Account No.", '=', '- ') + ',';
                        DIPG.TESTFIELD("Numero Cuenta");
                        Lin_Body += DIPG."Numero Cuenta";
                        HCN.CALCFIELDS("Total Ingresos", "Total deducciones");
                        Total := ROUND(HCN."Total Ingresos" + HCN."Total deducciones", 0.01);
                        Lin_Body += ',' + FORMAT(Total * 100, 13, '<Integer>');
                        Empl."Full Name" := FuncNom.Ascii2Ansi(Empl."Full Name");
                        Lin_Body += ',' + COPYSTR(DELCHR(Empl."Full Name", '=', ','), 1, 39);
                        CASE Empl."Document Type" OF
                            0:
                                Lin_Body += 'Cedula';
                            1:
                                Lin_Body += 'Pasaporte';
                            2:
                                Lin_Body += 'RNC';
                        END;
                        Empl."Document ID" := DELCHR(Empl."Document ID", '=', ' -');
                        Lin_Body += Empl."Document ID";
                        Concepto := STRSUBSTNO(Text002, GHCN.Inicio, GHCN.Fin);
                        Lin_Body += FORMAT(COPYSTR(Concepto, 1, 55), 55);

                        //TODO: Ver Archivo.WRITE(Lin_Body);
                        Contador := Contador + 1;
                    END
                    ELSE
                        IF (UPPERCASE(BcoNom.Formato) = 'BDP') OR (UPPERCASE(BcoNom.Formato) = 'PROGRESO') THEN BEGIN
                            //Creo el Cabecera
                            IF PrimeraVez THEN BEGIN
                                PrimeraVez := FALSE;
                                SecuenciaTrans := '000000';
                                BankAccount.GET(Empresa.Banco);
                                HCN2.RESET;
                                HCN2.COPYFILTERS(HCN);
                                CounterTotal := HCN.COUNT;
                                HCN2.FINDSET;
                                REPEAT
                                    HCN2.CALCFIELDS("Total Ingresos", "Total deducciones");
                                    //              TotalGeneral += ROUND(HCN2."Total Ingresos" + HCN2."Total deducciones",0.01);
                                    GHLN.RESET;
                                    GHLN.SETFILTER(Periodo, HCN2.GETFILTER(Periodo));
                                    GHLN.SETFILTER("Tipo de nomina", HCN2.GETFILTER("Tipo de nomina"));
                                    GHLN.SETRANGE("No. empleado", HCN2."No. empleado");
                                    IF GHLN.FINDSET THEN
                                        REPEAT
                                            TotalGeneral += ROUND(GHLN.Total, 0.01);
                                        UNTIL GHLN.NEXT = 0;
                                UNTIL HCN2.NEXT = 0;

                                //Creo la cabecera
                                RNC := DELCHR(RNC, '=', '-. ,');
                                Lin_Body := PADSTR(CERO, 11 - STRLEN(RNC), '0') + RNC; //RNC
                                Lin_Body += 'H'; //Tipo de registro
                                BankAccount."Bank Account No." := DELCHR(BankAccount."Bank Account No.", '=', '- ');
                                Lin_Body += PADSTR(CERO, 10 - STRLEN(BankAccount."Bank Account No."), '0') + BankAccount."Bank Account No.";
                                Lin_Body += FORMAT(TotalGeneral * 100, 11, '<integer,11><Filler Character,0>');
                                Lin_Body += FORMAT(FechaTrans, 0, '<Month,2><Day,2><Year4>'); //Fecha efectividad MMDDYYYY
                                Lin_Body += FORMAT(CounterTotal, 6, '<Integer,6><Filler Character,0>');
                                Lin_Body += FORMAT(COPYSTR(Empresa."Nombre Empresa cotizacion", 1, 30), 30, '<Filler Character, >');
                                //TODO: Ver Archivo.WRITE(Lin_Body);
                            END;

                            //Creo el detalle
                            //tipo cuenta ==> 0= ahorro, 1= Corriente, 2 = cheque
                            Lin_Body := PADSTR(CERO, 11 - STRLEN(RNC), '0') + RNC; //RNC
                            Lin_Body += 'N'; //Detalle
                            DIPG.TESTFIELD("Numero Cuenta");
                            Lin_Body += PADSTR(CERO, 10 - STRLEN(DIPG."Numero Cuenta"), '0') + DIPG."Numero Cuenta"; //No. cuenta beneficiario
                            HCN.CALCFIELDS("Total Ingresos", "Total deducciones");
                            Total := ROUND(HCN."Total Ingresos" + HCN."Total deducciones", 0.01);
                            Lin_Body += CONVERTSTR(FORMAT(Total * 100, 11, '<Integer,11>'), ' ', '0'); //Importe a pagar
                            Lin_Body += FORMAT(FechaTrans, 0, '<Month,2><Day,2><Year4>'); //Fecha efectividad MMDDYYYY
                            SecuenciaTrans := INCSTR(SecuenciaTrans);
                            Lin_Body += SecuenciaTrans;
                            Empl."Full Name" := FuncNom.Ascii2Ansi(Empl."Full Name");
                            Lin_Body += FORMAT(COPYSTR(Empl."Full Name", 1, 30), 30);
                            Contador := Contador + 1;
                            //TODO: Ver Archivo.WRITE(Lin_Body);
                        END
                        ELSE
                            IF (UPPERCASE(BcoNom.Formato) = 'BLH') OR (UPPERCASE(BcoNom.Formato) = 'LOPEZDEHARO') THEN BEGIN
                                //Creo el Cabecera
                                DIPG.RESET;
                                DIPG.SETRANGE("No. empleado", HCN."No. empleado");
                                DIPG.FINDFIRST;
                                IF PrimeraVez THEN BEGIN
                                    PrimeraVez := FALSE;
                                    //Creo la cabecera
                                    Lin_Body2 := 'H'; //Header
                                    Lin_Body2 += '0' + FORMAT(Empresa."Identificador Empresa"); //Identificador de empresa
                                    RNC := DELCHR(RNC, '=', '-. ,');
                                    Lin_Body2 += FORMAT(Blanco, 11 - STRLEN(RNC), '<Filler character, >') + RNC; //RNC
                                    Lin_Body2 += FORMAT(TODAY, 0, '<Year4><Month,2><Day,2>'); //Fecha creacion YYYYMMDD
                                    Lin_Body2 += FORMAT(TIME, 0, '<Hours24,2><Minutes,2><Seconds,2>'); //Hora creacion HHMMSS
                                    Lin_Body2 += FORMAT(FechaTrans, 0, '<Year4><Month,2><Day,2>'); //Fecha efectividad YYYYMMDD
                                                                                                   //Lin_Body2 += FORMAT(TIME,0,'<Hours24,2><Minutes,2><Seconds,2>');
                                    Lin_Body2 += '000000'; //Hora efectividad HHMMSS
                                    Lin_Body2 += '0000000000'; //No. referencia
                                    Lin_Body2 += 'P'; //Post File
                                    Lin_Body2 += '08'; //08=Payroll, 09=Pay bills
                                    Concepto := STRSUBSTNO(Text002, GHCN.Inicio, GHCN.Fin);
                                    Lin_Body2 += FORMAT(Blanco, 80 - STRLEN(Concepto), '<Filler character, >') + Concepto; //Concepto
                                    Lin_Body2 += '0000'; //ID Cuenta
                                    Lin_Body2 += '000000000000000'; //Para tarjetas de credito, No de comercio (Merchand ID)
                                    Lin_Body2 += '1000'; //Version del archivo
                                    Lin_Body2 += FORMAT(Blanco, 238); //Espacios en blanco para llegar a 400
                                    //TODO: Ver Archivo.WRITE(Lin_Body2);
                                END;

                                //Creo el detalle
                                //tipo cuenta ==> 0= ahorro, 1= Corriente, 2 = cheque
                                CLEAR(Lin_Body2);
                                Lin_Body2 := 'D'; //Detalle
                                Contador := Contador + 1;
                                CLEAR(Blanco);
                                Lin_Body2 += FORMAT(Contador, 6, '<Integer,6><Filler Character,0>'); //Secuencia
                                CASE Empl."Document Type" OF //Tipo documento
                                    0:
                                        Lin_Body2 += 'CD';
                                    1:
                                        Lin_Body2 += 'PP';
                                    ELSE
                                        Lin_Body2 += 'OT';
                                END;
                                Lin_Body2 += FORMAT(DELCHR(Empl."Document ID", '=', '-. '), 20); //ID Documento
                                Empl."Full Name" := FuncNom.Ascii2Ansi(Empl."Full Name");
                                Lin_Body2 += FORMAT(COPYSTR(Empl."Full Name", 1, 60), 60); //Nombre
                                Lin_Body2 += 'C'; //Tipo de operacion. D=Debito, C=Credito
                                                  //Lin_Body2 += FORMAT(DIPG."Cod. Banco",4); //No. Banco destino
                                Lin_Body2 += 'BLDH'; //No. Banco destino
                                DIPG.TESTFIELD("Numero Cuenta");
                                Lin_Body2 += DIPG."Numero Cuenta" + FORMAT(Blanco, 30 - STRLEN(DIPG."Numero Cuenta"), '<Filler Character, >'); //No. cuenta beneficiario

                                IF DIPG."Tipo Cuenta" = DIPG."Tipo Cuenta"::Credit THEN //Tipo de cuenta
                                    Lin_Body2 += 'DDA'
                                ELSE
                                    Lin_Body2 += 'SAV';
                                Lin_Body2 += '214'; //Divisa, 214=RD$, 840=US$, 978=EUR
                                HCN.CALCFIELDS("Total Ingresos", "Total deducciones");
                                Total := ROUND(HCN."Total Ingresos" + HCN."Total deducciones", 0.01);
                                TotalGeneral += Total;
                                //MESSAGE('%1',CONVERTSTR(FORMAT(Total,15,'<Integer,12><Decimals,3>'),' ','0'));
                                Lin_Body2 += CONVERTSTR(FORMAT(Total * 100, 15, '<Integer>'), ' ', '0'); //Importe a pagar

                                Total := 0;
                                Lin_Body2 += FORMAT(Total, 30, '<Integer,30><Filler character,0>');
                                IF (Empl."E-Mail" <> '') OR (Empl."Company E-Mail" <> '') THEN BEGIN
                                    Lin_Body2 += 'Y';
                                    IF Empl."Company E-Mail" <> '' THEN
                                        Lin_Body2 += FORMAT(Empl."Company E-Mail", 60)
                                    ELSE
                                        Lin_Body2 += FORMAT(Empl."E-Mail", 60);
                                END
                                ELSE BEGIN
                                    Lin_Body2 += 'N';
                                    Lin_Body2 += FORMAT(Empl."Company E-Mail", 60);
                                END;
                                Concepto := STRSUBSTNO(Text003, GHCN.Inicio, GHCN.Fin);
                                Lin_Body2 += FORMAT(COPYSTR(Concepto, 1, 20), 20);
                                Lin_Body2 += FORMAT(Blanco, 80, '<Filler Character, >');
                                Lin_Body2 += '0000';
                                Lin_Body2 += 'I';
                                Lin_Body2 += 'N';
                                Lin_Body2 += FORMAT(Blanco, 58, '<Filler Character, >');

                                //TODO: Ver Archivo.WRITE(Lin_Body2);
                            END;
        UNTIL HCN.NEXT = 0;

        IF (UPPERCASE(BcoNom.Formato) = 'BLH') OR (UPPERCASE(BcoNom.Formato) = 'LOPEZDEHARO') THEN BEGIN
            /*
            TotalGeneral := 0;

             GHLN.RESET;
             GHLN.SETFILTER(Periodo,HCN.GETFILTER(Periodo));
             GHLN.SETFILTER("Tipo de nomina",HCN.GETFILTER("Tipo de nomina"));

             IF GHLN.FINDSET THEN
               REPEAT
                 GHCN.GET(GHLN.Ano,GHLN."No. empleado",GHLN.Periodo,GHLN."Job No.",GHLN."Tipo de nomina");
                 IF GHCN."Forma de Cobro" = GHCN."Forma de Cobro"::"Transferencia Banc." THEN
                    TotalGeneral += ROUND(GHLN.Total,0.01);
               UNTIL GHLN.NEXT = 0;
               */
            // MESSAGE('%1 %2',GHLN.GETFILTERS,totalgeneral);
            Lin_Body2 := 'S';
            Lin_Body2 += FORMAT(Contador, 6, '<Integer,6><Filler Character,0>');
            Lin_Body2 += PADSTR(CERO, 15 - STRLEN(FORMAT(TotalGeneral * 100, 0, '<Integer>')), '0') + FORMAT(TotalGeneral * 100, 0, '<Integer>');
            Lin_Body2 += FORMAT(Blanco, 378, '<Filler character, >');
            //TODO: Ver Archivo.WRITE(Lin_Body2);
        END;
        //TODO: Ver Archivo.CLOSE;

        //TODO: Ver NombreArchivo := TEMPORARYPATH + NombreArchivo;
        NombreArchivo2 := ConfNomina."Path Archivos Electronicos" + BcoNom.Formato + '\' + NombreArchivo2;
        //MESSAGE('%1\ %2',NOMBREARCHIVO,NOMBREARCHIVO2);
        RenameFile;

    end;

    procedure NovedadesCambioSueldo()
    var
        HSalario: Record 34002149;
        CT: Record 34002101;
    begin
        /*Archivo para novedades de modificacion de sueldo (Aviso de nuevo sueldo)
        o RUC de la empresa (13 digitos)
        o Codigo de la sucursal (4 digitos)
        o Año actual (4 digitos formato YYYY)
        o Mes actual (2 digitos formato MM)
        o Tipo de movimiento (prefijado como MSU)
        o Cédula (Actualizada) de identidad del afiliado afectado (10 digitos)
        o Nuevo sueldo (14 digitos)
        */
        /*
        Blanco := ';';
        CERO   := '0';
        EC.GET(GHCN."Empresa cotizacion");
        ConfNomina.GET();
        ConfNomina.TESTFIELD("Path Archivos Electronicos");
        ConfNomina.TESTFIELD("Secuencia de archivo Batch");
        ConfNomina."Secuencia de archivo Batch" := INCSTR(ConfNomina."Secuencia de archivo Batch");
        ConfNomina.MODIFY;
        
        Fecha.RESET;
        Fecha.SETRANGE(Fecha."Period Type",Fecha."Period Type"::Month);
        Fecha.SETRANGE(Fecha."Period Start",DMY2DATE(1,DATE2DMY(WORKDATE,2),DATE2DMY(WORKDATE,3)));
        Fecha.FINDFIRST;
        
        IF COPYSTR(ConfNomina."Path Archivos Electronicos",STRLEN(ConfNomina."Path Archivos Electronicos")-1,1) <> '\' THEN
           ConfNomina."Path Archivos Electronicos" += '\';
        
        NombreArchivo  := ('c:\temp\' + 'CAMBIO-S-' +
                          FORMAT(WORKDATE,0,'<Year4>') + FORMAT(WORKDATE,0,'<Month,2>') +
                          FORMAT(WORKDATE,0,'<Day,2>') + EC."Identificador Empresa" + '_01.txt');
        NombreArchivo2 := (ConfNomina."Path Archivos Electronicos" + 'CAMBIO-S-' +
                          FORMAT(WORKDATE,0,'<Year4>') + FORMAT(WORKDATE,0,'<Month,2>') +
                          FORMAT(WORKDATE,0,'<Day,2>') + EC."Identificador Empresa" + '_01.txt');
        
        Archivo.TEXTMODE(TRUE);
        {
        Archivo.CREATE(ConfNomina."Path Archivos Electronicos" + 'CAMBIO-S-' +
                       FORMAT(WORKDATE,0,'<Year4>') + FORMAT(WORKDATE,0,'<Month,2>') +
                       FORMAT(WORKDATE,0,'<Day,2>') + '.txt');
        }
        Archivo.CREATE(NombreArchivo);
        Archivo.TRUNC;
        
        HSalario.RESET;
        HSalario.SETRANGE("Fecha Hasta",Fecha."Period Start",NORMALDATE(Fecha."Period End"));
        CounterTotal := HSalario.COUNT;
        Window.OPEN(Text001);
        
        IF HSalario.FINDSET THEN
           REPEAT
              Counter := Counter + 1;
              Window.UPDATE(1,HSalario."No. empleado");
              Window.UPDATE(2,ROUND(Counter / CounterTotal * 10000,1));
        
              Empl.GET(HSalario."No. empleado");
              Empl.CALCFIELDS(Salario);
        
              CLEAR(Lin_Body);
              Lin_Body := EC."RNC/CED" + Blanco + Empl."Working Center" + Blanco + FORMAT(WORKDATE,0,'<Year4>') + Blanco +
                          FORMAT(WORKDATE,0,'<Month,2>') + Blanco + 'MSU' + Blanco + Lin_Body + FORMAT(Empl."Document ID",10) +
                          Blanco + FORMAT(Empl.Salario,14,'<Integer><Decimals,3>') + Blanco + 'O';
              //TODO: Ver Archivo.WRITE(Lin_Body);
           UNTIL HSalario.NEXT = 0;
        
        Archivo.CLOSE;
        RenameFile;
        */

    end;

    procedure NovedadesVarSueldo()
    var
        HCabNomina: Record 34002117;
        HLinNomina: Record 34002118;
        Acumulado: Decimal;
    begin
        /*Archivo para Novedades de Variacion de Sueldo (Aviso de variacion de sueldo por extras)
        o RUC de la empresa (13 digitos)
        o Codigo de la sucursal (4 digitos)
        o Año actual (4 digitos formato YYYY)
        o Mes actual (2 digitos formato MM)
        o Tipo de movimiento (prefijado como INS)
        o Cédula (Actualizada) de identidad del afiliado afectado (10 digitos)
        o Valores Extras (máximo 14 digitos)
        o Causa. (1 digito (codificacion ver Anexo) )
        */
        /*GRN
        Blanco := ';';
        CERO   := '0';
        EC.GET(GHCN."Empresa cotizacion");
        ConfNomina.GET();
        ConfNomina.TESTFIELD("Path Archivos Electronicos");
        ConfNomina.TESTFIELD("Secuencia de archivo Batch");
        ConfNomina."Secuencia de archivo Batch" := INCSTR(ConfNomina."Secuencia de archivo Batch");
        ConfNomina.MODIFY;
        
        Fecha.RESET;
        Fecha.SETRANGE(Fecha."Period Type",Fecha."Period Type"::Month);
        Fecha.SETRANGE(Fecha."Period Start",DMY2DATE(1,DATE2DMY(WORKDATE,2),DATE2DMY(WORKDATE,3)));
        Fecha.FINDFIRST;
        
        IF COPYSTR(ConfNomina."Path Archivos Electronicos",STRLEN(ConfNomina."Path Archivos Electronicos")-1,1) <> '\' THEN
           ConfNomina."Path Archivos Electronicos" += '\';
        
        Archivo.TEXTMODE(TRUE);
        NombreArchivo  := 'c:\temp\' + 'VARIACION-S-' +
                          FORMAT(WORKDATE,0,'<Year4>') + FORMAT(WORKDATE,0,'<Month,2>') +
                          FORMAT(WORKDATE,0,'<Day,2>') + '.txt';
        
        NombreArchivo2 := ConfNomina."Path Archivos Electronicos" + 'VARIACION-S-' +
                          FORMAT(WORKDATE,0,'<Year4>') + FORMAT(WORKDATE,0,'<Month,2>') +
                          FORMAT(WORKDATE,0,'<Day,2>') + '.txt';
        
        {
        Archivo.CREATE(ConfNomina."Path Archivos Electronicos" + 'VARIACION-S-' +
                       FORMAT(WORKDATE,0,'<Year4>') + FORMAT(WORKDATE,0,'<Month,2>') +
                       FORMAT(WORKDATE,0,'<Day,2>') + '.txt');
        }
        
        Archivo.TRUNC;
        
        HCabNomina.RESET;
        HCabNomina.SETRANGE("Tipo Nomina",GHCN."Tipo Nomina");
        HCabNomina.SETRANGE(Periodo,GHCN.Periodo);
        
        CounterTotal := HCabNomina.COUNT;
        Window.OPEN(Text001);
        
        HCabNomina.FINDSET;
        REPEAT
          Counter := Counter + 1;
          Window.UPDATE(1,HCabNomina."No. empleado");
          Window.UPDATE(2,ROUND(Counter / CounterTotal * 10000,1));
        
          Empl.GET(HCabNomina."No. empleado");
          Acumulado := 0;
        
          HLinNomina.RESET;
          HLinNomina.SETRANGE("No. empleado",HCabNomina."No. empleado");
          HLinNomina.SETRANGE("Tipo de Nomina",HCabNomina."Tipo de Nomina");
          HLinNomina.SETRANGE(Periodo,HCabNomina.Periodo);
          HLinNomina.SETRANGE("Salario Base",FALSE);
          HLinNomina.SETRANGE("Sujeto Cotizacion",TRUE);
          IF HLinNomina.FINDSET THEN
             REPEAT
              Acumulado += HLinNomina.Total;
             UNTIL HLinNomina.NEXT = 0;
        
          IF Acumulado <> 0 THEN
             BEGIN
                CLEAR(Lin_Body);
                Lin_Body := EC."RNC/CED" + Blanco + Empl."Working Center" + Blanco + FORMAT(WORKDATE,0,'<Year4>') + Blanco +
                            FORMAT(WORKDATE,0,'<Month,2>') + Blanco + 'INS' + Blanco + Lin_Body + FORMAT(Empl."Document ID",10) +
                            Blanco + FORMAT(Acumulado,14,'<Integer><Decimals,3>') + Blanco + 'O';
                //TODO: Ver Archivo.WRITE(Lin_Body);
             END;
        UNTIL HCabNomina.NEXT =0;
        Window.CLOSE;
        Archivo.CLOSE;
        
        RenameFile;
        */

    end;

    procedure FormatoBancoDiario(CodDiario: Code[20]; SeccDiario: Code[20])
    var
        GenJnlLine: Record 81;
        Banco: Record 270;
        DIPG: Record 34002108;
        BcoACH: Record 34002167;
        FirstTime: Boolean;
        BancoAnt: Code[20];
        Err001: Label 'The bank account must be the same in all the lines, please correct it';
    begin
        //Verifico que todas las lineas del diario tengan el mismo banco
        /*
        FirstTime := TRUE;
        Blanco := ' ';
        CERO   := '0';
        
        ConfNomina.GET();
        ConfNomina.TESTFIELD("Path Archivos Electronicos");
        ConfNomina.TESTFIELD("Secuencia de archivo Batch");
        ConfNomina.TESTFIELD("Dimension Empleado");
        
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE("Journal Template Name",CodDiario);
        GenJnlLine.SETRANGE("Journal Batch Name",SeccDiario);
        GenJnlLine.SETRANGE("Account Type",GenJnlLine."Account Type"::"Bank Account");
        GenJnlLine.SETFILTER("Account No.",'<>%1','');
        IF NOT GenJnlLine.FINDFIRST THEN
           BEGIN
            GenJnlLine.RESET;
            GenJnlLine.SETRANGE("Journal Template Name",CodDiario);
            GenJnlLine.SETRANGE("Journal Batch Name",SeccDiario);
            GenJnlLine.SETRANGE("Bal. Account Type",GenJnlLine."Account Type"::"Bank Account");
            GenJnlLine.SETFILTER("Bal. Account No.",'<>%1','');
            IF NOT GenJnlLine.FINDFIRST THEN
               ERROR(Err002);
           END;
        
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE("Journal Template Name",CodDiario);
        GenJnlLine.SETRANGE("Journal Batch Name",SeccDiario);
        GenJnlLine.FINDSET;
        REPEAT
          IF FirstTime THEN
             BEGIN
              FirstTime := FALSE;
              BancoAnt := GenJnlLine."Bal. Account No.";
             END;
             IF BancoAnt <> GenJnlLine."Bal. Account No." THEN
                ERROR(Err001);
        UNTIL GenJnlLine.NEXT = 0;
        
        
        FirstTime := TRUE;
        
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE("Journal Template Name",CodDiario);
        GenJnlLine.SETRANGE("Journal Batch Name",SeccDiario);
        GenJnlLine.SETRANGE("Account Type",GenJnlLine."Account Type"::"G/L Account");
        CounterTotal := GenJnlLine.COUNT;
        Window.OPEN(Text001);
        GenJnlLine.FINDSET;
        REPEAT
          Counter := Counter + 1;
          Window.UPDATE(1,GenJnlLine."Line No.");
          Window.UPDATE(2,ROUND(Counter / CounterTotal * 10000,1));
        
          IF FirstTime THEN
             BEGIN
              FirstTime := FALSE;
              recDimEntry.RESET;
              recDimEntry.SETRANGE("Dimension Set ID", GenJnlLine."Dimension Set ID");
              recDimEntry.SETRANGE("Dimension Code",ConfNomina."Dimension Empleado");
              recDimEntry.FINDFIRST;
        
        
              Empl.GET(recDimEntry."Dimension Value Code"); //Busco el empleado
              Empl.TESTFIELD(Company);
              EC.GET(Empl.Company);
        
              ConfNomina."Secuencia de archivo Batch" := INCSTR(ConfNomina."Secuencia de archivo Batch");
              ConfNomina.MODIFY;
              IF COPYSTR(ConfNomina."Path Archivos Electronicos",STRLEN(ConfNomina."Path Archivos Electronicos"),1) <> '\' THEN
                 ConfNomina."Path Archivos Electronicos" += '\';
        
              Archivo.TEXTMODE(TRUE);
              NombreArchivo  := 'c:\temp\' + 'NCR' +
                                FORMAT(WORKDATE,0,'<Year4>') + FORMAT(WORKDATE,0,'<Month,2>') +
                                FORMAT(WORKDATE,0,'<Day,2>') + EC."Identificador Empresa" + '_01.txt';
              NombreArchivo2 := ConfNomina."Path Archivos Electronicos" + 'NCR' +
                                FORMAT(WORKDATE,0,'<Year4>') + FORMAT(WORKDATE,0,'<Month,2>') +
                                FORMAT(WORKDATE,0,'<Day,2>') + EC."Identificador Empresa" + '_01.txt';
              {
              Archivo.CREATE(ConfNomina."Path Archivos Electronicos" + 'NCR' +
                             FORMAT(WORKDATE,0,'<Year4>') + FORMAT(WORKDATE,0,'<Month,2>') +
                             FORMAT(WORKDATE,0,'<Day,2>') + EC."Identificador Empresa" + '_01.txt');
              }
              Archivo.CREATE(NombreArchivo);
              Archivo.TRUNC;
             END;
        
          recDimEntry.RESET;
          recDimEntry.SETRANGE("Dimension Set ID", GenJnlLine."Dimension Set ID");
          recDimEntry.SETRANGE("Dimension Code",ConfNomina."Dimension Empleado");
          recDimEntry.FINDFIRST;
        
          Empl.GET(recDimEntry."Dimension Value Code"); //Busco el empleado
        
        
          DIPG.RESET;
          DIPG.SETRANGE("No. empleado",Empl."No.");
          DIPG.FINDFIRST;
          CLEAR(Lin_Body);
          CASE DIPG."Tipo Cuenta" OF
            0:
             Lin_Body := 'A'
          ELSE
             Lin_Body := 'C';
          END;
        
          BcoACH.GET(DIPG."Cod. Banco");
          IF EC.Banco = DIPG."Cod. Banco" THEN
             BEGIN
              CERO := PADSTR(CERO,10-STRLEN(DIPG."Numero Cuenta"),'0');
              Lin_Body += CERO + FORMAT(DIPG."Numero Cuenta");
              Lin_Body += FORMAT(ROUND((GenJnlLine.Amount),0.01)*100,15,'<integer,15><Filler Character,0>');
              Lin_Body += 'XXY01';
              Lin_Body += FORMAT(Blanco,38);
             END
          ELSE
             BEGIN
              CERO := PADSTR(CERO,10,'0');
              Lin_Body += CERO;
              Lin_Body += FORMAT(ROUND((GenJnlLine.Amount),0.01)*100,15,'<integer,15><Filler Character,0>');
              Lin_Body += 'XXY01';
        
              Lin_Body += BcoACH."Cod. Institucion Financiera";
              CERO := PADSTR(CERO,18-STRLEN(DIPG."Numero Cuenta"),'0');
              Lin_Body += CERO + FORMAT(DIPG."Numero Cuenta");
              Lin_Body += COPYSTR(Empl."Full Name",1,18);
             END;
        
          Lin_Body += EC."Identificador Empresa";
        
          Lin_Body += FORMAT(Empl."E-Mail",30);
          CERO := PADSTR(CERO,10,'0');
          Lin_Body += FORMAT(CERO,10); //Informacion del Celular
        
          Lin_Body += FORMAT(Blanco,3);  //Banco Destino para el pago interbancario
          CASE Empl."Document Type" OF
           0: //Cedula
            BEGIN
             Lin_Body += 'C';
             Lin_Body += FORMAT(Empl."Document ID",13);
            END;
           1: //Pasaporte
            BEGIN
             Lin_Body += 'P';
             Lin_Body += FORMAT(Empl."Document ID",13);
            END;
           ELSE
            BEGIN
             Lin_Body += 'R';
             Lin_Body += FORMAT(Empl."Document ID",13);
            END;
          END;
          //TODO: Ver Archivo.WRITE(Lin_Body);
        UNTIL GenJnlLine.NEXT = 0;
        Window.CLOSE;
        Archivo.CLOSE;
        
        RenameFile;
        */

    end;

    procedure FormatoPagoProveedores(CodDiario: Code[20]; SeccDiario: Code[20])
    var
        Err001: Label 'The bank account must be the same in all the lines, please correct it';
        GenJnlLine: Record 81;
        VendorBank: Record 288;
        BcoACH: Record 34002167;
        Vendor: Record 23;
        //TODO: Ver ExportPaymentsACH: Codeunit 10090;
        //TODO: Ver ExportPaymentsRB: Codeunit 10091;
        FirstTime: Boolean;
        FirstTime2: Boolean;
        BancoAnt: Code[20];
        TAB: Char;
        TextMes: Code[3];
        NoLin: Integer;
        CodBco: Code[20];
        ExportAmount: Decimal;
        TraceNumber: Code[30];
        SettleDate: Date;
        Lin_Detail: Text[1024];
        Seq: Integer;
    begin
        //Verifico que todas las lineas del diario tengan el mismo banco
        FirstTime := TRUE;
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE("Journal Template Name", CodDiario);
        GenJnlLine.SETRANGE("Journal Batch Name", SeccDiario);
        GenJnlLine.SETRANGE("Check Printed", FALSE);
        GenJnlLine.SETRANGE("Check Exported", FALSE);
        GenJnlLine.FINDSET;
        REPEAT
            IF FirstTime THEN BEGIN
                FirstTime := FALSE;
                BancoAnt := GenJnlLine."Bal. Account No.";
                BankAccount.GET(BancoAnt);
            END;
            IF BancoAnt <> GenJnlLine."Bal. Account No." THEN
                ERROR(Err001);
        UNTIL GenJnlLine.NEXT = 0;

        BankAccount.TESTFIELD(Formato);
        //TODO: Ver BankAccount.TESTFIELD("E-Pay Export File Path");
        //MESSAGE('%1',BankAccount.Formato);

        BankAccount.Formato := UPPERCASE(BankAccount.Formato);
        CASE UPPERCASE(BankAccount.Formato) OF
            'BPD', 'POPULAR':
                FormatoBPD(CodDiario, SeccDiario);
            'BHD':
                FormatoBHD(CodDiario, SeccDiario);
            'SCA', 'SCOTIA', 'SCOTIABANK':
                FormatoSCA(CodDiario, SeccDiario);
            'RES', 'RESERVA', 'RESERVAS':
                FormatoRES(CodDiario, SeccDiario);
        END;
    end;

    procedure InsertIntoCheckLedger(Trace: Code[30]; Amt: Decimal; GenJnlLine: Record 81)
    var
        CheckLedgerEntry: Record 272;
        CheckManagement: Codeunit 367;
    begin
        WITH CheckLedgerEntry DO BEGIN
            INIT;
            "Bank Account No." := BankAccount."No.";
            "Posting Date" := GenJnlLine."Posting Date";
            "Document Type" := GenJnlLine."Document Type";
            "Document No." := GenJnlLine."Document No.";
            Description := GenJnlLine.Description;
            Beneficiario := GenJnlLine.Beneficiario; //GRN Para guardar info beneficiario
            "Bank Payment Type" := "Bank Payment Type"::"Electronic Payment";
            "Entry Status" := "Entry Status"::Exported;
            "Check Date" := GenJnlLine."Posting Date";
            "Check No." := GenJnlLine."Document No.";
            /*
            IF BankAccountIs = BankAccountIs::Acnt THEN BEGIN
              "Bal. Account Type" := genjnlline."Bal. Account Type";
              "Bal. Account No." := genjnlline."Bal. Account No.";
            END ELSE
            */
            BEGIN
                "Bal. Account Type" := GenJnlLine."Account Type";
                "Bal. Account No." := GenJnlLine."Account No.";
            END;
            //TODO: Ver "Trace No." := Trace;
            //TODO: Ver "Transmission File Name" := GenJnlLine."Export File Name";
            Amount := Amt;
            CheckManagement.InsertCheck(CheckLedgerEntry, RECORDID);
        END;

    end;

    procedure EnviaMailPagos(CodDiario: Code[20]; SeccDiario: Code[20])
    var
        //TODO: Ver Mail: Codeunit 400;
        GenJnlLine: Record 81;
        VendorBank: Record 288;
        Vendor: Record 23;
        UserSetup: Record 91;
        ConfEmpresa: Record 34002100;
        FirstTime: Boolean;
        BancoAnt: Code[20];
        CuerpoMail: Text[1024];
        CodBco: Code[20];
        Subject: Text[150];
        Err001: Label 'The bank account must be the same in all the lines, please correct it';
        Err002: Label 'User %1 is not defined in the Database';
        Filtro: Text[30];
        User: Record 2000000120;
    begin
        /*GRN 22/04/2013 lo voy a sustituir por un sistema de correo abierto
         No el de NAVISION porque da error en algunos servidores
        
        //Verifico que todas las lineas del diario tengan el mismo banco
        FirstTime := TRUE;
        Subject := 'CONFIRMACION DE PAGO';
        
        Filtro := '*' + USERID + '*';
        UserSetupW.RESET;
        UserSetupW.SETFILTER(ID,Filtro);
        //MESSAGE('%1',UserSetupW.GETFILTERS);
        IF NOT UserSetupW.FINDFIRST THEN
           IF NOT UserSetupD.GET(USERID) THEN
              ERROR(Err002,USERID);
        
        IF NOT UserSetup.GET(USERID) THEN
           ERROR(Err002,USERID);
        
        UserSetup.TESTFIELD("E-Mail");
        
        EC.FINDFIRST;
        ConfNomina.GET();
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE("Journal Template Name",CodDiario);
        GenJnlLine.SETRANGE("Journal Batch Name",SeccDiario);
        GenJnlLine.FINDSET;
        REPEAT
          IF FirstTime THEN
             BEGIN
              FirstTime := FALSE;
              BancoAnt := GenJnlLine."Bal. Account No.";
             END;
             IF BancoAnt <> GenJnlLine."Bal. Account No." THEN
                ERROR(Err001);
        UNTIL GenJnlLine.NEXT = 0;
        
        FirstTime := TRUE;
        
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE("Journal Template Name",CodDiario);
        GenJnlLine.SETRANGE("Journal Batch Name",SeccDiario);
        CounterTotal := GenJnlLine.COUNT;
        Window.OPEN(Text001);
        GenJnlLine.FINDSET;
        REPEAT
          Counter := Counter + 1;
          Window.UPDATE(1,GenJnlLine."Line No.");
          Window.UPDATE(2,ROUND(Counter / CounterTotal * 10000,1));
        
        //  IF FirstTime THEN
        //     BEGIN
        //      FirstTime := FALSE;
              IF GenJnlLine."Account Type" = GenJnlLine."Account Type"::Vendor THEN
                 BEGIN
                  BankAccount.GET(GenJnlLine."Bal. Account No.");
                  BankAccount.TESTFIELD("E-Pay Export File Path");
                 END
              ELSE
              IF GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Vendor THEN
                 BEGIN
                  BankAccount.GET(GenJnlLine."Account No.");
                  BankAccount.TESTFIELD("E-Pay Export File Path");
                 END;
        
              IF GenJnlLine."Account Type" = GenJnlLine."Account Type"::Vendor THEN
                 BEGIN
                  Vendor.GET(GenJnlLine."Account No.");
                  BankAccount.GET(GenJnlLine."Bal. Account No.");
                  VendorBank.RESET;
                  VendorBank.SETRANGE("Vendor No.",GenJnlLine."Account No.");
                  CodBco := GenJnlLine."Bal. Account No.";
                 END
              ELSE
              IF GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Vendor THEN
                 BEGIN
                  Vendor.GET(GenJnlLine."Bal. Account No.");
                  BankAccount.GET(GenJnlLine."Account No.");
                  VendorBank.RESET;
                  VendorBank.SETRANGE("Vendor No.",GenJnlLine."Bal. Account No.");
                  CodBco := GenJnlLine."Account No.";
                 END;
        //     END;
              VendorBank.FINDFIRST;
              VendorBank.TESTFIELD("Bank Account No.");
              VendorBank.TESTFIELD("Banco Receptor");
        
              CuerpoMail := 'Estimado Colaborador:';
              Mail.CreateMessage(UserSetupW.Name,UserSetup."E-Mail",Vendor."E-Mail",Subject,'',TRUE);
              Mail.AppendBody(CuerpoMail + '<br>');
              CLEAR(CuerpoMail);
              Mail.AppendBody(CuerpoMail + '<br>');
              Mail.AppendBody(CuerpoMail + '<br>');
              CuerpoMail := 'El Grupo Editorial Santillana, tiene el agrado de informarle que ha sido generada una Orden de ';
              CuerpoMail += 'Pago a su favor en su Cuenta ';
              CASE VendorBank."Tipo Cuenta" OF
                 0:
                  CuerpoMail += 'CTE No. ';
                 1:
                  CuerpoMail += 'AHO No. ';
              END;
        
              CuerpoMail += VendorBank."Bank Account No.";
              CuerpoMail += ' constando como Beneficiario: ';
              CuerpoMail += GenJnlLine.Beneficiario + '.';
              Mail.AppendBody(CuerpoMail + '<br>');
              CLEAR(CuerpoMail);
              Mail.AppendBody(CuerpoMail + '<br>');
        
              CuerpoMail := 'Por un valor de $' + FORMAT(ABS(GenJnlLine.Amount)) + '.';
              Mail.AppendBody(CuerpoMail + '<br>');
        
              CuerpoMail := 'Facturas canceladas:';
              Mail.AppendBody(CuerpoMail + '<br>');
        
              //Detalle de las facturas que se pagan
              VLE.RESET;
              VLE.SETCURRENTKEY("Vendor No.",Open,Positive,"Due Date","Currency Code");
              IF GenJnlLine."Account Type" = GenJnlLine."Account Type"::Vendor THEN
                 BEGIN
                  VLE.SETRANGE("Vendor No.",GenJnlLine."Account No.");
                  Vendor.GET(GenJnlLine."Account No.");
                 END
              ELSE
                 BEGIN
                  VLE.SETRANGE("Vendor No.",GenJnlLine."Bal. Account No.");
                  Vendor.GET(GenJnlLine."Bal. Account No.");
                 END;
        
              VLE.SETRANGE(Open,TRUE);
              VLE.SETRANGE(Positive,FALSE);
              VLE.SETRANGE("Applies-to ID",GenJnlLine."Applies-to ID");
              IF VLE.FINDSET THEN
                 REPEAT
                  CuerpoMail := VLE."Document No." + ', ';
                  Mail.AppendBody(CuerpoMail);
                 UNTIL VLE.NEXT =0;
              CLEAR(CuerpoMail);
              Mail.AppendBody(CuerpoMail + '<br>' + '<br>');
        
        
              CuerpoMail += 'También le recordamos que sus comprobantes de Retencion pueden ser retirados en nuestras ';
              CuerpoMail += 'oficinas de lunes a viernes de 9:00 a 18:00, solo con presentar la copia del RUC para empresas y  ';
              CuerpoMail += 'la Cédula de Ciudadania para personas naturales.';
              Mail.AppendBody(CuerpoMail);
              CLEAR(CuerpoMail);
              Mail.AppendBody(CuerpoMail + '<br>' + '<br>');
        
        
              CuerpoMail += 'Agradecemos de antemano por su atencion y colaboracion. ';
              Mail.AppendBody(CuerpoMail + '<br>');
              CLEAR(CuerpoMail);
              Mail.AppendBody(CuerpoMail + '<br>' + '<br>');
        
              CuerpoMail := 'Atentamente';
              Mail.AppendBody(CuerpoMail + '<br>');
        
        
              CuerpoMail := 'Grupo Santillana ';
              Mail.AppendBody(CuerpoMail + '<br>');
        
              CuerpoMail := 'TESORERIA ';
              Mail.AppendBody(CuerpoMail + '<br>');
        
              Mail.Send();
              CLEAR(Mail);
        UNTIL GenJnlLine.NEXT = 0;
        Window.CLOSE;
        */

    end;

    procedure RenameFile()
    var
        FileManagement: Codeunit 419;
    begin
        //TODO: Ver FileManagement.DownloadToFile(NombreArchivo, NombreArchivo2);
    end;

    local procedure FormatoBPD(CodDiario: Code[20]; SeccDiario: Code[20])
    var
        GenJnlLine2: Record 81;
        RNC: Text[30];
        Blanco: Text[60];
        Cero: Text[1];
        FechaTrans: Date;
        Mes: Integer;
        Secuencia: Code[10];
        CodBco: Code[20];
        Total: Decimal;
        Contador: Integer;
    begin
        CompanyInfo.GET();
        ConfContab.GET();
        CompanyInfo.TESTFIELD("VAT Registration No.");
        RNC := DELCHR(CompanyInfo."VAT Registration No.", '=', '-');

        Blanco := ' ';
        Cero := '0';
        PrimeraVez := TRUE;
        TotalGeneral := 0;
        BankAccount.TESTFIELD("Identificador Empresa");

        //TODO: Ver IF COPYSTR(BankAccount."E-Pay Export File Path", STRLEN(BankAccount."E-Pay Export File Path"), 1) <> '\' THEN
        //TODO: Ver     BankAccount."E-Pay Export File Path" += '\';

        //Leemos el Diario
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE("Journal Template Name", CodDiario);
        GenJnlLine.SETRANGE("Journal Batch Name", SeccDiario);
        GenJnlLine.SETRANGE("Check Printed", FALSE);
        GenJnlLine.SETRANGE("Check Exported", FALSE);
        GenJnlLine.SETRANGE("Document Type", GenJnlLine."Document Type"::Payment);
        GenJnlLine.SETRANGE("Bank Payment Type", GenJnlLine."Bank Payment Type"::"Electronic Payment");
        GenJnlLine.SETFILTER(Amount, '<>%1', 0);
        GenJnlLine.FINDFIRST;

        IF GenJnlLine."Posting Date" < TODAY THEN
            ERROR(Err003);
        FechaTrans := GenJnlLine."Posting Date";
        //TODO: Ver PathENV := TEMPORARYPATH;

        NombreArchivo := 'PE' + BankAccount."Identificador Empresa" + '01' + FORMAT(FechaTrans, 0, '<Month,2>') + FORMAT(FechaTrans, 0, '<Day,2>');

        Mes := DATE2DMY(FechaTrans, 2);
        Mes := Mes * 2;

        IF BankAccount.Secuencia = '' THEN BEGIN
            IF Mes < 10 THEN
                Secuencia := '000000' + FORMAT(Mes)
            ELSE
                Secuencia := '00000' + FORMAT(Mes);

            BankAccount.Secuencia := INCSTR(BankAccount.Secuencia);
            BankAccount.MODIFY;
        END
        ELSE BEGIN
            BankAccount.Secuencia := INCSTR(BankAccount.Secuencia);
            BankAccount.MODIFY;
            Secuencia := BankAccount.Secuencia;
        END;
        NombreArchivo += Secuencia + 'E.txt';
        NombreArchivo2 := NombreArchivo;
        SecuenciaTrans := '0000000';

        //TODO: Ver Archivo.TEXTMODE(TRUE);
        //TODO: Ver Archivo.CREATE(PathENV + NombreArchivo);
        //TODO: Ver Archivo.TRUNC;

        //Leemos el Diario
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE("Journal Template Name", CodDiario);
        GenJnlLine.SETRANGE("Journal Batch Name", SeccDiario);
        GenJnlLine.SETRANGE("Check Printed", FALSE);
        GenJnlLine.SETRANGE("Check Exported", FALSE);
        GenJnlLine.SETRANGE("Document Type", GenJnlLine."Document Type"::Payment);
        GenJnlLine.SETRANGE("Bank Payment Type", GenJnlLine."Bank Payment Type"::"Electronic Payment");
        GenJnlLine.SETFILTER(Amount, '<>%1', 0);
        GenJnlLine.FINDSET;
        CounterTotal := GenJnlLine.COUNT;
        Window.OPEN(Text001);

        REPEAT
            Counter := Counter + 1;
            Window.UPDATE(1, GenJnlLine."Account No.");
            Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));
            IF PrimeraVez THEN BEGIN
                PrimeraVez := FALSE;
                //Creo la cabecera
                GenJnlLine2.RESET;
                GenJnlLine2.COPYFILTERS(GenJnlLine);
                GenJnlLine2.SETRANGE("Check Printed", FALSE);
                GenJnlLine2.SETRANGE("Check Exported", FALSE);
                GenJnlLine2.FINDSET;
                REPEAT
                    TotalGeneral += ROUND(GenJnlLine2.Amount, 0.01);
                UNTIL GenJnlLine2.NEXT = 0;

                Lin_Body := 'H';
                Lin_Body += FORMAT(RNC, 15);
                Lin_Body += FORMAT(CompanyInfo.Name, 35);
                Lin_Body += Secuencia + '02';
                Lin_Body += FORMAT(FechaTrans, 0, '<Year4><Month,2><Day,2>');
                Lin_Body += '000000000000000000000000';
                Lin_Body += FORMAT(CounterTotal, 11, '<Integer,11><Filler Character,0>');
                Lin_Body += FORMAT(TotalGeneral * 100, 13, '<integer,13><Filler Character,0>');
                Lin_Body += '000000000000000';
                Lin_Body += FORMAT(TODAY, 0, '<Year4><Month,2><Day,2>');
                Lin_Body += FORMAT(TIME, 4, '<hours24,2><Minutes,2>');
                Lin_Body += FORMAT(CompanyInfo."E-Mail", 40);
                Lin_Body += FORMAT(Blanco, 136);
                //TODO: Ver Archivo.WRITE(Lin_Body);
            END;

            //Creo el detalle
            CLEAR(Vendor);
            SecuenciaTrans := INCSTR(SecuenciaTrans);
            CLEAR(Lin_Body);
            Lin_Body := 'N';
            Lin_Body += FORMAT(RNC, 15);
            Lin_Body += FORMAT(Secuencia, 7);
            Lin_Body += FORMAT(SecuenciaTrans, 7);


            IF GenJnlLine."Account Type" = GenJnlLine."Account Type"::Vendor THEN BEGIN
                Vendor.GET(GenJnlLine."Account No.");
                BankAccount.GET(GenJnlLine."Bal. Account No.");
                VendorBank.RESET;
                VendorBank.SETRANGE("Vendor No.", GenJnlLine."Account No.");
                VendorBank.SETRANGE(Code, GenJnlLine."Recipient Bank Account");
                CodBco := GenJnlLine."Bal. Account No.";
                VendorBank.FINDFIRST;
                VendorBank.TESTFIELD("Bank Account No.");
                //TODO: Ver VendorBank.TESTFIELD("Banco RED ACH");
                //TODO: Ver BcoACH.GET(VendorBank."Banco RED ACH");
                //BcoACH.TESTFIELD("Ruta y Transito");
            END
            ELSE
                IF GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Vendor THEN BEGIN
                    Vendor.GET(GenJnlLine."Bal. Account No.");
                    BankAccount.GET(GenJnlLine."Account No.");
                    VendorBank.RESET;
                    VendorBank.SETRANGE("Vendor No.", GenJnlLine."Bal. Account No.");
                    VendorBank.SETRANGE(Code, GenJnlLine."Recipient Bank Account");
                    CodBco := GenJnlLine."Account No.";
                    VendorBank.FINDFIRST;
                    VendorBank.TESTFIELD("Bank Account No.");
                    //TODO: Ver VendorBank.TESTFIELD("Banco RED ACH");
                    //TODO: Ver BcoACH.GET(VendorBank."Banco RED ACH");
                    //BcoACH.TESTFIELD("Ruta y Transito");
                END;

            BankAccount."Bank Account No." := DELCHR(BankAccount."Bank Account No.", '=', '-/., ');

            //tipo cuenta ==> 0= ahorro, 1= Corriente, 2 = cheque
            IF (GenJnlLine."Account Type" = GenJnlLine."Account Type"::"Bank Account") AND  // Para cuando es transferencias entre bancos
               (GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::"Bank Account") THEN BEGIN
                BankAccount2.GET(GenJnlLine."Account No.");
                BankAccount2.TESTFIELD("Bank Account No.");
                //BankAccount2.TESTFIELD("Bank Code");
                BankAccount2."Bank Account No." := DELCHR(BankAccount2."Bank Account No.", '=', '-/., ');

                Lin_Body += FORMAT(BankAccount2."Bank Account No.") + FORMAT(Blanco, 20 - STRLEN(BankAccount2."Bank Account No."));
                Lin_Body += '1';
                IF STRPOS(ConfContab."LCY Code", 'US') <> 0 THEN BEGIN
                    IF STRPOS(GenJnlLine."Currency Code", 'DO') <> 0 THEN
                        Lin_Body += '214'
                    ELSE
                        IF STRPOS(GenJnlLine."Currency Code", 'EU') <> 0 THEN
                            Lin_Body += '978'
                        ELSE
                            Lin_Body += '840'; //Moneda 214=RD$, 840=USD, 978=Euro
                END
                ELSE
                    IF STRPOS(ConfContab."LCY Code", 'DO') <> 0 THEN BEGIN
                        IF STRPOS(GenJnlLine."Currency Code", 'US') <> 0 THEN
                            Lin_Body += '840'
                        ELSE
                            IF STRPOS(GenJnlLine."Currency Code", 'EU') <> 0 THEN
                                Lin_Body += '978'
                            ELSE
                                Lin_Body += '214'; //Moneda 214=RD$, 840=USD, 978=Euro
                    END;

                Lin_Body += BankAccount2."SWIFT Code";//Aqui debe tener el Identificador del banco + codigo ACH + Digito de chequeo
                Vendor."E-Mail" := BankAccount2."E-Mail";

                IF BankAccount2."Tipo Cuenta" = 0 THEN //Corriente
                    Lin_Body += '22'
                ELSE
                    IF BankAccount2."Tipo Cuenta" = 1 THEN //Ahorro
                        Lin_Body += '32'
                    ELSE
                        Lin_Body += '52'; //Tarjeta o Prestamo
            END
            ELSE BEGIN
                IF (VendorBank."Bank Account No." <> '') AND (VendorBank."Tipo Cuenta" <> 2) THEN
                    Lin_Body += FORMAT(VendorBank."Bank Account No.") + FORMAT(Blanco, 20 - STRLEN(VendorBank."Bank Account No."))
                ELSE
                    IF VendorBank."Tipo Cuenta" <> 2 THEN
                        ERROR(Err002, GenJnlLine."Account No." + ', ' + GenJnlLine.Beneficiario)
                    ELSE
                        IF VendorBank."Tipo Cuenta" = 2 THEN
                            Lin_Body += FORMAT(Blanco, 20);

                IF VendorBank."Tipo Cuenta" = 0 THEN //Corriente
                    Lin_Body += '1'
                ELSE
                    IF VendorBank."Tipo Cuenta" = 1 THEN //Ahorro
                        Lin_Body += '2'
                    ELSE
                        Lin_Body += '5';

                IF STRPOS(ConfContab."LCY Code", 'US') <> 0 THEN BEGIN
                    IF STRPOS(GenJnlLine."Currency Code", 'DO') <> 0 THEN
                        Lin_Body += '214'
                    ELSE
                        IF STRPOS(GenJnlLine."Currency Code", 'EU') <> 0 THEN
                            Lin_Body += '978'
                        ELSE
                            Lin_Body += '840'; //Moneda 214=RD$, 840=USD, 978=Euro

                    //TODO: Ver BcoACH.GET(VendorBank."Banco RED ACH");
                    IF (STRPOS(GenJnlLine."Currency Code", 'DO') = 0) AND (BcoACH."Cod. Institucion Financiera" <> 'BPD') THEN BEGIN
                        Lin_Body += '8' + COPYSTR(BcoACH."ACH Reservas", 2, 10);
                        Lin_Body += 'L';
                    END
                    ELSE BEGIN
                        Lin_Body += BcoACH."ACH Reservas";
                        Lin_Body += FORMAT(BcoACH."Digito Chequeo");
                    END;
                END
                ELSE
                    IF STRPOS(ConfContab."LCY Code", 'DO') <> 0 THEN BEGIN
                        IF STRPOS(GenJnlLine."Currency Code", 'US') <> 0 THEN
                            Lin_Body += '840'
                        ELSE
                            IF STRPOS(GenJnlLine."Currency Code", 'EU') <> 0 THEN
                                Lin_Body += '978'
                            ELSE
                                Lin_Body += '214'; //Moneda 214=RD$, 840=USD, 978=Euro

                        //TODO: Ver BcoACH.GET(VendorBank."Banco RED ACH");
                        IF (GenJnlLine."Currency Code" = '') OR (BcoACH."Cod. Institucion Financiera" = 'BPD') THEN BEGIN
                            Lin_Body += BcoACH."ACH Reservas";
                            Lin_Body += FORMAT(BcoACH."Digito Chequeo");
                        END
                        ELSE BEGIN
                            Lin_Body += '8' + COPYSTR(BcoACH."ACH Reservas", 2, 10);
                            Lin_Body += 'L';
                        END;
                    END;

                IF VendorBank."Tipo Cuenta" = 0 THEN //Corriente
                    Lin_Body += '22'
                ELSE
                    IF VendorBank."Tipo Cuenta" = 1 THEN //Ahorro
                        Lin_Body += '32'
                    ELSE
                        Lin_Body += '12';
            END;

            Lin_Body += FORMAT(GenJnlLine.Amount * 100, 13, '<integer,13><Filler Character,0>');

            //GRN Se cambia por tipo doc y numero Lin_Body += FORMAT(Blanco,17,'<Text,17>');
            Vendor."VAT Registration No." := DELCHR(Vendor."VAT Registration No.", '=', '-');
            IF STRLEN(Vendor."VAT Registration No.") > 9 THEN
                Lin_Body += 'CE'
            ELSE
                Lin_Body += 'RN';

            Lin_Body += PADSTR(Blanco, 15 - STRLEN(Vendor."VAT Registration No.")) + Vendor."VAT Registration No.";
            Lin_Body += FORMAT(COPYSTR(GenJnlLine.Beneficiario, 1, 35), 35);
            Lin_Body += FORMAT(FechaTrans, 12, '<Year4><Month,2><Day,2><Filler Character,0>');
            IF STRPOS(CompanyInfo.Name, ',') <> 0 THEN
                Lin_Body += FORMAT(COPYSTR(COPYSTR(CompanyInfo.Name, 1, STRPOS(CompanyInfo.Name, ',') - 1) + '-' + GenJnlLine.Description, 1, 40), 40)
            ELSE
                Lin_Body += FORMAT(COPYSTR(CompanyInfo.Name, 1, 40), 40);
            Lin_Body += FORMAT(Blanco, 4);
            IF Vendor."E-Mail" <> '' THEN
                Lin_Body += '1'
            ELSE
                Lin_Body += ' ';

            IF STRLEN(Vendor."E-Mail") <= 40 THEN
                Lin_Body += FORMAT(Vendor."E-Mail", 40);

            Lin_Body += FORMAT(Blanco, 12);
            Lin_Body += '00';

            Lin_Body += FORMAT(Blanco, 78);
            //TODO: Ver Archivo.WRITE(Lin_Body);

            Contador := Contador + 1;
            /*GRN

                CASE BankAccount."Export Format" OF
                  BankAccount."Export Format"::US:
                    TraceNumber := ExportPaymentsACH.ExportElectronicPayment(GenJnlLine,ExportAmount);
                  BankAccount."Export Format"::CA:
                    TraceNumber := ExportPaymentsRB.ExportElectronicPayment(GenJnlLine,ExportAmount,SettleDate);
                  BankAccount."Export Format"::MX:
                    TraceNumber := ExportPaymentsCecoban.ExportElectronicPayment(GenJnlLine,ExportAmount,SettleDate);
                END;
            */
            Tracenumber := FORMAT(CURRENTDATETIME);
            Tracenumber := DELCHR(Tracenumber, '=', '._-:');
            ExportAmount := GenJnlLine.Amount;
            GenJnlLine."Check Printed" := TRUE;
            GenJnlLine."Check Exported" := TRUE;
            GenJnlLine."Check Transmitted" := TRUE;

            //TODO: Ver GenJnlLine."Export File Name" := NombreArchivo2;
            //TODO: Ver BankAccount.TESTFIELD("Last Remittance Advice No.");
            //TODO: Ver GenJnlLine."Document No." := INCSTR(BankAccount."Last Remittance Advice No.");

            //TODO: Ver BankAccount."Last Remittance Advice No." := INCSTR(BankAccount."Last Remittance Advice No.");
            //TODO: Ver BankAccount."Last E-Pay Export File Name" := NombreArchivo;
            BankAccount.MODIFY;


            GenJnlLine."Exported to Payment File" := TRUE;
            InsertIntoCheckLedger(Tracenumber, -ExportAmount, GenJnlLine);
            GenJnlLine.MODIFY;

        UNTIL GenJnlLine.NEXT = 0;
        Window.CLOSE;
        //TODO: Ver Archivo.CLOSE;

        //TODO: Ver NombreArchivo := TEMPORARYPATH + NombreArchivo;
        //TODO: Ver NombreArchivo2 := BankAccount."E-Pay Export File Path" + NombreArchivo2;
        //MESSAGE('%1\ %2',NOMBREARCHIVO,NOMBREARCHIVO2);
        RenameFile;

    end;

    local procedure FormatoBHD(CodDiario: Code[20]; SeccDiario: Code[20])
    var
        Empresa: Record 79;
        GenJnlLine2: Record 81;
        Secuencia: Text;
        CodBco: Code[20];
        RNC: Code[20];
    begin
        //BHD
        CompanyInfo.GET();
        CompanyInfo.TESTFIELD("VAT Registration No.");
        RNC := DELCHR(CompanyInfo."VAT Registration No.", '=', '-');

        Blanco := ' ';
        CERO := '0';
        TotalGeneral := 0;
        PrimeraVez := TRUE;
        BankAccount.TESTFIELD("Identificador Empresa");

        //TODO: Ver IF COPYSTR(BankAccount."E-Pay Export File Path", STRLEN(BankAccount."E-Pay Export File Path"), 1) <> '\' THEN
        //TODO: Ver     BankAccount."E-Pay Export File Path" += '\';

        //Leemos el Diario
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE("Journal Template Name", CodDiario);
        GenJnlLine.SETRANGE("Journal Batch Name", SeccDiario);
        GenJnlLine.SETRANGE("Check Printed", FALSE);
        GenJnlLine.SETRANGE("Check Exported", FALSE);
        GenJnlLine.SETRANGE("Document Type", GenJnlLine."Document Type"::Payment);
        GenJnlLine.SETRANGE("Bank Payment Type", GenJnlLine."Bank Payment Type"::"Electronic Payment");
        GenJnlLine.SETFILTER(Amount, '<>%1', 0);
        GenJnlLine.FINDFIRST;

        //TODO: Ver PathENV := TEMPORARYPATH;

        NombreArchivo := 'PE-BHD-' + BankAccount."Identificador Empresa" + '-' + FORMAT(WORKDATE, 0, '<Month,2>') + FORMAT(WORKDATE, 0, '<Day,2>');

        IF BankAccount.Secuencia = '' THEN BEGIN
            Secuencia := 'HHH0000000';

            BankAccount.Secuencia := INCSTR(BankAccount.Secuencia);
            BankAccount.MODIFY;
        END;

        SecuenciaTrans := BankAccount.Secuencia;
        NombreArchivo += Secuencia + '.txt';
        NombreArchivo2 := NombreArchivo;

        //TODO: Ver Archivo.TEXTMODE(TRUE);
        //TODO: Ver Archivo.CREATE(PathENV + NombreArchivo);
        //TODO: Ver Archivo.TRUNC;

        //Leemos el Diario
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE("Journal Template Name", CodDiario);
        GenJnlLine.SETRANGE("Journal Batch Name", SeccDiario);
        GenJnlLine.SETRANGE("Check Printed", FALSE);
        GenJnlLine.SETRANGE("Check Exported", FALSE);
        GenJnlLine.SETRANGE("Document Type", GenJnlLine."Document Type"::Payment);
        GenJnlLine.SETRANGE("Bank Payment Type", GenJnlLine."Bank Payment Type"::"Electronic Payment");
        GenJnlLine.SETFILTER(Amount, '<>%1', 0);
        GenJnlLine.FINDSET;
        CounterTotal := GenJnlLine.COUNT;
        Window.OPEN(Text001);
        REPEAT
            Counter := Counter + 1;
            Window.UPDATE(1, GenJnlLine."Account No.");
            Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

            IF GenJnlLine."Posting Date" < WORKDATE THEN
                ERROR(Err003);

            //Creo el detalle
            CLEAR(Vendor);
            CLEAR(Lin_Body);
            IF PrimeraVez THEN BEGIN
                PrimeraVez := FALSE;
                SecuenciaTrans := 'HHH0000000';
                //Creo la cabecera
                BankAccount."Bank Account No." := DELCHR(BankAccount."Bank Account No.", '=', '-/., ');
                Lin_Body := BankAccount."Bank Account No." + ';'; //Cuenta de la empresa

                GenJnlLine2.RESET;
                GenJnlLine2.COPYFILTERS(GenJnlLine);
                GenJnlLine2.SETRANGE("Check Printed", FALSE);
                GenJnlLine2.SETRANGE("Check Exported", FALSE);
                GenJnlLine2.FINDSET;
                REPEAT
                    TotalGeneral += ROUND(GenJnlLine2.Amount, 0.01);
                UNTIL GenJnlLine2.NEXT = 0;

                Lin_Body := BankAccount."Bank Account No." + ';';
                Lin_Body += 'BHD;';
                Lin_Body += 'CC;';
                Lin_Body += DELCHR(CompanyInfo.Name, '=', ';') + ';';
                Lin_Body += 'D;';
                Lin_Body += FORMAT(TotalGeneral, 0, '<Integer><Decimals,3>') + ';';
                Lin_Body += SecuenciaTrans + ';';
                Lin_Body += 'TRANSFERENCIA ELECTRONICA;';
                //TODO: Ver Archivo.WRITE(Lin_Body);
            END;

            IF GenJnlLine."Account Type" = GenJnlLine."Account Type"::Vendor THEN BEGIN
                Vendor.GET(GenJnlLine."Account No.");
                BankAccount.GET(GenJnlLine."Bal. Account No.");
                VendorBank.RESET;
                VendorBank.SETRANGE("Vendor No.", GenJnlLine."Account No.");
                VendorBank.SETRANGE(Code, GenJnlLine."Recipient Bank Account");
                CodBco := GenJnlLine."Bal. Account No.";
                VendorBank.FINDFIRST;
                VendorBank.TESTFIELD("Bank Account No.");
                //TODO: Ver VendorBank.TESTFIELD("Banco RED ACH");
                //TODO: Ver BcoACH.GET(VendorBank."Banco RED ACH");
                //      BcoACH.TESTFIELD("Ruta y Transito");
            END
            ELSE
                IF GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Vendor THEN BEGIN
                    Vendor.GET(GenJnlLine."Bal. Account No.");
                    BankAccount.GET(GenJnlLine."Account No.");
                    VendorBank.RESET;
                    VendorBank.SETRANGE("Vendor No.", GenJnlLine."Bal. Account No.");
                    VendorBank.SETRANGE(Code, GenJnlLine."Recipient Bank Account");
                    CodBco := GenJnlLine."Account No.";
                    VendorBank.FINDFIRST;
                    VendorBank.TESTFIELD("Bank Account No.");
                    //TODO: Ver VendorBank.TESTFIELD("Banco RED ACH");
                    //TODO: Ver BcoACH.GET(VendorBank."Banco RED ACH");
                    //BcoACH.TESTFIELD("Ruta y Transito");
                END;
            //TODO: Ver BcoACH.GET(VendorBank."Banco RED ACH");

            CLEAR(Lin_Body);
            VendorBank."Bank Account No." := DELCHR(VendorBank."Bank Account No.", '=', '-/., ');
            Lin_Body := VendorBank."Bank Account No." + ';'; //Cuenta del proveedor

            Lin_Body += BcoACH."Cod. Institucion Financiera" + ';'; //Banco y ruta destino
            IF VendorBank."Tipo Cuenta" = 0 THEN //Corriente
                Lin_Body += 'CC'
            ELSE
                IF VendorBank."Tipo Cuenta" = 1 THEN //Ahorro
                    Lin_Body += 'CA'
                ELSE
                    Lin_Body += 'PR';

            GenJnlLine.Beneficiario := DELCHR(GenJnlLine.Beneficiario, '=', ';');
            Lin_Body += ';' + COPYSTR(GenJnlLine.Beneficiario, 1, 22) + ';';
            Lin_Body += 'C;';
            Lin_Body += FORMAT(GenJnlLine.Amount, 0, '<Integer><Decimals,3>') + ';';
            SecuenciaTrans := INCSTR(SecuenciaTrans);
            Lin_Body += SecuenciaTrans + ';';
            GenJnlLine.Description := DELCHR(GenJnlLine.Description, '=', ';');
            Lin_Body += COPYSTR(GenJnlLine.Description, 1, 80) + ';';
            Lin_Body += Vendor."E-Mail";


            //TODO: Ver Archivo.WRITE(Lin_Body);

            Tracenumber := FORMAT(CURRENTDATETIME);
            Tracenumber := DELCHR(Tracenumber, '=', '._-:');
            ExportAmount := GenJnlLine.Amount;
            GenJnlLine."Check Printed" := TRUE;
            GenJnlLine."Check Exported" := TRUE;
            GenJnlLine."Check Transmitted" := TRUE;
            //jpg eliminar hhh a la secuencia para campo "EP Bulk No. Line"

            //TODO: Ver GenJnlLine."Export File Name" := NombreArchivo2;
            //TODO: Ver BankAccount.TESTFIELD("Last Remittance Advice No.");
            //TODO: Ver GenJnlLine."Document No." := INCSTR(BankAccount."Last Remittance Advice No.");

            //TODO: Ver BankAccount."Last Remittance Advice No." := INCSTR(BankAccount."Last Remittance Advice No.");
            //TODO: Ver BankAccount."Last E-Pay Export File Name" := NombreArchivo;
            BankAccount.MODIFY;


            GenJnlLine."Exported to Payment File" := TRUE;
            InsertIntoCheckLedger(Tracenumber, -ExportAmount, GenJnlLine);
            GenJnlLine.MODIFY;
        UNTIL GenJnlLine.NEXT = 0;

        BankAccount.Secuencia := SecuenciaTrans;
        BankAccount.MODIFY;

        Window.CLOSE;
        //TODO: Ver Archivo.CLOSE;

        //TODO: Ver NombreArchivo := TEMPORARYPATH + NombreArchivo;
        //TODO: Ver NombreArchivo2 := BankAccount."E-Pay Export File Path" + NombreArchivo2;
        RenameFile;
        MESSAGE(MSG001);
    end;

    local procedure FormatoRES(CodDiario: Code[20]; SeccDiario: Code[20])
    var
        Empresa: Record 79;
        Secuencia: Text;
        CodBco: Code[20];
        RNC: Code[20];
    begin
        //Reservas

        CompanyInfo.GET();
        CompanyInfo.TESTFIELD("VAT Registration No.");
        RNC := DELCHR(CompanyInfo."VAT Registration No.", '=', '-');

        Blanco := ' ';
        CERO := '0';
        TotalGeneral := 0;
        BankAccount.TESTFIELD("Identificador Empresa");

        //TODO: Ver IF COPYSTR(BankAccount."E-Pay Export File Path", STRLEN(BankAccount."E-Pay Export File Path"), 1) <> '\' THEN
        //TODO: Ver     BankAccount."E-Pay Export File Path" += '\';

        //Leemos el Diario
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE("Journal Template Name", CodDiario);
        GenJnlLine.SETRANGE("Journal Batch Name", SeccDiario);
        GenJnlLine.SETRANGE("Check Printed", FALSE);
        GenJnlLine.SETRANGE("Check Exported", FALSE);
        GenJnlLine.SETRANGE("Document Type", GenJnlLine."Document Type"::Payment);
        GenJnlLine.SETRANGE("Bank Payment Type", GenJnlLine."Bank Payment Type"::"Electronic Payment");
        GenJnlLine.SETFILTER(Amount, '<>%1', 0);
        GenJnlLine.FINDFIRST;

        //TODO: Ver PathENV := TEMPORARYPATH;

        NombreArchivo := 'PE-BR-' + BankAccount."Identificador Empresa" + '-' + FORMAT(WORKDATE, 0, '<Month,2>') + FORMAT(WORKDATE, 0, '<Day,2>');

        IF BankAccount.Secuencia = '' THEN BEGIN
            Secuencia := '000000';

            BankAccount.Secuencia := INCSTR(BankAccount.Secuencia);
            BankAccount.MODIFY;
        END
        ELSE BEGIN
            BankAccount.Secuencia := INCSTR(BankAccount.Secuencia);
            BankAccount.MODIFY;
            Secuencia := BankAccount.Secuencia;
        END;
        NombreArchivo += Secuencia + '.txt';
        NombreArchivo2 := NombreArchivo;

        //TODO: Ver  Archivo.TEXTMODE(TRUE);
        //TODO: Ver Archivo.CREATE(PathENV + NombreArchivo);
        //TODO: Ver Archivo.TRUNC;

        //Leemos el Diario
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE("Journal Template Name", CodDiario);
        GenJnlLine.SETRANGE("Journal Batch Name", SeccDiario);
        GenJnlLine.SETRANGE("Check Printed", FALSE);
        GenJnlLine.SETRANGE("Check Exported", FALSE);
        GenJnlLine.SETRANGE("Document Type", GenJnlLine."Document Type"::Payment);
        GenJnlLine.SETRANGE("Bank Payment Type", GenJnlLine."Bank Payment Type"::"Electronic Payment");
        GenJnlLine.SETFILTER(Amount, '<>%1', 0);
        GenJnlLine.FINDSET;
        CounterTotal := GenJnlLine.COUNT;
        Window.OPEN(Text001);
        REPEAT
            Counter := Counter + 1;
            Window.UPDATE(1, GenJnlLine."Account No.");
            Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

            IF GenJnlLine."Posting Date" < TODAY THEN
                ERROR(Err003);

            //Creo el detalle
            CLEAR(Vendor);
            CLEAR(Lin_Body);
            IF BankAccount."Tipo Cuenta" = BankAccount."Tipo Cuenta"::"CA=Cuenta de Ahorro" THEN
                Lin_Body := 'ÇA'
            ELSE
                Lin_Body := 'ÇC';

            IF BankAccount."Currency Code" = '' THEN
                Lin_Body += 'DOP'
            ELSE
                Lin_Body += BankAccount."Currency Code";
            BankAccount."Bank Account No." := DELCHR(BankAccount."Bank Account No.", '=', '-/., ');
            Lin_Body += BankAccount."Bank Account No." + ','; //Cuenta de origen

            IF GenJnlLine."Account Type" = GenJnlLine."Account Type"::Vendor THEN BEGIN
                Vendor.GET(GenJnlLine."Account No.");
                BankAccount.GET(GenJnlLine."Bal. Account No.");
                VendorBank.RESET;
                VendorBank.SETRANGE("Vendor No.", GenJnlLine."Account No.");
                VendorBank.SETRANGE(Code, GenJnlLine."Recipient Bank Account");
                CodBco := GenJnlLine."Bal. Account No.";
                VendorBank.FINDFIRST;
                VendorBank.TESTFIELD("Bank Account No.");
                //TODO: Ver VendorBank.TESTFIELD("Banco RED ACH");
                //TODO: Ver BcoACH.GET(VendorBank."Banco RED ACH");
                //BcoACH.TESTFIELD("Ruta y Transito");
            END
            ELSE
                IF GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Vendor THEN BEGIN
                    Vendor.GET(GenJnlLine."Bal. Account No.");
                    BankAccount.GET(GenJnlLine."Account No.");
                    VendorBank.RESET;
                    VendorBank.SETRANGE("Vendor No.", GenJnlLine."Bal. Account No.");
                    VendorBank.SETRANGE(Code, GenJnlLine."Recipient Bank Account");
                    CodBco := GenJnlLine."Account No.";
                    VendorBank.FINDFIRST;
                    VendorBank.TESTFIELD("Bank Account No.");
                    //TODO: Ver VendorBank.TESTFIELD("Banco RED ACH");
                    //TODO: Ver BcoACH.GET(VendorBank."Banco RED ACH");
                    //BcoACH.TESTFIELD("Ruta y Transito");
                END;
            //TODO: Ver  BcoACH.GET(VendorBank."Banco RED ACH");


            Lin_Body += BcoACH."ACH Reservas" + ','; //Banco y ruta destino

            //Tipo cuenta ==> AH= ahorro, CC= Corriente, TC = Tarjeta de crédito, PR = Préstamos
            IF (VendorBank."Bank Account No." <> '') AND (VendorBank."Tipo Cuenta" <> 2) THEN
                Lin_Body += VendorBank."Bank Account No."
            ELSE
                IF VendorBank."Tipo Cuenta" <> 2 THEN
                    ERROR(Err002, GenJnlLine."Account No." + ', ' + GenJnlLine.Beneficiario)
                ELSE
                    IF VendorBank."Tipo Cuenta" = 2 THEN
                        Lin_Body += FORMAT(Blanco, 20);
            Lin_Body += ',';
            IF VendorBank."Tipo Cuenta" = 0 THEN //Corriente
                Lin_Body += 'CC'
            ELSE
                Lin_Body += 'CA';

            VendorBank."Bank Account No." := DELCHR(VendorBank."Bank Account No.", '=', '-/., ');

            Lin_Body += ',';
            Lin_Body += FORMAT(GenJnlLine.Amount * 100, 13, '<integer,13><Filler Character,0>') + ',';
            GenJnlLine.Beneficiario := DELCHR(GenJnlLine.Beneficiario, '=', ',');
            Lin_Body += COPYSTR(GenJnlLine.Beneficiario, 1, 22) + ',';
            Vendor.TESTFIELD("VAT Registration No.");
            IF STRLEN(DELCHR(Vendor."VAT Registration No.", '=', ' -')) = 9 THEN
                Lin_Body += 'RNC'
            ELSE
                IF STRLEN(DELCHR(Vendor."VAT Registration No.", '=', ' -')) = 11 THEN
                    Lin_Body += 'Cedula'
                ELSE
                    Lin_Body += 'Pasaporte';
            Lin_Body += RNC + ',';
            GenJnlLine.Description := DELCHR(GenJnlLine.Description, '=', ',');
            Lin_Body += FORMAT(COPYSTR(GenJnlLine.Description, 1, 55), 55);
        //TODO: Ver Archivo.WRITE(Lin_Body);
        UNTIL GenJnlLine.NEXT = 0;

        Window.CLOSE;
        //TODO: Ver Archivo.CLOSE;

        //TODO: Ver NombreArchivo := TEMPORARYPATH + NombreArchivo;
        //TODO: Ver NombreArchivo2 := BankAccount."E-Pay Export File Path" + NombreArchivo2;
        //MESSAGE('%1\ %2',NOMBREARCHIVO,NOMBREARCHIVO2);
        RenameFile;
        MESSAGE(MSG001);
    end;

    local procedure FormatoSCA(CodDiario: Code[20]; SeccDiario: Code[20])
    var
        Secuencia: Text[10];
        CodBco: Code[20];
        Contador: Integer;
    begin
        CompanyInfo.GET();

        Blanco := ' ';
        CERO := '0';
        TotalGeneral := 0;

        //Leemos el Diario
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE("Journal Template Name", CodDiario);
        GenJnlLine.SETRANGE("Journal Batch Name", SeccDiario);
        GenJnlLine.SETRANGE("Check Printed", FALSE);
        GenJnlLine.SETRANGE("Check Exported", FALSE);
        GenJnlLine.SETRANGE("Document Type", GenJnlLine."Document Type"::Payment);
        GenJnlLine.SETRANGE("Bank Payment Type", GenJnlLine."Bank Payment Type"::"Electronic Payment");
        GenJnlLine.SETFILTER(Amount, '<>%1', 0);
        GenJnlLine.FINDFIRST;

        //TODO: Ver IF COPYSTR(BankAccount."E-Pay Export File Path", STRLEN(BankAccount."E-Pay Export File Path"), 1) <> '\' THEN
        //TODO: Ver     BankAccount."E-Pay Export File Path" += '\';

        //TODO: Ver PathENV := TEMPORARYPATH;

        //TODO: Ver BankAccount."Last E-Pay Export File Name" := INCSTR(BankAccount."Last E-Pay Export File Name");
        BankAccount.MODIFY;

        //TODO: Ver NombreArchivo := BankAccount."Last E-Pay Export File Name";

        NombreArchivo2 := NombreArchivo;

        //TODO: Ver PathENV := TEMPORARYPATH;

        //TODO: Ver Archivo.TEXTMODE(TRUE);
        //TODO: Ver Archivo.CREATE(PathENV + NombreArchivo);
        //TODO: Ver Archivo.TRUNC;

        //Leemos el Diario
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE("Journal Template Name", CodDiario);
        GenJnlLine.SETRANGE("Journal Batch Name", SeccDiario);
        GenJnlLine.SETRANGE("Check Printed", FALSE);
        GenJnlLine.SETRANGE("Check Exported", FALSE);
        GenJnlLine.SETRANGE("Document Type", GenJnlLine."Document Type"::Payment);
        GenJnlLine.SETRANGE("Bank Payment Type", GenJnlLine."Bank Payment Type"::"Electronic Payment");
        GenJnlLine.SETFILTER(Amount, '<>%1', 0);
        GenJnlLine.FINDSET;
        CounterTotal := GenJnlLine.COUNT;
        Window.OPEN(Text001);

        REPEAT
            Counter := Counter + 1;
            Window.UPDATE(1, GenJnlLine."Account No.");
            Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

            IF GenJnlLine."Posting Date" < TODAY THEN
                ERROR(Err003);

            //Creo el detalle
            CLEAR(Vendor);
            CLEAR(Lin_Body);
            Contador := Contador + 1;

            IF GenJnlLine."Account Type" = GenJnlLine."Account Type"::Vendor THEN BEGIN
                Vendor.GET(GenJnlLine."Account No.");
                BankAccount.GET(GenJnlLine."Bal. Account No.");
                VendorBank.RESET;
                VendorBank.SETRANGE("Vendor No.", GenJnlLine."Account No.");
                VendorBank.SETRANGE(Code, GenJnlLine."Recipient Bank Account");
                CodBco := GenJnlLine."Bal. Account No.";
                VendorBank.FINDFIRST;
                VendorBank.TESTFIELD("Bank Account No.");
                //TODO: Ver VendorBank.TESTFIELD("Banco RED ACH");
                //TODO: Ver BcoACH.GET(VendorBank."Banco RED ACH");
                //      BcoACH.TESTFIELD("Ruta y Transito");
            END
            ELSE
                IF GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Vendor THEN BEGIN
                    Vendor.GET(GenJnlLine."Bal. Account No.");
                    BankAccount.GET(GenJnlLine."Account No.");
                    VendorBank.RESET;
                    VendorBank.SETRANGE("Vendor No.", GenJnlLine."Bal. Account No.");
                    VendorBank.SETRANGE(Code, GenJnlLine."Recipient Bank Account");
                    CodBco := GenJnlLine."Account No.";
                    VendorBank.FINDFIRST;
                    VendorBank.TESTFIELD("Bank Account No.");
                    //TODO: Ver VendorBank.TESTFIELD("Banco RED ACH");
                    //TODO: Ver BcoACH.GET(VendorBank."Banco RED ACH");
                    //      BcoACH.TESTFIELD("Ruta y Transito");
                END;

            BankAccount."Bank Account No." := DELCHR(BankAccount."Bank Account No.", '=', '-/., ');
            GenJnlLine.Description := DELCHR(GenJnlLine.Description, '=', ',');
            GenJnlLine.Beneficiario := DELCHR(GenJnlLine.Beneficiario, '=', ',');

            //tipo cuenta ==> 0= ahorro, 1= Corriente, 2 = cheque
            IF (GenJnlLine."Account Type" = GenJnlLine."Account Type"::"Bank Account") AND  // Para cuando es transferencias entre bancos
               (GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::"Bank Account") THEN BEGIN
                BankAccount2.GET(GenJnlLine."Account No.");
                BankAccount2.TESTFIELD("Bank Account No.");
                //BankAccount2.TESTFIELD("Bank Code");
                BankAccount2."Bank Account No." := DELCHR(BankAccount2."Bank Account No.", '=', '-/., ');
                CLEAR(Lin_Body);
                Lin_Body := FORMAT(COPYSTR(GenJnlLine.Beneficiario, 1, 32), 32);
                Lin_Body += ',';
                IF GenJnlLine."Account Type" = GenJnlLine."Account Type"::Vendor THEN
                    Lin_Body += FORMAT(DELCHR(Vendor."VAT Registration No.", '=', ' .-'))
                ELSE
                    IF GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Vendor THEN
                        Lin_Body += FORMAT(DELCHR(Vendor."VAT Registration No.", '=', ' .-'))
                    ELSE
                        Lin_Body += FORMAT(Counter, 0, '<Integer>');
                Lin_Body += ',';
                Lin_Body += VendorBank."SWIFT Code";
                Lin_Body += ',';
                Lin_Body += BankAccount."Bank Account No.";
                Lin_Body += ',';
                IF GenJnlLine."Currency Code" = '' THEN
                    Lin_Body += 'DOP'
                ELSE
                    Lin_Body += GenJnlLine."Currency Code";

                Lin_Body += ',';
                IF BankAccount."Tipo Cuenta" = BankAccount."Tipo Cuenta"::"CC= Cuenta Corriente" THEN
                    Lin_Body += 'Chequing'
                ELSE
                    Lin_Body += 'Saving';
                Lin_Body += ',';
                Lin_Body += FORMAT(GenJnlLine.Amount * 100, 10, '<Integer,10><Filler Character,0>');
                Lin_Body += ',';
                Lin_Body += COPYSTR(GenJnlLine.Description, 1, 80);
                //TODO: Ver Archivo.WRITE(Lin_Body);
            END
            ELSE BEGIN
                CLEAR(Lin_Body);
                Lin_Body := FORMAT(COPYSTR(GenJnlLine.Beneficiario, 1, 32), 32);
                Lin_Body += ',';
                Counter += 1;
                Lin_Body += FORMAT(Contador, 0, '<Integer>');
                Lin_Body += ',';
                Lin_Body += VendorBank."SWIFT Code";
                Lin_Body += ',';
                Lin_Body += BankAccount."Bank Account No.";
                Lin_Body += ',';
                IF GenJnlLine."Currency Code" = '' THEN
                    Lin_Body += 'DOP'
                ELSE
                    Lin_Body += GenJnlLine."Currency Code";

                Lin_Body += ',';
                IF BankAccount."Tipo Cuenta" = BankAccount."Tipo Cuenta"::"CC= Cuenta Corriente" THEN
                    Lin_Body += 'Chequing'
                ELSE
                    Lin_Body += 'Saving';
                Lin_Body += ',';
                Lin_Body += FORMAT(GenJnlLine.Amount * 100, 10, '<Integer,10><Filler Character,0>');
                Lin_Body += ',';
                Lin_Body += COPYSTR(GenJnlLine.Description, 1, 80);
                //TODO: Ver Archivo.WRITE(Lin_Body);
            END;

            ExportAmount := GenJnlLine.Amount;

            GenJnlLine."Check Printed" := TRUE;
            GenJnlLine."Check Exported" := TRUE;
            GenJnlLine."Check Transmitted" := TRUE;
            GenJnlLine."Exported to Payment File" := TRUE;

            //TODO: Ver GenJnlLine."Export File Name" := NombreArchivo2;
            //TODO: Ver BankAccount.TESTFIELD("Last Remittance Advice No.");
            //TODO: Ver GenJnlLine."Document No." := INCSTR(BankAccount."Last Remittance Advice No.");

            //TODO: Ver BankAccount."Last Remittance Advice No." := INCSTR(BankAccount."Last Remittance Advice No.");
            //TODO: Ver BankAccount."Last E-Pay Export File Name" := NombreArchivo;
            BankAccount.MODIFY;

            InsertIntoCheckLedger(Tracenumber, -ExportAmount, GenJnlLine);
            GenJnlLine.MODIFY;

        UNTIL GenJnlLine.NEXT = 0;
        Window.CLOSE;
        //TODO: Ver Archivo.CLOSE;

        //TODO: Ver NombreArchivo := TEMPORARYPATH + NombreArchivo;
        //TODO: Ver NombreArchivo2 := BankAccount."E-Pay Export File Path" + NombreArchivo2;
        //MESSAGE('%1\ %2',NOMBREARCHIVO,NOMBREARCHIVO2);
        RenameFile;
        MESSAGE(MSG001);
    end;
}

