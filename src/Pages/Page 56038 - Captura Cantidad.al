page 55263 "Captura Cantidad"
{

    layout
    {
        area(content)
        {
            field(wCant; wCant)
            {
                ApplicationArea = All;
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

