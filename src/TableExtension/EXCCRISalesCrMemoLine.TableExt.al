tableextension 50032 EXCCRISalesCrMemoLine extends "Sales Cr.Memo Line"
{
    fields
    {
        field(50014; "Cod. Cupon"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50015; "No. Linea Cupon"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50016; "Cantidad Aprobada"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50017; "Cantidad pendiente BO"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50018; "Cantidad a Anular"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50019; "Cantidad Solicitada"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50020; Temporal; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50022; "Cantidad Anulada"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50040; "Cantidad a Ajustar"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50041; "Porcentaje Cant. Aprobada"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(53004; "Cod. Vendedor"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
        }

        field(55500; "Linea Copiada"; Boolean)
        {
            Caption = 'Copied Line';
            DataClassification = ToBeClassified;
        }

        field(56001; Disponible; Boolean)
        {
            Caption = 'Available';
            DataClassification = ToBeClassified;
        }

        field(56008; "Bin Ranking"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(56009; Compartir; Option)
        {
            Caption = 'Cod. Compartir';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Libros,Servicios,Aulas';
            OptionMembers = " ","Libros","Servicios","Aulas";
        }

        field(56015; "Tipo Descuento FE"; Code[2])
        {
            DataClassification = ToBeClassified;
        }

        field(67000; "Cantidad Alumnos"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            DecimalPlaces = 0:0;
        }

        field(67001; Adopcion; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ","Conquista","Mantener","Perdida","Retiro";
            Editable = false;
        }

        field(67002; "Cod. Colegio"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Contact;
            Editable = false;
        }

        field(34002508; "Devuelve a Documento"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(34002509; "Devuelve a Linea Documento"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(34003000; "Tipo de bien-servicio"; Option)
        {
            Caption = 'Type of Good/Service';
            DataClassification = ToBeClassified;
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
