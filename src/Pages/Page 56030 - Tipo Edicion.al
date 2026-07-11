page 56030 "Tipo Edicion"
{
    Caption = 'Edtion Type';
    PageType = List;
    SourceTable = 56004;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Tipo Edicion"; "Cod. Tipo Edicion")
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

