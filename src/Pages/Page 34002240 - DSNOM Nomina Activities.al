page 34002240 "DSNOM Nomina Activities"
{
    Caption = 'Payroll Activities';
    PageType = CardPart;
    SourceTable = 34002169;

    layout
    {
        area(content)
        {
            cuegroup(Payroll)
            {
                Caption = 'Payroll';
                field("Employees with wire transfer"; "Employees with wire transfer")
                {
                    Image = Receipt;
                }
                field("Employees with check"; "Employees with check")
                {
                    Image = Receipt;
                }
                field(Loans; Loans)
                {
                    Image = Receipt;
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
        //TODO: Ver FuncionesNom: Codeunit 34002104;
        Fecha: Record 2000000007;
}

