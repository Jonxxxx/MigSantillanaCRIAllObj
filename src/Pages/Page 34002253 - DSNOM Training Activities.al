page 55892 "DSNOM Training Activities"
{
    Caption = 'Training activities';
    PageType = CardPart;
    SourceTable = 55810;

    layout
    {
        area(content)
        {
            cuegroup(Trainings)
            {
                Caption = 'Trainings';
                field("Entrenamientos activos"; Rec."Entrenamientos activos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Entrenamientos activos';
                    Image = People;
                }
                field("Entrenamientos del mes"; Rec."Entrenamientos del mes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Entrenamientos del mes';
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
        // TODO: Manual review - The verified payroll codeunit declaration has no caller on this cue page.
        // Original code: FuncionesNom: Codeunit 55745;
        Fecha: Record 2000000007;
}

