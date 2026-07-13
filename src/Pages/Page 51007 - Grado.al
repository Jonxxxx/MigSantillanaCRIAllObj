page 51007 Grado
{
    Caption = 'Grade';
    PageType = List;
    SourceTable = 51012;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Grado"; "Cod. Grado")
                {
                }
                field(Descripcion; Descripcion)
                {
                }
            }
        }
    }

    actions
    {
    }
}

