pageextension 50032 EXCCRISalesQuoteSubform extends "Sales Quote Subform"
{
    layout
    {
        modify("Unit Price")
        {
            trigger OnAfterValidate()
            begin
                EXCCRIValidateUnitPricePermission();
            end;
        }
        modify("Line Discount %")
        {
            trigger OnAfterValidate()
            begin
                EXCCRIValidateSalesDiscount();
            end;
        }
        addafter("No.")
        {
            field(EXCCRILineNo; Rec."Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the line number of the sales quote line.';
            }
            field(EXCCRISharingCode; Rec.Compartir)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the sharing classification assigned to the sales quote line.';
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not EXCCRIUserSetup.Get(UserId()) then
            Clear(EXCCRIUserSetup);
    end;

    local procedure EXCCRIValidateUnitPricePermission()
    begin
        if EXCCRIUserSetup."Modifica Precio Venta" then
            exit;

        if Rec."Document Type" in
           [Rec."Document Type"::Quote, Rec."Document Type"::Invoice]
        then
            Error(
                EXCCRIFieldModificationNotAllowedErr,
                UserId(),
                Rec.FieldCaption("Unit Price"),
                Rec.FieldCaption("Document Type"),
                Rec."Document Type");
    end;

    local procedure EXCCRIValidateSalesDiscount()
    begin
        if not EXCCRIUserSetup."Modifica Descuento Venta" then begin
            if Rec."Document Type" in
               [Rec."Document Type"::Quote, Rec."Document Type"::Invoice]
            then
                Error(
                    EXCCRIFieldModificationNotAllowedErr,
                    UserId(),
                    Rec.FieldCaption("Line Discount %"),
                    Rec.FieldCaption("Document Type"),
                    Rec."Document Type");

            exit;
        end;

        if (EXCCRIUserSetup."Permitir Descuento Hasta" = 0) and
           (Rec."Line Discount %" > 0)
        then
            Error(EXCCRIDiscountSetupMissingErr);

        if Rec."Line Discount %" >
           EXCCRIUserSetup."Permitir Descuento Hasta"
        then
            Error(
                EXCCRIMaximumDiscountExceededErr,
                UserId(),
                EXCCRIUserSetup."Permitir Descuento Hasta");
    end;

    var
        EXCCRIUserSetup: Record "User Setup";
        EXCCRIFieldModificationNotAllowedErr: Label 'User %1 is not allowed to change %2 in %3 %4.';
        EXCCRIDiscountSetupMissingErr: Label 'The maximum sales discount percentage is not configured in User Setup.';
        EXCCRIMaximumDiscountExceededErr: Label 'User %1 is only allowed to apply discounts up to %2 percent.';
}
