table 55279 "Grupos de almacenes"
{
    // 001 RRT 02.06.2014

    DrillDownPageID = 55281;
    LookupPageID = 55281;

    fields
    {
        field(1; Grupo; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Grupo';
        }
        field(2; "Descripcion"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
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
        lrAxG: Record 55280;
    begin
        lrAxG.RESET;
        lrAxG.SETRANGE(Grupo, Grupo);
        IF lrAxG.COUNT > 0 THEN
            ERROR(TextL001);
    end;
}

