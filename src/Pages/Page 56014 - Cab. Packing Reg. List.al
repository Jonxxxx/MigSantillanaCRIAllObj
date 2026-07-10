page 56014 "Cab. Packing Reg. List"
{
    // Proyecto: Implementacion Microsoft Dynamics Nav
    // AMS     : Agustin Mendez
    // GRN     : Guillermo Roman
    // ------------------------------------------------------------------------
    // No.         Firma   Fecha         Descripcion
    // ------------------------------------------------------------------------
    // #854        PLB     05/12/2013    Añadido campo "No. Pedido"
    //                                   Mostrar/ocultar "No. picking" o "No. pedido"

    CardPageID = "Cab. Packing Registrado";
    Editable = false;
    PageType = List;
    SourceTable = Table56033;

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
                field("No. Packing Origen"; "No. Packing Origen")
                {
                }
                field("Total de Productos"; "Total de Productos")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(; Notes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        TieneGestionAlmacen := FuncSant.TieneGestionAlmacen;
    end;

    var
        FuncSant: Codeunit 56000;
        [InDataSet]
        TieneGestionAlmacen: Boolean;
}

