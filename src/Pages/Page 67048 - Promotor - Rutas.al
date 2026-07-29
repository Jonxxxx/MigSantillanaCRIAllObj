page 67048 "Promotor - Rutas"
{
    ApplicationArea = Basic, Suite, Service;
    PageType = List;
    SourceTable = 67044;
    UsageCategory = Tasks;

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
                }
                field("Nombre Promotor"; Rec."Nombre Promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Promotor';
                    Editable = false;
                }
                field("Cod. Ruta"; Rec."Cod. Ruta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Ruta';
                }
                field("Descripcion Ruta"; Rec."Descripcion Ruta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Ruta';
                    Editable = false;
                }
                field("Cod. Zona"; Rec."Cod. Zona")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Zona';
                }
                field("Descripcion zona"; Rec."Descripcion zona")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion zona';
                    Editable = false;
                }
                field("Cod. Supervisor"; Rec."Cod. Supervisor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Supervisor';
                }
                field("Nombre Supervisor"; Rec."Nombre Supervisor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Supervisor';
                    Editable = false;
                }
                field(Delegacion; Rec.Delegacion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Delegacion';
                }
                field("Descripcion Delegacion"; Rec."Descripcion Delegacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Delegacion';
                }
            }
        }
    }

    actions
    {
    }
}

