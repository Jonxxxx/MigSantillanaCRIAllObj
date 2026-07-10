page 67059 Aficiones
{
    ApplicationArea = Basic,"#Suite","#Service";
    Caption = 'Hobbies';
    PageType = List;
    SourceTable = Table67002;
    SourceTableView = SORTING(Tipo registro,Codigo)
                      WHERE(Tipo registro=CONST(Aficiones));
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Codigo;Codigo)
                {
                }
                field(Descripcion;Descripcion)
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
        "Tipo registro" := "Tipo registro"::Aficiones;
    end;
}

