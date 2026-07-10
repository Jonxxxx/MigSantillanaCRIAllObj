tableextension 70000110 tableextension70000110 extends "Item Journal Line"
{
    fields
    {
        modify("Item No.")
        {
            TableRelation = Item WHERE(Blocked = CONST(false));
        }
        modify("Location Code")
        {
            TableRelation = Location;
        }
        modify("Item Shpt. Entry No.")
        {
            Caption = 'Item Shpt. Entry No.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            Caption = 'Shortcut Dimension 1 Code';
        }
        modify("Shortcut Dimension 2 Code")
        {
            Caption = 'Shortcut Dimension 2 Code';
        }
        modify("New Location Code")
        {
            TableRelation = Location;
        }
        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Gen. Bus. Posting Group';
        }
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        modify("Area")
        {
            Caption = 'Area';
        }
        modify("Job Contract Entry No.")
        {
            Caption = 'Job Contract Entry No.';
        }
        modify("Unit of Measure Code")
        {
            Caption = 'Unit of Measure Code';
        }
        modify("Originally Ordered No.")
        {
            TableRelation = Item;
        }
        modify("Invoice-to Source No.")
        {
            TableRelation = IF (Source Type=CONST(Customer)) Customer
                            ELSE IF (Source Type=CONST(Vendor)) Vendor;
        }
        modify("Prod. Order Comp. Line No.")
        {
            Caption = 'Prod. Order Comp. Line No.';
        }
        modify("Work Center Group Code")
        {
            Caption = 'Work Center Group Code';
        }
        modify("New Item Expiration Date")
        {
            Caption = 'New Item Expiration Date';
        }

        //Unsupported feature: Code Modification on ""Item No."(Field 3).OnValidate".

        //trigger "(Field 3)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Item No." <> xRec."Item No." THEN BEGIN
          "Variant Code" := '';
          "Bin Code" := '';
          IF CurrFieldNo <> 0 THEN
            WMSManagement.CheckItemJnlLineFieldChange(Rec,xRec,FIELDCAPTION("Item No."));
          IF ("Location Code" <> '') AND ("Item No." <> '') THEN BEGIN
            GetLocation("Location Code");
            IF Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick" THEN
              WMSManagement.GetDefaultBin("Item No.","Variant Code","Location Code","Bin Code")
          END;
          IF ("Entry Type" = "Entry Type"::Transfer) AND ("Location Code" = "New Location Code") THEN
            "New Bin Code" := "Bin Code";
        END;

        IF "Entry Type" IN ["Entry Type"::Consumption,"Entry Type"::Output] THEN
          WhseValidateSourceLine.ItemLineVerifyChange(Rec,xRec);

        IF "Item No." = '' THEN BEGIN
          CreateDim(
            DATABASE::Item,"Item No.",
            DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
            DATABASE::"Work Center","Work Center No.");
          EXIT;
        END;

        GetItem;
        OnValidateItemNoOnAfterGetItem(Rec,Item);
        DisplayErrorIfItemIsBlocked(Item);
        ValidateTypeWithItemNo;

        IF "Value Entry Type" = "Value Entry Type"::Revaluation THEN
          Item.TESTFIELD("Inventory Value Zero",FALSE);
        Description := Item.Description;
        "Inventory Posting Group" := Item."Inventory Posting Group";
        "Item Category Code" := Item."Item Category Code";

        IF ("Value Entry Type" <> "Value Entry Type"::"Direct Cost") OR
           ("Item Charge No." <> '')
        THEN BEGIN
          IF "Item No." <> xRec."Item No." THEN BEGIN
            TESTFIELD("Partial Revaluation",FALSE);
            RetrieveCosts;
            "Indirect Cost %" := 0;
            "Overhead Rate" := 0;
            "Inventory Value Per" := "Inventory Value Per"::" ";
            VALIDATE("Applies-to Entry",0);
            "Partial Revaluation" := FALSE;
          END;
        END ELSE BEGIN
          "Indirect Cost %" := Item."Indirect Cost %";
          "Overhead Rate" := Item."Overhead Rate";
          IF NOT "Phys. Inventory" OR (Item."Costing Method" = Item."Costing Method"::Standard) THEN BEGIN
            RetrieveCosts;
            "Unit Cost" := UnitCost;
          END ELSE
            UnitCost := "Unit Cost";
        END;

        IF (("Entry Type" = "Entry Type"::Output) AND (WorkCenter."No." = '') AND (MachineCenter."No." = '')) OR
           ("Entry Type" <> "Entry Type"::Output) OR
           ("Value Entry Type" = "Value Entry Type"::Revaluation)
        THEN
          "Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";

        CASE "Entry Type" OF
          "Entry Type"::Purchase,
          "Entry Type"::Output,
          "Entry Type"::"Assembly Output":
            PurchPriceCalcMgt.FindItemJnlLinePrice(Rec,FIELDNO("Item No."));
          "Entry Type"::"Positive Adjmt.",
          "Entry Type"::"Negative Adjmt.",
          "Entry Type"::Consumption,
          "Entry Type"::"Assembly Consumption":
            "Unit Amount" := UnitCost;
          "Entry Type"::Sale:
            SalesPriceCalcMgt.FindItemJnlLinePrice(Rec,FIELDNO("Item No."));
          "Entry Type"::Transfer:
            BEGIN
              "Unit Amount" := 0;
              "Unit Cost" := 0;
              Amount := 0;
            END;
        END;

        CASE "Entry Type" OF
          "Entry Type"::Purchase:
            "Unit of Measure Code" := Item."Purch. Unit of Measure";
          "Entry Type"::Sale:
            "Unit of Measure Code" := Item."Sales Unit of Measure";
          "Entry Type"::Output:
            BEGIN
              Item.TESTFIELD("Inventory Value Zero",FALSE);
              ProdOrderLine.SetFilterByReleasedOrderNo("Order No.");
              ProdOrderLine.SETRANGE("Item No.","Item No.");
              IF ProdOrderLine.FINDFIRST THEN BEGIN
                "Routing No." := ProdOrderLine."Routing No.";
                "Source Type" := "Source Type"::Item;
                "Source No." := ProdOrderLine."Item No.";
              END ELSE
                IF ("Value Entry Type" <> "Value Entry Type"::Revaluation) AND
                   (CurrFieldNo <> 0)
                THEN
                  ERROR(Text031,"Item No.","Order No.");
              IF ProdOrderLine.COUNT = 1 THEN
                CopyFromProdOrderLine(ProdOrderLine)
              ELSE
                "Unit of Measure Code" := Item."Base Unit of Measure";
            END;
          "Entry Type"::Consumption:
            BEGIN
              ProdOrderComp.SetFilterByReleasedOrderNo("Order No.");
              ProdOrderComp.SETRANGE("Item No.","Item No.");
              IF ProdOrderComp.COUNT = 1 THEN BEGIN
                ProdOrderComp.FINDFIRST;
                CopyFromProdOrderComp(ProdOrderComp);
              END ELSE BEGIN
                "Unit of Measure Code" := Item."Base Unit of Measure";
                VALIDATE("Prod. Order Comp. Line No.",0);
              END;
            END;
        END;

        IF "Unit of Measure Code" = '' THEN
          "Unit of Measure Code" := Item."Base Unit of Measure";

        IF "Value Entry Type" = "Value Entry Type"::Revaluation THEN
          "Unit of Measure Code" := Item."Base Unit of Measure";
        VALIDATE("Unit of Measure Code");
        IF "Variant Code" <> '' THEN
          VALIDATE("Variant Code");

        OnAfterOnValidateItemNoAssignByEntryType(Rec,Item);

        CheckItemAvailable(FIELDNO("Item No."));

        IF ((NOT ("Order Type" IN ["Order Type"::Production,"Order Type"::Assembly])) OR ("Order No." = '')) AND NOT "Phys. Inventory"
        THEN
          CreateDim(
            DATABASE::Item,"Item No.",
            DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
            DATABASE::"Work Center","Work Center No.");

        OnBeforeVerifyReservedQty(Rec,xRec,FIELDNO("Item No."));
        ReserveItemJnlLine.VerifyChange(Rec,xRec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..109
            IF FindProdOrderComponent(ProdOrderComp) THEN
              CopyFromProdOrderComp(ProdOrderComp)
            ELSE BEGIN
              "Unit of Measure Code" := Item."Base Unit of Measure";
              VALIDATE("Prod. Order Comp. Line No.",0);
        #120..144
        */
        //end;

        //Unsupported feature: Property Deletion (Description) on ""Item No."(Field 3)".


        //Unsupported feature: Property Deletion (Description) on ""Location Code"(Field 9)".


        //Unsupported feature: Property Deletion (Description) on ""New Location Code"(Field 50)".


        //Unsupported feature: Deletion on ""Gen. Bus. Posting Group"(Field 57).OnValidate".


        //Unsupported feature: Property Deletion (Description) on ""Originally Ordered No."(Field 5701)".


        //Unsupported feature: Property Deletion (Description) on ""Invoice-to Source No."(Field 5820)".



        //Unsupported feature: Code Insertion (VariableCollection) on ""Prod. Order Comp. Line No."(Field 5884).OnValidate".

        //trigger (Variable: ProdOrderComponent)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on ""Prod. Order Comp. Line No."(Field 5884).OnValidate".

        //trigger  Order Comp()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Prod. Order Comp. Line No." <> xRec."Prod. Order Comp. Line No." THEN
          CreateProdDim;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF "Prod. Order Comp. Line No." <> xRec."Prod. Order Comp. Line No." THEN BEGIN
          IF ("Order Type" = "Order Type"::Production) AND ("Prod. Order Comp. Line No." <> 0) THEN BEGIN
            ProdOrderComponent.GET(
              ProdOrderComponent.Status::Released,"Order No.","Order Line No.","Prod. Order Comp. Line No.");
            IF "Item No." <> ProdOrderComponent."Item No." THEN
              VALIDATE("Item No.",ProdOrderComponent."Item No.");
          END;

          CreateProdDim;
        END;
        */
        //end;

        //Unsupported feature: Deletion (FieldCollection) on ""No. Paginas"(Field 50000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Componentes Producto"(Field 50001)".


        //Unsupported feature: Deletion (FieldCollection) on "ISBN(Field 50002)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Procedencia"(Field 50003)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Edición"(Field 50004)".


        //Unsupported feature: Deletion (FieldCollection) on "Areas(Field 50005)".


        //Unsupported feature: Deletion (FieldCollection) on ""Nivel Educativo"(Field 50006)".


        //Unsupported feature: Deletion (FieldCollection) on "Cursos(Field 50007)".


        //Unsupported feature: Deletion (FieldCollection) on ""Precio Unitario Cons. Inicial"(Field 50008)".


        //Unsupported feature: Deletion (FieldCollection) on ""Descuento % Cons. Inicial"(Field 50009)".


        //Unsupported feature: Deletion (FieldCollection) on ""Importe Cons. bruto Inicial"(Field 50010)".


        //Unsupported feature: Deletion (FieldCollection) on ""Importe Cons Neto Inicial"(Field 50011)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Mov. Prod. Cosg. a Liq."(Field 50012)".


        //Unsupported feature: Deletion (FieldCollection) on ""Pedido Consignacion"(Field 50014)".


        //Unsupported feature: Deletion (FieldCollection) on ""Devolucion Consignacion"(Field 50015)".


        //Unsupported feature: Deletion (FieldCollection) on ""Precio Unitario Cons. Act."(Field 50016)".


        //Unsupported feature: Deletion (FieldCollection) on ""Descuento % Cons. Actualizado"(Field 50017)".


        //Unsupported feature: Deletion (FieldCollection) on ""Importe Cons. bruto Act."(Field 50018)".


        //Unsupported feature: Deletion (FieldCollection) on ""Importe Cons. Neto Actualizado"(Field 50019)".


        //Unsupported feature: Deletion (FieldCollection) on ""No aplica Derechos de Autor"(Field 56020)".


        //Unsupported feature: Deletion (FieldCollection) on "Promocion(Field 56021)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Colegio"(Field 56022)".


        //Unsupported feature: Deletion (FieldCollection) on "Barcode(Field 34002500)".

    }

    //Unsupported feature: Property Modification (Attributes) on "EmptyLine(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "IsValueEntryForDeletedItem(PROCEDURE 22)".



    //Unsupported feature: Code Modification on "GetItem(PROCEDURE 2)".

    //procedure GetItem();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Item."No." <> "Item No." THEN
    //GRN
      //Item.GET("Item No."); Para buscar por Producto o Cod. Barras
      IF NOT Item.GET("Item No.") THEN
         BEGIN
          ICR.SETCURRENTKEY("Cross-Reference No.");
          ICR.SETRANGE("Cross-Reference No.","Item No.");
          IF ICR.FINDFIRST THEN;
          Item.GET(ICR."Item No.")
         END;
    //GRN-
    OnAfterGetItemChange(Item,Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF Item."No." <> "Item No." THEN
      Item.GET("Item No.");

    OnAfterGetItemChange(Item,Rec);
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "SetUpNewLine(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "SetDocNos(PROCEDURE 165)".


    //Unsupported feature: Property Modification (Attributes) on "Signed(PROCEDURE 20)".


    //Unsupported feature: Property Modification (Attributes) on "IsInbound(PROCEDURE 31)".


    //Unsupported feature: Property Modification (Attributes) on "OpenItemTrackingLines(PROCEDURE 6500)".


    //Unsupported feature: Property Modification (Attributes) on "CreateDim(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "CopyDim(PROCEDURE 46)".


    //Unsupported feature: Property Modification (Attributes) on "CreateProdDim(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "LookupShortcutDimCode(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "ShowShortcutDimCode(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateNewShortcutDimCode(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "LookupNewShortcutDimCode(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "ShowNewShortcutDimCode(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "CopyDocumentFields(PROCEDURE 129)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromSalesHeader(PROCEDURE 58)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromSalesLine(PROCEDURE 12)".



    //Unsupported feature: Code Modification on "CopyFromSalesLine(PROCEDURE 12)".

    //procedure CopyFromSalesLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Item No." := SalesLine."No.";
    Description := SalesLine.Description;
    "Shortcut Dimension 1 Code" := SalesLine."Shortcut Dimension 1 Code";
    "Shortcut Dimension 2 Code" := SalesLine."Shortcut Dimension 2 Code";
    "Dimension Set ID" := SalesLine."Dimension Set ID";

    //004
    SalesHeader.GET(SalesLine."Document Type",SalesLine."Document No.");
    IF SalesHeader."Pedido Consignacion" THEN
      BEGIN
        "Precio Unitario Cons. Inicial" := SalesLine."Unit Price";
        "Descuento % Cons. Inicial"     := SalesLine."Line Discount %";
        "Importe Cons. bruto Inicial"   := (SalesLine."Unit Price" * SalesLine."Qty. to Invoice");
        "Importe Cons Neto Inicial"     := ("Importe Cons. bruto Inicial" - SalesLine."Line Discount Amount");
        "No. Mov. Prod. Cosg. a Liq."   := SalesLine."No. Mov. Prod. Cosg. a Liq.";
        "Pedido Consignacion"           := TRUE;
      END;
    //004

    //014
    "No aplica Derechos de Autor" := SalesHeader."No aplica Derechos de Autor";
    "Cod. Colegio" := SalesHeader."Cod. Colegio";
    //014

    "Location Code" := SalesLine."Location Code";
    "Bin Code" := SalesLine."Bin Code";
    "Variant Code" := SalesLine."Variant Code";
    "Inventory Posting Group" := SalesLine."Posting Group";
    "Gen. Bus. Posting Group" := SalesLine."Gen. Bus. Posting Group";
    "Gen. Prod. Posting Group" := SalesLine."Gen. Prod. Posting Group";
    "Transaction Type" := SalesLine."Transaction Type";
    "Transport Method" := SalesLine."Transport Method";
    "Entry/Exit Point" := SalesLine."Exit Point";
    Area := SalesLine.Area;
    "Transaction Specification" := SalesLine."Transaction Specification";
    "Drop Shipment" := SalesLine."Drop Shipment";
    "Entry Type" := "Entry Type"::Sale;
    "Unit of Measure Code" := SalesLine."Unit of Measure Code";
    "Qty. per Unit of Measure" := SalesLine."Qty. per Unit of Measure";
    "Derived from Blanket Order" := SalesLine."Blanket Order No." <> '';
    "Cross-Reference No." := SalesLine."Cross-Reference No.";
    "Originally Ordered No." := SalesLine."Originally Ordered No.";
    "Originally Ordered Var. Code" := SalesLine."Originally Ordered Var. Code";
    "Out-of-Stock Substitution" := SalesLine."Out-of-Stock Substitution";
    "Item Category Code" := SalesLine."Item Category Code";
    Nonstock := SalesLine.Nonstock;
    "Purchasing Code" := SalesLine."Purchasing Code";
    "Return Reason Code" := SalesLine."Return Reason Code";
    "Planned Delivery Date" := SalesLine."Planned Delivery Date";
    "Document Line No." := SalesLine."Line No.";
    "Unit Cost" := SalesLine."Unit Cost (LCY)";
    "Unit Cost (ACY)" := SalesLine."Unit Cost";
    "Value Entry Type" := "Value Entry Type"::"Direct Cost";
    "Source Type" := "Source Type"::Customer;
    "Source No." := SalesLine."Sell-to Customer No.";
    "Invoice-to Source No." := SalesLine."Bill-to Customer No.";

    OnAfterCopyItemJnlLineFromSalesLine(Rec,SalesLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
    #25..58
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "CopyFromPurchHeader(PROCEDURE 57)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromPurchLine(PROCEDURE 160)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromServHeader(PROCEDURE 59)".



    //Unsupported feature: Code Modification on "CopyFromServHeader(PROCEDURE 59)".

    //procedure CopyFromServHeader();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Document Date" := ServiceHeader."Document Date";
    "Order Date" := ServiceHeader."Order Date";
    "Source Posting Group" := ServiceHeader."Customer Posting Group";
    "Salespers./Purch. Code" := ServiceHeader."Salesperson Code";
    "Country/Region Code" := ServiceHeader."VAT Country/Region Code";
    "Reason Code" := ServiceHeader."Reason Code";
    "Source Type" := "Source Type"::Customer;
    "Source No." := ServiceHeader."Customer No.";
    "Shpt. Method Code" := ServiceHeader."Shipment Method Code";

    OnAfterCopyItemJnlLineFromServHeader(Rec,ServiceHeader);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    #6..10
    IF ServiceHeader.IsCreditDocType THEN
      "Country/Region Code" := ServiceHeader."Country/Region Code"
    ELSE
      IF ServiceHeader."Ship-to Country/Region Code" <> '' THEN
        "Country/Region Code" := ServiceHeader."Ship-to Country/Region Code"
      ELSE
        "Country/Region Code" := ServiceHeader."Country/Region Code";

    OnAfterCopyItemJnlLineFromServHeader(Rec,ServiceHeader);
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "CopyFromServLine(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromServShptHeader(PROCEDURE 53)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromServShptLine(PROCEDURE 51)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromServShptLineUndo(PROCEDURE 60)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromJobJnlLine(PROCEDURE 76)".


    //Unsupported feature: Property Modification (Attributes) on "OnlyStopTime(PROCEDURE 24)".


    //Unsupported feature: Property Modification (Attributes) on "OutputValuePosting(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "TimeIsEmpty(PROCEDURE 26)".


    //Unsupported feature: Property Modification (Attributes) on "RowID1(PROCEDURE 44)".


    //Unsupported feature: Property Modification (Attributes) on "ItemPosting(PROCEDURE 33)".


    //Unsupported feature: Property Modification (Attributes) on "LastOutputOperation(PROCEDURE 35)".


    //Unsupported feature: Property Modification (Attributes) on "LookupItemNo(PROCEDURE 37)".


    //Unsupported feature: Property Modification (Attributes) on "RecalculateUnitAmount(PROCEDURE 38)".


    //Unsupported feature: Property Modification (Attributes) on "IsReclass(PROCEDURE 40)".


    //Unsupported feature: Property Modification (Attributes) on "CheckWhse(PROCEDURE 39)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 41)".


    //Unsupported feature: Property Modification (Attributes) on "ShowReclasDimensions(PROCEDURE 30)".


    //Unsupported feature: Property Modification (Attributes) on "PostingItemJnlFromProduction(PROCEDURE 43)".


    //Unsupported feature: Property Modification (Attributes) on "IsAssemblyResourceConsumpLine(PROCEDURE 87)".


    //Unsupported feature: Property Modification (Attributes) on "IsAssemblyOutputLine(PROCEDURE 89)".


    //Unsupported feature: Property Modification (Attributes) on "IsATOCorrection(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "ClearTracking(PROCEDURE 63)".


    //Unsupported feature: Property Modification (Attributes) on "CopyTrackingFromSpec(PROCEDURE 62)".


    //Unsupported feature: Property Modification (Attributes) on "TrackingExists(PROCEDURE 47)".


    //Unsupported feature: Property Modification (Attributes) on "TestItemFields(PROCEDURE 61)".


    //Unsupported feature: Property Modification (Attributes) on "DisplayErrorIfItemIsBlocked(PROCEDURE 83)".


    //Unsupported feature: Property Modification (Attributes) on "IsPurchaseReturn(PROCEDURE 49)".


    //Unsupported feature: Property Modification (Attributes) on "IsOpenedFromBatch(PROCEDURE 50)".


    //Unsupported feature: Property Modification (Attributes) on "SubcontractingWorkCenterUsed(PROCEDURE 52)".


    //Unsupported feature: Property Modification (Attributes) on "CheckItemJournalLineRestriction(PROCEDURE 161)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateTypeWithItemNo(PROCEDURE 81)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSetupNewLine(PROCEDURE 71)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterClearTracking(PROCEDURE 98)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyItemJnlLineFromSalesHeader(PROCEDURE 64)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyItemJnlLineFromSalesLine(PROCEDURE 65)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyItemJnlLineFromPurchHeader(PROCEDURE 66)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyItemJnlLineFromPurchLine(PROCEDURE 67)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyItemJnlLineFromServHeader(PROCEDURE 69)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyItemJnlLineFromServLine(PROCEDURE 70)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyItemJnlLineFromServShptHeader(PROCEDURE 72)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyItemJnlLineFromServShptLine(PROCEDURE 73)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyItemJnlLineFromServShptLineUndo(PROCEDURE 74)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyItemJnlLineFromJobJnlLine(PROCEDURE 75)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyTrackingFromSpec(PROCEDURE 80)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromProdOrderComp(PROCEDURE 85)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromProdOrderLine(PROCEDURE 92)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromWorkCenter(PROCEDURE 94)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromMachineCenter(PROCEDURE 95)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetItemChange(PROCEDURE 99)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetUnitAmount(PROCEDURE 106)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterItemPosting(PROCEDURE 102)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterOnValidateItemNoAssignByEntryType(PROCEDURE 68)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateDimTableIDs(PROCEDURE 164)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterReadGLSetup(PROCEDURE 113)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterRecalculateUnitAmount(PROCEDURE 108)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateAmount(PROCEDURE 78)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckItemAvailable(PROCEDURE 111)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeDisplayErrorIfItemIsBlocked(PROCEDURE 115)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeGetUnitAmount(PROCEDURE 107)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeLookupItemNo(PROCEDURE 112)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforePostingItemJnlFromProduction(PROCEDURE 96)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeRetrieveCosts(PROCEDURE 82)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeSelectItemEntry(PROCEDURE 101)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeValidateUnitOfMeasureCode(PROCEDURE 110)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeVerifyReservedQty(PROCEDURE 77)".


    //Unsupported feature: Property Modification (Attributes) on "OnCheckItemJournalLinePostRestrictions(PROCEDURE 90)".


    //Unsupported feature: Property Modification (Attributes) on "OnCreateAssemblyDimOnAfterCreateDimSetIDArr(PROCEDURE 103)".


    //Unsupported feature: Property Modification (Attributes) on "OnCreateProdDimOnAfterCreateDimSetIDArr(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "OnLastOutputOperationOnBeforeTestRoutingNo(PROCEDURE 97)".


    //Unsupported feature: Property Modification (Attributes) on "OnSelectItemEntryOnBeforeOpenPage(PROCEDURE 104)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateItemNoOnAfterGetItem(PROCEDURE 88)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateOrderNoOrderTypeProduction(PROCEDURE 105)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateQuantityOnBeforeGetUnitAmount(PROCEDURE 100)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateUnitOfMeasureCodeOnBeforeCalcUnitCost(PROCEDURE 109)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeValidateScrapCode(PROCEDURE 314)".


    procedure IsNotInternalWhseMovement(): Boolean
    begin
        EXIT(
          NOT (("Entry Type" = "Entry Type"::Transfer) AND
               ("Location Code" = "New Location Code") AND
               ("Dimension Set ID" = "New Dimension Set ID") AND
               ("Value Entry Type" = "Value Entry Type"::"Direct Cost") AND
               NOT Adjustment));
    end;

    local procedure FindProdOrderComponent(var ProdOrderComponent Record: 5407"): Boolean
    begin
        ProdOrderComponent.SetFilterByReleasedOrderNo("Order No.");
        ProdOrderComponent.SETRANGE("Line No.", "Prod. Order Comp. Line No.");
        ProdOrderComponent.SETRANGE("Item No.", "Item No.");
        IF ProdOrderComponent.FINDFIRST THEN
            EXIT(TRUE);

        ProdOrderComponent.SETRANGE("Line No.");
        IF ProdOrderComponent.COUNT = 1 THEN
            EXIT(ProdOrderComponent.FINDFIRST);

        EXIT(FALSE);
    end;

    //Unsupported feature: Deletion (VariableCollection) on "GetItem(PROCEDURE 2).ICR(Variable 1000000000)".


    //Unsupported feature: Deletion (VariableCollection) on "CopyFromSalesLine(PROCEDURE 12).SalesHeader(Variable 100000000)".


    var
        ProdOrderComponent Record: 5407;


    //Unsupported feature: Property Modification (TextConstString) on "RevaluationPerEntryNotAllowedErr(Variable 1050)".

    //var
    //>>>> ORIGINAL VALUE:
    //RevaluationPerEntryNotAllowedErr : ENU=This item has already been revalued with the Calculate Inventory Value function, so you cannot use the Applies-to Entry field as that may change the valuation.;ESM=Este producto ya ha revalorizado con la función Calcular valor inventario, por lo que no puede usar el campo Liq. por n.º orden ya que eso puede cambiar la valoración.;FRC=Cet article a déjà été réévalué avec la fonction Calculer valeur de l'inventaire, vous ne pouvez donc pas utiliser le champ Écriture référence, étant donné que cela peut modifier l'évaluation.;ENC=This item has already been revalued with the Calculate Inventory Value function, so you cannot use the Applies-to Entry field as that may change the valuation.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //RevaluationPerEntryNotAllowedErr : ENU=This item has already been revalued with the Calculate Inventory Value function, so you cannot use the Applies-to Entry field as that may change the valuation.;ESM=Este producto ya se ha revalorizado con la función Calcular valor inventario, por lo que no puede usar el campo Liq. por n.º orden ya que eso puede cambiar la valoración.;FRC=Cet article a déjà été réévalué avec la fonction Calculer valeur de l'inventaire, vous ne pouvez donc pas utiliser le champ Écriture référence, étant donné que cela peut modifier l'évaluation.;ENC=This item has already been revalued with the Calculate Inventory Value function, so you cannot use the Applies-to Entry field as that may change the valuation.;
    //Variable type has not been exported.
}

