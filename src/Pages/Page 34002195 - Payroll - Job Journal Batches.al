page 55836 "Payroll - Job Journal Batches"
{
    Caption = 'Job Journal Batches';
    DataCaptionExpression = DataCaption;
    Editable = true;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = 55814;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Name';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description';
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Edit Journal")
            {
                ApplicationArea = All;
                Caption = 'Edit Journal';
                ToolTip = 'Edit Journal';
                Image = OpenJournal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Return';

                trigger OnAction()
                begin
                    JobJnlMgt.TemplateSelectionFromBatch(Rec);
                end;
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("Test Report")
                {
                    ApplicationArea = All;
                    Caption = 'Test Report';
                    ToolTip = 'Test Report';
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        //ReportPrint.PrintJobJnlBatch(Rec);
                    end;
                }
                action("P&ost")
                {
                    ApplicationArea = All;
                    Caption = 'P&ost';
                    ToolTip = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit 1023;
                    ShortCutKey = 'F9';
                }
                action("Post and &Print")
                {
                    ApplicationArea = All;
                    Caption = 'Post and &Print';
                    ToolTip = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit 1024;
                    ShortCutKey = 'Shift+F9';
                }
            }
        }
    }

    trigger OnInit()
    begin
        SETRANGE("Journal Template Name");
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetupNewBatch;
    end;

    trigger OnOpenPage()
    begin
        JobJnlMgt.OpenJnlBatch(Rec);
    end;

    var
        ReportPrint: Codeunit 228;
        JobJnlMgt: Codeunit 55761;

    local procedure DataCaption(): Text[250]
    var
        JobJnlTemplate: Record 55815;
    begin
        IF NOT CurrPage.LOOKUPMODE THEN
            IF GETFILTER("Journal Template Name") <> '' THEN
                IF GETRANGEMIN("Journal Template Name") = GETRANGEMAX("Journal Template Name") THEN
                    IF JobJnlTemplate.GET(GETRANGEMIN("Journal Template Name")) THEN
                        EXIT(JobJnlTemplate.Name + ' ' + JobJnlTemplate.Description);
    end;
}

