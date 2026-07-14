tableextension 50107 EXCCRIWarehouseJournalLine extends "Warehouse Journal Line"
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

        field(34002500; Barcode; Code[22])
        {
            Caption = 'Barcode', Comment = 'ESP=Cód. Barras';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                EXCCRIItemReference: Record "Item Reference";
            begin
                EXCCRIItemReference.SetCurrentKey("Reference No.");
                EXCCRIItemReference.SetRange(
                    "Reference No.",
                    Barcode);
                EXCCRIItemReference.FindFirst();

                Validate(
                    "Item No.",
                    EXCCRIItemReference."Item No.");

                if EXCCRIItemReference."Unit of Measure" <> '' then
                    Validate(
                        "Unit of Measure Code",
                        EXCCRIItemReference."Unit of Measure");

                if EXCCRIItemReference."Variant Code" <> '' then
                    Validate(
                        "Variant Code",
                        EXCCRIItemReference."Variant Code");
            end;

            trigger OnLookup()
            var
                EXCCRIItemReference: Record "Item Reference";
            begin
                TestField("Item No.");

                EXCCRIItemReference.SetRange(
                    "Item No.",
                    "Item No.");
                EXCCRIItemReference.FindFirst();

                if
                    Page.RunModal(
                        Page::"Item References",
                        EXCCRIItemReference) = Action::LookupOK
                then
                    Barcode := CopyStr(
                        EXCCRIItemReference."Reference No.",
                        1,
                        MaxStrLen(Barcode));
            end;
        }
    }
}
