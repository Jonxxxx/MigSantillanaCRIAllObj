page 34002146 "Datos adicionales"
{
    DataCaptionFields = "Tipo registro";
    PageType = List;
    SourceTable = 34002151;

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

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
        CurrPage.CAPTION := FORMAT("Tipo registro");
    end;
}

