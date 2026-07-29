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
                field("DNI Padre"; Rec."DNI Padre")
                {
                    ApplicationArea = All;
                    ToolTip = 'DNI Padre';
                    Visible = false;
                }
                field("Cod. Area Interes"; Rec."Cod. Area Interes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Area Interes';
                }
                field("Nombre Padre"; Rec."Nombre Padre")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Padre';
                    Editable = false;
                }
                field("Descripcion Area Interes"; Rec."Descripcion Area Interes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Area Interes';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

