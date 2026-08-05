page 55501 "Lista Colegio - Delegaciones"
{
    ApplicationArea = Basic, Suite, Service;
    Editable = false;
    PageType = Card;
    SourceTable = 55501;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No. Solicitud"; Rec."No. Solicitud")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Solicitud';
                    Visible = false;
                }
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                }
                field("Cod. Local"; Rec."Cod. Local")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Local';
                }
                field("Cod. Nivel"; Rec."Cod. Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Nivel';
                }
                field("Cod. Grado"; Rec."Cod. Grado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Grado';
                }
                field("Nombre Colegio"; Rec."Nombre Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Colegio';
                }
                field("Descripcion Nivel"; Rec."Descripcion Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Nivel';
                }
                field("Descripcion Grado"; Rec."Descripcion Grado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Grado';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Branch")
            {
                Caption = '&Branch';
                action("&Card")
                {
                    ApplicationArea = All;
                    Caption = '&Card';
                    ToolTip = '&Card';
                    Image = EditLines;
                    RunObject = Page 55514;
                    RunPageLink = "No. Solicitud" = FIELD("No. Solicitud");
                    ShortCutKey = 'Shift+F5';
                }
            }
        }
    }
}

