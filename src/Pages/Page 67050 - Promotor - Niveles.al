page 67050 "Promotor - Niveles"
{
    DataCaptionFields = "Cod. Promotor", "Nombre Promotor";
    PageType = Card;
    SourceTable = 67040;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Promotor"; "Cod. Promotor")
                {
                    Visible = false;
                }
                field("Cod. Nivel"; "Cod. Nivel")
                {
                }
                field("Nombre Promotor"; "Nombre Promotor")
                {
                    Editable = false;
                }
                field("Descripcion Nivel"; "Descripcion Nivel")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

