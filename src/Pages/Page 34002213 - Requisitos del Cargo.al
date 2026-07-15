page 34002213 "Requisitos del Cargo"
{
    Caption = 'Job requisites';
    PageType = List;
    SourceTable = 34002162;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Cargo"; "Cod. Cargo")
                {
                    Visible = false;
                }
                field("Cod. requisito"; "Cod. requisito")
                {
                }
                field("Cualificacion requerida"; "Cualificacion requerida")
                {
                }
                field(Requerido; Requerido)
                {
                }
            }
        }
    }

    actions
    {
    }
}

