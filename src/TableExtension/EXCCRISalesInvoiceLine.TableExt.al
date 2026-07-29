tableextension 50030 EXCCRISalesInvoiceLine extends "Sales Invoice Line"
{
    fields
    {
        field(50014; "Cod. Cupon"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(50015; "No. Linea Cupon"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(50016; "Cantidad Aprobada"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(50017; "Cantidad pendiente BO"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(50018; "Cantidad a Anular"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(50019; "Cantidad Solicitada"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(50020; Temporal; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(50021; "Requested Delivery Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(50022; "Cantidad Anulada"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(50040; "Cantidad a Ajustar"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(50041; "Porcentaje Cant. Aprobada"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55500; "Linea Copiada"; Boolean)
        {
            Caption = 'Copied Line';
            DataClassification = CustomerContent;
        }

        field(56001; Disponible; Boolean)
        {
            Caption = 'Available';
            DataClassification = CustomerContent;
        }

        field(56008; "Bin Ranking"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(56009; Compartir; Option)
        {
            Caption = 'Cod. Compartir';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Libros,Servicios,Aulas';
            OptionMembers = " ","Libros","Servicios","Aulas";
        }

        field(56015; "Tipo Descuento FE"; Code[2])
        {
            DataClassification = CustomerContent;
        }

        field(56150; "Tipo Documento Replicador"; Option)
        {
            Caption = 'Replicator Document Type';
            DataClassification = CustomerContent;
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Pre Order';
            OptionMembers = "Quote","Order","Invoice","Credit Memo","Blanket Order","Return Order","Pre Order";
        }

        field(56151; "No. Pedido Replicador"; Code[20])
        {
            Caption = 'Replicator Order No';
            DataClassification = CustomerContent;
        }

        field(56152; "Cantidad 1 Replicador"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(56153; "Cantidad 2 Replicador"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(56154; "Cantidad 3 Replicador"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(56155; "Cantidad 4 Replicador"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(34002500; "Anulada en TPV"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(34002501; "Precio anulacion TPV"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(34002502; "Cantidad anulacion TPV"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(34002503; "Cantidad agregada"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(34002504; "Cod. Vendedor"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser";
        }

        field(34002505; Devuelto; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(34002506; "Devuelto en Documento"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(34002507; "Devuelto en Linea Documento"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(34002800; "Cantidad Alumnos"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
            DecimalPlaces = 0 : 0;
        }

        field(34002801; Adopcion; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ","Conquista","Mantener","Perdida","Retiro";
            Editable = false;
        }

        field(34002802; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Contact;
            Editable = false;
        }

        field(34003000; "Tipo de bien-servicio"; Option)
        {
            Caption = 'Type of Good/Service';
            DataClassification = CustomerContent;
            OptionCaption = 'Good,Service,Selective,Tips,Other';
            OptionMembers = "Bienes","Servicios","Selectivo al consumo","Propina legal","Otros";
        }
    }

    keys
    {
        key(EXCCRIBinRanking; "Bin Ranking")
        {
        }
    }
}
