page 67137 "Colegio - Work Flow Pasos"
{
    Caption = 'School - steps Work flow';
    DeleteAllowed = false;
    PageType = ListPlus;
    SourceTable = Table67062;
    SourceTableView = WHERE("Paso" = CONST(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Colegio"; "Cod. Colegio")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Detalle; Detalle)
                {
                    Caption = 'Step';
                    Editable = false;
                }
                field(Resultado; Resultado)
                {

                    trigger OnValidate()
                    var
                        Error001: Label 'Es obligatorio marcar los pasos de forma ordenada, del primero al último.';
                        Error002: Label 'No se permite desmarcar pasos.';
                    begin

                        IF Resultado THEN BEGIN
                            CWF.RESET;
                            CWF.SETRANGE("Cod. Colegio", "Cod. Colegio");
                            CWF.SETRANGE(Paso, TRUE);
                            CWF.SETFILTER(Detalle, '<>%1', Detalle);
                            CWF.SETRANGE(Resultado, FALSE);
                            IF CWF.FINDFIRST THEN BEGIN
                                IF CWF.Secuencia < Secuencia THEN
                                    ERROR(Error001);
                            END;
                        END
                        ELSE BEGIN
                            CWF.RESET;
                            CWF.SETRANGE("Cod. Colegio", "Cod. Colegio");
                            CWF.SETRANGE(Paso, TRUE);
                            CWF.SETFILTER(Detalle, '<>%1', Detalle);
                            CWF.SETRANGE(Resultado, TRUE);
                            IF CWF.FINDLAST THEN BEGIN
                                IF CWF.Secuencia > Secuencia THEN
                                    ERROR(Error001);
                            END;

                        END;
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Sec := 0;
        CWF.RESET;
        CWF.SETRANGE("Cod. Promotor", "Cod. Promotor");
        CWF.SETRANGE("Cod. Colegio", "Cod. Colegio");
        CWF.SETRANGE(Paso, TRUE);
        IF NOT CWF.FINDFIRST THEN BEGIN
            DatosAux.RESET;
            DatosAux.SETRANGE("Tipo registro", DatosAux."Tipo registro"::Paso);
            DatosAux.FIND('-');
            REPEAT
                Sec += 1000;
                INIT;
                "Cod. Colegio" := "Cod. Colegio";
                Secuencia := Sec;
                Detalle := DatosAux.Descripcion;
                Paso := TRUE;
                INSERT;
            UNTIL DatosAux.NEXT = 0;
        END;
    end;

    var
        CWF: Record 67062;
        DatosAux: Record 67002;
        Sec: Integer;
}

