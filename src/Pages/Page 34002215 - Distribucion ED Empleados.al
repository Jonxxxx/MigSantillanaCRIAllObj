page 55856 "Distribucion ED Empleados"
{
    Caption = 'Employee JE distribution';
    PageType = List;
    SourceTable = 55831;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee no."; Rec."Employee no.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Employee no.';
                    Visible = false;
                }
                field("Concepto salarial"; Rec."Concepto salarial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Concepto salarial';
                    Visible = false;
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
                    Editable = false;
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

