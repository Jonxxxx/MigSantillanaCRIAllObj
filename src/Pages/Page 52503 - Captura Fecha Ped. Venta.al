page 52503 "Captura Fecha Ped. Venta"
{
    PageType = StandardDialog;

    layout
    {
        area(content)
        {
            field("Fecha Desde";FechaDesde)
            {
            }
            field("Fecha Hasta";FechaHasta)
            {
            }
        }
    }

    actions
    {
    }

    var
        FechaDesde: Date;
        FechaHasta: Date;

    procedure TraerFechas(var datPrmFechaIni: Date;var datPrmFechafin: Date)
    begin
        datPrmFechaIni := FechaDesde;
        datPrmFechafin := FechaHasta;
    end;
}

