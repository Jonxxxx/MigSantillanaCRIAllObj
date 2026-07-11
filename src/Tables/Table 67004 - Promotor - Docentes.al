table 67004 "Promotor - Docentes"
{
    DrillDownPageID = 67004;
    LookupPageID = 67004;

    fields
    {
        field(1; "Codigo Docente"; Code[20])
        {
            TableRelation = Docentes;
        }
        field(2; "Cod. Promotor"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(3; "Nombre Docente"; Text[60])
        {
            CalcFormula = Lookup(Docentes."Full Name" WHERE("No." = FIELD("Codigo Docente")));
            FieldClass = FlowField;
        }
        field(4; "Nombre Promotor"; Text[60])
        {
            CalcFormula = Lookup(Salesperson/Purchaser.Name WHERE ("Code"=FIELD("Cod. Promotor")));
            FieldClass = FlowField;
        }
        field(5;"Nivel decision";Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE ("Tipo registro"=CONST("Nivel de decisi n"));

            trigger OnValidate()
            begin
                IF "Nivel decision" <> '' THEN
                   BEGIN
                    DA.RESET;
                    DA.SETRANGE("Tipo registro",DA."Tipo registro"::"Nivel de decisi n");
                    DA.SETRANGE(Codigo,"Nivel decision");
                    DA.FINDFIRST;
                   END;
            end;
        }
        field(6;"Cod. Cargo";Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE ("Tipo registro"=CONST("Puestos de trabajo"));

            trigger OnValidate()
            begin
                IF "Cod. Cargo" <> '' THEN
                   BEGIN
                    DA.RESET;
                    DA.SETRANGE("Tipo registro",DA."Tipo registro"::"Puestos de trabajo");
                    DA.SETRANGE(Codigo,"Cod. Cargo");
                    DA.FINDFIRST;
                    "Descripcion Cargo" := DA.Descripcion;
                   END;
            end;
        }
        field(7;"Descripcion Cargo";Text[60])
        {
        }
    }

    keys
    {
        key(Key1;"Codigo Docente","Cod. Promotor")
        {
        }
        key(Key2;"Cod. Promotor","Codigo Docente")
        {
        }
    }

    fieldgroups
    {
    }

    var
        DA: Record 67002;
        ColNiv: Record 67036;
        NivelE: Record 67022;
        PromRuta: Record 67044;
        Promotor: Record 13;
        Docente: Record 67001;
        Cargo: Page 67033;
}

