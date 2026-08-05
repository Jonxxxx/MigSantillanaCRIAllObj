page 55818 Shift
{
    PageType = List;
    SourceTable = 55802;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Shift)
            {
                Caption = 'Shift';
                action(Calendar)
                {
                    ApplicationArea = All;
                    Caption = 'Calendar';
                    ToolTip = 'Calendar';
                    Image = ProfileCalendar;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 55841;
                    RunPageLink = "Codigo turno" = FIELD(Codigo);
                }
            }
        }
    }
}

