page 34002105 "Pagos Electronicos"
{
    Caption = 'Electronic Payment Income Distribution';
    PageType = List;
    SourceTable = 34002108;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("No. empleado"; "No. empleado")
                {
                    Visible = false;
                }
                field("Cod. Banco"; "Cod. Banco")
                {
                }
                field("Tipo Cuenta"; "Tipo Cuenta")
                {
                }
                field("Numero Cuenta"; "Numero Cuenta")
                {
                }
                field("Nro. tarjeta"; "Nro. tarjeta")
                {
                }
                field(Importe; Importe)
                {
                }
                field("Fecha vencimiento"; "Fecha vencimiento")
                {
                }
                field("Tipo Importe"; "Tipo Importe")
                {
                }
            }
        }
    }

    actions
    {
    }
}

