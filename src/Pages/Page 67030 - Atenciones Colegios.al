page 67030 "Atenciones Colegios"
{
    PageType = Card;
    SourceTable = 67030;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Atencion"; Rec."Cod. Atencion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Atencion';
                    Visible = false;
                }
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                }
                field("Cod. promotor"; Rec."Cod. promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. promotor';
                }
                field("Cod. Delegacion"; Rec."Cod. Delegacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Delegacion';
                }
                field("Cod. Nivel"; Rec."Cod. Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Nivel';
                }
                field("Cod. Turno"; Rec."Cod. Turno")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Turno';
                }
                field("Description Atencion"; Rec."Description Atencion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Description Atencion';
                }
                field("Nombre Colegio"; Rec."Nombre Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Colegio';
                }
                field("Nombre Comercial"; Rec."Nombre Comercial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Comercial';
                }
                field("Fecha Entrega"; Rec."Fecha Entrega")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Entrega';
                }
                field(Cantidad; Rec.Cantidad)
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad';
                }
            }
        }
    }

    actions
    {
    }
}

