page 56041 "Contenido Cajas"
{
    PageType = List;
    SourceTable = 56032;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Barras"; Rec."Cod. Barras")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Barras';
                }
                field(Cantidad; Rec.Cantidad)
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad';
                }
                field("No. Linea Picking"; Rec."No. Linea Picking")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Linea Picking';
                }
                field("No. Producto"; Rec."No. Producto")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Producto';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("Cod. Unidad de Medida"; Rec."Cod. Unidad de Medida")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Unidad de Medida';
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

                ApplicationArea = All;
                Caption = '&Cerrar Caja';
                ToolTip = '&Cerrar Caja';
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

