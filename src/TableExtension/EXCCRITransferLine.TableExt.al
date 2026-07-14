tableextension 50087 EXCCRITransferLine extends "Transfer Line"
{
    fields
    {
        modify("Item No.")
        {
            TableRelation = Item where(Type = const(Inventory), Blocked = const(false), Inactivo = const(false));

            trigger OnAfterValidate()
            var
                EXCCRIItem: Record Item;
            begin
                if "Item No." = '' then
                    exit;

                EXCCRIItem.Get("Item No.");
                EXCCRIItem.TestField("Item Disc. Group");
                EXCCRIUpdateConsignmentPriceAndTax();
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                EXCCRIUpdateConsignmentPriceAndTax();
                EXCCRIUpdateConsignmentAmounts();
            end;
        }
        modify("Qty. to Ship")
        {
            trigger OnAfterValidate()
            var
                EXCCRIDiscountAmount: Decimal;
            begin
                EXCCRIDiscountAmount :=
                    ("Qty. to Ship" * "Precio Venta Consignacion") *
                    "Descuento % Consignacion" / 100;
                "Importe Consignacion" :=
                    ("Qty. to Ship" * "Precio Venta Consignacion") -
                    EXCCRIDiscountAmount;
            end;
        }
        modify("In-Transit Code")
        {
            TableRelation = Location where("Use As In-Transit" = const(true), Inactivo = const(false));
        }
        modify("Transfer-from Code")
        {
            TableRelation = Location where(Inactivo = const(false));
        }
        modify("Transfer-to Code")
        {
            TableRelation = Location where(Inactivo = const(false));
        }

        field(50000; "Precio Venta Consignacion"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50001; "Descuento % Consignacion"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50002; "Importe Consignacion"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50003; "Importe Consignacion Original"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50004; "ISBN"; Text[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item.ISBN;
        }

        field(50010; "No. Pedido Consignacion"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50011; "No. Linea Pedido Consignacion"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50012; "No. Mov. Prod. Cosg. a Liq."; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50014; "Cantidad Devuelta"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50015; "Grupo registro IVA prod."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "VAT Product Posting Group";
        }

        field(50016; "Grupo registro IVA neg."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "VAT Business Posting Group";
        }

        field(50017; "% IVA"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50018; "Importe IVA"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50020; "Cantidad Aprobada"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                EXCCRICustomer: Record Customer;
                EXCCRISantillanaSetup: Record 56001;
                EXCCRITransferHeader: Record "Transfer Header";
                EXCCRIUserSetup: Record "User Setup";
                EXCCRIAvailabilityManagement: Codeunit 7171;
                EXCCRIAvailableQuantity: Decimal;
            begin
                EXCCRISantillanaSetup.Get();
                if
                    EXCCRISantillanaSetup."Cantidades sin Decimales" and
                    ("Cantidad Aprobada" mod 1 <> 0)
                then
                    Error(EXCCRIDecimalQuantityErr);

                if not EXCCRIUserSetup.Get(UserId()) then
                    Error(EXCCRIApprovalPermissionErr);
                if not EXCCRIUserSetup."Aprueba Cantidades Transf." then
                    Error(EXCCRIApprovalPermissionErr);

                Validate(Quantity, 0);
                Modify(true);

                "Cantidad pendiente BO" := 0;
                "Cantidad a Anular" := 0;

                //TODO: Ver EXCCRIAvailableQuantity :=
                //TODO: Ver EXCCRIAvailabilityManagement.CalcAvailabilityTL_BackOrder(Rec);

                if EXCCRIAvailableQuantity >= "Cantidad Aprobada" then begin
                    Validate(Quantity, "Cantidad Aprobada");
                    exit;
                end;

                if EXCCRITransferHeader.Get("Document No.") then
                    if EXCCRITransferHeader."Pedido Consignacion" then
                        EXCCRICustomer.Get(EXCCRITransferHeader."Transfer-to Code");

                if EXCCRIAvailableQuantity >= 0 then begin
                    Validate(Quantity, EXCCRIAvailableQuantity);
                    if EXCCRICustomer."Admite Pendientes en Pedidos" then
                        Validate(
                            "Cantidad pendiente BO",
                            "Cantidad Aprobada" -
                            EXCCRIAvailableQuantity -
                            "Cantidad Anulada");
                end;
            end;
        }

        field(50021; "Cantidad pendiente BO"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50022; "Cantidad a Anular"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Cantidad a Anular" > "Cantidad pendiente BO" then
                    Error(
                        EXCCRIQuantityExceedsPendingErr,
                        FieldCaption("Cantidad a Anular"));

                if "Cantidad a Anular" < 0 then
                    Error(
                        EXCCRINegativeQuantityErr,
                        FieldCaption("Cantidad a Anular"));
            end;
        }

        field(50023; "Cantidad Solicitada"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                EXCCRISantillanaSetup: Record 56001;
            begin
                EXCCRISantillanaSetup.Get();
                if
                    EXCCRISantillanaSetup."Cantidades sin Decimales" and
                    ("Cantidad Solicitada" mod 1 <> 0)
                then
                    Error(EXCCRIDecimalQuantityErr);
            end;
        }

        field(50024; "Cantidad a Ajustar"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Cantidad a Ajustar" > "Cantidad pendiente BO" then
                    Error(
                        EXCCRIQuantityExceedsPendingErr,
                        FieldCaption("Cantidad a Ajustar"));

                if "Cantidad a Ajustar" < 0 then
                    Error(
                        EXCCRINegativeQuantityErr,
                        FieldCaption("Cantidad a Ajustar"));
            end;
        }

        field(50025; "Porcentaje Cant. Aprobada"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                EXCCRIUserSetup: Record "User Setup";
                EXCCRIAvailabilityManagement: Codeunit 7171;
                EXCCRIAvailableQuantity: Decimal;
                EXCCRIApprovedQuantity: Decimal;
            begin
                if
                    ("Porcentaje Cant. Aprobada" > 100) or
                    ("Porcentaje Cant. Aprobada" < 0)
                then
                    Error(EXCCRIInvalidPercentageErr);

                if not EXCCRIUserSetup.Get(UserId()) then
                    Error(EXCCRIApprovalPermissionErr);
                if not EXCCRIUserSetup."Aprueba Cantidades Transf." then
                    Error(EXCCRIApprovalPermissionErr);

                EXCCRIApprovedQuantity :=
                    Round(
                        "Cantidad Solicitada" *
                        "Porcentaje Cant. Aprobada" / 100,
                        1,
                        '<');

                //TODO: Ver EXCCRIAvailableQuantity :=
                //TODO: Ver EXCCRIAvailabilityManagement.CalcAvailabilityTransLine(Rec);

                if EXCCRIAvailableQuantity >= 0 then
                    Validate("Cantidad Aprobada", EXCCRIApprovedQuantity);
            end;
        }

        field(50029; "Cantidad Anulada"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50030; "ISBN2"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Item.ISBN where("No." = field("Item No.")));
        }

        field(56008; "Bin Ranking"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(56028; "Disponible BackOrder"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(56076; "Tipo Transferencia"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Venta","Promocion";
        }

        field(67000; "Cantidad Alumnos"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            DecimalPlaces = 0 : 0;
        }

        field(67001; "Adopcion"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Conquista","Mantener","Perdida","Retiro";
            Editable = false;
        }

        field(67002; "Cod. Colegio"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Contact;
            Editable = false;
        }
    }

    keys
    {
        key(EXCCRIConsignmentByDocument; "Document No.", "Derived From Line No.")
        {
            //TODO: Ver SumIndexFields =
            //TODO: Ver "Importe Consignacion",
            //TODO: Ver "Importe Consignacion Original";
        }
        key(EXCCRIAvailableBackOrder; "Disponible BackOrder")
        {
        }
    }

    trigger OnBeforeModify()
    var
        EXCCRITransferHeader: Record "Transfer Header";
    begin
        if EXCCRIAutoModify then
            exit;

        if EXCCRITransferHeader.Get("Document No.") then
            EXCCRITransferHeader.ControlClasificacionDevolucion();
    end;

    procedure ActLinBO()
    var
        EXCCRITransferHeader: Record "Transfer Header";
        EXCCRIAvailabilityManagement: Codeunit 7171;
    begin
        EXCCRITransferHeader.Get("Document No.");
        EXCCRITransferHeader.TestField(Status, EXCCRITransferHeader.Status::Open);

        if "Cantidad a Ajustar" > 0 then begin
            if "Cantidad a Ajustar" > "Cantidad pendiente BO" then
                Error(
                    EXCCRIQuantityExceedsPendingErr,
                    FieldCaption("Cantidad a Ajustar"));

            //TODO: Ver 
            /*
            if EXCCRIAvailabilityManagement.CalcAvailabilityTL_BackOrder(Rec) >= "Cantidad a Ajustar" then begin
                Quantity += "Cantidad a Ajustar";
                Validate(Quantity);

                "Cantidad pendiente BO" :=
                    "Cantidad Aprobada" -
                    Quantity -
                    "Cantidad Anulada";

                if "Cantidad a Anular" > "Cantidad pendiente BO" then
                    "Cantidad a Anular" := "Cantidad pendiente BO";

                "Cantidad a Ajustar" := 0;
            end else
                Error(
                    EXCCRIQuantityExceedsAvailabilityErr,
                    FieldCaption("Cantidad a Ajustar"));
                    */
        end;

        if "Cantidad a Anular" > 0 then
            if "Cantidad a Anular" <= "Cantidad pendiente BO" then begin
                "Cantidad pendiente BO" -= "Cantidad a Anular";
                "Cantidad Anulada" += "Cantidad a Anular";
                "Cantidad a Anular" := 0;
            end else
                Error(
                    EXCCRIQuantityExceedsAvailabilityErr,
                    FieldCaption("Cantidad a Anular"));
    end;

    procedure SetAutoModify(EXCCRINewAutoModify: Boolean)
    begin
        EXCCRIAutoModify := EXCCRINewAutoModify;
    end;

    procedure ItemAvailability(EXCCRIAvailabilityType: Option Date,Variant,Location)
    var
        EXCCRIItem: Record Item;
        EXCCRIItemAvailByDate: Page 157;
        EXCCRIItemAvailByLocation: Page "Item Availability by Location";
        EXCCRIItemAvailByVariant: Page "Item Availability by Variant";
    begin
        TestField("Item No.");

        EXCCRIItem.Get("Item No.");
        EXCCRIItem.SetRange("No.", "Item No.");
        EXCCRIItem.SetRange("Date Filter", 0D, "Shipment Date");

        case EXCCRIAvailabilityType of
            EXCCRIAvailabilityType::Date:
                begin
                    EXCCRIItem.SetRange("Variant Filter", "Variant Code");
                    EXCCRIItem.SetRange("Location Filter", "Transfer-from Code");
                    EXCCRIItemAvailByDate.LookupMode(false);
                    EXCCRIItemAvailByDate.SetRecord(EXCCRIItem);
                    EXCCRIItemAvailByDate.SetTableView(EXCCRIItem);

                    if
                        (EXCCRIItemAvailByDate.RunModal() = Action::LookupOK) and
                        ("Shipment Date" <> EXCCRIItemAvailByDate.GetLastDate())
                    then
                        if Confirm(
                            EXCCRIChangeFieldQst,
                            true,
                            FieldCaption("Shipment Date"),
                            "Shipment Date",
                            EXCCRIItemAvailByDate.GetLastDate())
                        then
                            Validate(
                                "Shipment Date",
                                EXCCRIItemAvailByDate.GetLastDate());
                end;
            EXCCRIAvailabilityType::Variant:
                begin
                    EXCCRIItem.SetRange("Location Filter", "Transfer-from Code");
                    EXCCRIItemAvailByVariant.LookupMode(false);
                    EXCCRIItemAvailByVariant.SetRecord(EXCCRIItem);
                    EXCCRIItemAvailByVariant.SetTableView(EXCCRIItem);

                    if
                        (EXCCRIItemAvailByVariant.RunModal() = Action::LookupOK) and
                        ("Variant Code" <> EXCCRIItemAvailByVariant.GetLastVariant())
                    then
                        if Confirm(
                            EXCCRIChangeFieldQst,
                            true,
                            FieldCaption("Variant Code"),
                            "Variant Code",
                            EXCCRIItemAvailByVariant.GetLastVariant())
                        then
                            Validate(
                                "Variant Code",
                                EXCCRIItemAvailByVariant.GetLastVariant());
                end;
            EXCCRIAvailabilityType::Location:
                begin
                    EXCCRIItem.SetRange("Variant Filter", "Variant Code");
                    EXCCRIItemAvailByLocation.LookupMode(false);
                    EXCCRIItemAvailByLocation.SetRecord(EXCCRIItem);
                    EXCCRIItemAvailByLocation.SetTableView(EXCCRIItem);

                    if
                        (EXCCRIItemAvailByLocation.RunModal() = Action::LookupOK) and
                        ("Transfer-from Code" <>
                         EXCCRIItemAvailByLocation.GetLastLocation())
                    then
                        if Confirm(
                            EXCCRIChangeFieldQst,
                            true,
                            FieldCaption("Transfer-from Code"),
                            "Transfer-from Code",
                            EXCCRIItemAvailByLocation.GetLastLocation())
                        then
                            Validate(
                                "Transfer-from Code",
                                EXCCRIItemAvailByLocation.GetLastLocation());
                end;
        end;
    end;

    local procedure EXCCRIUpdateConsignmentPriceAndTax()
    var
        EXCCRICustomer: Record Customer;
        EXCCRIItem: Record Item;
        EXCCRITransferHeader: Record "Transfer Header";
        EXCCRIVATPostingSetup: Record "VAT Posting Setup";
        //TODO: Ver EXCCRISantillanaFunctions: Codeunit 56000;
        EXCCRICustomerNo: Code[20];
    begin
        if not EXCCRITransferHeader.Get("Document No.") then
            exit;
        if not EXCCRITransferHeader."Pedido Consignacion" then
            exit;
        if "Item No." = '' then
            exit;

        EXCCRIItem.Get("Item No.");

        if EXCCRITransferHeader."Devolucion Consignacion" then
            EXCCRICustomerNo := EXCCRITransferHeader."Transfer-from Code"
        else
            EXCCRICustomerNo := EXCCRITransferHeader."Transfer-to Code";

        //TODO: Ver
        /*
        if EXCCRIItem."Unit Price" = 0 then begin
            if
                EXCCRITransferHeader."Devolucion Consignacion" or
                not EXCCRITransferHeader."Consignacion Muestras"
            then
                "Precio Venta Consignacion" :=
                    EXCCRISantillanaFunctions.CalcrPrecio(
                        "Item No.",
                        EXCCRICustomerNo,
                        "Unit of Measure Code",
                        EXCCRITransferHeader."Posting Date");
        end else
            "Precio Venta Consignacion" := EXCCRIItem."Unit Price";

        if
            EXCCRITransferHeader."Devolucion Consignacion" or
            not EXCCRITransferHeader."Consignacion Muestras"
        then
            "Descuento % Consignacion" :=
                EXCCRISantillanaFunctions.CalcDesc(
                    "Item No.",
                    EXCCRICustomerNo,
                    "Unit of Measure Code",
                    EXCCRITransferHeader."Posting Date");*/

        if EXCCRICustomer.Get(EXCCRITransferHeader."Transfer-to Code") then begin
            Validate(
                "Grupo registro IVA prod.",
                EXCCRIItem."VAT Prod. Posting Group");
            Validate(
                "Grupo registro IVA neg.",
                EXCCRICustomer."VAT Bus. Posting Group");

            if EXCCRIVATPostingSetup.Get(
                "Grupo registro IVA neg.",
                "Grupo registro IVA prod.")
            then
                Validate("% IVA", EXCCRIVATPostingSetup."VAT %");
        end;
    end;

    local procedure EXCCRIUpdateConsignmentAmounts()
    var
        EXCCRIDiscountAmount: Decimal;
    begin
        EXCCRIDiscountAmount :=
            (Quantity * "Precio Venta Consignacion") *
            "Descuento % Consignacion" / 100;

        "Importe Consignacion Original" :=
            (Quantity * "Precio Venta Consignacion") -
            EXCCRIDiscountAmount;

        "Importe IVA" :=
            "Importe Consignacion Original" *
            "% IVA" / 100;
    end;

    var
        EXCCRIAutoModify: Boolean;
        EXCCRIApprovalPermissionErr: Label 'The user is not allowed to approve quantities on transfer orders.';
        EXCCRIDecimalQuantityErr: Label 'The current setup does not allow decimal quantities.';
        EXCCRIInvalidPercentageErr: Label 'The percentage must be between 0 and 100.';
        EXCCRIQuantityExceedsPendingErr: Label '%1 cannot be greater than the pending backorder quantity.';
        EXCCRINegativeQuantityErr: Label '%1 cannot be less than zero.';
        EXCCRIQuantityExceedsAvailabilityErr: Label '%1 cannot be greater than availability.';
        EXCCRIChangeFieldQst: Label 'Change %1 from %2 to %3?';
}
