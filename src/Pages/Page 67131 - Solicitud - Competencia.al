page 55590 "Solicitud - Competencia"
{
    PageType = List;
    SourceTable = 55649;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Editorial"; Rec."Cod. Editorial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Editorial';
                }
                field("Cod. Libro"; Rec."Cod. Libro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Libro';
                }
                field(Nivel; Rec.Nivel)
                {
                    ApplicationArea = All;
                    ToolTip = 'Nivel';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description';
                    Editable = false;
                }
                field("Cod. Grado"; Rec."Cod. Grado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Grado';
                    Editable = false;
                }
                field("Nombre Editorial"; Rec."Nombre Editorial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Editorial';
                    Editable = false;
                }
                field("Horas a la semana"; Rec."Horas a la semana")
                {
                    ApplicationArea = All;
                    ToolTip = 'Horas a la semana';
                }
                field("Año adopcion"; Rec."Ano adopcion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ano adopcion';
                }
            }
        }
    }

    actions
    {
    }
}

