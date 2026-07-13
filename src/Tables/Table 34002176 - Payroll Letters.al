table 34002176 "Payroll Letters"
{
    Caption = 'Custom Report Layout';
    DrillDownPageID = 9650;
    LookupPageID = 9650;

    fields
    {
        field(1;"Code";Code[20])
        {
            Caption = 'ID';
        }
        field(2;"Report ID";Integer)
        {
            Caption = 'Report ID';
            TableRelation = AllObjWithCaption."Object ID" WHERE (Object Type=CONST(Report));

            trigger OnValidate()
            begin

                IF Code <> '' THEN
                  BEGIN
                    CRL.RESET;
                    CRL.SETRANGE(Code,Code);
                    CRL.FINDFIRST;
                    Description := CRL.Description;
                    "Report Name" := CRL."Report Name";
                  END;
            end;
        }
        field(3;"Report Name";Text[80])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE (Object Type=CONST(Report),
                                                                           Object ID=FIELD(Report ID)));
            Caption = 'Report Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4;"Company Name";Text[30])
        {
            Caption = 'Company Name';
            TableRelation = Company;
        }
        field(6;Type;Option)
        {
            Caption = 'Type';
            InitValue = Word;
            OptionCaption = 'RDLC,Word';
            OptionMembers = RDLC,Word;
        }
        field(7;"Layout";BLOB)
        {
            Caption = 'Layout';
        }
        field(8;"Last Modified";DateTime)
        {
            Caption = 'Last Modified';
            Editable = false;
        }
        field(9;"Last Modified by User";Code[50])
        {
            Caption = 'Last Modified by User';
            Editable = false;
        }
        field(10;"File Extension";Text[30])
        {
            Caption = 'File Extension';
            Editable = false;
        }
        field(11;Description;Text[80])
        {
            Caption = 'Description';
        }
        field(12;"Custom XML Part";BLOB)
        {
            Caption = 'Custom XML Part';
        }
        field(13;Publish;Boolean)
        {
            Caption = 'Publish';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Code")
        {
        }
        key(Key2;"Report ID","Company Name",Type)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        TESTFIELD(Description);
        SetUpdated;
    end;

    trigger OnModify()
    begin
        TESTFIELD(Description);
        SetUpdated;
    end;

    var
        ImportWordTxt: Label 'Import Word Document';
        ImportRdlcTxt: Label 'Import Report Layout';
        FileFilterWordTxt: Label 'Word Files (*.docx)|*.docx', Comment='{Split=r''\|''}{Locked=s''1''}';
        FileFilterRdlcTxt: Label 'SQL Report Builder (*.rdl;*.rdlc)|*.rdl;*.rdlc', Comment='{Split=r''\|''}{Locked=s''1''}';
        NoRecordsErr: Label 'There is no record in the list.';
        BuiltInTxt: Label 'Built-in layout';
        CopyOfTxt: Label 'Copy of %1';
        NewLayoutTxt: Label 'New layout';
        ErrorInLayoutErr: Label 'Issue found in layout %1 for report ID  %2:\%3.', Comment='%1=a name, %2=a number, %3=a sentence/error description.';
        TemplateValidationQst: Label 'The RDLC layout does not comply with the current report design (for example, fields are missing or the report ID is wrong).\The following errors were detected during the layout validation:\%1\Do you want to continue?', Comment='%1 = an error message.';
        TemplateValidationErr: Label 'The RDLC layout does not comply with the current report design (for example, fields are missing or the report ID is wrong).\The following errors were detected during the document validation:\%1\You must update the layout to match the current report design.';
        AbortWithValidationErr: Label 'The RDLC layout action has been canceled because of validation errors.';
        CRL: Record "9650";

    local procedure SetUpdated()
    begin
        "Last Modified" := ROUNDDATETIME(CURRENTDATETIME);
        "Last Modified by User" := USERID;
    end;

    procedure InitBuiltInLayout(ReportID: Integer;LayoutType: Option)
    var
        CustomReportLayout: Record "9650";
        DocumentReportMgt: Codeunit "9651";
        InStr: InStream;
        OutStr: OutStream;
    begin
        /*IF ReportID = 0 THEN
          EXIT;
        CustomReportLayout.INIT;
        CustomReportLayout."Report ID" := ReportID;
        CustomReportLayout.Type := LayoutType;
        CustomReportLayout.Description := COPYSTR(STRSUBSTNO(CopyOfTxt,BuiltInTxt),1,MAXSTRLEN(Description));
        
        CASE LayoutType OF
          CustomReportLayout.Type::Word:
            BEGIN
              CustomReportLayout.Layout.CREATEOUTSTREAM(OutStr);
              IF NOT REPORT.WORDLAYOUT(ReportID,InStr) THEN BEGIN
                DocumentReportMgt.NewWordLayout(ReportID,OutStr);
                CustomReportLayout.Description := COPYSTR(NewLayoutTxt,1,MAXSTRLEN(Description));
              END ELSE
                COPYSTREAM(OutStr,InStr);
            END;
          CustomReportLayout.Type::RDLC:
            BEGIN
              CustomReportLayout.Layout.CREATEOUTSTREAM(OutStr);
              IF REPORT.RDLCLAYOUT(ReportID,InStr) THEN
                COPYSTREAM(OutStr,InStr);
            END;
        END;
        
        InsertCustomXmlPart(CustomReportLayout);
        
        CustomReportLayout.Code := 0;
        CustomReportLayout.INSERT(TRUE);
        */

    end;

    procedure InsertBuiltInLayout()
    var
        ReportLayoutLookup: Page "9651";
        ReportID: Integer;
    begin
        FILTERGROUP(4);
        IF GETFILTER("Report ID") = '' THEN
          FILTERGROUP(0);
        IF GETFILTER("Report ID") <> '' THEN
          IF EVALUATE(ReportID,GETFILTER("Report ID")) THEN
            ReportLayoutLookup.SetReportID(ReportID);
        FILTERGROUP(0);
        IF ReportLayoutLookup.RUNMODAL = ACTION::OK THEN BEGIN
          IF ReportLayoutLookup.SelectedAddWordLayot THEN
            InitBuiltInLayout(ReportLayoutLookup.SelectedReportID,Type::Word);
          IF ReportLayoutLookup.SelectedAddRdlcLayot THEN
            InitBuiltInLayout(ReportLayoutLookup.SelectedReportID,Type::RDLC);
        END;
    end;

    procedure GetCustomRdlc(ReportID: Integer): Text
    var
        ReportLayoutSelection: Record "9651";
        InStream: InStream;
        RdlcTxt: Text;
        CustomLayoutID: Integer;
    begin
        // Temporarily selected layout for Design-time report execution?
        /*IF ReportLayoutSelection.GetTempLayoutSelected <> 0 THEN
          CustomLayoutID := ReportLayoutSelection.GetTempLayoutSelected
        ELSE  // Normal selection
          IF ReportLayoutSelection.HasCustomLayout(ReportID) = 1 THEN
            CustomLayoutID := ReportLayoutSelection."Custom Report Layout Code";
        
        IF (CustomLayoutID <> 0) AND GET(CustomLayoutID) THEN BEGIN
          TESTFIELD(Type,Type::RDLC);
          CALCFIELDS(Layout);
          Layout.CREATEINSTREAM(InStream,TEXTENCODING::UTF8);
        END ELSE
          REPORT.RDLCLAYOUT(ReportID,InStream);
        InStream.READ(RdlcTxt);
        
        EXIT(RdlcTxt);
        */

    end;

    local procedure GetWordXML(var TempBlob: Record "99008535")
    var
        OutStr: OutStream;
    begin
        TESTFIELD("Report ID");
        TempBlob.Blob.CREATEOUTSTREAM(OutStr,TEXTENCODING::UTF16);
        OutStr.WRITETEXT(REPORT.WORDXMLPART("Report ID"));
    end;

    procedure ExportSchema(DefaultFileName: Text;ShowFileDialog: Boolean): Text
    var
        TempBlob: Record "99008535";
        FileMgt: Codeunit "419";
    begin
        TESTFIELD(Type,Type::Word);

        IF DefaultFileName = '' THEN
          DefaultFileName := '*.xml';

        GetWordXML(TempBlob);
        IF TempBlob.Blob.HASVALUE THEN
          EXIT(FileMgt.BLOBExport(TempBlob,DefaultFileName,ShowFileDialog));
    end;

    procedure EditLayout()
    begin

        CASE Type OF
          Type::Word:
            CODEUNIT.RUN(CODEUNIT::"Edit MS Word Report Layout",Rec);
        END;
    end;

    local procedure GetFileExtension(): Text[4]
    begin
        CASE Type OF
          Type::Word:
            EXIT('docx');
          Type::RDLC:
            EXIT('rdl');
        END;
    end;

    local procedure InsertCustomXmlPart(var CustomReportLayout: Record "9650")
    var
        OutStr: OutStream;
        WordXmlPart: Text;
    begin
        // Store the current design as an extended WordXmlPart. This data is used for later updates / refactorings.
        CustomReportLayout."Custom XML Part".CREATEOUTSTREAM(OutStr,TEXTENCODING::UTF16);
        WordXmlPart := REPORT.WORDXMLPART(CustomReportLayout."Report ID",TRUE);
        IF WordXmlPart <> '' THEN
          OutStr.WRITE(WordXmlPart);
    end;

    procedure GetCustomXmlPart() XmlPart: Text
    var
        InStr: InStream;
    begin
        CALCFIELDS("Custom XML Part");
        IF NOT "Custom XML Part".HASVALUE THEN
          EXIT;

        "Custom XML Part".CREATEINSTREAM(InStr,TEXTENCODING::UTF16);
        InStr.READ(XmlPart);
    end;

    procedure RunCustomReport(CodEmp: Code[20])
    var
        ReportLayoutSelection: Record "9651";
        Emp: Record "5200";
    begin
        IF "Report ID" = 0 THEN
          EXIT;

        Emp.SETRANGE("No.",CodEmp);

        ReportLayoutSelection.SetTempLayoutSelected(Code);
        REPORT.RUNMODAL("Report ID",TRUE,FALSE,Emp);
        //ReportLayoutSelection.SetTempLayoutSelected('');
    end;
}

