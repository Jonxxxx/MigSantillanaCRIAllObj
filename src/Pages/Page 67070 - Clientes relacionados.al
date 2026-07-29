page 67070 "Clientes relacionados"
{
    PageType = Card;
    SourceTable = 67003;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Cliente"; Rec."Cod. Cliente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Cliente';
                }
                field("Cod. Cliente Relacionado"; Rec."Cod. Cliente Relacionado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Cliente Relacionado';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("Descripcion Cte. Relacionado"; Rec."Descripcion Cte. Relacionado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Cte. Relacionado';
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                    ToolTip = 'Balance';
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Balance (LCY)';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Global Dimension 1 Code';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Global Dimension 2 Code';
                }
            }
        }
    }

    actions
    {
    }
}

