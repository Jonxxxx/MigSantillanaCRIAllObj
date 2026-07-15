page 34002161 "RRHH Usuarios aprobacion"
{
    Caption = 'HR User authorization';
    PageType = List;
    SourceTable = 34002154;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("User ID"; "User ID")
                {

                    trigger OnValidate()
                    begin
                        CALCFIELDS("Full name");
                    end;
                }
                field("Full name"; "Full name")
                {
                }
                field("E-Mail"; "E-Mail")
                {
                }
                field("Revisado por"; "Revisado por")
                {
                }
                field("Autorizado por"; "Autorizado por")
                {
                }
                field("Visualiza salario"; "Visualiza salario")
                {
                }
                field("Visualiza Calc. Nomina"; "Visualiza Calc. Nomina")
                {
                }
            }
        }
    }

    actions
    {
    }
}

