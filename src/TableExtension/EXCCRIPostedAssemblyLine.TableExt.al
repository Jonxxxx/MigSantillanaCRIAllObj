tableextension 50070 EXCCRIPostedAssemblyLine extends "Posted Assembly Line"
{
    fields
    {
        field(56000; "Cantidad a Revertir"; Decimal)
        {
            Caption = 'Quantity to Reverse', Comment = 'ESP=Cantidad a Revertir';
            DataClassification = ToBeClassified;
        }
        field(56001; "Cantidad Revertida"; Decimal)
        {
            Caption = 'Reversed Quantity', Comment = 'ESP=Cantidad Revertida';
            DataClassification = ToBeClassified;
        }
        field(56002; "Cantidad (Base) a Revertir"; Decimal)
        {
            Caption = 'Quantity (Base) to Reverse', Comment = 'ESP=Cantidad (Base) a Revertir';
            DataClassification = ToBeClassified;
        }
        field(56003; "Cantidad (Base) Revertida"; Decimal)
        {
            Caption = 'Reversed Quantity (Base)', Comment = 'ESP=Cantidad (Base) Revertida';
            DataClassification = ToBeClassified;
        }
    }
}
