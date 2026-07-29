page 34002193 "Payroll - Job Journal"
{
    AutoSplitKey = true;
    Caption = 'Job Journal';
    DataCaptionFields = "Journal Batch Name";
    PageType = Worksheet;
    PromotedActionCategories = 'New,Process,Report,Job,Resource,Human Resource';
    SaveValues = true;
    SourceTable = 34002172;

    layout
    {
        area(content)
        {
            field(CurrentJnlBatchName; CurrentJnlBatchName)
            {
                ApplicationArea = All;
                Caption = 'Batch Name';
                Lookup = true;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    CurrPage.SAVERECORD;
                    JobJnlManagement.LookupName(CurrentJnlBatchName, Rec);
                    CurrPage.UPDATE(FALSE);
                end;
            }
            repeater(GeneralRep)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Document No.';
                }
                field("No. empleado"; Rec."No. empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. empleado';
                }
                field("Puesto trabajo"; Rec."Puesto trabajo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Puesto trabajo';
                }
                field("Apellidos y Nombre"; Rec."Apellidos y Nombre")
                {
                    ApplicationArea = All;
                    ToolTip = 'Apellidos y Nombre';
                }
                field("Tipo concepto"; Rec."Tipo concepto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo concepto';
                    Visible = false;
                }
                field("Concepto salarial"; Rec."Concepto salarial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Concepto salarial';
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Posting Date';
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Job No.';

                    trigger OnValidate()
                    begin
                        JobJnlManagement.GetNames(Rec, JobDescription, AccName);
                        //ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Job Task No.';
                }
                field("Work Type Code"; Rec."Work Type Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Work Type Code';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unit of Measure Code';
                    Visible = false;
                }
                field("Tipo Tarifa"; Rec."Tipo Tarifa")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Tarifa';
                }
                field("Precio Costo"; Rec."Precio Costo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Precio Costo';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantity';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Amount';
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Gen. Bus. Posting Group';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Gen. Prod. Posting Group';
                }
            }
            group(GeneralGroup)
            {
                fixed(General)
                {
                    group("Job Description")
                    {
                        Caption = 'Job Description';
                        field(JobDescription; JobDescription)
                        {
                            ApplicationArea = All;
                            Editable = false;
                        }
                    }
                    group("Account Name")
                    {
                        Caption = 'Account Name';
                        field(AccName; AccName)
                        {
                            ApplicationArea = All;
                            Caption = 'Account Name';
                            Editable = false;
                        }
                    }
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Job")
            {
                Caption = '&Job';
                Image = Job;
                action(Card1)
                {
                    Caption = 'Card';
                    Image = Job;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page 88;
                    RunPageLink = "No." = FIELD("Job No.");
                    ShortCutKey = 'Shift+F7';
                }
                action("Ledger E&ntries1")
                {
                    Caption = 'Ledger E&ntries';
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page 92;
                    RunPageLink = "Job No." = FIELD("Job No.");
                    RunPageView = SORTING("Job No.", "Posting Date");
                    ShortCutKey = 'Ctrl+F7';
                }
            }
            group(Resource)
            {
                Caption = 'Resource';
                Image = Resource;
                action(Card2)
                {
                    Caption = 'Card';
                    Image = Resource;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page 76;
                    RunPageLink = "No." = FIELD("Resource No.");
                    ShortCutKey = 'Shift+F7';
                }
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    Image = ResourceLedger;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page 202;
                    RunPageLink = "Resource No." = FIELD("Resource No.");
                    RunPageView = SORTING("Resource No.", "Posting Date");
                }
            }
            group(Employee)
            {
                Caption = 'Employee';
                Image = Employee;
                action(Card)
                {
                    Caption = 'Card';
                    Image = Employee;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    RunObject = Page 34002104;
                    RunPageLink = "No." = FIELD("No. empleado");
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(CalcRemainingUsage)
                {
                    Caption = 'Calc. Remaining Usage';
                    Ellipsis = true;
                    Image = CalculateRemainingUsage;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    var
                        JobCalcRemainingUsage: Report 1090;
                    begin
                        TESTFIELD("Journal Template Name");
                        TESTFIELD("Journal Batch Name");
                        CLEAR(JobCalcRemainingUsage);
                        JobCalcRemainingUsage.SetBatch("Journal Template Name", "Journal Batch Name");
                        //JobCalcRemainingUsage.SetDocNo("Document No.");
                        JobCalcRemainingUsage.RUNMODAL;
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    var
                        PJL: Record 34002172;
                    begin
                        //ReportPrint.PrintJobJnlLine(Rec);

                        PJL.RESET;
                        PJL.SETRANGE("Journal Template Name", "Journal Template Name");
                        PJL.SETRANGE("Journal Batch Name", "Journal Batch Name");
                        // TODO: Manual review - The custom Valida Diario Nom. - Proyectos report is unavailable in the current repository.
                        // Original code: REPORT.RUN(REPORT::"Valida Diario Nom. - Proyectos", TRUE, TRUE, PJL);
                    end;
                }
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Post Payroll - Job Journal", Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';

                    trigger OnAction()
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Job Jnl.-Post+Print", Rec);
                        //CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    var
        ReserveJobJnlLine: Codeunit 99000844;
    begin
        COMMIT;
    end;

    trigger OnOpenPage()
    var
        JnlSelected: Boolean;
    begin

        OpenedFromBatch := ("Journal Batch Name" <> '') AND ("Journal Template Name" = '');
        IF OpenedFromBatch THEN BEGIN
            CurrentJnlBatchName := "Journal Batch Name";
            JobJnlManagement.OpenJnl(CurrentJnlBatchName, Rec);
            EXIT;
        END;
        JobJnlManagement.TemplateSelection(PAGE::"Payroll - Job Journal Batches", FALSE, Rec, JnlSelected);
        IF NOT JnlSelected THEN
            ERROR('');
        JobJnlManagement.OpenJnl(CurrentJnlBatchName, Rec);
    end;

    var
        JobJnlManagement: Codeunit 34002120;
        JobDescription: Text[50];
        AccName: Text[50];
        CurrentJnlBatchName: Code[10];
        ShortcutDimCode: array[8] of Code[20];
        OpenedFromBatch: Boolean;

    local procedure CurrentJnlBatchNameOnAfterVali()
    begin
    end;
}

