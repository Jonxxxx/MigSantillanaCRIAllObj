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
                field("Fecha Desde"; Rec."Fecha Desde")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Desde';
                    Caption = 'Desde';
                }
                field("Fecha Hasta"; Rec."Fecha Hasta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Hasta';
                    Caption = 'Hasta';
                }
                field(Importe; Rec.Importe)
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe';
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

