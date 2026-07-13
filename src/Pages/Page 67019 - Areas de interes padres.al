page 67019 "Areas de interes padres"
{
    PageType = Card;
    SourceTable = 67019;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("DNI Padre"; "DNI Padre")
                {
                    Visible = false;
                }
                field("Cod. Area Interes"; "Cod. Area Interes")
                {
                }
                field("Nombre Padre"; "Nombre Padre")
                {
                    Editable = false;
                }
                field("Descripcion Area Interes"; "Descripcion Area Interes")
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

