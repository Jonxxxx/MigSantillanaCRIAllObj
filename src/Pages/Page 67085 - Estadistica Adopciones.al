page 67085 "Estadistica Adopciones"
{
    Editable = false;
    PageType = Card;
    SourceTable = 55480;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Sub Familia"; Rec."Sub Familia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sub Familia';
                    Caption = 'Value';
                }
                field("Adopcion - 2INI"; Rec."Adopcion - 2INI")
                {
                    ApplicationArea = All;
                    ToolTip = 'Adopcion - 2INI';
                }
                field("Adopcion - 3INI"; Rec."Adopcion - 3INI")
                {
                    ApplicationArea = All;
                    ToolTip = 'Adopcion - 3INI';
                }
                field("Adopcion - 4INI"; Rec."Adopcion - 4INI")
                {
                    ApplicationArea = All;
                    ToolTip = 'Adopcion - 4INI';
                }
                field("Adopcion - 5INI"; Rec."Adopcion - 5INI")
                {
                    ApplicationArea = All;
                    ToolTip = 'Adopcion - 5INI';
                }
                field("Adopcion - 1PRI"; Rec."Adopcion - 1PRI")
                {
                    ApplicationArea = All;
                    ToolTip = 'Adopcion - 1PRI';
                }
                field("Adopcion - 2PRI"; Rec."Adopcion - 2PRI")
                {
                    ApplicationArea = All;
                    ToolTip = 'Adopcion - 2PRI';
                }
                field("Adopcion - 3PRI"; Rec."Adopcion - 3PRI")
                {
                    ApplicationArea = All;
                    ToolTip = 'Adopcion - 3PRI';
                }
                field("Adopcion - 4PRI"; Rec."Adopcion - 4PRI")
                {
                    ApplicationArea = All;
                    ToolTip = 'Adopcion - 4PRI';
                }
                field("Adopcion - 5PRI"; Rec."Adopcion - 5PRI")
                {
                    ApplicationArea = All;
                    ToolTip = 'Adopcion - 5PRI';
                }
                field("Adopcion - 6PRI"; Rec."Adopcion - 6PRI")
                {
                    ApplicationArea = All;
                    ToolTip = 'Adopcion - 6PRI';
                }
                field("Adopcion - 1SEC"; Rec."Adopcion - 1SEC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Adopcion - 1SEC';
                }
                field("Adopcion - 2SEC"; Rec."Adopcion - 2SEC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Adopcion - 2SEC';
                }
                field("Adopcion - 3SEC"; Rec."Adopcion - 3SEC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Adopcion - 3SEC';
                }
                field("Adopcion - 4SEC"; Rec."Adopcion - 4SEC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Adopcion - 4SEC';
                }
                field("Adopcion - 5SEC"; Rec."Adopcion - 5SEC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Adopcion - 5SEC';
                }
                field("Adopcion - 1SEI"; Rec."Adopcion - 1SEI")
                {
                    ApplicationArea = All;
                    ToolTip = 'Adopcion - 1SEI';
                }
                field("Adopcion - 2SEI"; Rec."Adopcion - 2SEI")
                {
                    ApplicationArea = All;
                    ToolTip = 'Adopcion - 2SEI';
                }
                field("Adopcion - 3SEI"; Rec."Adopcion - 3SEI")
                {
                    ApplicationArea = All;
                    ToolTip = 'Adopcion - 3SEI';
                }
                field("Adopcion - 4SEI"; Rec."Adopcion - 4SEI")
                {
                    ApplicationArea = All;
                    ToolTip = 'Adopcion - 4SEI';
                }
                field("Adopcion - 1VA"; Rec."Adopcion - 1VA")
                {
                    ApplicationArea = All;
                    ToolTip = 'Adopcion - 1VA';
                }
                field("Adopcion - 2VA"; Rec."Adopcion - 2VA")
                {
                    ApplicationArea = All;
                    ToolTip = 'Adopcion - 2VA';
                }
                field("Adopcion - 3VA"; Rec."Adopcion - 3VA")
                {
                    ApplicationArea = All;
                    ToolTip = 'Adopcion - 3VA';
                }
                field("Adopcion - 4VA"; Rec."Adopcion - 4VA")
                {
                    ApplicationArea = All;
                    ToolTip = 'Adopcion - 4VA';
                }
                field("Adopcion - 5VA"; Rec."Adopcion - 5VA")
                {
                    ApplicationArea = All;
                    ToolTip = 'Adopcion - 5VA';
                }
            }
        }
    }

    actions
    {
    }

    var
        ConfAPS: Record 55467;
        TextoEncabezado: array[30] of Text[30];
        DimValue: Text[60];
        i: Integer;

    procedure RecibeParametros(CodCol: Code[20])
    var
        ColAdopDetalle: Record 55520;
        Grados: Record 55469;
    begin
        ConfAPS.GET();
        ConfAPS.TESTFIELD("Dim para Estad. Adopciones");
        i := 0;
        DimValue := 'aaa';
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
        //ColAdopDetalle.SETRANGE("Cod. Nivel",CodNivel);
        //ColAdopDetalle.SETRANGE("Cod. Turno",CodTurno);
        //ColAdopDetalle.SETRANGE("Cod. Grado",CodGrado);
        ColAdopDetalle.FINDSET;
        REPEAT
            IF ConfAPS."Dim para Estad. Adopciones" = ConfAPS."Cod. Dimension Lin. Negocio" THEN BEGIN
                IF ColAdopDetalle."Linea de negocio" <> DimValue THEN BEGIN
                    INIT;
                    DimValue := ColAdopDetalle."Linea de negocio";
                END;
            END
            ELSE
                IF ConfAPS."Dim para Estad. Adopciones" = ConfAPS."Cod. Dimension Familia" THEN BEGIN
                    IF ColAdopDetalle.Familia <> DimValue THEN BEGIN
                        INIT;
                        DimValue := ColAdopDetalle.Familia;
                    END;
                END
                ELSE
                    IF ConfAPS."Dim para Estad. Adopciones" = ConfAPS."Cod. Dimension Sub Familia" THEN BEGIN
                        IF ColAdopDetalle."Sub Familia" <> DimValue THEN BEGIN
                            INIT;
                            DimValue := ColAdopDetalle."Sub Familia";
                        END;
                    END
                    ELSE
                        IF ConfAPS."Dim para Estad. Adopciones" = ConfAPS."Cod. Dimension Serie" THEN BEGIN
                            IF ColAdopDetalle.Serie <> DimValue THEN BEGIN
                                INIT;
                                DimValue := ColAdopDetalle.Serie;
                            END;
                        END;

            "Cod. Colegio" := ColAdopDetalle."Cod. Colegio";
            "Cod. Nivel" := ColAdopDetalle."Cod. Nivel";
            "Cod. Grado" := ColAdopDetalle."Cod. Grado";
            "Cod. Turno" := ColAdopDetalle."Cod. Turno";
            "Linea de negocio" := ColAdopDetalle."Linea de negocio";
            Familia := ColAdopDetalle.Familia;
            "Sub Familia" := DimValue;
            Serie := ColAdopDetalle.Serie;
            "Cod. Editorial" := ColAdopDetalle."Cod. Editorial";
            "Cod. Local" := ColAdopDetalle."Cod. Local";
            "Cod. Promotor" := ColAdopDetalle."Cod. Promotor";
            "Cod. Producto" := ColAdopDetalle."Cod. Producto";
            IF FIELDCAPTION("Cantidad - 2INI") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                "Cantidad - 2INI" := ColAdopDetalle."Cantidad Alumnos";
                "Adopcion - 2INI" := ColAdopDetalle.Adopcion;
            END
            ELSE
                IF FIELDCAPTION("Cantidad - 3INI") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                    "Cantidad - 3INI" := ColAdopDetalle."Cantidad Alumnos";
                    "Adopcion - 3INI" := ColAdopDetalle.Adopcion;
                END
                ELSE
                    IF FIELDCAPTION("Cantidad - 4INI") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                        "Cantidad - 4INI" := ColAdopDetalle."Cantidad Alumnos";
                        "Adopcion - 4INI" := ColAdopDetalle.Adopcion;
                    END
                    ELSE
                        IF FIELDCAPTION("Cantidad - 5INI") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                            "Cantidad - 5INI" := ColAdopDetalle."Cantidad Alumnos";
                            "Adopcion - 5INI" := ColAdopDetalle.Adopcion;
                        END
                        ELSE
                            IF FIELDCAPTION("Cantidad - 1PRI") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                "Cantidad - 1PRI" := ColAdopDetalle."Cantidad Alumnos";
                                "Adopcion - 1PRI" := ColAdopDetalle.Adopcion;
                            END
                            ELSE
                                IF FIELDCAPTION("Cantidad - 2PRI") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                    "Cantidad - 2PRI" := ColAdopDetalle."Cantidad Alumnos";
                                    "Adopcion - 2PRI" := ColAdopDetalle.Adopcion;
                                END
                                ELSE
                                    IF FIELDCAPTION("Cantidad - 3PRI") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                        "Cantidad - 3PRI" := ColAdopDetalle."Cantidad Alumnos";
                                        "Adopcion - 3PRI" := ColAdopDetalle.Adopcion;
                                    END
                                    ELSE
                                        IF FIELDCAPTION("Cantidad - 4PRI") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                            "Cantidad - 4PRI" := ColAdopDetalle."Cantidad Alumnos";
                                            "Adopcion - 4PRI" := ColAdopDetalle.Adopcion;
                                        END
                                        ELSE
                                            IF FIELDCAPTION("Cantidad - 5PRI") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                                "Cantidad - 5PRI" := ColAdopDetalle."Cantidad Alumnos";
                                                "Adopcion - 5PRI" := ColAdopDetalle.Adopcion;
                                            END
                                            ELSE
                                                IF FIELDCAPTION("Cantidad - 6PRI") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                                    "Cantidad - 6PRI" := ColAdopDetalle."Cantidad Alumnos";
                                                    "Adopcion - 6PRI" := ColAdopDetalle.Adopcion;
                                                END
                                                ELSE
                                                    IF FIELDCAPTION("Cantidad - 1SEC") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                                        "Cantidad - 1SEC" := ColAdopDetalle."Cantidad Alumnos";
                                                        "Adopcion - 1SEC" := ColAdopDetalle.Adopcion;
                                                    END
                                                    ELSE
                                                        IF FIELDCAPTION("Cantidad - 2SEC") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                                            "Cantidad - 2SEC" := ColAdopDetalle."Cantidad Alumnos";
                                                            "Adopcion - 2SEC" := ColAdopDetalle.Adopcion;
                                                        END
                                                        ELSE
                                                            IF FIELDCAPTION("Cantidad - 3SEC") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                                                "Cantidad - 3SEC" := ColAdopDetalle."Cantidad Alumnos";
                                                                "Adopcion - 3SEC" := ColAdopDetalle.Adopcion;
                                                            END
                                                            ELSE
                                                                IF FIELDCAPTION("Cantidad - 4SEC") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                                                    "Cantidad - 4SEC" := ColAdopDetalle."Cantidad Alumnos";
                                                                    "Adopcion - 4SEC" := ColAdopDetalle.Adopcion;
                                                                END
                                                                ELSE
                                                                    IF FIELDCAPTION("Cantidad - 5SEC") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                                                        "Cantidad - 5SEC" := ColAdopDetalle."Cantidad Alumnos";
                                                                        "Adopcion - 5SEC" := ColAdopDetalle.Adopcion;
                                                                    END
                                                                    ELSE
                                                                        IF FIELDCAPTION("Cantidad - 1SEI") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                                                            "Cantidad - 1SEI" := ColAdopDetalle."Cantidad Alumnos";
                                                                            "Adopcion - 1SEI" := ColAdopDetalle.Adopcion;
                                                                        END
                                                                        ELSE
                                                                            IF FIELDCAPTION("Cantidad - 2SEI") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                                                                "Cantidad - 2SEI" := ColAdopDetalle."Cantidad Alumnos";
                                                                                "Adopcion - 2SEI" := ColAdopDetalle.Adopcion;
                                                                            END
                                                                            ELSE
                                                                                IF FIELDCAPTION("Cantidad - 3SEI") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                                                                    "Cantidad - 3SEI" := ColAdopDetalle."Cantidad Alumnos";
                                                                                    "Adopcion - 3SEI" := ColAdopDetalle.Adopcion;
                                                                                END
                                                                                ELSE
                                                                                    IF FIELDCAPTION("Cantidad - 4SEI") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                                                                        "Cantidad - 4SEI" := ColAdopDetalle."Cantidad Alumnos";
                                                                                        "Adopcion - 4SEI" := ColAdopDetalle.Adopcion;
                                                                                    END
                                                                                    ELSE
                                                                                        IF FIELDCAPTION("Cantidad - 1VA") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                                                                            "Cantidad - 1VA" := ColAdopDetalle."Cantidad Alumnos";
                                                                                            "Adopcion - 1VA" := ColAdopDetalle.Adopcion;
                                                                                        END
                                                                                        ELSE
                                                                                            IF FIELDCAPTION("Cantidad - 2VA") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                                                                                "Cantidad - 2VA" := ColAdopDetalle."Cantidad Alumnos";
                                                                                                "Adopcion - 2VA" := ColAdopDetalle.Adopcion;
                                                                                            END
                                                                                            ELSE
                                                                                                IF FIELDCAPTION("Cantidad - 3VA") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                                                                                    "Cantidad - 3VA" := ColAdopDetalle."Cantidad Alumnos";
                                                                                                    "Adopcion - 3VA" := ColAdopDetalle.Adopcion;
                                                                                                END
                                                                                                ELSE
                                                                                                    IF FIELDCAPTION("Cantidad - 4VA") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                                                                                        "Cantidad - 4VA" := ColAdopDetalle."Cantidad Alumnos";
                                                                                                        "Adopcion - 4VA" := ColAdopDetalle.Adopcion;
                                                                                                    END
                                                                                                    ELSE
                                                                                                        IF FIELDCAPTION("Cantidad - 5VA") = ColAdopDetalle."Cod. Grado" THEN BEGIN
                                                                                                            "Cantidad - 5VA" := ColAdopDetalle."Cantidad Alumnos";
                                                                                                            "Adopcion - 5VA" := ColAdopDetalle.Adopcion;
                                                                                                        END;

            IF NOT INSERT THEN
                MODIFY;
        UNTIL ColAdopDetalle.NEXT = 0;
    end;
}

