page 67111 "Adopciones - Colegio - MRK"
{
    Caption = 'School - Adoptions';
    DataCaptionFields = "Cod. Colegio", "Cod. Docente";
    PageType = Card;
    SourceTable = 67058;
    SourceTableView = SORTING("Cod. Docente", "Cod. Colegio", "Cod. Local", "Cod. Producto");

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Producto"; "Cod. Producto")
                {
                    Editable = false;
                }
                field("Descripcion producto"; "Descripcion producto")
                {
                    Editable = false;
                }
                field("Edicion Coleccion"; "Edicion Coleccion")
                {
                }
                field(t2INI; t2INI)
                {
                    AssistEdit = true;
                    Caption = '2INI';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF "Marca Adopcion - 2INI" = "Adopcion - 2INI" THEN
                            "Marca Adopcion - 2INI" := 0
                        ELSE
                            "Marca Adopcion - 2INI" := "Adopcion - 2INI";
                    end;
                }
                field("Marca Adopcion - 2INI"; "Marca Adopcion - 2INI")
                {
                    Editable = false;
                }
                field(t3INI; t3INI)
                {
                    Caption = '3INI';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF "Marca Adopcion - 3INI" = "Adopcion - 3INI" THEN
                            "Marca Adopcion - 3INI" := 0
                        ELSE
                            "Marca Adopcion - 3INI" := "Adopcion - 3INI";
                    end;
                }
                field("Marca Adopcion - 3INI"; "Marca Adopcion - 3INI")
                {
                    Editable = false;
                }
                field(t4INI; t4INI)
                {
                    Caption = '4INI';
                    Editable = false;
                    //TODO: Ver OptionCaption = ' ,Conquest,Keep,Lost,Retired';

                    trigger OnAssistEdit()
                    begin
                        IF "Marca Adopcion - 4INI" = "Adopcion - 4INI" THEN
                            "Marca Adopcion - 4INI" := 0
                        ELSE
                            "Marca Adopcion - 4INI" := "Adopcion - 4INI";
                    end;
                }
                field("Marca Adopcion - 4INI"; "Marca Adopcion - 4INI")
                {
                    Editable = false;
                }
                field(t5INI; t5INI)
                {
                    Caption = '5INI';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF "Marca Adopcion - 5INI" = "Adopcion - 5INI" THEN
                            "Marca Adopcion - 5INI" := 0
                        ELSE
                            "Marca Adopcion - 5INI" := "Adopcion - 5INI";
                    end;
                }
                field("Marca Adopcion - 5INI"; "Marca Adopcion - 5INI")
                {
                    Editable = false;
                }
                field(t1PRI; t1PRI)
                {
                    Caption = '1PRI';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF "Marca Adopcion - 1PRI" = "Adopcion - 1PRI" THEN
                            "Marca Adopcion - 1PRI" := 0
                        ELSE
                            "Marca Adopcion - 1PRI" := "Adopcion - 1PRI";
                    end;
                }
                field("Marca Adopcion - 1PRI"; "Marca Adopcion - 1PRI")
                {
                    Editable = false;
                }
                field(t2PRI; t2PRI)
                {
                    Caption = '2PRI';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF "Marca Adopcion - 2PRI" = "Adopcion - 2PRI" THEN
                            "Marca Adopcion - 2PRI" := 0
                        ELSE
                            "Marca Adopcion - 2PRI" := "Adopcion - 2PRI";
                    end;
                }
                field("Marca Adopcion - 2PRI"; "Marca Adopcion - 2PRI")
                {
                    Editable = false;
                }
                field(t3PRI; t3PRI)
                {
                    Caption = '3PRI';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF "Marca Adopcion - 3PRI" = "Adopcion - 3PRI" THEN
                            "Marca Adopcion - 3PRI" := 0
                        ELSE
                            "Marca Adopcion - 3PRI" := "Adopcion - 3PRI";
                    end;
                }
                field("Marca Adopcion - 3PRI"; "Marca Adopcion - 3PRI")
                {
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF "Marca Adopcion - 3PRI" = "Adopcion - 3PRI" THEN
                            "Marca Adopcion - 3PRI" := 0
                        ELSE
                            "Marca Adopcion - 3PRI" := "Adopcion - 3PRI";
                    end;
                }
                field(t4PRI; t4PRI)
                {
                    Caption = '4PRI';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF "Marca Adopcion - 4PRI" = "Adopcion - 4PRI" THEN
                            "Marca Adopcion - 4PRI" := 0
                        ELSE
                            "Marca Adopcion - 4PRI" := "Adopcion - 4PRI";
                    end;
                }
                field("Marca Adopcion - 4PRI"; "Marca Adopcion - 4PRI")
                {
                    Editable = false;
                }
                field(t5PRI; t5PRI)
                {
                    Caption = '5PRI';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF "Marca Adopcion - 5PRI" = "Adopcion - 5PRI" THEN
                            "Marca Adopcion - 5PRI" := 0
                        ELSE
                            "Marca Adopcion - 5PRI" := "Adopcion - 5PRI";
                    end;
                }
                field("Marca Adopcion - 5PRI"; "Marca Adopcion - 5PRI")
                {
                    Editable = false;
                }
                field(t6PRI; t6PRI)
                {
                    Caption = '6PRI';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF "Marca Adopcion - 6PRI" = "Adopcion - 6PRI" THEN
                            "Marca Adopcion - 6PRI" := 0
                        ELSE
                            "Marca Adopcion - 6PRI" := "Adopcion - 6PRI";
                    end;
                }
                field("Marca Adopcion - 6PRI"; "Marca Adopcion - 6PRI")
                {
                    Editable = false;
                }
                field(t1SEC; t1SEC)
                {
                    Caption = '1SEC';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF "Marca Adopcion - 1SEC" = "Adopcion - 1SEC" THEN
                            "Marca Adopcion - 1SEC" := 0
                        ELSE
                            "Marca Adopcion - 1SEC" := "Adopcion - 1SEC";
                    end;
                }
                field("Marca Adopcion - 1SEC"; "Marca Adopcion - 1SEC")
                {
                    Editable = false;
                }
                field(t2SEC; t2SEC)
                {
                    Caption = '2SEC';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF "Marca Adopcion - 2SEC" = "Adopcion - 2SEC" THEN
                            "Marca Adopcion - 2SEC" := 0
                        ELSE
                            "Marca Adopcion - 2SEC" := "Adopcion - 2SEC";
                    end;
                }
                field("Marca Adopcion - 2SEC"; "Marca Adopcion - 2SEC")
                {
                    Editable = false;
                }
                field(t3SEC; t3SEC)
                {
                    Caption = '3SEC';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF "Marca Adopcion - 3SEC" = "Adopcion - 3SEC" THEN
                            "Marca Adopcion - 3SEC" := 0
                        ELSE
                            "Marca Adopcion - 3SEC" := "Adopcion - 3SEC";
                    end;
                }
                field("Marca Adopcion - 3SEC"; "Marca Adopcion - 3SEC")
                {
                    Editable = false;
                }
                field(t4SEC; t4SEC)
                {
                    Caption = '4SEC';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF "Marca Adopcion - 4SEC" = "Adopcion - 4SEC" THEN
                            "Marca Adopcion - 4SEC" := 0
                        ELSE
                            "Marca Adopcion - 4SEC" := "Adopcion - 4SEC";
                    end;
                }
                field("Marca Adopcion - 4SEC"; "Marca Adopcion - 4SEC")
                {
                    Editable = false;
                }
                field(t5SEC; t5SEC)
                {
                    Caption = '5SEC';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF "Marca Adopcion - 5SEC" = "Adopcion - 5SEC" THEN
                            "Marca Adopcion - 5SEC" := 0
                        ELSE
                            "Marca Adopcion - 5SEC" := "Adopcion - 5SEC";
                    end;
                }
                field("Marca Adopcion - 5SEC"; "Marca Adopcion - 5SEC")
                {
                    Editable = false;
                }
                field(t1SEI; t1SEI)
                {
                    Caption = '1SEI';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF "Marca Adopcion - 1SEI" = "Adopcion - 1SEI" THEN
                            "Marca Adopcion - 1SEI" := 0
                        ELSE
                            "Marca Adopcion - 1SEI" := "Adopcion - 1SEI";
                    end;
                }
                field("Marca Adopcion - 1SEI"; "Marca Adopcion - 1SEI")
                {
                    Editable = false;
                }
                field(t2SEI; t2SEI)
                {
                    Caption = '2SEI';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF "Marca Adopcion - 2SEI" = "Adopcion - 2SEI" THEN
                            "Marca Adopcion - 2SEI" := 0
                        ELSE
                            "Marca Adopcion - 2SEI" := "Adopcion - 2SEI";
                    end;
                }
                field("Marca Adopcion - 2SEI"; "Marca Adopcion - 2SEI")
                {
                    Editable = false;
                }
                field(t3SEI; t3SEI)
                {
                    Caption = '3SEI';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF "Marca Adopcion - 3SEI" = "Adopcion - 3SEI" THEN
                            "Marca Adopcion - 3SEI" := 0
                        ELSE
                            "Marca Adopcion - 3SEI" := "Adopcion - 3SEI";
                    end;
                }
                field("Marca Adopcion - 3SEI"; "Marca Adopcion - 3SEI")
                {
                    Editable = false;
                }
                field(t4SEI; t4SEI)
                {
                    Caption = '4SEI';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF "Marca Adopcion - 4SEI" = "Adopcion - 4SEI" THEN
                            "Marca Adopcion - 4SEI" := 0
                        ELSE
                            "Marca Adopcion - 4SEI" := "Adopcion - 4SEI";
                    end;
                }
                field("Marca Adopcion - 4SEI"; "Marca Adopcion - 4SEI")
                {
                    Editable = false;
                }
                field(t1VA; t1VA)
                {
                    Caption = '1VA';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF "Marca Adopcion - 1VA" = "Adopcion - 1VA" THEN
                            "Marca Adopcion - 1VA" := 0
                        ELSE
                            "Marca Adopcion - 1VA" := "Adopcion - 1VA";
                    end;
                }
                field("Marca Adopcion - 1VA"; "Marca Adopcion - 1VA")
                {
                    Editable = false;
                }
                field(t2VA; t2VA)
                {
                    Caption = '2VA';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF "Marca Adopcion - 2VA" = "Adopcion - 2VA" THEN
                            "Marca Adopcion - 2VA" := 0
                        ELSE
                            "Marca Adopcion - 2VA" := "Adopcion - 2VA";
                    end;
                }
                field("Marca Adopcion - 2VA"; "Marca Adopcion - 2VA")
                {
                    Editable = false;
                }
                field(t3VA; t3VA)
                {
                    Caption = '3VA';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF "Marca Adopcion - 3VA" = "Adopcion - 3VA" THEN
                            "Marca Adopcion - 3VA" := 0
                        ELSE
                            "Marca Adopcion - 3VA" := "Adopcion - 3VA";
                    end;
                }
                field("Marca Adopcion - 3VA"; "Marca Adopcion - 3VA")
                {
                    Editable = false;
                }
                field(t4VA; t4VA)
                {
                    Caption = '4VA';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF "Marca Adopcion - 4VA" = "Adopcion - 4VA" THEN
                            "Marca Adopcion - 4VA" := 0
                        ELSE
                            "Marca Adopcion - 4VA" := "Adopcion - 4VA";
                    end;
                }
                field("Marca Adopcion - 4VA"; "Marca Adopcion - 4VA")
                {
                    Editable = false;
                }
                field(t5VA; t5VA)
                {
                    Caption = '5VA';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF "Marca Adopcion - 5VA" = "Adopcion - 5VA" THEN
                            "Marca Adopcion - 5VA" := 0
                        ELSE
                            "Marca Adopcion - 5VA" := "Adopcion - 5VA";
                    end;
                }
                field("Marca Adopcion - 5VA"; "Marca Adopcion - 5VA")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        t2INI := FORMAT("Adopcion - 2INI");
        t3INI := FORMAT("Adopcion - 3INI");
        t4INI := FORMAT("Adopcion - 4INI");
        t5INI := FORMAT("Adopcion - 5INI");
        t1PRI := FORMAT("Adopcion - 1PRI");
        t2PRI := FORMAT("Adopcion - 2PRI");
        t3PRI := FORMAT("Adopcion - 3PRI");
        t4PRI := FORMAT("Adopcion - 4PRI");
        t5PRI := FORMAT("Adopcion - 5PRI");
        t6PRI := FORMAT("Adopcion - 6PRI");
        t1SEC := FORMAT("Adopcion - 1SEC");
        t2SEC := FORMAT("Adopcion - 2SEC");
        t3SEC := FORMAT("Adopcion - 3SEC");
        t4SEC := FORMAT("Adopcion - 4SEC");
        t5SEC := FORMAT("Adopcion - 5SEC");
        t1SEI := FORMAT("Adopcion - 1SEI");
        t2SEI := FORMAT("Adopcion - 2SEI");
        t3SEI := FORMAT("Adopcion - 3SEI");
        t4SEI := FORMAT("Adopcion - 4SEI");
        t1VA := FORMAT("Adopcion - 1VA");
        t2VA := FORMAT("Adopcion - 2VA");
        t3VA := FORMAT("Adopcion - 3VA");
        t4VA := FORMAT("Adopcion - 4VA");
        t5VA := FORMAT("Adopcion - 5VA");
    end;

    trigger OnOpenPage()
    begin
        SETRANGE("Cod. Colegio", gCodColegio);
        SETRANGE("Cod. Docente", gCodDocente);
    end;

    var
        ConfAPS: Record 67000;
        Item: Record 27;
        DefDim: Record 352;
        TextoEncabezado: array[30] of Text[30];
        DimValue: Text[60];
        i: Integer;
        gCodDocente: Code[20];
        gCodColegio: Code[20];
        t2INI: Text[30];
        t3INI: Text[30];
        t4INI: Text[30];
        t5INI: Text[30];
        t1PRI: Text[30];
        t2PRI: Text[30];
        t3PRI: Text[30];
        t4PRI: Text[30];
        t5PRI: Text[30];
        t6PRI: Text[30];
        t1SEC: Text[30];
        t2SEC: Text[30];
        t3SEC: Text[30];
        t4SEC: Text[30];
        t5SEC: Text[30];
        t1SEI: Text[30];
        t2SEI: Text[30];
        t3SEI: Text[30];
        t4SEI: Text[30];
        t1VA: Text[30];
        t2VA: Text[30];
        t3VA: Text[30];
        t4VA: Text[30];
        t5VA: Text[30];

    procedure RecibeParametros(CodDoc: Code[20]; CodCol: Code[20])
    var
        ColAdopDetalle: Record 67053;
        Grados: Record 67002;
    begin
        gCodColegio := CodCol;
        gCodDocente := CodDoc;
        ConfAPS.GET();
        ConfAPS.TESTFIELD("Dim para Estad. Adopciones");
        i := 0;

        DimValue := ' ';
        Grados.RESET;
        Grados.SETRANGE("Tipo registro", Grados."Tipo registro"::Grados);
        Grados.FIND('-');
        REPEAT
            i += 1;
            TextoEncabezado[i] := Grados.Codigo;
        UNTIL Grados.NEXT = 0;


        ColAdopDetalle.RESET;
        ColAdopDetalle.SETCURRENTKEY("Cod. Colegio", "Linea de negocio", Familia, "Sub Familia", Serie, "Grupo de Negocio");
        ColAdopDetalle.SETRANGE("Cod. Colegio", CodCol);
        ColAdopDetalle.SETFILTER(Adopcion, '<>%1', 0);
        //ColAdopDetalle.SETRANGE("Cod. Nivel",CodNivel);
        //ColAdopDetalle.SETRANGE("Cod. Turno",CodTurno);
        //ColAdopDetalle.SETRANGE("Cod. Grado",CodGrado);
        ColAdopDetalle.FINDSET;
        REPEAT
            /*
              IF ConfAPS."Dim para Estad. Adopciones" = ConfAPS."Cod. Dimension Lin. Negocio" THEN
                 BEGIN
                  IF ColAdopDetalle."Linea de negocio" <> DimValue THEN
                     BEGIN
                      INIT;
                      DimValue := ColAdopDetalle."Linea de negocio";
                     END;
                 END
              ELSE
              IF ConfAPS."Dim para Estad. Adopciones" = ConfAPS."Cod. Dimension Familia" THEN
                 BEGIN
                  IF ColAdopDetalle.Familia <> DimValue THEN
                     BEGIN
                      INIT;
                      DimValue := ColAdopDetalle.Familia;
                     END;
                 END
              ELSE
              IF ConfAPS."Dim para Estad. Adopciones" = ConfAPS."Cod. Dimension Sub Familia" THEN
                 BEGIN
                  IF ColAdopDetalle."Sub Familia" <> DimValue THEN
                     BEGIN
                      INIT;
                      DimValue := ColAdopDetalle."Sub Familia";
                     END;
                 END
              ELSE
              IF ConfAPS."Dim para Estad. Adopciones" = ConfAPS."Cod. Dimension Serie" THEN
                 BEGIN
                  IF ColAdopDetalle.Serie <> DimValue THEN
                     BEGIN
                      INIT;
                      DimValue := ColAdopDetalle.Serie;
                     END;
                 END;
            */
            IF NOT GET(CodDoc, CodCol, ColAdopDetalle."Cod. Local", ColAdopDetalle."Cod. Producto") THEN
                INIT;

            "Cod. Docente" := CodDoc;
            "Cod. Colegio" := ColAdopDetalle."Cod. Colegio";
            "Cod. Nivel" := ColAdopDetalle."Cod. Nivel";
            "Cod. Grado" := ColAdopDetalle."Cod. Grado";
            "Cod. Turno" := ColAdopDetalle."Cod. Turno";
            "Linea de negocio" := ColAdopDetalle."Linea de negocio";
            Familia := ColAdopDetalle.Familia;
            "Sub Familia" := DimValue;
            Serie := ColAdopDetalle.Serie;
            //"Cod. Editorial"   := ColAdopDetalle."Cod. Editorial";
            "Cod. Local" := ColAdopDetalle."Cod. Local";
            "Cod. Promotor" := ColAdopDetalle."Cod. Promotor";
            "Cod. Producto" := ColAdopDetalle."Cod. Producto";
            Item.GET("Cod. Producto");

            DefDim.RESET;
            DefDim.SETRANGE("Table ID", 27);
            DefDim.SETRANGE("No.", "Cod. Producto");
            DefDim.SETRANGE("Dimension Code", 'EDICION_COLECCION');
            IF DefDim.FINDFIRST THEN
                "Edicion Coleccion" := DefDim."Dimension Value Code";

            "Descripcion producto" := Item.Description;
            IF FIELDCAPTION("2INI") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                "Adopcion - 2INI" := ColAdopDetalle.Adopcion;
            END
            ELSE
                IF FIELDCAPTION("3INI") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                    "Adopcion - 3INI" := ColAdopDetalle.Adopcion;
                END
                ELSE
                    IF FIELDCAPTION("4INI") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                        "Adopcion - 4INI" := ColAdopDetalle.Adopcion;
                    END
                    ELSE
                        IF FIELDCAPTION("5INI") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                            "Adopcion - 5INI" := ColAdopDetalle.Adopcion;
                        END
                        ELSE
                            IF FIELDCAPTION("1PRI") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                "Adopcion - 1PRI" := ColAdopDetalle.Adopcion;
                            END
                            ELSE
                                IF FIELDCAPTION("2PRI") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                    "Adopcion - 2PRI" := ColAdopDetalle.Adopcion;
                                END
                                ELSE
                                    IF FIELDCAPTION("3PRI") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                        "Adopcion - 3PRI" := ColAdopDetalle.Adopcion;
                                    END
                                    ELSE
                                        IF FIELDCAPTION("4PRI") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                            "Adopcion - 4PRI" := ColAdopDetalle.Adopcion;
                                        END
                                        ELSE
                                            IF FIELDCAPTION("5PRI") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                                "Adopcion - 5PRI" := ColAdopDetalle.Adopcion;
                                            END
                                            ELSE
                                                IF FIELDCAPTION("6PRI") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                                    "Adopcion - 6PRI" := ColAdopDetalle.Adopcion;
                                                END
                                                ELSE
                                                    IF FIELDCAPTION("1SEC") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                                        "Adopcion - 1SEC" := ColAdopDetalle.Adopcion;
                                                    END
                                                    ELSE
                                                        IF FIELDCAPTION("2SEC") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                                            "Adopcion - 2SEC" := ColAdopDetalle.Adopcion;
                                                        END
                                                        ELSE
                                                            IF FIELDCAPTION("3SEC") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                                                "Adopcion - 3SEC" := ColAdopDetalle.Adopcion;
                                                            END
                                                            ELSE
                                                                IF FIELDCAPTION("4SEC") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                                                    "Adopcion - 4SEC" := ColAdopDetalle.Adopcion;
                                                                END
                                                                ELSE
                                                                    IF FIELDCAPTION("5SEC") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                                                        "Adopcion - 5SEC" := ColAdopDetalle.Adopcion;
                                                                    END
                                                                    ELSE
                                                                        IF FIELDCAPTION("1SEI") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                                                            "Adopcion - 1SEI" := ColAdopDetalle.Adopcion;
                                                                        END
                                                                        ELSE
                                                                            IF FIELDCAPTION("2SEI") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                                                                "Adopcion - 2SEI" := ColAdopDetalle.Adopcion;
                                                                            END
                                                                            ELSE
                                                                                IF FIELDCAPTION("3SEI") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                                                                    "Adopcion - 3SEI" := ColAdopDetalle.Adopcion;
                                                                                END
                                                                                ELSE
                                                                                    IF FIELDCAPTION("4SEI") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                                                                        "Adopcion - 4SEI" := ColAdopDetalle.Adopcion;
                                                                                    END
                                                                                    ELSE
                                                                                        IF FIELDCAPTION("1VA") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                                                                            "Adopcion - 1VA" := ColAdopDetalle.Adopcion;
                                                                                        END
                                                                                        ELSE
                                                                                            IF FIELDCAPTION("2VA") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                                                                                "Adopcion - 2VA" := ColAdopDetalle.Adopcion;
                                                                                            END
                                                                                            ELSE
                                                                                                IF FIELDCAPTION("3VA") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                                                                                    "Adopcion - 3VA" := ColAdopDetalle.Adopcion;
                                                                                                END
                                                                                                ELSE
                                                                                                    IF FIELDCAPTION("4VA") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                                                                                        "Adopcion - 4VA" := ColAdopDetalle.Adopcion;
                                                                                                    END
                                                                                                    ELSE
                                                                                                        IF FIELDCAPTION("5VA") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                                                                                            "Adopcion - 5VA" := ColAdopDetalle.Adopcion;
                                                                                                        END;

            IF NOT INSERT THEN
                MODIFY;
        UNTIL ColAdopDetalle.NEXT = 0;

    end;
}

