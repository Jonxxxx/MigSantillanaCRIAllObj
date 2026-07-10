tableextension 70000037 tableextension70000037 extends "Item Ledger Entry"
{
    fields
    {
        modify("Global Dimension 1 Code")
        {
            Caption = 'Global Dimension 1 Code';
        }
        modify("Global Dimension 2 Code")
        {
            Caption = 'Global Dimension 2 Code';
        }
        modify("Area")
        {
            Caption = 'Area';
        }
        modify("Unit of Measure Code")
        {
            Caption = 'Unit of Measure Code';
        }
        modify("Cost Amount (Actual) (ACY)")
        {
            Caption = 'Cost Amount (Actual) (ACY)';
        }
        modify("Shipped Qty. Not Returned")
        {
            Caption = 'Shipped Qty. Not Returned';
        }
        modify("Prod. Order Comp. Line No.")
        {
            Caption = 'Prod. Order Comp. Line No.';
        }

        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Procedencia"(Field 50000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Edición"(Field 50001)".


        //Unsupported feature: Deletion (FieldCollection) on "Areas(Field 50002)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Paginas"(Field 50003)".


        //Unsupported feature: Deletion (FieldCollection) on "ISBN(Field 50004)".


        //Unsupported feature: Deletion (FieldCollection) on ""Componentes Prod."(Field 50005)".


        //Unsupported feature: Deletion (FieldCollection) on ""Nivel Educativo"(Field 50006)".


        //Unsupported feature: Deletion (FieldCollection) on "Cursos(Field 50007)".


        //Unsupported feature: Deletion (FieldCollection) on ""Precio Unitario Cons. Inicial"(Field 50008)".


        //Unsupported feature: Deletion (FieldCollection) on ""Descuento % Cons. Inicial"(Field 50009)".


        //Unsupported feature: Deletion (FieldCollection) on ""Importe Cons. bruto Inicial"(Field 50010)".


        //Unsupported feature: Deletion (FieldCollection) on ""Importe Cons. Neto Inicial"(Field 50011)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cant. Consignacion Pendiente"(Field 50012)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Mov. Prod. Cosg. a Liq."(Field 50013)".


        //Unsupported feature: Deletion (FieldCollection) on ""Pedido Consignacion"(Field 50014)".


        //Unsupported feature: Deletion (FieldCollection) on ""Devolucion Consignacion"(Field 50015)".


        //Unsupported feature: Deletion (FieldCollection) on ""Descripcion Producto"(Field 50016)".


        //Unsupported feature: Deletion (FieldCollection) on ""Precio Unitario Cons. Act."(Field 50017)".


        //Unsupported feature: Deletion (FieldCollection) on ""Descuento % Cons. Actualizado"(Field 50018)".


        //Unsupported feature: Deletion (FieldCollection) on ""Importe Cons. bruto Act."(Field 50019)".


        //Unsupported feature: Deletion (FieldCollection) on ""Importe Cons. Neto Act."(Field 50020)".


        //Unsupported feature: Deletion (FieldCollection) on ""Ult. Fecha Act. Imp. Consig."(Field 50021)".


        //Unsupported feature: Deletion (FieldCollection) on ""No aplica Derechos de Autor"(Field 56020)".


        //Unsupported feature: Deletion (FieldCollection) on "Promocion(Field 56021)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Colegio"(Field 67002)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Vendedor"(Field 67003)".

    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Location Code,Open"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Pedido Consignacion"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Posting Date,Location Code"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Source No."(Key)".

    }

    //Unsupported feature: Property Modification (Attributes) on "ShowReservationEntries(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "SetAppliedEntryToAdjust(PROCEDURE 66)".


    //Unsupported feature: Property Modification (Attributes) on "SetAvgTransCompletelyInvoiced(PROCEDURE 80)".


    //Unsupported feature: Property Modification (Attributes) on "SetCompletelyInvoiced(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "AppliedEntryToAdjustExists(PROCEDURE 40)".


    //Unsupported feature: Property Modification (Attributes) on "IsOutbndConsump(PROCEDURE 57)".


    //Unsupported feature: Property Modification (Attributes) on "IsExactCostReversingPurchase(PROCEDURE 59)".


    //Unsupported feature: Property Modification (Attributes) on "IsExactCostReversingOutput(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateItemTracking(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "GetUnitCostLCY(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "FilterLinesWithItemToPlan(PROCEDURE 69)".


    //Unsupported feature: Property Modification (Attributes) on "FindLinesWithItemToPlan(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "LinesWithItemToPlanExist(PROCEDURE 67)".


    //Unsupported feature: Property Modification (Attributes) on "IsOutbndSale(PROCEDURE 5888)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "CalculateRemQuantity(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "VerifyOnInventory(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "CalculateRemInventoryValue(PROCEDURE 12)".


    //Unsupported feature: Code Modification on "CalculateRemInventoryValue(PROCEDURE 12)".

    //procedure CalculateRemInventoryValue();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ValueEntry.SETCURRENTKEY("Item Ledger Entry No.");
    ValueEntry.SETRANGE("Item Ledger Entry No.",ItemLedgEntryNo);
    ValueEntry.SETFILTER("Valuation Date",'<=%1',PostingDate);
    IF NOT IncludeExpectedCost THEN
      ValueEntry.SETRANGE("Expected Cost",FALSE);
    IF ValueEntry.FINDSET THEN
      REPEAT
        IF ValueEntry."Entry Type" = ValueEntry."Entry Type"::Revaluation THEN
          TotalQty := ValueEntry."Valued Quantity"
        ELSE
          TotalQty := ItemLedgEntryQty;
        IF ValueEntry."Entry Type" <> ValueEntry."Entry Type"::Rounding THEN
          IF IncludeExpectedCost THEN
            AdjustedCost += RemQty / TotalQty * (ValueEntry."Cost Amount (Actual)" + ValueEntry."Cost Amount (Expected)")
          ELSE
            AdjustedCost += RemQty / TotalQty * ValueEntry."Cost Amount (Actual)";
      UNTIL ValueEntry.NEXT = 0;
    EXIT(AdjustedCost);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    EXIT(
      CalculateRemainingInventoryValue(ItemLedgEntryNo,ItemLedgEntryQty,RemQty,IncludeExpectedCost,PostingDate,0D));
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "TrackingExists(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "SetItemVariantLocationFilters(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "SetTrackingFilter(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "SetTrackingFilterFromSpec(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterFilterLinesWithItemToPlan(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeVerifyOnInventory(PROCEDURE 18)".


    [Scope('Personalization')]
    procedure CalculateRemainingInventoryValue(ItemLedgEntryNo: Integer; ItemLedgEntryQty: Decimal; RemQty: Decimal; IncludeExpectedCost: Boolean; ValuationDate: Date; PostingDate: Date): Decimal
    var
        ValueEntry Record: 5802;
        AdjustedCost: Decimal;
        TotalQty: Decimal;
    begin
        ValueEntry.SETCURRENTKEY("Item Ledger Entry No.");
        ValueEntry.SETRANGE("Item Ledger Entry No.", ItemLedgEntryNo);
        IF ValuationDate <> 0D THEN
            ValueEntry.SETRANGE("Valuation Date", 0D, ValuationDate);
        IF PostingDate <> 0D THEN
            ValueEntry.SETRANGE("Posting Date", 0D, PostingDate);
        ValueEntry.SETFILTER("Entry Type", '<>%1', ValueEntry."Entry Type"::Rounding);
        IF NOT IncludeExpectedCost THEN
            ValueEntry.SETRANGE("Expected Cost", FALSE);
        IF ValueEntry.FINDSET THEN
            REPEAT
                IF ValueEntry."Entry Type" = ValueEntry."Entry Type"::Revaluation THEN
                    TotalQty := ValueEntry."Valued Quantity"
                ELSE
                    TotalQty := ItemLedgEntryQty;
                IF IncludeExpectedCost THEN
                    AdjustedCost += RemQty / TotalQty * (ValueEntry."Cost Amount (Actual)" + ValueEntry."Cost Amount (Expected)")
                ELSE
                    AdjustedCost += RemQty / TotalQty * ValueEntry."Cost Amount (Actual)";
            UNTIL ValueEntry.NEXT = 0;

        EXIT(AdjustedCost);
    end;

    //Unsupported feature: Deletion (VariableCollection) on "CalculateRemInventoryValue(PROCEDURE 12).ValueEntry(Variable 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "CalculateRemInventoryValue(PROCEDURE 12).AdjustedCost(Variable 1003)".


    //Unsupported feature: Deletion (VariableCollection) on "CalculateRemInventoryValue(PROCEDURE 12).TotalQty(Variable 1007)".

}

