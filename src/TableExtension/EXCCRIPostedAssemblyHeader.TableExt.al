tableextension 55069 EXCCRIPostedAssemblyHeader extends "Posted Assembly Header"
{
    fields
    {
        field(56000; "Cantidad a Revertir"; Decimal)
        {
            Caption = 'Quantity to Reverse', Comment = 'ESP=Cantidad a Revertir';
            DataClassification = CustomerContent;
        }
        field(56001; "Cantidad Revertida"; Decimal)
        {
            Caption = 'Reversed Quantity', Comment = 'ESP=Cantidad Revertida';
            DataClassification = CustomerContent;
        }
        field(56002; "Cantidad (Base) a Revertir"; Decimal)
        {
            Caption = 'Quantity (Base) to Reverse', Comment = 'ESP=Cantidad (Base) a Revertir';
            DataClassification = CustomerContent;
        }
        field(56003; "Cantidad (Base) Revertida"; Decimal)
        {
            Caption = 'Reversed Quantity (Base)', Comment = 'ESP=Cantidad (Base) Revertida';
            DataClassification = CustomerContent;
        }
        field(56004; "Revertido completamente"; Boolean)
        {
            Caption = 'Completely Reversed', Comment = 'ESP=Revertido completamente';
            DataClassification = CustomerContent;
        }
        field(56005; "Ultima Fecha Reversion"; Date)
        {
            Caption = 'Last Reversal Date', Comment = 'ESP=Última Fecha Reversion';
            DataClassification = CustomerContent;
        }
        field(56006; "Ultimo Almacen Reversion"; Code[20])
        {
            Caption = 'Last Reversal Location', Comment = 'ESP=Último Almacén Reversion';
            DataClassification = CustomerContent;
        }
    }
}
