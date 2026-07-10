table 56200 "Async NAV WS Process Queue"
{
    // Dynamics.is - Gunnar  r Gestsson


    fields
    {
        field(1;"Entry No.";Integer)
        {
            AutoIncrement = true;
        }
        field(2;"Process Code";Code[50])
        {
        }
        field(3;"Process Data";BLOB)
        {
        }
        field(4;"Process Status";Option)
        {
            OptionMembers = Requested,Pending,Completed,Error;
        }
        field(5;"Process Response";BLOB)
        {
        }
        field(6;"Process Start Date & Time";DateTime)
        {
        }
        field(7;"Process End Date & Time";DateTime)
        {
        }
        field(8;"Process User Id";Code[50])
        {
        }
        field(9;"URL Web Service";Text[150])
        {
        }
        field(10;"Soap Action";Text[50])
        {
        }
        field(11;"Received Data";BLOB)
        {
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

