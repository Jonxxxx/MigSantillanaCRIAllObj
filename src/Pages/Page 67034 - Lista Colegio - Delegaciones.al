page 67034 "Lista Colegio - Delegaciones"
{
    ApplicationArea = Basic, Suite, Service;
    Editable = false;
    PageType = Card;
    SourceTable = 67034;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No. Solicitud"; "No. Solicitud")
                {
                    Visible = false;
                }
                field("Cod. Colegio"; "Cod. Colegio")
                {
                }
                field("Cod. Local"; "Cod. Local")
                {
                }
                field("Cod. Nivel"; "Cod. Nivel")
                {
                }
                field("Cod. Grado"; "Cod. Grado")
                {
                }
                field("Nombre Colegio"; "Nombre Colegio")
                {
                }
                field("Descripcion Nivel"; "Descripcion Nivel")
                {
                }
                field("Descripcion Grado"; "Descripcion Grado")
                {
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
                    Caption = '&Card';
                    Image = EditLines;
                    RunObject = Page 67047;
                    RunPageLink = "No. Solicitud" = FIELD("No. Solicitud");
                    ShortCutKey = 'Shift+F5';
                }
            }
        }
    }
}

