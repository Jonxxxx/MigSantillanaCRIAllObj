tableextension 50028 EXCCRISalesShipmentLine extends "Sales Shipment Line"
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
    }

    keys
    {
        key(EXCCRIBinRanking; "Bin Ranking")
        {
        }
    }
}
