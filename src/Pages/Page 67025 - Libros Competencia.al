page 67025 "Libros Competencia"
{
    PageType = List;
    SourceTable = 67025;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Editorial"; "Cod. Editorial")
                {
                    TableRelation = Editoras;
                }
                field("Cod. Libro"; "Cod. Libro")
                {
                }
                field(Nivel; Nivel)
                {
                }
                field(Description; Description)
                {
                }
                field("Grupo de Negocio"; "Grupo de Negocio")
                {
                }
                field("Cod. Grado"; "Cod. Grado")
                {
                }
                field("Cod. Libro Santillana"; "Cod. Libro Santillana")
                {
                }
                field("Description Santillana"; "Description Santillana")
                {
                    Editable = false;
                }
                field("Nombre Editorial"; "Nombre Editorial")
                {
                    Visible = false;
                }
                field(Precio; Precio)
                {
                }
                field("Año Edición"; "Ano Edicion")
                {
                }
                field("Año Uso"; "Ano Uso")
                {
                }
            }
        }
    }

    actions
    {
    }
}

