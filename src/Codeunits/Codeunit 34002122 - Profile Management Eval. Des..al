codeunit 34002122 "Profile Management Eval. Des."
{

    trigger OnRun()
    begin
    end;

    var
        Text000: Label 'General';
        Text001: Label 'No profile questionnaire is created for this employee.';
        ProfileQuestnHeaderTemp: Record 34002184 temporary;

    local procedure FindLegalProfileQuestionnaire(Emp: Record 5200)
    var
        ProfileQuestnHeader: Record 34002184;
        ContProfileAnswer: Record 34002192;
        Valid: Boolean;
    begin
        ProfileQuestnHeaderTemp.DELETEALL;

        WITH ProfileQuestnHeader DO BEGIN
            RESET;
            IF FIND('-') THEN
                REPEAT
                    Valid := TRUE;
                    /*
                    IF ("Contact Type" = "Contact Type"::Companies) AND
                       (Cont.Type <> Cont.Type::Company)
                    THEN
                      Valid := FALSE;

                    IF ("Contact Type" = "Contact Type"::People) AND
                       (Cont.Type <> Cont.Type::Person)
                    THEN
                      Valid := FALSE;
                    IF Valid AND ("Business Relation Code" <> '') THEN
                      IF NOT ContBusRel.GET(Cont."Company No.","Business Relation Code") THEN
                        Valid := FALSE;
                    */
                    IF NOT Valid THEN BEGIN
                        ContProfileAnswer.RESET;
                        ContProfileAnswer.SETRANGE("Employee No.", Emp."No.");
                        ContProfileAnswer.SETRANGE("Profile Questionnaire Code", Code);
                        IF ContProfileAnswer.FINDFIRST THEN
                            Valid := TRUE;
                    END;
                    IF Valid THEN BEGIN
                        ProfileQuestnHeaderTemp := ProfileQuestnHeader;
                        ProfileQuestnHeaderTemp.INSERT;
                    END;
                UNTIL NEXT = 0;
        END;

    end;

    [Scope('Personalization')]
    procedure GetQuestionnaire(): Code[20]
    var
        ProfileQuestnHeader: Record 5087;
    begin
        IF ProfileQuestnHeader.FINDFIRST THEN
            EXIT(ProfileQuestnHeader.Code);

        ProfileQuestnHeader.INIT;
        ProfileQuestnHeader.Code := Text000;
        ProfileQuestnHeader.Description := Text000;
        ProfileQuestnHeader.INSERT;
        EXIT(ProfileQuestnHeader.Code);
    end;

    [Scope('Personalization')]
    procedure ProfileQuestionnaireAllowed(Emp: Record 5200; ProfileQuestnHeaderCode: Code[20]): Code[20]
    begin
        FindLegalProfileQuestionnaire(Emp);

        IF ProfileQuestnHeaderTemp.GET(ProfileQuestnHeaderCode) THEN
            EXIT(ProfileQuestnHeaderCode);
        IF ProfileQuestnHeaderTemp.FINDFIRST THEN
            EXIT(ProfileQuestnHeaderTemp.Code);

        ERROR(Text001);
    end;

    [Scope('Personalization')]
    procedure ShowContactQuestionnaireCard(Emp: Record 5200; ProfileQuestnLineCode: Code[20]; ProfileQuestnLineLineNo: Integer)
    var
        ProfileQuestnLine: Record 34002185;
        EmpProfileAnswers: Page 34002212;
    begin
        EmpProfileAnswers.SetParameters(Emp, ProfileQuestionnaireAllowed(Emp, ''), ProfileQuestnLineCode, ProfileQuestnLineLineNo);
        IF ProfileQuestnHeaderTemp.GET(ProfileQuestnLineCode) THEN BEGIN
            ProfileQuestnLine.GET(ProfileQuestnLineCode, ProfileQuestnLineLineNo);
            EmpProfileAnswers.SETRECORD(ProfileQuestnLine);
        END;
        EmpProfileAnswers.RUNMODAL;
    end;

    [Scope('Personalization')]
    procedure CheckName(CurrentQuestionsChecklistCode: Code[20]; var Emp: Record 5200)
    begin
        FindLegalProfileQuestionnaire(Emp);
        ProfileQuestnHeaderTemp.GET(CurrentQuestionsChecklistCode);
    end;

    [Scope('Personalization')]
    procedure SetName(ProfileQuestnHeaderCode: Code[20]; var ProfileQuestnLine: Record 34002185; ContactProfileAnswerLine: Integer)
    begin
        ProfileQuestnLine.FILTERGROUP := 2;
        ProfileQuestnLine.SETRANGE("Profile Questionnaire Code", ProfileQuestnHeaderCode);
        ProfileQuestnLine.FILTERGROUP := 0;
        IF ContactProfileAnswerLine = 0 THEN
            IF ProfileQuestnLine.FIND('-') THEN;
    end;

    [Scope('Personalization')]
    procedure LookupName(var ProfileQuestnHeaderCode: Code[20]; var ProfileQuestnLine: Record 34002185; var Cont: Record 5200)
    begin
        COMMIT;
        FindLegalProfileQuestionnaire(Cont);
        IF ProfileQuestnHeaderTemp.GET(ProfileQuestnHeaderCode) THEN;
        IF PAGE.RUNMODAL(PAGE::"Lista Cuestionario Evaluacion", ProfileQuestnHeaderTemp) = ACTION::LookupOK THEN
            ProfileQuestnHeaderCode := ProfileQuestnHeaderTemp.Code;

        SetName(ProfileQuestnHeaderCode, ProfileQuestnLine, 0);
    end;

    [Scope('Personalization')]
    procedure ShowAnswerPoints(CurrProfileQuestnLine: Record 34002185)
    begin
        CurrProfileQuestnLine.SETRANGE("Profile Questionnaire Code", CurrProfileQuestnLine."Profile Questionnaire Code");
        PAGE.RUNMODAL(PAGE::"Answer Points", CurrProfileQuestnLine);
    end;
}

