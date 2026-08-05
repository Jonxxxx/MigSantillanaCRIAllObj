page 55882 "DSNOM HR Chart"
{
    Caption = 'Trailing Sales Orders';
    PageType = CardPart;
    SourceTable = 485;

    layout
    {
        area(content)
        {
            field(StatusText; StatusText)
            {
                ApplicationArea = All;
                Caption = 'Status Text';
                Editable = false;
                ShowCaption = false;
                ToolTip = 'Specifies the status of the chart.';
            }
            usercontrol(BusinessChart; "Microsoft.Dynamics.Nav.Client.BusinessChart")
            {
                ApplicationArea = All;
                // TODO: Manual review - The disabled chart event block uses DotNet BusinessChartDataPoint, which is unsupported in Business Central SaaS.
                /*

                trigger DataPointClicked(point: DotNet BusinessChartDataPoint)
                begin
                    SetDrillDownIndexes(point);
                    TrailingSalesOrdersMgt.DrillDown(Rec);
                end;

                trigger DataPointDoubleClicked(point: DotNet BusinessChartDataPoint)
                begin
                end;

                trigger AddInReady()
                begin
                    IsChartAddInReady := TRUE;
                    TrailingSalesOrdersMgt.OnOpenPage(TrailingSalesOrdersSetup);
                    UpdateStatus;
                    IF IsChartDataReady THEN
                        UpdateChart;
                end;

                trigger Refresh()
                begin
                    IF IsChartAddInReady AND IsChartDataReady THEN BEGIN
                        NeedsUpdate := TRUE;
                        UpdateChart
                    END;
                end;
                */
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Show)
            {
                Caption = 'Show';
                Image = View;
                action(AllOrders)
                {
                    ApplicationArea = All;
                    Caption = 'All Orders';
                    ToolTip = 'All Orders';
                    Enabled = AllOrdersEnabled;

                    trigger OnAction()
                    begin
                        TrailingSalesOrdersSetup.SetShowOrders(TrailingSalesOrdersSetup."Show Orders"::"All Orders");
                        UpdateStatus;
                    end;
                }
                action(OrdersUntilToday)
                {
                    ApplicationArea = All;
                    Caption = 'Orders Until Today';
                    ToolTip = 'Orders Until Today';
                    Enabled = OrdersUntilTodayEnabled;

                    trigger OnAction()
                    begin
                        TrailingSalesOrdersSetup.SetShowOrders(TrailingSalesOrdersSetup."Show Orders"::"Orders Until Today");
                        UpdateStatus;
                    end;
                }
                action(DelayedOrders)
                {
                    ApplicationArea = All;
                    Caption = 'Delayed Orders';
                    ToolTip = 'Delayed Orders';
                    Enabled = DelayedOrdersEnabled;

                    trigger OnAction()
                    begin
                        TrailingSalesOrdersSetup.SetShowOrders(TrailingSalesOrdersSetup."Show Orders"::"Delayed Orders");
                        UpdateStatus;
                    end;
                }
            }
            group(PeriodLength)
            {
                Caption = 'Period Length';
                Image = Period;
                action(Day)
                {
                    ApplicationArea = All;
                    Caption = 'Day';
                    ToolTip = 'Day';
                    Enabled = DayEnabled;

                    trigger OnAction()
                    begin
                        TrailingSalesOrdersSetup.SetPeriodLength(TrailingSalesOrdersSetup."Period Length"::Day);
                        UpdateStatus;
                    end;
                }
                action(Week)
                {
                    ApplicationArea = All;
                    Caption = 'Week';
                    ToolTip = 'Week';
                    Enabled = WeekEnabled;

                    trigger OnAction()
                    begin
                        TrailingSalesOrdersSetup.SetPeriodLength(TrailingSalesOrdersSetup."Period Length"::Week);
                        UpdateStatus;
                    end;
                }
                action(Month)
                {
                    ApplicationArea = All;
                    Caption = 'Month';
                    ToolTip = 'Month';
                    Enabled = MonthEnabled;

                    trigger OnAction()
                    begin
                        TrailingSalesOrdersSetup.SetPeriodLength(TrailingSalesOrdersSetup."Period Length"::Month);
                        UpdateStatus;
                    end;
                }
                action(Quarter)
                {
                    ApplicationArea = All;
                    Caption = 'Quarter';
                    ToolTip = 'Quarter';
                    Enabled = QuarterEnabled;

                    trigger OnAction()
                    begin
                        TrailingSalesOrdersSetup.SetPeriodLength(TrailingSalesOrdersSetup."Period Length"::Quarter);
                        UpdateStatus;
                    end;
                }
                action(Year)
                {
                    ApplicationArea = All;
                    Caption = 'Year';
                    ToolTip = 'Year';
                    Enabled = YearEnabled;

                    trigger OnAction()
                    begin
                        TrailingSalesOrdersSetup.SetPeriodLength(TrailingSalesOrdersSetup."Period Length"::Year);
                        UpdateStatus;
                    end;
                }
            }
            group(Options)
            {
                Caption = 'Options';
                Image = SelectChart;
                group(ValueToCalculate)
                {
                    Caption = 'Value to Calculate';
                    Image = Calculate;
                    action(Amount)
                    {
                        ApplicationArea = All;
                        Caption = 'Amount';
                        ToolTip = 'Amount';
                        Enabled = AmountEnabled;

                        trigger OnAction()
                        begin
                            TrailingSalesOrdersSetup.SetValueToCalcuate(TrailingSalesOrdersSetup."Value to Calculate"::"Amount Excl. VAT");
                            UpdateStatus;
                        end;
                    }
                    action(NoofOrders)
                    {
                        ApplicationArea = All;
                        Caption = 'No. of Orders';
                        ToolTip = 'No. of Orders';
                        Enabled = NoOfOrdersEnabled;

                        trigger OnAction()
                        begin
                            TrailingSalesOrdersSetup.SetValueToCalcuate(TrailingSalesOrdersSetup."Value to Calculate"::"No. of Orders");
                            UpdateStatus;
                        end;
                    }
                }
                group("Chart Type")
                {
                    Caption = 'Chart Type';
                    Image = BarChart;
                    action(StackedArea)
                    {
                        ApplicationArea = All;
                        Caption = 'Stacked Area';
                        ToolTip = 'Stacked Area';
                        Enabled = StackedAreaEnabled;

                        trigger OnAction()
                        begin
                            TrailingSalesOrdersSetup.SetChartType(TrailingSalesOrdersSetup."Chart Type"::"Stacked Area");
                            UpdateStatus;
                        end;
                    }
                    action(StackedAreaPct)
                    {
                        ApplicationArea = All;
                        Caption = 'Stacked Area (%)';
                        ToolTip = 'Stacked Area (%)';
                        Enabled = StackedAreaPctEnabled;

                        trigger OnAction()
                        begin
                            TrailingSalesOrdersSetup.SetChartType(TrailingSalesOrdersSetup."Chart Type"::"Stacked Area (%)");
                            UpdateStatus;
                        end;
                    }
                    action(StackedColumn)
                    {
                        ApplicationArea = All;
                        Caption = 'Stacked Column';
                        ToolTip = 'Stacked Column';
                        Enabled = StackedColumnEnabled;

                        trigger OnAction()
                        begin
                            TrailingSalesOrdersSetup.SetChartType(TrailingSalesOrdersSetup."Chart Type"::"Stacked Column");
                            UpdateStatus;
                        end;
                    }
                    action(StackedColumnPct)
                    {
                        ApplicationArea = All;
                        Caption = 'Stacked Column (%)';
                        ToolTip = 'Stacked Column (%)';
                        Enabled = StackedColumnPctEnabled;

                        trigger OnAction()
                        begin
                            TrailingSalesOrdersSetup.SetChartType(TrailingSalesOrdersSetup."Chart Type"::"Stacked Column (%)");
                            UpdateStatus;
                        end;
                    }
                }
            }

            action(Setup)
            {
                ApplicationArea = All;
                Caption = 'Setup';
                ToolTip = 'Setup';
                Image = Setup;

                trigger OnAction()
                begin
                    RunSetup;
                end;
            }
        }
    }

    trigger OnFindRecord(Which: Text): Boolean
    begin
        // TODO: Manual review - The legacy parameterless chart refresh binds the current control-add-in overload, which requires a BusinessChart argument.
        // Original code: UpdateChart;
        IsChartDataReady := TRUE;

        IF NOT IsChartAddInReady THEN
            SetActionsEnabled;
    end;

    trigger OnOpenPage()
    begin
        SetActionsEnabled;
    end;

    var
        TrailingSalesOrdersSetup: Record 760;
        OldTrailingSalesOrdersSetup: Record 760;
        TrailingSalesOrdersMgt: Codeunit 760;
        StatusText: Text[250];
        NeedsUpdate: Boolean;
        [InDataSet]
        AllOrdersEnabled: Boolean;
        [InDataSet]
        OrdersUntilTodayEnabled: Boolean;
        [InDataSet]
        DelayedOrdersEnabled: Boolean;
        [InDataSet]
        DayEnabled: Boolean;
        [InDataSet]
        WeekEnabled: Boolean;
        [InDataSet]
        MonthEnabled: Boolean;
        [InDataSet]
        QuarterEnabled: Boolean;
        [InDataSet]
        YearEnabled: Boolean;
        [InDataSet]
        AmountEnabled: Boolean;
        [InDataSet]
        NoOfOrdersEnabled: Boolean;
        [InDataSet]
        StackedAreaEnabled: Boolean;
        [InDataSet]
        StackedAreaPctEnabled: Boolean;
        [InDataSet]
        StackedColumnEnabled: Boolean;
        [InDataSet]
        StackedColumnPctEnabled: Boolean;
        IsChartAddInReady: Boolean;
        IsChartDataReady: Boolean;

    local procedure UpdateChart()
    begin
        IF NOT NeedsUpdate THEN
            EXIT;
        IF NOT IsChartAddInReady THEN
            EXIT;
        TrailingSalesOrdersMgt.UpdateData(Rec);
        // TODO: Manual review - The legacy Business Chart Update call has no verified current control-add-in signature.
        // Original code: Update(CurrPage.BusinessChart);
        UpdateStatus;
        NeedsUpdate := FALSE;
    end;

    local procedure UpdateStatus()
    begin
        NeedsUpdate :=
          NeedsUpdate OR
          (OldTrailingSalesOrdersSetup."Period Length" <> TrailingSalesOrdersSetup."Period Length") OR
          (OldTrailingSalesOrdersSetup."Show Orders" <> TrailingSalesOrdersSetup."Show Orders") OR
          (OldTrailingSalesOrdersSetup."Use Work Date as Base" <> TrailingSalesOrdersSetup."Use Work Date as Base") OR
          (OldTrailingSalesOrdersSetup."Value to Calculate" <> TrailingSalesOrdersSetup."Value to Calculate") OR
          (OldTrailingSalesOrdersSetup."Chart Type" <> TrailingSalesOrdersSetup."Chart Type");

        OldTrailingSalesOrdersSetup := TrailingSalesOrdersSetup;

        IF NeedsUpdate THEN
            StatusText := TrailingSalesOrdersSetup.GetCurrentSelectionText;

        SetActionsEnabled;
    end;

    local procedure RunSetup()
    begin
        PAGE.RUNMODAL(PAGE::"Trailing Sales Orders Setup", TrailingSalesOrdersSetup);
        TrailingSalesOrdersSetup.GET(USERID);
        UpdateStatus;
    end;

    [Scope('Personalization')]
    procedure SetActionsEnabled()
    begin
        AllOrdersEnabled := (TrailingSalesOrdersSetup."Show Orders" <> TrailingSalesOrdersSetup."Show Orders"::"All Orders") AND
          IsChartAddInReady;
        OrdersUntilTodayEnabled :=
          (TrailingSalesOrdersSetup."Show Orders" <> TrailingSalesOrdersSetup."Show Orders"::"Orders Until Today") AND
          IsChartAddInReady;
        DelayedOrdersEnabled := (TrailingSalesOrdersSetup."Show Orders" <> TrailingSalesOrdersSetup."Show Orders"::"Delayed Orders") AND
          IsChartAddInReady;
        DayEnabled := (TrailingSalesOrdersSetup."Period Length" <> TrailingSalesOrdersSetup."Period Length"::Day) AND
          IsChartAddInReady;
        WeekEnabled := (TrailingSalesOrdersSetup."Period Length" <> TrailingSalesOrdersSetup."Period Length"::Week) AND
          IsChartAddInReady;
        MonthEnabled := (TrailingSalesOrdersSetup."Period Length" <> TrailingSalesOrdersSetup."Period Length"::Month) AND
          IsChartAddInReady;
        QuarterEnabled := (TrailingSalesOrdersSetup."Period Length" <> TrailingSalesOrdersSetup."Period Length"::Quarter) AND
          IsChartAddInReady;
        YearEnabled := (TrailingSalesOrdersSetup."Period Length" <> TrailingSalesOrdersSetup."Period Length"::Year) AND
          IsChartAddInReady;
        AmountEnabled :=
          (TrailingSalesOrdersSetup."Value to Calculate" <> TrailingSalesOrdersSetup."Value to Calculate"::"Amount Excl. VAT") AND
          IsChartAddInReady;
        NoOfOrdersEnabled :=
          (TrailingSalesOrdersSetup."Value to Calculate" <> TrailingSalesOrdersSetup."Value to Calculate"::"No. of Orders") AND
          IsChartAddInReady;
        StackedAreaEnabled := (TrailingSalesOrdersSetup."Chart Type" <> TrailingSalesOrdersSetup."Chart Type"::"Stacked Area") AND
          IsChartAddInReady;
        StackedAreaPctEnabled := (TrailingSalesOrdersSetup."Chart Type" <> TrailingSalesOrdersSetup."Chart Type"::"Stacked Area (%)") AND
          IsChartAddInReady;
        StackedColumnEnabled := (TrailingSalesOrdersSetup."Chart Type" <> TrailingSalesOrdersSetup."Chart Type"::"Stacked Column") AND
          IsChartAddInReady;
        StackedColumnPctEnabled :=
          (TrailingSalesOrdersSetup."Chart Type" <> TrailingSalesOrdersSetup."Chart Type"::"Stacked Column (%)") AND
          IsChartAddInReady;
    end;
}

