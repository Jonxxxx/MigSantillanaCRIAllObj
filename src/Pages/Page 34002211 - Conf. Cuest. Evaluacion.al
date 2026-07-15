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
                ApplicationArea = RelationshipMgmt;
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
                field(Type; Type)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = StyleIsStrong;
                    ToolTip = 'Specifies whether the entry is a question or an answer.';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = StyleIsStrong;
                    ToolTip = 'Specifies the profile question or answer.';
                }
                field("Multiple Answers"; "Multiple Answers")
                {
                    ApplicationArea = RelationshipMgmt;
                    ToolTip = 'Specifies that the question has more than one possible answer.';
                }
                field(Priority; Priority)
                {
                    ApplicationArea = RelationshipMgmt;
                    HideValue = PriorityHideValue;
                    ToolTip = 'Specifies the priority you give to the answer and where it should be displayed on the lines of the Contact Card. There are five options:';
                }
                field("Auto Employee Classification"; "Auto Employee Classification")
                {
                    ApplicationArea = RelationshipMgmt;
                    Editable = false;
                    ToolTip = 'Specifies that the question is automatically answered when you run the Update Contact Classification batch job.';
                }
                field("From Value"; "From Value")
                {
                    ApplicationArea = RelationshipMgmt;
                    ToolTip = 'Specifies the value from which the automatic classification of your contacts starts.';
                }
                field("To Value"; "To Value")
                {
                    ApplicationArea = RelationshipMgmt;
                    ToolTip = 'Specifies the value that the automatic classification of your contacts stops at.';
                }
                field("No. of Employee"; "No. of Employee")
                {
                    ApplicationArea = RelationshipMgmt;
                    ToolTip = 'Specifies the number of contacts that have given this answer.';
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
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Question Details';
                    Image = Questionaire;
                    Promoted = true;
                    Scope = Repeater;
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View detailed information about the questions within the questionnaire.';

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
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Answer Where-Used';
                    Image = Trace;
                    ToolTip = 'View which questions the current answer is based on with the number of points given.';

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
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Update &Classification';
                    Image = Refresh;
                    ToolTip = 'Update automatic classification of your contacts. This batch job updates all the answers to the profile questions that are automatically answered by the program, based on customer, vendor or contact data.';

                    trigger OnAction()
                    var
                        ProfileQuestnHeader: Record 34002184;
                    begin
                        ProfileQuestnHeader.GET(CurrentQuestionsChecklistCode);
                        ProfileQuestnHeader.SETRECFILTER;
                        //TODO: Ver REPORT.RUN(REPORT::"Update Employee Classification", TRUE, FALSE, ProfileQuestnHeader);
                    end;
                }

                action("Move &Up")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Move &Up';
                    Image = MoveUp;
                    Promoted = true;
                    Scope = Repeater;
                    ToolTip = 'Change the sorting order of the lines.';

                    trigger OnAction()
                    begin
                        MoveUp;
                    end;
                }
                action("Move &Down")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Move &Down';
                    Image = MoveDown;
                    Promoted = true;
                    Scope = Repeater;
                    ToolTip = 'Change the sorting order of the lines.';

                    trigger OnAction()
                    begin
                        MoveDown
                    end;
                }

                action(Print)
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Print';
                    Image = Print;
                    ToolTip = 'Print the information in the window. A print request window opens where you can specify what to include on the print-out.';

                    trigger OnAction()
                    var
                        ProfileQuestnHeader: Record 34002184;
                    begin
                        ProfileQuestnHeader.SETRANGE(Code, CurrentQuestionsChecklistCode);
                        //TODO: Ver REPORT.RUN(REPORT::"Recibo Nomina sin copia - coop", TRUE, FALSE, ProfileQuestnHeader);
                    end;
                }
                action("Test Report")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Test Report';
                    Image = TestReport;
                    ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.';

                    trigger OnAction()
                    var
                        ProfileQuestnHeader: Record 34002184;
                    begin
                        ProfileQuestnHeader.SETRANGE(Code, CurrentQuestionsChecklistCode);
                        //TODO: Ver REPORT.RUN(REPORT::"Nominas por departamentos A4", TRUE, FALSE, ProfileQuestnHeader);
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

        //TODO: Ver IF CurrentQuestionsChecklistCode = '' THEN
        //TODO: Ver     CurrentQuestionsChecklistCode := ProfileManagement.GetQuestionnaire;

        //001 ProfileManagement.SetName(CurrentQuestionsChecklistCode,Rec,0);

        CaptionExpr := "Profile Questionnaire Code";
        ProfileQuestionnaireCodeNameVi := FALSE;
    end;

    var
        Text000: Label 'Details only available for questions.';
        ProfileQuestnHeader: Record 34002184;
        //TODO: Ver ProfileManagement: Codeunit 34002123;
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

