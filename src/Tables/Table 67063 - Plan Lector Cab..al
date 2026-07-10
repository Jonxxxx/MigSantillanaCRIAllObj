table 67063 "Plan Lector Cab."
{

    fields
    {
        field(1; "Cod. Colegio"; Code[10])
        {
            TableRelation = Contact WHERE(Type = CONST(Company),
                                           Tipo educacion=CONST(true));

            trigger OnValidate()
            var
                Colegio: Record 5050;
                DimVal Record: 349;
                ConfAPS Record: 67000;
            begin
                Colegio.SETRANGE(Colegio."No.", "Cod. Colegio");
                IF Colegio.FINDFIRST THEN BEGIN
                    "Nombre Colegio" := Colegio.Name;
                    Distrito := Colegio.Distritos;
                    "Cod. Delegacion" := Colegio.Delegacion;
                    ConfAPS.GET;
                    ConfAPS.TESTFIELD("Cod. Dimension Delegacion");
                    DimVal.RESET;
                    DimVal.SETRANGE("Dimension Code", ConfAPS."Cod. Dimension Delegacion");
                    DimVal.SETRANGE("Dimension Value Type", DimVal."Dimension Value Type"::Standard);
                    DimVal.SETRANGE(Code, Colegio.Delegacion);
                    IF DimVal.FINDFIRST THEN
                        "Descripci n Delegacion" := DimVal.Name;


                END;
            end;
        }
        field(2; "Nombre Colegio"; Text[50])
        {
            Editable = false;
        }
        field(3; "Cod. Local"; Code[10])
        {
            TableRelation = "Contact Alt. Address".Code WHERE(Contact No.=FIELD(Cod. Colegio));
        }
        field(4;"Descripcion Local";Text[50])
        {
            Editable = false;
        }
        field(5;"Cod. Turno";Code[10])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE (Tipo registro=CONST(Turnos));

            trigger OnValidate()
            var
                DA Record: 67002;
            begin
                DA.SETRANGE("Tipo registro",DA."Tipo registro"::Turnos);
                IF DA.FINDFIRST THEN
                  "Descripcion Turno" := DA.Descripcion;
            end;
        }
        field(6;"Descripcion Turno";Text[30])
        {
            Editable = false;
        }
        field(7;Distrito;Text[30])
        {
            Editable = false;
        }
        field(8;"Cod. Delegacion";Code[20])
        {
        }
        field(9;"Descripci n Delegacion";Text[50])
        {
        }
        field(50;"Campa a";Code[20])
        {
        }
    }

    keys
    {
        key(Key1;"Campa a","Cod. Colegio","Cod. Local","Cod. Turno")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnRename()
    var
        Text001: Label 'You cannot rename a %1.';
    begin
        ERROR(Text001,TABLECAPTION);
    end;
}

