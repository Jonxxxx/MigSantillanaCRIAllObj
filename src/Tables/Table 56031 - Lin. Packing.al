table 56031 "Lin. Packing"
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
        }
        field(3; "No. Caja"; Code[20])
        {
            Caption = 'Box No.';
        }
        field(4; "Fecha Apertura Caja"; Date)
        {
        }
        field(5; "Fecha Cierre Caja"; Date)
        {
        }
        field(6; "Estado Caja"; Option)
        {
            Caption = 'Box Status';
            OptionCaption = 'Close,Open';
            OptionMembers = Cerrada,Abierta;
        }
        field(7; "No. Picking"; Code[20])
        {
            Caption = 'Picking No.';
        }
        field(8; "Total de Productos"; Decimal)
        {
            CalcFormula = Sum("Contenido Cajas Packing".Cantidad WHERE(No. Packing=FIELD(No.),
                                                                        No. Caja=FIELD(No. Caja)));
            Caption = 'Item total';
            FieldClass = FlowField;
        }
        field(9;"No. Palet";Code[20])
        {
            Caption = 'Palet No.';
        }
        field(10;"No. Pedido";Code[20])
        {
            TableRelation = IF (Tipo pedido=CONST(Venta)) "Sales Header"."No." WHERE (Document Type=CONST(Order),
                                                                                    Estado packing=CONST(Listo))
                                                                                    ELSE IF (Tipo pedido=CONST(Consignacion)) "Transfer Header"."No." WHERE (Pedido Consignacion=CONST(true),
                                                                                                                                                           Estado packing=CONST(Listo))
                                                                                                                                                           ELSE IF (Tipo pedido=CONST(Transferencia)) "Transfer Header"."No." WHERE (Pedido Consignacion=CONST(false),
                                                                                                                                                                                                                                   Estado packing=CONST(Listo));
        }
        field(20;"Tipo pedido";Option)
        {
            OptionCaption = 'Venta,Consignaci n,Transferencia';
            OptionMembers = Venta,Consignacion,Transferencia;
        }
    }

    keys
    {
        key(Key1;"No.","No. Caja")
        {
        }
        key(Key2;"No. Picking")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TESTFIELD("Estado Caja","Estado Caja"::Abierta);
        CP.RESET;
        CP.SETRANGE("No. Packing","No.");
        CP.SETRANGE("No. Caja","No. Caja");
        CP.DELETEALL(TRUE);
    end;

    var
        CP Record: 56032;
        FuncSant: Codeunit 56000;
        ContCaja: Page56041;

    procedure ContenidoCaja()
    begin
        CP.SETRANGE("No. Packing", "No.");
        CP.SETRANGE("No. Caja", "No. Caja");
        CP.SETRANGE("No. Picking", "No. Picking");
        CP.SETRANGE("No. Pedido", "No. Pedido"); //+#854
        ContCaja.SETTABLEVIEW(CP);
        ContCaja.RUNMODAL;
        CLEAR(ContCaja);
    end;

    procedure AbrirCaja()
    begin
        FuncSant.ReabrirCajaPacking(Rec);
        /*
        CP.SETRANGE("No. Packing","No.");
        CP.SETRANGE("No. Caja","No. Caja");
        CP.SETRANGE("No. Picking","No. Picking");
        CP.DELETEALL(TRUE);
         */

    end;
}

