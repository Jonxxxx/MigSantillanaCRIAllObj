table 67110 "Clasificacion Categorias"
{

    fields
    {
        field(1; "Campana"; Integer)
        {
        }
        field(2; Potencial; Option)
        {
            OptionCaption = ' ,1,2,3,4';
            OptionMembers = " ","1","2","3","4";
        }
        field(3; "Cod. Afinidad"; Code[20])
        {
            //TODO: Ver campo tipo registro TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST('30'));
        }
        field(4; "Categoria"; Code[2])
        {
        }
    }

    keys
    {
        key(Key1; Potencial, "Cod. Afinidad")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        APSSetup: Record 67000;
    begin
        APSSetup.GET();
        APSSetup.TESTFIELD(APSSetup.Campana);
        EVALUATE(Campana, APSSetup.Campana);
    end;
}

