page 55854 "Requisitos del Cargo"
{
    Caption = 'Job requisites';
    PageType = List;
    SourceTable = 55803;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Cargo"; Rec."Cod. Cargo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Cargo';
                    Visible = false;
                }
                field("Cod. requisito"; Rec."Cod. requisito")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. requisito';
                }
                field("Cualificacion requerida"; Rec."Cualificacion requerida")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cualificacion requerida';
                }
                field(Requerido; Rec.Requerido)
                {
                    ApplicationArea = All;
                    ToolTip = 'Requerido';
                }
            }
        }
    }

    actions
    {
    }
}

