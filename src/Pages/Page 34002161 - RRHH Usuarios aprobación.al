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
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'User ID';

                    trigger OnValidate()
                    begin
                        CALCFIELDS("Full name");
                    end;
                }
                field("Full name"; Rec."Full name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Full name';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'E-Mail';
                }
                field("Revisado por"; Rec."Revisado por")
                {
                    ApplicationArea = All;
                    ToolTip = 'Revisado por';
                }
                field("Autorizado por"; Rec."Autorizado por")
                {
                    ApplicationArea = All;
                    ToolTip = 'Autorizado por';
                }
                field("Visualiza salario"; Rec."Visualiza salario")
                {
                    ApplicationArea = All;
                    ToolTip = 'Visualiza salario';
                }
                field("Visualiza Calc. Nomina"; Rec."Visualiza Calc. Nomina")
                {
                    ApplicationArea = All;
                    ToolTip = 'Visualiza Calc. Nomina';
                }
            }
        }
    }

    actions
    {
    }
}

