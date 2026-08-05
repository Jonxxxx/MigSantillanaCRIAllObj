page 55804 "Dias Fiestas"
{
    AdditionalSearchTerms = 'Holidays';
    ApplicationArea = Basic, Suite, BasicHR;
    Caption = 'Holidays';
    PageType = List;
    SourceTable = 55796;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field(Fecha; Rec.Fecha)
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha';
                }
                field("Dia Semana"; Rec."Dia Semana")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dia Semana';
                }
                field(Texto; Rec.Texto)
                {
                    ApplicationArea = All;
                    ToolTip = 'Texto';
                }
                field(Mes; Rec.Mes)
                {
                    ApplicationArea = All;
                    ToolTip = 'Mes';
                }
                field("Fecha original"; Rec."Fecha original")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha original';
                }
            }
        }
    }

    actions
    {
    }
}

