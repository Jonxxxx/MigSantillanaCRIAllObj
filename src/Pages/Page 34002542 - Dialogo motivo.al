page 34002542 "Dialogo motivo"
{
    Caption = 'Indique el Motivo';
    PageType = StandardDialog;

    layout
    {
        area(content)
        {
            field(Motivo;texMotivo)
            {
                Caption = 'Indique el motivo de la reapertura';
            }
        }
    }

    actions
    {
    }

    var
        texMotivo: Text[60];

    procedure TraerMotivo(): Text[60]
    begin
        EXIT(texMotivo);
    end;
}

