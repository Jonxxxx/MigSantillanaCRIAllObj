table 55004 "Dimension Value-Vendores"
{
    Caption = 'Dimension Value';
    //IGNORAR: Page no existe DrillDownPageID = 55009;
    //IGNORAR: Page no existe LookupPageID = 55009;

    fields
    {
        field(1; "Dimension Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension Code';
            NotBlank = true;
            TableRelation = Dimension;
        }
        field(2; "Code"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
            NotBlank = true;
        }
        field(3; Name; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Name';
        }
        field(4; "Dimension Value Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension Value Type';
            OptionCaption = 'Standard,Heading,Total,Begin-Total,End-Total';
            OptionMembers = Standard,Heading,Total,"Begin-Total","End-Total";
        }
        field(5; Totaling; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Totaling';
            TableRelation = IF ("Dimension Value Type" = CONST(Total)) "Dimension Value"."Dimension Code" WHERE("Dimension Code" = FIELD("Dimension Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(6; Blocked; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Blocked';
        }
        field(7; "Consolidation Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Consolidation Code';
        }
        field(8; Indentation; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Indentation';
        }
        field(9; "Global Dimension No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension No.';
        }
        field(10; "Map-to IC Dimension Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Map-to IC Dimension Code';
        }
        field(11; "Map-to IC Dimension Value Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Map-to IC Dimension Value Code';
            TableRelation = "IC Dimension Value".Code WHERE("Dimension Code" = FIELD("Map-to IC Dimension Code"));
        }
    }

    keys
    {
        key(Key1; "Dimension Code", "Code")
        {
        }
        key(Key2; "Code", "Global Dimension No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text000: Label '%1\You cannot delete it.';
        Text002: Label '(CONFLICT)';
        Text003: Label '%1 can not be (CONFLICT). This name is used internally by the system.';
        Text004: Label '%1\You cannot change the type.';
        Text005: Label 'This dimension value is used in posted and budget entries.';
        Text006: Label 'This dimension value is used in posted entries.';
        Text007: Label 'This dimension value is used in budget entries.';
        DimValueComb: Record 351;
        DefaultDim: Record 352;
        SelectedDim: Record 369;
        AnalysisSelectedDim: Record 7159;
        GLSetup: Record 98;
        CheckDimErr: Text[250];
        UsedInPostedEntries: Boolean;
        UsedInBudgetEntries: Boolean;
}

