page 55787 "Datos adicionales"
{
    DataCaptionFields = "Tipo registro";
    PageType = List;
    SourceTable = 55792;

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

