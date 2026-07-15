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
                field(Fecha; Fecha)
                {
                }
                field(Texto; Texto)
                {
                }
                field("No laborable"; "No laborable")
                {
                }
                field(Semana; Semana)
                {
                }
                field(Periodo; Periodo)
                {
                }
                field(Ano; Ano)
                {
                }
                field(Mes; Mes)
                {
                }
                field("Dia de la semana"; "Dia de la semana")
                {
                }
                field(Generado; Generado)
                {
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
                    Caption = 'Generate calendar';
                    Image = CalculateCalendar;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    //TODO: Ver RunObject = Report 34002147;
                }
                action(Hollydays)
                {
                    Caption = 'Hollydays';
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

