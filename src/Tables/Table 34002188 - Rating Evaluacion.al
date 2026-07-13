table 34002188 "Rating Evaluacion"
{
    Caption = 'Rating';

    fields
    {
        field(1; "Profile Questionnaire Code"; Code[20])
        {
            Caption = 'Profile Questionnaire Code';
            NotBlank = true;
            TableRelation = "Cab. Cuestionario Evaluacion";
        }
        field(2; "Profile Questionnaire Line No."; Integer)
        {
            Caption = 'Profile Questionnaire Line No.';
            NotBlank = true;
            //TODO: Ver TableRelation = "Lin. Cuestionario Evaluacion"."Line No." WHERE("Profile Questionnaire Code" = FIELD("Profile Questionnaire Code"),
            //TODO: Ver                                                                  Type = CONST(Question),
            //TODO: Ver                                                                  "Class. Field" = CONST(Rating));
        }
        field(3; "Rating Profile Quest. Code"; Code[20])
        {
            Caption = 'Rating Profile Quest. Code';
            NotBlank = true;
            TableRelation = "Cab. Cuestionario Evaluacion";
        }
        field(4; "Rating Profile Quest. Line No."; Integer)
        {
            Caption = 'Rating Profile Quest. Line No.';
            NotBlank = true;
            TableRelation = "Lin. Cuestionario Evaluacion"."Line No." WHERE("Profile Questionnaire Code" = FIELD("Rating Profile Quest. Code"),
                                                                             Type = CONST(Answer));
        }
        field(5; Points; Decimal)
        {
            BlankZero = true;
            Caption = 'Points';
            DecimalPlaces = 0 : 0;
        }
        field(6; "Profile Question Description"; Text[50])
        {
            CalcFormula = Lookup("Lin. Cuestionario Evaluacion".Description WHERE("Profile Questionnaire Code" = FIELD("Profile Questionnaire Code"),
                                                                                   "Line No." = FIELD("Profile Questionnaire Line No.")));
            Caption = 'Profile Question Description';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Profile Questionnaire Code", "Profile Questionnaire Line No.", "Rating Profile Quest. Code", "Rating Profile Quest. Line No.")
        {
        }
        key(Key2; "Rating Profile Quest. Code", "Rating Profile Quest. Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        ProfileQuestionnaireLine: Record 34002185;
    begin
        ProfileQuestionnaireLine.GET("Profile Questionnaire Code", "Profile Questionnaire Line No.");
        CALCFIELDS("Profile Question Description");
        ErrorMessage := "Profile Question Description";
        IF RatingDeadlock(ProfileQuestionnaireLine, Rec) THEN
            ERROR(COPYSTR(
                STRSUBSTNO(Text000, ProfileQuestionnaireLine.Description) +
                "Profile Question Description" + ' -> ' + ErrorMessage, 1, 1024));
    end;

    var
        Text000: Label 'Rating deadlock involving question %1 - insert aborted.\';
        ErrorMessage: Text[1024];

    local procedure RatingDeadlock(TargetProfileQuestnLine: Record 34002185; NextRating: Record 34002188) Deadlock: Boolean
    var
        Rating2: Record 34002188;
        ProfileQuestionnaireLine: Record 34002185;
    begin
        Deadlock := FALSE;
        ProfileQuestionnaireLine.GET(NextRating."Rating Profile Quest. Code", NextRating."Rating Profile Quest. Line No.");

        Rating2.SETRANGE("Profile Questionnaire Code", NextRating."Rating Profile Quest. Code");
        Rating2.SETRANGE("Profile Questionnaire Line No.", ProfileQuestionnaireLine.FindQuestionLine);
        IF Rating2.FIND('-') THEN
            REPEAT
                ProfileQuestionnaireLine.GET(Rating2."Rating Profile Quest. Code", Rating2."Rating Profile Quest. Line No.");
                ProfileQuestionnaireLine.GET(Rating2."Rating Profile Quest. Code", ProfileQuestionnaireLine.FindQuestionLine);
                IF (TargetProfileQuestnLine."Profile Questionnaire Code" = ProfileQuestionnaireLine."Profile Questionnaire Code") AND
                   (TargetProfileQuestnLine."Line No." = ProfileQuestionnaireLine."Line No.")
                THEN
                    Deadlock := TRUE
                ELSE
                    IF RatingDeadlock(TargetProfileQuestnLine, Rating2) THEN
                        Deadlock := TRUE;
            UNTIL (Deadlock = TRUE) OR (Rating2.NEXT = 0);

        IF Deadlock THEN BEGIN
            Rating2.CALCFIELDS("Profile Question Description");
            ErrorMessage := COPYSTR(Rating2."Profile Question Description" + ' -> ' + ErrorMessage, 1, 1024);
        END;
    end;
}

