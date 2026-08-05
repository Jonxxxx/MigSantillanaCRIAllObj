table 55815 "Payroll - Job Journal Template"
{
    Caption = 'Payroll Journal Template';
    DrillDownPageID = 55835;
    LookupPageID = 55835;

    fields
    {
        field(1; Name; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Name';
            NotBlank = true;
        }
        field(2; Description; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(5; "Test Report ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Test Report ID';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Report));
        }
        field(6; "Page ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Page ID';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Page));
        }
        field(7; "Posting Report ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Report ID';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Report));
        }
        field(8; "Force Posting Report"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Force Posting Report';
        }
        field(13; "Test Report Caption"; Text[250])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE("Object Type" = CONST(Report),
                                                                           "Object ID" = FIELD("Test Report ID")));
            Caption = 'Test Report Caption';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Page Caption"; Text[250])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE("Object Type" = CONST(Page),
                                                                           "Object ID" = FIELD("Page ID")));
            Caption = 'Page Caption';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Posting Report Caption"; Text[250])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE("Object Type" = CONST(Report),
                                                                           "Object ID" = FIELD("Posting Report ID")));
            Caption = 'Posting Report Caption';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "No. Series"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                /*GRN No va por el momento
                
                IF "No. Series" <> '' THEN BEGIN
                  IF Recurring THEN
                    ERROR(
                      Text000,
                      FIELDCAPTION("Posting No. Series"));
                  IF "No. Series" = "Posting No. Series" THEN
                    "Posting No. Series" := '';
                END;
                */

            end;
        }
        field(17; "Posting No. Series"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                /*GRN No va por el momento
                IF ("Posting No. Series" = "No. Series") AND ("Posting No. Series" <> '') THEN
                  FIELDERROR("Posting No. Series",STRSUBSTNO(Text001,"Posting No. Series"));
                */

            end;
        }
    }

    keys
    {
        key(Key1; Name)
        {
        }
    }

    fieldgroups
    {
    }

    var
        JobJnlBatch: Record 55814;
        JobJnlLine: Record 55813;
        SourceCodeSetup: Record 242;
}

