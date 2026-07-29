page 56042 "Puestos de empaque"
{
    PageType = List;
    SourceTable = 56036;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo';
                }
                field("Control Peso"; Rec."Control Peso")
                {
                    ApplicationArea = All;
                    ToolTip = 'Control Peso';
                }
                field("Usuario Asignado"; Rec."Usuario Asignado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Usuario Asignado';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
            }
        }
    }

    actions
    {
    }
}

