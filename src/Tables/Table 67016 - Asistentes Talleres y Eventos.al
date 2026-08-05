table 67016 "Asistentes Talleres y Eventos"
{

    fields
    {
        field(1; "No. Solicitud"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Solicitud';
        }
        field(2; "Cod. Taller - Evento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Taller - Evento';
            TableRelation = Eventos."No.";

            trigger OnValidate()
            begin
                TyE.GET("Tipo Evento", "Cod. Taller - Evento");
                "Description Taller" := TyE.Descripcion;
                VALIDATE("Cod. Colegio", ProgTyE."Cod. Colegio");
                VALIDATE("Cod. Promotor", ProgTyE."Cod. Promotor");
            end;
        }
        field(3; "Tipo Evento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Evento';
        }
        field(4; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Colegio';
            TableRelation = Contact WHERE("Type" = CONST(Company));

            trigger OnValidate()
            begin
                IF Col.GET("Cod. Colegio") THEN
                    "Nombre Colegio" := Col.Name;
            end;
        }
        field(5; "Cod. Promotor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Promotor';
            TableRelation = "Salesperson/Purchaser" WHERE("Tipo" = CONST(Vendedor));

            trigger OnValidate()
            begin
                IF "Cod. Promotor" <> '' THEN BEGIN
                    Prom.GET("Cod. Promotor");
                    "Nombre Promotor" := Prom.Name;
                END;
            end;
        }
        field(6; "Description Tipo evento"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description Tipo evento';
        }
        field(7; "Description Taller"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description Taller';
        }
        field(8; "Nombre Colegio"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Colegio';
        }
        field(9; "Nombre Promotor"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Promotor';
        }
        field(10; Secuencia; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Secuencia';
        }
        field(11; "Cod. Expositor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Expositor';
            TableRelation = IF ("Tipo de Expositor" = CONST(Docente)) Docentes WHERE("Expositor" = CONST(true))
            ELSE IF ("Tipo de Expositor" = CONST(Proveedor)) Vendor;

            trigger OnValidate()
            begin
                IF "Tipo de Expositor" = 0 THEN BEGIN
                    Expos.GET("Cod. Expositor");
                    "Nombre Expositor" := Expos."Full Name";
                END
                ELSE BEGIN
                    Vend.GET("Cod. Expositor");
                    "Nombre Expositor" := Vend.Name;
                END
            end;
        }
        field(12; "Nombre Expositor"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Expositor';
        }
        field(13; Confirmado; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Confirmado';
        }
        field(14; "Fecha inscripcion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha inscripcion';
        }
        field(15; "Fecha del Evento"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha del Evento';
        }
        field(16; "Fecha de realizacion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha de realizacion';
        }
        field(17; "Cod. Docente"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Docente';
            TableRelation = Docentes;

            trigger OnValidate()
            begin
                IF "Cod. Docente" <> '' THEN BEGIN
                    Prof.GET("Cod. Docente");
                    "Nombre Docente" := Prof."Full Name";
                    "Document ID" := Prof."Document ID";
                    Inscrito := TRUE;
                END;
            end;
        }
        field(18; "Nombre Docente"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Docente';
        }
        field(19; Asistio; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Asistio';

            trigger OnValidate()
            begin
                IF (NOT Confirmado) AND (Asistio) THEN
                    Confirmado := Asistio;

                IF (Asistio) AND ("No. Solicitud" <> '') THEN BEGIN
                    Inscrito := Asistio;
                    Confirmado := Asistio;
                END;
            end;
        }
        field(20; "Tipo de Expositor"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de Expositor';
            OptionCaption = 'Teacher,Vendor';
            OptionMembers = Docente,Proveedor;
        }
        field(21; Inscrito; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inscrito';
        }
        field(22; "Fecha programacion"; Date)
        {
            Caption = 'Fecha programacion';
            CalcFormula = Lookup("Programac. Talleres y Eventos"."Fecha programacion" WHERE("Cod. Taller - Evento" = FIELD("Cod. Taller - Evento"),
                                                                                             "Tipo Evento" = FIELD("Tipo Evento"),
                                                                                             "Tipo de Expositor" = FIELD("Tipo de Expositor"),
                                                                                             "Secuencia" = FIELD("Secuencia"),
                                                                                             "No. Linea" = FIELD("No Linea Programac.")));
            FieldClass = FlowField;
        }
        field(23; "Document ID"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document ID';

            trigger OnValidate()
            var
                VATRegNoFormat: Record 381;
            begin
            end;
        }
        field(24; "No Linea Programac."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No Linea Programac.';
        }
    }

    keys
    {
        key(Key1; "No. Solicitud", "Cod. Taller - Evento", "Cod. Expositor", Secuencia, "No Linea Programac.", "Cod. Docente")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF Asistio THEN
            ERROR(STRSUBSTNO(Err002, FIELDCAPTION(Asistio), Asistio));
    end;

    trigger OnInsert()
    var
        wAsistentesEsp: Integer;
        rSol: Record 67055;
    begin
        CabPlanEvent.RESET;
        CabPlanEvent.SETRANGE("Cod. Taller - Evento", "Cod. Taller - Evento");
        CabPlanEvent.SETRANGE(Expositor, "Cod. Expositor");
        CabPlanEvent.SETRANGE(Secuencia, Secuencia);
        CabPlanEvent.SETRANGE("Tipo Evento", "Tipo Evento");
        CabPlanEvent.FINDFIRST;


        "Fecha del Evento" := CabPlanEvent."Fecha Inicio";
        "Fecha inscripcion" := TODAY;
        VALIDATE("Cod. Colegio", CabPlanEvent."Cod. Colegio");
        VALIDATE("Cod. Promotor", CabPlanEvent."Cod. Promotor");


        rProgEv.SETRANGE(rProgEv."Cod. Taller - Evento", "Cod. Taller - Evento");
        rProgEv.SETRANGE(rProgEv.Expositor, "Cod. Expositor");
        rProgEv.SETRANGE(rProgEv.Secuencia, Secuencia);
        rProgEv.SETRANGE(rProgEv."Tipo Evento", "Tipo Evento");
        //rProgEv.SETRANGE(rProgEv."Fecha programacion",  "Fecha programacion");
        rProgEv.SETRANGE("No. Linea", "No Linea Programac.");
        rProgEv.FINDFIRST;

        IF CabPlanEvent."No. Solicitud" <> '' THEN BEGIN
            rSol.GET(CabPlanEvent."No. Solicitud");
            wAsistentesEsp := rSol."Asistentes Esperados";
        END
        ELSE
            wAsistentesEsp := CabPlanEvent."Asistentes esperados";

        Asist.RESET;
        Asist.SETRANGE("Cod. Taller - Evento", "Cod. Taller - Evento");
        Asist.SETRANGE("Tipo Evento", "Tipo Evento");
        Asist.SETRANGE("Cod. Expositor", "Cod. Expositor");
        Asist.SETRANGE(Secuencia, Secuencia);
        //Asist.SETRANGE("Fecha programacion","Fecha programacion");
        Asist.SETRANGE("No Linea Programac.", "No Linea Programac.");
        //IF CabPlanEvent."Asistentes esperados" < Asist.COUNT +1 THEN
        IF wAsistentesEsp < Asist.COUNT + 1 THEN
            ERROR(Err001);
    end;

    var
        CabPlanEvent: Record 67051;
        Col: Record 5050;
        Prom: Record 13;
        TyE: Record 55478;
        Prof: Record 55468;
        ProgTyE: Record 67015;
        Expos: Record 55468;
        Vend: Record 23;
        Asist: Record 67016;
        Err001: Label 'Teachers Total exceeds the capacity for the Event';
        Err002: Label 'Line can not be deleted because it is marked with% 1% %2';
        rProgEv: Record 67015;
}

