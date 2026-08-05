page 55868 "Tipos de entrenamientos"
{
    Caption = 'Training types';
    DataCaptionFields = "Tipo registro";
    PageType = List;
    SourceTable = 55792;
    SourceTableView = WHERE("Tipo registro" = CONST("Tipo Entrenamiento"));

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

