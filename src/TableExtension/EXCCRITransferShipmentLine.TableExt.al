tableextension 50089 EXCCRITransferShipmentLine extends "Transfer Shipment Line"
{
    fields
    {
        field(50000; "Precio Venta Consignacion"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(50001; "Descuento % Consignacion"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(50002; "Importe Consignacion"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(50004; "ISBN"; Text[30])
        {
            DataClassification = CustomerContent;
            TableRelation = Item.ISBN;
        }

        field(50010; "No. Pedido Consignacion"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(50011; "No. Linea Pedido Consignacion"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(50012; "No. Mov. Prod. Cosg. a Liq."; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(50014; "Cantidad Devuelta"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(50015; "Grupo registro IVA prod."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "VAT Product Posting Group";
        }

        field(50016; "Grupo registro IVA neg."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "VAT Business Posting Group";
        }

        field(50017; "% IVA"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(50018; "Importe IVA"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(50021; "Cantidad pendiente BO"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(50022; "Cantidad a Anular"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(50023; "Cantidad Solicitada"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(50024; "Cantidad a Ajustar"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(50029; "Cantidad Anulada"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(56008; "Bin Ranking"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(67000; "Cantidad Alumnos"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
            DecimalPlaces = 0 : 0;
        }

        field(67001; "Adopcion"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Conquista","Mantener","Perdida","Retiro";
            Editable = false;
        }

        field(67002; "Cod. Colegio"; Code[20])
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
