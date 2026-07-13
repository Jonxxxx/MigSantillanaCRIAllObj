tableextension 50028 EXCCRISalesShipmentLine extends "Sales Shipment Line"
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
    }

    keys
    {
        key(EXCCRIBinRanking; "Bin Ranking")
        {
        }
    }
}
