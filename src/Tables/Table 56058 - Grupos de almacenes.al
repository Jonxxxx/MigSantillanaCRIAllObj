table 56058 "Grupos de almacenes"
{
    // 001 RRT 02.06.2014

    DrillDownPageID = 56060;
    LookupPageID = 56060;

    fields
    {
        field(1; Grupo; Code[10])
        {
        }
        field(2; "Descripci n"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; Grupo)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        TextL001: Label 'No podemos eliminar el grupo ya que est  definido en la tabla de almacenes x grupo';
        lrAxG Record: 56059;
    begin
        lrAxG.RESET;
        lrAxG.SETRANGE(Grupo, Grupo);
        IF lrAxG.COUNT > 0 THEN
            ERROR(TextL001);
    end;
}

