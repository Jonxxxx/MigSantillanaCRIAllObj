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
                Caption = 'Batch Name';
                Lookup = true;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    CurrPage.SAVERECORD;
                    //TODO: Ver JobJnlManagement.LookupName(CurrentJnlBatchName, Rec);
                    CurrPage.UPDATE(FALSE);
                end;
            }
            repeater(GeneralRep)
            {
                field("Document No."; "Document No.")
                {
                }
                field("No. empleado"; "No. empleado")
                {
                }
                field("Puesto trabajo"; "Puesto trabajo")
                {
                }
                field("Apellidos y Nombre"; "Apellidos y Nombre")
                {
                }
                field("Tipo concepto"; "Tipo concepto")
                {
                    Visible = false;
                }
                field("Concepto salarial"; "Concepto salarial")
                {
                    Visible = false;
                }
                field("Posting Date"; "Posting Date")
                {
                }
                field("Job No."; "Job No.")
                {

                    trigger OnValidate()
                    begin
                        //TODO: Ver JobJnlManagement.GetNames(Rec, JobDescription, AccName);
                        //ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Job Task No."; "Job Task No.")
                {
                }
                field("Work Type Code"; "Work Type Code")
                {
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    Visible = false;
                }
                field("Tipo Tarifa"; "Tipo Tarifa")
                {
                }
                field("Precio Costo"; "Precio Costo")
                {
                }
                field(Quantity; Quantity)
                {
                }
                field(Amount; Amount)
                {
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
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
                            Editable = false;
                        }
                    }
                    group("Account Name")
                    {
                        Caption = 'Account Name';
                        field(AccName; AccName)
                        {
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
                        //TODO: Ver REPORT.RUN(REPORT::"Valida Diario Nom. - Proyectos", TRUE, TRUE, PJL);
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
                        //TODO: Ver CODEUNIT.RUN(CODEUNIT::"Post Payroll - Job Journal", Rec);
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
            //TODO: Ver JobJnlManagement.OpenJnl(CurrentJnlBatchName, Rec);
            EXIT;
        END;
        //TODO: Ver JobJnlManagement.TemplateSelection(PAGE::"Payroll - Job Journal Batches", FALSE, Rec, JnlSelected);
        IF NOT JnlSelected THEN
            ERROR('');
        //TODO: Ver JobJnlManagement.OpenJnl(CurrentJnlBatchName, Rec);
    end;

    var
        //TODO: Ver JobJnlManagement: Codeunit 34002120;
        JobDescription: Text[50];
        AccName: Text[50];
        CurrentJnlBatchName: Code[10];
        ShortcutDimCode: array[8] of Code[20];
        OpenedFromBatch: Boolean;

    local procedure CurrentJnlBatchNameOnAfterVali()
    begin
    end;
}

