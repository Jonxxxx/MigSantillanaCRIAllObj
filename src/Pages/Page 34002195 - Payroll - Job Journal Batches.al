page 34002195 "Payroll - Job Journal Batches"
{
    Caption = 'Job Journal Batches';
    DataCaptionExpression = DataCaption;
    Editable = true;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = 34002173;

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
            }
            systempart(Notes; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Edit Journal")
            {
                Caption = 'Edit Journal';
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
                    Caption = 'Test Report';
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        //ReportPrint.PrintJobJnlBatch(Rec);
                    end;
                }
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit 1023;
                    ShortCutKey = 'F9';
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
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
        JobJnlMgt: Codeunit 34002120;

    local procedure DataCaption(): Text[250]
    var
        JobJnlTemplate: Record 34002174;
    begin
        IF NOT CurrPage.LOOKUPMODE THEN
            IF GETFILTER("Journal Template Name") <> '' THEN
                IF GETRANGEMIN("Journal Template Name") = GETRANGEMAX("Journal Template Name") THEN
                    IF JobJnlTemplate.GET(GETRANGEMIN("Journal Template Name")) THEN
                        EXIT(JobJnlTemplate.Name + ' ' + JobJnlTemplate.Description);
    end;
}

