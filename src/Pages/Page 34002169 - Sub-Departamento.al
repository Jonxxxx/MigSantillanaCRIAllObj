page 34002169 "Sub-Departamento"
{
    Caption = 'Sub-Department';
    PageType = List;
    SourceTable = 34002136;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Cod. Departamento"; "Cod. Departamento")
                {
                    Visible = false;
                }
                field(Codigo; Codigo)
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Total Empleados"; "Total Empleados")
                {
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

