page 55492 "Libros Competencia"
{
    PageType = List;
    SourceTable = 55492;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Editorial"; Rec."Cod. Editorial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Editorial';
                    TableRelation = Editoras;
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
                }
                field("Grupo de Negocio"; Rec."Grupo de Negocio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Grupo de Negocio';
                }
                field("Cod. Grado"; Rec."Cod. Grado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Grado';
                }
                field("Cod. Libro Santillana"; Rec."Cod. Libro Santillana")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Libro Santillana';
                }
                field("Description Santillana"; Rec."Description Santillana")
                {
                    ApplicationArea = All;
                    ToolTip = 'Description Santillana';
                    Editable = false;
                }
                field("Nombre Editorial"; Rec."Nombre Editorial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Editorial';
                    Visible = false;
                }
                field(Precio; Rec.Precio)
                {
                    ApplicationArea = All;
                    ToolTip = 'Precio';
                }
                field("Año Edicion"; Rec."Ano Edicion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ano Edicion';
                }
                field("Año Uso"; Rec."Ano Uso")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ano Uso';
                }
            }
        }
    }

    actions
    {
    }
}

