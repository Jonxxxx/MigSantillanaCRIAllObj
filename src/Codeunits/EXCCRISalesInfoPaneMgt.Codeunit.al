codeunit 61025 EXCCRISalesInfoPaneMgt
{
    procedure CalcAvailability_BackOrder(var SalesLine: Record "Sales Line"): Decimal
    var
        Item: Record Item;
    begin
        if not GetItemFromSalesLine(SalesLine, Item) then
            exit(0);

        Item.Reset();
        Item.SetRange("Variant Filter", SalesLine."Variant Code");
        Item.SetRange("Location Filter", SalesLine."Location Code");
        Item.SetRange("Drop Shipment Filter", false);
        Item.CalcFields(
            "Qty. on Sales Order",
            "Qty. on Assembly Order",
            "Res. Qty. on Assembly Order",
            "Qty. on Service Order",
            Inventory,
            "Reserved Qty. on Inventory",
            "Qty. on Pre Sales Order",
            "Trans. Ord. Shipment (Qty.)");

        exit(
            Item.Inventory -
            Item."Qty. on Sales Order" -
            Item."Qty. on Assembly Order" -
            Item."Res. Qty. on Assembly Order" -
            Item."Qty. on Service Order" -
            Item."Reserved Qty. on Inventory" -
            Item."Qty. on Pre Sales Order" -
            Item."Trans. Ord. Shipment (Qty.)");
    end;

    procedure CalcAvailability_Item(ItemNo: Code[20]; var LocationCode: Code[20]): Decimal
    var
        Item: Record Item;
    begin
        Item.Get(ItemNo);
        Item.Reset();
        Item.SetRange("Location Filter", LocationCode);
        Item.SetRange("Drop Shipment Filter", false);
        Item.CalcFields(
            "Qty. on Sales Order",
            "Qty. on Service Order",
            Inventory,
            "Reserved Qty. on Inventory",
            "Trans. Ord. Shipment (Qty.)");

        exit(
            Item.Inventory -
            Item."Qty. on Sales Order" -
            Item."Qty. on Service Order" -
            Item."Reserved Qty. on Inventory" -
            Item."Trans. Ord. Shipment (Qty.)");
    end;

    procedure CalcAvailabilityTL_BackOrder(var TransferLine: Record "Transfer Line"): Decimal
    var
        Item: Record Item;
    begin
        if not GetItemFromTransferLine(TransferLine, Item) then
            exit(0);

        Item.Reset();
        Item.SetRange("Variant Filter", TransferLine."Variant Code");
        Item.SetRange("Location Filter", TransferLine."Transfer-from Code");
        Item.SetRange("Drop Shipment Filter", false);
        Item.CalcFields(
            "Qty. on Sales Order",
            "Qty. on Assembly Order",
            "Res. Qty. on Assembly Order",
            "Qty. on Service Order",
            Inventory,
            "Reserved Qty. on Inventory",
            "Trans. Ord. Shipment (Qty.)");

        exit(
            Item.Inventory -
            Item."Qty. on Sales Order" -
            Item."Qty. on Assembly Order" -
            Item."Res. Qty. on Assembly Order" -
            Item."Qty. on Service Order" -
            Item."Reserved Qty. on Inventory" -
            Item."Trans. Ord. Shipment (Qty.)");
    end;

    procedure CalcAvailabilityTransLine(var TransferLine: Record "Transfer Line"): Decimal
    var
        Item: Record Item;
        AvailableToPromise: Codeunit "Available to Promise";
        PeriodType: Enum "Analysis Period Type";
        GrossRequirement: Decimal;
        ScheduledReceipt: Decimal;
        AvailabilityDate: Date;
        LookaheadDateFormula: DateFormula;
    begin
        if not GetItemFromTransferLine(TransferLine, Item) then
            exit(0);

        if TransferLine."Shipment Date" <> 0D then
            AvailabilityDate := TransferLine."Shipment Date"
        else
            AvailabilityDate := WorkDate();

        Item.Reset();
        Item.SetRange("Date Filter", 0D, AvailabilityDate);
        Item.SetRange("Variant Filter", TransferLine."Variant Code");
        Item.SetRange("Location Filter", TransferLine."Transfer-from Code");
        Item.SetRange("Drop Shipment Filter", false);

        PeriodType := PeriodType::Day;
        Evaluate(LookaheadDateFormula, '<0D>');

        exit(
            AvailableToPromise.CalcQtyAvailableToPromise(
                Item,
                GrossRequirement,
                ScheduledReceipt,
                AvailabilityDate,
                PeriodType,
                LookaheadDateFormula));
    end;

    procedure CalcNoOfSubstitutionsTransLine(var TransferLine: Record "Transfer Line"): Integer
    var
        Item: Record Item;
    begin
        if not GetItemFromTransferLine(TransferLine, Item) then
            exit(0);

        Item.CalcFields("No. of Substitutes");
        exit(Item."No. of Substitutes");
    end;

    local procedure GetItemFromSalesLine(
        SalesLine: Record "Sales Line";
        var Item: Record Item): Boolean
    begin
        if (SalesLine.Type <> SalesLine.Type::Item) or (SalesLine."No." = '') then
            exit(false);

        exit(Item.Get(SalesLine."No."));
    end;

    local procedure GetItemFromTransferLine(
        TransferLine: Record "Transfer Line";
        var Item: Record Item): Boolean
    begin
        if TransferLine."Item No." = '' then
            exit(false);

        exit(Item.Get(TransferLine."Item No."));
    end;
}
