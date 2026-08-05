page 34002239 "DSNOM Vacaciones Activities"
{
    Caption = 'Vacation''s Activities';
    PageType = CardPart;
    SourceTable = 34002169;

    layout
    {
        area(content)
        {
            cuegroup(Vacation)
            {
                Caption = 'Vacation';
                field(FuncionesNomVacacionesporVencer;
                FuncionesNom.VacacionesporVencer)
                {
                    ApplicationArea = All;
                    Caption = 'vacation to expire';
                    DecimalPlaces = 0 : 2;
                    Image = Calendar;

                    trigger OnDrillDown()
                    begin
                        FuncionesNom.MuestraVacporVencer;
                    end;
                }
                field("Vacation to start"; Rec."Vacation to start")
                {
                    ApplicationArea = All;
                    ToolTip = 'Vacation to start';
                    Image = Calendar;
                }
                field("Vacation to finish"; Rec."Vacation to finish")
                {
                    ApplicationArea = All;
                    ToolTip = 'Vacation to finish';
                    Image = Calendar;
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

