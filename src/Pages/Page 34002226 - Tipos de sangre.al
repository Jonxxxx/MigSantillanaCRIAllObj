page 34002226 "Tipos de sangre"
{
    Caption = 'Blood types';
    DataCaptionFields = "Tipo registro";
    PageType = List;
    SourceTable = 34002151;
    SourceTableView = WHERE("Tipo registro" = CONST("Tipo de Sangre"));

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

