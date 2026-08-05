page 55690 "Conf. Estructura Analitica"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = 55690;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Id; Rec.Id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Id';
                    Visible = false;
                }
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo';
                }
                field(Nivel; Rec.Nivel)
                {
                    ApplicationArea = All;
                    ToolTip = 'Nivel';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("Id Field"; Rec."Id Field")
                {
                    ApplicationArea = All;
                    ToolTip = 'Id Field';
                }
                field(FieldName; Rec.FieldName)
                {
                    ApplicationArea = All;
                    ToolTip = 'FieldName';
                }
                field(Valor; Rec.Valor)
                {
                    ApplicationArea = All;
                    ToolTip = 'Valor';
                }
            }
        }
    }

    actions
    {
    }
}

