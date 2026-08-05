tableextension 55027 EXCCRISalesShipmentHeader extends "Sales Shipment Header"
{
    fields
    {
        field(55010; "Tipo de Venta"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Invoice,Consignation,Sample,Donations';
            OptionMembers = "Factura","Consignacion","Muestras","Donaciones";
        }

        field(55110; "No. Documento SIC"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55198; "Source counter"; BigInteger)
        {
            DataClassification = CustomerContent;
        }

        field(55111; "Cod. Cajero"; Code[50])
        {
            DataClassification = CustomerContent;
        }

        field(55112; "Cod. Supervisor"; Text[30])
        {
            DataClassification = CustomerContent;
        }

        field(53008; Tienda; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Bancos tienda";
        }

        field(53009; "Factura en Historico"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55225; "Pedido Consignacion"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55226; "Collector Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser" where(Collector = const(true));
        }

        field(55227; "Pre pedido"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55228; "Devolucion Consignacion"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55231; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Contact where(Type = filter(Company));
        }

        field(55232; "Nombre Colegio"; Text[120])
        {
            DataClassification = CustomerContent;
        }

        field(55245; "No aplica Derechos de Autor"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55246; Promocion; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55283; "Cantidad de Bultos"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(55290; "No. Envio de Almacen"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55291; "No. Picking"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55292; "No. Picking Reg."; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55293; "No. Packing"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55294; "No. Packing Reg."; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55295; "No. Factura"; Code[20])
        {
            Caption = 'Invoice No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."No." where("Order No." = field("Order No.")));
        }

        field(55296; "No. Envio"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55318; "En Hoja de Ruta"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Lin. Hoja de Ruta" where("Tipo Envio" = filter("Pedido Venta"), "No. Conduce" = field("No.")));
        }

        field(55319; "En Hoja de Ruta Registrada"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Lin. Hoja de Ruta Reg." where("Tipo Envio" = filter("Pedido Venta"), "No. Conduce" = field("No."), "No entregado" = filter(false)));
        }

        field(56310; Origen; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Standard,E-Commerce';
            OptionMembers = "Estandar","E-Commerce";
        }

        field(56311; "Estado E-Commerce"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Processing,Ready to deliver,Delivered';
            OptionMembers = "En Proceso","Listo para entrega","Entregado";
        }
    }
}
