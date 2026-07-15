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
                field("Active Employees"; "Active Employees")
                {
                    Image = People;
                }
                field("Inactives Employees"; "Inactives Employees")
                {
                    Image = People;
                }
                //TODO: Ver 
                /*
                field(FuncionesNom.AniversarioEmpleados;
                    FuncionesNom.AniversarioEmpleados)
                {
                    Caption = 'Empl. anniversary';
                    DecimalPlaces = 0 : 2;
                    Image = Time;
                    Style = Attention;
                    StyleExpr = TRUE;

                    trigger OnDrillDown()
                    begin
                        FuncionesNom.MuestraAniversarioEmpl;
                    end;
                }*/
                field("New hires"; "New hires")
                {
                    Image = People;
                }
                field("Employee departures"; "Employee departures")
                {
                    Image = People;
                }
                field("Contract to expire"; "Contract to expire")
                {
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
        //TODO: Ver //TODO: Ver FuncionesNom: Codeunit 34002104;
        Fecha: Record 2000000007;
}

