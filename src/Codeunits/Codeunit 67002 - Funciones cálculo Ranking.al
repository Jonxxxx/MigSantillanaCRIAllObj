codeunit 67002 "Funciones cálculo Ranking"
{

    trigger OnRun()
    begin
    end;

    var
        gCamp: Code[4];
        gHist: Boolean;
        gTipo: Option General,CVM;
        gDeleg: Code[20];
        recColegio: Record 5050;
        Text001: Label 'Calculando Ranking General ... \ Colegio #1###################';
        Ventana: Dialog;
        gTipoReporte: Option Todos,Colegios,Nidos;
        gGNeg: Option General,Santillana,Richmond,"Plan Lector";
        Text002: Label 'Calculando Ranking CVM ... \ Colegio #1###################';
        gFecha: Date;

    procedure CalcRanking(var tTrabajo Record: 67094; parTipo: Option General,CVM; parCamp: Code[4]; parDeleg: Code[20]; parTipoReporte: Option Todos,Colegios,Nidos; parGNeg: Option General,Santillana,Richmond,"Plan Lector")
    begin

        gTipo := parTipo;
        gCamp := parCamp;
        gHist := EsCampHistorica;
        gDeleg := parDeleg;
        gTipoReporte := parTipoReporte;
        gGNeg := parGNeg;
        gFecha := TODAY;

        CASE gTipo OF
            gTipo::CVM:
                BEGIN
                    tTrabajo.SETRANGE(tTrabajo.Reporte, tTrabajo.Reporte::CVM);
                    tTrabajo.SETRANGE(tTrabajo.Campaña, gCamp);
                    IF gDeleg <> '' THEN
                        tTrabajo.SETRANGE(tTrabajo.Delegación, gDeleg);
                    tTrabajo.DELETEALL;
                    Ventana.OPEN(Text002);
                END;
            gTipo::General:
                BEGIN
                    tTrabajo.SETRANGE(tTrabajo.Reporte, tTrabajo.Reporte::General);
                    tTrabajo.SETRANGE(tTrabajo.Campaña, gCamp);
                    IF gDeleg <> '' THEN
                        tTrabajo.SETRANGE(tTrabajo.Delegación, gDeleg);
                    tTrabajo.DELETEALL;
                    Ventana.OPEN(Text001);
                END;
        END;

        recColegio.RESET;
        IF gDeleg <> '' THEN BEGIN
            recColegio.SETCURRENTKEY(Delegacion);
            recColegio.SETRANGE(Delegacion, gDeleg);
        END;
        IF recColegio.FINDSET THEN
            REPEAT
                Ventana.UPDATE(1, recColegio."No.");
                CASE gTipo OF
                    gTipo::General:
                        BEGIN
                            IF ValidaTipoReporte THEN
                                IF TieneAdopciones THEN
                                    InsertaTemporal(tTrabajo);
                        END;
                    gTipo::CVM:
                        BEGIN
                            IF ValidaTipoReporte THEN
                                IF EnCartera THEN
                                    InsertaTemporal(tTrabajo);
                        END;
                END;
            UNTIL recColegio.NEXT = 0;
        OrdenarTemporal(tTrabajo);
        Ventana.CLOSE;
    end;

    procedure TieneAdopciones() rtn: Boolean
    var
        recHistAdop Record: 67035;
        recAdop Record: 67053;
    begin

        IF gHist THEN BEGIN
            recHistAdop.RESET;
            recHistAdop.SETCURRENTKEY("Cod. Colegio", Campana, Adopcion, "Cod. Editorial", "Grupo de Negocio", "Linea de negocio");
            recHistAdop.SETFILTER(Adopcion, '%1|%2', recHistAdop.Adopcion::Conquista, recHistAdop.Adopcion::Mantener);
            recHistAdop.SETRANGE(Campana, gCamp);
            recHistAdop.SETRANGE("Cod. Colegio", recColegio."No.");
            rtn := recHistAdop.FINDFIRST;
        END
        ELSE BEGIN
            recAdop.RESET;
            recAdop.SETCURRENTKEY("Cod. Colegio", "Grupo de Negocio", "Cod. Grado", "Cod. Turno", "Cod. Promotor", "Cod. Producto");
            recAdop.SETRANGE("Cod. Colegio", recColegio."No.");
            recAdop.SETFILTER(Adopcion, '%1|%2', recAdop.Adopcion::Conquista, recAdop.Adopcion::Mantener);
            rtn := recAdop.FINDFIRST;
        END;
    end;

    procedure InsertaTemporal(var tTrabajo Record: 67094")
    begin

        tTrabajo.INIT;

        CASE gTipo OF
            gTipo::General:
                tTrabajo.Reporte := tTrabajo.Reporte::General;
            gTipo::CVM:
                tTrabajo.Reporte := tTrabajo.Reporte::CVM;
        END;
        tTrabajo.Campaña := gCamp;
        tTrabajo.FechaGen := gFecha;

        InsertaInfoColegio(tTrabajo);

        InsertaInfoCategorias(tTrabajo);

        InsertaInfoMontoBruto(tTrabajo);

        InsertaInfoMontoTotal(tTrabajo);

        InsertaInfoPorcxLinea(tTrabajo);

        tTrabajo.INSERT;
    end;

    procedure InsertaInfoCategorias(var tTrabajo Record: 67094")
    var
        recCategoria Record: 67091;
        recHistCategoria Record: 67093;
    begin

        IF NOT gHist THEN BEGIN
            recCategoria.SETRANGE("Cod. Colegio", recColegio."No.");
            IF recCategoria.FINDSET THEN
                REPEAT
                    CASE recCategoria."Grupo Negocio" OF
                        'SANTILLANA':
                            BEGIN
                                CASE recCategoria."Cod. Nivel" OF
                                    'GEN':
                                        tTrabajo."CVM TEXTO_GEN" := recCategoria.Categoria;
                                    'INI':
                                        tTrabajo."CVM TEXTO_INI" := recCategoria.Categoria;
                                    'PRI':
                                        tTrabajo."CVM TEXTO_PRI" := recCategoria.Categoria;
                                    'SEC':
                                        tTrabajo."CVM TEXTO_SEC" := recCategoria.Categoria;
                                END;
                            END;
                        'RICHMOND':
                            BEGIN
                                CASE recCategoria."Cod. Nivel" OF
                                    'GEN':
                                        tTrabajo.RICHMOND_GEN := recCategoria.Categoria;
                                    'INI':
                                        tTrabajo.RICHMOND_INI := recCategoria.Categoria;
                                    'PRI':
                                        tTrabajo.RICHMOND_PRI := recCategoria.Categoria;
                                    'SEC':
                                        tTrabajo.RICHMOND_SEC := recCategoria.Categoria;
                                END;
                            END;
                        'PLAN LECTOR':
                            BEGIN
                                CASE recCategoria."Cod. Nivel" OF
                                    'GEN':
                                        tTrabajo."PLAN LECTOR_GEN" := recCategoria.Categoria;
                                    'INI':
                                        tTrabajo."PLAN LECTOR_INI" := recCategoria.Categoria;
                                    'PRI':
                                        tTrabajo."PLAN LECTOR_PRI" := recCategoria.Categoria;
                                    'SEC':
                                        tTrabajo."PLAN LECTOR_SEC" := recCategoria.Categoria;
                                END;
                            END;
                        'SANTILLANA COMPARTIR':
                            BEGIN
                                CASE recCategoria."Cod. Nivel" OF
                                    'GEN':
                                        tTrabajo.COMPARTIR_GEN := recCategoria.Categoria;
                                    'INI':
                                        tTrabajo.COMPARTIR_INI := recCategoria.Categoria;
                                    'PRI':
                                        tTrabajo.COMPARTIR_PRI := recCategoria.Categoria;
                                    'SEC':
                                        tTrabajo.COMPARTIR_SEC := recCategoria.Categoria;
                                END;
                            END;
                        'GENERAL':
                            BEGIN
                                IF recCategoria."Cod. Nivel" = 'GEN' THEN
                                    tTrabajo."CVM GN" := recCategoria.Categoria;
                            END;
                    END;
                UNTIL recCategoria.NEXT = 0;
        END
        ELSE BEGIN
            recHistCategoria.RESET;
            recHistCategoria.SETRANGE(Campaña, gCamp);
            recHistCategoria.SETRANGE("Cod. Colegio", recColegio."No.");
            IF recHistCategoria.FINDSET THEN
                REPEAT
                    CASE recHistCategoria."Grupo Negocio" OF
                        'SANTILLANA':
                            BEGIN
                                CASE recHistCategoria."Cod. Nivel" OF
                                    'GEN':
                                        tTrabajo."CVM TEXTO_GEN" := recHistCategoria.Categoria;
                                    'INI':
                                        tTrabajo."CVM TEXTO_INI" := recHistCategoria.Categoria;
                                    'PRI':
                                        tTrabajo."CVM TEXTO_PRI" := recHistCategoria.Categoria;
                                    'SEC':
                                        tTrabajo."CVM TEXTO_SEC" := recHistCategoria.Categoria;
                                END;
                            END;
                        'RICHMOND':
                            BEGIN
                                CASE recHistCategoria."Cod. Nivel" OF
                                    'GEN':
                                        tTrabajo.RICHMOND_GEN := recHistCategoria.Categoria;
                                    'INI':
                                        tTrabajo.RICHMOND_INI := recHistCategoria.Categoria;
                                    'PRI':
                                        tTrabajo.RICHMOND_PRI := recHistCategoria.Categoria;
                                    'SEC':
                                        tTrabajo.RICHMOND_SEC := recHistCategoria.Categoria;
                                END;
                            END;
                        'PLAN LECTOR':
                            BEGIN
                                CASE recHistCategoria."Cod. Nivel" OF
                                    'GEN':
                                        tTrabajo."PLAN LECTOR_GEN" := recHistCategoria.Categoria;
                                    'INI':
                                        tTrabajo."PLAN LECTOR_INI" := recHistCategoria.Categoria;
                                    'PRI':
                                        tTrabajo."PLAN LECTOR_PRI" := recHistCategoria.Categoria;
                                    'SEC':
                                        tTrabajo."PLAN LECTOR_SEC" := recHistCategoria.Categoria;
                                END;
                            END;
                        'SANTILLANA COMPARTIR':
                            BEGIN
                                CASE recHistCategoria."Cod. Nivel" OF
                                    'GEN':
                                        tTrabajo.COMPARTIR_GEN := recHistCategoria.Categoria;
                                    'INI':
                                        tTrabajo.COMPARTIR_INI := recHistCategoria.Categoria;
                                    'PRI':
                                        tTrabajo.COMPARTIR_PRI := recHistCategoria.Categoria;
                                    'SEC':
                                        tTrabajo.COMPARTIR_SEC := recHistCategoria.Categoria;
                                END;
                            END;
                        'GENERAL':
                            BEGIN
                                IF recHistCategoria."Cod. Nivel" = 'GEN' THEN
                                    tTrabajo."CVM GN" := recHistCategoria.Categoria;
                            END;
                    END;
                UNTIL recHistCategoria.NEXT = 0;


        END;
    end;

    procedure InsertaInfoMontoBruto(var tTrabajo Record: 67094")
    var
        recHistAdop Record: 67035;
        recAdop Record: 67053;
    begin


        IF gHist THEN BEGIN

            recHistAdop.RESET;
            recHistAdop.SETCURRENTKEY("Cod. Colegio", Campana, Adopcion, "Cod. Editorial", "Grupo de Negocio", "Linea de negocio");
            recHistAdop.SETFILTER(Adopcion, '%1|%2', recHistAdop.Adopcion::Conquista, recHistAdop.Adopcion::Mantener);
            recHistAdop.SETRANGE(recHistAdop."Cod. Colegio", recColegio."No.");
            recHistAdop.SETRANGE(Campana, FORMAT(gCamp));

            IF (gGNeg = gGNeg::General) OR (gGNeg = gGNeg::Santillana) THEN BEGIN
                //INI
                recHistAdop.SETRANGE("Grupo de Negocio", 'SANTILLANA');
                recHistAdop.SETRANGE("Linea de negocio", '01_TEXTO');
                recHistAdop.SETRANGE("Item - Item Category Code", 'INI');
                recHistAdop.SETRANGE("Item - Product Group Code");
                IF recHistAdop.FINDSET THEN
                    REPEAT
                        recHistAdop.CALCFIELDS("Sales Price - Unit Price");
                        tTrabajo."MONTO BRUTO_INI" += (recHistAdop."Adopcion Real" * recHistAdop."Sales Price - Unit Price");
                    UNTIL recHistAdop.NEXT = 0;

                //PRI
                recHistAdop.SETRANGE("Grupo de Negocio", 'SANTILLANA');
                recHistAdop.SETRANGE("Linea de negocio", '01_TEXTO');
                recHistAdop.SETRANGE("Item - Item Category Code", 'PRI');
                recHistAdop.SETFILTER("Item - Product Group Code", '<>%1', 'LET');
                IF recHistAdop.FINDSET THEN
                    REPEAT
                        recHistAdop.CALCFIELDS("Sales Price - Unit Price");
                        tTrabajo."MONTO BRUTO_PRI" += (recHistAdop."Adopcion Real" * recHistAdop."Sales Price - Unit Price");
                    UNTIL recHistAdop.NEXT = 0;

                //SEC
                recHistAdop.SETRANGE("Grupo de Negocio", 'SANTILLANA');
                recHistAdop.SETRANGE("Linea de negocio", '01_TEXTO');
                recHistAdop.SETRANGE("Item - Item Category Code", 'SEC');
                recHistAdop.SETRANGE("Item - Product Group Code");
                IF recHistAdop.FINDSET THEN
                    REPEAT
                        recHistAdop.CALCFIELDS("Sales Price - Unit Price");
                        tTrabajo."MONTO BRUTO_SEC" += (recHistAdop."Adopcion Real" * recHistAdop."Sales Price - Unit Price");
                    UNTIL recHistAdop.NEXT = 0;

                //LETI
                recHistAdop.SETRANGE("Grupo de Negocio", 'SANTILLANA');
                recHistAdop.SETRANGE("Linea de negocio", '01_TEXTO');
                recHistAdop.SETRANGE("Item - Item Category Code", 'PRI');
                recHistAdop.SETRANGE("Item - Product Group Code", 'LET');
                IF recHistAdop.FINDSET THEN
                    REPEAT
                        recHistAdop.CALCFIELDS("Sales Price - Unit Price");
                        tTrabajo."MONTO BRUTO_LETI" += (recHistAdop."Adopcion Real" * recHistAdop."Sales Price - Unit Price");
                    UNTIL recHistAdop.NEXT = 0;

                //BIBL
                recHistAdop.SETRANGE("Grupo de Negocio", 'SANTILLANA');
                recHistAdop.SETRANGE("Linea de negocio", '01_TEXTO');
                recHistAdop.SETRANGE("Item - Item Category Code", 'BB');
                recHistAdop.SETRANGE("Item - Product Group Code");
                IF recHistAdop.FINDSET THEN
                    REPEAT
                        recHistAdop.CALCFIELDS("Sales Price - Unit Price");
                        tTrabajo."MONTO BRUTO_BIBL" += (recHistAdop."Adopcion Real" * recHistAdop."Sales Price - Unit Price");
                    UNTIL recHistAdop.NEXT = 0;
            END;

            IF (gGNeg = gGNeg::General) OR (gGNeg = gGNeg::Richmond) THEN BEGIN
                //ING
                recHistAdop.SETRANGE("Grupo de Negocio", 'RICHMOND');
                recHistAdop.SETRANGE("Linea de negocio", '02_IDIO_ING');
                recHistAdop.SETFILTER("Item - Item Category Code", '%1|%2|%3|%4', 'INI', 'PRI', 'SEC', 'SEI');
                recHistAdop.SETRANGE("Item - Product Group Code");
                IF recHistAdop.FINDSET THEN
                    REPEAT
                        recHistAdop.CALCFIELDS("Sales Price - Unit Price");
                        tTrabajo."MONTO BRUTO_ING" += (recHistAdop."Adopcion Real" * recHistAdop."Sales Price - Unit Price");
                    UNTIL recHistAdop.NEXT = 0;

                //READ
                recHistAdop.SETRANGE("Grupo de Negocio", 'RICHMOND');
                recHistAdop.SETRANGE("Linea de negocio", '02_IDIO_ING');
                recHistAdop.SETRANGE("Item - Item Category Code", 'VAR');
                recHistAdop.SETRANGE("Item - Product Group Code");
                IF recHistAdop.FINDSET THEN
                    REPEAT
                        recHistAdop.CALCFIELDS("Sales Price - Unit Price");
                        tTrabajo."MONTO BRUTO_READ" += (recHistAdop."Adopcion Real" * recHistAdop."Sales Price - Unit Price");
                    UNTIL recHistAdop.NEXT = 0;
            END;

            IF (gGNeg = gGNeg::General) OR (gGNeg = gGNeg::"Plan Lector") THEN BEGIN
                //PLA
                recHistAdop.SETRANGE("Grupo de Negocio", 'PLAN LECTOR');
                recHistAdop.SETRANGE("Linea de negocio");
                recHistAdop.SETRANGE("Item - Item Category Code");
                recHistAdop.SETRANGE("Item - Product Group Code");
                IF recHistAdop.FINDSET THEN
                    REPEAT
                        recHistAdop.CALCFIELDS("Sales Price - Unit Price");
                        tTrabajo."MONTO BRUTO_PLA" += (recHistAdop."Adopcion Real" * recHistAdop."Sales Price - Unit Price");
                    UNTIL recHistAdop.NEXT = 0;
            END;
        END
        ELSE BEGIN

            recAdop.RESET;
            recAdop.SETCURRENTKEY("Cod. Colegio", "Grupo de Negocio", "Cod. Grado", "Cod. Turno", "Cod. Promotor", "Cod. Producto");
            recAdop.SETRANGE("Cod. Colegio", recColegio."No.");
            recAdop.SETFILTER(Adopcion, '%1|%2', recAdop.Adopcion::Conquista, recAdop.Adopcion::Mantener);

            IF (gGNeg = gGNeg::General) OR (gGNeg = gGNeg::Santillana) THEN BEGIN
                //INI
                recAdop.SETRANGE("Grupo de Negocio", 'SANTILLANA');
                recAdop.SETRANGE("Linea de negocio", '01_TEXTO');
                recAdop.SETRANGE("Item - Item Category Code", 'INI');
                recAdop.SETRANGE("Item - Product Group Code");
                IF recAdop.FINDSET THEN
                    REPEAT
                        recAdop.CALCFIELDS("Sales Price - Unit Price");
                        tTrabajo."MONTO BRUTO_INI" += (recAdop."Adopcion Real" * recAdop."Sales Price - Unit Price");
                    UNTIL recAdop.NEXT = 0;
                //PRI
                recAdop.SETRANGE("Grupo de Negocio", 'SANTILLANA');
                recAdop.SETRANGE("Linea de negocio", '01_TEXTO');
                recAdop.SETRANGE("Item - Item Category Code", 'PRI');
                recAdop.SETFILTER("Item - Product Group Code", '<>%1', 'LET');
                IF recAdop.FINDSET THEN
                    REPEAT
                        recAdop.CALCFIELDS("Sales Price - Unit Price");
                        tTrabajo."MONTO BRUTO_PRI" += (recAdop."Adopcion Real" * recAdop."Sales Price - Unit Price");
                    UNTIL recAdop.NEXT = 0;

                //SEC
                recAdop.SETRANGE("Grupo de Negocio", 'SANTILLANA');
                recAdop.SETRANGE("Linea de negocio", '01_TEXTO');
                recAdop.SETRANGE("Item - Item Category Code", 'SEC');
                recAdop.SETRANGE("Item - Product Group Code");
                IF recAdop.FINDSET THEN
                    REPEAT
                        recAdop.CALCFIELDS("Sales Price - Unit Price");
                        tTrabajo."MONTO BRUTO_SEC" += (recAdop."Adopcion Real" * recAdop."Sales Price - Unit Price");
                    UNTIL recAdop.NEXT = 0;

                //LETI
                recAdop.SETRANGE("Grupo de Negocio", 'SANTILLANA');
                recAdop.SETRANGE("Linea de negocio", '01_TEXTO');
                recAdop.SETRANGE("Item - Item Category Code", 'PRI');
                recAdop.SETRANGE("Item - Product Group Code", 'LET');
                IF recAdop.FINDSET THEN
                    REPEAT
                        recAdop.CALCFIELDS("Sales Price - Unit Price");
                        tTrabajo."MONTO BRUTO_LETI" += (recAdop."Adopcion Real" * recAdop."Sales Price - Unit Price");
                    UNTIL recAdop.NEXT = 0;

                //BIBL
                recAdop.SETRANGE("Grupo de Negocio", 'SANTILLANA');
                recAdop.SETRANGE("Linea de negocio", '01_TEXTO');
                recAdop.SETRANGE("Item - Item Category Code", 'BB');
                recAdop.SETRANGE("Item - Product Group Code");
                IF recAdop.FINDSET THEN
                    REPEAT
                        recAdop.CALCFIELDS("Sales Price - Unit Price");
                        tTrabajo."MONTO BRUTO_BIBL" += (recAdop."Adopcion Real" * recAdop."Sales Price - Unit Price");
                    UNTIL recAdop.NEXT = 0;
            END;

            IF (gGNeg = gGNeg::General) OR (gGNeg = gGNeg::Richmond) THEN BEGIN
                //ING
                recAdop.SETRANGE("Grupo de Negocio", 'RICHMOND');
                recAdop.SETRANGE("Linea de negocio", '02_IDIO_ING');
                recAdop.SETFILTER("Item - Item Category Code", '%1|%2|%3|%4', 'INI', 'PRI', 'SEC', 'SEI');
                recAdop.SETRANGE("Item - Product Group Code");
                IF recAdop.FINDSET THEN
                    REPEAT
                        recAdop.CALCFIELDS("Sales Price - Unit Price");
                        tTrabajo."MONTO BRUTO_ING" += (recAdop."Adopcion Real" * recAdop."Sales Price - Unit Price");
                    UNTIL recAdop.NEXT = 0;

                //READ
                recAdop.SETRANGE("Grupo de Negocio", 'RICHMOND');
                recAdop.SETRANGE("Linea de negocio", '02_IDIO_ING');
                recAdop.SETRANGE("Item - Item Category Code", 'VAR');
                recAdop.SETRANGE("Item - Product Group Code");
                IF recAdop.FINDSET THEN
                    REPEAT
                        recAdop.CALCFIELDS("Sales Price - Unit Price");
                        tTrabajo."MONTO BRUTO_READ" += (recAdop."Adopcion Real" * recAdop."Sales Price - Unit Price");
                    UNTIL recAdop.NEXT = 0;
            END;

            IF (gGNeg = gGNeg::General) OR (gGNeg = gGNeg::"Plan Lector") THEN BEGIN
                //PLA
                recAdop.SETRANGE("Grupo de Negocio", 'PLAN LECTOR');
                recAdop.SETRANGE("Linea de negocio");
                recAdop.SETRANGE("Item - Item Category Code");
                recAdop.SETRANGE("Item - Product Group Code");
                IF recAdop.FINDSET THEN
                    REPEAT
                        recAdop.CALCFIELDS("Sales Price - Unit Price");
                        tTrabajo."MONTO BRUTO_PLA" += (recAdop."Adopcion Real" * recAdop."Sales Price - Unit Price");
                    UNTIL recAdop.NEXT = 0;
            END;

        END;

        //GEN

        tTrabajo."MONTO BRUTO_GENERAL" := tTrabajo."MONTO BRUTO_INI" + tTrabajo."MONTO BRUTO_PRI" +
                                             tTrabajo."MONTO BRUTO_SEC" + tTrabajo."MONTO BRUTO_ING" +
                                             tTrabajo."MONTO BRUTO_READ" + tTrabajo."MONTO BRUTO_PLA" +
                                             tTrabajo."MONTO BRUTO_LETI" + tTrabajo."MONTO BRUTO_DICC" +
                                             tTrabajo."MONTO BRUTO_BIBL";
    end;

    procedure EsCampHistorica() rtn: Boolean
    var
        recHistAdop Record: 67035;
    begin

        recHistAdop.RESET;
        recHistAdop.SETCURRENTKEY(Campana, "Cod. Colegio", "Linea de negocio");
        recHistAdop.SETRANGE(recHistAdop.Campana, gCamp);
        rtn := recHistAdop.FINDFIRST;
    end;

    procedure InsertaInfoMontoTotal(var tTrabajo Record: 67094")
    begin

        WITH tTrabajo DO BEGIN
            "MONTO TOTAL_ESPAÑOL" := "MONTO BRUTO_INI" + "MONTO BRUTO_PRI" + "MONTO BRUTO_SEC" +
                                          "MONTO BRUTO_DICC" + "MONTO BRUTO_BIBL";
            "MONTO TOTAL_INGLES" := "MONTO BRUTO_ING" + "MONTO BRUTO_READ";
            "MONTO TOTAL_PLAN LECTOR" := "MONTO BRUTO_PLA" + "MONTO BRUTO_LETI";
            "MONTO TOTAL_GENERAL" := "MONTO TOTAL_ESPAÑOL" + "MONTO TOTAL_INGLES" + "MONTO TOTAL_PLAN LECTOR";

        END;
    end;

    procedure InsertaInfoPorcxLinea(var tTrabajo Record: 67094")
    begin

        WITH tTrabajo DO BEGIN
            IF "MONTO TOTAL_GENERAL" <> 0 THEN BEGIN
                "PORC MONTO BRUTO_ESPAÑOL" := ROUND("MONTO TOTAL_ESPAÑOL" / "MONTO TOTAL_GENERAL" * 100, 1);
                "PORC MONTO BRUTO_INGLES" := ROUND("MONTO TOTAL_INGLES" / "MONTO TOTAL_GENERAL" * 100, 1);
                "PORC MONTO BRUTO_PLAN LECTOR" := ROUND("MONTO TOTAL_PLAN LECTOR" / "MONTO TOTAL_GENERAL" * 100, 1);
                "PORC MONTO BRUTO_GENERAL" := 100;
            END;
        END;
    end;

    procedure InsertaInfoColegio(var tTrabajo Record: 67094")
    var
        recColegioNivel Record: 67036;
        recHistColegioNivel Record: 67067;
    begin

        tTrabajo."Cod. Colegio" := recColegio."No.";
        tTrabajo."Nombre Colegio" := recColegio.Name;
        tTrabajo.Distrito := recColegio.Distritos;
        tTrabajo.Delegación := recColegio.Delegacion;
        //tTrabajo."Cod. Zona"  :=
        IF gTipo = gTipo::CVM THEN BEGIN
            IF TieneAdopciones THEN
                tTrabajo.Estado := tTrabajo.Estado::Usuario
            ELSE
                tTrabajo.Estado := tTrabajo.Estado::"No Usuario";
        END;

        IF EsNido THEN
            tTrabajo.Tipo := tTrabajo.Tipo::Nido
        ELSE
            tTrabajo.Tipo := tTrabajo.Tipo::Colegio;
    end;

    procedure OrdenarTemporal(var tTrabajo Record: 67094")
    var
        wCont: Integer;
    begin

        CLEAR(wCont);
        CASE gTipo OF
            gTipo::General:
                BEGIN
                    tTrabajo.SETCURRENTKEY(Reporte, Campaña, Delegación, "MONTO TOTAL_GENERAL");
                    tTrabajo.ASCENDING(FALSE)
                END;
            gTipo::CVM:
                tTrabajo.SETCURRENTKEY(Reporte, Campaña, Delegación, tTrabajo."CVM GN");
        END;
        IF tTrabajo.FINDFIRST THEN
            REPEAT
                wCont += 1;
                tTrabajo."No. Orden" := wCont;
                tTrabajo.MODIFY;
            UNTIL tTrabajo.NEXT = 0;
    end;

    procedure ValidaTipoReporte() rtn: Boolean
    var
        recColegioNivel Record: 67036;
        recHistColegioNivel Record: 67067;
    begin

        CASE gTipoReporte OF
            gTipoReporte::Todos:
                rtn := TRUE;
            gTipoReporte::Colegios:
                rtn := NOT (EsNido);
            gTipoReporte::Nidos:
                rtn := EsNido;
        END;
    end;

    procedure EnCartera() rtn: Boolean
    var
        recHistColNivel Record: 67067;
        recColNivel Record: 67036;
    begin

        IF gHist THEN BEGIN
            recHistColNivel.RESET;
            recHistColNivel.SETRANGE(Campana, gCamp);
            recHistColNivel.SETRANGE("Cod. Colegio", recColegio."No.");
            recHistColNivel.SETFILTER(Ruta, '<>%1&<>%2&<>%3&<>%4&<>%5', '199', '299', '399', '499', '799');
            rtn := recHistColNivel.FINDFIRST;
        END
        ELSE BEGIN
            recColNivel.RESET;
            recColNivel.SETRANGE("Cod. Colegio", recColegio."No.");
            recColNivel.SETFILTER(Ruta, '<>%1&<>%2&<>%3&<>%4&<>%5', '199', '299', '399', '499', '799');
            rtn := recColNivel.FINDFIRST;
        END;
    end;

    procedure EsNido() rtn: Boolean
    var
        recColegioNivel Record: 67036;
        recHistColegioNivel Record: 67067;
    begin

        rtn := FALSE;
        IF gHist THEN BEGIN
            recHistColegioNivel.RESET;
            recHistColegioNivel.SETCURRENTKEY(Campana, "Cod. Colegio", "Cod. Nivel", Turno, Ruta);
            recHistColegioNivel.SETRANGE(Campana, FORMAT(gCamp));
            recHistColegioNivel.SETRANGE("Cod. Colegio", recColegio."No.");
            IF recHistColegioNivel.FINDSET THEN BEGIN
                IF (recHistColegioNivel.COUNT = 1) THEN BEGIN
                    IF (recHistColegioNivel."Cod. Nivel" = 'INI') THEN
                        rtn := TRUE;
                END
                ELSE BEGIN
                    recHistColegioNivel.SETRANGE("Cod. Nivel", 'INI');
                    IF recHistColegioNivel.FINDSET THEN BEGIN
                        recHistColegioNivel.SETRANGE("Cod. Nivel", 'PRI');
                        IF NOT recHistColegioNivel.FINDSET THEN BEGIN
                            recHistColegioNivel.SETFILTER("Cod. Nivel", '<>%1', 'INI');
                            recHistColegioNivel.SETFILTER(Ruta, '<>%1&<>%2&<>%3&<>%4&<>%5', '199', '299', '399', '499', '799');
                            IF NOT recHistColegioNivel.FINDSET THEN
                                rtn := TRUE;
                        END;
                    END;
                END;
            END;
        END
        ELSE BEGIN
            recColegioNivel.RESET;
            recColegioNivel.SETRANGE("Cod. Colegio", recColegio."No.");
            IF recColegioNivel.FINDSET THEN BEGIN
                IF (recColegioNivel.COUNT = 1) THEN BEGIN
                    IF (recColegioNivel."Cod. Nivel" = 'INI') THEN
                        rtn := TRUE;
                END
                ELSE BEGIN
                    recColegioNivel.SETRANGE("Cod. Nivel", 'INI');
                    IF recColegioNivel.FINDSET THEN BEGIN
                        recColegioNivel.SETRANGE("Cod. Nivel", 'PRI');
                        IF NOT recColegioNivel.FINDSET THEN BEGIN
                            recColegioNivel.SETFILTER("Cod. Nivel", '<>%1', 'INI');
                            recColegioNivel.SETFILTER(Ruta, '<>%1&<>%2&<>%3&<>%4&<>%5', '199', '299', '399', '499', '799');
                            IF NOT recColegioNivel.FINDSET THEN
                                rtn := TRUE;
                        END;
                    END;
                END;
            END;
        END;
    end;
}

