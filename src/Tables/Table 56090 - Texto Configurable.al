table 56090 "Texto Configurable"
{
    // #842 CAT Configurador de textos


    fields
    {
        field(1; "Id. Tabla"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Id. Tabla';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(TableData));
        }
        field(2; "Seccion"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Seccion';
            OptionMembers = Cabecera,Detalle,Pie;
        }
        field(3; "No. Linea"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Linea';
        }
        field(4; Texto; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Texto';
        }
    }

    keys
    {
        key(Key1; "Id. Tabla", "Seccion", "No. Linea")
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
        rConf.SETRANGE(Seccion, Seccion);
        IF rConf.FINDLAST THEN
            "No. Linea" := rConf."No. Linea" + 1
        ELSE
            "No. Linea" := 1;
    end;
}

