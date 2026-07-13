table 34002192 "Employee Profile Answer"
{
    Caption = 'Employee Profile Answer';

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Employee;

            trigger OnValidate()
            var
                Cont: Record 5050;
            begin
                /*GRN no va
                IF Cont.GET("Employee No.") THEN
                  "Employee Company No." := Cont."Company No."
                ELSE
                  "Employee Company No." := '';
                */

            end;
        }
        field(3; "Profile Questionnaire Code"; Code[20])
        {
            Caption = 'Profile Questionnaire Code';
            NotBlank = true;
            TableRelation = "Cab. Cuestionario Evaluacion";

            trigger OnValidate()
            var
                ProfileQuestnHeader: Record 34002184;
            begin
                ProfileQuestnHeader.GET("Profile Questionnaire Code");
                "Profile Questionnaire Priority" := ProfileQuestnHeader.Priority;
            end;
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
            TableRelation = "Lin. Cuestionario Evaluacion"."Line No." WHERE("Profile Questionnaire Code" = FIELD("Profile Questionnaire Code"),
                                                                             Type = CONST(Answer));

            trigger OnValidate()
            var
                ProfileQuestnLine: Record 34002185;
            begin
                ProfileQuestnLine.GET("Profile Questionnaire Code", "Line No.");
                "Answer Priority" := ProfileQuestnLine.Priority;
            end;
        }
        field(5; Answer; Text[50])
        {
            CalcFormula = Lookup("Profile Questionnaire Line".Description WHERE("Profile Questionnaire Code" = FIELD("Profile Questionnaire Code"),
                                                                                 "Line No." = FIELD("Line No.")));
            Caption = 'Answer';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Employee Full Name"; Text[50])
        {
            CalcFormula = Lookup(Employee."Full Name" WHERE(No.=FIELD("Employee No.")));
            Caption = 'Employee Full Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8;"Profile Questionnaire Priority";Option)
        {
            Caption = 'Profile Questionnaire Priority';
            Editable = false;
            OptionCaption = 'Very Low,Low,Normal,High,Very High';
            OptionMembers = "Very Low",Low,Normal,High,"Very High";
        }
        field(9;"Answer Priority";Option)
        {
            Caption = 'Answer Priority';
            OptionCaption = 'Very Low (Hidden),Low,Normal,High,Very High';
            OptionMembers = "Very Low (Hidden)",Low,Normal,High,"Very High";
        }
        field(10;"Last Date Updated";Date)
        {
            Caption = 'Last Date Updated';
        }
        field(11;"Questions Answered (%)";Decimal)
        {
            BlankZero = true;
            Caption = 'Questions Answered (%)';
            DecimalPlaces = 0:0;
        }
        field(5088;"Profile Questionnaire Value";Text[250])
        {
            Caption = 'Profile Questionnaire Value';
        }
    }

    keys
    {
        key(Key1;"Employee No.","Profile Questionnaire Code","Line No.")
        {
        }
        key(Key2;"Employee No.","Answer Priority","Profile Questionnaire Priority")
        {
        }
        key(Key3;"Profile Questionnaire Code","Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        Employee: Record 5200;
        ProfileQuestnLine: Record 34002185;
    begin
        ProfileQuestnLine.GET("Profile Questionnaire Code",QuestionLineNo);
        ProfileQuestnLine.TESTFIELD("Auto Employee Classification",FALSE);

        IF PartOfRating THEN BEGIN
          DELETE;
          UpdateEmpClassification.UpdateRating("Employee No.");
          INSERT;
        END;

        //Esto es para poner la ult. hora de modif. Employee.TouchEmployee("Employee No.");
    end;

    trigger OnInsert()
    var
        Employee: Record 5200;
        EmpProfileAnswer: Record 34002192;
        ProfileQuestnLine: Record 34002185;
        ProfileQuestnLine2: Record 34002185;
        ProfileQuestnLine3: Record 34002185;
    begin
        ProfileQuestnLine.GET("Profile Questionnaire Code","Line No.");
        ProfileQuestnLine.TESTFIELD(Type,ProfileQuestnLine.Type::Answer);

        ProfileQuestnLine2.GET("Profile Questionnaire Code",QuestionLineNo);
        ProfileQuestnLine2.TESTFIELD("Auto Employee Classification",FALSE);

        IF NOT ProfileQuestnLine2."Multiple Answers" THEN BEGIN
          EmpProfileAnswer.RESET;
          ProfileQuestnLine3.RESET;
          ProfileQuestnLine3.SETRANGE("Profile Questionnaire Code","Profile Questionnaire Code");
          ProfileQuestnLine3.SETRANGE(Type,ProfileQuestnLine3.Type::Question);
          ProfileQuestnLine3.SETFILTER("Line No.",'>%1',ProfileQuestnLine2."Line No.");
          IF ProfileQuestnLine3.FINDFIRST THEN
            EmpProfileAnswer.SETRANGE(
              "Line No.",ProfileQuestnLine2."Line No.",ProfileQuestnLine3."Line No.")
          ELSE
            EmpProfileAnswer.SETFILTER("Line No.",'>%1',ProfileQuestnLine2."Line No.");
          EmpProfileAnswer.SETRANGE("Employee No.","Employee No.");
          EmpProfileAnswer.SETRANGE("Profile Questionnaire Code","Profile Questionnaire Code");
          IF NOT EmpProfileAnswer.ISEMPTY THEN
            ERROR(Text000,ProfileQuestnLine2.FIELDCAPTION("Multiple Answers"));
        END;

        IF PartOfRating THEN BEGIN
          INSERT;
          UpdateEmpClassification.UpdateRating("Employee No.");
          DELETE;
        END;

        //Esto es para poner la ult. hora de modif. Employee.TouchEmployee("Employee No.");
    end;

    trigger OnModify()
    var
        Contact: Record 5050;
    begin
        //Esto es para poner la ult. hora de modif. Employee.TouchEmployee("Employee No.");
    end;

    trigger OnRename()
    var
        Contact: Record 5050;
    begin
        /*
        //Esto es para poner la ult. hora de modif.
        IF xRec."Employee No." = "Employee No." THEN
          Employee.TouchEmployee("Employee No.")
        ELSE BEGIN
          Employee.TouchEmployee("Employee No.");
          Employee.TouchEmployee(xRec."Employee No.");
        END;
        */

    end;

    var
        Text000: Label 'This Question does not allow %1.';
        UpdateEmpClassification: Report 34002170;

    [Scope('Personalization')]
    procedure Question(): Text[50]
    var
        ProfileQuestnLine: Record 34002185;
    begin
        IF ProfileQuestnLine.GET("Profile Questionnaire Code", QuestionLineNo) THEN
            EXIT(ProfileQuestnLine.Description)
    end;

    local procedure QuestionLineNo(): Integer
    var
        ProfileQuestnLine: Record 34002185;
    begin
        WITH ProfileQuestnLine DO BEGIN
            RESET;
            SETRANGE("Profile Questionnaire Code", Rec."Profile Questionnaire Code");
            SETFILTER("Line No.", '<%1', Rec."Line No.");
            SETRANGE(Type, Type::Question);
            IF FINDLAST THEN
                EXIT("Line No.")
        END;
    end;

    local procedure PartOfRating(): Boolean
    var
        Rating: Record 34002188;
        ProfileQuestnLine: Record 34002185;
        ProfileQuestnLine2: Record 34002185;
    begin
        Rating.SETCURRENTKEY("Rating Profile Quest. Code", "Rating Profile Quest. Line No.");
        Rating.SETRANGE("Rating Profile Quest. Code", "Profile Questionnaire Code");

        ProfileQuestnLine.GET("Profile Questionnaire Code", "Line No.");
        ProfileQuestnLine.GET("Profile Questionnaire Code", ProfileQuestnLine.FindQuestionLine);

        ProfileQuestnLine2 := ProfileQuestnLine;
        ProfileQuestnLine2.SETRANGE(Type, ProfileQuestnLine2.Type::Question);
        ProfileQuestnLine2.SETRANGE("Profile Questionnaire Code", ProfileQuestnLine2."Profile Questionnaire Code");
        IF ProfileQuestnLine2.NEXT <> 0 THEN
            Rating.SETRANGE("Rating Profile Quest. Line No.", ProfileQuestnLine."Line No.", ProfileQuestnLine2."Line No.")
        ELSE
            Rating.SETFILTER("Rating Profile Quest. Line No.", '%1..', ProfileQuestnLine."Line No.");

        EXIT(Rating.FINDFIRST);
    end;
}

