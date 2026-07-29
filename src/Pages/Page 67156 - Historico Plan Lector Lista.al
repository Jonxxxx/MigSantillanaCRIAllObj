page 67156 "Historico Plan Lector Lista"
{
    ApplicationArea = Basic, Suite, Service;
    CardPageID = "Historico Plan Lector Ficha";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 67095;
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Campaña; Rec.Campana)
                {
                    ApplicationArea = All;
                    ToolTip = 'Campana';
                }
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                }
                field("Nombre Colegio"; Rec."Nombre Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Colegio';
                }
                field("Cod. Local"; Rec."Cod. Local")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Local';
                }
                field("Descripcion Local"; Rec."Descripcion Local")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Local';
                }
                field("Cod. Turno"; Rec."Cod. Turno")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Turno';
                }
                field("Descripcion Turno"; Rec."Descripcion Turno")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Turno';
                }
                field(Distrito; Rec.Distrito)
                {
                    ApplicationArea = All;
                    ToolTip = 'Distrito';
                }
                field("Cod. Delegacion"; Rec."Cod. Delegacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Delegacion';
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

