report 56135 Inventario
{
    DefaultLayout = RDLC;
    RDLCLayout = './Inventario.rdlc';
    ApplicationArea = Basic, Suite, Service;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Item; 27)
        {
            CalcFields = Qty. on Purch. Order, Qty. on Sales Order;
            DataItemTableView = SORTING(No.)
                                ORDER(Ascending);
            RequestFilterFields = "No.", "Date Filter";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(Filtros; Filtros)
            {
            }
            column(Item__No__; "No.")
            {
            }
            column(Item_Description; Description)
            {
            }
            column(VtasTotAnoAntesQueAnt; VtasTotAnoAntesQueAnt)
            {
            }
            column(VetTotAnoAnt; VetTotAnoAnt)
            {
            }
            column(CantVendAcAlMom; CantVendAcAlMom)
            {
            }
            column(CantConsAcumAlMom; CantConsAcumAlMom)
            {
            }
            column(PrespVta; PrespVta)
            {
            }
            column(CantFaltaPorVend; CantFaltaPorVend)
            {
            }
            column(Item__Safety_Stock_Quantity_; "Safety Stock Quantity")
            {
            }
            column(Item_Inventory; Inventory)
            {
            }
            column(AlarmBalInv; AlarmBalInv)
            {
            }
            column(Item__Qty__on_Purch__Order_; "Qty. on Purch. Order")
            {
            }
            column(Item__Qty__on_Sales_Order_; "Qty. on Sales Order")
            {
            }
            column(EnBackOrder; EnBackOrder)
            {
            }
            column(Inventory____Qty__on_Sales_Order____CantConsAcumAlMom; Inventory - "Qty. on Sales Order" - CantConsAcumAlMom)
            {
            }
            column(Item__Unit_Cost_; "Unit Cost")
            {
            }
            column(ValorInv; ValorInv)
            {
            }
            column(VtasTotAnoAntesQueAnt_Control1000000013; VtasTotAnoAntesQueAnt)
            {
            }
            column(VetTotAnoAnt_Control1000000014; VetTotAnoAnt)
            {
            }
            column(CantVendAcAlMom_Control1000000016; CantVendAcAlMom)
            {
            }
            column(CantConsAcumAlMom_Control1000000019; CantConsAcumAlMom)
            {
            }
            column(PrespVta_Control1000000022; PrespVta)
            {
            }
            column(CantFaltaPorVend_Control1000000025; CantFaltaPorVend)
            {
            }
            column(AlarmBalInv_Control1000000031; AlarmBalInv)
            {
            }
            column(Item_Inventory_Control1000000034; Inventory)
            {
            }
            column(EnOrdenDeCompra; EnOrdenDeCompra)
            {
            }
            column(EnOrdenVenta; EnOrdenVenta)
            {
            }
            column(EnBackOrder_Control1000000043; EnBackOrder)
            {
            }
            column(CantDisp; CantDisp)
            {
            }
            column(ValorInv_Control1000000049; ValorInv)
            {
            }
            column(InventoryCaption; InventoryCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(Filters_Caption; Filters_CaptionLbl)
            {
            }
            column(Item_No_Caption; Item_No_CaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(Book_TypeCaption; Book_TypeCaptionLbl)
            {
            }
            column(Total_Sales_Year_before_the_previous__N_1_Caption; Total_Sales_Year_before_the_previous__N_1_CaptionLbl)
            {
            }
            column(Total_Sales_Last_Year__N_Caption; Total_Sales_Last_Year__N_CaptionLbl)
            {
            }
            column(Quantity_Sold__Accumulated_Caption; Quantity_Sold__Accumulated_CaptionLbl)
            {
            }
            column(Consignment_Quantity__Accumulated_Caption; Consignment_Quantity__Accumulated_CaptionLbl)
            {
            }
            column(Sales_BudgetCaption; Sales_BudgetCaptionLbl)
            {
            }
            column(Qty__Remaining_for_SaleCaption; Qty__Remaining_for_SaleCaptionLbl)
            {
            }
            column(Safety_Stock_QuantityCaption; Safety_Stock_QuantityCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(Inventory_Balance_AlarmCaption; Inventory_Balance_AlarmCaptionLbl)
            {
            }
            column(In_Purch__OrderCaption; In_Purch__OrderCaptionLbl)
            {
            }
            column(In_Sales_OrderCaption; In_Sales_OrderCaptionLbl)
            {
            }
            column(In_Back_OrderCaption; In_Back_OrderCaptionLbl)
            {
            }
            column(Available_Qty_Caption; Available_Qty_CaptionLbl)
            {
            }
            column(Unit_CostCaption; Unit_CostCaptionLbl)
            {
            }
            column(Inventory_ValueCaption; Inventory_ValueCaptionLbl)
            {
            }
            column(Total_Caption; Total_CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                VtasTotAnoAntesQueAnt := 0;
                VetTotAnoAnt := 0;
                CantVendAcAlMom := 0;
                CantConsAcumAlMom := 0;
                PrespVta := 0;
                CantFaltaPorVend := 0;
                SafStock := 0;
                Balance := 0;
                EnOrdenDeCompra := 0;
                EnOrdenVenta := 0;
                EnBackOrder := 0;
                CantDisp := 0;
                CostoDeUnid := 0;
                ValorInv := 0;
                AlarmBalInv := 0;


                //Ventas Totales Año antes que el anterior
                ILE.RESET;
                ILE.SETCURRENTKEY("Item No.", "Posting Date");
                ILE.SETRANGE("Item No.", "No.");
                ILE.SETRANGE("Posting Date", FechaIniAnantAlAnt, FechaFinAnantAlAnt);
                ILE.SETRANGE("Entry Type", ILE."Entry Type"::Sale);
                IF ILE.FINDSET THEN
                    REPEAT
                        VtasTotAnoAntesQueAnt += -1 * ILE.Quantity;
                    UNTIL ILE.NEXT = 0;

                //Ventas Totales Año anterior
                ILE.RESET;
                ILE.SETCURRENTKEY("Item No.", "Posting Date");
                ILE.SETRANGE("Item No.", "No.");
                ILE.SETRANGE("Posting Date", FechaIniAnant, FechaFinAnant);
                ILE.SETRANGE("Entry Type", ILE."Entry Type"::Sale);
                IF ILE.FINDSET THEN
                    REPEAT
                        VetTotAnoAnt += -1 * ILE.Quantity;
                    UNTIL ILE.NEXT = 0;

                //Ventas Totales Año Actual
                ILE.RESET;
                ILE.SETCURRENTKEY("Item No.", "Posting Date");
                ILE.SETRANGE("Item No.", "No.");
                ILE.SETRANGE("Posting Date", FechaIniAnoAct, FechaFinAnoAct);
                ILE.SETRANGE("Entry Type", ILE."Entry Type"::Sale);
                IF ILE.FINDSET THEN
                    REPEAT
                        CantVendAcAlMom += -1 * ILE.Quantity;
                    UNTIL ILE.NEXT = 0;

                //Consignacion por almacen
                Loc.RESET;
                Loc.SETFILTER(Loc."Cod. Cliente", '<>%1', '');
                IF Loc.FINDSET THEN
                    REPEAT
                        Item1.RESET;
                        Item1.SETRANGE(Item1."No.", "No.");
                        Item1.SETRANGE("Location Filter", Loc.Code);
                        IF Item1.FINDSET THEN
                            REPEAT
                                Item1.CALCFIELDS(Inventory);
                                CantConsAcumAlMom += Item1.Inventory;
                            UNTIL Item1.NEXT = 0;
                    UNTIL Loc.NEXT = 0;

                //Cantidad que falta por vender
                CantFaltaPorVend := PrespVta - CantConsAcumAlMom - CantVendAcAlMom;

                //en orden de compra
                EnOrdenDeCompra += "Qty. on Purch. Order";

                //en pedidos de venta
                EnOrdenVenta += "Qty. on Sales Order";

                //Canitdad disponible
                CantDisp += Inventory - "Qty. on Sales Order" - CantConsAcumAlMom;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CREATETOTALS(VtasTotAnoAntesQueAnt, VetTotAnoAnt, CantVendAcAlMom, CantConsAcumAlMom, PrespVta, CantFaltaPorVend, SafStock,
                                         Balance);

                FechaIniAnoAct := GETRANGEMIN("Date Filter");
                FechaFinAnoAct := GETRANGEMAX("Date Filter");

                FechaIniAnantAlAnt := CALCDATE(Dos, FechaIniAnoAct);
                FechaFinAnantAlAnt := CALCDATE(Dos, FechaFinAnoAct);

                FechaIniAnant := CALCDATE(Uno, FechaIniAnoAct);
                FechaFinAnant := CALCDATE(Uno, FechaFinAnoAct);

                Filtros := Item.GETFILTERS;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        VtasTotAnoAntesQueAnt: Decimal;
        VetTotAnoAnt: Decimal;
        CantVendAcAlMom: Decimal;
        CantConsAcumAlMom: Decimal;
        PrespVta: Decimal;
        CantFaltaPorVend: Decimal;
        SafStock: Decimal;
        Balance: Decimal;
        EnOrdenDeCompra: Decimal;
        EnOrdenVenta: Decimal;
        EnBackOrder: Decimal;
        CantDisp: Decimal;
        CostoDeUnid: Decimal;
        ValorInv: Decimal;
        AlarmBalInv: Decimal;
        ILE: Record 32;
        FechaIniAnoAct: Date;
        FechaFinAnoAct: Date;
        FechaIniAnant: Date;
        FechaFinAnant: Date;
        FechaIniAnantAlAnt: Date;
        FechaFinAnantAlAnt: Date;
        Loc: Record 14;
        Item1: Record 27;
        Filtros: Text[500];
        Dos: Label '-2Y';
        Uno: Label '-1Y';
        InventoryCaptionLbl: Label 'Inventory';
        PageCaptionLbl: Label 'Page';
        Filters_CaptionLbl: Label 'Filters:';
        Item_No_CaptionLbl: Label 'Item No.';
        DescriptionCaptionLbl: Label 'Description';
        Book_TypeCaptionLbl: Label 'Book Type';
        Total_Sales_Year_before_the_previous__N_1_CaptionLbl: Label 'Total Sales Year before the previous (N-1)';
        Total_Sales_Last_Year__N_CaptionLbl: Label 'Total Sales Last Year (N)';
        Quantity_Sold__Accumulated_CaptionLbl: Label 'Quantity Sold (Accumulated)';
        Consignment_Quantity__Accumulated_CaptionLbl: Label 'Consignment Quantity (Accumulated)';
        Sales_BudgetCaptionLbl: Label 'Sales Budget';
        Qty__Remaining_for_SaleCaptionLbl: Label 'Qty. Remaining for Sale';
        Safety_Stock_QuantityCaptionLbl: Label 'Safety Stock Quantity';
        BalanceCaptionLbl: Label 'Balance';
        Inventory_Balance_AlarmCaptionLbl: Label 'Inventory Balance Alarm';
        In_Purch__OrderCaptionLbl: Label 'In Purch. Order';
        In_Sales_OrderCaptionLbl: Label 'In Sales Order';
        In_Back_OrderCaptionLbl: Label 'In Back Order';
        Available_Qty_CaptionLbl: Label 'Available Qty.';
        Unit_CostCaptionLbl: Label 'Unit Cost';
        Inventory_ValueCaptionLbl: Label 'Inventory Value';
        Total_CaptionLbl: Label 'Total:';
}

