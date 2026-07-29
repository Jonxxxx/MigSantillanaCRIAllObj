page 51010 "Vendedores por Colegio"
{
    PageType = List;
    SourceTable = 51014;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Vendedor"; Rec."Cod. Vendedor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Vendedor';
                }
                field("Nombre Vendedor"; Rec."Nombre Vendedor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Vendedor';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

