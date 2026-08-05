table 67017 Padres
{
    DrillDownPageID = 67049;
    LookupPageID = 67049;

    fields
    {
        field(1; DNI; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'DNI';
        }
        field(2; "First Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'First Name';

            trigger OnValidate()
            begin
                VALIDATE("Full name");
            end;
        }
        field(3; "Middle Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Middle Name';

            trigger OnValidate()
            begin
                VALIDATE("Full name");
            end;
        }
        field(4; "Last Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Last Name';

            trigger OnValidate()
            begin
                VALIDATE("Full name");
            end;
        }
        field(5; "Second Last Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Second Last Name';

            trigger OnValidate()
            begin
                VALIDATE("Full name");
            end;
        }
        field(6; Sex; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Sex';
            OptionCaption = 'Female,Male';
            OptionMembers = Femenino,Masculino;
        }
        field(7; Address; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Address';
        }
        field(8; "Address 2"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Address 2';
        }
        field(9; City; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'City';

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(10; "Territory Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Territory Code';
            TableRelation = Territory;
        }
        field(11; "Country/Region Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(12; "Post Code"; Code[20])
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
        field(13; County; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'County';
        }
        field(14; "Home Phone No."; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Home Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(15; "Tipo documento"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo documento';
            TableRelation = "Tipos de documentos personales";
        }
        field(16; "Dia Nacimiento"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Dia Nacimiento';
            MaxValue = 31;
            MinValue = 1;

            trigger OnValidate()
            begin
                IF ("Dia Nacimiento" <> 0) AND ("Mes Nacimiento" <> 0) AND ("Ano Nacimiento" <> 0) THEN
                    "Fecha Nacimiento" := DMY2DATE("Dia Nacimiento", "Mes Nacimiento", "Ano Nacimiento");
            end;
        }
        field(17; "Mes Nacimiento"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Mes Nacimiento';
            MaxValue = 12;
            MinValue = 1;
        }
        field(18; "Ano Nacimiento"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Ano Nacimiento';
        }
        field(19; "Home Page"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Home Page';
            ExtendedDatatype = URL;
        }
        field(20; Twitter; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Twitter';
            ExtendedDatatype = URL;
        }
        field(21; Facebook; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Facebook';
            ExtendedDatatype = URL;
        }
        field(22; "BB Pin"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'BB Pin';
        }
        field(23; "Cantidad Hijos INI"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad Hijos INI';
        }
        field(24; "Cantidad Hijos PRI"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad Hijos PRI';
        }
        field(25; "Cantidad Hijos SEC"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad Hijos SEC';
        }
        field(26; "Areas de Interes"; Integer)
        {
            Caption = 'Areas de Interes';
            CalcFormula = Count("Areas de interes padres" WHERE("DNI Padre" = FIELD("DNI")));
            FieldClass = FlowField;
        }
        field(27; "Cant. Hijos"; Integer)
        {
            Caption = 'Cant. Hijos';
            CalcFormula = Count("Alumnos - Hijos" WHERE("DNI Padre" = FIELD("DNI")));
            FieldClass = FlowField;
        }
        field(28; "E-Mail"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(29; "E-Mail 2"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'E-Mail 2';
            ExtendedDatatype = EMail;
        }
        field(30; "Cell Phone No."; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Cell Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(31; "Salutation Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Salutation Code';
            TableRelation = Salutation;
        }
        field(32; "Full name"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Full name';
            Editable = false;

            trigger OnValidate()
            begin
                "Full name" := "First Name" + ' ' + "Middle Name" + ' ' + "Last Name" + ' ' + "Second Last Name";
            end;
        }
        field(33; "Grado INI"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Grado INI';
        }
        field(34; "Fecha Nacimiento"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Nacimiento';
        }
        field(35; "Fecha creacion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha creacion';
        }
        field(36; "Ult. Fecha Actualizacion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Ult. Fecha Actualizacion';
        }
        field(37; "Grado PRI"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Grado PRI';
        }
        field(38; "Grado SEC"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Grado SEC';
        }
        field(39; Status; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionCaption = ' ,Inactive';
            OptionMembers = " ",Inactivo;
        }
    }

    keys
    {
        key(Key1; DNI)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Fecha creacion" := TODAY;
    end;

    trigger OnModify()
    begin
        "Ult. Fecha Actualizacion" := TODAY;
    end;

    var
        PostCode: Record 225;
        Col: Record 5050;
        Text033: Label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        DA: Record 55469;

    procedure DisplayMap()
    var
        MapPoint: Record 800;
        MapMgt: Codeunit 802;
    begin
        IF MapPoint.FIND('-') THEN
            MapMgt.MakeSelection(DATABASE::Contact, GETPOSITION)
        ELSE
            MESSAGE(Text033);
    end;
}

