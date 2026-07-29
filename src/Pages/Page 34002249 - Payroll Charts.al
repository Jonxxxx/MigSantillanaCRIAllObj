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
                ApplicationArea = Basic, Suite;
                Caption = 'Select Chart';
                Image = SelectChart;
                ToolTip = 'Select the analysis report that the chart will be based on.';

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
                    ApplicationArea = Basic, Suite;
                    Caption = 'Day';
                    ToolTip = 'Each stack covers one day.';

                    trigger OnAction()
                    begin
                        AnalysisReportChartSetup.SetPeriodLength(AnalysisReportChartSetup."Period Length"::Day);
                        // TODO: Manual review - The legacy option-qualified chart refresh argument is unavailable in this action and is incompatible with the current chart API.
                        // Original code: UpdateChart(Period::" ");
                    end;
                }
                action(Week)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Week';
                    ToolTip = 'Each stack except for the last stack covers one week. The last stack contains data from the start of the week until the date that is defined by the Show option.';

                    trigger OnAction()
                    begin
                        AnalysisReportChartSetup.SetPeriodLength(AnalysisReportChartSetup."Period Length"::Week);
                        // TODO: Manual review - The legacy option-qualified chart refresh argument is unavailable in this action and is incompatible with the current chart API.
                        // Original code: UpdateChart(Period::" ");
                    end;
                }
                action(Month)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Month';
                    ToolTip = 'Each stack except for the last stack covers one month. The last stack contains data from the start of the month until the date that is defined by the Show option.';

                    trigger OnAction()
                    begin
                        AnalysisReportChartSetup.SetPeriodLength(AnalysisReportChartSetup."Period Length"::Month);
                        // TODO: Manual review - The legacy option-qualified chart refresh argument is unavailable in this action and is incompatible with the current chart API.
                        // Original code: UpdateChart(Period::" ");
                    end;
                }
                action(Quarter)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Quarter';
                    ToolTip = 'Each stack except for the last stack covers one quarter. The last stack contains data from the start of the quarter until the date that is defined by the Show option.';

                    trigger OnAction()
                    begin
                        AnalysisReportChartSetup.SetPeriodLength(AnalysisReportChartSetup."Period Length"::Quarter);
                        // TODO: Manual review - The legacy option-qualified chart refresh argument is unavailable in this action and is incompatible with the current chart API.
                        // Original code: UpdateChart(Period::" ");
                    end;
                }
                action(Year)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Year';
                    ToolTip = 'Each stack except for the last stack covers one year. The last stack contains data from the start of the year until the date that is defined by the Show option.';

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
                ApplicationArea = Basic, Suite;
                Caption = 'Previous';
                Image = PreviousRecord;
                ToolTip = 'Show the information based on the previous period. If you set the View by field to Day, the date filter changes to the day before.';

                trigger OnAction()
                begin
                    // TODO: Manual review - The legacy Previous option value cannot be referenced safely from this trigger with the current chart refresh signature.
                    // Original code: UpdateChart(Period::Previous);
                end;
            }
            action(NextPeriod)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Next';
                Image = NextRecord;
                ToolTip = 'Show the information based on the next period.';

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

