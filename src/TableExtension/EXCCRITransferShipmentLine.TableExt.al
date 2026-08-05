tableextension 55089 EXCCRITransferShipmentLine extends "Transfer Shipment Line"
{
    fields
    {
        field(55000; "Precio Venta Consignacion"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55001; "Descuento % Consignacion"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55002; "Importe Consignacion"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55004; "ISBN"; Text[30])
        {
            DataClassification = CustomerContent;
            TableRelation = Item.ISBN;
        }

        field(55010; "No. Pedido Consignacion"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55011; "No. Linea Pedido Consignacion"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(55012; "No. Mov. Prod. Cosg. a Liq."; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(55014; "Cantidad Devuelta"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55015; "Grupo registro IVA prod."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "VAT Product Posting Group";
        }

        field(55016; "Grupo registro IVA neg."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "VAT Business Posting Group";
        }

        field(55017; "% IVA"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55018; "Importe IVA"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55021; "Cantidad pendiente BO"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55022; "Cantidad a Anular"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55023; "Cantidad Solicitada"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55024; "Cantidad a Ajustar"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55029; "Cantidad Anulada"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55233; "Bin Ranking"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(55467; "Cantidad Alumnos"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
            DecimalPlaces = 0 : 0;
        }

        field(55468; "Adopcion"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Conquista","Mantener","Perdida","Retiro";
            Editable = false;
        }

        field(55469; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Contact;
            Editable = false;
        }
    }

    keys
    {
        key(EXCCRIBinRanking; "Bin Ranking")
        {
        }
    }
}
