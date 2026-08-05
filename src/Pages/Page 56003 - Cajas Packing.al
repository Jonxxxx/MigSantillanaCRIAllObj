page 55228 "Cajas Packing"
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
    SourceTable = 55257;

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
                    Enabled = TieneGestionAlmacen;
                    Visible = TieneGestionAlmacen;
                }
                field("No. Linea Pedido"; Rec."No. Linea Pedido")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Linea Pedido';
                    Enabled = NOT TieneGestionAlmacen;
                    Visible = NOT TieneGestionAlmacen;
                }
                field("No. Producto"; Rec."No. Producto")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Producto';
                    Editable = false;
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
            action("&Close Box")
            {
                ApplicationArea = All;
                Caption = '&Close Box';
                ToolTip = '&Close Box';
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
        LinPack: Record 55256;
        txt002: Label 'Confirm that you want to close the box';
        CCP: Record 55257;
        FuncSant: Codeunit 55225;
        [InDataSet]
        TieneGestionAlmacen: Boolean;
}

