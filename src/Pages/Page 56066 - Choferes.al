page 55287 Choferes
{
    // #2655 PLB 08/04/2014: Añadido campos calculados "Activo" y "Observaciones"

    PageType = List;
    SourceTable = 55266;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Chofer"; Rec."Cod. Chofer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Chofer';
                }
                field(Nombre; Rec.Nombre)
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre';
                }
                field("No. Licencia"; Rec."No. Licencia")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Licencia';
                }
                field(Activo; Rec.Activo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Activo';
                }
                field(Observaciones; Rec.Observaciones)
                {
                    ApplicationArea = All;
                    ToolTip = 'Observaciones';
                }
            }
        }
    }

    actions
    {
    }
}

