tableextension 55028 EXCCRISalesShipmentLine extends "Sales Shipment Line"
{
    fields
    {
        field(55239; "Cod. Cupon"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55240; "No. Linea Cupon"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(55241; "Cantidad Aprobada"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55242; "Cantidad pendiente BO"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55243; "Cantidad a Anular"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55244; "Cantidad Solicitada"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55245; Temporal; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55247; "Cantidad Anulada"; Decimal)
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
