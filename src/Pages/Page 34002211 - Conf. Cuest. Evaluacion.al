page 34002211 "Conf. Cuest. Evaluacion"
{
    AutoSplitKey = true;
    Caption = 'Profile Questionnaire Setup';
    DataCaptionExpression = CaptionExpr;
    PageType = List;
    SaveValues = true;
    SourceTable = 34002185;

    layout
    {
        area(content)
        {
            field(ProfileQuestionnaireCodeName; CurrentQuestionsChecklistCode)
            {
                ApplicationArea = All;
                Caption = 'Profile Questionnaire Code';
                ToolTip = 'Specifies the profile questionnaire.';
                Visible = ProfileQuestionnaireCodeNameVi;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    CurrPage.SAVERECORD;
                    COMMIT;
                    IF PAGE.RUNMODAL(0, ProfileQuestnHeader) = ACTION::LookupOK THEN BEGIN
                        ProfileQuestnHeader.GET(ProfileQuestnHeader.Code);
                        CurrentQuestionsChecklistCode := ProfileQuestnHeader.Code;
                        //001 ProfileManagement.SetName(CurrentQuestionsChecklistCode,Rec,0);
                        CurrPage.UPDATE(FALSE);
                    END;
                end;

                trigger OnValidate()
                begin
                    ProfileQuestnHeader.GET(CurrentQuestionsChecklistCode);
                    CurrentQuestionsChecklistCodeO;
                end;
            }
            repeater(GeneralRep)
            {
                IndentationColumn = DescriptionIndent;
                IndentationControls = Description;
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Type';
                    Style = Strong;
                    StyleExpr = StyleIsStrong;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description';
                    Style = Strong;
                    StyleExpr = StyleIsStrong;
                }
                field("Multiple Answers"; Rec."Multiple Answers")
                {
                    ApplicationArea = All;
                    ToolTip = 'Multiple Answers';
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                    ToolTip = 'Priority';
                    HideValue = PriorityHideValue;
                }
                field("Auto Employee Classification"; Rec."Auto Employee Classification")
                {
                    ApplicationArea = All;
                    ToolTip = 'Auto Employee Classification';
                    Editable = false;
                }
                field("From Value"; Rec."From Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'From Value';
                }
                field("To Value"; Rec."To Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'To Value';
                }
                field("No. of Employee"; Rec."No. of Employee")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. of Employee';
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
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action("Question Details")
                {
                    ApplicationArea = All;
                    Caption = 'Question Details';
                    ToolTip = 'Question Details';
                    Image = Questionaire;
                    Promoted = true;
                    Scope = Repeater;
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()
                    begin
                        CASE Type OF
                            Type::Question:
                                PAGE.RUNMODAL(PAGE::"Preguntas Cuest. Evaluacion", Rec);
                            Type::Answer:
                                ERROR(Text000);
                        END;
                    end;
                }
                action("Answer Where-Used")
                {
                    ApplicationArea = All;
                    Caption = 'Answer Where-Used';
                    ToolTip = 'Answer Where-Used';
                    Image = Trace;

                    trigger OnAction()
                    var
                        Rating: Record 5111;
                    begin
                        CASE Type OF
                            Type::Question:
                                ERROR(Text001);
                            Type::Answer:
                                BEGIN
                                    Rating.SETRANGE("Rating Profile Quest. Code", "Profile Questionnaire Code");
                                    Rating.SETRANGE("Rating Profile Quest. Line No.", "Line No.");
                                    PAGE.RUNMODAL(PAGE::"Answer Where-Used", Rating);
                                END;
                        END;
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

                action("Update &Classification")
                {
                    ApplicationArea = All;
                    Caption = 'Update &Classification';
                    ToolTip = 'Update &Classification';
                    Image = Refresh;

                    trigger OnAction()
                    var
                        ProfileQuestnHeader: Record 34002184;
                    begin
                        ProfileQuestnHeader.GET(CurrentQuestionsChecklistCode);
                        ProfileQuestnHeader.SETRECFILTER;
                        // TODO: Manual review - The custom Update Employee Classification report is unavailable in the current repository.
                        // Original code: REPORT.RUN(REPORT::"Update Employee Classification", TRUE, FALSE, ProfileQuestnHeader);
                    end;
                }

                action("Move &Up")
                {
                    ApplicationArea = All;
                    Caption = 'Move &Up';
                    ToolTip = 'Move &Up';
                    Image = MoveUp;
                    Promoted = true;
                    Scope = Repeater;

                    trigger OnAction()
                    begin
                        MoveUp;
                    end;
                }
                action("Move &Down")
                {
                    ApplicationArea = All;
                    Caption = 'Move &Down';
                    ToolTip = 'Move &Down';
                    Image = MoveDown;
                    Promoted = true;
                    Scope = Repeater;

                    trigger OnAction()
                    begin
                        MoveDown
                    end;
                }

                action(Print)
                {
                    ApplicationArea = All;
                    Caption = 'Print';
                    ToolTip = 'Print';
                    Image = Print;

                    trigger OnAction()
                    var
                        ProfileQuestnHeader: Record 34002184;
                    begin
                        ProfileQuestnHeader.SETRANGE(Code, CurrentQuestionsChecklistCode);
                        // TODO: Manual review - The custom Recibo Nomina sin copia - coop report is unavailable in the current repository.
                        // Original code: REPORT.RUN(REPORT::"Recibo Nomina sin copia - coop", TRUE, FALSE, ProfileQuestnHeader);
                    end;
                }
                action("Test Report")
                {
                    ApplicationArea = All;
                    Caption = 'Test Report';
                    ToolTip = 'Test Report';
                    Image = TestReport;

                    trigger OnAction()
                    var
                        ProfileQuestnHeader: Record 34002184;
                    begin
                        ProfileQuestnHeader.SETRANGE(Code, CurrentQuestionsChecklistCode);
                        // TODO: Manual review - The custom Nominas por departamentos A4 report is unavailable in the current repository.
                        // Original code: REPORT.RUN(REPORT::"Nominas por departamentos A4", TRUE, FALSE, ProfileQuestnHeader);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        PriorityHideValue := FALSE;
        StyleIsStrong := FALSE;
        DescriptionIndent := 0;

        IF Type = Type::Question THEN BEGIN
            StyleIsStrong := TRUE;
            PriorityHideValue := TRUE;
        END ELSE
            DescriptionIndent := 1;
    end;

    trigger OnInit()
    begin
        ProfileQuestionnaireCodeNameVi := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Profile Questionnaire Code" := CurrentQuestionsChecklistCode;
        Type := Type::Answer;
    end;

    trigger OnOpenPage()
    var
        ProfileQuestionnaireHeader: Record 5087;
    begin
        IF GETFILTER("Profile Questionnaire Code") <> '' THEN BEGIN
            ProfileQuestionnaireHeader.SETFILTER(Code, GETFILTER("Profile Questionnaire Code"));
            IF ProfileQuestionnaireHeader.COUNT = 1 THEN BEGIN
                ProfileQuestionnaireHeader.FINDFIRST;
                CurrentQuestionsChecklistCode := ProfileQuestionnaireHeader.Code;
            END;
        END;

        // TODO: Manual review - Custom codeunit 34002123 is unavailable, and current Profile Management has no verified GetQuestionnaire replacement.
        // Original code preserved below.
        // IF CurrentQuestionsChecklistCode = '' THEN
        //     CurrentQuestionsChecklistCode := ProfileManagement.GetQuestionnaire;

        //001 ProfileManagement.SetName(CurrentQuestionsChecklistCode,Rec,0);

        CaptionExpr := "Profile Questionnaire Code";
        ProfileQuestionnaireCodeNameVi := FALSE;
    end;

    var
        Text000: Label 'Details only available for questions.';
        ProfileQuestnHeader: Record 34002184;
        // TODO: Manual review - Custom codeunit 34002123 is unavailable as the required object type.
        // Original code: ProfileManagement: Codeunit 34002123;
        CurrentQuestionsChecklistCode: Code[20];
        Text001: Label 'Where-Used only available for answers.';
        CaptionExpr: Text[100];
        [InDataSet]
        ProfileQuestionnaireCodeNameVi: Boolean;
        [InDataSet]
        DescriptionIndent: Integer;
        [InDataSet]
        StyleIsStrong: Boolean;
        [InDataSet]
        PriorityHideValue: Boolean;

    local procedure CurrentQuestionsChecklistCodeO()
    begin
        //001 ProfileManagement.SetName(CurrentQuestionsChecklistCode,Rec,0);
    end;
}

