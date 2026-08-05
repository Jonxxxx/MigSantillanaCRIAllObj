page 34002237 "DSNOM HR Activities"
{
    Caption = 'HR Activities';
    PageType = CardPart;
    SourceTable = 34002169;

    layout
    {
        area(content)
        {
            cuegroup("Human Resource")
            {
                Caption = 'Human Resource';
                field("Active Employees"; Rec."Active Employees")
                {
                    ApplicationArea = All;
                    ToolTip = 'Active Employees';
                    Image = People;
                }
                field("Inactives Employees"; Rec."Inactives Employees")
                {
                    ApplicationArea = All;
                    ToolTip = 'Inactives Employees';
                    Image = People;
                }
                field(FuncionesNomAniversarioEmpleados;
                FuncionesNom.AniversarioEmpleados)
                {
                    ApplicationArea = All;
                    Caption = 'Empl. anniversary';
                    DecimalPlaces = 0 : 2;
                    Image = Time;
                    Style = Attention;
                    StyleExpr = TRUE;

                    trigger OnDrillDown()
                    begin
                        FuncionesNom.MuestraAniversarioEmpl;
                    end;
                }
                field("New hires"; Rec."New hires")
                {
                    ApplicationArea = All;
                    ToolTip = 'New hires';
                    Image = People;
                }
                field("Employee departures"; Rec."Employee departures")
                {
                    ApplicationArea = All;
                    ToolTip = 'Employee departures';
                    Image = People;
                }
                field("Contract to expire"; Rec."Contract to expire")
                {
                    ApplicationArea = All;
                    ToolTip = 'Contract to expire';
                    Enabled = false;
                    Image = People;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        RESET;
        IF NOT GET THEN BEGIN
            INIT;
            INSERT;
        END;

        Fecha.RESET;
        Fecha.SETRANGE("Period Start", DMY2DATE(1, DATE2DMY(WORKDATE, 2), DATE2DMY(WORKDATE, 3)));
        Fecha.SETRANGE("Period Type", Fecha."Period Type"::Month);
        Fecha.FINDFIRST;
        SETRANGE("Date Filter", Fecha."Period Start", Fecha."Period End");

        SETRANGE("Birth Month filter", DATE2DMY(WORKDATE, 2));
    end;

    var
        FuncionesNom: Codeunit 55745;
        Fecha: Record 2000000007;
}

