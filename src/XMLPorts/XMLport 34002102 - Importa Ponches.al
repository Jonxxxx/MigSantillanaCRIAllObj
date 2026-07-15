xmlport 34002102 "Importa Ponches"
{
    Direction = Import;
    Format = FixedText;

    schema
    {
        textelement(root)
        {
            tableelement(Table2000000026; 2000000026)
            {
                AutoReplace = false;
                AutoSave = false;
                AutoUpdate = false;
                XmlName = 'integer';
                //TODO: Ver
                /*SourceTableView = SORTING(Field1)
                                  WHERE(Field1=CONST(1));*/
                textelement(texto)
                {
                    Width = 250;
                }

                trigger OnBeforeInsertRecord()
                begin
                    /*MESSAGE('%1',COPYSTR(texto,8,1));
                    MESSAGE('%1',COPYSTR(texto,11,4));
                    */
                    IF COPYSTR(texto, 8, 1) = '4' THEN BEGIN
                        AAAA := COPYSTR(texto, 10, 4);
                        MM := COPYSTR(texto, 14, 2);
                        DD := COPYSTR(texto, 16, 2);
                        EVALUATE(iAAAA, AAAA);
                        EVALUATE(iMM, MM);
                        EVALUATE(iDD, DD);
                    END
                    ELSE
                        IF COPYSTR(texto, 8, 1) = '3' THEN BEGIN
                            IF Emp.GET(COPYSTR(texto, 11, 4)) THEN BEGIN
                                CLEAR(LogPonchador);
                                LogPonchador.VALIDATE("Cod. Empleado", COPYSTR(texto, 11, 4));
                                LogPonchador."Fecha registro" := DMY2DATE(iDD, iMM, iAAAA);
                                EVALUATE(LogPonchador."Hora registro", COPYSTR(texto, 1, 6));
                                LogPonchador.Procesado := FALSE;
                                IF NOT LogPonchador.INSERT THEN
                                    LogPonchador.MODIFY;
                            END;
                        END;

                end;
            }
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

    var
        Emp: Record 5200;
        LogPonchador: Record 34002177;
        Fecha: Integer;
        AAAA: Text[4];
        MM: Text[2];
        DD: Text[2];
        iAAAA: Integer;
        iMM: Integer;
        iDD: Integer;
}

