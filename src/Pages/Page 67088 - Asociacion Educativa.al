page 67088 "Asociacion Educativa"
{
    ApplicationArea = Basic, Suite, Service;
    PageType = List;
    SourceTable = 67002;
    SourceTableView = WHERE("Tipo registro" = CONST("Asociacion educativa"));
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
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
    }
}

