table 67050 "Expositores - Eventos"
{
    Caption = 'Exhibitors - Events';

    fields
    {
        field(1; "Cod. Expositor"; Code[20])
        {
            TableRelation = IF (Tipo de Expositor=CONST(Docente)) Docentes WHERE ("Expositor"=CONST(true))
                            ELSE IF (Tipo de Expositor=CONST(Proveedor)) Vendor;

            trigger OnValidate()
            begin
                IF "Tipo de Expositor" = 0 THEN BEGIN
                    Expos.GET("Cod. Expositor");
                    "Nombre Expositor" := Expos."Full Name";
                END
                ELSE BEGIN
                    Vend.GET("Cod. Expositor");
                    "Nombre Expositor" := Vend.Name;
                END;

                Evento.RESET;
                Evento.SETRANGE("No.", "Cod. Evento");
                Evento.FINDFIRST;
                "Descripcion Evento" := Evento.Descripcion;
                Delegacion := Evento.Delegacion;
                "Tipo de Evento" := Evento."Tipo de Evento";
            end;
        }
        field(2; "Cod. Evento"; Code[20])
        {
            TableRelation = Eventos."No.";
        }
        field(3; "Nombre Expositor"; Text[100])
        {
            Editable = false;
        }
        field(4; "Descripcion Evento"; Text[100])
        {
            Editable = false;
        }
        field(5; "Cod. Docente"; Code[20])
        {
        }
        field(6; Delegacion; Code[20])
        {

            trigger OnValidate()
            begin
                ConfAPS.GET();
                ConfAPS.TESTFIELD(ConfAPS."Cod. Dimension Delegacion");

                IF Delegacion <> '' THEN BEGIN
                    DimVal.RESET;
                    DimVal.SETRANGE("Dimension Code", ConfAPS."Cod. Dimension Delegacion");
                    DimVal.SETRANGE("Dimension Value Type", DimVal."Dimension Value Type"::Standard);
                    DimVal.SETRANGE(Code, Delegacion);
                    DimVal.FINDFIRST;
                END;
            end;
        }
        field(7; "Tipo de Expositor"; Option)
        {
            OptionCaption = 'Teacher,Vendor';
            OptionMembers = Docente,Proveedor;
        }
        field(8; "Tipo de Evento"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Cod. Expositor", "Cod. Evento")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        CabPlanifEven.RESET;
        CabPlanifEven.SETRANGE(Expositor, "Cod. Expositor");
        IF CabPlanifEven.FINDFIRST THEN
            ERROR(Err001);
    end;

    trigger OnInsert()
    begin
        TESTFIELD("Cod. Expositor")
    end;

    var
        ConfAPS: Record 67000;
        Expos: Record 67001;
        Vend: Record 23;
        Evento: Record 67011;
        DimVal: Record 349;
        CabPlanifEven: Record 67051;
        Err001: Label 'Can not delete the Exhibitor because it has associated events.';
}

