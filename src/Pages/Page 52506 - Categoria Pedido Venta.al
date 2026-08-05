page 55204 "Categoria Pedido Venta"
{
    //  Proyecto: Implementacion Business Central
    // 
    //  LDP: Luis Jose De La Cruz Paredes
    //  ------------------------------------------------------------------------
    //  No.        Fecha           Firma    Descripcion
    //  ------------------------------------------------------------------------
    //  001        12-07-2023      LDP      SANTINAV-4746: crear filtro en Estadisticas de Vtas. (EXCEL)

    ApplicationArea = All;
    Caption = 'Sales Order Category';
    PageType = List;
    SourceTable = 55212;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("Filtrar Cod. Compartir"; Rec."Filtrar Cod. Compartir")
                {
                    ApplicationArea = All;
                    ToolTip = 'Filtrar Cod. Compartir';
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
        CategoriaPedidoVenta: Record 55212;
        RecordRef: RecordRef;
    begin
        CurrPage.SETSELECTIONFILTER(CategoriaPedidoVenta);
        RecordRef.GETTABLE(CategoriaPedidoVenta);
        EXIT(SelectionFilterManagement.GetSelectionFilter(RecordRef, CategoriaPedidoVenta.FIELDNO(Codigo)));
    end;
}

