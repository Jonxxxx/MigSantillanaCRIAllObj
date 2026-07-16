codeunit 34002526 "Inicializar Ventas POS-PELIGRO"
{

    trigger OnRun()
    var
        Text001: Label 'Este proceso BORRA TODOS LOS DATOS DEL POS\ Solo deberia ejecutarlo Dynasoft Solutions \ ¿Continuar?';
        r1: Record 36;
        r2: Record 37;
        r3: Record 34002521;
        r4: Record 34002530;
        r5: Record 34002523;
        r6: Record 34002524;
        r7: Record 34002526;
        r8: Record 34002528;
        r9: Record 34003050;
        r10: Record 34002529;
        r11: Record 34003052;
    begin

        IF NOT CONFIRM(Text001, FALSE) THEN
            EXIT;

        r1.SETRANGE("Venta TPV", TRUE);
        IF r1.FINDSET THEN BEGIN
            REPEAT
                r2.RESET;
                r2.SETRANGE("Document No.", r1."No.");
                IF r2.FINDSET THEN
                    r2.DELETEALL(FALSE);
            UNTIL r1.NEXT = 0;
            r1.DELETEALL(FALSE);
        END;

        r3.DELETEALL(FALSE);
        r4.DELETEALL(FALSE);
        r5.DELETEALL(FALSE);
        r6.DELETEALL(FALSE);
        r7.DELETEALL(FALSE);
        r8.DELETEALL(FALSE);
        r9.DELETEALL(FALSE);
        r10.DELETEALL(FALSE);
        r11.DELETEALL(FALSE);
    end;
}

