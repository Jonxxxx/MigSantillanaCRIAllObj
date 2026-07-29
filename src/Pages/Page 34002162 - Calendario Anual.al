page 34002162 "Calendario Anual"
{
    PageType = List;
    SourceTable = 34002134;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                Editable = true;
                field(Fecha; Rec.Fecha)
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha';
                }
                field(Texto; Rec.Texto)
                {
                    ApplicationArea = All;
                    ToolTip = 'Texto';
                }
                field("No laborable"; Rec."No laborable")
                {
                    ApplicationArea = All;
                    ToolTip = 'No laborable';
                }
                field(Semana; Rec.Semana)
                {
                    ApplicationArea = All;
                    ToolTip = 'Semana';
                }
                field(Periodo; Rec.Periodo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Periodo';
                }
                field(Ano; Rec.Ano)
                {
                    ApplicationArea = All;
                    ToolTip = 'Ano';
                }
                field(Mes; Rec.Mes)
                {
                    ApplicationArea = All;
                    ToolTip = 'Mes';
                }
                field("Dia de la semana"; Rec."Dia de la semana")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dia de la semana';
                }
                field(Generado; Rec.Generado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Generado';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Calendar")
            {
                Caption = '&Calendar';
                action("Generate calendar")
                {
                    ApplicationArea = All;
                    Caption = 'Generate calendar';
                    ToolTip = 'Generate calendar';
                    Image = CalculateCalendar;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    // TODO: Manual review - Custom report 34002147 is unavailable; the current object with this ID is not a report.
                    // Original code: RunObject = Report 34002147;
                }
                action(Hollydays)
                {
                    ApplicationArea = All;
                    Caption = 'Hollydays';
                    ToolTip = 'Hollydays';
                    Image = Calendar;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 34002163;
                }
            }
        }
    }
}

