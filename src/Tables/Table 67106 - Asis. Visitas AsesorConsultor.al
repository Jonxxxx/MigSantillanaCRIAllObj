table 67106 "Asis. Visitas Asesor/Consultor"
{

    fields
    {
        field(1; "No. Visita"; Code[20])
        {
            Editable = false;
        }
        field(2; "No. Linea Progr."; Integer)
        {
            Editable = false;
        }
        field(3; "No. Linea"; Integer)
        {
            Editable = false;
        }
        field(4; "Cod. Docente"; Code[20])
        {
            TableRelation = Docentes;

            trigger OnValidate()
            var
                Prof: Record 67001;
            begin

                IF "Cod. Docente" <> '' THEN BEGIN
                    Prof.GET("Cod. Docente");
                    "Nombre Docente" := Prof."Full Name";
                    "Document ID" := Prof."Document ID";
                    Inscrito := TRUE;
                END;
            end;
        }
        field(5; "Nombre Docente"; Text[60])
        {
            Editable = false;
        }
        field(6; Asistio; Boolean)
        {
            Caption = 'Attended';

            trigger OnValidate()
            begin

                IF (NOT Confirmado) AND (Asistio) THEN
                    Confirmado := Asistio;

                IF (Asistio) THEN BEGIN
                    Inscrito := Asistio;
                    Confirmado := Asistio;
                END;
            end;
        }
        field(7; Inscrito; Boolean)
        {
        }
        field(8; Confirmado; Boolean)
        {
        }
        field(9; "Fecha inscripcion"; Date)
        {
            Editable = false;
        }
        field(10; "Fecha programaci n"; Date)
        {
            CalcFormula = Lookup("Prog. Visitas Asesor/Consultor"."Fecha Programada" WHERE("No. Visita" = FIELD("No. Visita")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Document ID"; Text[20])
        {
            Caption = 'Document ID';
            Editable = false;

            trigger OnValidate()
            var
                VATRegNoFormat: Record 381;
            begin
            end;
        }
    }

    keys
    {
        key(Key1; "No. Visita", "No. Linea Progr.", "No. Linea")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        rRec: Record 67106;
        Error001: Label 'La fecha de la visita (%1) es inferior a la fecha de registro (%2).';
    begin

        rRec.RESET;
        rRec.SETRANGE(rRec."No. Visita", "No. Visita");
        rRec.SETRANGE(rRec."No. Linea Progr.", "No. Linea Progr.");
        IF rRec.FINDLAST THEN
            "No. Linea" := rRec."No. Linea" + 1
        ELSE
            "No. Linea" := 1;

        "Fecha inscripcion" := TODAY;
    end;
}

