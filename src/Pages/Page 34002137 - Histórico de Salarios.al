page 34002137 "Historico de Salarios"
{
    Editable = false;
    PageType = List;
    SourceTable = 34002149;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                Editable = false;
                field("Fecha Desde"; "Fecha Desde")
                {
                    Caption = 'Desde';
                }
                field("Fecha Hasta"; "Fecha Hasta")
                {
                    Caption = 'Hasta';
                }
                field(Importe; Importe)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;

    procedure FiltraEmpleado(rEmpleado: Record 5200)
    begin
        SETRANGE("No. empleado", rEmpleado."No.");
    end;
}

