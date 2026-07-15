page 34002177 Shift
{
    PageType = List;
    SourceTable = 34002161;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Codigo; Codigo)
                {
                }
                field(Descripcion; Descripcion)
                {
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
                    Caption = 'Calendar';
                    Image = ProfileCalendar;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 34002200;
                    RunPageLink = "Codigo turno" = FIELD(Codigo);
                }
            }
        }
    }
}

