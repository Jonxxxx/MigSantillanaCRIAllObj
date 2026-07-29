page 67162 "Consulta Distrib. Centro Costo"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 67086;

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
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field(Porcentaje; Rec.Porcentaje)
                {
                    ApplicationArea = All;
                    ToolTip = 'Porcentaje';
                }
            }
        }
    }

    actions
    {
    }
}

