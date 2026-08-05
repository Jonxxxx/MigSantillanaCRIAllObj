page 55880 "DSNOM Nomina Activities"
{
    Caption = 'Payroll Activities';
    PageType = CardPart;
    SourceTable = 55810;

    layout
    {
        area(content)
        {
            cuegroup(Payroll)
            {
                Caption = 'Payroll';
                field("Employees with wire transfer"; Rec."Employees with wire transfer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Employees with wire transfer';
                    Image = Receipt;
                }
                field("Employees with check"; Rec."Employees with check")
                {
                    ApplicationArea = All;
                    ToolTip = 'Employees with check';
                    Image = Receipt;
                }
                field(Loans; Rec.Loans)
                {
                    ApplicationArea = All;
                    ToolTip = 'Loans';
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
        // TODO: Manual review - The verified payroll codeunit declaration has no caller on this cue page.
        // Original code: FuncionesNom: Codeunit 55745;
        Fecha: Record 2000000007;
}

