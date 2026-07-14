tableextension 50073 EXCCRISalesHeaderArchive extends "Sales Header Archive"
{
    fields
    {
        field(56070; "No. Envio de Almacen"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Warehouse Shipment Header";
        }

        field(56071; "No. Picking"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Warehouse Activity Header";
        }

        field(56072; "No. Picking Reg."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Registered Whse. Activity Hdr."."No.";
        }

        field(56073; "No. Packing"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Cab. Packing";
        }

        field(56074; "No. Packing Reg."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Cab. Packing Registrado"."No.";
        }

        field(56075; "No. Factura"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sales Invoice Header";
        }

        field(56076; "No. Envio"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sales Shipment Header"."No.";
        }

        field(56090; "Ultima Version"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(56091; "No. Hoja Ruta"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Cab. Hoja de Ruta Reg.";
        }

        field(34003001; "No. Serie NCF Facturas"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series" where("Descripcion NCF" = filter(<> ''));
        }

        field(34003002; "No. Comprobante Fiscal"; Code[19])
        {
            DataClassification = ToBeClassified;
        }

        field(34003003; "No. Comprobante Fiscal Rel."; Code[19])
        {
            DataClassification = ToBeClassified;
        }

        field(34003004; "Razon anulacion NCF"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Razones Anulacion NCF";
        }

        field(34003005; "No. Serie NCF Abonos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(34003006; "Cod. Clasificacion Gasto"; Code[2])
        {
            DataClassification = ToBeClassified;
        }

        field(34003007; "Fecha vencimiento NCF"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Tipos de ingresos";
        }

        field(34003008; "Tipo de ingreso"; Code[2])
        {
            DataClassification = ToBeClassified;
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
