page 34002559 "Peticion de Fecha"
{
    PageType = ConfirmationDialog;

    layout
    {
        area(content)
        {
            field(Fecha; wFecha)
            {
            }
        }
    }

    actions
    {
    }

    var
        wFecha: Date;

    procedure DevolverFecha(): Date
    begin
        EXIT(wFecha);
    end;
}

