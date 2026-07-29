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

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
        CurrPage.CAPTION := FORMAT("Tipo registro");
    end;
}

