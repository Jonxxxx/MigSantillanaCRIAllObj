page 34002227 "Tipos de entrenamientos"
{
    Caption = 'Training types';
    DataCaptionFields = "Tipo registro";
    PageType = List;
    SourceTable = 34002151;
    SourceTableView = WHERE("Tipo registro" = CONST("Tipo Entrenamiento"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
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
    }
}

