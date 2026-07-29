page 34002249 "Payroll Charts"
{
    Caption = 'Sales Performance';
    PageType = CardPart;
    SourceTable = 485;

    layout
    {
        area(content)
        {
            field(StatusText; StatusText)
            {
                ApplicationArea = All;
                Enabled = false;
                ShowCaption = false;
                Style = StrongAccent;
                StyleExpr = TRUE;
                ToolTip = 'Specifies the status of the chart.';
            }
            usercontrol(BusinessChart; "Microsoft.Dynamics.Nav.Client.BusinessChart")
            {
                ApplicationArea = Basic, Suite;

                trigger AddInReady()
                begin
                    // TODO: Manual review - The legacy option-qualified chart refresh argument is unavailable in this trigger and is incompatible with the current chart API.
                    // Original code: UpdateChart(Period::" ");
                end;

                trigger Refresh()
                begin
                    InitializePeriodFilter(0D, 0D);
                    // TODO: Manual review - The legacy option-qualified chart refresh argument is unavailable in this trigger and is incompatible with the current chart API.
                    // Original code: UpdateChart(Period::" ");
                end;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(SelectChart)
            {
                ApplicationArea = All;
                Caption = 'Select Chart';
                ToolTip = 'Select Chart';
                Image = SelectChart;

                trigger OnAction()
                begin
                    // TODO: Manual review - The verified SelectChart call cannot be restored with the legacy chart refresh call because the current Business Chart API rejects that refresh argument.
                    // Original code preserved below.
                    // IF AnalysisReportChartMgt.SelectChart(AnalysisReportChartSetup, Rec) THEN
                    //     UpdateChart(Period::" ");
                end;
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
                    trigger OnAction()
                    begin
                        AnalysisReportChartSetup.SetPeriodLength(AnalysisReportChartSetup."Period Length"::Day);
                        // TODO: Manual review - The legacy option-qualified chart refresh argument is unavailable in this action and is incompatible with the current chart API.
                        // Original code: UpdateChart(Period::" ");
                    end;
                }
                action(Week)
                {

                    ApplicationArea = All;
                    Caption = 'Week';
                    ToolTip = 'Week';
                    trigger OnAction()
                    begin
                        AnalysisReportChartSetup.SetPeriodLength(AnalysisReportChartSetup."Period Length"::Week);
                        // TODO: Manual review - The legacy option-qualified chart refresh argument is unavailable in this action and is incompatible with the current chart API.
                        // Original code: UpdateChart(Period::" ");
                    end;
                }
                action(Month)
                {

                    ApplicationArea = All;
                    Caption = 'Month';
                    ToolTip = 'Month';
                    trigger OnAction()
                    begin
                        AnalysisReportChartSetup.SetPeriodLength(AnalysisReportChartSetup."Period Length"::Month);
                        // TODO: Manual review - The legacy option-qualified chart refresh argument is unavailable in this action and is incompatible with the current chart API.
                        // Original code: UpdateChart(Period::" ");
                    end;
                }
                action(Quarter)
                {

                    ApplicationArea = All;
                    Caption = 'Quarter';
                    ToolTip = 'Quarter';
                    trigger OnAction()
                    begin
                        AnalysisReportChartSetup.SetPeriodLength(AnalysisReportChartSetup."Period Length"::Quarter);
                        // TODO: Manual review - The legacy option-qualified chart refresh argument is unavailable in this action and is incompatible with the current chart API.
                        // Original code: UpdateChart(Period::" ");
                    end;
                }
                action(Year)
                {

                    ApplicationArea = All;
                    Caption = 'Year';
                    ToolTip = 'Year';
                    trigger OnAction()
                    begin
                        AnalysisReportChartSetup.SetPeriodLength(AnalysisReportChartSetup."Period Length"::Year);
                        // TODO: Manual review - The legacy option-qualified chart refresh argument is unavailable in this action and is incompatible with the current chart API.
                        // Original code: UpdateChart(Period::" ");
                    end;
                }
            }
            action(PreviousPeriod)
            {
                ApplicationArea = All;
                Caption = 'Previous';
                ToolTip = 'Previous';
                Image = PreviousRecord;

                trigger OnAction()
                begin
                    // TODO: Manual review - The legacy Previous option value cannot be referenced safely from this trigger with the current chart refresh signature.
                    // Original code: UpdateChart(Period::Previous);
                end;
            }
            action(NextPeriod)
            {
                ApplicationArea = All;
                Caption = 'Next';
                ToolTip = 'Next';
                Image = NextRecord;

                trigger OnAction()
                begin
                    // TODO: Manual review - The legacy Next option value cannot be referenced safely from this trigger with the current chart refresh signature.
                    // Original code: UpdateChart(Period::Next);
                end;
            }
        }
    }

    var
        AnalysisReportChartSetup: Record 770;
        AnalysisReportChartMgt: Codeunit 770;
        StatusText: Text[250];
        Period: Option " ",Next,Previous;

    local procedure UpdateChart(Period: Option ,Next,Previous)
    begin
        AnalysisReportChartMgt.UpdateChart(
          Period, AnalysisReportChartSetup, AnalysisReportChartSetup."Analysis Area"::Sales, Rec, StatusText);
        // TODO: Manual review - The legacy Business Chart Update call has no verified current control-add-in signature.
        // Original code: Update(CurrPage.BusinessChart);
    end;
}

