page 67145 "Ranking CVM"
{
    Editable = false;
    PageType = Card;
    SourceTable = 67092;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Cod. Colegio"; "Cod. Colegio")
                {
                    Visible = false;
                }
                field("Grupo de Negocio"; "Grupo de Negocio")
                {
                    Editable = false;
                }
                field("CVM GN"; "CVM GN")
                {
                    Editable = false;
                }
                field(INI; INI)
                {
                    Editable = false;
                }
                field(PRI; PRI)
                {
                    Editable = false;
                }
                field(SEC; SEC)
                {
                    Editable = false;
                }
                field("% Compra"; "% Compra")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    procedure CalcularRanking(CodCol: Code[20])
    var
        Colegio: Record 5050;
        ColCateg: Record 67091;
        HistColAdopciones: Record 67035;
        TarifVta: Record 7002;
        Porciento: Decimal;
        Total: Decimal;
        TotalGpoNivel: Decimal;
        wAntGpo: Code[20];
        Config: Record 67000;
        HistColCateg: Record 67093;
        ColAdopciones: Record 67053;
        ultCamp: Code[20];
        Text001: Label 'Ranking CVM (calculado con datos de la temporada: %1)';
    begin

        Total := 0;

        Config.GET;
        CurrPage.CAPTION(STRSUBSTNO(Text001, FORMAT(Config."Campaña Ranking Solicitud")));

        CASE Config."Campaña Ranking Solicitud" OF
            Config."Campaña Ranking Solicitud"::"­ltima Cerrada":
                BEGIN
                    HistColAdopciones.RESET;
                    HistColAdopciones.SETCURRENTKEY(Campana, "Cod. Colegio", "Linea de negocio");
                    HistColAdopciones.FINDLAST;
                    ultCamp := HistColAdopciones.Campana;
                    HistColAdopciones.SETCURRENTKEY("Cod. Colegio", Campana, Adopcion, "Cod. Editorial", "Grupo de Negocio", "Linea de negocio");
                    HistColAdopciones.SETRANGE(Campana, ultCamp);
                    HistColAdopciones.SETRANGE("Cod. Colegio", CodCol);
                    HistColAdopciones.SETRANGE(Adopcion, 1, 2); //Mantener, Conquista
                    IF HistColAdopciones.FINDSET THEN
                        REPEAT
                            HistColAdopciones.CALCFIELDS("Sales Price - Unit Price");
                            HistColAdopciones.TESTFIELD("Sales Price - Unit Price");
                            Total += HistColAdopciones."Sales Price - Unit Price" * HistColAdopciones."Adopcion Real";
                        UNTIL HistColAdopciones.NEXT = 0;

                    CLEAR(wAntGpo);
                    TotalGpoNivel := 0;
                    HistColCateg.RESET;
                    HistColCateg.SETRANGE("Cod. Colegio", CodCol);
                    IF HistColCateg.FINDSET THEN BEGIN
                        REPEAT
                            IF wAntGpo <> HistColCateg."Grupo Negocio" THEN BEGIN
                                IF wAntGpo <> '' THEN BEGIN
                                    HistColAdopciones.RESET;
                                    HistColAdopciones.SETCURRENTKEY("Cod. Colegio", Campana, Adopcion, "Cod. Editorial", "Grupo de Negocio", "Linea de negocio");
                                    HistColAdopciones.SETRANGE(Campana, ultCamp);
                                    HistColAdopciones.SETRANGE("Cod. Colegio", CodCol);
                                    HistColAdopciones.SETRANGE(Adopcion, 1, 2); //Mantener, Conquista
                                    HistColAdopciones.SETRANGE("Grupo de Negocio", wAntGpo);
                                    IF HistColAdopciones.FINDSET THEN
                                        REPEAT
                                            HistColAdopciones.CALCFIELDS("Sales Price - Unit Price");
                                            HistColAdopciones.TESTFIELD("Sales Price - Unit Price");
                                            TotalGpoNivel += HistColAdopciones."Sales Price - Unit Price" * HistColAdopciones."Adopcion Real";
                                        UNTIL HistColAdopciones.NEXT = 0;
                                    IF (Total <> 0) AND (TotalGpoNivel <> 0) THEN
                                        "% Compra" := ROUND(TotalGpoNivel / Total, 0.01) * 100;
                                    INSERT;
                                END;
                                TotalGpoNivel := 0;
                                wAntGpo := HistColCateg."Grupo Negocio";
                                INIT;
                                "Cod. Colegio" := HistColCateg."Cod. Colegio";
                                "Grupo de Negocio" := HistColCateg."Grupo Negocio";
                            END;
                            CASE HistColCateg."Cod. Nivel" OF
                                'GEN':
                                    "CVM GN" := HistColCateg.Categoria;
                                'INI':
                                    INI := HistColCateg.Categoria;
                                'PRI':
                                    PRI := HistColCateg.Categoria;
                                'SEC':
                                    SEC := HistColCateg.Categoria;
                            END;

                        UNTIL HistColCateg.NEXT = 0;
                        HistColAdopciones.RESET;
                        HistColAdopciones.SETCURRENTKEY("Cod. Colegio", Campana, Adopcion, "Cod. Editorial", "Grupo de Negocio", "Linea de negocio");
                        HistColAdopciones.SETRANGE(Campana, ultCamp);
                        HistColAdopciones.SETRANGE("Cod. Colegio", CodCol);
                        HistColAdopciones.SETRANGE(Adopcion, 1, 2); //Mantener, Conquista
                        HistColAdopciones.SETRANGE("Grupo de Negocio", wAntGpo);
                        IF HistColAdopciones.FINDSET THEN
                            REPEAT
                                HistColAdopciones.CALCFIELDS("Sales Price - Unit Price");
                                HistColAdopciones.TESTFIELD("Sales Price - Unit Price");
                                TotalGpoNivel += HistColAdopciones."Sales Price - Unit Price" * HistColAdopciones."Adopcion Real";
                            UNTIL HistColAdopciones.NEXT = 0;
                        IF (Total <> 0) AND (TotalGpoNivel <> 0) THEN
                            "% Compra" := ROUND(TotalGpoNivel / Total, 0.01) * 100;
                        INSERT;
                    END;
                END;//FIN ULTIMA

            Config."Campaña Ranking Solicitud"::Vigente:
                BEGIN
                    ColAdopciones.RESET;
                    ColAdopciones.SETCURRENTKEY("Cod. Colegio", Adopcion, "Cod. Editorial", "Grupo de Negocio", "Linea de negocio");
                    ColAdopciones.SETRANGE("Cod. Colegio", CodCol);
                    ColAdopciones.SETRANGE(Adopcion, 1, 2); //Mantener, Conquista
                    IF ColAdopciones.FINDSET THEN
                        REPEAT
                            ColAdopciones.CALCFIELDS("Sales Price - Unit Price");
                            ColAdopciones.TESTFIELD("Sales Price - Unit Price");
                            Total += ColAdopciones."Sales Price - Unit Price" * ColAdopciones."Adopcion Real";
                        UNTIL ColAdopciones.NEXT = 0;

                    CLEAR(wAntGpo);
                    TotalGpoNivel := 0;
                    ColCateg.RESET;
                    ColCateg.SETRANGE("Cod. Colegio", CodCol);
                    IF ColCateg.FINDSET THEN BEGIN
                        REPEAT
                            IF wAntGpo <> ColCateg."Grupo Negocio" THEN BEGIN
                                IF wAntGpo <> '' THEN BEGIN
                                    ColAdopciones.RESET;
                                    ColAdopciones.SETCURRENTKEY("Cod. Colegio", Adopcion, "Cod. Editorial", "Grupo de Negocio", "Linea de negocio");
                                    ColAdopciones.SETRANGE("Cod. Colegio", CodCol);
                                    ColAdopciones.SETRANGE(Adopcion, 1, 2); //Mantener, Conquista
                                    ColAdopciones.SETRANGE("Grupo de Negocio", wAntGpo);
                                    IF ColAdopciones.FINDSET THEN
                                        REPEAT
                                            ColAdopciones.CALCFIELDS("Sales Price - Unit Price");
                                            ColAdopciones.TESTFIELD("Sales Price - Unit Price");
                                            TotalGpoNivel += ColAdopciones."Sales Price - Unit Price" * ColAdopciones."Adopcion Real";
                                        UNTIL ColAdopciones.NEXT = 0;
                                    IF (Total <> 0) AND (TotalGpoNivel <> 0) THEN
                                        "% Compra" := ROUND(TotalGpoNivel / Total, 0.01) * 100;
                                    INSERT;
                                END;
                                TotalGpoNivel := 0;
                                wAntGpo := ColCateg."Grupo Negocio";
                                INIT;
                                "Cod. Colegio" := ColCateg."Cod. Colegio";
                                "Grupo de Negocio" := ColCateg."Grupo Negocio";
                            END;
                            CASE ColCateg."Cod. Nivel" OF
                                'GEN':
                                    "CVM GN" := ColCateg.Categoria;
                                'INI':
                                    INI := ColCateg.Categoria;
                                'PRI':
                                    PRI := ColCateg.Categoria;
                                'SEC':
                                    SEC := ColCateg.Categoria;
                            END;

                        UNTIL ColCateg.NEXT = 0;
                        ColAdopciones.RESET;
                        ColAdopciones.SETCURRENTKEY("Cod. Colegio", Adopcion, "Cod. Editorial", "Grupo de Negocio", "Linea de negocio");
                        ColAdopciones.SETRANGE("Cod. Colegio", CodCol);
                        ColAdopciones.SETRANGE(Adopcion, 1, 2); //Mantener, Conquista
                        ColAdopciones.SETRANGE("Grupo de Negocio", wAntGpo);
                        IF ColAdopciones.FINDSET THEN
                            REPEAT
                                ColAdopciones.CALCFIELDS("Sales Price - Unit Price");
                                ColAdopciones.TESTFIELD("Sales Price - Unit Price");
                                TotalGpoNivel += ColAdopciones."Sales Price - Unit Price" * ColAdopciones."Adopcion Real";
                            UNTIL ColAdopciones.NEXT = 0;
                        IF (Total <> 0) AND (TotalGpoNivel <> 0) THEN
                            "% Compra" := ROUND(TotalGpoNivel / Total, 0.01) * 100;
                        INSERT;
                    END;
                END;//FIN VIGENTE
        END;//FIN CASE
    end;
}

