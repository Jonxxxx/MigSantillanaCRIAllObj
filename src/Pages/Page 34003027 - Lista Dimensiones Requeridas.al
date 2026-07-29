page 34003027 "Lista Dimensiones Requeridas"
{
    ApplicationArea = Basic, Suite, Service;
    CardPageID = "Cab. Dimensiones Requeridas";
    Editable = false;
    PageType = List;
    SourceTable = 34003022;
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
                }
            }
        }
    }

    actions
    {
    }
}

