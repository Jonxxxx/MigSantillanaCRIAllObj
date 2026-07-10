tableextension 70000048 tableextension70000048 extends "Purchase Header"
{
    fields
    {
        modify("Buy-from Vendor No.")
        {
            TableRelation = Vendor;
        }
        modify("Pay-to Vendor No.")
        {
            TableRelation = Vendor;
        }

        //Unsupported feature: Property Modification (Data type) on ""Pay-to Name 2"(Field 6)".

        modify("Pay-to Address")
        {
            Caption = 'Address';
        }
        modify("Pay-to Address 2")
        {

            //Unsupported feature: Property Modification (Data type) on ""Pay-to Address 2"(Field 8)".

            Caption = 'Address 2';
        }

        //Unsupported feature: Property Modification (Data type) on ""Pay-to City"(Field 9)".


        //Unsupported feature: Property Modification (Data type) on ""Ship-to Name 2"(Field 14)".

        modify("Ship-to Address")
        {
            Caption = 'Ship-to Address';
        }

        //Unsupported feature: Property Modification (Data type) on ""Ship-to Address 2"(Field 16)".


        //Unsupported feature: Property Modification (Data type) on ""Ship-to City"(Field 17)".

        modify("Location Code")
        {
            TableRelation = Location WHERE(Use As In-Transit=CONST(false));
        }
        modify("Shortcut Dimension 1 Code")
        {
            Caption = 'Shortcut Dimension 1 Code';
        }
        modify("Shortcut Dimension 2 Code")
        {
            Caption = 'Shortcut Dimension 2 Code';
        }
        modify("Vendor Cr. Memo No.")
        {
            Caption = 'Vendor Cr. Memo No.';
        }

        //Unsupported feature: Property Modification (Data type) on ""VAT Registration No."(Field 70)".

        modify("Sell-to Customer No.")
        {
            TableRelation = Customer;
        }
        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Gen. Bus. Posting Group';
        }

        //Unsupported feature: Property Modification (Data type) on ""Buy-from Vendor Name 2"(Field 80)".


        //Unsupported feature: Property Modification (Data type) on ""Buy-from Address 2"(Field 82)".


        //Unsupported feature: Property Modification (Data type) on ""Buy-from City"(Field 83)".

        modify("Area")
        {
            Caption = 'Area';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'VAT Bus. Posting Group';
        }
        modify("Prepmt. Pmt. Discount Date")
        {
            Caption = 'Prepmt. Pmt. Discount Date';
        }
        modify("Location Filter")
        {
            TableRelation = Location;
        }
        modify("Fiscal Invoice Number PAC")
        {
            Caption = 'Fiscal Invoice Number PAC';
        }

        //Unsupported feature: Code Modification on ""Buy-from Vendor No."(Field 2).OnValidate".

        //trigger "(Field 2)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*

        //ValidaCampos.Maestros(23,"Buy-from Vendor No.");//+#4196
        //ValidaCampos.Dimensiones(23,"Buy-from Vendor No.",0,0);//+#4196


        IF "No." = '' THEN
          InitRecord;
        TestStatusOpen;
        #9..35
          Vend.TESTFIELD("Gen. Bus. Posting Group");
        OnAfterCheckBuyFromVendor(Rec,xRec,Vend);



        "Buy-from Vendor Name" := Vend.Name;
        "Buy-from Vendor Name 2" := Vend."Name 2;
        CopyBuyFromVendorAddressFieldsFromVendor(Vend,FALSE);
        #44..53
        ValidateEmptySellToCustomerAndLocation;
        OnAfterCopyBuyFromVendorFieldsFromVendor(Rec,Vend,xRec);

        //DSLoc1.01 To Default Vendor's Name in the Posting Description
        "Posting Description" := Vend.Name;
        "Cod. Clasificacion Gasto" := Vend."Cod. Clasificacion Gasto";

        IF "Buy-from Vendor No." = xRec."Pay-to Vendor No." THEN
          IF ReceivedPurchLinesExist OR ReturnShipmentExist THEN BEGIN
            TESTFIELD("VAT Bus. Posting Group",xRec."VAT Bus. Posting Group");
        #64..104

        IF (xRec."Buy-from Vendor No." <> '') AND (xRec."Buy-from Vendor No." <> "Buy-from Vendor No.") THEN
          RecallModifyAddressNotification(GetModifyVendorAddressNotificationId);

        IF "No." <> '' THEN //validar que el pedido ya tenga NO.
        InsertaRetenciones;//DSLoc1.02
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #6..38
        #41..56
        #61..107
        */
        //end;

        //Unsupported feature: Property Deletion (Description) on ""Buy-from Vendor No."(Field 2)".



        //Unsupported feature: Code Modification on ""Pay-to Vendor No."(Field 4).OnValidate".

        //trigger "(Field 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*

        //ValidaCampos.Maestros(23,"Buy-from Vendor No.");//+#4196
        //ValidaCampos.Dimensiones(23,"Buy-from Vendor No.",0,0);//+#4196

        TestStatusOpen;
        IF (xRec."Pay-to Vendor No." <> "Pay-to Vendor No.") AND
           (xRec."Pay-to Vendor No." <> '')
        THEN BEGIN
          IF GetHideValidationDialog OR NOT GUIALLOWED THEN
            Confirmed := TRUE
          ELSE
            Confirmed := CONFIRM(ConfirmChangeQst,FALSE,PayToVendorTxt);
          IF Confirmed THEN BEGIN
            PurchLine.SETRANGE("Document Type","Document Type");
            PurchLine.SETRANGE("Document No.","No.");

            CheckReceiptInfo(PurchLine,TRUE);
            CheckPrepmtInfo(PurchLine);
            CheckReturnInfo(PurchLine,TRUE);

            PurchLine.RESET;
          END ELSE
            "Pay-to Vendor No." := xRec."Pay-to Vendor No.";
        END;

        GetVend("Pay-to Vendor No.");
        Vend.CheckBlockedVendOnDocs(Vend,FALSE);
        Vend.TESTFIELD("Vendor Posting Group");
        PostingSetupMgt.CheckVendPostingGroupPayablesAccount("Vendor Posting Group");
        OnAfterCheckPayToVendor(Rec,xRec,Vend);

        "Pay-to Name" := Vend.Name;
        "Pay-to Name 2" := Vend."Name 2;
        CopyPayToVendorAddressFieldsFromVendor(Vend,FALSE);
        IF NOT SkipPayToContact THEN
          "Pay-to Contact" := Vend.Contact;
        "Payment Terms Code" := Vend."Payment Terms Code";
        "Prepmt. Payment Terms Code" := Vend."Payment Terms Code";
        "Payment Method Code" := Vend."Payment Method Code";

        IF "Buy-from Vendor No." = Vend."No." THEN
          "Shipment Method Code" := Vend."Shipment Method Code";
        "Vendor Posting Group" := Vend."Vendor Posting Group";
        GLSetup.GET;
        IF GLSetup."Bill-to/Sell-to VAT Calc." = GLSetup."Bill-to/Sell-to VAT Calc."::"Bill-to/Pay-to No." THEN BEGIN
          "VAT Bus. Posting Group" := Vend."VAT Bus. Posting Group";
          "VAT Country/Region Code" := Vend."Country/Region Code";
          "VAT Registration No." := Vend."VAT Registration No.";
          "Gen. Bus. Posting Group" := Vend."Gen. Bus. Posting Group";
        END;
        "Prices Including VAT" := Vend."Prices Including VAT";
        "Currency Code" := Vend."Currency Code";
        "Invoice Disc. Code" := Vend."Invoice Disc. Code";
        "Language Code" := Vend."Language Code";
        SetPurchaserCode(Vend."Purchaser Code","Purchaser Code");
        "IRS 1099 Code" := Vend."IRS 1099 Code";
        VALIDATE("Payment Terms Code");
        VALIDATE("Prepmt. Payment Terms Code");
        VALIDATE("Payment Method Code");
        VALIDATE("Currency Code");
        VALIDATE("Creditor No.",Vend."Creditor No.");

        OnValidatePurchaseHeaderPayToVendorNo(Vend,Rec);

        IF "Document Type" = "Document Type"::Order THEN
          VALIDATE("Prepayment %",Vend."Prepayment %");

        IF "Pay-to Vendor No." = xRec."Pay-to Vendor No." THEN BEGIN
          IF ReceivedPurchLinesExist THEN
            TESTFIELD("Currency Code",xRec."Currency Code");
        END;

        CreateDim(
          DATABASE::Vendor,"Pay-to Vendor No.",
          DATABASE::"Salesperson/Purchaser","Purchaser Code",
          DATABASE::Campaign,"Campaign No.",
          DATABASE::"Responsibility Center","Responsibility Center");

        OnValidatePaytoVendorNoBeforeRecreateLines(Rec,CurrFieldNo);

        IF (xRec."Buy-from Vendor No." = "Buy-from Vendor No.") AND
           (xRec."Pay-to Vendor No." <> "Pay-to Vendor No.")
        THEN
          RecreatePurchLines(PayToVendorTxt);

        IF NOT SkipPayToContact THEN
          UpdatePayToCont("Pay-to Vendor No.");

        "Pay-to IC Partner Code" := Vend."IC Partner Code";

        IF (xRec."Pay-to Vendor No." <> '') AND (xRec."Pay-to Vendor No." <> "Pay-to Vendor No.") THEN
          RecallModifyAddressNotification(GetModifyPayToVendorAddressNotificationId);

        //DSLoc1.01 To generate NCF to informal Vendor's
        VendorPostingGr.GET("Vendor Posting Group");
        IF ("No. Comprobante Fiscal" = '') AND (VendorPostingGr."Permite Emitir NCF") THEN
           IF "Document Type" IN ["Document Type"::Invoice,"Document Type"::Order] THEN
              BEGIN
                VendorPostingGr.TESTFIELD("No. Serie NCF Factura Compra");
                "No. Serie NCF Facturas" := VendorPostingGr."No. Serie NCF Factura Compra";
              END;

        IF ("No. Comprobante Fiscal" = '') AND (VendorPostingGr."Permite Emitir NCF") THEN
           IF "Document Type" IN ["Document Type"::"Credit Memo","Document Type"::"Return Order"] THEN
              BEGIN
                VendorPostingGr.TESTFIELD("No. Serie NCF Abonos Compra");
                "No. Serie NCF Abonos" := VendorPostingGr."No. Serie NCF Abonos Compra";
              END
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #5..92
        */
        //end;

        //Unsupported feature: Property Deletion (Description) on ""Pay-to Vendor No."(Field 4)".



        //Unsupported feature: Code Modification on ""Posting Date"(Field 20).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Posting Date");
        TestNoSeriesDate(
          "Posting No.","Posting No. Series",
        #4..18

        IF "Currency Code" <> '' THEN BEGIN
          UpdateCurrencyFactor;
          IF "Currency Factor" <> xRec."Currency Factor" THEN
            SkipJobCurrFactorUpdate := NOT ConfirmUpdateCurrencyFactor;
        END;

        #26..28

        IF PurchLinesExist THEN
          JobUpdatePurchLines(SkipJobCurrFactorUpdate);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..21
          IF ("Currency Factor" <> xRec."Currency Factor") AND NOT CalledFromWhseDoc THEN
        #23..31
        */
        //end;

        //Unsupported feature: Property Deletion (Description) on ""Location Code"(Field 28)".



        //Unsupported feature: Code Modification on ""Prices Including VAT"(Field 35).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;

        IF "Prices Including VAT" <> xRec."Prices Including VAT" THEN BEGIN
        #4..54
                    PurchLine."Line Amount" := PurchLine."Amount Including VAT" + PurchLine."Inv. Discount Amount"
                  ELSE
                    PurchLine."Line Amount" := PurchLine.Amount + PurchLine."Inv. Discount Amount";
              END;
              PurchLine.MODIFY;
            UNTIL PurchLine.NEXT = 0;
          END;
          OnAfterChangePricesIncludingVAT(Rec);
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..57
                UpdatePrepmtAmounts(PurchLine);
        #58..63
        */
        //end;

        //Unsupported feature: Property Deletion (Description) on ""Sell-to Customer No."(Field 72)".


        //Unsupported feature: Property Deletion (Description) on ""Location Filter"(Field 5754)".


        //Unsupported feature: Deletion (FieldCollection) on "Clave(Field 52500)".


        //Unsupported feature: Deletion (FieldCollection) on "Consecutivo(Field 52501)".


        //Unsupported feature: Deletion (FieldCollection) on "Estado(Field 52502)".


        //Unsupported feature: Deletion (FieldCollection) on "Mensaje(Field 52503)".


        //Unsupported feature: Deletion (FieldCollection) on ""Fecha Doc Electronico"(Field 52504)".


        //Unsupported feature: Deletion (FieldCollection) on ""E-Mail-FE"(Field 52505)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo Doc Electronico"(Field 52506)".


        //Unsupported feature: Deletion (FieldCollection) on ""QR Code FE"(Field 52507)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo Doc. Ref."(Field 52508)".


        //Unsupported feature: Deletion (FieldCollection) on ""Numero Referencia FE"(Field 52509)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo Doc. Ref NC"(Field 52510)".


        //Unsupported feature: Deletion (FieldCollection) on ""Codigo Referencia"(Field 52511)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Colegio"(Field 56006)".


        //Unsupported feature: Deletion (FieldCollection) on ""Nombre Colegio"(Field 56007)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Taller"(Field 56008)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Vendedor"(Field 67003)".


        //Unsupported feature: Deletion (FieldCollection) on "Rappel(Field 67004)".


        //Unsupported feature: Deletion (FieldCollection) on "Taller(Field 67005)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo Retencion"(Field 34003001)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Comprobante Fiscal"(Field 34003002)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Comprobante Fiscal Rel."(Field 34003003)".


        //Unsupported feature: Deletion (FieldCollection) on ""Correccion Doc. NCF"(Field 34003004)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Serie NCF Facturas"(Field 34003005)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Serie NCF Abonos"(Field 34003006)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Clasificacion Gasto"(Field 34003007)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. autorizacion de pago"(Field 34003008)".


        //Unsupported feature: Deletion (FieldCollection) on ""Fecha vencimiento NCF"(Field 34003009)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo de ingreso"(Field 34003010)".


        //Unsupported feature: Deletion (FieldCollection) on ""Total Retencion"(Field 34003013)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo ITBIS"(Field 34003014)".


        //Unsupported feature: Deletion (FieldCollection) on "Proporcionalidad(Field 34003030)".

    }


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    InitInsert;

    IF GETFILTER("Buy-from Vendor No.") <> '' THEN
    #4..8

    IF "Buy-from Vendor No." <> '' THEN
      StandardCodesMgt.CheckShowPurchRecurringLinesNotification(Rec);

    IF "Buy-from Vendor No." <> '' THEN //para insertar retencion nuevamente por si se uso nombre vendedor el cual no inserta el no de pedido
      InsertaRetenciones;//DSLoc1.02
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..11
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "InitInsert(PROCEDURE 41)".


    //Unsupported feature: Property Modification (Attributes) on "InitRecord(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "AssistEdit(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "TestNoSeries(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "GetNoSeriesCode(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "ConfirmDeletion(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "PurchLinesExist(PROCEDURE 3)".


    //Unsupported feature: Variable Insertion (Variable: TempPurchCommentLine) (VariableCollection) on "RecreatePurchLines(PROCEDURE 4)".



    //Unsupported feature: Code Modification on "RecreatePurchLines(PROCEDURE 4)".

    //procedure RecreatePurchLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT PurchLinesExist THEN
      EXIT;

    #4..53
          TempPurchLine.INSERT;
        UNTIL PurchLine.NEXT = 0;

        TransferItemChargeAssgntPurchToTemp(ItemChargeAssgntPurch,TempItemChargeAssgntPurch);

        PurchLine.DELETEALL(TRUE);
    #60..68
            PurchLine.VALIDATE(Type,TempPurchLine.Type);
            OnRecreatePurchLinesOnAfterValidateType(PurchLine,TempPurchLine);
            IF TempPurchLine."No." = '' THEN BEGIN
              PurchLine.VALIDATE(Description,TempPurchLine.Description);
              PurchLine.VALIDATE("Description 2",TempPurchLine."Description 2");
            END ELSE BEGIN
              PurchLine.VALIDATE("No.",TempPurchLine."No.");
              IF PurchLine.Type <> PurchLine.Type::" " THEN
    #77..105
              PurchLine.FINDLAST;
              ExtendedTextAdded := TRUE;
            END;
        UNTIL TempPurchLine.NEXT = 0;

        RecreateItemChargeAssgntPurch(TempItemChargeAssgntPurch,TempPurchLine,TempInteger);

        TempPurchLine.SETRANGE(Type);
        TempPurchLine.DELETEALL;
        OnAfterDeleteAllTempPurchLines;
      END;
    END ELSE
      ERROR(STRSUBSTNO(RecreatePurchaseLinesCancelErr,ChangedFieldName));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..56
        StorePurchCommentLineToTemp(TempPurchCommentLine);
        PurchCommentLine.DeleteComments("Document Type","No.");

    #57..71
              PurchLine.Description := TempPurchLine.Description;
              PurchLine."Description 2" := TempPurchLine."Description 2;
    #74..108
          RestorePurchCommentLine(TempPurchCommentLine,TempPurchLine."Line No.",PurchLine."Line No.");
        UNTIL TempPurchLine.NEXT = 0;

        RestorePurchCommentLine(TempPurchCommentLine,0,0);
    #111..118
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "MessageIfPurchLinesExist(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "PriceMessageIfPurchLinesExist(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateCurrencyFactor(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "GetHideValidationDialog(PROCEDURE 100)".


    //Unsupported feature: Property Modification (Attributes) on "SetHideValidationDialog(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePurchLines(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePurchLinesByFieldNo(PROCEDURE 99)".


    //Unsupported feature: Property Modification (Attributes) on "CreateDim(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateShipToAddress(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "CreateInvtPutAwayPick(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDocDim(PROCEDURE 32)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateAllLineDim(PROCEDURE 34)".


    //Unsupported feature: Property Modification (Attributes) on "SetAmountToApply(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "SetShipToForSpecOrder(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "SetSecurityFilterOnRespCenter(PROCEDURE 43)".


    //Unsupported feature: Property Modification (Attributes) on "CalcInvDiscForHeader(PROCEDURE 45)".


    //Unsupported feature: Property Modification (Attributes) on "AddShipToAddress(PROCEDURE 46)".


    //Unsupported feature: Property Modification (Attributes) on "DropShptOrderExists(PROCEDURE 48)".


    //Unsupported feature: Property Modification (Attributes) on "SpecialOrderExists(PROCEDURE 81)".


    //Unsupported feature: Property Modification (Attributes) on "QtyToReceiveIsZero(PROCEDURE 30)".


    //Unsupported feature: Property Modification (Attributes) on "IsApprovedForPostingBatch(PROCEDURE 51)".


    //Unsupported feature: Property Modification (Attributes) on "IsTotalValid(PROCEDURE 36)".


    //Unsupported feature: Property Modification (Attributes) on "SendToPosting(PROCEDURE 57)".


    //Unsupported feature: Property Modification (Attributes) on "CancelBackgroundPosting(PROCEDURE 33)".


    //Unsupported feature: Property Modification (Attributes) on "AddSpecialOrderToAddress(PROCEDURE 80)".


    //Unsupported feature: Property Modification (Attributes) on "InvoicedLineExists(PROCEDURE 56)".


    //Unsupported feature: Property Modification (Attributes) on "CreateDimSetForPrepmtAccDefaultDim(PROCEDURE 44)".


    //Unsupported feature: Property Modification (Attributes) on "OpenPurchaseOrderStatistics(PROCEDURE 60)".


    //Unsupported feature: Property Modification (Attributes) on "GetCardpageID(PROCEDURE 58)".


    //Unsupported feature: Property Modification (Attributes) on "OnCheckPurchasePostRestrictions(PROCEDURE 54)".


    //Unsupported feature: Property Modification (Attributes) on "OnCheckPurchaseReleaseRestrictions(PROCEDURE 55)".


    //Unsupported feature: Property Modification (Attributes) on "CheckPurchaseReleaseRestrictions(PROCEDURE 105)".


    //Unsupported feature: Property Modification (Attributes) on "SetStatus(PROCEDURE 53)".


    //Unsupported feature: Property Modification (Attributes) on "TriggerOnAfterPostPurchaseDoc(PROCEDURE 116)".


    //Unsupported feature: Property Modification (Attributes) on "DeferralHeadersExist(PROCEDURE 38)".


    //Unsupported feature: Property Modification (Attributes) on "IsCreditDocType(PROCEDURE 110)".


    //Unsupported feature: Property Modification (Attributes) on "SetBuyFromVendorFromFilter(PROCEDURE 186)".


    //Unsupported feature: Property Modification (Attributes) on "CopyBuyFromVendorFilter(PROCEDURE 59)".


    //Unsupported feature: Property Modification (Attributes) on "HasBuyFromAddress(PROCEDURE 65)".


    //Unsupported feature: Property Modification (Attributes) on "HasShipToAddress(PROCEDURE 103)".


    //Unsupported feature: Property Modification (Attributes) on "HasPayToAddress(PROCEDURE 66)".


    //Unsupported feature: Property Modification (Attributes) on "SetShipToAddress(PROCEDURE 117)".



    //Unsupported feature: Code Modification on "SetShipToAddress(PROCEDURE 117)".

    //procedure SetShipToAddress();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Ship-to Name" := ShipToName;
    "Ship-to Name 2" := ShipToName2;

    //#5935:Inicio
    //"Ship-to Address" := ShipToAddress;
    "Ship-to Address":=COPYSTR(ShipToAddress,1,MAXSTRLEN("Ship-to Address"));
    //#5935:Fin

    "Ship-to Address 2" := ShipToAddress2;
    "Ship-to City" := ShipToCity;
    "Ship-to Post Code" := ShipToPostCode;
    "Ship-to County" := ShipToCounty;
    "Ship-to Country/Region Code" := ShipToCountryRegionCode;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Ship-to Name" := ShipToName;
    "Ship-to Name 2" := ShipToName2;
    "Ship-to Address" := ShipToAddress;
    #9..13
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "ConfirmCloseUnposted(PROCEDURE 104)".


    //Unsupported feature: Property Modification (Attributes) on "InitFromPurchHeader(PROCEDURE 109)".


    //Unsupported feature: Property Modification (Attributes) on "SendRecords(PROCEDURE 75)".


    //Unsupported feature: Property Modification (Attributes) on "PrintRecords(PROCEDURE 74)".


    //Unsupported feature: Property Modification (Attributes) on "SendProfile(PROCEDURE 73)".


    //Unsupported feature: Property Modification (Attributes) on "RecalculateTaxesOnLines(PROCEDURE 1020001)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterValidateBuyFromVendorNo(PROCEDURE 77)".


    //Unsupported feature: Property Modification (Attributes) on "BatchConfirmUpdateDeferralDate(PROCEDURE 78)".


    //Unsupported feature: Property Modification (Attributes) on "SetAllowSelectNoSeries(PROCEDURE 86)".


    //Unsupported feature: Property Modification (Attributes) on "RecallModifyAddressNotification(PROCEDURE 148)".


    //Unsupported feature: Property Modification (Attributes) on "GetModifyVendorAddressNotificationId(PROCEDURE 193)".


    //Unsupported feature: Property Modification (Attributes) on "GetModifyPayToVendorAddressNotificationId(PROCEDURE 191)".


    //Unsupported feature: Property Modification (Attributes) on "GetShowExternalDocAlreadyExistNotificationId(PROCEDURE 92)".


    //Unsupported feature: Property Modification (Attributes) on "GetLineInvoiceDiscountResetNotificationId(PROCEDURE 233)".


    //Unsupported feature: Property Modification (Attributes) on "SetModifyVendorAddressNotificationDefaultState(PROCEDURE 196)".


    //Unsupported feature: Property Modification (Attributes) on "SetModifyPayToVendorAddressNotificationDefaultState(PROCEDURE 197)".


    //Unsupported feature: Property Modification (Attributes) on "SetShowExternalDocAlreadyExistNotificationDefaultState(PROCEDURE 87)".


    //Unsupported feature: Property Modification (Attributes) on "DontNotifyCurrentUserAgain(PROCEDURE 141)".


    //Unsupported feature: Property Modification (Attributes) on "FilterPartialReceived(PROCEDURE 108)".


    //Unsupported feature: Property Modification (Attributes) on "FilterPartialInvoiced(PROCEDURE 307)".


    //Unsupported feature: Property Modification (Attributes) on "ShipToAddressEqualsCompanyShipToAddress(PROCEDURE 111)".


    //Unsupported feature: Property Modification (Attributes) on "BuyFromAddressEqualsShipToAddress(PROCEDURE 94)".


    //Unsupported feature: Property Modification (Attributes) on "BuyFromAddressEqualsPayToAddress(PROCEDURE 163)".


    //Unsupported feature: Property Modification (Attributes) on "ValidatePurchaserOnPurchHeader(PROCEDURE 912)".


    //Unsupported feature: Property Modification (Attributes) on "CheckForBlockedLines(PROCEDURE 220)".


    //Unsupported feature: Property Modification (Attributes) on "TestStatusOpen(PROCEDURE 134)".


    //Unsupported feature: Property Modification (Attributes) on "SuspendStatusCheck(PROCEDURE 133)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAddShipToAddress(PROCEDURE 158)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitRecord(PROCEDURE 138)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitNoSeries(PROCEDURE 140)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterChangePricesIncludingVAT(PROCEDURE 187)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckBuyFromVendor(PROCEDURE 152)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckPayToVendor(PROCEDURE 156)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterConfirmPurchPrice(PROCEDURE 166)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyBuyFromVendorFieldsFromVendor(PROCEDURE 114)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyBuyFromVendorAddressFieldsFromVendor(PROCEDURE 130)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyPayToVendorAddressFieldsFromVendor(PROCEDURE 132)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyShipToVendorAddressFieldsFromVendor(PROCEDURE 131)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterRecreatePurchLine(PROCEDURE 93)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterDeleteAllTempPurchLines(PROCEDURE 155)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetNoSeriesCode(PROCEDURE 107)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetPostingNoSeriesCode(PROCEDURE 175)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetPrepaymentPostingNoSeriesCode(PROCEDURE 178)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetPurchSetup(PROCEDURE 177)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSetShipToForSpecOrder(PROCEDURE 129)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterTestNoSeries(PROCEDURE 136)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterTransferSavedFields(PROCEDURE 181)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateBuyFromVend(PROCEDURE 128)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateBuyFromCont(PROCEDURE 143)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdatePayToCont(PROCEDURE 144)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdatePayToVend(PROCEDURE 162)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateShipToAddress(PROCEDURE 137)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateCurrencyFactor(PROCEDURE 127)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateInboundWhseHandlingTime(PROCEDURE 202)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAppliesToDocNoOnLookup(PROCEDURE 106)".


    //Unsupported feature: Property Modification (Attributes) on "OnUpdatePurchLinesByChangedFieldName(PROCEDURE 139)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateDimTableIDs(PROCEDURE 164)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterValidateShortcutDimCode(PROCEDURE 125)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterTransferExtendedTextForPurchaseLineRecreation(PROCEDURE 165)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidatePurchaseHeaderPayToVendorNo(PROCEDURE 1215)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeConfirmUpdateCurrencyFactor(PROCEDURE 184)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInitInsert(PROCEDURE 168)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInitRecord(PROCEDURE 151)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeIsCreditDocType(PROCEDURE 146)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeIsTotalValid(PROCEDURE 174)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateCurrencyFactor(PROCEDURE 95)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeRecreatePurchLines(PROCEDURE 199)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeSetSecurityFilterOnRespCenter(PROCEDURE 147)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeTestNoSeries(PROCEDURE 149)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateAllLineDim(PROCEDURE 236)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateLocationCode(PROCEDURE 161)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdatePurchLinesByFieldNo(PROCEDURE 173)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateShipToAddress(PROCEDURE 179)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeValidateEmptySellToCustomerAndLocation(PROCEDURE 190)".


    //Unsupported feature: Property Modification (Attributes) on "OnCollectParamsInBufferForCreateDimSetOnAfterSetTempPurchLineFilters(PROCEDURE 255)".


    //Unsupported feature: Property Modification (Attributes) on "OnInsertTempPurchLineInBufferOnBeforeTempPurchLineInsert(PROCEDURE 256)".


    //Unsupported feature: Property Modification (Attributes) on "OnCreateDimOnBeforeUpdateLines(PROCEDURE 356)".


    //Unsupported feature: Property Modification (Attributes) on "OnRecreatePurchLinesOnAfterValidateType(PROCEDURE 344)".


    //Unsupported feature: Property Modification (Attributes) on "OnRecreatePurchLinesOnBeforeInsertPurchLine(PROCEDURE 112)".


    //Unsupported feature: Property Modification (Attributes) on "OnRecreatePurchLinesOnBeforeTempPurchLineInsert(PROCEDURE 118)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateBuyFromVendorNoBeforeRecreateLines(PROCEDURE 115)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeTestStatusOpen(PROCEDURE 135)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterTestStatusOpen(PROCEDURE 142)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdatePurchLines(PROCEDURE 145)".


    //Unsupported feature: Property Modification (Attributes) on "OnInitFromPurchHeader(PROCEDURE 180)".


    //Unsupported feature: Property Modification (Attributes) on "OnInitFromContactOnBeforeInitRecord(PROCEDURE 185)".


    //Unsupported feature: Property Modification (Attributes) on "OnInitFromVendorOnBeforeInitRecord(PROCEDURE 183)".


    //Unsupported feature: Property Modification (Attributes) on "OnInitInsertOnBeforeInitRecord(PROCEDURE 172)".


    //Unsupported feature: Property Modification (Attributes) on "OnRecreatePurchLinesOnBeforeConfirm(PROCEDURE 211)".


    //Unsupported feature: Property Modification (Attributes) on "OnUpdateAllLineDimOnBeforePurchLineModify(PROCEDURE 188)".


    //Unsupported feature: Property Modification (Attributes) on "OnUpdatePurchLinesByFieldNoOnBeforeValidateFields(PROCEDURE 201)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidatePaymentTermsCodeOnBeforeCalcDueDate(PROCEDURE 224)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidatePaymentTermsCodeOnBeforeCalcPmtDiscDate(PROCEDURE 225)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidatePaymentTermsCodeOnBeforeValidateDueDate(PROCEDURE 200)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidatePaymentTermsCodeOnBeforeValidateDueDateWhenBlank(PROCEDURE 189)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidatePaytoVendorNoBeforeRecreateLines(PROCEDURE 120)".


    local procedure StorePurchCommentLineToTemp(var TempPurchCommentLine Record: 43" temporary)
    var
        PurchCommentLine Record: 43;
    begin
        PurchCommentLine.SETRANGE("Document Type", "Document Type");
        PurchCommentLine.SETRANGE("No.", "No.");
        IF PurchCommentLine.FINDSET THEN
            REPEAT
                TempPurchCommentLine := PurchCommentLine;
                TempPurchCommentLine.INSERT;
            UNTIL PurchCommentLine.NEXT = 0;
    end;

    local procedure RestorePurchCommentLine(var TempPurchCommentLine Record: 43" temporary; OldDocumentLineNo: Integer; NewDocumentLineNo: Integer)
    var
        PurchCommentLine Record: 43;
    begin
        TempPurchCommentLine.SETRANGE("Document Type", "Document Type");
        TempPurchCommentLine.SETRANGE("No.", "No.");
        TempPurchCommentLine.SETRANGE("Document Line No.", OldDocumentLineNo);
        IF TempPurchCommentLine.FINDSET THEN
            REPEAT
                PurchCommentLine := TempPurchCommentLine;
                PurchCommentLine."Document Line No." := NewDocumentLineNo;
                PurchCommentLine.INSERT;
            UNTIL TempPurchCommentLine.NEXT = 0;
    end;

    procedure SetCalledFromWhseDoc(NewCalledFromWhseDoc: Boolean)
    begin
        CalledFromWhseDoc := NewCalledFromWhseDoc;
    end;

    local procedure UpdatePrepmtAmounts(var PurchaseLine Record: 39")
    var
        Currency Record: 4;
    begin
        Currency.Initialize("Currency Code");
        IF "Document Type" = "Document Type"::Order THEN BEGIN
            PurchaseLine."Prepmt. Line Amount" := ROUND(
                PurchaseLine."Line Amount" * PurchaseLine."Prepayment %" / 100, Currency."Amount Rounding Precision");
            IF ABS(PurchaseLine."Inv. Discount Amount" + PurchaseLine."Prepmt. Line Amount") > ABS(PurchaseLine."Line Amount") THEN
                PurchaseLine."Prepmt. Line Amount" := PurchaseLine."Line Amount" - PurchaseLine."Inv. Discount Amount";
        END;
    end;

    procedure ShouldSearchForVendorByName(VendorNo: Code[20]): Boolean
    begin
        EXIT(ShouldLookForVendorByName(VendorNo));
    end;


    //Unsupported feature: Property Modification (TextConstString) on "ConfirmChangeQst(Variable 1004)".

    //var
    //>>>> ORIGINAL VALUE:
    //ConfirmChangeQst : @@@="%1 = a Field Caption like Currency Code";ENU=Do you want to change %1?;ESM=¿Confirma que desea cambiar %1?;FRC=Désirez-vous modifier %1?;ENC=Do you want to change %1?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ConfirmChangeQst : @@@="%1 = a Field Caption like Currency Code";ENU=Do you want to change %1?;ESM=¿Confirma que desea cambiar %1?;FRC=Souhaitez-vous modifier la valeur du champ %1 ?;ENC=Do you want to change %1?;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text014(Variable 1014)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text014 : @@@="%1 = Document No.";ENU=Deleting this document will cause a gap in the number series for posted credit memos. An empty posted credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?;ESM=Si elimina el documento, se provocará una discontinuidad en la serie numérica de notas crédito registradas. Se creará una nota de crédito registrada en blanco %1 para completar este error en las series numéricas.\\¿Desea continuar?;FRC=La suppression de ce document va engendrer un écart dans la série de numéros des notes de crédit reportées. Une note de crédit reportée vide %1 va être créée pour éviter un écart dans la série de numéros.\\Voulez-vous continuer?;ENC=Deleting this document will cause a gap in the number series for posted credit memos. An empty posted credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text014 : @@@="%1 = Document No.";ENU=Deleting this document will cause a gap in the number series for posted credit memos. An empty posted credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?;ESM=Si elimina el documento, se provocará una discontinuidad en la serie numérica de notas de crédito registradas. Se creará una nota de crédito registrada en blanco %1 para completar este error en la serie numérica.\\¿Desea continuar?;FRC=La suppression de ce document va engendrer un écart dans la série de numéros des notes de crédit reportées. Une note de crédit reportée vide %1 va être créée pour éviter un écart dans la série de numéros.\\Voulez-vous continuer?;ENC=Deleting this document will cause a gap in the number series for posted credit memos. An empty posted credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "USText001(Variable 1400002)".

    //var
    //>>>> ORIGINAL VALUE:
    //USText001 : ENU=You have added a %1, which will result in a Tax Entry being posted to record the amount of Sales Tax you will owe your Province as a result of this purchase. Are you sure you want to do this?;ESM=Ha agregado un %1, lo que resultará en el registro de un movimiento de impuestos para registrar el importe de impuestos de ventas que le deberá a la provincia como resultado de esta compra. ¿Está seguro de que desea hacer esto?;FRC=L'ajout de %1 entraînera le report d'une écriture de taxe pour enregistrer la taxe de vente due à la province pour cet achat. Êtes-vous sûr de vouloir effectuer cette opération ?;ENC=You have added a %1, which will result in a Tax Entry being posted to record the amount of Sales Tax you will owe your Province as a result of this purchase. Are you sure you want to do this?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //USText001 : ENU=You have added a %1, which will result in a Tax Entry being posted to record the amount of Sales Tax you will owe your Province as a result of this purchase. Are you sure you want to do this?;ESM=Ha agregado un %1, lo que resultará en el registro de un movimiento de impuestos para registrar el importe de impuestos sobre las ventas que le deberá a la provincia como resultado de esta compra. ¿Está seguro de que desea hacer esto?;FRC=L'ajout de %1 entraînera le report d'une écriture de taxe pour enregistrer la taxe de vente due à la province pour cet achat. Êtes-vous sûr de vouloir effectuer cette opération ?;ENC=You have added a %1, which will result in a Tax Entry being posted to record the amount of Sales Tax you will owe your Province as a result of this purchase. Are you sure you want to do this?;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "RecreatePurchaseLinesCancelErr(Variable 1017)".

    //var
    //>>>> ORIGINAL VALUE:
    //RecreatePurchaseLinesCancelErr : @@@=%1 - Field Name, Sample:You must delete the existing purchase lines before you can change Currency Code.;ENU=You must delete the existing purchase lines before you can change %1.;ESM=Se deben eliminar las líneas de compra existentes antes de cambiar %1.;FRC=Vous devez supprimer les lignes d'achat existantes avant de pouvoir changer %1.;ENC=You must delete the existing purchase lines before you can change %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //RecreatePurchaseLinesCancelErr : @@@=%1 - Field Name, Sample:You must delete the existing purchase lines before you can change Currency Code.;ENU=You must delete the existing purchase lines before you can change %1.;ESM=Se deben eliminar las líneas de compra existentes antes de cambiar %1.;FRC=Vous devez supprimer les lignes achat existantes avant de modifier %1.;ENC=You must delete the existing purchase lines before you can change %1.;
    //Variable type has not been exported.

    var
        CalledFromWhseDoc: Boolean;
}

