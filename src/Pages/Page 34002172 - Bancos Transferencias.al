page 34002172 "Bancos Transferencias"
{
    Caption = 'Transfer Banks';
    PageType = List;
    SourceTable = 34002167;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Cod. Banco"; "Cod. Banco")
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Cod. Institucion Financiera"; "Cod. Institucion Financiera")
                {
                }
                field("ACH Reservas"; "ACH Reservas")
                {
                }
                field("Digito Chequeo"; "Digito Chequeo")
                {
                }
            }
        }
    }

    actions
    {
    }
}

