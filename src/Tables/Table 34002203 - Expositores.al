table 55844 Expositores
{
    Caption = 'Exponent';

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';

            /*TableRelation = IF (Tipo = CONST(Interno)) Employee.No.
                            ELSE IF (Tipo = CONST(Externo)) Vendor.No.;*/

            trigger OnValidate()
            begin
                IF Tipo = 0 THEN BEGIN
                    Emp.GET("No.");
                    Name := Emp."Full Name";
                    "Document ID" := Emp."Document ID";
                    Address := Emp.Address;
                    "Address 2" := Emp."Address 2";
                    City := Emp.City;
                    "Search Name" := Emp."Search Name";
                    "Mobile Phone No." := Emp."Mobile Phone No.";
                    "Country/Region Code" := Emp."Country/Region Code";
                    County := Emp.County;
                    "Phone No." := Emp."Phone No.";
                    "E-Mail" := Emp."E-Mail";
                    "E-Mail 2" := Emp."Company E-Mail";
                END
                ELSE BEGIN
                    Vend.GET("No.");
                    Name := Vend.Name;
                    "Document ID" := Vend."VAT Registration No.";
                    Address := Vend.Address;
                    "Address 2" := Vend."Address 2";
                    City := Vend.City;
                    "Search Name" := Vend."Search Name";
                    //"Mobile Phone No." := Emp."Mobile Phone No.";
                    "Country/Region Code" := Vend."Country/Region Code";
                    County := Vend.County;
                    "Phone No." := Vend."Phone No.";
                    "E-Mail" := Vend."E-Mail";

                END;
            end;
        }
        field(2; Name; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Name';
        }
        field(3; "Search Name"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Search Name';
        }
        field(4; "Name 2"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Name 2';
        }
        field(5; Address; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Address';
        }
        field(6; "Address 2"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Address 2';
        }
        field(7; City; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'City';

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(8; "Phone No."; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(9; "Mobile Phone No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Mobile Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(10; "Territory Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Territory Code';
            TableRelation = Territory;
        }
        field(11; "Language Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(12; Tipo; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo';
            OptionCaption = 'Internal,External';
            OptionMembers = Interno,Externo;
        }
        field(13; "Country/Region Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(14; Comment; Boolean)
        {
            CalcFormula = Exist("Rlshp. Mgt. Comment Line" WHERE("Table Name" = CONST(Contact),
                                                                  "No." = FIELD("No."),
                                                                  "Sub No." = CONST(0)));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Last Date Modified"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(16; "Fax No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Fax No.';
        }
        field(18; "Document ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document ID';

            trigger OnValidate()
            var
                VATRegNoFormat: Record 381;
            begin
            end;
        }
        field(19; Picture; BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(20; "Post Code"; Code[20])
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
        field(21; County; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'County';
        }
        field(22; "E-Mail"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(23; "Home Page"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Home Page';
            ExtendedDatatype = URL;
        }
        field(24; Twitter; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Twitter';
        }
        field(25; Facebook; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Facebook';
        }
        field(26; "E-Mail 2"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'E-Mail 2';
            ExtendedDatatype = EMail;
        }
        field(27; "No. Series"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(29; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(30; "Cost (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cost (LCY)';
            AutoFormatType = 1;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Document ID")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Emp: Record 5200;
        Vend: Record 23;
        PostCode: Record 225;
}

