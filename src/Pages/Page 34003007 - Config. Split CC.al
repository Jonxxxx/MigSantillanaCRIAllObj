page 55962 "Config. Split CC"
{
    PageType = List;
    SourceTable = 55965;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cta. Contable"; Rec."Cta. Contable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cta. Contable';
                    Visible = false;
                }
                field("Descripcion Cta. Contable"; Rec."Descripcion Cta. Contable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Cta. Contable';
                }
                field("Dimension Code"; Rec."Dimension Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dimension Code';
                }
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
                field("% a distribuir"; Rec."% a distribuir")
                {
                    ApplicationArea = All;
                    ToolTip = '% a distribuir';
                }
            }
        }
    }

    actions
    {
    }
}

