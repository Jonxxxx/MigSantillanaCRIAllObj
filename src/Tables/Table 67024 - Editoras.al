table 55491 Editoras
{
    DrillDownPageID = 55490;
    LookupPageID = 55490;

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
        }
        field(2; Description; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';

            trigger OnValidate()
            begin
                IF "Search Name" = '' THEN
                    "Search Name" := Description;
            end;
        }
        field(3; "Search Name"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Search Name';
        }
        field(4; Address; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Address';
        }
        field(5; "Address 2"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Address 2';
        }
        field(6; City; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'City';

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(7; "Territory Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Territory Code';
            TableRelation = Territory;
        }
        field(8; "Country/Region Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(9; "Post Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(10; County; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'County';
        }
        field(11; "Phone No."; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(12; "Home Page"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Home Page';
            ExtendedDatatype = URL;
        }
        field(13; Twitter; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Twitter';
            ExtendedDatatype = URL;
        }
        field(14; Facebook; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Facebook';
            ExtendedDatatype = URL;
        }
        field(15; Santillana; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Santillana';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        PostCode: Record 225;
}

