page 56041 "Contenido Cajas"
{
    PageType = List;
    SourceTable = Table56032;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Barras"; "Cod. Barras")
                {
                }
                field(Cantidad; Cantidad)
                {
                }
                field("No. Linea Picking"; "No. Linea Picking")
                {
                }
                field("No. Producto"; "No. Producto")
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Cod. Unidad de Medida"; "Cod. Unidad de Medida")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Cerrar Caja")
            {
                Caption = '&Cerrar Caja';

                trigger OnAction()
                begin

                    IF CONFIRM(txt002, FALSE) THEN BEGIN
                        IF LinPack.GET("No. Packing", "No. Caja") THEN
                            IF LinPack."Estado Caja" = LinPack."Estado Caja"::Abierta THEN BEGIN
                                LinPack.VALIDATE("Estado Caja", LinPack."Estado Caja"::Cerrada);
                                LinPack.VALIDATE("Fecha Cierre Caja", WORKDATE);
                                LinPack.MODIFY;
                                CurrPage.CLOSE;
                            END;
                    END;
                end;
            }
        }
    }

    var
        LinPack: Record 56031;
        txt001: Label 'Box Closed';
        txt002: Label 'Confirm that you want to close the box';

    procedure ContenidoCaja()
    begin
    end;
}

