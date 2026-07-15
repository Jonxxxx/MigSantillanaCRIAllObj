page 34002543 "FactBox total ventas"
{
    PageType = ListPart;
    SourceTable = 34002501;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Id TPV"; "Id TPV")
                {
                    Caption = 'TPV';
                    Importance = Promoted;
                }
                field("Importe ventas"; "Importe ventas")
                {
                    Caption = 'Ventas';
                }
                field("Importe cobros"; "Importe cobros")
                {
                    Caption = 'Cobros';
                }
            }
            grid(General)
            {
                group(GeneralGroup)
                {
                    field(Tienda; Tienda)
                    {
                        Caption = 'Store';
                    }
                    field("Importe ventas tienda"; "Importe ventas Tienda")
                    {
                        Caption = 'Ventas';
                    }
                    field("Importe cobros tienda"; "Importe cobros Tienda")
                    {
                        Caption = 'Cobros';
                    }
                }
            }
        }
    }

    actions
    {
    }

    var
        decTienda: Decimal;
        decTPV: Decimal;
}

