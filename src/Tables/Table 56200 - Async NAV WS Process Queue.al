table 56200 "Async NAV WS Process Queue"
{
    // Dynamics.is - Gunnar  r Gestsson


    fields
    {
        field(1;"Entry No.";Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2;"Process Code";Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Process Code';
        }
        field(3;"Process Data";BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'Process Data';
        }
        field(4;"Process Status";Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Process Status';
            OptionMembers = Requested,Pending,Completed,Error;
        }
        field(5;"Process Response";BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'Process Response';
        }
        field(6;"Process Start Date & Time";DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Process Start Date & Time';
        }
        field(7;"Process End Date & Time";DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Process End Date & Time';
        }
        field(8;"Process User Id";Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Process User Id';
        }
        field(9;"URL Web Service";Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'URL Web Service';
        }
        field(10;"Soap Action";Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Soap Action';
        }
        field(11;"Received Data";BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'Received Data';
        }
    }

    keys
    {
        key(Key1;"Entry No.")
        {
        }
    }

    fieldgroups
    {
    }

    procedure GetProcessData() ProcessData: Text
    var
        InStr: InStream;
        ReadPart: Text;
    begin
        IF NOT "Process Data".HASVALUE THEN EXIT('');
        CALCFIELDS("Process Data");
        "Process Data".CREATEINSTREAM(InStr);
        WHILE InStr.READTEXT(ReadPart) > 0 DO
          ProcessData += ReadPart;
    end;

    procedure SetProcessData(ProcessData: Text)
    var
        OutStr: OutStream;
    begin
        CLEAR("Process Data");
        "Process Data".CREATEOUTSTREAM(OutStr);
        OutStr.WRITETEXT(ProcessData);
    end;

    procedure GetProcessResponse() ProcessResponse: Text
    var
        InStr: InStream;
        ReadPart: Text;
    begin
        IF NOT "Process Response".HASVALUE THEN EXIT('');
        CALCFIELDS("Process Response");
        "Process Response".CREATEINSTREAM(InStr);
        WHILE InStr.READTEXT(ReadPart) > 0 DO
          ProcessResponse += ReadPart;
    end;

    procedure SetProcessResponse(ProcessResponse: Text)
    var
        OutStr: OutStream;
    begin
        CLEAR("Process Response");
        "Process Response".CREATEOUTSTREAM(OutStr);
        OutStr.WRITETEXT(ProcessResponse);
    end;

    procedure GetReceivedData() ReceivedData: Text
    var
        InStr: InStream;
        ReadPart: Text;
    begin
        //+#101415
        IF NOT "Received Data".HASVALUE THEN EXIT('');
        CALCFIELDS("Received Data");
        "Received Data".CREATEINSTREAM(InStr);
        WHILE InStr.READTEXT(ReadPart) > 0 DO
          ReceivedData += ReadPart;
    end;
}

