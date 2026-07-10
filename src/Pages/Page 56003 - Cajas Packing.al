page 56003 "Cajas Packing"
{
    // Proyecto: Implementacion Microsoft Dynamics Nav
    // AMS     : Agustin Mendez
    // GRN     : Guillermo Roman
    // ------------------------------------------------------------------------
    // No.         Firma   Fecha         Descripcion
    // ------------------------------------------------------------------------
    // #854        PLB     05/12/2013    Añadido campo "No. linea Pedido"
    //                                   Mostrar/ocultar "No. linea picking" o "No. linea pedido"
    // #4191  PLB  30/09/2014  Añadido atajo de teclado a "Cerrar caja" -> Mayús+Ctrl+C

    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = List;
    PopulateAllFields = true;
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
                    Enabled = TieneGestionAlmacen;
                    Visible = TieneGestionAlmacen;
                }
                field("No. Linea Pedido"; "No. Linea Pedido")
                {
                    Enabled = NOT TieneGestionAlmacen;
                    Visible = NOT TieneGestionAlmacen;
                }
                field("No. Producto"; "No. Producto")
                {
                    Editable = false;
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
            action("&Close Box")
            {
                Caption = '&Close Box';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Shift+Ctrl+C';

                trigger OnAction()
                begin
                    IF CONFIRM(txt002, FALSE) THEN BEGIN
                        CCP.RESET;
                        CCP.SETRANGE("No. Packing", "No. Packing");
                        CCP.SETRANGE("No. Caja", "No. Caja");
                        IF CCP.FINDSET THEN
                            REPEAT
                                CCP.TESTFIELD(Cantidad);
                            UNTIL CCP.NEXT = 0;

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

    trigger OnInit()
    begin
        TieneGestionAlmacen := FuncSant.TieneGestionAlmacen;
    end;

    var
        txt001: Label 'Box Closed';
        LinPack Record: 56031;
        txt002: Label 'Confirm that you want to close the box';
        CCP Record: 56032;
        FuncSant: Codeunit 56000;
        [InDataSet]
        TieneGestionAlmacen: Boolean;
}

