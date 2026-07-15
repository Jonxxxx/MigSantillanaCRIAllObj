page 34002117 "Lista Empresas de cotizacion"
{
    PageType = List;
    SourceTable = 34002100;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Empresa cotizacion"; "Empresa cotizacion")
                {
                }
                field("Nombre Empresa cotizacion"; "Nombre Empresa cotizacion")
                {
                }
                field("Esquema percepcion"; "Esquema percepcion")
                {
                }
                field(Fax; Fax)
                {
                }
                field("E-Mail"; "E-Mail")
                {
                }
                field("ID RNL"; "ID RNL")
                {
                }
                field("ID TSS"; "ID TSS")
                {
                }
                field("Tipo Empresa de Trabajo"; "Tipo Empresa de Trabajo")
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

