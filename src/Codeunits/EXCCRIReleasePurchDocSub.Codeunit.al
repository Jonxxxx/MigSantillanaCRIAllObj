codeunit 61015 EXCCRIReleasePurchDocSub
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnBeforeReleasePurchaseDoc', '', false, false)]
    local procedure OnBeforeReleasePurchaseDoc(
        var PurchaseHeader: Record "Purchase Header";
        PreviewMode: Boolean;
        var SkipCheckReleaseRestrictions: Boolean;
        var IsHandled: Boolean;
        SkipWhseRequestOperations: Boolean)
    var
        EXCCRISetup: Record 56001;
    begin
        EXCCRISetup.Get();

        EXCCRIValidateBillingDimension(
            PurchaseHeader,
            EXCCRISetup);
    end;

    local procedure EXCCRIValidateBillingDimension(
        PurchaseHeader: Record "Purchase Header";
        EXCCRISetup: Record 56001)
    var
        DimensionSetEntry: Record "Dimension Set Entry";
        PurchaseLine: Record "Purchase Line";
    begin
        if EXCCRISetup."Dim. Tipo Facturacion" = '' then
            exit;

        PurchaseLine.SetRange(
            "Document Type",
            PurchaseHeader."Document Type");
        PurchaseLine.SetRange(
            "Document No.",
            PurchaseHeader."No.");
        PurchaseLine.SetRange(
            Type,
            PurchaseLine.Type::Item);
        PurchaseLine.SetFilter(
            Quantity,
            '<>%1',
            0);

        if PurchaseLine.IsEmpty() then
            exit;

        if
            (PurchaseHeader."Dimension Set ID" = 0) or
            not DimensionSetEntry.Get(
                PurchaseHeader."Dimension Set ID",
                EXCCRISetup."Dim. Tipo Facturacion")
        then
            Error(
                EXCCRIBillingDimensionErr,
                DimensionSetEntry.FieldCaption("Dimension Code"),
                EXCCRISetup."Dim. Tipo Facturacion",
                PurchaseHeader.FieldCaption("Document Type"),
                PurchaseHeader."Document Type");
    end;

    var
        EXCCRIBillingDimensionErr: Label
            'You must specify %1 %2 for %3 %4.';
}
