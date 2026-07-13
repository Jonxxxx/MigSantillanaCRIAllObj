table 34002185 "Lin. Cuestionario Evaluacion"
{
    Caption = 'Profile Questionnaire Line';
    DataCaptionFields = "Profile Questionnaire Code", Description;
    //TODO: Ver LookupPageID = 34002210;

    fields
    {
        field(1; "Profile Questionnaire Code"; Code[20])
        {
            Caption = 'Profile Questionnaire Code';
            TableRelation = "Cab. Cuestionario Evaluacion";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Question,Answer';
            OptionMembers = Question,Answer;

            trigger OnValidate()
            begin
                CASE Type OF
                    Type::Question:
                        BEGIN
                            CALCFIELDS("No. of Employee");
                            TESTFIELD("No. of Employee", 0);
                            TESTFIELD("From Value", 0);
                            TESTFIELD("To Value", 0);
                        END;
                    Type::Answer:
                        BEGIN
                            TESTFIELD("Multiple Answers", FALSE);
                            //      TESTFIELD("Auto Employee Classification",FALSE);
                            //      TESTFIELD("Customer Class. Field",0);
                            //      TESTFIELD("Vendor Class. Field",0);
                            ///TESTFIELD("employee Class. Field",0);
                            TESTFIELD("Starting Date Formula", ZeroDateFormula);
                            TESTFIELD("Ending Date Formula", ZeroDateFormula);
                            TESTFIELD("Classification Method", 0);
                            TESTFIELD("Sorting Method", 0);
                            TESTFIELD("No. of Decimals", 0);
                        END;
                END;
            end;
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
            NotBlank = true;
        }
        field(5; "Multiple Answers"; Boolean)
        {
            Caption = 'Multiple Answers';

            trigger OnValidate()
            begin
                IF "Multiple Answers" THEN
                    TESTFIELD(Type, Type::Question);
            end;
        }
        field(6; "Auto Employee Classification"; Boolean)
        {
            Caption = 'Auto Employee Classification';

            trigger OnValidate()
            begin
                /*
                IF "Auto Employee Classification" THEN
                  TESTFIELD(Type,Type::Question)
                ELSE BEGIN
                  TESTFIELD("Customer Class. Field","Customer Class. Field"::" ");
                  TESTFIELD("Vendor Class. Field","Vendor Class. Field"::" ");
                  TESTFIELD("Employee Class. Field","Employee Class. Field"::" ");
                  TESTFIELD("Starting Date Formula",ZeroDateFormula);
                  TESTFIELD("Ending Date Formula",ZeroDateFormula);
                  TESTFIELD("Classification Method","Classification Method"::" ");
                  TESTFIELD("Sorting Method","Sorting Method"::" ");
                END;
                */

            end;
        }
        field(9; "Employee Class. Field"; Option)
        {
            Caption = 'Employee Class. Field';
            OptionCaption = ' ,Interaction Quantity,Interaction Frequency (No./Year),Avg. Interaction Cost ($),Avg. Interaction Duration (Min.),Opportunity Won (%),Rating';
            OptionMembers = " ","Interaction Quantity","Interaction Frequency (No./Year)","Avg. Interaction Cost (LCY)","Avg. Interaction Duration (Min.)","Opportunity Won (%)",Rating;

            trigger OnValidate()
            var
                Rating: Record "5111";
            begin
                IF xRec."Employee Class. Field" = "Employee Class. Field"::Rating THEN BEGIN
                    Rating.SETRANGE("Profile Questionnaire Code", "Profile Questionnaire Code");
                    Rating.SETRANGE("Profile Questionnaire Line No.", "Line No.");
                    IF Rating.FINDFIRST THEN
                        IF CONFIRM(Text000, FALSE) THEN
                            Rating.DELETEALL
                        ELSE
                            ERROR(Text001, FIELDCAPTION("Employee Class. Field"));
                END;

                IF "Employee Class. Field" <> "Employee Class. Field"::" " THEN BEGIN
                    TESTFIELD(Type, Type::Question);
                    //  CLEAR("Customer Class. Field");
                    //  CLEAR("Vendor Class. Field");
                    IF ("Classification Method" = "Classification Method"::" ") OR
                       ("Employee Class. Field" = "Employee Class. Field"::Rating)
                    THEN BEGIN
                        "Classification Method" := "Classification Method"::"Defined Value";
                        "Sorting Method" := "Sorting Method"::" ";
                    END;
                    IF "Employee Class. Field" = "Employee Class. Field"::Rating THEN BEGIN
                        CLEAR("Starting Date Formula");
                        CLEAR("Ending Date Formula");
                    END;
                END ELSE
                    ResetFields;
            end;
        }
        field(10; "Starting Date Formula"; DateFormula)
        {
            Caption = 'Starting Date Formula';

            trigger OnValidate()
            begin
                IF FORMAT("Starting Date Formula") <> '' THEN
                    TESTFIELD(Type, Type::Question);
            end;
        }
        field(11; "Ending Date Formula"; DateFormula)
        {
            Caption = 'Ending Date Formula';

            trigger OnValidate()
            begin
                IF FORMAT("Ending Date Formula") <> '' THEN
                    TESTFIELD(Type, Type::Question);
            end;
        }
        field(12; "Classification Method"; Option)
        {
            Caption = 'Classification Method';
            OptionCaption = ' ,Defined Value,Percentage of Value,Percentage of Employees';
            OptionMembers = " ","Defined Value","Percentage of Value","Percentage of employees";

            trigger OnValidate()
            begin
                IF "Classification Method" <> "Classification Method"::" " THEN BEGIN
                    TESTFIELD(Type, Type::Question);
                    IF "Classification Method" <> "Classification Method"::"Defined Value" THEN
                        "Sorting Method" := ProfileQuestnLine."Sorting Method"::Descending
                    ELSE
                        "Sorting Method" := ProfileQuestnLine."Sorting Method"::" ";
                END ELSE
                    "Sorting Method" := ProfileQuestnLine."Sorting Method"::" ";
            end;
        }
        field(13; "Sorting Method"; Option)
        {
            Caption = 'Sorting Method';
            OptionCaption = ' ,Descending,Ascending';
            OptionMembers = " ","Descending","Ascending";

            trigger OnValidate()
            begin
                IF "Sorting Method" <> "Sorting Method"::" " THEN
                    TESTFIELD(Type, Type::Question);
            end;
        }
        field(14; "From Value"; Decimal)
        {
            BlankZero = true;
            Caption = 'From Value';
            DecimalPlaces = 0 : 25;

            trigger OnValidate()
            begin
                IF "From Value" <> 0 THEN
                    TESTFIELD(Type, Type::Answer);
            end;
        }
        field(15; "To Value"; Decimal)
        {
            BlankZero = true;
            Caption = 'To Value';
            DecimalPlaces = 0 : 25;

            trigger OnValidate()
            begin
                IF "To Value" <> 0 THEN
                    TESTFIELD(Type, Type::Answer);
            end;
        }
        field(16; "No. of Employee"; Integer)
        {
            BlankZero = true;
            CalcFormula = Count("Employee Profile Answer" WHERE(Profile Questionnaire Code=FIELD(Profile Questionnaire Code),
                                                                 Line No.=FIELD(Line No.)));
            Caption = 'No. of Employee';
            Editable = false;
            FieldClass = FlowField;
        }
        field(17;Priority;Option)
        {
            Caption = 'Priority';
            InitValue = Normal;
            OptionCaption = 'Very Low (Hidden),Low,Normal,High,Very High';
            OptionMembers = "Very Low (Hidden)",Low,Normal,High,"Very High";

            trigger OnValidate()
            var
                EmpProfileAnswer: Record "34002192";
            begin
                TESTFIELD(Type,Type::Answer);
                EmpProfileAnswer.SETCURRENTKEY("Profile Questionnaire Code","Line No.");
                EmpProfileAnswer.SETRANGE("Profile Questionnaire Code","Profile Questionnaire Code");
                EmpProfileAnswer.SETRANGE("Line No.","Line No.");
                EmpProfileAnswer.MODIFYALL("Answer Priority",Priority);
                MODIFY;
            end;
        }
        field(18;"No. of Decimals";Integer)
        {
            Caption = 'No. of Decimals';
            MaxValue = 25;
            MinValue = -25;

            trigger OnValidate()
            begin
                IF "No. of Decimals" <> 0 THEN
                  TESTFIELD(Type,Type::Question);
            end;
        }
        field(19;"Min. % Questions Answered";Decimal)
        {
            Caption = 'Min. % Questions Answered';
            DecimalPlaces = 0:0;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                IF "Min. % Questions Answered" <> 0 THEN BEGIN
                  TESTFIELD(Type,Type::Question);
                  TESTFIELD("Employee Class. Field","Employee Class. Field"::Rating);
                END;
            end;
        }
        field(9501;"Wizard Step";Option)
        {
            Caption = 'Wizard Step';
            Editable = false;
            OptionCaption = ' ,1,2,3,4,5,6';
            OptionMembers = " ","1","2","3","4","5","6";
        }
        field(9502;"Interval Option";Option)
        {
            Caption = 'Interval Option';
            OptionCaption = 'Minimum,Maximum,Interval';
            OptionMembers = Minimum,Maximum,Interval;
        }
        field(9503;"Answer Option";Option)
        {
            Caption = 'Answer Option';
            OptionCaption = 'HighLow,ABC,Custom';
            OptionMembers = HighLow,ABC,Custom;
        }
        field(9504;"Answer Description";Text[50])
        {
            Caption = 'Answer Description';
        }
        field(9505;"Wizard From Value";Decimal)
        {
            BlankZero = true;
            Caption = 'Wizard From Value';
            DecimalPlaces = 0:25;

            trigger OnValidate()
            begin
                IF "From Value" <> 0 THEN
                  TESTFIELD(Type,Type::Answer);
            end;
        }
        field(9506;"Wizard To Value";Decimal)
        {
            BlankZero = true;
            Caption = 'Wizard To Value';
            DecimalPlaces = 0:25;

            trigger OnValidate()
            begin
                IF "To Value" <> 0 THEN
                  TESTFIELD(Type,Type::Answer);
            end;
        }
        field(9707;"Wizard From Line No.";Integer)
        {
            BlankZero = true;
            Caption = 'Wizard From Line No.';

            trigger OnValidate()
            begin
                IF "To Value" <> 0 THEN
                  TESTFIELD(Type,Type::Answer);
            end;
        }
    }

    keys
    {
        key(Key1;"Profile Questionnaire Code","Line No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(Brick;Type,Description,Priority,"Multiple Answers","Auto Employee Classification","No. of Employee")
        {
        }
    }

    trigger OnDelete()
    var
        Rating: Record "5111";
        ProfileQuestionnaireLine: Record "5088";
    begin
        CALCFIELDS("No. of Employee");
        TESTFIELD("No. of Employee",0);

        Rating.SETRANGE("Rating Profile Quest. Code","Profile Questionnaire Code");
        Rating.SETRANGE("Rating Profile Quest. Line No.","Line No.");
        IF NOT Rating.ISEMPTY THEN
          ERROR(Text002);

        Rating.RESET;
        Rating.SETRANGE("Profile Questionnaire Code","Profile Questionnaire Code");
        Rating.SETRANGE("Profile Questionnaire Line No.","Line No.");
        IF NOT Rating.ISEMPTY THEN
          ERROR(Text003);

        IF Type = Type::Question THEN BEGIN
          ProfileQuestionnaireLine.GET("Profile Questionnaire Code","Line No.");
          IF (ProfileQuestionnaireLine.NEXT <> 0) AND
             (ProfileQuestionnaireLine.Type = ProfileQuestnLine.Type::Answer)
          THEN
            ERROR(Text004);
        END;
    end;

    var
        ProfileQuestnLine: Record "34002185";
        TempProfileQuestionnaireLine: Record "34002185" temporary;
        ZeroDateFormula: DateFormula;
        Text000: Label 'Do you want to delete the rating values?';
        Text001: Label '%1 cannot be changed until the rating value is deleted.';
        Text002: Label 'You cannot delete this line because one or more questions are depending on it.';
        Text003: Label 'You cannot delete this line because one or more rating values exists.';
        Text004: Label 'You cannot delete this question while answers exists.';
        Text005: Label 'Please select for which questionnaire this rating should be created.';
        Text006: Label 'Please describe the rating.';
        Text007: Label 'Please create one or more different answers.';
        Text008: Label 'Please enter which range of points this answer should require.';
        Text009: Label 'High';
        Text010: Label 'Low';
        Text011: Label 'A', Comment='Selecting answer A';
        Text012: Label 'B', Comment='Selecting answer B';
        Text013: Label 'C', Comment='Selecting answer C';

    [Scope('Personalization')]
    procedure MoveUp()
    var
        UpperProfileQuestnLine: Record "34002185";
        LineNo: Integer;
        UpperRecLineNo: Integer;
    begin
        TESTFIELD(Type,Type::Answer);
        UpperProfileQuestnLine.SETRANGE("Profile Questionnaire Code","Profile Questionnaire Code");
        LineNo := "Line No.";
        UpperProfileQuestnLine.GET("Profile Questionnaire Code","Line No.");

        IF UpperProfileQuestnLine.FIND('<') AND
           (UpperProfileQuestnLine.Type = UpperProfileQuestnLine.Type::Answer)
        THEN BEGIN
          UpperRecLineNo := UpperProfileQuestnLine."Line No.";
          RENAME("Profile Questionnaire Code",-1);
          UpperProfileQuestnLine.RENAME("Profile Questionnaire Code",LineNo);
          RENAME("Profile Questionnaire Code",UpperRecLineNo);
        END;
    end;

    [Scope('Personalization')]
    procedure MoveDown()
    var
        LowerProfileQuestnLine: Record "34002185";
        LineNo: Integer;
        LowerRecLineNo: Integer;
    begin
        TESTFIELD(Type,Type::Answer);
        LowerProfileQuestnLine.SETRANGE("Profile Questionnaire Code","Profile Questionnaire Code");
        LineNo := "Line No.";
        LowerProfileQuestnLine.GET("Profile Questionnaire Code","Line No.");

        IF LowerProfileQuestnLine.FIND('>') AND
           (LowerProfileQuestnLine.Type = LowerProfileQuestnLine.Type::Answer)
        THEN BEGIN
          LowerRecLineNo := LowerProfileQuestnLine."Line No.";
          RENAME("Profile Questionnaire Code",-1);
          LowerProfileQuestnLine.RENAME("Profile Questionnaire Code",LineNo);
          RENAME("Profile Questionnaire Code",LowerRecLineNo);
        END;
    end;

    [Scope('Personalization')]
    procedure Question(): Text[50]
    begin
        ProfileQuestnLine.RESET;
        ProfileQuestnLine.SETRANGE("Profile Questionnaire Code","Profile Questionnaire Code");
        ProfileQuestnLine.SETFILTER("Line No.",'<%1',"Line No.");
        ProfileQuestnLine.SETRANGE(Type,Type::Question);
        IF ProfileQuestnLine.FINDLAST THEN
          EXIT(ProfileQuestnLine.Description);
    end;

    [Scope('Personalization')]
    procedure FindQuestionLine(): Integer
    begin
        ProfileQuestnLine.RESET;
        ProfileQuestnLine.SETRANGE("Profile Questionnaire Code","Profile Questionnaire Code");
        ProfileQuestnLine.SETFILTER("Line No.",'<%1',"Line No.");
        ProfileQuestnLine.SETRANGE(Type,Type::Question);
        IF ProfileQuestnLine.FINDLAST THEN
          EXIT(ProfileQuestnLine."Line No.");
    end;

    local procedure ResetFields()
    begin
        CLEAR("Starting Date Formula");
        CLEAR("Ending Date Formula");
        "Classification Method" := "Classification Method"::" ";
        "Sorting Method" := "Sorting Method"::" ";
        "No. of Decimals" := 0;
        "Min. % Questions Answered" := 0;
    end;

    [Scope('Personalization')]
    procedure CreateRatingFromProfQuestnLine(var ProfileQuestnLine: Record "34002185")
    begin
        INIT;
        "Profile Questionnaire Code" := ProfileQuestnLine."Profile Questionnaire Code";
        StartWizard;
    end;

    local procedure StartWizard()
    begin
        "Wizard Step" := "Wizard Step"::"1";
        VALIDATE("Auto Employee Classification",TRUE);
        VALIDATE("Employee Class. Field","Employee Class. Field"::Rating);
        INSERT;

        ValidateAnswerOption;
        ValidateIntervalOption;

        PAGE.RUNMODAL(PAGE::"Create Rating",Rec);
    end;

    [Scope('Personalization')]
    procedure CheckStatus()
    begin
        CASE "Wizard Step" OF
          "Wizard Step"::"1":
            BEGIN
              IF "Profile Questionnaire Code" = '' THEN
                ERROR(Text005);
              IF Description = '' THEN
                ERROR(Text006);
            END;
          "Wizard Step"::"2":
            BEGIN
              IF TempProfileQuestionnaireLine.COUNT = 0 THEN
                ERROR(Text007);
            END;
          "Wizard Step"::"3":
            IF ("Wizard From Value" = 0) AND ("Wizard To Value" = 0) THEN
              ERROR(Text008);
        END;
    end;

    [Scope('Personalization')]
    procedure PerformNextWizardStatus()
    begin
        CASE "Wizard Step" OF
          "Wizard Step"::"1":
            "Wizard Step" := "Wizard Step" + 1;
          "Wizard Step"::"2":
            BEGIN
              "Wizard From Line No." := 0;
              "Wizard Step" := "Wizard Step" + 1;
              TempProfileQuestionnaireLine.SETRANGE("Line No.");
              TempProfileQuestionnaireLine.FIND('-');
              SetIntervalOption;
            END;
          "Wizard Step"::"3":
            BEGIN
              TempProfileQuestionnaireLine.SETFILTER("Line No.",'%1..',"Wizard From Line No.");
              TempProfileQuestionnaireLine.FIND('-');
              TempProfileQuestionnaireLine."From Value" := "Wizard From Value";
              TempProfileQuestionnaireLine."To Value" := "Wizard To Value";
              TempProfileQuestionnaireLine.MODIFY;
              IF TempProfileQuestionnaireLine.NEXT <> 0 THEN BEGIN
                TempProfileQuestionnaireLine.SETRANGE("Line No.",TempProfileQuestionnaireLine."Line No.");
                "Wizard From Line No." := TempProfileQuestionnaireLine."Line No.";
                "Wizard From Value" := TempProfileQuestionnaireLine."From Value";
                "Wizard To Value" := TempProfileQuestionnaireLine."To Value";
                SetIntervalOption;
              END ELSE BEGIN
                TempProfileQuestionnaireLine.SETRANGE("Line No.");
                TempProfileQuestionnaireLine.FIND('-');
                "Wizard Step" := "Wizard Step" + 1;
              END;
            END;
        END;
    end;

    [Scope('Personalization')]
    procedure PerformPrevWizardStatus()
    begin
        CASE "Wizard Step" OF
          "Wizard Step"::"3":
            BEGIN
              TempProfileQuestionnaireLine.SETFILTER("Line No.",'..%1',"Wizard From Line No.");
              IF TempProfileQuestionnaireLine.FIND('+') THEN BEGIN
                TempProfileQuestionnaireLine."From Value" := "Wizard From Value";
                TempProfileQuestionnaireLine."To Value" := "Wizard To Value";
                TempProfileQuestionnaireLine.MODIFY;
              END;
              IF TempProfileQuestionnaireLine.NEXT(-1) <> 0 THEN BEGIN
                "Wizard From Line No." := TempProfileQuestionnaireLine."Line No.";
                "Wizard From Value" := TempProfileQuestionnaireLine."From Value";
                "Wizard To Value" := TempProfileQuestionnaireLine."To Value";
                SetIntervalOption
              END ELSE BEGIN
                TempProfileQuestionnaireLine.SETRANGE("Line No.");
                TempProfileQuestionnaireLine.FIND('-');
                "Wizard Step" := "Wizard Step" - 1;
              END;
            END;
          ELSE
            "Wizard Step" := "Wizard Step" - 1;
        END;
    end;

    [Scope('Personalization')]
    procedure FinishWizard()
    var
        ProfileQuestionnaireLine: Record "34002185";
        ProfileMgt: Codeunit "34002122";
        NextLineNo: Integer;
        QuestionLineNo: Integer;
    begin
        ProfileQuestionnaireLine.SETRANGE("Profile Questionnaire Code","Profile Questionnaire Code");
        IF ProfileQuestionnaireLine.FINDLAST THEN
          QuestionLineNo := ProfileQuestionnaireLine."Line No." + 10000
        ELSE
          QuestionLineNo := 10000;

        ProfileQuestionnaireLine := Rec;
        ProfileQuestionnaireLine."Line No." := QuestionLineNo;
        ProfileQuestionnaireLine.INSERT(TRUE);

        NextLineNo := QuestionLineNo;
        TempProfileQuestionnaireLine.RESET;
        IF TempProfileQuestionnaireLine.FINDSET THEN
          REPEAT
            NextLineNo := NextLineNo + 10000;
            ProfileQuestionnaireLine := TempProfileQuestionnaireLine;
            ProfileQuestionnaireLine."Profile Questionnaire Code" := "Profile Questionnaire Code";
            ProfileQuestionnaireLine."Line No." := NextLineNo;
            ProfileQuestionnaireLine.INSERT(TRUE);
          UNTIL TempProfileQuestionnaireLine.NEXT = 0;

        COMMIT;

        ProfileQuestionnaireLine.GET("Profile Questionnaire Code",QuestionLineNo);
        ProfileMgt.ShowAnswerPoints(ProfileQuestionnaireLine);
    end;

    [Scope('Personalization')]
    procedure SetIntervalOption()
    begin
        CASE TRUE OF
          (TempProfileQuestionnaireLine."From Value" = 0) AND (TempProfileQuestionnaireLine."To Value" <> 0):
            "Interval Option" := "Interval Option"::Maximum;
          (TempProfileQuestionnaireLine."From Value" <> 0) AND (TempProfileQuestionnaireLine."To Value" = 0):
            "Interval Option" := "Interval Option"::Minimum
          ELSE
            "Interval Option" := "Interval Option"::Interval
        END;

        ValidateIntervalOption;
    end;

    [Scope('Personalization')]
    procedure ValidateIntervalOption()
    begin
        TempProfileQuestionnaireLine.SETFILTER("Line No.",'%1..',"Wizard From Line No.");
        TempProfileQuestionnaireLine.FIND('-');
        IF "Interval Option" = "Interval Option"::Minimum THEN
          TempProfileQuestionnaireLine."To Value" := 0;
        IF "Interval Option" = "Interval Option"::Maximum THEN
          TempProfileQuestionnaireLine."From Value" := 0;
        TempProfileQuestionnaireLine.MODIFY;
    end;

    [Scope('Personalization')]
    procedure ValidateAnswerOption()
    begin
        IF "Answer Option" = "Answer Option"::Custom THEN
          EXIT;

        TempProfileQuestionnaireLine.DELETEALL;

        CASE "Answer Option" OF
          "Answer Option"::HighLow:
            BEGIN
              CreateAnswer(Text009);
              CreateAnswer(Text010);
            END;
          "Answer Option"::ABC:
            BEGIN
              CreateAnswer(Text011);
              CreateAnswer(Text012);
              CreateAnswer(Text013);
            END;
        END;
    end;

    local procedure CreateAnswer(AnswerDescription: Text[50])
    begin
        TempProfileQuestionnaireLine.INIT;
        TempProfileQuestionnaireLine."Line No." := (TempProfileQuestionnaireLine.COUNT + 1) * 10000;
        TempProfileQuestionnaireLine.Type := TempProfileQuestionnaireLine.Type::Answer;
        TempProfileQuestionnaireLine.Description := AnswerDescription;
        TempProfileQuestionnaireLine.INSERT;
    end;

    [Scope('Personalization')]
    procedure NoOfProfileAnswers(): Decimal
    begin
        EXIT(TempProfileQuestionnaireLine.COUNT);
    end;

    [Scope('Personalization')]
    procedure ShowAnswers()
    var
        TempProfileQuestionnaireLine2: Record "34002185" temporary;
    begin
        IF "Answer Option" <> "Answer Option"::Custom THEN
          IF TempProfileQuestionnaireLine.FIND('-') THEN
            REPEAT
              TempProfileQuestionnaireLine2 := TempProfileQuestionnaireLine;
              TempProfileQuestionnaireLine2.INSERT;
            UNTIL TempProfileQuestionnaireLine.NEXT = 0;

        PAGE.RUNMODAL(PAGE::"Rating Answers",TempProfileQuestionnaireLine);

        IF "Answer Option" <> "Answer Option"::Custom THEN
          IF TempProfileQuestionnaireLine.COUNT <> TempProfileQuestionnaireLine2.COUNT THEN
            "Answer Option" := "Answer Option"::Custom
          ELSE BEGIN
            IF TempProfileQuestionnaireLine.FIND('-') THEN
              REPEAT
                IF NOT TempProfileQuestionnaireLine2.GET(
                     TempProfileQuestionnaireLine."Profile Questionnaire Code",TempProfileQuestionnaireLine."Line No.")
                THEN
                  "Answer Option" := "Answer Option"::Custom
                ELSE
                  IF TempProfileQuestionnaireLine.Description <> TempProfileQuestionnaireLine2.Description THEN
                    "Answer Option" := "Answer Option"::Custom
              UNTIL (TempProfileQuestionnaireLine.NEXT = 0) OR ("Answer Option" = "Answer Option"::Custom);
          END;
    end;

    [Scope('Personalization')]
    procedure GetProfileLineAnswerDesc(): Text[100]
    begin
        TempProfileQuestionnaireLine.SETFILTER("Line No.",'%1..',"Wizard From Line No.");
        TempProfileQuestionnaireLine.FIND('-');
        EXIT(TempProfileQuestionnaireLine.Description);
    end;

    [Scope('Personalization')]
    procedure GetAnswers(var ProfileQuestionnaireLine: Record "34002185")
    begin
        TempProfileQuestionnaireLine.RESET;
        ProfileQuestionnaireLine.RESET;
        ProfileQuestionnaireLine.DELETEALL;
        IF TempProfileQuestionnaireLine.FIND('-') THEN
          REPEAT
            ProfileQuestionnaireLine.INIT;
            ProfileQuestionnaireLine := TempProfileQuestionnaireLine;
            ProfileQuestionnaireLine.INSERT;
          UNTIL TempProfileQuestionnaireLine.NEXT = 0;
    end;
}

