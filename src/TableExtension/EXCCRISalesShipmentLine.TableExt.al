tableextension 55028 EXCCRISalesShipmentLine extends "Sales Shipment Line"
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

        field(55224; "Cod. Vendedor"; Code[20])
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
    }

    keys
    {
        key(EXCCRIBinRanking; "Bin Ranking")
        {
        }
    }
}
