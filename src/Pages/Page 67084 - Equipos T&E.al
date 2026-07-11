page 67084 "Equipos T&E"
{
    Caption = 'Equipment Workshops and Events';
    DataCaptionExpression = FORMAT("Tipo registro");
    PageType = Card;
    SourceTable = 67002;
    SourceTableView = SORTING("Tipo registro", Codigo)
                      WHERE("Tipo registro" = CONST("Equipos T&E"));

    layout
    {
        area(content)
        {
            repeater()
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
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Tipo registro" := "Tipo registro"::"Equipos T&E";
    end;
}

