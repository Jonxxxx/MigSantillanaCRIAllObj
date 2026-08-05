codeunit 55746 Parser
{
    // Analizador sintáctico basado en el algoritmo 'Descenso recursivo' con
    // generacion de codigo en polaca inversa para la gramática:
    // E -> E + T, E - T
    // E -> T, -T
    // T -> T * F, T / F
    // T -> F
    // F -> i
    // F -> (E), -(E)
    // El codigo generado se almacena en la tabla POLACA

    TableNo = 55785;

    trigger OnRun()
    begin
        GlobalRec.COPY(Rec);
        WITH GlobalRec DO BEGIN
            GlobalRec.Formula := DELCHR(GlobalRec.Formula, '=', ' ');

            Regtoken.SETRANGE(Formula, GlobalRec.Formula);
            Regtoken.FINDFIRST;

            E(Regpolaca);
            IF Regtoken.Token <> '$' THEN BEGIN
                Eliminar;
                ERROR('Carácter inesperado %1  ' +
                      '%2', Regtoken.Token, Regtoken.Formula);
            END;
        END;
        Rec.COPY(GlobalRec);
    end;

    var
        Puntero: Integer;
        Regtoken: Record 55783;
        Regpolaca: Record 55784;
        Regconceptos: Record 55785;
        GlobalRec: Record 55785;

    procedure F(Reg: Record 55784)
    begin
        IF (Regtoken.Token >= 'a') AND (Regtoken.Token < 'z') OR
           (Regtoken.Token >= 'A') AND (Regtoken.Token < 'Z') OR
           (Regtoken.Token >= '0') AND (Regtoken.Token <= '9') OR
           (COPYSTR(Regtoken.Token, 1, 1) = '#') THEN BEGIN
            Reg.Token := Regtoken.Token;
            Apilar(Reg);
            Regtoken.NEXT;
        END
        ELSE IF Regtoken.Token <> '(' THEN BEGIN
            Eliminar;
            ERROR('Se esperaba paréntesis de apertura (  ' +
                  '%1', Regtoken.Formula);
        END
        ELSE BEGIN
            Regtoken.NEXT;
            E(Reg);
            IF Regtoken.Token <> ')' THEN BEGIN
                Eliminar;
                ERROR('Se esperaba paréntesis de cierre )  ' + '%1', Regtoken.Formula);
            END
            ELSE
                Regtoken.NEXT;
        END;
    end;

    procedure T(Reg: Record 55784)
    begin
        F(Reg);
        WHILE (Regtoken.Token = '*') OR (Regtoken.Token = '/') DO BEGIN
            Reg.Token := Regtoken.Token;
            Regtoken.NEXT;
            F(Reg);
            Apilar(Reg);
        END;
    end;

    procedure E(Reg: Record 55784)
    begin
        IF Regtoken.Token = '-' THEN BEGIN
            Reg.Token := '&';
            Regtoken.NEXT;
            T(Reg);
            Apilar(Reg);
        END
        ELSE
            T(Reg);
        WHILE (Regtoken.Token = '+') OR (Regtoken.Token = '-') DO BEGIN
            Reg.Token := Regtoken.Token;
            Regtoken.NEXT;
            T(Reg);
            Apilar(Reg);
        END;
    end;

    procedure Apilar(Reg: Record 55784)
    begin
        Puntero := Puntero + 1;
        Reg.Formula := Regtoken.Formula;
        Reg.Puntero := Puntero;
        IF NOT Reg.INSERT THEN
            Reg.MODIFY;
    end;

    procedure Eliminar()
    begin
        Regtoken.DELETEALL;
        Regpolaca.DELETEALL;
        COMMIT;
    end;
}

