page 55810 "Sub-Departamento"
{
    Caption = 'Sub-Department';
    PageType = List;
    SourceTable = 55777;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Cod. Departamento"; Rec."Cod. Departamento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Departamento';
                    Visible = false;
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
                field("Total Empleados"; Rec."Total Empleados")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total Empleados';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;
}

