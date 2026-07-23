codeunit 61014 EXCCRIReleaseSalesDocSub
{
    SingleInstance = true;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeReleaseSalesDoc', '', false, false)]
    local procedure OnBeforeReleaseSalesDoc(
        var SalesHeader: Record "Sales Header";
        PreviewMode: Boolean;
        var IsHandled: Boolean;
        var SkipCheckReleaseRestrictions: Boolean;
        SkipWhseRequestOperations: Boolean)
    var
        EXCCRISetup: Record 56001;
        IgnoreControls: Boolean;
    begin
        IgnoreControls := EXCCRIIgnoreControlsOnce;
        EXCCRIIgnoreControlsOnce := false;

        if not IgnoreControls then
            EXCCRIValidateMobilityUser();

        EXCCRIValidateQuoteCategory(SalesHeader);

        EXCCRISetup.Get();
        EXCCRIValidateZeroAmountLines(
            SalesHeader,
            EXCCRISetup);
        EXCCRIValidateBillingDimension(
            SalesHeader,
            EXCCRISetup);

        if
            SalesHeader.Origen =
            SalesHeader.Origen::"E-Commerce"
        then
            SkipCheckReleaseRestrictions := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnCodeOnAfterCheckCustomerCreated', '', false, false)]
    local procedure OnCodeOnAfterCheckCustomerCreated(
        var SalesHeader: Record "Sales Header";
        PreviewMode: Boolean;
        var IsHandled: Boolean;
        var LinesWereModified: Boolean)
    begin
        if SalesHeader.TPV <> '' then
            exit;

        SalesHeader.TestField("VAT Registration No.");
        SalesHeader.TestField("E-Mail-FE");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnAfterReleaseSalesDoc', '', false, false)]
    local procedure OnAfterReleaseSalesDoc(
        var SalesHeader: Record "Sales Header";
        PreviewMode: Boolean;
        var LinesWereModified: Boolean;
        SkipWhseRequestOperations: Boolean)
    begin
        if PreviewMode then
            exit;

        if
            SalesHeader.Status <>
            SalesHeader.Status::Released
        then
            exit;

        EXCCRIShowLocationCapacityWarnings(SalesHeader);
    end;

    procedure SetIgnorarControles(IgnoreControls: Boolean)
    begin
        EXCCRIIgnoreControlsOnce := IgnoreControls;
    end;

    local procedure EXCCRIValidateMobilityUser()
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId()) then
            exit;

        if UserSetup."Usuario Movilidad" then
            Error(EXCCRIMobilityUserErr);
    end;

    local procedure EXCCRIValidateQuoteCategory(
        SalesHeader: Record "Sales Header")
    begin
        if
            SalesHeader."Document Type" <>
            SalesHeader."Document Type"::Quote
        then
            exit;

        if SalesHeader."Categoria Pedido Venta" = '' then
            Error(
                EXCCRIQuoteCategoryErr,
                SalesHeader."Document Type",
                SalesHeader."No.");
    end;

    local procedure EXCCRIValidateZeroAmountLines(
        SalesHeader: Record "Sales Header";
        EXCCRISetup: Record 56001)
    var
        SalesLine: Record "Sales Line";
        ValidateLines: Boolean;
    begin
        case SalesHeader."Tipo de Venta" of
            SalesHeader."Tipo de Venta"::Muestras:
                ValidateLines :=
                    EXCCRISetup."Precio de Venta Muestras" <>
                    EXCCRISetup."Precio de Venta Muestras"::Cero;
            SalesHeader."Tipo de Venta"::Donaciones:
                ValidateLines :=
                    EXCCRISetup."Precio de Venta Donaciones" =
                    EXCCRISetup."Precio de Venta Donaciones"::Costo;
            else
                ValidateLines := true;
        end;

        if not ValidateLines then
            exit;

        SalesLine.SetRange(
            "Document Type",
            SalesHeader."Document Type");
        SalesLine.SetRange(
            "Document No.",
            SalesHeader."No.");

        if SalesLine.FindSet() then
            repeat
                if
                    (SalesLine.Quantity <> 0) and
                    (SalesLine.Quantity *
                     SalesLine."Unit Price" = 0)
                then
                    Error(
                        EXCCRIZeroLineAmountErr,
                        SalesLine."Line No.",
                        SalesLine."Document No.");
            until SalesLine.Next() = 0;
    end;

    local procedure EXCCRIValidateBillingDimension(
        SalesHeader: Record "Sales Header";
        EXCCRISetup: Record 56001)
    var
        DimensionSetEntry: Record "Dimension Set Entry";
    begin
        if EXCCRISetup."Dim. Tipo Facturacion" = '' then
            exit;

        if
            (SalesHeader."Dimension Set ID" = 0) or
            not DimensionSetEntry.Get(
                SalesHeader."Dimension Set ID",
                EXCCRISetup."Dim. Tipo Facturacion")
        then
            Error(
                EXCCRIBillingDimensionErr,
                DimensionSetEntry.FieldCaption("Dimension Code"),
                EXCCRISetup."Dim. Tipo Facturacion",
                SalesHeader.FieldCaption("Document Type"),
                SalesHeader."Document Type");
    end;

    local procedure EXCCRIShowLocationCapacityWarnings(
        SalesHeader: Record "Sales Header")
    var
        Location: Record Location;
        SalesLine: Record "Sales Line";
        HandledLocations: Dictionary of [Text, Boolean];
    begin
        if not GuiAllowed() then
            exit;

        SalesLine.SetRange(
            "Document Type",
            SalesHeader."Document Type");
        SalesLine.SetRange(
            "Document No.",
            SalesHeader."No.");
        SalesLine.SetFilter(
            Type,
            '<>%1',
            SalesLine.Type::" ");

        if not SalesLine.FindSet() then
            exit;

        repeat
            if
                (SalesLine."Location Code" <> '') and
                not HandledLocations.ContainsKey(
                    SalesLine."Location Code") and
                Location.Get(SalesLine."Location Code")
            then begin
                HandledLocations.Add(
                    SalesLine."Location Code",
                    true);
                EXCCRIShowCapacityWarning(Location);
            end;
        until SalesLine.Next() = 0;
    end;

    local procedure EXCCRIShowCapacityWarning(
        Location: Record Location)
    var
        CapacityRemaining: Decimal;
        SalesQuantity: Decimal;
        TransferQuantity: Decimal;
    begin
        if Location."Cant. Lineas a Man. Por dia" = 0 then
            exit;

        SalesQuantity :=
            EXCCRIGetSalesQuantity(
                Location.Code);
        TransferQuantity :=
            EXCCRIGetTransferQuantity(
                Location.Code);

        CapacityRemaining :=
            Location."Cant. Lineas a Man. Por dia" -
            (SalesQuantity + TransferQuantity);

        if
            (CapacityRemaining <=
             Location."Aviso cuando resten") and
            (CapacityRemaining > 0)
        then
            Message(
                EXCCRIRemainingCapacityMsg,
                CapacityRemaining,
                Location.Code);

        if CapacityRemaining <= 0 then
            Message(
                EXCCRICapacityExceededMsg,
                Location.Code);
    end;

    local procedure EXCCRIGetSalesQuantity(
        LocationCode: Code[10]): Decimal
    var
        SalesLine: Record "Sales Line";
        TotalQuantity: Decimal;
    begin
        SalesLine.SetCurrentKey(
            "Location Code",
            "Shipment Date");
        SalesLine.SetRange(
            "Location Code",
            LocationCode);
        SalesLine.SetRange(
            "Shipment Date",
            WorkDate());

        if SalesLine.FindSet() then
            repeat
                TotalQuantity += SalesLine.Quantity;
            until SalesLine.Next() = 0;

        exit(TotalQuantity);
    end;

    local procedure EXCCRIGetTransferQuantity(
        LocationCode: Code[10]): Decimal
    var
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        TotalQuantity: Decimal;
    begin
        TransferHeader.SetRange(
            "Transfer-from Code",
            LocationCode);
        TransferHeader.SetRange(
            "Posting Date",
            WorkDate());
        TransferHeader.SetRange(
            Status,
            TransferHeader.Status::Released);

        if TransferHeader.FindSet() then
            repeat
                TransferLine.Reset();
                TransferLine.SetRange(
                    "Document No.",
                    TransferHeader."No.");

                if TransferLine.FindSet() then
                    repeat
                        TotalQuantity +=
                            TransferLine.Quantity;
                    until TransferLine.Next() = 0;
            until TransferHeader.Next() = 0;

        exit(TotalQuantity);
    end;

    var
        EXCCRIIgnoreControlsOnce: Boolean;
        EXCCRIMobilityUserErr: Label
            'Mobility users cannot release sales documents.';
        EXCCRIQuoteCategoryErr: Label
            'Order Category must have a value in Sales Header: Document Type=%1, No.=%2.';
        EXCCRIZeroLineAmountErr: Label
            'The amount of line %1 in sales document %2 cannot be zero.';
        EXCCRIBillingDimensionErr: Label
            'You must specify %1 %2 for %3 %4.';
        EXCCRIRemainingCapacityMsg: Label
            '%1 items remain available for handling at location %2 according to its maximum daily capacity.';
        EXCCRICapacityExceededMsg: Label
            'The items to be handled today exceed the estimated capacity for location %1.';
}
