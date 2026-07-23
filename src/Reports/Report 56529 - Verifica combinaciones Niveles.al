report 56529 "Verifica combinaciones Niveles"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Colegio - Grados"; 67037)
        {
            DataItemTableView = SORTING("Cod. Colegio", "Cod. Nivel", "Cod. Turno", "Cod. Grado", Seccion)
                                WHERE("Cod. Nivel" = FILTER('INI' | 'PRI' | 'SEC'));

            trigger OnAfterGetRecord()
            begin
                Counter := Counter + 1;
                Window.UPDATE(1, "Cod. Colegio");
                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

                COLNIVEL.TRANSFERFIELDS("Colegio - Grados");
                IF (STRPOS("Cod. Grado", 'INI') <> 0) AND ("Cod. Nivel" <> 'INI') THEN BEGIN
                    COLNIVEL.RENAME("Cod. Colegio", 'INI', "Cod. Turno", "Cod. Grado", Seccion);
                    COMMIT;
                END
                ELSE
                    IF (STRPOS("Cod. Grado", 'PRI') <> 0) AND ("Cod. Nivel" <> 'PRI') THEN BEGIN
                        COLNIVEL.RENAME("Cod. Colegio", 'PRI', "Cod. Turno", "Cod. Grado", Seccion);
                        COMMIT;
                    END
                    ELSE
                        IF (STRPOS("Cod. Grado", 'SEC') <> 0) AND ("Cod. Nivel" <> 'SEC') THEN BEGIN
                            COLNIVEL.RENAME("Cod. Colegio", 'SEC', "Cod. Turno", "Cod. Grado", Seccion);
                            COMMIT;
                        END;
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                CounterTotal := COUNT;
                Window.OPEN(Text001);
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
        COLNIVEL: Record 67037;
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
        Text001: Label 'Reading  #1########## @2@@@@@@@@@@@@@';
}

