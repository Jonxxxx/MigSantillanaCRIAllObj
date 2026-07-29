page 34002230 "Area curricular"
{
    Caption = 'Knowledge area';
    DataCaptionFields = "Tipo registro";
    PageType = List;
    SourceTable = 34002151;
    SourceTableView = WHERE("Tipo registro" = CONST("Area curricular"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Code';
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

