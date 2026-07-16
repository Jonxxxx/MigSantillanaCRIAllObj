codeunit 34002107 Calculadora
{
    // Calcula el valor de una formula en notacion polaca inversa del fichero POLACA
    // y lo almacena en la variable resultado del fichero CONCEPTOS
    // El signo menos unario en polaca se representará por el signo '&'


    trigger OnRun()
    begin
        i := 0;
        Reg_Conceptos.GET('resultado');
        Reg_Polaca.SETRANGE(Formula, Reg_Conceptos.Formula);

        Reg_Polaca.FIND('-');

        //Reg_Conceptos.GET(Reg_Polaca.Token);

        REPEAT
            CASE Reg_Polaca.Token OF
                '+':
                    BEGIN
                        i := i - 1;
                        Pila[i] := Pila[i] + Pila[i + 1];
                    END;
                '-':
                    BEGIN
                        i := i - 1;
                        Pila[i] := Pila[i] - Pila[i + 1];
                    END;
                '*':
                    BEGIN
                        i := i - 1;
                        Pila[i] := Pila[i] * Pila[i + 1];
                    END;
                '/':
                    BEGIN
                        i := i - 1;
                        Pila[i] := Pila[i] / Pila[i + 1];
                    END;
                '&':
                    Pila[i] := -Pila[i];
                ELSE BEGIN
                    Reg_Conceptos.RESET;
                    Reg_Conceptos.SETRANGE(Concepto, Reg_Polaca.Token);
                    //      IF Reg_Conceptos.GET(Reg_Polaca.Token) THEN {variable}
                    IF Reg_Conceptos.FINDFIRST THEN /*variable*/
                       BEGIN
                        i := i + 1;
                        Pila[i] := Reg_Conceptos.Valor;
                    END
                    ELSE BEGIN
                        i := i + 1;
                        IF NOT Conceptossalariales.GET(Reg_Polaca.Token) THEN
                            EVALUATE(Pila[i], Reg_Polaca.Token);      /*constante*/
                    END;
                END;
            END;

        UNTIL Reg_Polaca.FIND('>') = FALSE;

        Reg_Conceptos.GET('resultado');
        Reg_Conceptos.Valor := Pila[i];
        Reg_Conceptos.MODIFY;

        Reg_tokens.RESET;
        Reg_tokens.DELETEALL;
        Reg_Polaca.RESET;
        Reg_Polaca.DELETEALL;

    end;

    var
        Reg_tokens: Record 34002142;
        Reg_Polaca: Record 34002143;
        Reg_Conceptos: Record 34002144;
        Conceptossalariales: Record 34002111;
        Pila: array[10] of Decimal;
        i: Integer;
}

