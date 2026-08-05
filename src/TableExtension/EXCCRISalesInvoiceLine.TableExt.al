tableextension 55030 EXCCRISalesInvoiceLine extends "Sales Invoice Line"
{
    fields
    {
        field(55014; "Cod. Cupon"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55015; "No. Linea Cupon"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(55016; "Cantidad Aprobada"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55017; "Cantidad pendiente BO"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55018; "Cantidad a Anular"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55019; "Cantidad Solicitada"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55020; Temporal; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55021; "Requested Delivery Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(55022; "Cantidad Anulada"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55040; "Cantidad a Ajustar"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55041; "Porcentaje Cant. Aprobada"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55500; "Linea Copiada"; Boolean)
        {
            Caption = 'Copied Line';
            DataClassification = CustomerContent;
        }

        field(55226; Disponible; Boolean)
        {
            Caption = 'Available';
            DataClassification = CustomerContent;
        }

        field(55233; "Bin Ranking"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(55234; Compartir; Option)
        {
            Caption = 'Cod. Compartir';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Libros,Servicios,Aulas';
            OptionMembers = " ","Libros","Servicios","Aulas";
        }

        field(55240; "Tipo Descuento FE"; Code[2])
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

        field(55894; "Anulada en TPV"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55895; "Precio anulacion TPV"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55896; "Cantidad anulacion TPV"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55897; "Cantidad agregada"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55898; "Cod. Vendedor"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser";
        }

        field(55899; Devuelto; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55900; "Devuelto en Documento"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55901; "Devuelto en Linea Documento"; Integer)
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
