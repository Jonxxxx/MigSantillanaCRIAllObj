page 34002215 "Distribucion ED Empleados"
{
    Caption = 'Employee JE distribution';
    PageType = List;
    SourceTable = 34002190;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee no."; "Employee no.")
                {
                    Visible = false;
                }
                field("Concepto salarial"; "Concepto salarial")
                {
                    Visible = false;
                }
                field("Dimension Code"; "Dimension Code")
                {
                }
                field(Codigo; Codigo)
                {
                }
                field(Descripcion; Descripcion)
                {
                    Editable = false;
                }
                field("% a distribuir"; "% a distribuir")
                {
                }
            }
        }
    }

    actions
    {
    }
}

