tableextension 50105 EXCCRIPriceListLine extends "Price List Line"
{
    fields
    {
        field(50000; "Source counter"; Integer)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                EXCCRIItem: Record Item;
                EXCCRIPriceListLine: Record "Price List Line";
            begin
                EXCCRIPriceListLine.SetCurrentKey("Source counter");
                if EXCCRIPriceListLine.FindLast() then
                    "Source counter" := EXCCRIPriceListLine."Source counter" + 1
                else
                    "Source counter" := 1;

                if "Asset Type" <> "Asset Type"::Item then
                    exit;

                EXCCRIItem.Get("Asset No.");
                EXCCRIItem.Validate("Source counter");
                EXCCRIItem.Modify();
            end;
        }
        field(50001; "Item description"; Text[100])
        {
            Caption = 'Item description', Comment = 'ESP=Descripcion producto';
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Asset No.")));
            Editable = false;
        }
        field(75000; IdJobQueueEntry; Guid)
        {
            DataClassification = CustomerContent;
        }
        field(34002504; Location; Code[20])
        {
            Caption = 'Location', Comment = 'ESP=Almacén';
            DataClassification = CustomerContent;
            TableRelation = Location;
        }
        field(34002505; "Precio manual"; Boolean)
        {
            Caption = 'Manual price', Comment = 'ESP=Precio manual';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(EXCCRISourceCounter; "Source counter")
        {
        }
    }
}
