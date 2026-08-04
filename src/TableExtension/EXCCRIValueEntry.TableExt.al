tableextension 55097 EXCCRIValueEntry extends "Value Entry"
{
    fields
    {
        field(55233; "Precio Unitario Consignacion"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55234; "Descuento % Consignacion"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55235; "Importe Consignacion bruto"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55236; "Importe Consignacion Neto"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55238; "Cant. Consignacion Pendiente"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55239; "Pedido Consignacion"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(55240; "Devolucion Consignacion"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(55241; "Cod. Oferta"; Code[20])
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
