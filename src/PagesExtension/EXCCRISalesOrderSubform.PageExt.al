pageextension 50024 EXCCRISalesOrderSubform extends "Sales Order Subform"
{
    layout
    {
        modify(Quantity)
        {
            Editable = false;
        }
        modify("Unit Price")
        {
            Editable = EXCCRIUnitPriceEditable;

            trigger OnAfterValidate()
            begin
                EXCCRIValidateUnitPricePermission();
                EXCCRIValidateSalesTypePrice();
            end;
        }
        modify("Line Discount %")
        {
            trigger OnAfterValidate()
            begin
                EXCCRIValidateDiscountPercentage();
            end;
        }
        addbefore("No.")
        {
            field(EXCCRIType; Rec.Type)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the type of record represented by the sales order line.';
            }
        }
        addafter("No.")
        {
            field(EXCCRIISBN; Rec.EAN)
            {
                ApplicationArea = All;
                Caption = '<ISBN>';
                ToolTip = 'Specifies the ISBN or barcode associated with the item on the sales order line.';
            }
            field(EXCCRIConsignmentOrderNo; Rec."No. Pedido Consignacion")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the consignment order from which the sales line originated.';
            }
            field(EXCCRISharingCode; Rec.Compartir)
            {
                ApplicationArea = All;
                Caption = 'Sharing Code';
                ToolTip = 'Specifies the sharing classification assigned to the sales order line.';
            }
            field(EXCCRIAvailability; EXCCRIAvailabilityValue)
            {
                ApplicationArea = All;
                Caption = 'Availability';
                Editable = false;
                Style = Strong;
                StyleExpr = true;
                ToolTip = 'Specifies the calculated backorder availability for the sales order line.';
            }
            field(EXCCRIPendingBackorderQuantity; Rec."Cantidad pendiente BO")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the quantity that remains pending as backorder.';
            }
            field(EXCCRIQuantityToCancel; Rec."Cantidad a Anular")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the backorder quantity that will be canceled.';
            }
            field(EXCCRIQuantityToAdjust; Rec."Cantidad a Ajustar")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the backorder quantity that will be adjusted.';
            }
            field(EXCCRIRequestedQuantity; Rec."Cantidad Solicitada")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity originally requested on the sales order line.';
            }
            field(EXCCRICanceledQuantity; Rec."Cantidad Anulada")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the quantity that has been canceled on the sales order line.';
            }
            field(EXCCRIApprovedQuantityPercentage; Rec."Porcentaje Cant. Aprobada")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the percentage of the requested quantity that has been approved.';
            }
            field(EXCCRIApprovedQuantity; Rec."Cantidad Aprobada")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the approved quantity for the sales order line.';

                trigger OnValidate()
                begin
                    Rec."Porcentaje Cant. Aprobada" := 0;
                    CurrPage.Update(false);
                    CurrPage.SaveRecord();
                end;
            }
            field(EXCCRIAvailabilityText; EXCCRIAvailabilityTextValue)
            {
                ApplicationArea = All;
                Caption = 'Availability';
                Editable = false;
                ToolTip = 'Shows the calculated backorder availability for the sales order line.';
            }
            field(EXCCRILineDiscountAmount; Rec."Line Discount Amount")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the discount amount granted for the sales order line.';

                trigger OnValidate()
                begin
                    EXCCRIValidateDiscountAmount();
                end;
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action(EXCCRIUpdateBackorder)
            {
                ApplicationArea = All;
                Caption = 'Update Backorder';
                ToolTip = 'Updates the backorder quantities for the selected sales order line.';

                trigger OnAction()
                begin
                    Rec.ActLinBO();
                    CurrPage.Update(false);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        EXCCRILoadUserSetup();
    end;

    trigger OnAfterGetRecord()
    begin
        EXCCRIUpdateUnitPriceEditable();
        EXCCRIUpdateAvailability();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        EXCCRIUpdateUnitPriceEditable();
        EXCCRIUpdateAvailability();
    end;

    procedure SplitIC()
    var
        EXCCRISalesLine: Record "Sales Line";
    begin
        CurrPage.SetSelectionFilter(EXCCRISalesLine);
        //TODO: Ver Report.Run(
        //TODO: Ver     Report::"Split Sales Item Charge",
        //TODO: Ver     false,
        //TODO: Ver     false,
        //TODO: Ver    EXCCRISalesLine);
    end;

    local procedure EXCCRILoadUserSetup()
    begin
        if not EXCCRIUserSetup.Get(UserId()) then
            Clear(EXCCRIUserSetup);

        EXCCRIUpdateUnitPriceEditable();
    end;

    local procedure EXCCRIUpdateUnitPriceEditable()
    begin
        if Rec.Type <> Rec.Type::Item then
            EXCCRIUnitPriceEditable := true
        else
            EXCCRIUnitPriceEditable :=
                EXCCRIUserSetup."Modifica Precio Venta";
    end;

    local procedure EXCCRIUpdateAvailability()
    begin
        //TODO: Ver EXCCRIAvailabilityValue :=
        //TODO: Ver     EXCCRISalesInfoPaneMgt.CalcAvailability_BackOrder(Rec);
        EXCCRIAvailabilityTextValue :=
            StrSubstNo('(%1)', EXCCRIAvailabilityValue);
    end;

    local procedure EXCCRIValidateUnitPricePermission()
    begin
        if EXCCRIUserSetup."Modifica Precio Venta" then
            exit;

        if Rec."Document Type" in
           [Rec."Document Type"::Order, Rec."Document Type"::Invoice]
        then
            Error(
                EXCCRIFieldModificationNotAllowedErr,
                UserId(),
                Rec.FieldCaption("Unit Price"),
                Rec.FieldCaption("Document Type"),
                Rec."Document Type");
    end;

    local procedure EXCCRIValidateDiscountPercentage()
    begin
        if not EXCCRIUserSetup."Modifica Descuento Venta" then begin
            if Rec."Document Type" in
               [Rec."Document Type"::Order, Rec."Document Type"::Invoice]
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

    local procedure EXCCRIValidateDiscountAmount()
    begin
        if not EXCCRIUserSetup."Modifica Descuento Venta" then begin
            if Rec."Document Type" in
               [Rec."Document Type"::Order, Rec."Document Type"::Invoice]
            then
                Error(
                    EXCCRIFieldModificationNotAllowedErr,
                    UserId(),
                    Rec.FieldCaption("Line Discount Amount"),
                    Rec.FieldCaption("Document Type"),
                    Rec."Document Type");

            exit;
        end;

        if (EXCCRIUserSetup."Permitir Descuento Hasta" = 0) and
           (Rec."Line Discount Amount" > 0)
        then
            Error(EXCCRIDiscountSetupMissingErr);
    end;

    local procedure EXCCRIValidateSalesTypePrice()
    var
        EXCCRIItem: Record Item;
        EXCCRISalesHeader: Record "Sales Header";
        EXCCRISantillanaSetup: Record 56001;
    begin
        EXCCRISantillanaSetup.Get();
        EXCCRISalesHeader.Get(
            Rec."Document Type",
            Rec."Document No.");

        if EXCCRISalesHeader."Tipo de Venta" =
           EXCCRISalesHeader."Tipo de Venta"::Muestras
        then
            if EXCCRIItem.Get(Rec."No.") then
                Error(EXCCRISalesTypePriceModificationErr);

        if EXCCRISalesHeader."Tipo de Venta" =
           EXCCRISalesHeader."Tipo de Venta"::Donaciones
        then
            if EXCCRIItem.Get(Rec."No.") then
                if EXCCRISantillanaSetup."Precio de Venta Donaciones" =
                   EXCCRISantillanaSetup."Precio de Venta Donaciones"::Costo
                then
                    Rec.Validate("Unit Price", EXCCRIItem."Unit Cost")
                else
                    Error(EXCCRISalesTypePriceModificationErr);
    end;

    var
        EXCCRIUserSetup: Record "User Setup";
        EXCCRISalesInfoPaneMgt: Codeunit "Sales Info-Pane Management";
        EXCCRIAvailabilityValue: Decimal;
        EXCCRIAvailabilityTextValue: Text[100];
        EXCCRIUnitPriceEditable: Boolean;
        EXCCRIFieldModificationNotAllowedErr: Label 'User %1 is not allowed to change %2 in %3 %4.';
        EXCCRIDiscountSetupMissingErr: Label 'The maximum sales discount percentage is not configured in User Setup.';
        EXCCRIMaximumDiscountExceededErr: Label 'User %1 is only allowed to apply discounts up to %2 percent.';
        EXCCRISalesTypePriceModificationErr: Label 'Prices cannot be modified on orders with the Samples or Donations sale type.';
}
