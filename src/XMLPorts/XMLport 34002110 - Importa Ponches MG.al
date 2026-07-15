xmlport 34002110 "Importa Ponches MG"
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
                                  WHERE(Field1 = CONST(1));*/
                textelement(texto)
                {
                    Width = 250;
                }

                trigger OnBeforeInsertRecord()
                begin
                    //ERROR('%1',COPYSTR(texto,5,5));
                    /*
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
                    //IF COPYSTR(texto,2,1) = '3' THEN
                       BEGIN
                        IF Emp.GET(COPYSTR(texto, 8, 5)) THEN BEGIN
                            CLEAR(LogPonchador);
                            LogPonchador.VALIDATE("Cod. Empleado", COPYSTR(texto, 8, 5));
                            AAAA := COPYSTR(texto, 13, 4);
                            MM := COPYSTR(texto, 17, 2);
                            DD := COPYSTR(texto, 19, 2);
                            EVALUATE(iAAAA, AAAA);
                            EVALUATE(iMM, MM);
                            EVALUATE(iDD, DD);
                            LogPonchador."Fecha registro" := DMY2DATE(iDD, iMM, iAAAA);
                            EVALUATE(LogPonchador."Hora registro", COPYSTR(texto, 21, 6));
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

