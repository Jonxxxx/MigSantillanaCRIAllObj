page 34002118 "Niveles - Grados RH"
{
    Caption = 'Level - Grades';
    PageType = List;
    SourceTable = 34002151;
    //TODO: Ver SourceTableView = WHERE("Tipo registro"=CONST(Niveles-Grados));

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
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

