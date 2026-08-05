page 55239 "Cab. Packing Reg. List"
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
    SourceTable = 55258;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No.';
                }
                field("Cod. Empleado"; Rec."Cod. Empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Empleado';
                }
                field("No. Mesa"; Rec."No. Mesa")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Mesa';
                }
                field("Picking No."; Rec."Picking No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Picking No.';
                    Enabled = TieneGestionAlmacen;
                    Visible = TieneGestionAlmacen;
                }
                field("Tipo pedido"; Rec."Tipo pedido")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo pedido';
                }
                field("No. Pedido"; Rec."No. Pedido")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Pedido';
                    Enabled = NOT TieneGestionAlmacen;
                    Visible = NOT TieneGestionAlmacen;
                }
                field("Fecha Apertura"; Rec."Fecha Apertura")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Apertura';
                }
                field("Fecha Registro"; Rec."Fecha Registro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Registro';
                }
                field("No. Packing Origen"; Rec."No. Packing Origen")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Packing Origen';
                }
                field("Total de Productos"; Rec."Total de Productos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total de Productos';
                }
            }
        }
        area(factboxes)
        {
            systempart(Notes; Notes)
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
        FuncSant: Codeunit 55225;
        [InDataSet]
        TieneGestionAlmacen: Boolean;
}

