page 34003010 "NCF Anulados"
{
    Editable = false;
    PageType = List;
    SourceTable = 34003012;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("No. documento"; "No. documento")
                {
                }
                field("No. Comprobante Fiscal"; "No. Comprobante Fiscal")
                {
                }
                field("Fecha anulacion"; "Fecha anulacion")
                {
                }
                field("No. Serie NCF Abonos"; "No. Serie NCF Abonos")
                {
                    Visible = false;
                }
                field("No. Serie NCF Facturas"; "No. Serie NCF Facturas")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

