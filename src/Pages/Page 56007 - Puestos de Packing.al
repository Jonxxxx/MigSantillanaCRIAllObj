page 56007 "Puestos de Packing"
{
    Caption = 'Packing Position';
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
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
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
            }
        }
    }

    actions
    {
    }
}

