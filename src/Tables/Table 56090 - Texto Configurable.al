table 56090 "Texto Configurable"
{
    // #842 CAT Configurador de textos


    fields
    {
        field(1; "Id. Tabla"; Integer)
        {
            TableRelation = Object.ID WHERE(Type = CONST(TableData));
        }
        field(2; "Secci n"; Option)
        {
            OptionMembers = Cabecera,Detalle,Pie;
        }
        field(3; "No. Linea"; Integer)
        {
        }
        field(4; Texto; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Id. Tabla", "Secci n", "No. Linea")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        rConf: Record 56090;
    begin
        rConf.SETRANGE("Id. Tabla", "Id. Tabla");
        rConf.SETRANGE(Secci n, Secci n);
        IF rConf.FINDLAST THEN
            "No. Linea" := rConf."No. Linea" + 1
        ELSE
            "No. Linea" := 1;
    end;
}

