page 55288 "Chofer por Transportista"
{
    // #2655 PLB 08/04/2014: Añadido campos calculados "Activo" y "Observaciones"

    Caption = 'Chofer por Transportista';
    PageType = List;
    SourceTable = 55267;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Chofer"; Rec."Cod. Chofer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Chofer';
                }
                field("Nombre Chofer"; Rec."Nombre Chofer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Chofer';
                }
                field("No. Licencia"; Rec."No. Licencia")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Licencia';
                }
                field("Chofer activo"; Rec."Chofer activo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Chofer activo';
                }
                field("Observaciones chofer"; Rec."Observaciones chofer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Observaciones chofer';
                }
            }
        }
    }

    actions
    {
    }
}

