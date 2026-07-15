page 34002241 "DSNOM Cooperativa Activities"
{
    Caption = 'Employee fund''s activities';
    PageType = CardPart;
    SourceTable = 34002169;

    layout
    {
        area(content)
        {
            cuegroup(Cooperative)
            {
                Caption = 'Cooperative';
                field("Afiliados cooperativa"; "Afiliados cooperativa")
                {
                    Image = People;
                }
                field("Miembros activos"; "Miembros activos")
                {
                    Image = Person;
                }
                field("Miembros inactivos"; "Miembros inactivos")
                {
                    Image = Person;
                }
                field("Prestamos activos"; "Prestamos activos")
                {
                    Image = Cash;
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

