tableextension 50091 EXCCRITransferReceiptLine extends "Transfer Receipt Line"
{
    fields
    {
        field(50000; "Precio Venta Consignacion"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50001; "Descuento % Consignacion"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50002; "Importe Consignacion"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50004; "ISBN"; Text[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item.ISBN;
        }

        field(50010; "No. Pedido Consignacion"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50011; "No. Linea Pedido Consignacion"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50012; "No. Mov. Prod. Cosg. a Liq."; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50013; "Cantidad Consg. Aplicada"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50014; "Cantidad Devuelta"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50015; "Grupo registro IVA prod."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "VAT Product Posting Group";
        }

        field(50016; "Grupo registro IVA neg."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "VAT Business Posting Group";
        }

        field(50017; "% IVA"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50018; "Importe IVA"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50020; "Cantidad Aprobada"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50021; "Cantidad pendiente BO"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50022; "Cantidad a Anular"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50023; "Cantidad Solicitada"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50024; "Cantidad a Ajustar"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50025; "Porcentaje Cant. Aprobada"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50029; "Cantidad Anulada"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(56008; "Bin Ranking"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(56028; "Disponible"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(67000; "Cantidad Alumnos"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            DecimalPlaces = 0:0;
        }

        field(67001; "Adopcion"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Conquista","Mantener","Perdida","Retiro";
            Editable = false;
        }

        field(67002; "Cod. Colegio"; Code[20])
        {
            DataClassification = ToBeClassified;
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
