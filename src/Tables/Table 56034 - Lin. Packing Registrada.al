table 55259 "Lin. Packing Registrada"
{
    // Proyecto: Implementacion Microsoft Dynamics Nav
    // AMS     : Agustin Mendez
    // GRN     : Guillermo Roman
    // ------------------------------------------------------------------------
    // No.         Firma   Fecha         Descripcion
    // ------------------------------------------------------------------------
    // #854        PLB     05/12/2013    A adido campo "No. Pedido"
    // #2945       JML     14/07/2014    A ado consignaciones y transferencias.

    Caption = 'Packing Line';

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(3; "No. Caja"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Caja';
        }
        field(4; "Fecha Apertura Caja"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Apertura Caja';
        }
        field(5; "Fecha Cierre Caja"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Cierre Caja';
        }
        field(6; "Estado Caja"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Estado Caja';
            OptionCaption = 'Close,Open';
            OptionMembers = Cerrada,Abierta;
        }
        field(7; "No. Picking"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Picking';
        }
        field(8; "Total de Productos"; Decimal)
        {
            Caption = 'Total de Productos';
            CalcFormula = Sum("Contenido Cajas Packing Reg.".Cantidad WHERE("No. Packing" = FIELD("No."),
                                                                             "No. Caja" = FIELD("No. Caja")));
            FieldClass = FlowField;
        }
        field(9; "No. Palet"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Palet';
        }
        field(10; "No. Pedido"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Pedido';
            //TODO Ver: 
            /*
            TableRelation = IF ("Tipo pedido" = CONST(Venta)) "Sales Header"."No." WHERE("Document Type" = CONST(Order),
                                                                                    "Estado packing" = CONST(Listo))
            ELSE IF ("Tipo pedido" = CONST(Consignacion)) "Transfer Header"."No." WHERE("Pedido Consignacion" = CONST(true),
                                                                                    "Estado packing" = CONST(Listo))
            ELSE IF ("Tipo pedido" = CONST(Transferencia)) "Transfer Header"."No." WHERE("Pedido Consignacion" = CONST(false),
                                                                                    "Estado packing" = CONST(Listo));
                                                                                    */
        }
        field(20; "Tipo pedido"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo pedido';
            OptionCaption = 'Venta,Consignaci n,Transferencia';
            OptionMembers = Venta,Consignacion,Transferencia;
        }
    }

    keys
    {
        key(Key1; "No.", "No. Caja")
        {
        }
        key(Key2; "No. Picking")
        {
        }
    }

    fieldgroups
    {
    }

    var
        CPR: Record 55260;
        ContCaja: Page 55266;

    procedure ContenidoCaja()
    begin
        CPR.RESET;
        CPR.SETRANGE(CPR."No. Packing", "No.");
        CPR.SETRANGE(CPR."No. Caja", "No. Caja");
        CPR.SETRANGE(CPR."No. Picking", "No. Picking");
        ContCaja.SETTABLEVIEW(CPR);
        ContCaja.RUNMODAL;
        CLEAR(ContCaja);
    end;
}

