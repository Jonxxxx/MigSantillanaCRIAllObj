page 34002159 "Beneficios puestos laborales"
{
    Caption = 'Benefits list';
    PageType = List;
    SourceTable = 34002152;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Tipo Beneficio"; "Tipo Beneficio")
                {
                }
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
}

