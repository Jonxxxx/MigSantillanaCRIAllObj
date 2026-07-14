tableextension 50111 EXCCRIWhseWorksheetLine extends "Whse. Worksheet Line"
{
    fields
    {
        modify("Location Code")
        {
            TableRelation = Location where(Inactivo = const(false));
        }
        modify("Item No.")
        {
            TableRelation = Item where(Type = const(Inventory), Inactivo = const(false));
        }

        field(50000; ISBN; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Item.ISBN where("No." = field("Item No.")));
        }
    }
}
