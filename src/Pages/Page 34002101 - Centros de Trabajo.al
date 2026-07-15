page 34002101 "Centros de Trabajo"
{
    PageType = List;
    SourceTable = 34002101;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Centro de trabajo"; "Centro de trabajo")
                {
                }
                field(Nombre; Nombre)
                {
                }
                field("Empresa cotizacion"; "Empresa cotizacion")
                {
                }
                field(Direccion; Direccion)
                {
                }
                field("C.P."; "C.P.")
                {
                }
                field(Poblacion; Poblacion)
                {
                }
                field(Provincia; Provincia)
                {
                }
                field("Fecha de Cierre Nomina"; "Fecha de Cierre Nomina")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Libro matricula")
            {
                Caption = '&Libro matricula';
                Promoted = true;
                PromotedCategory = Process;
                //TODO Ver 
                /*
                RunObject = Page 71107;
                RunPageLink = Field2 = FIELD("Centro de trabajo");*/
                Visible = false;
            }
        }
    }

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;
}

