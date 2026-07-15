page 34002212 "Preguntas Cuest. Evaluacion"
{
    AutoSplitKey = true;
    Caption = 'Employee Profile Answers';
    DataCaptionExpression = CaptionStr;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SaveValues = true;
    SourceTable = 34002185;

    layout
    {
        area(content)
        {
            field(CurrentQuestionsChecklistCode; CurrentQuestionsChecklistCode)
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Profile Questionnaire Code';
                ToolTip = 'Specifies the profile questionnaire.';

                trigger OnLookup(var Text: Text): Boolean
                begin
                    CurrPage.SAVERECORD;
                    //TODO: Ver ProfileManagement.LookupName(CurrentQuestionsChecklistCode, Rec, Emp);
                    CurrPage.UPDATE(FALSE);
                end;

                trigger OnValidate()
                begin
                    //TODO: Ver ProfileManagement.CheckName(CurrentQuestionsChecklistCode, Emp);
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
                    Editable = false;
                    Style = Strong;
                    StyleExpr = StyleIsStrong;
                    ToolTip = 'Specifies whether the entry is a question or an answer.';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = StyleIsStrong;
                    ToolTip = 'Specifies the profile question or answer.';
                }
                field("No. of Employee"; "No. of Employee")
                {
                    ApplicationArea = RelationshipMgmt;
                    ToolTip = 'Specifies the number of contacts that have given this answer.';
                    Visible = false;
                }
                field(Set; Set)
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Set';
                    ToolTip = 'Specifies the answer to the question.';

                    trigger OnValidate()
                    begin
                        UpdateProfileAnswer;
                    end;
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
    }

    trigger OnAfterGetRecord()
    begin
        Set := EmpProfileAnswer.GET(Emp."No.", "Profile Questionnaire Code", "Line No.");

        StyleIsStrong := Type = Type::Question;
        IF Type <> Type::Question THEN
            DescriptionIndent := 1
        ELSE
            DescriptionIndent := 0;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        ProfileQuestionnaireLine2.COPY(Rec);

        IF NOT ProfileQuestionnaireLine2.FIND(Which) THEN
            EXIT(FALSE);

        ProfileQuestLineQuestion := ProfileQuestionnaireLine2;
        IF ProfileQuestionnaireLine2.Type = Type::Answer THEN
            ProfileQuestLineQuestion.GET(ProfileQuestionnaireLine2."Profile Questionnaire Code", ProfileQuestLineQuestion.FindQuestionLine);

        OK := TRUE;
        IF ProfileQuestLineQuestion."Auto Employee Classification" THEN BEGIN
            OK := FALSE;
            REPEAT
                IF Which = '+' THEN
                    GoNext := ProfileQuestionnaireLine2.NEXT(-1) <> 0
                ELSE
                    GoNext := ProfileQuestionnaireLine2.NEXT(1) <> 0;
                IF GoNext THEN BEGIN
                    ProfileQuestLineQuestion := ProfileQuestionnaireLine2;
                    IF ProfileQuestionnaireLine2.Type = Type::Answer THEN
                        ProfileQuestLineQuestion.GET(
                          ProfileQuestionnaireLine2."Profile Questionnaire Code", ProfileQuestLineQuestion.FindQuestionLine);
                    OK := NOT ProfileQuestLineQuestion."Auto Employee Classification";
                END;
            UNTIL (NOT GoNext) OR OK;
        END;

        IF NOT OK THEN
            EXIT(FALSE);

        Rec := ProfileQuestionnaireLine2;
        EXIT(TRUE);
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    var
        ActualSteps: Integer;
        Step: Integer;
        NoOneFound: Boolean;
    begin
        ProfileQuestionnaireLine2.COPY(Rec);

        IF Steps > 0 THEN
            Step := 1
        ELSE
            Step := -1;

        REPEAT
            IF ProfileQuestionnaireLine2.NEXT(Step) <> 0 THEN BEGIN
                IF ProfileQuestionnaireLine2.Type = Type::Answer THEN
                    ProfileQuestLineQuestion.GET(
                      ProfileQuestionnaireLine2."Profile Questionnaire Code", ProfileQuestionnaireLine2.FindQuestionLine);
                IF ((NOT ProfileQuestLineQuestion."Auto Employee Classification") AND
                    (ProfileQuestionnaireLine2.Type = Type::Answer)) OR
                   ((ProfileQuestionnaireLine2.Type = Type::Question) AND (NOT ProfileQuestionnaireLine2."Auto Employee Classification"))
                THEN BEGIN
                    ActualSteps := ActualSteps + Step;
                    IF Steps <> 0 THEN
                        Rec := ProfileQuestionnaireLine2;
                END;
            END ELSE
                NoOneFound := TRUE
        UNTIL (ActualSteps = Steps) OR NoOneFound;

        EXIT(ActualSteps);
    end;

    trigger OnOpenPage()
    begin
        //TODO: Ver 
        /*
        IF EmpProfileAnswerCode = '' THEN
            CurrentQuestionsChecklistCode :=
              ProfileManagement.ProfileQuestionnaireAllowed(Emp, CurrentQuestionsChecklistCode)
        ELSE
            CurrentQuestionsChecklistCode := EmpProfileAnswerCode;

        ProfileManagement.SetName(CurrentQuestionsChecklistCode, Rec, EmpProfileAnswerLine);*/

        /*
        IF (Emp."Company No." <> '') AND (Emp."No." <> Emp."Company No.") THEN BEGIN
          CaptionStr := COPYSTR(Emp."Company No." + ' ' + Emp."Company Name",1,MAXSTRLEN(CaptionStr));
          CaptionStr := COPYSTR(CaptionStr + ' ' + Emp."No." + ' ' + Emp.Name,1,MAXSTRLEN(CaptionStr));
        END ELSE
        */
        CaptionStr := COPYSTR(Emp."No." + ' ' + Emp."Full Name", 1, MAXSTRLEN(CaptionStr));

    end;

    var
        Emp: Record 5200;
        EmpProfileAnswer: Record 34002192;
        ProfileQuestionnaireLine2: Record 34002185;
        ProfileQuestLineQuestion: Record 34002185;
        //TODO: Ver ProfileManagement: Codeunit 34002122;
        CurrentQuestionsChecklistCode: Code[20];
        EmpProfileAnswerCode: Code[20];
        EmpProfileAnswerLine: Integer;
        Set: Boolean;
        GoNext: Boolean;
        OK: Boolean;
        CaptionStr: Text[260];
        RunFormCode: Boolean;
        [InDataSet]
        StyleIsStrong: Boolean;
        [InDataSet]
        DescriptionIndent: Integer;

    [Scope('Personalization')]
    procedure SetParameters(var SetEmp: Record 5200; SetProfileQuestionnaireCode: Code[20]; SetEmpProfileAnswerCode: Code[20]; SetEmpProfileAnswerLine: Integer)
    begin
        Emp := SetEmp;
        CurrentQuestionsChecklistCode := SetProfileQuestionnaireCode;
        EmpProfileAnswerCode := SetEmpProfileAnswerCode;
        EmpProfileAnswerLine := SetEmpProfileAnswerLine;
    end;

    [Scope('Personalization')]
    procedure UpdateProfileAnswer()
    begin
        IF NOT RunFormCode AND Set THEN
            TESTFIELD(Type, Type::Answer);

        IF Set THEN BEGIN
            EmpProfileAnswer.INIT;
            EmpProfileAnswer."Employee No." := Emp."No.";
            //EmpProfileAnswer."Employee Company No." := Emp."Company No.";
            EmpProfileAnswer.VALIDATE("Profile Questionnaire Code", CurrentQuestionsChecklistCode);
            EmpProfileAnswer.VALIDATE("Line No.", "Line No.");
            EmpProfileAnswer."Last Date Updated" := TODAY;
            EmpProfileAnswer.INSERT(TRUE);
        END ELSE
            IF EmpProfileAnswer.GET(Emp."No.", CurrentQuestionsChecklistCode, "Line No.") THEN
                EmpProfileAnswer.DELETE(TRUE);
    end;

    [Scope('Personalization')]
    procedure SetRunFromForm(var ProfileQuestionnaireLine: Record 34002185; EmpFrom: Record 5200; CurrQuestionsChecklistCodeFrom: Code[20])
    begin
        Set := TRUE;
        RunFormCode := TRUE;
        Emp := EmpFrom;
        CurrentQuestionsChecklistCode := CurrQuestionsChecklistCodeFrom;
        Rec := ProfileQuestionnaireLine;
    end;

    local procedure CurrentQuestionsChecklistCodeO()
    begin
        CurrPage.SAVERECORD;
        //TODO: Ver ProfileManagement.SetName(CurrentQuestionsChecklistCode, Rec, 0);
        CurrPage.UPDATE(FALSE);
    end;
}

