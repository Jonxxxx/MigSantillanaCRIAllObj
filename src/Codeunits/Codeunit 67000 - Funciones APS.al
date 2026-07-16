codeunit 67000 "Funciones APS"
{

    trigger OnRun()
    begin
    end;

    var
        APSSetup: Record 67000;
        Colegio: Record 5050;
        Fecha: Record 2000000007;
        FechaInicioMes: Date;
        AnoInicio: Integer;
        MesInicio: Integer;
        "DiaInicio": Integer;
        AnoFin: Integer;
        MesFin: Integer;
        "DiaFin": Integer;
        Text001: Label 'Processing School... \ #1########## @2@@@@@@@@@@@@@';
        Text002: Label 'End of update';
        Text003: Label 'Verificando School... \ #1########## @2@@@@@@@@@@@@@';
        Err001: Label 'Starting date can''t be bigger than Ending date, %1 > %2';
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;

    procedure ColCalculoProf()
    begin
    end;

    procedure ColCalculoCenso()
    begin
    end;

    procedure ColCalculoNiveles()
    begin
    end;

    procedure ColBalCte()
    begin
    end;

    procedure ColCalcCompetencia()
    begin
    end;

    procedure ColCalcProm()
    begin
    end;

    procedure ColCalcInvConsigna()
    begin
    end;

    procedure ColCalcInvMuestras(CodColegio: Code[20]): Decimal
    var
        BC: Record 7302;
        Colegio: Record 5050;
        Inventario: Decimal;
    begin
        Inventario := 0;
        IF NOT Colegio.GET(CodColegio) THEN
            EXIT;

        IF Colegio."Samples Location Code" = '' THEN
            EXIT;

        BC.RESET;
        BC.SETRANGE("Location Code", Colegio."Samples Location Code");
        BC.SETRANGE("Bin Code", CodColegio);
        IF BC.FINDSET THEN
            REPEAT
                BC.CALCFIELDS(Quantity);
                Inventario += BC.Quantity;
            UNTIL BC.NEXT = 0;

        EXIT(Inventario);
    end;

    procedure ComCalculoZonas()
    begin
    end;

    procedure ComCalculoCol()
    begin
    end;

    procedure ComPptoVta()
    begin
    end;

    procedure ComCalculoVta()
    begin
    end;

    procedure ProfCalculoCol()
    begin
    end;

    procedure ProfCalculoMat()
    begin
    end;

    procedure ProfCalculoCenso()
    begin
    end;

    procedure LlenaPromotorColegios(CodPromotor: Code[20])
    var
        Promotor: Record 13;
        PromListaCol: Record 67006;
        RutaProm: Record 67044;
        ColegioNivel: Record 67036;
        Colegio: Record 5050;
    begin
        //Primero se verifican los valores actuales por si han
        //cambiado la ruta del Promotor
        Window.OPEN(Text003);
        PromListaCol.RESET;
        PromListaCol.SETRANGE("Cod. Promotor", CodPromotor);
        CounterTotal := PromListaCol.COUNT;
        Counter := 0;
        IF PromListaCol.FINDSET THEN
            REPEAT
                Counter := Counter + 1;
                Window.UPDATE(1, PromListaCol."Cod. Colegio");
                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

                ColegioNivel.RESET;
                ColegioNivel.SETRANGE("Cod. Colegio", PromListaCol."Cod. Colegio");
                ColegioNivel.SETRANGE(Ruta, RutaProm."Cod. Ruta");
                IF NOT ColegioNivel.FINDFIRST THEN
                    PromListaCol.DELETE;
            UNTIL PromListaCol.NEXT = 0;

        Window.CLOSE;

        //En seleccion de colegios  para visitas,
        //filtrar x ruta que esta amarrado al nivel del colegio
        Window.OPEN(Text001);
        RutaProm.RESET;
        RutaProm.SETRANGE("Cod. Promotor", CodPromotor);
        RutaProm.FINDSET;
        REPEAT
            ColegioNivel.RESET;
            ColegioNivel.SETRANGE(Ruta, RutaProm."Cod. Ruta");
            ColegioNivel.FINDSET;
            CounterTotal := ColegioNivel.COUNT;
            Counter := 0;
            REPEAT
                Counter := Counter + 1;
                Window.UPDATE(1, ColegioNivel."Cod. Colegio");
                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

                CLEAR(PromListaCol);
                Colegio.GET(ColegioNivel."Cod. Colegio");

                PromListaCol.VALIDATE("Cod. Promotor", CodPromotor);
                PromListaCol.VALIDATE("Cod. Colegio", ColegioNivel."Cod. Colegio");
                PromListaCol.VALIDATE("Cod. Ruta", ColegioNivel.Ruta);
                //Peru  PromListaCol."Distrito Code" := Colegio.City;
                //  PromListaCol.Distritos := Colegio.Departamento;
                IF PromListaCol.INSERT(TRUE) THEN;


            UNTIL ColegioNivel.NEXT = 0;
        UNTIL RutaProm.NEXT = 0;

        Window.CLOSE;
        MESSAGE(Text002);
    end;

    procedure InsertaAdopciones(CodCol: Code[20]; CodNivel: Code[20]; CodPromotor: Code[20]; CodTurno: Code[20])
    var
        AdopcionesD: Record 67053;
        HAdopciones: Record 67035;
        Item: Record 27;
        PptoPromotor: Record 67027;
        GradosCol: Record 67037;
        Editoriales: Record 67024;
        Nivel: Record 67022;
        DimVal: Record 349;
        DefDim: Record 352;
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
        Turnos: Page 67003;
    begin
        //MESSAGE('a%1 b%2 c%3 d%4 e%5',CodCol,CodNivel,CodPromotor,CodTurno);

        Editoriales.SETRANGE(Santillana, TRUE);
        Editoriales.FINDFIRST;

        PptoPromotor.RESET;
        PptoPromotor.SETRANGE("Cod. Promotor", CodPromotor);
        PptoPromotor.FINDSET;

        CounterTotal := PptoPromotor.COUNT;
        Window.OPEN(Text001);

        REPEAT
            Counter := Counter + 1;
            Window.UPDATE(1, PptoPromotor."Cod. Producto");
            Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

            Item.GET(PptoPromotor."Cod. Producto");
            Item.TESTFIELD("Nivel Educativo APS");
            Item.TESTFIELD("Nivel Escolar (Grado)");
            Item.TESTFIELD("Grupo de Negocio");

            IF STRPOS(CodNivel, Item."Nivel Educativo APS") <> 0 THEN BEGIN
                Nivel.GET(Item."Nivel Educativo APS");
                /*
                     IF Nivel."Verificacion cruzada" THEN
                        BEGIN
                          GradosCol.SETRANGE("Cod. Colegio",gCodCol);
                          GradosCol.SETRANGE("Cod. Turno",gCodTurno);
                     //     IF Item.Grado <> '' THEN
                        END
                     ELSE
                */

                CLEAR(GradosCol);
                GradosCol.SETRANGE("Cod. Colegio", CodCol);
                GradosCol.SETFILTER("Cod. Nivel", Item."Nivel Educativo APS");
                GradosCol.SETRANGE("Cod. Turno", CodTurno);
                GradosCol.SETRANGE("Cod. Grado", Item."Nivel Escolar (Grado)");
                IF GradosCol.FINDFIRST THEN;
                //      GradosCol.TESTFIELD("Cantidad Alumnos");

                HAdopciones.SETRANGE(Campana, FORMAT(APSSetup.Campana));
                HAdopciones.SETRANGE("Cod. Editorial", Editoriales.Code);
                HAdopciones.SETRANGE("Cod. Colegio", CodCol);
                HAdopciones.SETRANGE("Cod. Nivel", Item."Nivel Educativo APS");
                IF PptoPromotor."Cod. producto equivalente" <> '' THEN
                    HAdopciones.SETFILTER("Cod. producto", '%1|%2', '', PptoPromotor."Cod. producto equivalente")
                ELSE
                    HAdopciones.SETFILTER("Cod. producto", '%1|%2', '', PptoPromotor."Cod. Producto");
                HAdopciones.SETRANGE(Santillana, TRUE);
                IF HAdopciones.FINDLAST THEN BEGIN
                    CLEAR(AdopcionesD);
                    AdopcionesD.VALIDATE("Cod. Colegio", CodCol);
                    //     AdopcionesD.VALIDATE("Cod. Local",CodLocal);
                    AdopcionesD.VALIDATE("Cod. Nivel", Item."Nivel Educativo APS");
                    AdopcionesD.VALIDATE("Cod. Turno", CodTurno);
                    AdopcionesD.VALIDATE("Cod. Promotor", CodPromotor);
                    AdopcionesD.VALIDATE("Cod. Producto", PptoPromotor."Cod. Producto");
                    AdopcionesD."Cod. Grado" := Item."Nivel Escolar (Grado)";
                    AdopcionesD."Cantidad Alumnos" := GradosCol."Cantidad Alumnos";
                    AdopcionesD.VALIDATE(Seccion, GradosCol.Seccion);
                    AdopcionesD."Adopcion anterior" := HAdopciones.Adopcion;
                    AdopcionesD.VALIDATE("Grupo de Negocio", Item."Grupo de Negocio");
                    AdopcionesD.VALIDATE("Cantidad Alumnos", GradosCol."Cantidad Alumnos");
                    IF AdopcionesD.INSERT(TRUE) THEN;
                END
                ELSE BEGIN
                    CLEAR(AdopcionesD);
                    AdopcionesD.VALIDATE("Cod. Colegio", CodCol);
                    //      AdopcionesD.VALIDATE("Cod. Local",gCodLocal);
                    AdopcionesD.VALIDATE("Cod. Nivel", Item."Nivel Educativo APS");
                    AdopcionesD.VALIDATE("Cod. Turno", CodTurno);
                    AdopcionesD.VALIDATE("Cod. Promotor", CodPromotor);
                    AdopcionesD.VALIDATE("Cod. Producto", PptoPromotor."Cod. Producto");
                    //           AdopcionesD.VALIDATE("Cod. Editorial",Editoriales.Code);
                    AdopcionesD."Cod. Grado" := Item."Nivel Escolar (Grado)";
                    AdopcionesD."Cantidad Alumnos" := GradosCol."Cantidad Alumnos";
                    AdopcionesD.VALIDATE(Seccion, GradosCol.Seccion);
                    AdopcionesD.VALIDATE("Grupo de Negocio", Item."Grupo de Negocio");
                    AdopcionesD.VALIDATE("Cantidad Alumnos", GradosCol."Cantidad Alumnos");
                    IF AdopcionesD.INSERT(TRUE) THEN;
                END;
            END;
        UNTIL PptoPromotor.NEXT = 0;
        Window.CLOSE;

    end;
}

