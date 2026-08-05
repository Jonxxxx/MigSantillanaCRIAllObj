tableextension 55070 EXCCRIPostedAssemblyLine extends "Posted Assembly Line"
{
    fields
    {
        field(55225; "Cantidad a Revertir"; Decimal)
        {
            Caption = 'Quantity to Reverse', Comment = 'ESP=Cantidad a Revertir';
            DataClassification = CustomerContent;
        }
        field(55226; "Cantidad Revertida"; Decimal)
        {
            Caption = 'Reversed Quantity', Comment = 'ESP=Cantidad Revertida';
            DataClassification = CustomerContent;
        }
        field(55227; "Cantidad (Base) a Revertir"; Decimal)
        {
            Caption = 'Quantity (Base) to Reverse', Comment = 'ESP=Cantidad (Base) a Revertir';
            DataClassification = CustomerContent;
        }
        field(55228; "Cantidad (Base) Revertida"; Decimal)
        {
            Caption = 'Reversed Quantity (Base)', Comment = 'ESP=Cantidad (Base) Revertida';
            DataClassification = CustomerContent;
        }
    }
}
