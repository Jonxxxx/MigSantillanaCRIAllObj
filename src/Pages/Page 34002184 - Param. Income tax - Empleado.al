page 34002184 "Param. Income tax - Empleado"
{
    Caption = 'Employee - Income tax exceptions';
    PageType = List;
    SourceTable = 55757;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Employee No.';
                    Visible = false;
                }
                field("Exemption code"; Rec."Exemption code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Exemption code';
                }
                field("Wedge Code"; Rec."Wedge Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Wedge Code';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Status';
                }
                field("Exemption type"; Rec."Exemption type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Exemption type';
                }
                field("Personal Exemption"; Rec."Personal Exemption")
                {
                    ApplicationArea = All;
                    ToolTip = 'Personal Exemption';
                }
                field("Importe fijo"; Rec."Importe fijo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe fijo';
                }
                field("Exeption for Dependents"; Rec."Exeption for Dependents")
                {
                    ApplicationArea = All;
                    ToolTip = 'Exeption for Dependents';
                }
            }
        }
    }

    actions
    {
    }
}

