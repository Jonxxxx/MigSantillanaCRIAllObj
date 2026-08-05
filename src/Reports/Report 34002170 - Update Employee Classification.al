report 55811 "Update Employee Classification"
{
    Caption = 'Update Contact Classification';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Cab. Cuestionario Evaluacion"; 55825)
        {
            DataItemTableView = SORTING(Code);
            RequestFilterFields = "Code", Description;
            dataitem("Lin. Cuestionario Evaluacion"; 55826)
            {
                DataItemLink = "Profile Questionnaire Code" = FIELD(Code);
                DataItemTableView = SORTING("Profile Questionnaire Code", "Line No.")
                                    WHERE(Type = CONST(Question),
                                          "Auto Employee Classification" = CONST(true),
                                          "Employee Class. Field" = FILTER(<> Rating));

                trigger OnAfterGetRecord()
                begin
                    Window.UPDATE(3, "Line No.");
                    IF NoOfQuestions = 0 THEN
                        NoOfQuestions := COUNT;
                    QuestionCount := QuestionCount + 1;
                    Window.UPDATE(4, ROUND(10000 * QuestionCount / NoOfQuestions, 1));
                    RecCount := 0;

                    EmployeeValue.DELETEALL;

                    IF (FORMAT("Starting Date Formula") = '') OR (FORMAT("Ending Date Formula") = '') THEN
                        ERROR(
                          Text005,
                          FIELDCAPTION("Starting Date Formula"),
                          FIELDCAPTION("Ending Date Formula"),
                          "Cab. Cuestionario Evaluacion".Code,
                          Description);

                    IF "Classification Method" = "Classification Method"::" " THEN
                        ERROR(
                          Text008,
                          FIELDCAPTION("Classification Method"),
                          "Cab. Cuestionario Evaluacion".Code,
                          Description);

                    AnswersExists("Lin. Cuestionario Evaluacion", '', TRUE);
                    TotalValue := 0;

                    //CASE TRUE OF
                    //  "Employee Class. Field" <> "Employee Class. Field"::" ":
                    FindEmployeeValues("Lin. Cuestionario Evaluacion");
                    //END;

                    MarkEmployeeByMethod("Lin. Cuestionario Evaluacion", '');
                end;

                trigger OnPreDataItem()
                begin
                    NoOfQuestions := 0;
                    QuestionCount := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Window.UPDATE(1, Code);
                IF NoOfProfiles = 0 THEN
                    NoOfProfiles := COUNT;
                ProfileCount := ProfileCount + 1;
                Window.UPDATE(2, ROUND(10000 * ProfileCount / NoOfProfiles, 1));
                NoOfQuestions := 0;
            end;
        }
        dataitem("Integer"; 2000000026)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = CONST(1));

            trigger OnAfterGetRecord()
            begin
                UpdateRating('');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(Date; Date)
                    {
                        ApplicationArea = All;
                        Caption = 'Date';
                        ToolTip = 'Date';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        Date := WORKDATE;
    end;

    trigger OnPreReport()
    begin
        Window.OPEN(
          Text000 +
          Text001 +
          Text002);
    end;

    var
        Text000: Label 'Profile Questionnaire #1######## @2@@@@@@@@@@@@@\\';
        Text001: Label 'Question Line No.     #3######## @4@@@@@@@@@@@@@\';
        Text002: Label 'Finding Values        #5######## @6@@@@@@@@@@@@@\';
        Text003: Label '%1 results in a date before the result of the %2.';
        EmployeeValue: Record 55834 temporary;
        Window: Dialog;
        Date: Date;
        NoOfProfiles: Integer;
        ProfileCount: Integer;
        NoOfQuestions: Integer;
        QuestionCount: Integer;
        NoOfRecs: Integer;
        RecCount: Integer;
        TotalValue: Decimal;
        Text004: Label 'Two or more questions are causing the rating calculation to loop.';
        Text005: Label 'You must specify %1 and %2 in Profile Questionnaire %3, question %4. To find additional errors, run the Test report.', Comment = '%1 = Starting Date Formula;%2 = Ending Date Formula;%3 = Profile Questionaire Code;%4 = Question Description';
        Text008: Label 'You must specify %1 in Profile Questionnaire %2, question %3. To find additional errors, run the Test report.', Comment = '%1 = Sorting Method;%2 = Profile Questionaire Code;%3 = Question Description';

    local procedure AnswersExists(var ProfileQuestionnaireLine: Record 55826; UpdateEmpNo: Code[20]; Delete: Boolean): Boolean
    var
        ContProfileAnswer: Record 55833;
        ProfileQuestnLine2: Record 55826;
    begin
        ContProfileAnswer.SETCURRENTKEY("Profile Questionnaire Code", "Line No.");
        ContProfileAnswer.SETRANGE("Profile Questionnaire Code", ProfileQuestionnaireLine."Profile Questionnaire Code");

        ProfileQuestnLine2.RESET;
        ProfileQuestnLine2 := ProfileQuestionnaireLine;
        ProfileQuestnLine2.SETRANGE(Type, ProfileQuestnLine2.Type::Question);
        ProfileQuestnLine2.SETRANGE("Profile Questionnaire Code", ProfileQuestionnaireLine."Profile Questionnaire Code");
        IF ProfileQuestnLine2.NEXT <> 0 THEN
            ContProfileAnswer.SETRANGE("Line No.", ProfileQuestionnaireLine."Line No.", ProfileQuestnLine2."Line No.")
        ELSE
            ContProfileAnswer.SETFILTER("Line No.", '%1..', ProfileQuestionnaireLine."Line No.");
        IF UpdateEmpNo <> '' THEN BEGIN
            ContProfileAnswer.SETRANGE("Employee No.", UpdateEmpNo);
            ContProfileAnswer.SETCURRENTKEY("Employee No.", "Profile Questionnaire Code", "Line No.");
        END;

        IF Delete THEN
            ContProfileAnswer.DELETEALL
        ELSE
            EXIT(NOT ContProfileAnswer.ISEMPTY);
    end;

    local procedure FindEmployeeValues(ProfileQuestionnaireLine: Record 55826)
    var
        Emp: Record 5200;
        ContNo: Code[20];
        NoOfYears: Decimal;
        WonCount: Integer;
        LostCount: Integer;
        FromDate: Date;
        ToDate: Date;
    begin
        /*
        NoOfRecs := Emp.COUNT;
        IF Emp.FIND('-') THEN
          REPEAT
            RecCount := RecCount + 1;
            Window.UPDATE(5,Emp."No.");
            Window.UPDATE(6,ROUND(10000 * RecCount / NoOfRecs,1));
            ContNo := EmployeeNo(ProfileQuestionnaireLine,DATABASE::Employee,Emp."No.");
            IF ContNo <> '' THEN BEGIN
              Emp.RESET;
              FromDate := CALCDATE(ProfileQuestionnaireLine."Starting Date Formula",Date);
              ToDate := CALCDATE(ProfileQuestionnaireLine."Ending Date Formula",Date);
              IF ToDate < FromDate THEN
                ProfileQuestionnaireLine.FIELDERROR("Ending Date Formula",
                  STRSUBSTNO(Text003,
                    ProfileQuestionnaireLine.FIELDCAPTION("Ending Date Formula"),
                    ProfileQuestionnaireLine.FIELDCAPTION("Starting Date Formula")));
              Emp.SETRANGE("Date Filter",FromDate,ToDate);
              CASE ProfileQuestionnaireLine."Employee Class. Field" OF
                ProfileQuestionnaireLine."Employee Class. Field"::"Interaction Quantity":
                  BEGIN
                    Emp.CALCFIELDS("No. of Interactions");
                    InsertEmployeeValue(ProfileQuestionnaireLine,Emp."No.",Emp."No. of Interactions",0D,0);
                  END;
                ProfileQuestionnaireLine."Employee Class. Field"::"Interaction Frequency (No./Year)":
                  BEGIN
                    Emp.CALCFIELDS("No. of Interactions");
                    NoOfYears := (ToDate - FromDate + 1) / 365;
                    InsertEmployeeValue(ProfileQuestionnaireLine,Emp."No.",Emp."No. of Interactions" / NoOfYears,0D,0);
                  END;
                ProfileQuestionnaireLine."Employee Class. Field"::"Avg. Interaction Cost (LCY)":
                  BEGIN
                    Emp.CALCFIELDS("No. of Interactions","Cost (LCY)");
                    IF Emp."No. of Interactions" <> 0 THEN
                      InsertEmployeeValue(ProfileQuestionnaireLine,Emp."No.",Emp."Cost (LCY)" / Emp."No. of Interactions",0D,0)
                    ELSE
                      InsertEmployeeValue(ProfileQuestionnaireLine,Emp."No.",0,0D,0);
                  END;
                ProfileQuestionnaireLine."Employee Class. Field"::"Avg. Interaction Duration (Min.)":
                  BEGIN
                    Emp.CALCFIELDS("No. of Interactions","Duration (Min.)");
                    IF Emp."No. of Interactions" <> 0 THEN
                      InsertEmployeeValue(ProfileQuestionnaireLine,Emp."No.",Emp."Duration (Min.)" / Emp."No. of Interactions",0D,0)
                    ELSE
                      InsertEmployeeValue(ProfileQuestionnaireLine,Emp."No.",0,0D,0);
                  END;
                ProfileQuestionnaireLine."Employee Class. Field"::"Opportunity Won (%)":
                  BEGIN
                    Emp.SETRANGE("Action Taken Filter",Emp."Action Taken Filter"::Won);
                    Emp.CALCFIELDS("No. of Opportunities");
                    WonCount := Emp."No. of Opportunities";
                    Emp.SETRANGE("Action Taken Filter",Emp."Action Taken Filter"::Lost);
                    Emp.CALCFIELDS("No. of Opportunities");
                    LostCount := Emp."No. of Opportunities";
                    IF (LostCount + WonCount) <> 0 THEN
                      InsertEmployeeValue(ProfileQuestionnaireLine,Emp."No.",100 * WonCount / (LostCount + WonCount),0D,0)
                    ELSE
                      InsertEmployeeValue(ProfileQuestionnaireLine,Emp."No.",0,0D,0);
                  END;
              END;
            END;
          UNTIL Emp.NEXT = 0
        */

    end;

    local procedure EmployeeNo(ProfileQuestionnaireLine: Record 55826; TableID: Integer; No: Code[20]) EmployeeNo: Code[20]
    var
        Emp: Record 5200;
        ProfileQuestnHeader: Record 55825;
    begin
        ProfileQuestnHeader.GET(ProfileQuestionnaireLine."Profile Questionnaire Code");
        IF TableID = DATABASE::Employee THEN
            EmployeeNo := No;
        /*
        ELSE
          WITH ContBusRel DO BEGIN
            RESET;
            SETCURRENTKEY("Link to Table","No.");
            CASE TableID OF
              DATABASE::Customer:
                SETRANGE("Link to Table","Link to Table"::Customer);
              DATABASE::Vendor:
                SETRANGE("Link to Table","Link to Table"::Vendor);
            END;
        
        
            SETRANGE("No.",No);
            IF FINDFIRST THEN
              EmployeeNo := "Employee No."
            ELSE
              EXIT('');
          END;
        */

        Emp.GET(EmployeeNo);
        /*
        IF (ProfileQuestnHeader."Employee Type" = ProfileQuestnHeader."Employee Type"::Companies) AND
           (Emp.Type <> Emp.Type::Company)
        THEN
          EXIT('');
        
        IF ProfileQuestnHeader."Business Relation Code" = '' THEN
        */
        EXIT(EmployeeNo);
        /*
        ContBusRel.RESET;
        IF TableID = DATABASE::Employee THEN
          ContBusRel.SETRANGE("Employee No.",Emp."Company No.")
        ELSE
          ContBusRel.SETRANGE("Employee No.",EmployeeNo);
        ContBusRel.SETRANGE("Business Relation Code",ProfileQuestnHeader."Business Relation Code");
        IF NOT ContBusRel.ISEMPTY THEN
          EXIT(EmployeeNo);
        EmployeeNo := '';
        */

    end;

    local procedure MarkByDefinedValue(ProfileQuestnLineQuestion: Record 55826; ProfileQuestnLineAnswer: Record 55826)
    begin
        EmployeeValue.RESET;
        IF EmployeeValue.FIND('-') THEN
            REPEAT
                IF InRange(EmployeeValue.Value, ProfileQuestnLineAnswer."From Value", ProfileQuestnLineAnswer."To Value") THEN
                    MarkEmployee(
                      ProfileQuestnLineQuestion, ProfileQuestnLineAnswer, EmployeeValue."Employee No.",
                      EmployeeValue."Last Date Updated", EmployeeValue."Questions Answered (%)")
            UNTIL EmployeeValue.NEXT = 0;
    end;

    local procedure MarkByPercentageOfValue(ProfileQuestnLineQuestion: Record 55826; ProfileQuestnLineAnswer: Record 55826)
    var
        Prc: Decimal;
    begin
        EmployeeValue.RESET;
        EmployeeValue.SETCURRENTKEY(Value);

        IF ProfileQuestnLineQuestion."Sorting Method" = ProfileQuestnLineQuestion."Sorting Method"::" " THEN
            ERROR(
              Text008,
              ProfileQuestnLineQuestion.FIELDCAPTION("Sorting Method"),
              ProfileQuestnLineQuestion."Profile Questionnaire Code",
              ProfileQuestnLineQuestion.Description);

        CASE ProfileQuestnLineQuestion."Sorting Method" OF
            ProfileQuestnLineQuestion."Sorting Method"::Descending:
                EmployeeValue.ASCENDING(FALSE);
            ProfileQuestnLineQuestion."Sorting Method"::Ascending:
                EmployeeValue.ASCENDING(TRUE);
        END;

        IF EmployeeValue.FINDSET THEN
            REPEAT
                IF TotalValue <> 0 THEN
                    Prc := ROUND(100 * EmployeeValue.Value / TotalValue, 1 / POWER(10, ProfileQuestnLineQuestion."No. of Decimals"))
                ELSE
                    Prc := 0;
                IF InRange(Prc, ProfileQuestnLineAnswer."From Value", ProfileQuestnLineAnswer."To Value") THEN
                    MarkEmployee(
                      ProfileQuestnLineQuestion, ProfileQuestnLineAnswer, EmployeeValue."Employee No.",
                      EmployeeValue."Last Date Updated", EmployeeValue."Questions Answered (%)");
            UNTIL EmployeeValue.NEXT = 0
    end;

    local procedure MarkByPercentageOfEmployee(ProfileQuestnLineQuestion: Record 55826; ProfileQuestnLineAnswer: Record 55826)
    var
        EmployeeValueCount: Integer;
        RecNo: Integer;
        Prc: Decimal;
    begin
        EmployeeValue.RESET;
        EmployeeValue.SETCURRENTKEY(Value);

        IF ProfileQuestnLineQuestion."Sorting Method" = ProfileQuestnLineQuestion."Sorting Method"::" " THEN
            ERROR(
              Text008,
              ProfileQuestnLineQuestion.FIELDCAPTION("Sorting Method"),
              ProfileQuestnLineQuestion."Profile Questionnaire Code",
              ProfileQuestnLineQuestion.Description);

        CASE ProfileQuestnLineQuestion."Sorting Method" OF
            ProfileQuestnLineQuestion."Sorting Method"::Descending:
                EmployeeValue.ASCENDING(FALSE);
            ProfileQuestnLineQuestion."Sorting Method"::Ascending:
                EmployeeValue.ASCENDING(TRUE);
        END;

        IF EmployeeValue.FIND('-') THEN BEGIN
            EmployeeValueCount := EmployeeValue.COUNT;
            RecNo := 0;
            REPEAT
                RecNo := RecNo + 1;
                Prc := ROUND(100 * RecNo / EmployeeValueCount, 1 / POWER(10, ProfileQuestnLineQuestion."No. of Decimals"));
                IF InRange(Prc, ProfileQuestnLineAnswer."From Value", ProfileQuestnLineAnswer."To Value") THEN
                    MarkEmployee(
                      ProfileQuestnLineQuestion, ProfileQuestnLineAnswer, EmployeeValue."Employee No.",
                      EmployeeValue."Last Date Updated", EmployeeValue."Questions Answered (%)")
            UNTIL EmployeeValue.NEXT = 0
        END;
    end;

    local procedure InRange(Value: Decimal; FromValue: Decimal; ToValue: Decimal): Boolean
    begin
        IF (FromValue <> 0) AND (ToValue <> 0) AND (Value >= FromValue) AND (Value <= ToValue) THEN
            EXIT(TRUE);
        IF (FromValue <> 0) AND (ToValue = 0) AND (Value >= FromValue) THEN
            EXIT(TRUE);
        IF (FromValue = 0) AND (ToValue <> 0) AND (Value <= ToValue) THEN
            EXIT(TRUE);
    end;

    local procedure MarkEmployee(ProfileQuestnLineQuestion: Record 55826; ProfileQuestnLineAnswer: Record 55826; EmpNo: Code[20]; UpdateDate: Date; QuestionsAnsweredPrc: Decimal)
    var
        Emp: Record 5200;
        EmpPers: Record 5200;
        EmpProfileAnswer: Record 55833;
        ProfileQuestnHeader2: Record 55825;
    begin
        ProfileQuestnHeader2.GET(ProfileQuestnLineQuestion."Profile Questionnaire Code");

        Emp.GET(EmpNo);
        /*
        IF (Emp.Type = Emp.Type::Company) AND
           (ProfileQuestnLineQuestion."Employee Class. Field" = ProfileQuestnLineQuestion."Employee Class. Field"::" ") AND
           (ProfileQuestnHeader2."Employee Type" <> ProfileQuestnHeader2."Employee Type"::Companies)
        THEN BEGIN
          ContPers.RESET;
          ContPers.SETCURRENTKEY("Company No.");
          ContPers.SETRANGE("Company No.",Emp."No.");
          ContPers.SETRANGE(Type,Emp.Type::Person);
          IF ContPers.FIND('-') THEN
            REPEAT
              MarkEmployee(ProfileQuestnLineQuestion,ProfileQuestnLineAnswer,ContPers."No.",UpdateDate,QuestionsAnsweredPrc);
            UNTIL ContPers.NEXT = 0
        END;
        
        IF (ProfileQuestnHeader2."Employee Type" = ProfileQuestnHeader2."Employee Type"::People) AND
           (Emp.Type <> Emp.Type::Person)
        THEN
          EXIT;
        IF (ProfileQuestnHeader2."Employee Type" = ProfileQuestnHeader2."Employee Type"::Companies) AND
           (Emp.Type <> Emp.Type::Company)
        THEN
          EXIT;
        */
        EmpProfileAnswer.INIT;
        EmpProfileAnswer."Employee No." := Emp."No.";
        EmpProfileAnswer."Profile Questionnaire Code" := ProfileQuestnLineAnswer."Profile Questionnaire Code";
        EmpProfileAnswer."Line No." := ProfileQuestnLineAnswer."Line No.";
        //ContProfileAnswer."Employee Company No." := Emp."Company No.";
        EmpProfileAnswer."Profile Questionnaire Priority" := ProfileQuestnHeader2.Priority;
        EmpProfileAnswer."Answer Priority" := ProfileQuestnLineAnswer.Priority;
        EmpProfileAnswer."Questions Answered (%)" := QuestionsAnsweredPrc;
        IF UpdateDate = 0D THEN
            EmpProfileAnswer."Last Date Updated" := TODAY
        ELSE
            EmpProfileAnswer."Last Date Updated" := UpdateDate;
        EmpProfileAnswer.INSERT;

    end;

    procedure UpdateRating(UpdateEmpNo: Code[20])
    var
        ProfileQuestnLine: Record 55826;
        ProfileQuestnLine2: Record 55826;
        Rating: Record 55829;
        RatingQuestion: Record 55829;
        Emp: Record 5200;
        Leaf: Boolean;
        Changed: Boolean;
        EmpNo: Code[20];
        NoOfRatingLines: Integer;
        RatingLineNo: Integer;
        Points: Integer;
        UpdateDate: Date;
        QuestionsAnsweredPrc: Decimal;
    begin
        // Mark all non-calculated rating questions
        ProfileQuestnLine.RESET;
        ProfileQuestnLine.SETRANGE("Employee Class. Field", ProfileQuestnLine."Employee Class. Field"::Rating);
        IF "Cab. Cuestionario Evaluacion".Code <> '' THEN
            ProfileQuestnLine.SETRANGE("Profile Questionnaire Code", "Cab. Cuestionario Evaluacion".Code);
        IF NOT ProfileQuestnLine.FIND('-') THEN
            EXIT;
        REPEAT
            ProfileQuestnLine.MARK(TRUE);
            NoOfRatingLines := NoOfRatingLines + 1;
        UNTIL ProfileQuestnLine.NEXT = 0;
        ProfileQuestnLine.MARKEDONLY(TRUE);

        // Calculate Ratings
        REPEAT
            Changed := FALSE;
            IF ProfileQuestnLine.FIND('-') THEN
                REPEAT
                    Leaf := TRUE;
                    Rating.SETRANGE("Profile Questionnaire Code", ProfileQuestnLine."Profile Questionnaire Code");
                    Rating.SETRANGE("Profile Questionnaire Line No.", ProfileQuestnLine."Line No.");
                    IF Rating.FIND('-') THEN
                        REPEAT
                            ProfileQuestnLine2.GET(Rating."Rating Profile Quest. Code", Rating."Rating Profile Quest. Line No.");
                            RatingQuestion.SETRANGE("Profile Questionnaire Code", Rating."Rating Profile Quest. Code");
                            RatingQuestion.SETRANGE("Profile Questionnaire Line No.", ProfileQuestnLine2.FindQuestionLine);
                            IF RatingQuestion.FINDFIRST THEN BEGIN
                                ProfileQuestnLine2 := ProfileQuestnLine;
                                ProfileQuestnLine.GET(
                                  RatingQuestion."Profile Questionnaire Code", RatingQuestion."Profile Questionnaire Line No.");
                                IF ProfileQuestnLine.MARK THEN
                                    Leaf := FALSE;
                                ProfileQuestnLine := ProfileQuestnLine2;
                            END;
                        UNTIL (Rating.NEXT = 0) OR (NOT Leaf);

                    // Calculate Rating
                    IF Leaf THEN BEGIN
                        IF UpdateEmpNo = '' THEN BEGIN
                            RatingLineNo := RatingLineNo + 1;
                            Window.UPDATE(1, ProfileQuestnLine."Profile Questionnaire Code");
                            Window.UPDATE(3, ProfileQuestnLine."Line No.");
                            Window.UPDATE(4, ROUND(10000 * RatingLineNo / NoOfRatingLines, 1));
                            NoOfRecs := Emp.COUNT;
                            RecCount := 0;
                            TotalValue := 0;
                        END;
                        EmployeeValue.DELETEALL;
                        AnswersExists(ProfileQuestnLine, UpdateEmpNo, TRUE);
                        IF UpdateEmpNo <> '' THEN
                            Emp.SETRANGE("No.", UpdateEmpNo);
                        IF Emp.FIND('-') THEN
                            REPEAT
                                IF UpdateEmpNo = '' THEN BEGIN
                                    RecCount := RecCount + 1;
                                    Window.UPDATE(5, Emp."No.");
                                    Window.UPDATE(6, ROUND(10000 * RecCount / NoOfRecs, 1));
                                END;
                                EmpNo := EmployeeNo(ProfileQuestnLine, DATABASE::Employee, Emp."No.");
                                IF EmpNo <> '' THEN BEGIN
                                    Points := FindEmployeeRatingValue(ProfileQuestnLine, Emp, UpdateDate, QuestionsAnsweredPrc);
                                    //GRN  IF QuestionsAnsweredPrc >= ProfileQuestnLine."Min. % Questions Answered" THEN
                                    //GRN    InsertEmployeeValue(ProfileQuestnLine,Emp."No.",Points,UpdateDate,QuestionsAnsweredPrc);
                                END;
                            UNTIL Emp.NEXT = 0;
                        MarkEmployeeByMethod(ProfileQuestnLine, UpdateEmpNo);
                        ProfileQuestnLine.MARK(FALSE);
                        Changed := TRUE;
                    END;
                UNTIL ProfileQuestnLine.NEXT = 0;
        UNTIL Changed = FALSE;

        IF ProfileQuestnLine.FIND('-') THEN
            ERROR(Text004);
    end;

    local procedure FindEmployeeRatingValue(ProfileQuestnLine: Record 55826; Emp: Record 5200; var UpdateDate: Date; var QuestionsAnsweredPrc: Decimal) Value: Decimal
    var
        Rating: Record 55829;
        ContProfileAnswer: Record 5089;
        ProfileQuestionnaireLine: Record 55826;
        TempProfileQuestnLine: Record 55826 temporary;
        NoOfAnsweredQuestions: Integer;
    begin
        UpdateDate := TODAY;
        Rating.SETRANGE("Profile Questionnaire Code", ProfileQuestnLine."Profile Questionnaire Code");
        Rating.SETRANGE("Profile Questionnaire Line No.", ProfileQuestnLine."Line No.");
        IF Rating.FIND('-') THEN
            REPEAT
                ProfileQuestionnaireLine.GET(Rating."Rating Profile Quest. Code", Rating."Rating Profile Quest. Line No.");
                ProfileQuestionnaireLine.GET(
                  ProfileQuestionnaireLine."Profile Questionnaire Code", ProfileQuestionnaireLine.FindQuestionLine);
                IF NOT TempProfileQuestnLine.GET(
                     ProfileQuestionnaireLine."Profile Questionnaire Code", ProfileQuestionnaireLine."Line No.")
                THEN BEGIN
                    TempProfileQuestnLine.INIT;
                    TempProfileQuestnLine."Profile Questionnaire Code" := ProfileQuestionnaireLine."Profile Questionnaire Code";
                    TempProfileQuestnLine."Line No." := ProfileQuestionnaireLine."Line No.";
                    TempProfileQuestnLine.INSERT;
                    IF AnswersExists(ProfileQuestionnaireLine, Emp."No.", FALSE) THEN
                        NoOfAnsweredQuestions := NoOfAnsweredQuestions + 1;
                END;

                IF ContProfileAnswer.GET(
                     Emp."No.", Rating."Rating Profile Quest. Code", Rating."Rating Profile Quest. Line No.")
                THEN BEGIN
                    Value := Value + Rating.Points;
                    IF ContProfileAnswer."Last Date Updated" < UpdateDate THEN
                        UpdateDate := ContProfileAnswer."Last Date Updated";
                END;
            UNTIL Rating.NEXT = 0;

        IF TempProfileQuestnLine.COUNT <> 0 THEN
            QuestionsAnsweredPrc := NoOfAnsweredQuestions / TempProfileQuestnLine.COUNT * 100
        ELSE
            QuestionsAnsweredPrc := 0;
    end;

    local procedure MarkEmployeeByMethod(ProfileQuestnLine: Record 55826; UpdateEmpNo: Code[20])
    var
        ProfileQuestnLine2: Record 55826;
    begin
        ProfileQuestnLine2.RESET;
        ProfileQuestnLine2 := ProfileQuestnLine;
        ProfileQuestnLine2.SETRANGE("Profile Questionnaire Code", ProfileQuestnLine."Profile Questionnaire Code");
        IF ProfileQuestnLine2.FIND('>') AND
           (ProfileQuestnLine2.Type = ProfileQuestnLine2.Type::Answer)
        THEN
            REPEAT
                IF UpdateEmpNo = '' THEN
                    Window.UPDATE(3, ProfileQuestnLine2."Line No.");
                CASE ProfileQuestnLine."Classification Method" OF
                    ProfileQuestnLine."Classification Method"::"Defined Value":
                        MarkByDefinedValue(ProfileQuestnLine, ProfileQuestnLine2);
                    ProfileQuestnLine."Classification Method"::"Percentage of Value":
                        MarkByPercentageOfValue(ProfileQuestnLine, ProfileQuestnLine2);
                    ProfileQuestnLine."Classification Method"::"Percentage of employees":
                        MarkByPercentageOfEmployee(ProfileQuestnLine, ProfileQuestnLine2);
                END;
            UNTIL (ProfileQuestnLine2.NEXT = 0) OR
                  (ProfileQuestnLine2.Type = ProfileQuestnLine2.Type::Question);
    end;
}

