page 67124 "Solicitud - Especialidad"
{
    PageType = List;
    SourceTable = 67082;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Especialidad"; Rec."Cod. Especialidad")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Especialidad';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
            }
        }
    }

    actions
    {
    }
}

