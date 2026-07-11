table 67056 "Colegio - Cab. Jerarquia puest"
{

    fields
    {
        field(1; "Cod. Colegio"; Code[20])
        {
            TableRelation = Contact;

            trigger OnValidate()
            begin
                IF "Cod. Colegio" <> '' THEN BEGIN
                    Colegio.GET("Cod. Colegio");
                    "Nombre Colegio" := Colegio.Name;
                END
            end;
        }
        field(2; "Cod. Local"; Code[20])
        {
            TableRelation = "Contact Alt. Address".Code WHERE("Contact No." = FIELD("Cod. Colegio"));
        }
        field(3; "Cod. Nivel"; Code[20])
        {
            TableRelation = "Colegio - Nivel"."Cod. Nivel" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"),
                                                                  Cod. Local=FIELD(Cod. Local));
        }
        field(4;"Cod. Turno";Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE ("Tipo registro"=CONST(Turnos));

            trigger OnLookup()
            begin
                DA.RESET;
                DA.SETRANGE("Tipo registro",DA."Tipo registro"::Turnos);
                Turnos.SETTABLEVIEW(DA);
                Turnos.SETRECORD(DA);
                Turnos.LOOKUPMODE(TRUE);
                IF Turnos.RUNMODAL = ACTION::LookupOK THEN
                   BEGIN
                    Turnos.GETRECORD(DA);
                    "Cod. Turno" := DA.Codigo;
                   END;

                CLEAR(Turnos);
            end;
        }
        field(5;"Nombre Colegio";Text[60])
        {
        }
    }

    keys
    {
        key(Key1;"Cod. Colegio")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Colegio: Record 5050;
        Empleado Record: 67001;
        DA Record: 67002;
        Turnos: Page67003;
                    Grados: Page67006;
}

