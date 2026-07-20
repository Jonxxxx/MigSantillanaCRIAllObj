codeunit 61004 EXCCRISalesPostSub
{
    Permissions =
        tabledata "Sales Invoice Header" = rm,
        tabledata "Purchase Header" = rim,
        tabledata "Purchase Line" = rim;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    local procedure OnBeforePostSalesDoc(
        var SalesHeader: Record "Sales Header";
        CommitIsSuppressed: Boolean;
        PreviewMode: Boolean;
        var HideProgressWindow: Boolean;
        var IsHandled: Boolean;
        var CalledBy: Integer)
    var
        EXCCRISalesLine: Record "Sales Line";
        EXCCRIUserSetup: Record "User Setup";
        EXCCRISetup: Record 56001;
        EXCCRIMdMFunctions: Codeunit 75000;
        EXCCRIRequiredFields: Codeunit 34003006;
    begin
        HideProgressWindow := true;

        if
            (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) and
            (SalesHeader."Tipo pedido" <> SalesHeader."Tipo pedido"::TPV)
        then
            SalesHeader.Validate("Posting Date", WorkDate());

        EXCCRIMdMFunctions.ContrlFechasDocV(SalesHeader);

        if SalesHeader."Document Type" in
           [
               SalesHeader."Document Type"::Order,
               SalesHeader."Document Type"::Invoice,
               SalesHeader."Document Type"::"Credit Memo"
           ]
        then
            EXCCRIRequiredFields.Documento(
                Database::"Sales Header",
                SalesHeader."Document Type",
                SalesHeader."No.");

        if
            (SalesHeader."Document Type" in
             [
                 SalesHeader."Document Type"::Order,
                 SalesHeader."Document Type"::Invoice
             ]) and
            (SalesHeader."Tipo de Venta" in
             [
                 SalesHeader."Tipo de Venta"::"Canal 3",
                 SalesHeader."Tipo de Venta"::Factura
             ])
        then begin
            EXCCRISalesLine.SetRange(
                "Document Type",
                SalesHeader."Document Type");
            EXCCRISalesLine.SetRange(
                "Document No.",
                SalesHeader."No.");
            EXCCRISalesLine.SetRange("Unit Price", 0);

            if not EXCCRISalesLine.IsEmpty() then
                Error(
                    EXCCRIZeroPriceErr,
                    SalesHeader."Document Type",
                    SalesHeader."Tipo de Venta");
        end;

        EXCCRISetup.Get();

        if
            EXCCRISetup."Funcionalidad NCF Activa" and
            (SalesHeader."Document Type" in
             [
                 SalesHeader."Document Type"::"Credit Memo",
                 SalesHeader."Document Type"::"Return Order"
             ])
        then
            SalesHeader.TestField("No. Comprobante Fiscal Rel.");

        if
            (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) and
            (SalesHeader."Tipo pedido" = SalesHeader."Tipo pedido"::TPV)
        then begin
            SalesHeader.Ship := true;
            SalesHeader.Invoice := true;
        end;

        if not SalesHeader.Invoice then
            if EXCCRISetup."Funcionalidad Imp. Fiscal Act." then begin
                SalesHeader.TestField("VAT Registration No.");
                SalesHeader.TestField("Sell-to Customer Name");

                if not EXCCRIUserSetup.Get(UserId()) then
                    Error(EXCCRIFiscalPrinterSetupErr, UserId());

                EXCCRIUserSetup.TestField("Puerto Imp. Fiscal");
                EXCCRIUserSetup.TestField("Velocidad Imp. Fiscal");
            end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterCheckSalesDoc', '', false, false)]
    local procedure OnAfterCheckSalesDoc(
        var SalesHeader: Record "Sales Header";
        CommitIsSuppressed: Boolean;
        WhseShip: Boolean;
        WhseReceive: Boolean;
        PreviewMode: Boolean;
        var ErrorMessageMgt: Codeunit "Error Message Management")
    var
        EXCCRICustomerPostingGroup: Record "Customer Posting Group";
        EXCCRISalesLine: Record "Sales Line";
        EXCCRISetup: Record 56001;
        EXCCRIDocumentLineControl: Record 56002;
        EXCCRICountryParameters: Record 34003011;
        EXCCRIItemLineCount: Integer;
    begin
        EXCCRISetup.Get();
        EXCCRISetup.TestField(Country);
        EXCCRICountryParameters.Get(EXCCRISetup.Country);

        if EXCCRICountryParameters."Control Lin. por Factura" then begin
            EXCCRICountryParameters.TestField("Cantidad Lin. por factura");

            EXCCRISalesLine.SetRange(
                "Document Type",
                SalesHeader."Document Type");
            EXCCRISalesLine.SetRange(
                "Document No.",
                SalesHeader."No.");
            EXCCRISalesLine.SetRange(Type, EXCCRISalesLine.Type::Item);
            EXCCRIItemLineCount := EXCCRISalesLine.Count();

            if
                (EXCCRIItemLineCount >
                 EXCCRICountryParameters."Cantidad Lin. por factura") and
                (EXCCRICountryParameters."Cantidad Lin. por factura" <> 0)
            then
                Error(
                    EXCCRILineLimitErr,
                    SalesHeader."No.",
                    SalesHeader.FieldCaption("Document Type"),
                    SalesHeader."Document Type");

            SalesHeader.TestField("Collector Code");

            if EXCCRICountryParameters."Formato Doc. Vtas. por cliente" then begin
                EXCCRICustomerPostingGroup.Get(
                    SalesHeader."Customer Posting Group");

                EXCCRIDocumentLineControl.SetRange(
                    Country,
                    EXCCRISetup.Country);

                if SalesHeader."Document Type" in
                   [
                       SalesHeader."Document Type"::Order,
                       SalesHeader."Document Type"::Invoice
                   ]
                then
                    EXCCRIDocumentLineControl.SetRange(
                        "Sales Report ID",
                        EXCCRICustomerPostingGroup."Invoice Report ID")
                else
                    EXCCRIDocumentLineControl.SetRange(
                        "Sales Report ID",
                        EXCCRICustomerPostingGroup."Credit Memo Report ID");

                if EXCCRIDocumentLineControl.FindFirst() then
                    if
                        (EXCCRIItemLineCount >
                         EXCCRIDocumentLineControl."Maximun line number") and
                        (EXCCRIDocumentLineControl."Maximun line number" <> 0)
                    then
                        Error(
                            EXCCRILineLimitErr,
                            SalesHeader."No.",
                            SalesHeader.FieldCaption("Document Type"),
                            SalesHeader."Document Type");
            end;
        end;

        if SalesHeader.Invoice then
            SalesHeader.TestField("Payment Method Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostSalesLineOnAfterSetEverythingInvoiced', '', false, false)]
    local procedure OnPostSalesLineOnAfterSetEverythingInvoiced(
        SalesLine: Record "Sales Line";
        var EverythingInvoiced: Boolean;
        var IsHandled: Boolean;
        SalesHeader: Record "Sales Header")
    begin
        if SalesLine."Cantidad pendiente BO" <> 0 then
            EverythingInvoiced := false;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesInvHeaderInsert', '', false, false)]
    local procedure OnBeforeSalesInvHeaderInsert(
        var SalesInvHeader: Record "Sales Invoice Header";
        var SalesHeader: Record "Sales Header";
        CommitIsSuppressed: Boolean;
        var IsHandled: Boolean;
        WhseShip: Boolean;
        WhseShptHeader: Record "Warehouse Shipment Header";
        InvtPickPutaway: Boolean)
    begin
        SalesHeader.CalcFields("Importe ITBIS Incl.");

        SalesInvHeader."Tipo pedido" := SalesHeader."Tipo pedido";
        SalesInvHeader."Importe ITBIS Incl." :=
            SalesHeader."Importe ITBIS Incl.";
        SalesInvHeader."Importe a liquidar" :=
            SalesHeader."Importe a liquidar";

        if SalesHeader."Tipo pedido" = SalesHeader."Tipo pedido"::TPV then begin
            SalesInvHeader."Tipo Documento Replicador" :=
                SalesInvHeader."Tipo Documento Replicador"::Order;
            SalesInvHeader."No. Serie Envio Replicador" :=
                SalesHeader."Shipping No. Series";
        end;

        SalesInvHeader."Fecha entrega requerida" :=
            SalesHeader."Requested Delivery Date";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesInvLineInsert', '', false, false)]
    local procedure OnBeforeSalesInvLineInsert(
        var SalesInvLine: Record "Sales Invoice Line";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesLine: Record "Sales Line";
        CommitIsSuppressed: Boolean;
        var IsHandled: Boolean;
        PostingSalesLine: Record "Sales Line";
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesHeader: Record "Sales Header";
        var ReturnReceiptHeader: Record "Return Receipt Header")
    begin
        SalesInvLine."Tipo Documento Replicador" :=
            SalesInvLine."Tipo Documento Replicador"::Order;
        SalesInvLine."No. Pedido Replicador" :=
            SalesInvHeader."Order No.";
        SalesInvLine."Cantidad 1 Replicador" :=
            PostingSalesLine."Qty. to Invoice";
        SalesInvLine."Cantidad 2 Replicador" :=
            PostingSalesLine."Qty. to Invoice";
        SalesInvLine."Cantidad 3 Replicador" :=
            PostingSalesLine."Qty. to Invoice";
        SalesInvLine."Cantidad 4 Replicador" :=
            PostingSalesLine."Qty. to Invoice";
        SalesInvLine."Requested Delivery Date" :=
            PostingSalesLine."Requested Delivery Date";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostItemJnlLineOnAfterPrepareItemJnlLine', '', false, false)]
    local procedure OnPostItemJnlLineOnAfterPrepareItemJnlLine(
        var ItemJournalLine: Record "Item Journal Line";
        SalesLine: Record "Sales Line";
        SalesHeader: Record "Sales Header";
        WhseShip: Boolean;
        var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        var QtyToBeShipped: Decimal;
        TrackingSpecification: Record "Tracking Specification";
        var QtyToBeInvoiced: Decimal;
        var QtyToBeInvoicedBase: Decimal;
        var QtyToBeShippedBase: Decimal;
        var RemAmt: Decimal;
        var RemDiscAmt: Decimal)
    var
        EXCCRIDiscountAmount: Decimal;
    begin
        if ItemJournalLine."Importe Cons. bruto Inicial" <> 0 then
            exit;

        ItemJournalLine."Precio Unitario Cons. Inicial" :=
            SalesLine."Unit Price";
        ItemJournalLine."Descuento % Cons. Inicial" :=
            SalesLine."Line Discount %";
        ItemJournalLine."Importe Cons. bruto Inicial" :=
            SalesLine."Unit Price" * SalesLine."Qty. to Ship";

        EXCCRIDiscountAmount :=
            Abs(
                ItemJournalLine."Importe Cons. bruto Inicial" *
                SalesLine."Line Discount %" / 100);

        ItemJournalLine."Importe Cons Neto Inicial" :=
            ItemJournalLine."Importe Cons. bruto Inicial" +
            EXCCRIDiscountAmount;
        ItemJournalLine."No. Mov. Prod. Cosg. a Liq." :=
            SalesLine."No. Mov. Prod. Cosg. a Liq.";
        ItemJournalLine."Pedido Consignacion" :=
            SalesHeader."Pedido Consignacion";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostCommitSalesDoc', '', false, false)]
    local procedure OnBeforePostCommitSalesDoc(
        var SalesHeader: Record "Sales Header";
        var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        PreviewMode: Boolean;
        var ModifyHeader: Boolean;
        var CommitIsSuppressed: Boolean;
        var TempSalesLineGlobal: Record "Sales Line" temporary)
    begin
        if PreviewMode or not SalesHeader.Invoice then
            exit;

        EXCCRIAssignFiscalReceipt(SalesHeader, ModifyHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterUpdateLastPostingNos', '', false, false)]
    local procedure OnAfterUpdateLastPostingNos(
        var SalesHeader: Record "Sales Header")
    begin
        if not SalesHeader.Invoice then
            exit;

        SalesHeader."No. Comprobante Fiscal" := '';
        SalesHeader."Fecha vencimiento NCF" := 0D;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostItemTrackingForShipment', '', false, false)]
    local procedure OnBeforePostItemTrackingForShipment(
        var SalesInvoiceHeader: Record "Sales Invoice Header";
        var SalesShipmentLine: Record "Sales Shipment Line";
        var TempTrackingSpecification: Record "Tracking Specification" temporary;
        var TrackingSpecificationExists: Boolean;
        SalesLine: Record "Sales Line";
        QtyToBeInvoiced: Decimal;
        QtyToBeInvoicedBase: Decimal)
    begin
        EXCCRISetTrackingHandledQuantity(
            TempTrackingSpecification,
            TrackingSpecificationExists,
            QtyToBeInvoicedBase);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostItemTrackingForShipment', '', false, false)]
    local procedure OnAfterPostItemTrackingForShipment(
        var SalesInvoiceHeader: Record "Sales Invoice Header";
        var SalesShipmentLine: Record "Sales Shipment Line";
        var TempTrackingSpecification: Record "Tracking Specification" temporary;
        var TrackingSpecificationExists: Boolean;
        SalesLine: Record "Sales Line";
        QtyToBeInvoiced: Decimal;
        QtyToBeInvoicedBase: Decimal)
    begin
        EXCCRIConsumeTrackingHandledQuantity(
            TempTrackingSpecification,
            TrackingSpecificationExists);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostItemTrackingReturnRcpt', '', false, false)]
    local procedure OnBeforePostItemTrackingReturnRcpt(
        var SalesInvoiceHeader: Record "Sales Invoice Header";
        var SalesShipmentLine: Record "Sales Shipment Line";
        var TempTrackingSpecification: Record "Tracking Specification" temporary;
        var TrackingSpecificationExists: Boolean;
        var SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        var ReturnReceiptLine: Record "Return Receipt Line";
        SalesLine: Record "Sales Line";
        QtyToBeInvoiced: Decimal;
        QtyToBeInvoicedBase: Decimal)
    begin
        EXCCRISetTrackingHandledQuantity(
            TempTrackingSpecification,
            TrackingSpecificationExists,
            QtyToBeInvoicedBase);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostItemTrackingReturnRcpt', '', false, false)]
    local procedure OnAfterPostItemTrackingReturnRcpt(
        var SalesInvoiceHeader: Record "Sales Invoice Header";
        var SalesShipmentLine: Record "Sales Shipment Line";
        var TempTrackingSpecification: Record "Tracking Specification" temporary;
        var TrackingSpecificationExists: Boolean;
        var SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        var ReturnReceiptLine: Record "Return Receipt Line";
        SalesLine: Record "Sales Line";
        QtyToBeInvoiced: Decimal;
        QtyToBeInvoicedBase: Decimal)
    begin
        EXCCRIConsumeTrackingHandledQuantity(
            TempTrackingSpecification,
            TrackingSpecificationExists);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnRunOnBeforeMakeInventoryAdjustment', '', false, false)]
    local procedure OnRunOnBeforeMakeInventoryAdjustment(
        var SalesHeader: Record "Sales Header";
        SalesInvHeader: Record "Sales Invoice Header";
        var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        PreviewMode: Boolean;
        var SkipInventoryAdjustment: Boolean)
    var
        EXCCRISetup: Record 56001;
    begin
        EXCCRISetup.Get();

        if
            EXCCRISetup."Crea Ped. Compra de Muestras" and
            SalesHeader.Invoice and
            (SalesHeader."Tipo de Venta" =
             SalesHeader."Tipo de Venta"::Muestras) and
            (SalesHeader."Document Type" in
             [
                 SalesHeader."Document Type"::Order,
                 SalesHeader."Document Type"::Invoice
             ])
        then
            CreatePurchOrder(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, false)]
    local procedure OnAfterPostSalesDoc(
        var SalesHeader: Record "Sales Header";
        var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        SalesShptHdrNo: Code[20];
        RetRcpHdrNo: Code[20];
        SalesInvHdrNo: Code[20];
        SalesCrMemoHdrNo: Code[20];
        CommitIsSuppressed: Boolean;
        InvtPickPutaway: Boolean;
        var CustLedgerEntry: Record "Cust. Ledger Entry";
        WhseShip: Boolean;
        WhseReceiv: Boolean;
        PreviewMode: Boolean)
    var
        EXCCRIMdMFunctions: Codeunit 75000;
    begin
        if PreviewMode then
            exit;

        EXCCRIMdMFunctions.ContrlFechasMdMTmp(2);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterInsertDropOrderPurchRcptHeader', '', false, false)]
    local procedure OnAfterInsertDropOrderPurchRcptHeader(
        var PurchRcptHeader: Record "Purch. Rcpt. Header")
    var
        EXCCRIMdMFunctions: Codeunit 75000;
    begin
        EXCCRIMdMFunctions.ContrlFechasAlbC(PurchRcptHeader);
    end;

    procedure CreatePurchOrder(SalesHeader: Record "Sales Header")
    var
        EXCCRIItem: Record Item;
        EXCCRIPurchaseHeader: Record "Purchase Header";
        EXCCRIPurchaseLine: Record "Purchase Line";
        EXCCRISalesLine: Record "Sales Line";
        EXCCRISetup: Record 56001;
    begin
        EXCCRISetup.Get();
        EXCCRISetup.TestField("Proveedor Muestras");

        EXCCRIPurchaseHeader.Init();
        EXCCRIPurchaseHeader."Document Type" :=
            EXCCRIPurchaseHeader."Document Type"::Order;
        EXCCRIPurchaseHeader.Insert(true);
        EXCCRIPurchaseHeader.Validate(
            "Buy-from Vendor No.",
            EXCCRISetup."Proveedor Muestras");
        EXCCRIPurchaseHeader.Validate(
            "Posting Date",
            SalesHeader."Posting Date");
        EXCCRIPurchaseHeader.Modify();

        EXCCRISalesLine.SetRange(
            "Document Type",
            SalesHeader."Document Type");
        EXCCRISalesLine.SetRange(
            "Document No.",
            SalesHeader."No.");
        EXCCRISalesLine.SetRange(Type, EXCCRISalesLine.Type::Item);
        EXCCRISalesLine.SetFilter("No.", '<>%1', '');
        EXCCRISalesLine.SetFilter("Qty. to Invoice", '<>%1', 0);
        EXCCRISalesLine.FindSet();

        repeat
            EXCCRIItem.Get(EXCCRISalesLine."No.");
            EXCCRIItem.TestField("Vendor No.");

            EXCCRIPurchaseLine.Init();
            EXCCRIPurchaseLine."Document Type" :=
                EXCCRIPurchaseLine."Document Type"::Order;
            EXCCRIPurchaseLine."Document No." :=
                EXCCRIPurchaseHeader."No.";
            EXCCRIPurchaseLine."Line No." :=
                EXCCRISalesLine."Line No.";
            EXCCRIPurchaseLine.Validate(
                "Buy-from Vendor No.",
                EXCCRIItem."Vendor No.");
            EXCCRIPurchaseLine.Type :=
                EXCCRIPurchaseLine.Type::Item;
            EXCCRIPurchaseLine.Validate(
                "No.",
                EXCCRISalesLine."No.");
            EXCCRIPurchaseLine.Validate(
                "Location Code",
                EXCCRISalesLine."Location Code");
            EXCCRIPurchaseLine.Validate(
                "Unit of Measure",
                EXCCRISalesLine."Unit of Measure");
            EXCCRIPurchaseLine.Validate(
                Quantity,
                EXCCRISalesLine.Quantity);
            EXCCRIPurchaseLine.Validate(
                "Direct Unit Cost",
                EXCCRISalesLine."Unit Cost (LCY)");
            EXCCRIPurchaseLine.Insert(true);
            EXCCRIPurchaseLine.Validate(
                "Shortcut Dimension 1 Code",
                EXCCRISalesLine."Shortcut Dimension 1 Code");
            EXCCRIPurchaseLine.Validate(
                "Shortcut Dimension 2 Code",
                EXCCRISalesLine."Shortcut Dimension 2 Code");
            EXCCRIPurchaseLine.Modify();
        until EXCCRISalesLine.Next() = 0;
    end;

    procedure RegistrarCobrosSCR2(DocNum: Code[20])
    var
        EXCCRIBankStore: Record 34002504;
        EXCCRIGenJnlLine: Record "Gen. Journal Line";
        EXCCRIPaymentLines: Record 50113;
        EXCCRIPaymentLinesWithoutSIC: Record 50113;
        EXCCRIPaymentSetup: Record 50110;
        EXCCRISalesInvoiceHeader: Record "Sales Invoice Header";
        EXCCRISalesInvoiceHeaderCheck: Record "Sales Invoice Header";
        EXCCRISalesInvoiceLine: Record "Sales Invoice Line";
        EXCCRIGenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        EXCCRIDocumentUsesSIC: Boolean;
        EXCCRILineNo: Integer;
    begin
        EXCCRISalesInvoiceHeader.SetRange("No.", DocNum);
        if not EXCCRISalesInvoiceHeader.FindFirst() then
            exit;

        EXCCRIDocumentUsesSIC := true;

        EXCCRIPaymentLinesWithoutSIC.SetRange("Tipo documento", 1, 2);
        EXCCRIPaymentLinesWithoutSIC.SetFilter(
            "No. documento",
            '%1|%2',
            EXCCRISalesInvoiceHeader."Order No.",
            EXCCRISalesInvoiceHeader."Pre-Assigned No.");
        EXCCRIPaymentLinesWithoutSIC.SetRange("No. documento SIC", '');
        EXCCRIPaymentLinesWithoutSIC.SetFilter(
            "Cod. medio de pago",
            '<>%1&<>%2',
            '',
            '99');

        if EXCCRIPaymentLinesWithoutSIC.FindFirst() then
            EXCCRIDocumentUsesSIC := false;

        EXCCRIPaymentLines.SetRange("Tipo documento", 1, 2);
        EXCCRIPaymentLines.SetFilter(
            "No. documento",
            '%1|%2',
            EXCCRISalesInvoiceHeader."Order No.",
            EXCCRISalesInvoiceHeader."Pre-Assigned No.");

        if EXCCRIDocumentUsesSIC then
            EXCCRIPaymentLines.SetRange(
                "No. documento SIC",
                EXCCRISalesInvoiceHeader."No. Documento SIC");

        EXCCRIPaymentLines.SetFilter(
            "Cod. medio de pago",
            '<>%1&<>%2',
            '',
            '99');

        if not EXCCRISalesInvoiceHeader."Venta TPV" then
            exit;

        if not EXCCRIPaymentLines.FindSet() then
            exit;

        repeat
            EXCCRILineNo += 1000;

            EXCCRIPaymentSetup.Get(
                EXCCRIPaymentLines."Cod. medio de pago");

            if EXCCRIPaymentSetup.Credito then
                exit;

            EXCCRISalesInvoiceHeaderCheck.SetRange(
                "No.",
                EXCCRISalesInvoiceHeader."No.");

            if EXCCRISalesInvoiceHeaderCheck.FindFirst() then begin
                EXCCRISalesInvoiceHeaderCheck.CalcFields(
                    "Remaining Amount");

                if
                    EXCCRISalesInvoiceHeaderCheck."Remaining Amount" = 0
                then
                    exit;
            end;

            EXCCRISalesInvoiceLine.SetRange(
                "Document No.",
                EXCCRISalesInvoiceHeader."No.");
            EXCCRISalesInvoiceLine.CalcSums(
                "Amount Including VAT");

            if
                EXCCRIPaymentLines.Importe <>
                EXCCRISalesInvoiceLine."Amount Including VAT"
            then
                exit;

            EXCCRIBankStore.SetRange(
                "Cod. Tienda",
                EXCCRISalesInvoiceHeader.Tienda);
            EXCCRIBankStore.FindFirst();
            EXCCRIBankStore.TestField("Cod. Banco");

            EXCCRIGenJnlLine.Init();
            EXCCRIGenJnlLine."Line No." := EXCCRILineNo;
            EXCCRIGenJnlLine.Validate(
                "Document Type",
                EXCCRIGenJnlLine."Document Type"::Payment);
            EXCCRIGenJnlLine."Document No." :=
                EXCCRISalesInvoiceHeader."No.";
            EXCCRIGenJnlLine."Posting Date" := WorkDate();
            EXCCRIGenJnlLine.Validate(
                "Account Type",
                EXCCRIGenJnlLine."Account Type"::Customer);
            EXCCRIGenJnlLine.Validate(
                "Account No.",
                EXCCRISalesInvoiceHeader."Sell-to Customer No.");
            EXCCRIGenJnlLine.Validate(
                "Bal. Account Type",
                EXCCRIGenJnlLine."Bal. Account Type"::"Bank Account");
            EXCCRIGenJnlLine.Validate(
                "Bal. Account No.",
                EXCCRIBankStore."Cod. Banco");
            EXCCRIGenJnlLine.Description :=
                CopyStr(
                    StrSubstNo(
                        EXCCRIPaymentDescriptionLbl,
                        EXCCRISalesInvoiceHeader."No." + ', ' +
                        EXCCRIPaymentSetup."Cod. Forma Pago"),
                    1,
                    MaxStrLen(EXCCRIGenJnlLine.Description));
            EXCCRIGenJnlLine.Validate(
                "Credit Amount",
                EXCCRIPaymentLines.Importe);
            EXCCRIGenJnlLine.Validate(
                "Applies-to Doc. Type",
                EXCCRIGenJnlLine."Applies-to Doc. Type"::Invoice);
            EXCCRIGenJnlLine.Validate(
                "Applies-to Doc. No.",
                EXCCRISalesInvoiceHeader."No.");
            EXCCRIGenJnlLine."Salespers./Purch. Code" :=
                EXCCRISalesInvoiceHeader."Salesperson Code";
            EXCCRIGenJnlLine.Validate(
                "Shortcut Dimension 1 Code",
                EXCCRISalesInvoiceHeader."Shortcut Dimension 1 Code");
            EXCCRIGenJnlLine.Validate(
                "Shortcut Dimension 2 Code",
                EXCCRISalesInvoiceHeader."Shortcut Dimension 2 Code");

            EXCCRIGenJnlPostLine.RunWithCheck(EXCCRIGenJnlLine);

            EXCCRISalesInvoiceHeader."Liquidado TPV" := true;
            EXCCRISalesInvoiceHeader.Modify();
        until EXCCRIPaymentLines.Next() = 0;
    end;

    local procedure EXCCRIAssignFiscalReceipt(
        var SalesHeader: Record "Sales Header";
        var ModifyHeader: Boolean)
    var
        EXCCRICustomerPostingGroup: Record "Customer Posting Group";
        EXCCRINoSeriesLine: Record "No. Series Line";
        EXCCRISetup: Record 56001;
        EXCCRILocalization: Codeunit 34003002;
        EXCCRINoSeries: Codeunit "No. Series";
    begin
        EXCCRISetup.Get();

        if not EXCCRISetup."Funcionalidad NCF Activa" then
            exit;

        EXCCRICustomerPostingGroup.Get(
            SalesHeader."Customer Posting Group");

        if
            not EXCCRICustomerPostingGroup."Permite emitir NCF" or
            SalesHeader.Correction
        then
            exit;

        if SalesHeader."Document Type" in
           [
               SalesHeader."Document Type"::Order,
               SalesHeader."Document Type"::Invoice
           ]
        then
            SalesHeader.TestField("No. Serie NCF Facturas")
        else
            if SalesHeader."Document Type" in
               [
                   SalesHeader."Document Type"::"Credit Memo",
                   SalesHeader."Document Type"::"Return Order"
               ]
            then
                SalesHeader.TestField("No. Serie NCF Abonos");

        if SalesHeader."Tipo de ingreso" = '' then
            SalesHeader."Tipo de ingreso" := '01';

        EXCCRINoSeriesLine.Reset();

        if SalesHeader."Document Type" in
           [
               SalesHeader."Document Type"::Order,
               SalesHeader."Document Type"::Invoice
           ]
        then
            EXCCRINoSeriesLine.SetRange(
                "Series Code",
                SalesHeader."No. Serie NCF Facturas")
        else
            if
                SalesHeader."Document Type" =
                SalesHeader."Document Type"::"Credit Memo"
            then
                EXCCRINoSeriesLine.SetRange(
                    "Series Code",
                    SalesHeader."No. Serie NCF Facturas");

        EXCCRINoSeriesLine.SetFilter(
            "Expiration date",
            '>=%1',
            SalesHeader."Posting Date");
        EXCCRINoSeriesLine.SetFilter(
            "Starting Date",
            '>=%1',
            DMY2Date(1, 5, 2018));
        EXCCRINoSeriesLine.SetRange(Open, true);
        EXCCRINoSeriesLine.FindFirst();

        if
            (SalesHeader."Posting Date" >
             EXCCRINoSeriesLine."Expiration date") and
            (EXCCRINoSeriesLine."Expiration date" <> 0D)
        then
            Error(
                EXCCRINCFExpirationErr,
                SalesHeader.FieldCaption("Posting Date"),
                EXCCRINoSeriesLine.FieldCaption("Expiration date"),
                SalesHeader."Posting Date",
                EXCCRINoSeriesLine."Expiration date");

        if SalesHeader."No. Comprobante Fiscal" = '' then
            SalesHeader."Fecha vencimiento NCF" :=
                EXCCRINoSeriesLine."Expiration date";

        if
            (SalesHeader."Document Type" in
             [
                 SalesHeader."Document Type"::Order,
                 SalesHeader."Document Type"::Invoice
             ]) and
            (SalesHeader."No. Comprobante Fiscal" = '')
        then
            SalesHeader."No. Comprobante Fiscal" :=
                EXCCRINoSeries.GetNextNo(
                    SalesHeader."No. Serie NCF Facturas",
                    SalesHeader."Posting Date")
        else
            if SalesHeader."No. Comprobante Fiscal" = '' then
                SalesHeader."No. Comprobante Fiscal" :=
                    EXCCRINoSeries.GetNextNo(
                        SalesHeader."No. Serie NCF Abonos",
                        SalesHeader."Posting Date");

        if
            (CopyStr(SalesHeader."No. Comprobante Fiscal", 2, 2) <> '02') and
            (CopyStr(SalesHeader."No. Comprobante Fiscal", 2, 2) <> '04')
        then
            SalesHeader.TestField("Fecha vencimiento NCF");

        if SalesHeader."No. Comprobante Fiscal" = '' then
            Error(
                EXCCRINCFGenerationErr,
                SalesHeader.FieldCaption("No. Comprobante Fiscal"));

        EXCCRILocalization.ValidaExiste(
            SalesHeader,
            SalesHeader."No. Comprobante Fiscal");

        SalesHeader.CalcFields("Amount Including VAT");

        if not
           ((CopyStr(
                SalesHeader."No. Comprobante Fiscal",
                1,
                3) = 'B02') and
            (SalesHeader."Amount Including VAT" <= 250000))
        then
            SalesHeader.TestField("VAT Registration No.");

        ModifyHeader := true;
    end;

    local procedure EXCCRISetTrackingHandledQuantity(
        var TempTrackingSpecification: Record "Tracking Specification" temporary;
        TrackingSpecificationExists: Boolean;
        QtyToBeInvoicedBase: Decimal)
    begin
        if not TrackingSpecificationExists then
            exit;

        TempTrackingSpecification."Quantity actual Handled (Base)" :=
            QtyToBeInvoicedBase;
        TempTrackingSpecification.Modify();
    end;

    local procedure EXCCRIConsumeTrackingHandledQuantity(
        var TempTrackingSpecification: Record "Tracking Specification" temporary;
        TrackingSpecificationExists: Boolean)
    begin
        if not TrackingSpecificationExists then
            exit;

        TempTrackingSpecification."Quantity Invoiced (Base)" +=
            TempTrackingSpecification."Quantity actual Handled (Base)";
        TempTrackingSpecification."Quantity actual Handled (Base)" := 0;
        TempTrackingSpecification.Modify();
    end;

    var
        EXCCRILineLimitErr: Label
            'Document %1 exceeds the line limit allowed for %2 %3.';
        EXCCRIZeroPriceErr: Label
            'Document type %1 does not allow lines with zero unit price for sales type %2.';
        EXCCRIFiscalPrinterSetupErr: Label
            'Fiscal printer port and speed must be configured for user %1.';
        EXCCRINCFExpirationErr: Label
            '%1 cannot be later than %2 of the NCF number series. The corresponding values are %3 and %4.';
        EXCCRINCFGenerationErr: Label
            'The %1 could not be generated. Run the posting process again.';
        EXCCRIPaymentDescriptionLbl: Label
            'Liq. pago Doc. %1';
}
