codeunit 34002106 Scanner
{
    TableNo = 34002144;

    trigger OnRun()
    begin
        GlobalRec.COPY(Rec);
        Reg_Tokens.INIT;
        CLEAR(Reg_Tokens);
        Posicion := 0;
        Token := '';
        Car := '';
        Puntero := 0;
        i := 0;
        WITH GlobalRec DO BEGIN
            GlobalRec.Formula := DELCHR(GlobalRec.Formula, '=', ' ');

            Scan;

            WHILE Car <> '' DO BEGIN
                Token := '';
                IF (STRPOS('abcdefghijklmnopqrstuvwxyZABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_.,', Car) <> 0) THEN BEGIN
                    REPEAT
                        Token := Token + Car;
                        Scan;
                    UNTIL (STRPOS('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_.,', Car) = 0);
                    Reconceptos.SETRANGE(Codigo, Token);
                    IF NOT Reconceptos.FINDFIRST THEN;
                END
                ELSE
                    IF (STRPOS('+-*/()#', Car) = 0) THEN
                        ERROR('Carácter inesperado  %1', Car)
                    ELSE BEGIN
                        Token := Token + Car;
                        Scan;
                        IF Token = '#' THEN BEGIN
                            Token := Token + Car;
                            Scan;
                        END;
                    END;
                IF Token <> '' THEN
                    Apilar;
            END;

            Token := '$';
            Apilar;
        END;
        Rec.COPY(GlobalRec);
    end;

    var
        Posicion: Integer;
        Car: Text[1];
        Token: Text[30];
        i: Integer;
        Reg_Tokens: Record 34002142;
        Puntero: Integer;
        Reconceptos: Record 34002111;
        GlobalRec: Record 34002144;

    procedure Scan()
    begin
        i := i + 1;
        Car := COPYSTR(GlobalRec.Formula, i, 1);
    end;

    procedure Apilar()
    begin
        Puntero := Puntero + 1;
        Reg_Tokens.Formula := GlobalRec.Formula;
        Reg_Tokens.Puntero := Puntero;
        Reg_Tokens.Token := Token;
        IF NOT Reg_Tokens.INSERT THEN
            Reg_Tokens.MODIFY;
    end;
}

