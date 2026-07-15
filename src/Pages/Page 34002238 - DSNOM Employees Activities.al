page 34002238 "DSNOM Employees Activities"
{
    Caption = 'Employee Activities';
    PageType = CardPart;
    SourceTable = 34002169;

    layout
    {
        area(content)
        {
            cuegroup(Employees)
            {
                Caption = 'Employees';
                field(Cumple; "Birthday of the month")
                {
                    Caption = 'Current month birthdays';
                    Image = calendar;
                }
                field("Male Employees"; "Male Employees")
                {
                    Image = Person;
                }
                field("Female Employees"; "Female Employees")
                {
                    Image = Person;
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
        //TODO: Ver  //TODO: Ver FuncionesNom: Codeunit 34002104;
        Fecha: Record 2000000007;
}

