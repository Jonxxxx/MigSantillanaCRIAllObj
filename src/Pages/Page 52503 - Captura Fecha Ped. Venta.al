page 55212 "Captura Fecha Ped. Venta"
{
    PageType = StandardDialog;

    layout
    {
        area(content)
        {
            field("Fecha Desde"; FechaDesde)
            {
                ApplicationArea = All;
            }
            field("Fecha Hasta"; FechaHasta)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    var
        FechaDesde: Date;
        FechaHasta: Date;

    procedure TraerFechas(var datPrmFechaIni: Date; var datPrmFechafin: Date)
    begin
        datPrmFechaIni := FechaDesde;
        datPrmFechafin := FechaHasta;
    end;
}

