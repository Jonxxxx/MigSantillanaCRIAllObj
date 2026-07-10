page 56038 "Captura Cantidad"
{

    layout
    {
        area(content)
        {
            field(wCant;wCant)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        wCant := 1;
    end;

    var
        wCant: Decimal;

    procedure GetCantidad(): Decimal
    begin
        EXIT(wCant);
    end;
}

