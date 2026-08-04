tableextension 55091 EXCCRITransferReceiptLine extends "Transfer Receipt Line"
{
    fields
    {
        field(55225; "Precio Venta Consignacion"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55226; "Descuento % Consignacion"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55227; "Importe Consignacion"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55229; "ISBN"; Text[30])
        {
            DataClassification = CustomerContent;
            TableRelation = Item.ISBN;
        }

        field(55235; "No. Pedido Consignacion"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55236; "No. Linea Pedido Consignacion"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(55237; "No. Mov. Prod. Cosg. a Liq."; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(55238; "Cantidad Consg. Aplicada"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55239; "Cantidad Devuelta"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55240; "Grupo registro IVA prod."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "VAT Product Posting Group";
        }

        field(55241; "Grupo registro IVA neg."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "VAT Business Posting Group";
        }

        field(55242; "% IVA"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55243; "Importe IVA"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55245; "Cantidad Aprobada"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55246; "Cantidad pendiente BO"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55247; "Cantidad a Anular"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55248; "Cantidad Solicitada"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55249; "Cantidad a Ajustar"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55250; "Porcentaje Cant. Aprobada"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55029; "Cantidad Anulada"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(56008; "Bin Ranking"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(56028; "Disponible"; Boolean)
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
