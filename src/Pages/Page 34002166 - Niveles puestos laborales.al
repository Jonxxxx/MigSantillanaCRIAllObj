page 55807 "Niveles puestos laborales"
{
    Caption = 'Job type levels';
    DataCaptionFields = "Cod. Nivel", Descripcion;
    PageType = List;
    SourceTable = 55761;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Cod. Nivel"; Rec."Cod. Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Nivel';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("Importe minimo"; Rec."Importe minimo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe minimo';
                }
                field("Importe Medio"; Rec."Importe Medio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Medio';
                }
                field("Importe Maximo"; Rec."Importe Maximo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Maximo';
                }
            }
        }
    }

    actions
    {
    }
}

