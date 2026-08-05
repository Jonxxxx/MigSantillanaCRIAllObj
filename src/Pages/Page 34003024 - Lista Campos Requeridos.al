page 55976 "Lista Campos Requeridos"
{
    ApplicationArea = All;
    CardPageID = "Cab. Campos Requeridos";
    Editable = false;
    PageType = List;
    SourceTable = 55972;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. Tabla"; Rec."No. Tabla")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Tabla';
                }
                field(Nombre; Rec.Nombre)
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre';
                }
                field(Activo; Rec.Activo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Activo';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

