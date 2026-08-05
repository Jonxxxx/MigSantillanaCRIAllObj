page 55809 Departamentos
{
    AdditionalSearchTerms = 'Department';
    ApplicationArea = Basic, Suite, BasicHR;
    Caption = 'Department';
    PageType = List;
    SourceTable = 55776;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
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
                field(Inhabilitado; Rec.Inhabilitado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Inhabilitado';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Department")
            {
                Caption = '&Department';
                action("Sub Department")
                {
                    ApplicationArea = All;
                    Caption = 'Sub Department';
                    ToolTip = 'Sub Department';
                    Image = Departments;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 55810;
                    RunPageLink = "Cod. Departamento" = FIELD(Codigo);
                }
                action(Puestos)
                {
                    ApplicationArea = All;
                    Caption = 'Puestos';
                    ToolTip = 'Puestos';
                    Image = Position;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 55750;
                    RunPageLink = "Cod. departamento" = FIELD(Codigo);
                }
            }
        }
    }

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;
}

