report 56025 "Etiqueta Cajas OLD"
{
    // 001  PLB  07/08/2014  MIGRACION NAV2013: no se puede utilizar shell, mejor utilizar WSH
    //                       http://www.mibuso.com/forum/viewtopic.php?t=45256
    //                       http://www.mibuso.com/forum/viewtopic.php?t=12417

    ProcessingOnly = true;

    dataset
    {
        dataitem("Lin. Packing Registrada"; 56034)
        {

            trigger OnAfterGetRecord()
            var
                wsh_shell: Automation;
            begin
                UsrSetUp.GET(USERID);
                UsrSetUp.TESTFIELD("Ubicacion Impresion Etiqueta");

                CompInf.GET;

                RWAL.RESET;
                RWAL.SETRANGE(RWAL."No.", "Lin. Packing Registrada"."No. Picking");
                IF RWAL.FINDFIRST THEN
                    Cust.GET(RWAL."Destination No.");
                IF Pais.GET(Cust."Country/Region Code") THEN;
                afile2.CREATE(UsrSetUp."Ubicacion Impresion Etiqueta" + '\' + 'BTC1.txt');
                afile2.TEXTMODE(TRUE);
                afile2.WRITEMODE(TRUE);

                afile2.WRITE('^XA');
                afile2.WRITE('^FO40,20^A0N,35,28^FD' + CompInf.Name + '^FS');
                afile2.WRITE('^FO40,60^A0N,35,20^FD' + CompInf."Address 2" + '^FS');
                afile2.WRITE('^FO40,100^A0N,35,20^FD' + CompInf.Address + '^FS');

                afile2.WRITE('^FO300,100^A0N,45,95^FD' + RWAL."Source No." + '^FS');
                afile2.WRITE('^FO40,140^A0N,35,28^FD--------------------------------^FS');
                afile2.WRITE('^FO40,180^A0N,35,28^FD' + 'Destinatario:' + '^FS');
                afile2.WRITE('^FO40,220^A0N,35,28^FD' + Cust.Name + '^FS');
                afile2.WRITE('^FO40,260^A0N,35,28^FD' + Cust."Post Code" + '^FS');
                afile2.WRITE('^FO40,300^A0N,35,28^FD' + Cust.Address + '^FS');
                afile2.WRITE('^FO40,340^A0N,35,28^FD' + Cust."Address 2" + '^FS');
                afile2.WRITE('^FO40,380^A0N,35,28^FD' + Cust.City + '^FS');
                afile2.WRITE('^FO40,420^A0N,35,28^FD' + Pais.Name + '^FS');

                //Cantidad de Bultos
                I := 0;
                N := 0;

                LPR.RESET;
                LPR.SETRANGE("No.", "No.");
                CantBult := LPR.COUNT;
                IF LPR.FINDSET THEN
                    REPEAT
                        IF (LPR."No." = "No.") AND (LPR."No. Caja" = "No. Caja") THEN BEGIN
                            I := 1;
                            N += 1;
                        END
                        ELSE
                            N += 1;
                        LPR.NEXT;
                    UNTIL I = 1;

                afile2.WRITE('^FO240,480^A0N,45,100^FD' + 'BULTO ' + FORMAT(N) + '/' + FORMAT(CantBult) + '^FS');
                afile2.WRITE('^FO40,560^A0N,35,28^FD--------------------------------^FS');
                CALCFIELDS("Total de Productos");
                afile2.WRITE('^FO240,540^A0N,35,28^FD' + 'Este bulto contiene ' + FORMAT("Total de Productos") + ' ej.:' + '^FS');

                Contador := 550;
                ContCajReg.RESET;
                ContCajReg.SETRANGE("No. Packing", "No.");
                ContCajReg.SETRANGE("No. Caja", "No. Caja");
                IF ContCajReg.FINDSET THEN
                    REPEAT
                        Contador += 40;
                        ICR.RESET;
                        ICR.SETRANGE(ICR."Item No.", ContCajReg."No. Producto");
                        ICR.SETRANGE(ICR."Cross-Reference Type", ICR."Cross-Reference Type"::"Bar Code");
                        ICR.FINDFIRST;
                        afile2.WRITE('^FO40,' + FORMAT(Contador) + '^A0N,35,22^FD' + FORMAT(ICR."Cross-Reference No.") + '^FS');
                        afile2.WRITE('^FO240,' + FORMAT(Contador) + '^A0N,35,22^FD' + FORMAT(ContCajReg.Descripcion) + '^FS');
                        afile2.WRITE('^FO730,' + FORMAT(Contador) + '^A0N,35,22^FD' + FORMAT(ContCajReg.Cantidad) + '^FS');
                    UNTIL ContCajReg.NEXT = 0;
                afile2.WRITE('^XZ');

                afile2.CLOSE;

                //afile3.CREATE(UsrSetUp."Ubicacion Impresion Etiqueta"+'\'+'BTC1.bat');
                //afile3.TEXTMODE(TRUE);
                //afile3.WRITEMODE(TRUE);
                //afile3.WRITE('copy '+UsrSetUp."Ubicacion Impresion Etiqueta"+'\'+'BTC1.txt '+ 'lpt1:');
                //afile3.CLOSE;

                //CommandProcessor := UsrSetUp."Ubicacion Impresion Etiqueta"+'\'+'BTC1.bat';
                SLEEP(1000);
                CommandProcessor := 'cmd /c copy ' + UsrSetUp."Ubicacion Impresion Etiqueta" + '\' + 'BTC1.txt ' + 'lpt1:';

                //iShell := SHELL(CommandProcessor);
                CREATE(wsh_shell, FALSE, TRUE);
                iShell := wsh_shell.Run(CommandProcessor);
                CLEAR(wsh_shell);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        afile2: File;
        afile3: File;
        CommandProcessor: Text[30];
        Variable1: Text[30];
        Variable2: Text[30];
        iShell: Integer;
        CompInf: Record 79;
        Cust: Record 18;
        RWAH: Record 5772;
        RWAL: Record 5773;
        CPR: Record 56033;
        LPR: Record 56034;
        CantBult: Integer;
        I: Integer;
        N: Integer;
        ContCajReg: Record 56035;
        Contador: Integer;
        ICR: Record 5717;
        UsrSetUp: Record 91;
        Pais: Record 9;
}

