tableextension 55100 EXCCRIServiceZone extends "Service Zone"
{
    fields
    {
        field(55225; "Cod. Cobrador"; Code[20])
        {
            Caption = 'Collector Code', Comment = 'ESP=Cod. Cobrador';
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser".Code where(Collector = const(true));

            trigger OnValidate()
            var
                EXCCRISalespersonPurchaser: Record "Salesperson/Purchaser";
            begin
                if EXCCRISalespersonPurchaser.Get(Code) then
                    "Nombre Cobrador" := EXCCRISalespersonPurchaser.Name
                else
                    EXCCRISalespersonPurchaser.Name := '';
            end;
        }
        field(55226; "Nombre Cobrador"; Text[200])
        {
            Caption = 'Collector Name', Comment = 'ESP=Nombre Cobrador';
            DataClassification = CustomerContent;
        }
    }
}
