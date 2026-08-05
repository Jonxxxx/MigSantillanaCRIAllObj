page 34002225 "Tipos de prestamos"
{
    Caption = 'Loan types';
    DataCaptionFields = "Tipo registro";
    PageType = List;
    SourceTable = 55792;
    SourceTableView = WHERE("Tipo registro" = CONST("Tipo de Prestamo"));

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

