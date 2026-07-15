page 34002225 "Tipos de prestamos"
{
    Caption = 'Loan types';
    DataCaptionFields = "Tipo registro";
    PageType = List;
    SourceTable = 34002151;
    SourceTableView = WHERE("Tipo registro" = CONST("Tipo de préstamo"));

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

