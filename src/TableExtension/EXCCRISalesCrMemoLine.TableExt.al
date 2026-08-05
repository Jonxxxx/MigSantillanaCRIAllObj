tableextension 55032 EXCCRISalesCrMemoLine extends "Sales Cr.Memo Line"
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

        field(53004; "Cod. Vendedor"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser";
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

        field(55467; "Cantidad Alumnos"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
            DecimalPlaces = 0 : 0;
        }

        field(55468; Adopcion; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ","Conquista","Mantener","Perdida","Retiro";
            Editable = false;
        }

        field(55469; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Contact;
            Editable = false;
        }

        field(55902; "Devuelve a Documento"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55903; "Devuelve a Linea Documento"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(55955; "Tipo de bien-servicio"; Option)
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
