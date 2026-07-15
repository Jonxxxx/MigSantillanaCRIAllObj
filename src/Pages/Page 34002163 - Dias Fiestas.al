page 34002163 "Dias Fiestas"
{
    AdditionalSearchTerms = 'Holidays';
    ApplicationArea = Basic, Suite, BasicHR;
    Caption = 'Holidays';
    PageType = List;
    SourceTable = 34002155;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field(Fecha; Fecha)
                {
                }
                field("Dia Semana"; "Dia Semana")
                {
                }
                field(Texto; Texto)
                {
                }
                field(Mes; Mes)
                {
                }
                field("Fecha original"; "Fecha original")
                {
                }
            }
        }
    }

    actions
    {
    }
}

