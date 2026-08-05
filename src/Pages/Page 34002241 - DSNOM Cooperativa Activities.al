page 55881 "DSNOM Cooperativa Activities"
{
    Caption = 'Employee fund''s activities';
    PageType = CardPart;
    SourceTable = 55810;

    layout
    {
        area(content)
        {
            cuegroup(Cooperative)
            {
                Caption = 'Cooperative';
                field("Afiliados cooperativa"; Rec."Afiliados cooperativa")
                {
                    ApplicationArea = All;
                    ToolTip = 'Afiliados cooperativa';
                    Image = People;
                }
                field("Miembros activos"; Rec."Miembros activos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Miembros activos';
                    Image = Person;
                }
                field("Miembros inactivos"; Rec."Miembros inactivos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Miembros inactivos';
                    Image = Person;
                }
                field("Prestamos activos"; Rec."Prestamos activos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Prestamos activos';
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
        // TODO: Manual review - The verified payroll codeunit declaration has no caller on this cue page.
        // Original code: FuncionesNom: Codeunit 55745;
        Fecha: Record 2000000007;
}

