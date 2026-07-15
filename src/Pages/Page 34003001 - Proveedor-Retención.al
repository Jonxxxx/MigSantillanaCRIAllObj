page 34003001 "Proveedor-Retencion"
{
    PageType = List;
    SourceTable = 34003001;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Codigo Retencion"; "Codigo Retencion")
                {

                    trigger OnValidate()
                    begin
                        rMaestroRet.RESET;
                        rMaestroRet.SETRANGE("Codigo Retencion", "Codigo Retencion");
                        IF rMaestroRet.FIND('-') THEN BEGIN
                            "Cta. Contable" := rMaestroRet."Cta. Contable";
                            "Base Cálculo" := rMaestroRet."Base Cálculo";
                            Devengo := rMaestroRet.Devengo;
                            "Importe Retencion" := rMaestroRet."Importe Retencion";
                            "Tipo Retencion" := rMaestroRet."Tipo Retencion";
                            "Aplica Productos" := rMaestroRet."Aplica Productos";
                            "Aplica Servicios" := rMaestroRet."Aplica Servicios";
                        END;
                    end;
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

    var
        rMaestroRet: Record 34003000;
}

