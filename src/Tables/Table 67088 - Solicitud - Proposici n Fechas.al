table 67088 "Solicitud - Proposici n Fechas"
{

    fields
    {
        field(1; "No. Solicitud"; Code[20])
        {
        }
        field(2; "No. Linea"; Integer)
        {
        }
        field(3; "Fecha propuesta"; Date)
        {
        }
        field(4; "Hora Inicio"; Time)
        {
        }
        field(5; "Hora Fin"; Time)
        {
        }
        field(6; "Cod. Grado"; Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Grados));

            trigger OnValidate()
            var
                rSol: Record 67055;
                rColGrados: Record 67037;
            begin

                "No. asistentes" := 0;
                IF ("No. Solicitud" <> '') AND ("Cod. Grado" <> '') THEN BEGIN
                    rSol.GET("No. Solicitud");
                    rColGrados.SETRANGE(rColGrados."Cod. Colegio", rSol."Cod. Colegio");
                    //rColGrados.SETRANGE(rColGrados."Cod. Nivel", rSol."Cod. Nivel");
                    //rColGrados.SETRANGE(rColGrados."Cod. Turno",  rSol."Cod. Turno");
                    rColGrados.SETRANGE(rColGrados."Cod. Grado", "Cod. Grado");
                    IF rColGrados.FINDFIRST THEN
                        REPEAT
                            "No. asistentes" := "No. asistentes" + rColGrados."Cantidad Alumnos";
                        UNTIL rColGrados.NEXT = 0;
                END;
            end;
        }
        field(8; "No. asistentes"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "No. Solicitud", "No. Linea")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        rProp: Record 67088;
        rSol: Record 67055;
    begin

        IF ("No. Solicitud" <> '') AND ("No. Linea" <> 0) THEN BEGIN
            rProp.SETRANGE("No. Solicitud", "No. Solicitud");
            rProp.SETFILTER("No. Linea", '<>%1', "No. Linea");
            IF NOT rProp.FINDSET THEN BEGIN
                IF rSol.GET("No. Solicitud") THEN BEGIN
                    rSol."Fecha Propuesta" := 0D;
                    rSol.MODIFY;
                END;
            END;
        END;
    end;

    trigger OnInsert()
    var
        rRec: Record 67088;
        rProp: Record 67088;
        rSol: Record 67055;
        Error001: Label 'La fecha propuesta (%1) es inferior a la fecha de solicitud (%2).';
    begin

        TESTFIELD("Fecha propuesta");
        TESTFIELD("Hora Inicio");
        TESTFIELD("Hora Fin");

        rRec.SETRANGE(rRec."No. Solicitud", "No. Solicitud");
        IF rRec.FINDLAST THEN
            "No. Linea" := rRec."No. Linea" + 1
        ELSE
            "No. Linea" := 1;

        IF "Fecha propuesta" <> 0D THEN BEGIN
            IF rSol.GET("No. Solicitud") THEN BEGIN
                IF "Fecha propuesta" < rSol."Fecha Solicitud" THEN
                    ERROR(STRSUBSTNO(Error001, "Fecha propuesta", rSol."Fecha Solicitud"));
                rSol."Fecha Propuesta" := "Fecha propuesta";
                rSol.MODIFY;
            END;
        END;
    end;

    trigger OnModify()
    var
        rProp: Record 67088;
        rSol: Record 67055;
        Error001: Label 'La fecha propuesta (%1) es inferior a la fecha de solicitud (%2).';
    begin

        TESTFIELD("Fecha propuesta");
        TESTFIELD("Hora Inicio");
        TESTFIELD("Hora Fin");

        IF "Fecha propuesta" <> 0D THEN BEGIN
            IF rSol.GET("No. Solicitud") THEN BEGIN
                IF "Fecha propuesta" < rSol."Fecha Solicitud" THEN
                    ERROR(STRSUBSTNO(Error001, "Fecha propuesta", rSol."Fecha Solicitud"));
                rSol."Fecha Propuesta" := "Fecha propuesta";
                rSol.MODIFY;
            END;
        END;
    end;
}

