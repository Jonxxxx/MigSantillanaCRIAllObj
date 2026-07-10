table 130400 "CAL Test Suite"
{
    Caption = 'CAL Test Suite';
    DataCaptionFields = Name, Description;
    LookupPageID = 130400;
    ReplicateData = false;

    fields
    {
        field(1; Name; Code[10])
        {
            Caption = 'Name';
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; "Tests to Execute"; Integer)
        {
            CalcFormula = Count("CAL Test Line" WHERE(Test Suite=FIELD(Name),
                                                       Line Type=CONST(Function),
                                                       Run=CONST(true)));
            Caption = 'Tests to Execute';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4;"Tests not Executed";Integer)
        {
            CalcFormula = Count("CAL Test Line" WHERE (Test Suite=FIELD(Name),
                                                       Line Type=CONST(Function),
                                                       Run=CONST(true),
                                                       Result=CONST(" ")));
            Caption = 'Tests not Executed';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5;Failures;Integer)
        {
            CalcFormula = Count("CAL Test Line" WHERE (Test Suite=FIELD(Name),
                                                       Line Type=CONST(Function),
                                                       Run=CONST(true),
                                                       Result=CONST(Failure)));
            Caption = 'Failures';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6;"Last Run";DateTime)
        {
            Caption = 'Last Run';
            Editable = false;
        }
        field(8;Export;Boolean)
        {
            Caption = 'Export';
        }
        field(21;Attachment;BLOB)
        {
            Caption = 'Attachment';
        }
        field(23;"Update Test Coverage Map";Boolean)
        {
            Caption = 'Update Test Coverage Map';
        }
    }

    keys
    {
        key(Key1;Name)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        CALTestLine Record: 130401;
    begin
        CALTestLine.SETRANGE("Test Suite",Name);
        CALTestLine.DELETEALL(TRUE);
    end;

    var
        CouldNotExportErr: Label 'Could not export Unit Test XML definition.', Locked=true;
        UTTxt: Label 'UT', Locked=true;
        CALTestSuiteXML: XMLport "130400;
                             CALTestResultsXML: XMLport "130401;

    procedure ExportTestSuiteSetup()
    var
        CALTestSuite Record: 130400;
        TempBlob Record: 99008535;
        FileMgt: Codeunit 419;
        OStream: OutStream;
    begin
        TempBlob.Blob.CREATEOUTSTREAM(OStream);
        CALTestSuite.SETRANGE(Name, Name);

        CALTestSuiteXML.SETDESTINATION(OStream);
        CALTestSuiteXML.SETTABLEVIEW(CALTestSuite);

        IF NOT CALTestSuiteXML.EXPORT THEN
            ERROR(CouldNotExportErr);

        FileMgt.ServerTempFileName('*.xml');
        FileMgt.BLOBExport(TempBlob, UTTxt + Name, TRUE);
    end;

    procedure ImportTestSuiteSetup()
    var
        TempBlob Record: 99008535;
        FileMgt: Codeunit 419;
        IStream: InStream;
    begin
        FileMgt.BLOBImport(TempBlob, '*.xml');
        TempBlob.Blob.CREATEINSTREAM(IStream);
        CALTestSuiteXML.SETSOURCE(IStream);
        CALTestSuiteXML.IMPORT;
    end;

    procedure ExportTestSuiteResult()
    var
        CALTestSuite Record: 130400;
        TempBlob Record: 99008535;
        FileMgt: Codeunit 419;
        OStream: OutStream;
    begin
        TempBlob.Blob.CREATEOUTSTREAM(OStream);
        CALTestSuite.SETRANGE(Name, Name);

        CALTestResultsXML.SETDESTINATION(OStream);
        CALTestResultsXML.SETTABLEVIEW(CALTestSuite);

        IF NOT CALTestResultsXML.EXPORT THEN
            ERROR(CouldNotExportErr);

        FileMgt.ServerTempFileName('*.xml');
        FileMgt.BLOBExport(TempBlob, UTTxt + Name, TRUE);
    end;

    procedure ImportTestSuiteResult()
    var
        TempBlob Record: 99008535;
        FileMgt: Codeunit 419;
        IStream: InStream;
    begin
        FileMgt.BLOBImport(TempBlob, '*.xml');
        TempBlob.Blob.CREATEINSTREAM(IStream);
        CALTestResultsXML.SETSOURCE(IStream);
        CALTestResultsXML.IMPORT;
    end;
}

