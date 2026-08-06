page 55281 "Grupos de almacenes"
{
    // 001 RRT 02.06.2014

    PageType = List;
    SourceTable = 55279;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Grupo; Rec.Grupo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Grupo';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
            }
            part(AlmacenesRelacionados; 55282)
            {
                SubPageLink = Grupo = FIELD("Grupo");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}

