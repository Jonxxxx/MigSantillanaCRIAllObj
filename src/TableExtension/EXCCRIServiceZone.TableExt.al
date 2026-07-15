tableextension 50100 EXCCRIServiceZone extends "Service Zone"
{
    fields
    {
        field(50000; "Cod. Cobrador"; Code[20])
        {
            Caption = 'Collector Code', Comment = 'ESP=Cod. Cobrador';
            DataClassification = ToBeClassified;
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
        field(50001; "Nombre Cobrador"; Text[200])
        {
            Caption = 'Collector Name', Comment = 'ESP=Nombre Cobrador';
            DataClassification = ToBeClassified;
        }
    }
}
