tableextension 50097 EXCCRIValueEntry extends "Value Entry"
{
    fields
    {
        field(50008; "Precio Unitario Consignacion"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Descuento % Consignacion"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Importe Consignacion bruto"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Importe Consignacion Neto"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Cant. Consignacion Pendiente"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Pedido Consignacion"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Devolucion Consignacion"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Cod. Oferta"; Code[20])
        {
            DataClassification = ToBeClassified;
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
