table 34002194 "Preguntas Cuest. Evaluacion"
{
    Caption = 'Contact Profile Answer';
    DrillDownPageID = 5115;

    fields
    {
        field(1; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            NotBlank = true;
            TableRelation = Contact;

            trigger OnValidate()
            var
                Cont: Record 5050;
            begin
                /*
                IF Cont.GET(Desde) THEN
                  "Cantidad de dias" := Cont."Company No."
                ELSE
                  "Cantidad de dias" := '';
                */

            end;
        }
        field(2; "Contact Company No."; Code[20])
        {
            Caption = 'Contact Company No.';
            NotBlank = true;
            TableRelation = Contact WHERE(Type = CONST(Company));
        }
        field(3; "Profile Questionnaire Code"; Code[20])
        {
            Caption = 'Profile Questionnaire Code';
            NotBlank = true;
            TableRelation = "Cab. Cuestionario Evaluacion";

            trigger OnValidate()
            var
                ProfileQuestnHeader: Record 5087;
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
                ProfileQuestnLine: Record 5088;
            begin
                ProfileQuestnLine.GET("Profile Questionnaire Code", "Line No.");
                "Answer Priority" := ProfileQuestnLine.Priority;
            end;
        }
        field(5; Answer; Text[50])
        {
            CalcFormula = Lookup("Lin. Cuestionario Evaluacion".Description WHERE("Profile Questionnaire Code" = FIELD("Profile Questionnaire Code"),
                                                                                   "Line No." = FIELD("Line No.")));
            Caption = 'Answer';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Contact Company Name"; Text[50])
        {
            CalcFormula = Lookup(Contact."Company Name" WHERE(No.=FIELD("Contact No.")));
            Caption = 'Contact Company Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7;"Contact Name";Text[50])
        {
            CalcFormula = Lookup(Contact.Name WHERE (No.=FIELD("Contact No.")));
            Caption = 'Contact Name';
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
        key(Key1;"Contact No.","Profile Questionnaire Code","Line No.")
        {
        }
        key(Key2;"Contact No.","Answer Priority","Profile Questionnaire Priority")
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
        Contact: Record 5050;
        ProfileQuestnLine: Record 5088;
    begin
        /*
        ProfileQuestnLine.GET("Profile Questionnaire Code",QuestionLineNo);
        ProfileQuestnLine.TESTFIELD("Auto Contact Classification",FALSE);
        
        IF PartOfRating THEN BEGIN
          DELETE;
          UpdateContactClassification.UpdateRating(Desde);
          INSERT;
        END;
        
        Contact.TouchContact(Desde);
        */

    end;

    trigger OnInsert()
    var
        Contact: Record 5050;
        ContProfileAnswer: Record 5089;
        ProfileQuestnLine: Record 5088;
        ProfileQuestnLine2: Record 5088;
        ProfileQuestnLine3: Record 5088;
    begin
        /*
        ProfileQuestnLine.GET("Profile Questionnaire Code","Line No.");
        ProfileQuestnLine.TESTFIELD(Type,ProfileQuestnLine.Type::Answer);
        
        ProfileQuestnLine2.GET("Profile Questionnaire Code",QuestionLineNo);
        ProfileQuestnLine2.TESTFIELD("Auto Contact Classification",FALSE);
        
        IF NOT ProfileQuestnLine2."Multiple Answers" THEN BEGIN
          ContProfileAnswer.RESET;
          ProfileQuestnLine3.RESET;
          ProfileQuestnLine3.SETRANGE("Profile Questionnaire Code","Profile Questionnaire Code");
          ProfileQuestnLine3.SETRANGE(Type,ProfileQuestnLine3.Type::Question);
          ProfileQuestnLine3.SETFILTER("Line No.",'>%1',ProfileQuestnLine2."Line No.");
          IF ProfileQuestnLine3.FINDFIRST THEN
            ContProfileAnswer.SETRANGE(
              "Line No.",ProfileQuestnLine2."Line No.",ProfileQuestnLine3."Line No.")
          ELSE
            ContProfileAnswer.SETFILTER("Line No.",'>%1',ProfileQuestnLine2."Line No.");
          ContProfileAnswer.SETRANGE("Contact No.",Desde);
          ContProfileAnswer.SETRANGE("Profile Questionnaire Code","Profile Questionnaire Code");
          IF NOT ContProfileAnswer.ISEMPTY THEN
            ERROR(Text000,ProfileQuestnLine2.FIELDCAPTION("Multiple Answers"));
        END;
        
        IF PartOfRating THEN BEGIN
          INSERT;
          UpdateContactClassification.UpdateRating(Desde);
          DELETE;
        END;
        
        Contact.TouchContact(Desde);
        */

    end;

    trigger OnModify()
    var
        Contact: Record 5050;
    begin
        //Contact.TouchContact(Desde);
    end;

    trigger OnRename()
    var
        Contact: Record 5050;
    begin
        /*
        IF xRec.Desde = Desde THEN
          Contact.TouchContact(Desde)
        ELSE BEGIN
          Contact.TouchContact(Desde);
          Contact.TouchContact(xRec.Desde);
        END;
        */

    end;

    var
        Text000: Label 'This Question does not allow %1.';
        UpdateContactClassification: Report 5199;

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

