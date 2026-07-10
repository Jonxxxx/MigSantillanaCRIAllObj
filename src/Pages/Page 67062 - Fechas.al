page 67062 Fechas
{
    Editable = false;
    PageType = ListPlus;
    SourceTable = Table2000000007;
    SourceTableView = WHERE(Period Type=CONST(Week));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Period Type";"Period Type")
                {
                }
                field("Period Start";"Period Start")
                {
                }
                field(NORMALDATE("Period End");NORMALDATE("Period End"))
                {
                    Caption = 'Period End';
                }
                field("Period No.";"Period No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}

