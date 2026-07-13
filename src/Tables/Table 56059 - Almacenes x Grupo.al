table 56059 "Almacenes x Grupo"
{
    // 001 RRT 02.06.2014


    fields
    {
        field(1; Grupo; Code[10])
        {
            NotBlank = true;
            TableRelation = "Grupos de almacenes".Grupo;
        }
        field(2; Almacen; Code[10])
        {
            NotBlank = true;
            TableRelation = Location.Code;
        }
        field(10; "Nombre Grupo"; Text[50])
        {
            //TODO: Ver CalcFormula = Lookup("Grupos de almacenes".Descripcion WHERE ("Grupo"=FIELD("Grupo")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Nombre Almacen"; Text[100])
        {
            CalcFormula = Lookup(Location.Name WHERE("Code" = FIELD("Almacen")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; Grupo, Almacen)
        {
        }
        key(Key2; Almacen, Grupo)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        TextL001: Label 'Un grupo no puede tener mas de %2 almacenes relacionados.';
        lrAxG: Record 56059;
    begin
        lrAxG.SETRANGE(Grupo, Grupo);
        IF lrAxG.COUNT >= (32 + 1) THEN
            ERROR(TextL001, Grupo, 32);
    end;
}

