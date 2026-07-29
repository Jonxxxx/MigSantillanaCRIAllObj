page 56130 "Maestro de Rutas"
{
    // #29481  03/09/2015  FAA   Creada para este desarrollo.

    Caption = 'Maestro de Rutas';
    PageType = List;
    SourceTable = 56070;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo';
                }
                field("Nombre de Ruta"; Rec."Nombre de Ruta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre de Ruta';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Detalles de Ruta")
            {
                Caption = 'Detalles de Ruta';
                RunObject = Page 56131;
                RunPageLink = Code = FIELD(FILTER(Codigo));
                RunPageOnRec = false;

                trigger OnAction()
                var
                    recRutas: Record 56070;
                    recDetalleRutas: Record 56071;
                begin
                    recDetalleRutas.RESET;
                    recDetalleRutas.SETRANGE(recDetalleRutas.Code, recRutas.Codigo);
                end;
            }
        }
    }
}

