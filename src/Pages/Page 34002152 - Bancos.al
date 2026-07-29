page 34002152 Bancos
{
    PageType = List;
    SourceTable = 34002139;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo';
                }
                field("Nombre banco"; Rec."Nombre banco")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre banco';
                }
                field("ID Banco"; Rec."ID Banco")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Banco';
                }
                field(Formato; Rec.Formato)
                {
                    ApplicationArea = All;
                    ToolTip = 'Formato';
                }
            }
        }
    }

    actions
    {
    }
}

