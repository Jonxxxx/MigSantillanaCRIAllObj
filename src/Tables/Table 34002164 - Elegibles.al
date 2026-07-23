table 34002164 Elegibles
{
    // Version       USERID    Fecha       Descripcion
    // //DSNOM1.01   GRN       25/12/2008  Modificaciones para manejar modulo de nominas

    Caption = 'Eligibles';
    DataCaptionFields = "No.", "First Name", "Last Name";
    DrillDownPageID = 34002191;
    LookupPageID = 34002191;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    HumanResSetup.GET;
                    NoSeriesMgt.TestManual(HumanResSetup."Employee Nos.");
                END;
            end;
        }
        field(2; "First Name"; Text[30])
        {
            Caption = 'First Name';

            trigger OnValidate()
            begin
                VALIDATE("Lugar nacimiento");
            end;
        }
        field(3; "Middle Name"; Text[30])
        {
            Caption = 'Middle Name';

            trigger OnValidate()
            begin
                VALIDATE("Lugar nacimiento");
            end;
        }
        field(4; "Last Name"; Text[30])
        {
            Caption = 'Last Name';

            trigger OnValidate()
            begin
                VALIDATE("Lugar nacimiento");
            end;
        }
        field(5; Initials; Text[30])
        {
            Caption = 'Initials';

            trigger OnValidate()
            begin
                IF ("Search Name" = UPPERCASE(xRec.Initials)) OR ("Search Name" = '') THEN
                    "Search Name" := Initials;
            end;
        }
        field(6; "Job Title"; Text[50])
        {
            Caption = 'Job Title';
        }
        field(7; "Search Name"; Code[30])
        {
            Caption = 'Search Name';
        }
        field(8; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(9; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(10; City; Text[30])
        {
            Caption = 'City';

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", TRUE);
                //GRN PostCode.ValidateCity(City,"Post Code");
            end;
        }
        field(11; "Post Code"; Code[20])
        {
            Caption = 'ZIP Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", TRUE);
                //GRN PostCode.ValidatePostCode(City,"Post Code");
            end;
        }
        field(12; County; Text[30])
        {
            Caption = 'State';
        }
        field(13; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }
        field(14; "Mobile Phone No."; Text[30])
        {
            Caption = 'Mobile Phone No.';
        }
        field(15; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
        }
        field(19; Picture; BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(20; "Birth Date"; Date)
        {
            Caption = 'Birth Date';
        }
        field(21; "Social Security No."; Text[30])
        {
            Caption = 'Social Security No.';
        }
        field(22; Gender; Option)
        {
            Caption = 'Gender';
            OptionCaption = ' ,Female,Male';
            OptionMembers = " ",Female,Male;
        }
        field(23; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(24; Comment; Boolean)
        {
            CalcFormula = Exist("Human Resource Comment Line" WHERE("Table Name" = CONST(Employee),
                                                                     "No." = FIELD("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(25; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(27; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(28; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(29; Extension; Text[30])
        {
            Caption = 'Extension';
        }
        field(30; "URL Linkedin"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "URL Facebook"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Company E-Mail"; Text[80])
        {
            Caption = 'Company E-Mail';
        }
        field(33; Title; Text[30])
        {
            Caption = 'Title';
        }
        field(34; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(35; "Second Last Name"; Text[30])
        {
            Caption = 'Second Last Name';

            trigger OnValidate()
            begin
                VALIDATE("Lugar nacimiento");
            end;
        }
        field(36; "Full Name"; Text[50])
        {
            Caption = 'Full Name';

            trigger OnValidate()
            begin
                "Lugar nacimiento" := "First Name" + ' ' + "Middle Name" + ' ' + "Last Name" + ' ' + Nacionalidad;
            end;
        }
        field(37; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'SS,Passport,Residence ID,Work Permission';
            OptionMembers = "Cédula",Pasaporte,"Tarj. residencia","Permiso de Trabajo";
        }
        field(38; "Document ID"; Text[15])
        {
            Caption = 'Document ID';

            trigger OnValidate()
            begin
                Candidato.RESET;
                Candidato.SETFILTER("No.", '<>%1', "No.");
                Candidato.SETRANGE("Document ID", "Document ID");
                IF Candidato.FINDFIRST THEN
                    ERROR(STRSUBSTNO(Err003, FIELDCAPTION("Document Type"), Candidato."No.", Candidato."Full Name"));

                //TODO: Ver IF "Document Type" = "Document Type"::Cédula THEN
                //TODO: Ver IF NOT FuncNominas.ValidarCedula(DELCHR("Document ID", '=', '-')) THEN
                //TODO: Ver ERROR(STRSUBSTNO(Err004, "Document Type"));
            end;
        }
        field(40; Nacionalidad; Code[10])
        {
            TableRelation = "Country/Region";
        }
        field(41; "Lugar nacimiento"; Text[30])
        {
        }
        field(42; "Estado civil"; Option)
        {
            Description = 'Soltero/a,Casado/a,Viudo/a,Separado/a,Divorciado/a';
            OptionMembers = "Soltero/a","Casado/a","Viudo/a","Separado/a","Divorciado/a";
        }
        field(44; "No. Seguridad Social"; Code[10])
        {
        }
        field(45; "Experiencia 1"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Experiencia 2"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(47; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionCaption = 'Elegible,Descartado,Contratado';
            OptionMembers = Elegible,Descartado,Contratado;
        }
        field(34002108; "Job Type Code"; Code[15])
        {
            Caption = 'Job type code';
            DataClassification = ToBeClassified;
            TableRelation = "Puestos laborales".Codigo;

            trigger OnValidate()
            var
                Contract: Record 34002109;
            begin

                Cargo.RESET;
                Cargo.SETRANGE(Codigo, "Job Type Code");
                IF Cargo.FINDFIRST THEN BEGIN
                    "Job Title" := Cargo.Descripcion;
                    //     "Cod. Supervisor" := Cargo."Cod. Supervisor";
                END;
            end;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Search Name")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "First Name", "Last Name", "Phone No.")
        {
        }
    }

    trigger OnDelete()
    var
        Contrato: Record 34002109;
        PerfilSal: Record 34002115;
        HistNom: Record 34002117;
    begin
        AlternativeAddr.SETRANGE("Employee No.", "No.");
        AlternativeAddr.DELETEALL;

        EmployeeQualification.SETRANGE("Employee No.", "No.");
        EmployeeQualification.DELETEALL;

        Relative.SETRANGE("Employee No.", "No.");
        Relative.DELETEALL;

        MiscArticleInformation.SETRANGE("Employee No.", "No.");
        MiscArticleInformation.DELETEALL;

        ConfidentialInformation.SETRANGE("Employee No.", "No.");
        ConfidentialInformation.DELETEALL;

        HumanResComment.SETRANGE("No.", "No.");
        HumanResComment.DELETEALL;

        //TODO: Ver DimMgt.DeleteDefaultDim(DATABASE::Employee, "No.");
    end;

    trigger OnInsert()
    begin
        //Para cuando el numerador de empleados es comun a las empresas
        ConfNominas.GET();
        IF (ConfNominas."Habilitar numeradores globales") AND ("No." = '') THEN BEGIN
            Numeradorescomunes.FINDFIRST;
            Numeradorescomunes.TESTFIELD("No. serie candidatos");
            "No." := INCSTR(Numeradorescomunes."No. serie candidatos");
            Numeradorescomunes."No. serie candidatos" := "No.";
            Numeradorescomunes.MODIFY;
        END
        ELSE
            IF "No." = '' THEN BEGIN
                HumanResSetup.GET;
                HumanResSetup.TESTFIELD("Candidate Nos.");
                "No. Series" := HumanResSetup."Candidate Nos.";
                if NoSeriesMgt.AreRelated("No. Series", xRec."No. Series") then "No. Series" := xRec."No. Series";
                "No." := NoSeriesMgt.GetNextNo("No. Series");
            END;

        //TODO: Ver DimMgt.UpdateDefaultDim(
        //TODO: Ver   DATABASE::Employee, "No.",
        //TODO: Ver   "Global Dimension 1 Filter", "Global Dimension 2 Filter");
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := TODAY;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := TODAY;
    end;

    var
        HumanResSetup: Record 5218;
        Candidato: Record 34002164;
        Cargo: Record 34002110;
        Res: Record 156;
        PostCode: Record 225;
        AlternativeAddr: Record 5201;
        EmployeeQualification: Record 5203;
        Relative: Record 5205;
        MiscArticleInformation: Record 5214;
        ConfidentialInformation: Record 5216;
        HumanResComment: Record 5208;
        SalespersonPurchaser: Record 13;
        ConfNominas: Record 34002103;
        Numeradorescomunes: Record 34002182;
        NoSeriesMgt: Codeunit "No. Series";
        //TODO: Ver DimMgt: Codeunit 408;
        Text000: Label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        Err001: Label 'This Account No. already exist for candidate %1';
        Err002: Label 'This employee has posted payroll, you can not delete it';
        //TODO: Ver FuncNominas: Codeunit 34002104;
        Err003: Label 'This %1 already exist for the candidate %2 %3';
        Err004: Label '$1 is invalid, please verify';

    procedure AssistEdit(OldEmployee: Record 34002164): Boolean
    begin
        /*
        WITH Employee DO BEGIN
          Employee := Rec;
          HumanResSetup.GET;
          HumanResSetup.TESTFIELD("Candidate Nos.");
          IF NoSeriesMgt.SelectSeries(HumanResSetup."Candidate Nos.",OldEmployee."Telefono caso emergencia","Telefono caso emergencia") THEN
        BEGIN
            HumanResSetup.GET;
            HumanResSetup.TESTFIELD("Employee Nos.");
            NoSeriesMgt.SetSeries("No.");
            Rec := Employee;
            EXIT(TRUE);
          END;
        END;
        */
        WITH Candidato DO BEGIN
            Candidato := Rec;
            HumanResSetup.GET;
            //TODO: Ver HumanResSetup.TESTFIELD("Candidate Nos.");
            //TODO: Ver 
            /*
            IF NoSeriesMgt.SelectSeries(HumanResSetup."Candidate Nos.", OldEmployee."No. Series", "No. Series") THEN BEGIN
                HumanResSetup.GET;
                HumanResSetup.TESTFIELD("Employee Nos.");
                NoSeriesMgt.SetSeries("No.");
                Rec := Candidato;
                EXIT(TRUE);
            END;
            */
        END;

    end;

    procedure FullName(): Text[100]
    begin
        IF "Middle Name" = '' THEN
            EXIT("First Name" + ' ' + "Last Name")
        ELSE
            EXIT("First Name" + ' ' + "Middle Name" + ' ' + "Last Name");
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        //TODO: Ver DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        //TODO: Ver DimMgt.SaveDefaultDim(DATABASE::Employee, "No.", FieldNumber, ShortcutDimCode);
        MODIFY;
    end;

    procedure DisplayMap()
    var
        MapPoint: Record 800;
        MapMgt: Codeunit 802;
    begin
        IF MapPoint.FIND('-') THEN
            MapMgt.SetupDefault
        ELSE
            MESSAGE(Text000);
    end;
}

