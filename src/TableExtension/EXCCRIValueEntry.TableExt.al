tableextension 55097 EXCCRIValueEntry extends "Value Entry"
{
    fields
    {
        field(55008; "Precio Unitario Consignacion"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55009; "Descuento % Consignacion"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55010; "Importe Consignacion bruto"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55011; "Importe Consignacion Neto"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55013; "Cant. Consignacion Pendiente"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55014; "Pedido Consignacion"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(55015; "Devolucion Consignacion"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(55016; "Cod. Oferta"; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(EXCCRIItemSourceAnalysis; "Item No.", "Source No.", "Global Dimension 2 Code", "Gen. Bus. Posting Group")
        {
        }
        key(EXCCRIPostingGroupAnalysis; "Gen. Bus. Posting Group", "Global Dimension 1 Code")
        {
        }
    }
}
