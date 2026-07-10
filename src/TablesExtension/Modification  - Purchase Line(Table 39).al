tableextension 70000050 tableextension70000050 extends "Purchase Line"
{
    fields
    {
        modify("Buy-from Vendor No.")
        {
            TableRelation = Vendor;
        }
        modify("No.")
        {
            TableRelation = IF (Type = CONST(" ")) "Standard Text"
            ELSE IF (Type = CONST(G/L Account),
                                     System-Created Entry=CONST(false)) "G/L Account" WHERE (Direct Posting=CONST(true),
                                                                                          Account Type=CONST(Posting),
                                                                                          Blocked=CONST(false))
                                                                                          ELSE IF (Type=CONST(G/L Account),
                                                                                                   System-Created Entry=CONST(true)) "G/L Account"
                                                                                                   ELSE IF (Type=CONST(Fixed Asset)) "Fixed Asset"
                                                                                                   ELSE IF (Type=CONST("Charge (Item)")) "Item Charge"
                                                                                                   ELSE IF (Type=CONST(Item),
                                                                                                            Document Type=FILTER(<>Credit Memo&<>Return Order)) Item WHERE (Blocked=CONST(false),
                                                                                                                                                                            Purchasing Blocked=CONST(false))
                                                                                                                                                                            ELSE IF (Type=CONST(Item),
                                                                                                                                                                                     Document Type=FILTER(Credit Memo|Return Order)) Item WHERE (Blocked=CONST(false));
        }
        modify("Location Code")
        {
            TableRelation = Location WHERE (Use As In-Transit=CONST(false));
        }
        modify(Description)
        {
            TableRelation = IF (Type=CONST(G/L Account),
                                System-Created Entry=CONST(false),
                                No.=CONST('')) "G/L Account".Name WHERE (Direct Posting=CONST(true),
                                                                         Account Type=CONST(Posting),
                                                                         Blocked=CONST(false))
                                                                         ELSE IF (Type=CONST(G/L Account),
                                                                                  System-Created Entry=CONST(true),
                                                                                  No.=CONST('')) "G/L Account".Name
                                                                                  ELSE IF (Type=CONST(Item),
                                                                                           Document Type=FILTER(<>Credit Memo&<>Return Order),
                                                                                           No.=CONST('')) Item.Description WHERE (Blocked=CONST(false),
                                                                                                                                  Purchasing Blocked=CONST(false))
                                                                                                                                  ELSE IF (Type=CONST(Item),
                                                                                                                                           Document Type=FILTER(Credit Memo|Return Order),
                                                                                                                                           No.=CONST('')) Item.Description WHERE (Blocked=CONST(false))
                                                                                                                                           ELSE IF (Type=CONST(Fixed Asset),
                                                                                                                                                    No.=CONST('')) "Fixed Asset".Description
                                                                                                                                                    ELSE IF (Type=CONST("Charge (Item)"),
                                                                                                                                                             No.=CONST('')) "Item Charge".Description;
        }

        //Unsupported feature: Property Modification (Data type) on ""Description 2"(Field 12)".

        modify("Shortcut Dimension 1 Code")
        {
            Caption = 'Shortcut Dimension 1 Code';
        }
        modify("Shortcut Dimension 2 Code")
        {
            Caption = 'Shortcut Dimension 2 Code';
        }
        modify("Qty. Rcd. Not Invoiced")
        {
            Caption = 'Qty. Rcd. Not Invoiced';
        }
        modify("Pay-to Vendor No.")
        {
            TableRelation = Vendor;
        }
        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Gen. Bus. Posting Group';
        }
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        modify("Attached to Line No.")
        {
            Caption = 'Attached to Line No.';
        }
        modify("Area")
        {
            Caption = 'Area';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'VAT Bus. Posting Group';
        }
        modify("VAT Prod. Posting Group")
        {
            Caption = 'VAT Prod. Posting Group';
        }
        modify("IC Partner Ref. Type")
        {
            Caption = 'IC Partner Ref. Type';
        }
        modify("Job Line Discount Amount")
        {
            Caption = 'Job Line Discount Amount';
        }
        modify("Job Unit Price (LCY)")
        {
            Caption = 'Job Unit Price ($)';
        }
        modify("Job Total Price (LCY)")
        {
            Caption = 'Job Total Price ($)';
        }
        modify("Job Line Amount (LCY)")
        {
            Caption = 'Job Line Amount ($)';
        }
        modify("Job Line Disc. Amount (LCY)")
        {
            Caption = 'Job Line Disc. Amount ($)';
        }
        modify("Job Planning Line No.")
        {
            Caption = 'Job Planning Line No.';
        }
        modify("Unit of Measure Code")
        {
            Caption = 'Unit of Measure Code';
        }
        modify("Depr. until FA Posting Date")
        {
            Caption = 'Depr. until FA Posting Date';
        }
        modify("Duplicate in Depreciation Book")
        {
            Caption = 'Duplicate in Depreciation Book';
        }
        modify("Whse. Outstanding Qty. (Base)")
        {
            Caption = 'Whse. Outstanding Qty. (Base)';
        }
        modify("Return Shipment Line No.")
        {
            Caption = 'Return Shipment Line No.';
        }

        //Unsupported feature: Property Deletion (Description) on ""Buy-from Vendor No."(Field 2)".


        //Unsupported feature: Property Deletion (Description) on ""No."(Field 6)".


        //Unsupported feature: Code Modification on ""Location Code"(Field 7).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TestStatusOpen;

            IF "Location Code" <> '' THEN
            #4..42
            END;
            "Bin Code" := '';

            IF Type = Type::Item THEN
              UpdateDirectUnitCost(FIELDNO("Location Code"));

            PurchSetup.GET;
            IF PurchSetup."Use Vendor's Tax Area Code" THEN BEGIN
            #51..102

            IF "Document Type" = "Document Type"::"Return Order" THEN
              ValidateReturnReasonCode(FIELDNO("Location Code"));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..45
            IF Type = Type::Item THEN BEGIN
              GetPurchHeader;
              PurchPriceCalcMgt.FindPurchLinePrice(PurchHeader,Rec,FIELDNO("Location Code"));
              VALIDATE("Direct Unit Cost");
            END;
            #48..105
            */
        //end;

        //Unsupported feature: Property Deletion (Description) on ""Location Code"(Field 7)".



        //Unsupported feature: Code Modification on ""Unit Cost (LCY)"(Field 23).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TestStatusOpen;
            TESTFIELD("No.");
            TESTFIELD(Quantity);
            #4..37
                ROUND(
                  (UnitCostCurrency - "Direct Unit Cost" + "Line Discount Amount" / Quantity) /
                  ("Direct Unit Cost" - "Line Discount Amount" / Quantity) * 100,0.00001);
              IF IndirectCostPercent >= 0 THEN
                "Indirect Cost %" := IndirectCostPercent;
            END;

            UpdateSalesCost;
            #46..48
              TempJobJnlLine.VALIDATE("Unit Cost (LCY)","Unit Cost (LCY)");
              UpdateJobPrices;
            END
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..40
              IF IndirectCostPercent >= 0 THEN BEGIN
                "Indirect Cost %" := IndirectCostPercent;
                CheckLineTypeOnIndirectCostPercentUpdate;
              END;
            #43..51
            */
        //end;


        //Unsupported feature: Code Modification on ""Indirect Cost %"(Field 54).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD("No.");
            TestStatusOpen;

            IF Type = Type::"Charge (Item)" THEN
              TESTFIELD("Indirect Cost %",0);

            IF (Type = Type::Item) AND ("Prod. Order No." = '') THEN BEGIN
              GetItem(Item);
            #9..13
            END;

            UpdateUnitCost;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
            CheckLineTypeOnIndirectCostPercentUpdate;
            #6..16
            */
        //end;

        //Unsupported feature: Property Deletion (Description) on ""Pay-to Vendor No."(Field 68)".



        //Unsupported feature: Code Modification on ""Drop Shipment"(Field 73).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF (xRec."Drop Shipment" <> "Drop Shipment") AND (Quantity <> 0) THEN BEGIN
              ReservePurchLine.VerifyChange(Rec,xRec);
              WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
            END;
            IF "Drop Shipment" THEN BEGIN
              "Bin Code" := '';
              EVALUATE("Inbound Whse. Handling Time",'<0D>');
              VALIDATE("Inbound Whse. Handling Time");
              InitOutstanding;
              InitQtyToReceive;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..8
              EVALUATE("Safety Lead Time",'<0D>');
              VALIDATE("Safety Lead Time");
            #9..11
            */
        //end;


        //Unsupported feature: Code Modification on ""Blanket Order Line No."(Field 98).OnValidate".

        //trigger "(Field 98)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD("Quantity Received",0);
            IF "Blanket Order Line No." <> 0 THEN BEGIN
              PurchLine2.GET("Document Type"::"Blanket Order","Blanket Order No.","Blanket Order Line No.");
              PurchLine2.TESTFIELD(Type,Type);
              PurchLine2.TESTFIELD("No.","No.");
              PurchLine2.TESTFIELD("Pay-to Vendor No.","Pay-to Vendor No.");
              PurchLine2.TESTFIELD("Buy-from Vendor No.","Buy-from Vendor No.");
              IF "Drop Shipment" THEN BEGIN
                PurchLine2.TESTFIELD("Variant Code","Variant Code");
                PurchLine2.TESTFIELD("Location Code","Location Code");
                PurchLine2.TESTFIELD("Unit of Measure Code","Unit of Measure Code");
            #12..16
              VALIDATE("Direct Unit Cost",PurchLine2."Direct Unit Cost");
              VALIDATE("Line Discount %",PurchLine2."Line Discount %");
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..7
              IF "Drop Shipment" OR "Special Order" THEN BEGIN
            #9..19
            */
        //end;

        //Unsupported feature: Deletion (FieldCollection) on "ISBN(Field 50000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Colegio"(Field 67002)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Vendedor"(Field 67003)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Taller"(Field 67004)".

    }


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TestStatusOpen;
        CheckForTaxDifferences;

        #4..74
        THEN BEGIN
          Quantity := 0;
          "Quantity (Base)" := 0;
          "Line Discount Amount" := 0;
          "Inv. Discount Amount" := 0;
          "Inv. Disc. Amount to Invoice" := 0;
        #81..84
          DeferralUtilities.DeferralCodeOnDelete(
            DeferralUtilities.GetPurchDeferralDocType,'','',
            "Document Type","Document No.","Line No.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..77
          "Qty. to Invoice" := 0;
          "Qty. to Invoice (Base)" := 0;
        #78..87
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "InitOutstanding(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "InitOutstandingAmount(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "InitQtyToReceive(PROCEDURE 15)".



    //Unsupported feature: Code Modification on "InitQtyToReceive(PROCEDURE 15)".

    //procedure InitQtyToReceive();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GetPurchSetup;
        IF (PurchSetup."Default Qty. to Receive" = PurchSetup."Default Qty. to Receive"::Remainder) OR
           ("Document Type" = "Document Type"::Invoice)
        THEN BEGIN
          "Qty. to Receive" := "Outstanding Quantity";
          "Qty. to Receive (Base)" := "Outstanding Qty. (Base)";
        END ELSE
          IF "Qty. to Receive" <> 0 THEN
            "Qty. to Receive (Base)" := CalcBaseQty("Qty. to Receive");

        OnAfterInitQtyToReceive(Rec,CurrFieldNo);

        InitQtyToInvoice;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..8
            "Qty. to Receive (Base)" := MaxQtyToReceiveBase(CalcBaseQty("Qty. to Receive"));
        #10..13
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "InitQtyToShip(PROCEDURE 5803)".


    //Unsupported feature: Property Modification (Attributes) on "InitQtyToInvoice(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "MaxQtyToInvoice(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "MaxQtyToInvoiceBase(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "CalcInvDiscToInvoice(PROCEDURE 33)".


    //Unsupported feature: Property Modification (Attributes) on "CalcLineAmount(PROCEDURE 163)".


    //Unsupported feature: Property Modification (Attributes) on "SetPurchHeader(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateDirectUnitCost(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateUnitCost(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateAmounts(PROCEDURE 3)".


    //Unsupported feature: Variable Insertion (Variable: TotalVATDifference) (VariableCollection) on "UpdateVATAmounts(PROCEDURE 38)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateVATAmounts(PROCEDURE 38)".



    //Unsupported feature: Code Modification on "UpdateVATAmounts(PROCEDURE 38)".

    //procedure UpdateVATAmounts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        OnBeforeUpdateVATAmounts(Rec);

        GetPurchHeader;
        #4..33
            PurchLine2.SETFILTER("VAT %",'<>0');
            IF NOT PurchLine2.ISEMPTY THEN BEGIN
              PurchLine2.CALCSUMS(
                "Line Amount","Inv. Discount Amount",Amount,"Amount Including VAT","Quantity (Base)","Tax To Be Expensed");
              TotalLineAmount := PurchLine2."Line Amount";
              TotalInvDiscAmount := PurchLine2."Inv. Discount Amount";
              TotalAmount := PurchLine2.Amount;
              TotalAmountInclVAT := PurchLine2."Amount Including VAT";
              TotalQuantityBase := PurchLine2."Quantity (Base)";
              TotalExpenseTax := PurchLine2."Tax To Be Expensed";
              OnAfterUpdateTotalAmounts(Rec,PurchLine2,TotalAmount,TotalAmountInclVAT,TotalLineAmount,TotalInvDiscAmount);
        #45..109
                    ROUND(
                      (TotalAmount + Amount) * (1 - PurchHeader."VAT Base Discount %" / 100) * "VAT %" / 100,
                      Currency."Amount Rounding Precision",Currency.VATRoundingDirection) -
                    TotalAmountInclVAT;
                END;
              "VAT Calculation Type"::"Full VAT":
                BEGIN
        #117..148
        END;

        OnAfterUpdateVATAmounts(Rec);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..36
                "Line Amount","Inv. Discount Amount",Amount,"Amount Including VAT","Quantity (Base)","VAT Difference",
                "Tax To Be Expensed");
        #38..41
              TotalVATDifference := PurchLine2."VAT Difference";
        #42..112
                    TotalAmountInclVAT + TotalVATDifference;
        #114..151
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "UpdatePrepmtSetupFields(PROCEDURE 102)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateUOMQtyPerStockQty(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "SelectMultipleItems(PROCEDURE 180)".


    //Unsupported feature: Property Modification (Attributes) on "ShowReservation(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "ShowReservationEntries(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "GetDate(PROCEDURE 28)".


    //Unsupported feature: Property Modification (Attributes) on "Signed(PROCEDURE 20)".


    //Unsupported feature: Property Modification (Attributes) on "BlanketOrderLookup(PROCEDURE 36)".


    //Unsupported feature: Property Modification (Attributes) on "BlockDynamicTracking(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "OpenItemTrackingLines(PROCEDURE 6500)".


    //Unsupported feature: Property Modification (Attributes) on "CreateDim(PROCEDURE 26)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "LookupShortcutDimCode(PROCEDURE 30)".


    //Unsupported feature: Property Modification (Attributes) on "ShowShortcutDimCode(PROCEDURE 27)".


    //Unsupported feature: Property Modification (Attributes) on "ShowItemChargeAssgnt(PROCEDURE 5801)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateItemChargeAssgnt(PROCEDURE 5807)".


    //Unsupported feature: Property Modification (Attributes) on "CheckItemChargeAssgnt(PROCEDURE 5800)".


    //Unsupported feature: Property Modification (Attributes) on "GetCaptionClass(PROCEDURE 34)".


    //Unsupported feature: Property Modification (Attributes) on "TestStatusOpen(PROCEDURE 37)".


    //Unsupported feature: Property Modification (Attributes) on "SuspendStatusCheck(PROCEDURE 42)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateLeadTimeFields(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "GetUpdateBasicDates(PROCEDURE 43)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateDates(PROCEDURE 39)".


    //Unsupported feature: Property Modification (Attributes) on "InternalLeadTimeDays(PROCEDURE 35)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateVATOnLines(PROCEDURE 32)".



    //Unsupported feature: Code Modification on "UpdateVATOnLines(PROCEDURE 32)".

    //procedure UpdateVATOnLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        LineWasModified := FALSE;
        IF QtyType = QtyType::Shipping THEN
          EXIT;
        #4..13
          LOCKTABLE;
          IF FINDSET THEN
            REPEAT
              IF NOT ZeroAmountLine(QtyType) THEN BEGIN
                DeferralAmount := GetDeferralAmount;
                VATAmountLine.GET("VAT Identifier","VAT Calculation Type","Tax Group Code","Tax Area Code","Use Tax","Line Amount" >= 0);
                IF VATAmountLine.Modified THEN BEGIN
        #21..140
        END;

        OnAfterUpdateVATOnLines(PurchHeader,PurchLine,VATAmountLine,QtyType);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..16
              IF NOT ZeroAmountLine(QtyType) AND
                 ((PurchHeader."Document Type" <> PurchHeader."Document Type"::Invoice) OR ("Prepmt. Amt. Inv." = 0))
              THEN BEGIN
        #18..143
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "CalcVATAmountLines(PROCEDURE 24)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateWithWarehouseReceive(PROCEDURE 41)".


    //Unsupported feature: Property Modification (Attributes) on "GetItemTranslation(PROCEDURE 44)".


    //Unsupported feature: Property Modification (Attributes) on "AdjustDateFormula(PROCEDURE 48)".


    //Unsupported feature: Property Modification (Attributes) on "RowID1(PROCEDURE 49)".


    //Unsupported feature: Property Modification (Attributes) on "IsInbound(PROCEDURE 75)".


    //Unsupported feature: Property Modification (Attributes) on "CrossReferenceNoLookUp(PROCEDURE 51)".


    //Unsupported feature: Property Modification (Attributes) on "ItemExists(PROCEDURE 52)".


    //Unsupported feature: Property Modification (Attributes) on "CalcPrepaymentToDeduct(PROCEDURE 59)".


    //Unsupported feature: Property Modification (Attributes) on "IsFinalInvoice(PROCEDURE 116)".


    //Unsupported feature: Property Modification (Attributes) on "GetLineAmountToHandle(PROCEDURE 117)".


    //Unsupported feature: Property Modification (Attributes) on "GetLineAmountToHandleInclPrepmt(PROCEDURE 193)".


    //Unsupported feature: Property Modification (Attributes) on "JobTaskIsSet(PROCEDURE 61)".


    //Unsupported feature: Property Modification (Attributes) on "CreateTempJobJnlLine(PROCEDURE 55)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateJobPrices(PROCEDURE 69)".


    //Unsupported feature: Property Modification (Attributes) on "JobSetCurrencyFactor(PROCEDURE 54)".


    //Unsupported feature: Property Modification (Attributes) on "SetUpdateFromVAT(PROCEDURE 58)".


    //Unsupported feature: Property Modification (Attributes) on "InitQtyToReceive2(PROCEDURE 57)".


    //Unsupported feature: Property Modification (Attributes) on "ClearQtyIfBlank(PROCEDURE 88)".


    //Unsupported feature: Property Modification (Attributes) on "ShowLineComments(PROCEDURE 62)".


    //Unsupported feature: Property Modification (Attributes) on "SetDefaultQuantity(PROCEDURE 63)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePrePaymentAmounts(PROCEDURE 65)".


    //Unsupported feature: Property Modification (Attributes) on "SetVendorItemNo(PROCEDURE 64)".


    //Unsupported feature: Property Modification (Attributes) on "ZeroAmountLine(PROCEDURE 66)".


    //Unsupported feature: Property Modification (Attributes) on "FilterLinesWithItemToPlan(PROCEDURE 70)".


    //Unsupported feature: Property Modification (Attributes) on "FindLinesWithItemToPlan(PROCEDURE 68)".


    //Unsupported feature: Property Modification (Attributes) on "LinesWithItemToPlanExist(PROCEDURE 67)".


    //Unsupported feature: Property Modification (Attributes) on "GetVPGInvRoundAcc(PROCEDURE 72)".


    //Unsupported feature: Property Modification (Attributes) on "IsReceivedShippedItemDimChanged(PROCEDURE 89)".


    //Unsupported feature: Property Modification (Attributes) on "ConfirmReceivedShippedItemDimChange(PROCEDURE 90)".


    //Unsupported feature: Property Modification (Attributes) on "InitType(PROCEDURE 22)".


    //Unsupported feature: Property Modification (Attributes) on "CalcSalesTaxLines(PROCEDURE 1020000)".


    //Unsupported feature: Property Modification (Attributes) on "TestExpenseCapitalize(PROCEDURE 1020001)".


    //Unsupported feature: Property Modification (Attributes) on "CheckLocationOnWMS(PROCEDURE 79)".


    //Unsupported feature: Property Modification (Attributes) on "IsNonInventoriableItem(PROCEDURE 175)".


    //Unsupported feature: Property Modification (Attributes) on "IsInventoriableItem(PROCEDURE 139)".


    //Unsupported feature: Property Modification (Attributes) on "CalcAmountIncludingTax(PROCEDURE 1020003)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateLineDiscountPercent(PROCEDURE 160)".


    //Unsupported feature: Property Modification (Attributes) on "HasTypeToFillMandatoryFields(PROCEDURE 103)".


    //Unsupported feature: Property Modification (Attributes) on "GetDeferralAmount(PROCEDURE 105)".


    //Unsupported feature: Property Modification (Attributes) on "DefaultDeferralCode(PROCEDURE 110)".


    //Unsupported feature: Property Modification (Attributes) on "IsCreditDocType(PROCEDURE 83)".


    //Unsupported feature: Property Modification (Attributes) on "IsInvoiceDocType(PROCEDURE 91)".


    //Unsupported feature: Property Modification (Attributes) on "CanEditUnitOfMeasureCode(PROCEDURE 115)".


    //Unsupported feature: Property Modification (Attributes) on "TestItemFields(PROCEDURE 93)".


    //Unsupported feature: Property Modification (Attributes) on "RecalculateTaxes(PROCEDURE 1020004)".


    //Unsupported feature: Property Modification (Attributes) on "ClearPurchaseHeader(PROCEDURE 120)".


    //Unsupported feature: Property Modification (Attributes) on "SendLineInvoiceDiscountResetNotification(PROCEDURE 223)".


    //Unsupported feature: Property Modification (Attributes) on "FormatType(PROCEDURE 149)".


    //Unsupported feature: Property Modification (Attributes) on "RenameNo(PROCEDURE 133)".



    //Unsupported feature: Code Modification on "UpdateBaseAmounts(PROCEDURE 173)".

    //procedure UpdateBaseAmounts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        Amount := NewAmount;
        "Amount Including VAT" := NewAmountIncludingVAT;
        "VAT Base Amount" := NewVATBaseAmount;
        IF NOT PurchHeader."Prices Including VAT" AND (Amount > 0) AND (Amount < "Prepmt. Line Amount") THEN
          "Prepmt. Line Amount" := Amount;
        IF PurchHeader."Prices Including VAT" AND ("Amount Including VAT" > 0) AND ("Amount Including VAT" < "Prepmt. Line Amount") THEN
          "Prepmt. Line Amount" := "Amount Including VAT";
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        */
    //end;


    //Unsupported feature: Code Modification on "UpdatePrepmtAmounts(PROCEDURE 206)".

    //procedure UpdatePrepmtAmounts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "Prepayment %" <> 0 THEN BEGIN
          IF Quantity < 0 THEN
            FIELDERROR(Quantity,STRSUBSTNO(Text043,FIELDCAPTION("Prepayment %")));
          IF "Direct Unit Cost" < 0 THEN
            FIELDERROR("Direct Unit Cost",STRSUBSTNO(Text043,FIELDCAPTION("Prepayment %")));
        END;
        IF PurchHeader."Document Type" <> PurchHeader."Document Type"::Invoice THEN BEGIN
          "Prepayment VAT Difference" := 0;
          IF NOT PrePaymentLineAmountEntered THEN
            "Prepmt. Line Amount" := ROUND("Line Amount" * "Prepayment %" / 100,Currency."Amount Rounding Precision");
          IF "Prepmt. Line Amount" < "Prepmt. Amt. Inv." THEN BEGIN
            IF IsServiceCharge THEN
              ERROR(CannotChangePrepaidServiceChargeErr);
        #14..27
              FIELDERROR("Line Amount",STRSUBSTNO(Text038,xRec."Line Amount"));
            FIELDERROR("Line Amount",STRSUBSTNO(Text039,xRec."Line Amount"));
          END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..8
          IF NOT PrePaymentLineAmountEntered THEN BEGIN
            "Prepmt. Line Amount" := ROUND("Line Amount" * "Prepayment %" / 100,Currency."Amount Rounding Precision");
            IF ABS("Inv. Discount Amount" + "Prepmt. Line Amount") > ABS("Line Amount") THEN
              "Prepmt. Line Amount" := "Line Amount" - "Inv. Discount Amount";
          END;
        #11..30
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignFieldsForNo(PROCEDURE 122)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignHeaderValues(PROCEDURE 134)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignStdTxtValues(PROCEDURE 135)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignGLAccountValues(PROCEDURE 138)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignItemValues(PROCEDURE 136)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignItemChargeValues(PROCEDURE 137)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignFixedAssetValues(PROCEDURE 140)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignItemUOM(PROCEDURE 118)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterBlanketOrderLookup(PROCEDURE 314)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterDeleteChargeChargeAssgnt(PROCEDURE 267)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetDeferralAmount(PROCEDURE 271)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetItem(PROCEDURE 165)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetItemTranslation(PROCEDURE 184)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetPurchHeader(PROCEDURE 159)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterFilterLinesWithItemToPlan(PROCEDURE 217)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateDirectUnitCost(PROCEDURE 126)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateDirectUnitCost(PROCEDURE 127)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeVerifyReservedQty(PROCEDURE 113)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitHeaderDefaults(PROCEDURE 125)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitOutstandingQty(PROCEDURE 142)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitOutstandingAmount(PROCEDURE 109)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitQtyToInvoice(PROCEDURE 128)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitQtyToShip(PROCEDURE 129)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitQtyToReceive(PROCEDURE 130)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitQtyToReceive2(PROCEDURE 200)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSetDefaultQuantity(PROCEDURE 150)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCalcLineAmount(PROCEDURE 188)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCalcVATAmountLines(PROCEDURE 170)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckReceiptRelation(PROCEDURE 204)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckRetShptRelation(PROCEDURE 205)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateDimTableIDs(PROCEDURE 131)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetLineAmountToHandle(PROCEDURE 164)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSalesTaxCalculate(PROCEDURE 171)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSalesTaxCalculateReverse(PROCEDURE 185)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterTestStatusOpen(PROCEDURE 174)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateAmounts(PROCEDURE 121)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateAmountsDone(PROCEDURE 87)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateUnitCost(PROCEDURE 98)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateJobPrices(PROCEDURE 106)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateWithWarehouseReceive(PROCEDURE 124)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateVATAmounts(PROCEDURE 331)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateVATOnLines(PROCEDURE 162)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateSalesCost(PROCEDURE 187)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateTotalAmounts(PROCEDURE 77)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterValidateCrossReferenceNo(PROCEDURE 258)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeAddItems(PROCEDURE 189)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeClearQtyIfBlank(PROCEDURE 201)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCopyFromItem(PROCEDURE 167)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeBlanketOrderLookup(PROCEDURE 161)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCalcInvDiscToInvoice(PROCEDURE 31)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCalcVATAmountLines(PROCEDURE 153)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCreateTempJobJnlLine(PROCEDURE 169)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeGetDefaultBin(PROCEDURE 191)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeGetItemTranslation(PROCEDURE 275)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeJobSetCurrencyFactor(PROCEDURE 181)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeJobTaskIsSet(PROCEDURE 111)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeMaxQtyToInvoice(PROCEDURE 332)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeMaxQtyToInvoiceBase(PROCEDURE 234)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeOpenItemTrackingLines(PROCEDURE 158)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeShowReservation(PROCEDURE 242)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeShowReservationEntries(PROCEDURE 240)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeTestStatusOpen(PROCEDURE 172)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateLeadTimeFields(PROCEDURE 203)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateLineDiscPct(PROCEDURE 196)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdatePrepmtAmounts(PROCEDURE 245)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdatePrepmtSetupFields(PROCEDURE 236)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateVATAmounts(PROCEDURE 154)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateSalesCost(PROCEDURE 190)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateUnitCost(PROCEDURE 195)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateTempJobJnlLine(PROCEDURE 114)".


    //Unsupported feature: Property Modification (Attributes) on "OnCalcVATAmountLinesOnAfterCalcLineTotals(PROCEDURE 266)".


    //Unsupported feature: Property Modification (Attributes) on "OnCopyFromItemOnAfterCheck(PROCEDURE 182)".


    //Unsupported feature: Property Modification (Attributes) on "OnCrossReferenceNoLookupOnBeforeValidateDirectUnitCost(PROCEDURE 168)".


    //Unsupported feature: Property Modification (Attributes) on "OnInitQtyToReceive2OnBeforeCalcInvDiscToInvoice(PROCEDURE 202)".


    //Unsupported feature: Property Modification (Attributes) on "OnUpdateDirectUnitCostOnBeforeFindPrice(PROCEDURE 146)".


    //Unsupported feature: Property Modification (Attributes) on "OnUpdateUnitCostOnBeforeUpdateUnitCostLCY(PROCEDURE 197)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateCrossReferenceNoOnBeforeAssignNo(PROCEDURE 151)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateExpectedReceiptDateOnBeforeCheckDateConflict(PROCEDURE 186)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateTypeOnAfterCheckItem(PROCEDURE 176)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateTypeOnCopyFromTempPurchLine(PROCEDURE 147)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateNoOnCopyFromTempPurchLine(PROCEDURE 148)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateNoOnAfterAssignQtyFromXRec(PROCEDURE 144)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateNoOnAfterChecks(PROCEDURE 155)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateNoOnAfterVerifyChange(PROCEDURE 141)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateNoOnBeforeInitRec(PROCEDURE 143)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateQtyToReceiveOnAfterCheck(PROCEDURE 152)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateQtyToReceiveOnAfterInitQty(PROCEDURE 183)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateQuantityOnBeforeDropShptCheck(PROCEDURE 157)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateReturnQtyToShipOnAfterCheck(PROCEDURE 194)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateReturnQtyToShipOnAfterInitQty(PROCEDURE 198)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateUnitCostLCYOnAfterUpdateUnitCostCurrency(PROCEDURE 199)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateVariantCodeOnAfterValidationChecks(PROCEDURE 166)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateVATProdPostingGroupOnAfterVATPostingSetupGet(PROCEDURE 192)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateVATProdPostingGroupOnBeforeCheckVATCalcType(PROCEDURE 259)".


    //Unsupported feature: Property Modification (Attributes) on "AssignedItemCharge(PROCEDURE 119)".


    procedure MaxQtyToReceiveBase(QtyToReceiveBase: Decimal): Decimal
    begin
        IF ABS(QtyToReceiveBase) > ABS("Outstanding Qty. (Base)") THEN
          EXIT("Outstanding Qty. (Base)");

        EXIT(QtyToReceiveBase);
    end;

    local procedure CheckLineTypeOnIndirectCostPercentUpdate()
    var
        IsHandled: Boolean;
    begin
        IsHandled := FALSE;
        OnBeforeCheckLineTypeOnIndirectCostPercentUpdate(Rec,IsHandled);
        IF IsHandled THEN
          EXIT;

        IF Type <> Type::Item THEN
          TESTFIELD("Indirect Cost %",0);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCheckLineTypeOnIndirectCostPercentUpdate(var PurchaseLine Record: 39;var IsHandled: Boolean)
    begin
    end;


    //Unsupported feature: Property Modification (TextConstString) on "Text012(Variable 1011)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text012 : ENU="must not be specified when %1 = %2;ESM="no se puede indicar cuando %1 = %2;FRC="ne doit pas être spécifié lorsque %1 = %2.";ENC="must not be specified when %1 = %2;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text012 : ENU="must not be specified when %1 = %2;ESM="no se debe especificar cuando %1 = %2;FRC="ne doit pas être spécifié(e) quand %1 = %2;ENC="must not be specified when %1 = %2;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "USText001(Variable 1020007)".

    //var
        //>>>> ORIGINAL VALUE:
        //USText001 : ENU=You have added a %1, which will result in a Tax Entry being posted to record the amount of Sales Tax you will owe your Province as a result of this purchase. Are you sure you want to do this?;ESM=Ha agregado un %1, que arrojará una Entrada de impuesto que se registrará para anotar el monto de Impuesto de ventas que adeudará a la Provincia como resultado de esta compra. ¿Está seguro de que desea hacer esto?;FRC=L'ajout de %1 entraînera le report d'une écriture de taxe pour enregistrer la taxe de vente due à la province pour cet achat. Êtes-vous sûr de vouloir effectuer cette opération ?;ENC=You have added a %1, which will result in a Tax Entry being posted to record the amount of Sales Tax you will owe your Province as a result of this purchase. Are you sure you want to do this?;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //USText001 : ENU=You have added a %1, which will result in a Tax Entry being posted to record the amount of Sales Tax you will owe your Province as a result of this purchase. Are you sure you want to do this?;ESM=Ha agregado un %1, lo que resultará en el registro de un movimiento de impuestos para registrar el importe de impuestos sobre las ventas que le deberá a la provincia como resultado de esta compra. ¿Está seguro de que desea hacer esto?;FRC=L'ajout de %1 entraînera le report d'une écriture de taxe pour enregistrer la taxe de vente due à la province pour cet achat. Êtes-vous sûr de vouloir effectuer cette opération ?;ENC=You have added a %1, which will result in a Tax Entry being posted to record the amount of Sales Tax you will owe your Province as a result of this purchase. Are you sure you want to do this?;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "CannotChangePrepaidServiceChargeErr(Variable 1038)".

    //var
        //>>>> ORIGINAL VALUE:
        //CannotChangePrepaidServiceChargeErr : ENU=You cannot change the line because it will affect service charges that are already invoiced as part of a prepayment.;ESM=No puede cambiar la línea porque afectará a los cargos por servicios que ya se han facturado como parte de un anticipo.;FRC=Vous ne pouvez pas modifier la ligne, car elle affectera les frais de service qui sont déjà facturés dans le cadre d'un paiement anticipé.;ENC=You cannot change the line because it will affect service charges that are already invoiced as part of a prepayment.;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //CannotChangePrepaidServiceChargeErr : ENU=You cannot change the line because it will affect service charges that are already invoiced as part of a prepayment.;ESM=No puede cambiar la línea porque afectará a los cargos por servicios que ya se han facturado como parte de un anticipo.;FRC=Vous ne pouvez pas modifier la ligne, car cela affectera les frais de service qui sont déjà facturés dans le cadre d'un paiement anticipé.;ENC=You cannot change the line because it will affect service charges that are already invoiced as part of a prepayment.;
        //Variable type has not been exported.
}

