pageextension 50002 EXCCRISalespersonsPurchasers extends "Salespersons/Purchasers"
{
    layout
    {
        addafter("Phone No.")
        {
            field(EXCCRIJobTitle; Rec."Job Title")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the job title of the salesperson or purchaser.';
            }
            field(EXCCRIType; Rec.Tipo)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the custom type assigned to the salesperson or purchaser.';
            }
            field(EXCCRIEmail; Rec."E-Mail")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the email address of the salesperson or purchaser.';
            }
            field(EXCCRICollector; Rec.Collector)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the salesperson or purchaser acts as a collector.';
            }
            field(EXCCRIRoute; Rec.Ruta)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the route assigned to the salesperson or purchaser.';
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            group(EXCCRISalesperson)
            {
                Caption = 'Salesperson';
                Image = SalesPerson;

                action(EXCCRISalesBudget)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Budget';
                    Image = LedgerBudget;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Opens the sales budget filtered by the selected salesperson.';

                    trigger OnAction()
                    begin
                        Rec.TestField(Tipo, 0);
                        EXCCRISalesBudget.SetRange("Cod. Promotor", Rec.Code);
                        EXCCRISalesBudgetPage.SetTableView(EXCCRISalesBudget);
                        EXCCRISalesBudgetPage.RunModal();
                        Clear(EXCCRISalesBudgetPage);
                    end;
                }
                action(EXCCRISampleBudget)
                {
                    ApplicationArea = All;
                    Caption = 'Sample Budget';
                    Image = LedgerBudget;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Opens the sample budget filtered by the selected salesperson.';

                    trigger OnAction()
                    begin
                        Rec.TestField(Tipo, 0);
                        EXCCRISampleBudget.SetRange("Cod. Promotor", Rec.Code);
                        EXCCRISampleBudgetPage.SetTableView(EXCCRISampleBudget);
                        EXCCRISampleBudgetPage.RunModal();
                        Clear(EXCCRISampleBudgetPage);
                    end;
                }
                action(EXCCRILevels)
                {
                    ApplicationArea = All;
                    Caption = 'Levels';
                    Image = BOMLevel;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Opens the levels configured for the selected salesperson.';

                    trigger OnAction()
                    begin
                        Rec.TestField(Tipo, 0);
                        EXCCRILevelsRecord.SetRange("Cod. Promotor", Rec.Code);
                        EXCCRILevelsPage.SetTableView(EXCCRILevelsRecord);
                        EXCCRILevelsPage.RunModal();
                        Clear(EXCCRILevelsPage);
                    end;
                }
                group(EXCCRIPlanning)
                {
                    Caption = 'Planning';

                    action(EXCCRIPlan)
                    {
                        ApplicationArea = All;
                        Caption = 'Plan';
                        Image = CreateReminders;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        ToolTip = 'Opens visit planning for the selected salesperson.';

                        trigger OnAction()
                        begin
                            EXCCRIVisitPlanning.Reset();
                            EXCCRIVisitPlanning.SetRange("Cod. Promotor", Rec.Code);
                            EXCCRIVisitPlanning.FindSet();

                            EXCCRIVisitPlanningPage.RecibeParametros(Rec.Code);
                            EXCCRIVisitPlanningPage.RunModal();
                            Clear(EXCCRIVisitPlanningPage);
                        end;
                    }
                    action(EXCCRIExecution)
                    {
                        ApplicationArea = All;
                        Caption = 'Execution';
                        Image = ReceiptReminder;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        ToolTip = 'Opens visit execution for the selected salesperson.';

                        trigger OnAction()
                        begin
                            EXCCRIVisitExecutionPage.RecibeParametros(Rec.Code);
                            EXCCRIVisitExecutionPage.RunModal();
                            Clear(EXCCRIVisitExecutionPage);
                        end;
                    }
                    action(EXCCRIConsult)
                    {
                        ApplicationArea = All;
                        Caption = 'Consult';
                        Image = AnalysisView;
                        Promoted = true;
                        PromotedCategory = Process;
                        ToolTip = 'Opens visit execution in read-only mode for the selected salesperson.';

                        trigger OnAction()
                        begin
                            EXCCRIVisitExecution.Reset();
                            EXCCRIVisitExecution.SetRange("Cod. Promotor", Rec.Code);
                            if not EXCCRIVisitExecution.FindFirst() then begin
                                Clear(EXCCRIVisitExecution);
                                EXCCRIVisitExecution.Validate("Cod. Promotor", Rec.Code);
                                if EXCCRIVisitExecution.Insert(true) then
                                    Commit();
                            end;

                            EXCCRIVisitExecutionPage.SetTableView(EXCCRIVisitExecution);
                            EXCCRIVisitExecutionPage.Editable(false);
                            EXCCRIVisitExecutionPage.RunModal();
                            Clear(EXCCRIVisitExecutionPage);
                        end;
                    }
                }
                action(EXCCRITechnicalAssistance)
                {
                    ApplicationArea = All;
                    Caption = 'Technical Assistance Request';
                    Image = Replan;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Opens a technical assistance request for the selected salesperson.';

                    trigger OnAction()
                    var
                        EXCCRIAssistanceRequestPage: Page 67090;
                    begin
                        EXCCRIAssistanceRequestPage.RecibeParam(Rec.Code);
                        EXCCRIAssistanceRequestPage.RunModal();
                        Clear(EXCCRIAssistanceRequestPage);
                    end;
                }
                action(EXCCRIRoutes)
                {
                    ApplicationArea = All;
                    Caption = 'Route';
                    Image = Route;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Opens the routes assigned to the selected salesperson.';

                    trigger OnAction()
                    begin
                        Rec.TestField(Tipo, 0);
                        EXCCRIRoutesRecord.SetRange("Cod. Promotor", Rec.Code);
                        EXCCRIRoutesPage.SetTableView(EXCCRIRoutesRecord);
                        EXCCRIRoutesPage.RunModal();
                        Clear(EXCCRIRoutesPage);
                    end;
                }
                action(EXCCRISamples)
                {
                    ApplicationArea = All;
                    Caption = 'Samples';
                    Image = NewTransferOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Opens the sample deliveries for the selected salesperson in read-only mode.';

                    trigger OnAction()
                    begin
                        Rec.TestField(Tipo, 0);
                        EXCCRISampleDelivery.SetRange("Cod. Promotor", Rec.Code);
                        EXCCRISampleDeliveryPage.SetTableView(EXCCRISampleDelivery);
                        EXCCRISampleDeliveryPage.Editable(false);
                        EXCCRISampleDeliveryPage.RunModal();
                        Clear(EXCCRISampleDeliveryPage);
                    end;
                }
                action(EXCCRISchools)
                {
                    ApplicationArea = All;
                    Caption = 'Schools';
                    Image = AddToHome;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67079;
                    RunPageLink = "Cod. Promotor" = field(Code);
                    ToolTip = 'Opens the schools assigned to the selected salesperson.';
                }
                action(EXCCRITeachers)
                {
                    ApplicationArea = All;
                    Caption = 'Teachers';
                    Image = EditCustomer;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67078;
                    RunPageLink = "Cod. Promotor" = field(Code);
                    ToolTip = 'Opens the teachers assigned to the selected salesperson.';
                }
            }
        }
    }

    var
        EXCCRISalesBudget: Record 67027;
        EXCCRISampleBudget: Record 67028;
        EXCCRILevelsRecord: Record 67040;
        EXCCRIVisitPlanning: Record 67023;
        EXCCRIVisitExecution: Record 67023;
        EXCCRISampleDelivery: Record 67039;
        EXCCRIRoutesRecord: Record 67044;
        EXCCRISalesBudgetPage: Page 67027;
        EXCCRISampleBudgetPage: Page 67028;
        EXCCRIVisitPlanningPage: Page 67097;
        EXCCRIVisitExecutionPage: Page 67098;
        EXCCRISampleDeliveryPage: Page 67039;
        EXCCRILevelsPage: Page 67050;
        EXCCRIRoutesPage: Page 67048;
}
