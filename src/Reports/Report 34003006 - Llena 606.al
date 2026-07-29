report 34003006 "Llena 606"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = const(1));

            trigger OnAfterGetRecord()
            begin
            end;

            trigger OnPostDataItem()
            begin
                if WindowIsOpen then begin
                    Window.Close();
                    WindowIsOpen := false;
                end;
            end;

            trigger OnPreDataItem()
            begin
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(General)
                {
                    Caption = 'General';

                    group("Import from")
                    {
                        Caption = 'Import from';

                        field(FileName; FileName)
                        {
                            ApplicationArea = All;
                            Caption = 'Workbook File Name';
                            Editable = false;
                            ToolTip = 'Workbook File Name';

                            trigger OnAssistEdit()
                            begin
                                UploadFile();
                            end;
                        }

                        field(SheetName; SheetName)
                        {
                            ApplicationArea = All;
                            Caption = 'Worksheet Name';
                            Editable = false;
                            ToolTip = 'Worksheet Name';

                            trigger OnAssistEdit()
                            begin
                                if not ExcelFileTempBlob.HasValue() then
                                    if not UploadFile() then
                                        exit;

                                SelectSheetName();
                            end;
                        }
                    }
                }
            }
        }

        trigger OnQueryClosePage(CloseAction: Action): Boolean
        begin
            if CloseAction <> Action::OK then
                exit(true);

            if not ExcelFileTempBlob.HasValue() then
                if not UploadFile() then
                    exit(false);

            if SheetName = '' then
                if not SelectSheetName() then
                    exit(false);

            exit(true);
        end;
    }

    trigger OnPreReport()
    begin
        if not ExcelFileTempBlob.HasValue() then
            Error(NoExcelFileErr);

        if SheetName = '' then
            Error(NoWorksheetErr);
    end;

    var
        rCompany: Record "Company Information";
        AT_Itbis: Record 34003004;
        ExcelBuf: Record "Excel Buffer" temporary;
        ExcelFileTempBlob: Codeunit "Temp Blob";
        FileName: Text[250];
        SheetName: Text[250];
        Window: Dialog;
        WindowIsOpen: Boolean;
        CounterTotal: Integer;
        Counter: Integer;
        CantLin: Integer;
        ImporteFacturado: Decimal;
        ImporteITBIS: Decimal;
        ImporteRetenido: Decimal;
        Fila: Text[30];
        "Col-b": Text[30];
        "Col-c": Text[30];
        "Col-d": Text[30];
        "Col-e": Text[30];
        "Col-f": Text[30];
        "Col-g": Text[30];
        "Col-h": Text[30];
        "Col-i": Text[30];
        "Col-j": Text[30];
        "Col-k": Text[30];
        "Col-l": Text[30];
        "Col-m": Text[30];
        "Col-t": Text[30];
        "Col-u": Text[30];
        "Col-v": Text[30];
        NoRec: Integer;
        Text001: Label 'Exporting @1@@@@@@@@@@@@@';
        ImportExcelFileLbl: Label 'Import Excel File';
        ExcelFileFilterLbl: Label 'Excel Workbook (*.xlsx)|*.xlsx';
        ExcelFileExtensionTok: Label 'xlsx', Locked = true;
        NoExcelFileErr: Label 'You must select an Excel workbook before running the process.';
        NoWorksheetErr: Label 'You must select a worksheet before running the process.';

    procedure UploadFile(): Boolean
    var
        FileManagement: Codeunit "File Management";
        UploadedFileName: Text;
    begin
        Clear(ExcelFileTempBlob);

        UploadedFileName := FileManagement.BLOBImportWithFilter(
            ExcelFileTempBlob,
            ImportExcelFileLbl,
            '',
            ExcelFileFilterLbl,
            ExcelFileExtensionTok);

        if UploadedFileName = '' then begin
            Clear(FileName);
            Clear(SheetName);
            exit(false);
        end;

        FileName := CopyStr(
            FileManagement.GetFileName(UploadedFileName),
            1,
            MaxStrLen(FileName));

        Clear(SheetName);
        exit(true);
    end;

    local procedure SelectSheetName(): Boolean
    var
        ExcelInStream: InStream;
    begin
        if not ExcelFileTempBlob.HasValue() then
            exit(false);

        ExcelFileTempBlob.CreateInStream(ExcelInStream);
        SheetName := ExcelBuf.SelectSheetsNameStream(ExcelInStream);

        exit(SheetName <> '');
    end;

    local procedure ReadExcelSheet()
    var
        ExcelInStream: InStream;
        OpenBookError: Text;
    begin
        if not ExcelFileTempBlob.HasValue() then
            Error(NoExcelFileErr);

        if SheetName = '' then
            Error(NoWorksheetErr);

        ExcelBuf.Reset();
        ExcelBuf.DeleteAll();

        ExcelFileTempBlob.CreateInStream(ExcelInStream);

        OpenBookError := ExcelBuf.OpenBookStream(ExcelInStream, SheetName);

        if OpenBookError <> '' then
            Error(OpenExcelErr, OpenBookError);

        ExcelBuf.ReadSheet();
        ExcelBuf.CloseBook();
    end;

    procedure SetExcelFile(NewFileName: Text; ExcelInStream: InStream)
    var
        ExcelOutStream: OutStream;
    begin
        Clear(ExcelFileTempBlob);
        ExcelFileTempBlob.CreateOutStream(ExcelOutStream);
        CopyStream(ExcelOutStream, ExcelInStream);

        FileName := CopyStr(NewFileName, 1, MaxStrLen(FileName));
        Clear(SheetName);
    end;

    var
        OpenExcelErr: Label 'The Excel workbook could not be opened. %1';
}
