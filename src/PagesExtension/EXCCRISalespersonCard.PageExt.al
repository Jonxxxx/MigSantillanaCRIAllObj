pageextension 50095 EXCCRISalespersonCard extends "Salesperson/Purchaser Card"
{
    layout
    {
        addlast(General)
        {
            group(EXCCRISantillana)
            {
                Caption = 'Santillana';

                field(EXCCRILocationCode; Rec."Location code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Location code value for the salesperson or purchaser.';
                }
                field(EXCCRITipo; Rec.Tipo)
                {
                    ApplicationArea = All;
                    ValuesAllowed = Vendedor, Cobrador, Supervisor;
                    ToolTip = 'Specifies the Tipo value for the salesperson or purchaser.';
                }
                field(EXCCRIStatus; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Status value for the salesperson or purchaser.';
                }
                field(EXCCRICollector; Rec.Collector)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Collector value for the salesperson or purchaser.';
                }
            }
            group(EXCCRICommunication)
            {
                Caption = 'Communication';

                field(EXCCRIHomePage; Rec."Home Page")
                {
                    ApplicationArea = All;
                    ExtendedDatatype = URL;
                    ToolTip = 'Specifies the Home Page value for the salesperson or purchaser.';
                }
                field(EXCCRIFacebook; Rec.Facebook)
                {
                    ApplicationArea = All;
                    ExtendedDatatype = URL;
                    ToolTip = 'Specifies the Facebook value for the salesperson or purchaser.';
                }
                field(EXCCRIEMail; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the E-Mail value for the salesperson or purchaser.';
                }
                field(EXCCRITwitter; Rec.Twitter)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Twitter value for the salesperson or purchaser.';
                }
                field(EXCCRIBBPin; Rec."BB Pin")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the BB Pin value for the salesperson or purchaser.';
                }
                field(EXCCRIVehicle; Rec.Vehicle)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Vehicle value for the salesperson or purchaser.';
                }
            }
        }
    }

    actions
    {
        addlast(Navigation)
        {
            group(EXCCRISalesperson)
            {
                Caption = 'Salesperson';

                action(EXCCRISalesBudget)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Budget';
                    Image = LedgerBudget;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Opens the sales budget for the salesperson.';

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
                    ToolTip = 'Opens the sample budget for the salesperson.';

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
                    ToolTip = 'Opens the levels assigned to the salesperson.';

                    trigger OnAction()
                    begin
                        Rec.TestField(Tipo, 0);
                        EXCCRILevels.SetRange("Cod. Promotor", Rec.Code);
                        EXCCRILevelsPage.SetTableView(EXCCRILevels);
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
                        ToolTip = 'Opens the visit planning process for the salesperson.';

                        trigger OnAction()
                        begin
                            EXCCRIVisitPlanning.Reset();
                            EXCCRIVisitPlanning.SetRange("Cod. Promotor", Rec.Code);
                            if EXCCRIVisitPlanning.FindSet() then;

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
                        ToolTip = 'Opens the visit execution process for the salesperson.';

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
                        ToolTip = 'Opens the salesperson visit information in read-only mode.';

                        trigger OnAction()
                        begin
                            EXCCRIVisitExecution.Reset();
                            EXCCRIVisitExecution.SetRange("Cod. Promotor", Rec.Code);
                            if not EXCCRIVisitExecution.FindFirst() then begin
                                Clear(EXCCRIVisitExecution);
                                EXCCRIVisitExecution.Validate(
                                    "Cod. Promotor",
                                    Rec.Code);
                                if EXCCRIVisitExecution.Insert(true) then
                                    Commit();
                            end;

                            EXCCRIVisitExecutionPage.SetTableView(
                                EXCCRIVisitExecution);
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
                    ToolTip = 'Opens a technical assistance request for the salesperson.';

                    trigger OnAction()
                    var
                        EXCCRIAssistancePage: Page 67090;
                    begin
                        EXCCRIAssistancePage.RecibeParam(Rec.Code);
                        EXCCRIAssistancePage.RunModal();
                        Clear(EXCCRIAssistancePage);
                    end;
                }
                action(EXCCRIRoutes)
                {
                    ApplicationArea = All;
                    Caption = 'Route';
                    Image = Route;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Opens the routes assigned to the salesperson.';

                    trigger OnAction()
                    begin
                        Rec.TestField(Tipo, 0);
                        EXCCRIRoutes.SetRange("Cod. Promotor", Rec.Code);
                        EXCCRIRoutesPage.SetTableView(EXCCRIRoutes);
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
                    ToolTip = 'Opens the sample deliveries for the salesperson.';

                    trigger OnAction()
                    begin
                        Rec.TestField(Tipo, 0);
                        EXCCRISampleDelivery.SetRange(
                            "Cod. Promotor",
                            Rec.Code);
                        EXCCRISampleDeliveryPage.SetTableView(
                            EXCCRISampleDelivery);
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
                    ToolTip = 'Opens the schools assigned to the salesperson.';
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
                    ToolTip = 'Opens the teachers assigned to the salesperson.';
                }
                action(EXCCRICommissionSetup)
                {
                    ApplicationArea = All;
                    Caption = 'Commission Setup';
                    Image = CalculateInvoiceDiscount;
                    Promoted = true;
                    PromotedCategory = Process;
                    //TODO: Ver RunObject = Page 55501;
                    //TODO: Ver RunPageLink = Field1 = field(Code);
                    //TODO: Ver RunPageView = sorting(Field1, Field10);
                    ToolTip = 'Opens the commission setup for the salesperson.';
                    Visible = false;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        EXCCRIUserSetup.Get(UserId());
    end;

    trigger OnAfterGetRecord()
    begin
        if EXCCRIUserSetup."Salespers./Purch. Code" <> '' then
            Rec.SetRange(
                Code,
                EXCCRIUserSetup."Salespers./Purch. Code")
        else
            Rec.SetRange(Code);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if xRec.Code = '' then
            Rec.Reset();

        exit(true);
    end;

    var
        EXCCRIUserSetup: Record "User Setup";
        EXCCRISalesBudget: Record 67027;
        EXCCRISampleBudget: Record 67028;
        EXCCRILevels: Record 67040;
        EXCCRIVisitPlanning: Record 67023;
        EXCCRIVisitExecution: Record 67023;
        EXCCRISampleDelivery: Record 67039;
        EXCCRIRoutes: Record 67044;
        EXCCRISalesBudgetPage: Page 67027;
        EXCCRISampleBudgetPage: Page 67028;
        EXCCRIVisitPlanningPage: Page 67097;
        EXCCRIVisitExecutionPage: Page 67098;
        EXCCRISampleDeliveryPage: Page 67039;
        EXCCRILevelsPage: Page 67050;
        EXCCRIRoutesPage: Page 67048;
}
