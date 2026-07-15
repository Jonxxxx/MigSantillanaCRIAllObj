page 34002168 Departamentos
{
    AdditionalSearchTerms = 'Department';
    ApplicationArea = Basic, Suite, BasicHR;
    Caption = 'Department';
    PageType = List;
    SourceTable = 34002135;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field(Codigo; Codigo)
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Total Empleados"; "Total Empleados")
                {
                }
                field(Inhabilitado; Inhabilitado)
                {
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
                    Caption = 'Sub Department';
                    Image = Departments;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 34002169;
                    RunPageLink = "Cod. Departamento" = FIELD(Codigo);
                }
                action(Puestos)
                {
                    Image = Position;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 34002109;
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

