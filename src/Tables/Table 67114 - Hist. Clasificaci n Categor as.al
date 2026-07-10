table 67114 "Hist. Clasificaci n Categor as"
{

    fields
    {
        field(1; "Campa a"; Integer)
        {
        }
        field(2; Potencial; Option)
        {
            OptionCaption = ' ,1,2,3,4';
            OptionMembers = " ","1","2","3","4;
        }
        field(3; "Cod. Afinidad"; Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE(Tipo registro=CONST(30));
        }
        field(4; "Categor a"; Code[2])
        {
        }
    }

    keys
    {
        key(Key1; "Campa a", Potencial, "Cod. Afinidad")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        APSSetup Record: 67000;
    begin
        //APSSetup.GET();
        //APSSetup.TESTFIELD(APSSetup.Campana);
        //Campa a := APSSetup.Campana;
    end;
}

