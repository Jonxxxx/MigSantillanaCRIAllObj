page 56013 "Cab. Packing List"
{
    // Proyecto: Implementacion Microsoft Dynamics Nav
    // AMS     : Agustin Mendez
    // GRN     : Guillermo Roman
    // ------------------------------------------------------------------------
    // No.         Firma   Fecha         Descripcion
    // ------------------------------------------------------------------------
    // #854        PLB     05/12/2013    Añadido campo "No. Pedido"
    //                                   Mostrar/ocultar "No. picking" o "No. pedido"

    ApplicationArea = Basic, Suite, Service;
    CardPageID = Packing;
    Editable = false;
    PageType = List;
    SourceTable = 56030;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                }
                field("Cod. Empleado"; "Cod. Empleado")
                {
                }
                field("No. Mesa"; "No. Mesa")
                {
                }
                field("Picking No."; "Picking No.")
                {
                    Enabled = TieneGestionAlmacen;
                    Visible = TieneGestionAlmacen;
                }
                field("Tipo pedido"; "Tipo pedido")
                {
                }
                field("No. Pedido"; "No. Pedido")
                {
                    Enabled = NOT TieneGestionAlmacen;
                    Visible = NOT TieneGestionAlmacen;
                }
                field("Fecha Apertura"; "Fecha Apertura")
                {
                }
                field("Fecha Registro"; "Fecha Registro")
                {
                }
                field("Total de Productos"; "Total de Productos")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        //TODO: Ver TieneGestionAlmacen := FuncSant.TieneGestionAlmacen;
    end;

    var
        //TODO: Ver FuncSant: Codeunit 56000;
        [InDataSet]
        TieneGestionAlmacen: Boolean;
}

