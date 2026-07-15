page 34003002 "Proveedor-Retencion Documento"
{
    Editable = false;
    PageType = List;
    SourceTable = 34003002;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Codigo Retencion"; "Codigo Retencion")
                {
                }
                field("Cta. Contable"; "Cta. Contable")
                {
                }
                field("Base Cálculo"; "Base Cálculo")
                {
                }
                field(Devengo; Devengo)
                {
                }
                field("Importe Retencion"; "Importe Retencion")
                {
                }
                field("Tipo Retencion"; "Tipo Retencion")
                {
                }
                field("Aplica Productos"; "Aplica Productos")
                {
                }
                field("Aplica Servicios"; "Aplica Servicios")
                {
                }
                field("Retencion ITBIS"; "Retencion ITBIS")
                {
                }
            }
        }
    }

    actions
    {
    }
}

