tableextension 50039 EXCCRIRequisitionLine extends "Requisition Line"
{
    fields
    {
        modify("No.")
        {
            TableRelation =
                if (Type = const("G/L Account")) "G/L Account"
                else if (Type = const(Item), "Worksheet Template Name" = filter(<> ''), "Journal Batch Name" = filter(<> '')) Item where(Type = const(Inventory), Inactivo = const(false))
                else if (Type = const(Item), "Worksheet Template Name" = const(''), "Journal Batch Name" = const('')) Item;
        }
        modify("Vendor No.")
        {
            TableRelation = Vendor where(Inactivo = const(false));
        }
        modify("Location Code")
        {
            TableRelation = Location where("Use As In-Transit" = const(false), Inactivo = const(false));
        }
    }
}
