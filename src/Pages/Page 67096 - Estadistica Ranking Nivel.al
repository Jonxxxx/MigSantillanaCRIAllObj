page 55555 "Estadistica Ranking Nivel"
{
    Editable = false;
    PageType = Card;
    SourceTable = 55508;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                    Visible = false;
                }
                field("Grupo de Negocio"; Rec."Grupo de Negocio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Grupo de Negocio';
                }
                field("Cod. Nivel"; Rec."Cod. Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Nivel';
                }
                field("Categoria colegio"; Rec."Categoria colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Categoria colegio';
                }
                field(Porciento; Rec.Porciento)
                {
                    ApplicationArea = All;
                    ToolTip = 'Porciento';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Total := 0;

        ColAdopciones.RESET;
        ColAdopciones.SETRANGE("Cod. Colegio", "Cod. Colegio");
        ColAdopciones.SETRANGE(Adopcion, 1, 2); //Mantener, Conquista
        IF ColAdopciones.FINDSET THEN
            REPEAT
                TarifVta.RESET;
                TarifVta.SETRANGE("Item No.", ColAdopciones."Cod. Producto");
                TarifVta.SETRANGE("Sales Type", TarifVta."Sales Type"::"All Customers");
                TarifVta.SETRANGE("Ending Date", 0D);
                TarifVta.FINDFIRST;
                TarifVta.TESTFIELD("Unit Price");
                Total += TarifVta."Unit Price" * ColAdopciones."Cantidad Alumnos";
            UNTIL ColAdopciones.NEXT = 0;

        ColRankNiv.RESET;
        ColRankNiv.SETRANGE("Cod. Colegio", "Cod. Colegio");
        IF ColRankNiv.FINDSET THEN
            REPEAT
                TotalGpoNivel := 0;

                INIT;
                "Cod. Colegio" := ColRankNiv."Cod. Colegio";
                "Grupo de Negocio" := ColRankNiv."Grupo de Negocio";
                "Cod. Nivel" := ColRankNiv."Cod. Nivel";
                "Categoria colegio" := ColRankNiv."Categoria colegio";

                ColAdopciones.RESET;
                ColAdopciones.SETRANGE("Cod. Colegio", "Cod. Colegio");
                ColAdopciones.SETRANGE(Adopcion, 1, 2); //Mantener, Conquista
                ColAdopciones.SETRANGE("Cod. Nivel", ColRankNiv."Cod. Nivel");
                ColAdopciones.SETRANGE("Grupo de Negocio", ColRankNiv."Grupo de Negocio");
                IF ColAdopciones.FINDSET THEN
                    REPEAT
                        TarifVta.RESET;
                        TarifVta.SETRANGE("Item No.", ColAdopciones."Cod. Producto");
                        TarifVta.SETRANGE("Sales Type", TarifVta."Sales Type"::"All Customers");
                        TarifVta.SETRANGE("Ending Date", 0D);
                        TarifVta.FINDFIRST;
                        TarifVta.TESTFIELD("Unit Price");
                        TotalGpoNivel += TarifVta."Unit Price" * ColAdopciones."Cantidad Alumnos";
                    UNTIL ColAdopciones.NEXT = 0;

                IF (Total <> 0) AND (TotalGpoNivel <> 0) THEN
                    Porciento := ROUND(TotalGpoNivel / Total, 0.01) * 100;
                //    MESSAGE('%1 %2 %3 %4',TotalGen,Total);
                INSERT;
            UNTIL ColRankNiv.NEXT = 0;
    end;

    var
        Colegio: Record 5050;
        ColRankNiv: Record 55513;
        ColAdopciones: Record 55520;
        TarifVta: Record 7002;
        Porciento: Decimal;
        Total: Decimal;
        TotalGpoNivel: Decimal;
}

