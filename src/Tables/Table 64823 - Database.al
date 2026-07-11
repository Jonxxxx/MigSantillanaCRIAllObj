table 64823 Database
{
    DataCaptionFields = "Code", Description;
    DrillDownPageID = 64833;
    LookupPageID = 64833;

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(5; Description; Text[80])
        {
        }
        field(10; "Server No."; Integer)
        {
        }
        field(11; NetType; Text[30])
        {
        }
        field(12; "Database Name"; Text[80])
        {
        }
        field(14; Company; Text[30])
        {
            TableRelation = "Database Company"."Company Name" WHERE("Database Code" = FIELD("Code"));
            ValidateTableRelation = false;
        }
        field(15; UserID; Text[10])
        {
        }
        field(16; Password; Text[10])
        {
        }
        field(17; Type; Option)
        {
            InitValue = "MS Dynamics NAV";
            OptionMembers = "3.56","MS Dynamics NAV";
        }
        field(18; "Server Name"; Text[30])
        {
        }
        field(19; "Assume Design"; Code[20])
        {
            //TODO: Ver TableRelation = Database.Code;
        }
        field(20; "Read Design"; Boolean)
        {

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
        }
        field(22; Directory; Text[80])
        {
        }
        field(23; "Database Driver"; Text[10])
        {
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
        }
        field(25; "Use Codeunits Permissions"; Integer)
        {
        }
        field(26; "Local Db. Cache"; Integer)
        {
        }
        field(27; "Local Db. Commit Cache"; Integer)
        {
        }
        field(28; "Single User Database"; Boolean)
        {
        }
        field(30; "Remote Server Address"; Text[30])
        {
        }
        field(31; "Remote Server Port"; Text[30])
        {
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
        "Table"Record 64828;
        "Field"Record 64829;
        Accounts: Record 64830;
        "Keys"Record 64831;
}

