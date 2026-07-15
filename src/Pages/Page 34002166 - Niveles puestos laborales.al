page 34002166 "Niveles puestos laborales"
{
    Caption = 'Job type levels';
    DataCaptionFields = "Cod. Nivel", Descripcion;
    PageType = List;
    SourceTable = 34002120;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Cod. Nivel"; "Cod. Nivel")
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Importe minimo"; "Importe minimo")
                {
                }
                field("Importe Medio"; "Importe Medio")
                {
                }
                field("Importe máximo"; "Importe máximo")
                {
                }
            }
        }
    }

    actions
    {
    }
}

