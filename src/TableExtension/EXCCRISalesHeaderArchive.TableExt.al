tableextension 55073 EXCCRISalesHeaderArchive extends "Sales Header Archive"
{
    fields
    {
        field(55290; "No. Envio de Almacen"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Warehouse Shipment Header";
        }

        field(55291; "No. Picking"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Warehouse Activity Header";
        }

        field(55292; "No. Picking Reg."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Registered Whse. Activity Hdr."."No.";
        }

        field(55293; "No. Packing"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Cab. Packing";
        }

        field(55294; "No. Packing Reg."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Cab. Packing Registrado"."No.";
        }

        field(55295; "No. Factura"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Sales Invoice Header";
        }

        field(55296; "No. Envio"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Sales Shipment Header"."No.";
        }

        field(55310; "Ultima Version"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55311; "No. Hoja Ruta"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Cab. Hoja de Ruta Reg.";
        }

        field(55956; "No. Serie NCF Facturas"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series" where("Descripcion NCF" = filter(<> ''));
        }

        field(55957; "No. Comprobante Fiscal"; Code[19])
        {
            DataClassification = CustomerContent;
        }

        field(55958; "No. Comprobante Fiscal Rel."; Code[19])
        {
            DataClassification = CustomerContent;
        }

        field(55959; "Razon anulacion NCF"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Razones Anulacion NCF";
        }

        field(55960; "No. Serie NCF Abonos"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }

        field(55961; "Cod. Clasificacion Gasto"; Code[2])
        {
            DataClassification = CustomerContent;
        }

        field(55962; "Fecha vencimiento NCF"; Date)
        {
            DataClassification = CustomerContent;
            TableRelation = "Tipos de ingresos";
        }

        field(55963; "Tipo de ingreso"; Code[2])
        {
            DataClassification = CustomerContent;
            TableRelation = "Tipos de ingresos";
        }
    }

    keys
    {
        key(EXCCRILastVersion; "Ultima Version")
        {
        }
    }
}
