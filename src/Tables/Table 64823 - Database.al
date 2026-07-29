table 64823 EXCCRIDatabase
{
    DataCaptionFields = "Code", Description;
    //IGNORAR: Page no existe DrillDownPageID = 64833;
    //IGNORAR: Page no existe LookupPageID = 64833;

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
            NotBlank = true;
        }
        field(5; Description; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(10; "Server No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Server No.';
        }
        field(11; NetType; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'NetType';
        }
        field(12; "Database Name"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Database Name';
        }
        field(14; Company; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Company';
            TableRelation = "Database Company"."Company Name" WHERE("Database Code" = FIELD("Code"));
            ValidateTableRelation = false;
        }
        field(15; UserID; Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'UserID';
        }
        field(16; Password; Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Password';
        }
        field(17; Type; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Type';
            InitValue = "MS Dynamics NAV";
            OptionMembers = "3.56","MS Dynamics NAV";
        }
        field(18; "Server Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Server Name';
        }
        field(19; "Assume Design"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Assume Design';
            TableRelation = EXCCRIDatabase.Code;
        }
        field(20; "Read Design"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Read Design';

            trigger OnValidate()
            begin
                IF "Read Design" THEN
                    "Assume Design" := Code
                ELSE IF "Assume Design" = Code THEN
                    "Assume Design" := '';
            end;
        }
        field(21; "Installation Path"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Installation Path';
        }
        field(22; Directory; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Directory';
        }
        field(23; "Database Driver"; Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Database Driver';
            Description = 'NDBCN or NDBCS';
            InitValue = 'NDBCN';

            trigger OnValidate()
            begin
                "Database Driver" := UPPERCASE("Database Driver");
                IF (("Database Driver" <> 'NDBCN') AND ("Database Driver" <> 'NDBCS')) THEN
                    FIELDERROR("Database Driver", 'must be either NDBCN (Navision Financials) or NDBCS (MS-SQL 7) server.');
            end;
        }
        field(24; "Use NT Authentication"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Use NT Authentication';
        }
        field(25; "Use Codeunits Permissions"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Use Codeunits Permissions';
        }
        field(26; "Local Db. Cache"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Local Db. Cache';
        }
        field(27; "Local Db. Commit Cache"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Local Db. Commit Cache';
        }
        field(28; "Single User Database"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Single User Database';
        }
        field(30; "Remote Server Address"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Remote Server Address';
        }
        field(31; "Remote Server Port"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Remote Server Port';
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

    trigger OnDelete()
    begin
        Specification.SETRANGE("Source Design", Code);
        IF Specification.FIND('-') THEN
            ERROR('This database is used as %1 and can not be deleted.',
              Specification.FIELDNAME("Source Design"));
        Specification.SETRANGE("Source Design");
        Specification.SETRANGE("Dest. Design", Code);
        IF Specification.FIND('-') THEN
            ERROR('This database is used as %1 and can not be deleted.',
              Specification.FIELDNAME("Dest. Design"));

        IF NOT CONFIRM('Deleting the database will remove the entire database design,\' +
          'if present, and also delete related Todo and Log entries, continue?', FALSE)
        THEN
            EXIT;

        ToDo.SETRANGE("Sender Database", Code);
        ToDo.DELETEALL();
        ToDo.RESET();
        ToDo.SETRANGE("Receiver Database", Code);
        ToDo.DELETEALL();
        Log.SETRANGE("Source Database", Code);
        Log.DELETEALL();
        Log.RESET();
        Log.SETRANGE("Dest. Database", Code);
        Log.DELETEALL();
        Table.SETRANGE("Database Code", Code);
        Table.DELETEALL();
        Field.SETRANGE("Database Code", Code);
        Field.DELETEALL();
        Accounts.SETRANGE("Database Code", Code);
        Accounts.DELETEALL();
        Keys.SETRANGE("Database Code", Code);
        Keys.DELETEALL();
    end;

    var
        Specification: Record 64822;
        SpecFields: Record 64825;
        ToDo: Record 64826;
        Log: Record 64827;
        "Table": Record 64828;
        "Field": Record 64829;
        Accounts: Record 64830;
        "Keys": Record 64831;
}

