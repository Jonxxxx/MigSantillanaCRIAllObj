page 34002540 "Dialogo fondo de caja"
{
    PageType = ConfirmationDialog;

    layout
    {
        area(content)
        {
            field("Fondo de caja";decFondo)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    var
        decFondo: Decimal;

    procedure TraerFondo(): Decimal
    begin
        EXIT(decFondo);
    end;
}

