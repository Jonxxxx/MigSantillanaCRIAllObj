page 52506 "Categoria Pedido Venta"
{
    //  Proyecto: Implementacion Business Central
    // 
    //  LDP: Luis Jose De La Cruz Paredes
    //  ------------------------------------------------------------------------
    //  No.        Fecha           Firma    Descripcion
    //  ------------------------------------------------------------------------
    //  001        12-07-2023      LDP      SANTINAV-4746: crear filtro en Estadisticas de Vtas. (EXCEL)

    ApplicationArea = Basic, Suite;
    Caption = 'Sales Order Category';
    PageType = List;
    SourceTable = Table52503;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Codigo; Codigo)
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Filtrar Cod. Compartir"; "Filtrar Cod. Compartir")
                {
                }
            }
        }
    }

    actions
    {
    }

    [Scope('Personalization')]
    procedure GetSelectionFilter(): Text
    var
        SelectionFilterManagement: Codeunit 46;
        CategoriaPedidoVenta: Record 52503;
        RecordRef: RecordRef;
    begin
        CurrPage.SETSELECTIONFILTER(CategoriaPedidoVenta);
        RecordRef.GETTABLE(CategoriaPedidoVenta);
        EXIT(SelectionFilterManagement.GetSelectionFilter(RecordRef, CategoriaPedidoVenta.FIELDNO(Codigo)));
    end;
}

