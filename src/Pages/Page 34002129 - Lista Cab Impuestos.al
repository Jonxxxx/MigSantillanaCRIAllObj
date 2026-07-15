page 34002129 "Lista Cab Impuestos"
{
    CardPageID = "Historico Cab. Impuestos";
    Editable = false;
    PageType = List;
    SourceTable = 34002121;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Tipo de nomina"; "Tipo de nomina")
                {
                }
                field("Tipo Nomina"; "Tipo Nomina")
                {
                    Visible = false;
                }
                field("No. Documento"; "No. Documento")
                {
                }
                field("Unidad cotizacion"; "Unidad cotizacion")
                {
                }
                field(Periodo; Periodo)
                {
                }
                field("No. Contabilizacion"; "No. Contabilizacion")
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
    end;
}

