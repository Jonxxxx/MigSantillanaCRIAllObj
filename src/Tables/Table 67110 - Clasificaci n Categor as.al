table 67110 "Clasificacion Categorias"
{

    fields
    {
        field(1; "Campana"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Campana';
        }
        field(2; Potencial; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Potencial';
            OptionCaption = ' ,1,2,3,4';
            OptionMembers = " ","1","2","3","4";
        }
        field(3; "Cod. Afinidad"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Afinidad';
            //TODO: Revisar campo tipo registro TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST('30'));
        }
        field(4; "Categoria"; Code[2])
        {
            DataClassification = CustomerContent;
            Caption = 'Categoria';
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

