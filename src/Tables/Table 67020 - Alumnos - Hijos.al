table 67020 "Alumnos - Hijos"
{
    DrillDownPageID = 67020;
    LookupPageID = 67020;

    fields
    {
        field(1; "DNI Padre"; Code[20])
        {
            NotBlank = true;
            TableRelation = Padres;

            trigger OnValidate()
            begin
                IF "DNI Padre" <> '' THEN BEGIN
                    Father.GET("DNI Padre");
                    IF CONFIRM(Msg001, TRUE) THEN BEGIN
                        Address := Father.Address;
                        //TODO: Ver "Address 2" := Father."Address 2;
                        //TODO: Ver VALIDATE(City, Father.City);
                        VALIDATE("Post Code", Father."Post Code");
                        VALIDATE(County, Father.County);
                    END;
                    "Nombre Padre" := Father."Second Last Name";
                END;
            end;
        }
        field(2; "Cod. Colegio"; Code[20])
        {
            NotBlank = true;
            TableRelation = Contact WHERE("Type" = CONST(Company));
        }
        field(3; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(4; "First Name"; Text[30])
        {
            Caption = 'First Name';
        }
        field(5; "Middle Name"; Text[30])
        {
            Caption = 'Middle Name';
        }
        field(6; Surname; Text[30])
        {
            Caption = 'Surname';
        }
        field(7; "Nombre Padre"; Text[60])
        {
            Caption = 'Father''s name';
        }
        field(8; Sex; Option)
        {
            OptionCaption = 'Female,Male';
            OptionMembers = Femenino,Masculino;
        }
        field(9; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(10; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(11; City; Text[30])
        {
            Caption = 'City';

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", TRUE);
            end;
        }
        field(12; "Territory Code"; Code[10])
        {
            Caption = 'Territory Code';
            TableRelation = Territory;
        }
        field(13; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(14; "Post Code"; Code[20])
        {
            Caption = 'ZIP Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(15; County; Text[30])
        {
            Caption = 'State';
        }
        field(16; "Home Phone No."; Text[50])
        {
            Caption = 'Home Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(17; "Born Date"; Date)
        {
        }
        field(18; "Home Page"; Text[150])
        {
        }
        field(19; Twitter; Text[30])
        {
        }
        field(20; Facebook; Text[150])
        {
        }
        field(21; "BB Pin"; Code[10])
        {
        }
        field(22; "Nombre Colegio"; Text[60])
        {
        }
        field(23; "Cell Phone No."; Text[50])
        {
            Caption = 'Cell Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(25; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
    }

    keys
    {
        key(Key1; "DNI Padre", "Cod. Colegio", "Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Father: Record 67017;
        PostCode: Record 225;
        Msg001: Label 'Do you wish to copy the address from the father?';
        Text033: Label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';

    procedure DisplayMap()
    var
        MapPoint: Record 800;
    //TODO: Ver  MapMgt: Codeunit 802;
    begin
        //TODO: Ver IF MapPoint.FIND('-') THEN
        //TODO: Ver     MapMgt.SetupDefault
        //TODO: Ver ELSE
        //TODO: Ver     MESSAGE(Text033);
    end;
}

