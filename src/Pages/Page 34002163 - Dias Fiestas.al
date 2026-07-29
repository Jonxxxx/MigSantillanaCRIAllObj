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

