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
                field("Cod. Promotor"; Rec."Cod. Promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Promotor';
                    Visible = false;
                }
                field("Cod. Nivel"; Rec."Cod. Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Nivel';
                }
                field("Nombre Promotor"; Rec."Nombre Promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Promotor';
                    Editable = false;
                }
                field("Descripcion Nivel"; Rec."Descripcion Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Nivel';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

