page 34002242 "DSNOM HR Chart"
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
                ApplicationArea = Basic, Suite;
                Caption = 'Status Text';
                Editable = false;
                ShowCaption = false;
                ToolTip = 'Specifies the status of the chart.';
            }
            usercontrol(BusinessChart; "Microsoft.Dynamics.Nav.Client.BusinessChart")
            {
                ApplicationArea = Basic, Suite;
                //TODO: Ver
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
                    ApplicationArea = Basic, Suite;
                    Caption = 'All Orders';
                    Enabled = AllOrdersEnabled;
                    ToolTip = 'View all not fully posted sales orders, including sales orders with document dates in the future because of long delivery times, delays, or other reasons.';

                    trigger OnAction()
                    begin
                        TrailingSalesOrdersSetup.SetShowOrders(TrailingSalesOrdersSetup."Show Orders"::"All Orders");
                        UpdateStatus;
                    end;
                }
                action(OrdersUntilToday)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Orders Until Today';
                    Enabled = OrdersUntilTodayEnabled;
                    ToolTip = 'View not fully posted sales orders with document dates up until today''s date.';

                    trigger OnAction()
                    begin
                        TrailingSalesOrdersSetup.SetShowOrders(TrailingSalesOrdersSetup."Show Orders"::"Orders Until Today");
                        UpdateStatus;
                    end;
                }
                action(DelayedOrders)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Delayed Orders';
                    Enabled = DelayedOrdersEnabled;
                    ToolTip = 'View not fully posted sales orders with shipment dates that are before today''s date.';

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
                    ApplicationArea = Basic, Suite;
                    Caption = 'Day';
                    Enabled = DayEnabled;
                    ToolTip = 'Each stack covers one day.';

                    trigger OnAction()
                    begin
                        TrailingSalesOrdersSetup.SetPeriodLength(TrailingSalesOrdersSetup."Period Length"::Day);
                        UpdateStatus;
                    end;
                }
                action(Week)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Week';
                    Enabled = WeekEnabled;
                    ToolTip = 'Each stack except for the last stack covers one week. The last stack contains data from the start of the week until the date that is defined by the Show option.';

                    trigger OnAction()
                    begin
                        TrailingSalesOrdersSetup.SetPeriodLength(TrailingSalesOrdersSetup."Period Length"::Week);
                        UpdateStatus;
                    end;
                }
                action(Month)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Month';
                    Enabled = MonthEnabled;
                    ToolTip = 'Each stack except for the last stack covers one month. The last stack contains data from the start of the month until the date that is defined by the Show option.';

                    trigger OnAction()
                    begin
                        TrailingSalesOrdersSetup.SetPeriodLength(TrailingSalesOrdersSetup."Period Length"::Month);
                        UpdateStatus;
                    end;
                }
                action(Quarter)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Quarter';
                    Enabled = QuarterEnabled;
                    ToolTip = 'Each stack except for the last stack covers one quarter. The last stack contains data from the start of the quarter until the date that is defined by the Show option.';

                    trigger OnAction()
                    begin
                        TrailingSalesOrdersSetup.SetPeriodLength(TrailingSalesOrdersSetup."Period Length"::Quarter);
                        UpdateStatus;
                    end;
                }
                action(Year)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Year';
                    Enabled = YearEnabled;
                    ToolTip = 'Each stack except for the last stack covers one year. The last stack contains data from the start of the year until the date that is defined by the Show option.';

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
                        ApplicationArea = Basic, Suite;
                        Caption = 'Amount';
                        Enabled = AmountEnabled;
                        ToolTip = 'The Y-axis shows the totaled $ amount of the orders.';

                        trigger OnAction()
                        begin
                            TrailingSalesOrdersSetup.SetValueToCalcuate(TrailingSalesOrdersSetup."Value to Calculate"::"Amount Excl. VAT");
                            UpdateStatus;
                        end;
                    }
                    action(NoofOrders)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'No. of Orders';
                        Enabled = NoOfOrdersEnabled;
                        ToolTip = 'The Y-axis shows the number of orders.';

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
                        ApplicationArea = Basic, Suite;
                        Caption = 'Stacked Area';
                        Enabled = StackedAreaEnabled;
                        ToolTip = 'View the data in area layout.';

                        trigger OnAction()
                        begin
                            TrailingSalesOrdersSetup.SetChartType(TrailingSalesOrdersSetup."Chart Type"::"Stacked Area");
                            UpdateStatus;
                        end;
                    }
                    action(StackedAreaPct)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Stacked Area (%)';
                        Enabled = StackedAreaPctEnabled;
                        ToolTip = 'view the percentage distribution of the four order statuses in area layout.';

                        trigger OnAction()
                        begin
                            TrailingSalesOrdersSetup.SetChartType(TrailingSalesOrdersSetup."Chart Type"::"Stacked Area (%)");
                            UpdateStatus;
                        end;
                    }
                    action(StackedColumn)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Stacked Column';
                        Enabled = StackedColumnEnabled;
                        ToolTip = 'view the data in column layout.';

                        trigger OnAction()
                        begin
                            TrailingSalesOrdersSetup.SetChartType(TrailingSalesOrdersSetup."Chart Type"::"Stacked Column");
                            UpdateStatus;
                        end;
                    }
                    action(StackedColumnPct)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Stacked Column (%)';
                        Enabled = StackedColumnPctEnabled;
                        ToolTip = 'view the percentage distribution of the four order statuses in column layout.';

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
                ApplicationArea = Basic, Suite;
                Caption = 'Setup';
                Image = Setup;
                ToolTip = 'Specify if the chart will be based on a work date other than today''s date. This is mainly relevant in demonstration databases with fictitious sales orders.';

                trigger OnAction()
                begin
                    RunSetup;
                end;
            }
        }
    }

    trigger OnFindRecord(Which: Text): Boolean
    begin
        //TODO: Ver UpdateChart;
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
        //TODO: Ver Update(CurrPage.BusinessChart);
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

