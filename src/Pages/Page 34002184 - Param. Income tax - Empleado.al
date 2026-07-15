page 34002184 "Param. Income tax - Empleado"
{
    Caption = 'Employee - Income tax exceptions';
    PageType = List;
    SourceTable = 34002116;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; "Employee No.")
                {
                    Visible = false;
                }
                field("Exemption code"; "Exemption code")
                {
                }
                field("Wedge Code"; "Wedge Code")
                {
                }
                field(Status; Status)
                {
                }
                field("Exemption type"; "Exemption type")
                {
                }
                field("Personal Exemption"; "Personal Exemption")
                {
                }
                field("Importe fijo"; "Importe fijo")
                {
                }
                field("Exeption for Dependents"; "Exeption for Dependents")
                {
                }
            }
        }
    }

    actions
    {
    }
}

