page 67122 "Solicitud -  Nivel Asistentes"
{
    PageType = List;
    SourceTable = 67080;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Nivel"; Rec."Cod. Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Nivel';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("No. Asistentes"; Rec."No. Asistentes")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Asistentes';
                }
            }
        }
    }

    actions
    {
    }
}

