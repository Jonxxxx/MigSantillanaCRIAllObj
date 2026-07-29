report 34002182 "Importa datos empleados"
{
    Caption = 'Import Employee data';
    ProcessingOnly = true;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = const(1));

            trigger OnAfterGetRecord()
            begin
                ReadExcelSheet();
                AnalyzeData();
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

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

                        field(ConceptoSal; ConceptoSal)
                        {
                            ApplicationArea = All;
                            Caption = 'Wedge''s Concept';
                            TableRelation = "Conceptos salariales";
                            ToolTip = 'Wedge''s Concept';
                        }

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

                        group(General2)
                        {
                            ShowCaption = false;

                            field(Cell3; Cell3)
                            {
                                ApplicationArea = All;
                                Caption = 'Employee code cell';
                                ToolTip = 'Employee code cell';
                            }

                            field(Cell1; Cell1)
                            {
                                ApplicationArea = All;
                                Caption = 'Quantity Cell';
                                ToolTip = 'Quantity Cell';
                            }

                            field(Cell2; Cell2)
                            {
                                ApplicationArea = All;
                                Caption = 'Amount Cell';
                                ToolTip = 'Amount Cell';
                            }
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
            if not SelectSheetName() then
                Error(NoWorksheetErr);
    end;

    var
        ExcelBuf: Record "Excel Buffer" temporary;
        PerfilSal: Record 34002115;
        ExcelFileTempBlob: Codeunit "Temp Blob";
        Celda: Code[20];
        FileName: Text[250];
        SheetName: Text[250];
        Window: Dialog;
        Qty: Decimal;
        Amt: Decimal;
        CodEmpleado: Code[20];
        Cell1: Code[10];
        Cell2: Code[10];
        Cell3: Code[10];
        TotalRecNo: Integer;
        RecNo: Integer;
        ConceptoSal: Code[20];
        ImportExcelFileLbl: Label 'Import Excel File';
        ExcelFileFilterLbl: Label 'Excel Workbook (*.xlsx)|*.xlsx';
        ExcelFileExtensionTok: Label 'xlsx', Locked = true;
        AnalyzingDataLbl: Label 'Analyzing Data...\@1@@@@@@@@@@@@@@@@@@@@@@@@@';
        NoExcelFileErr: Label 'You must select an Excel workbook before running the import.';
        NoWorksheetErr: Label 'You must select a worksheet before running the import.';
        ExcelOpenErr: Label 'The Excel workbook could not be opened. %1';

    local procedure UploadFile(): Boolean
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
            Error(ExcelOpenErr, OpenBookError);

        ExcelBuf.ReadSheet();
        ExcelBuf.CloseBook();
    end;

    local procedure AnalyzeData()
    begin
        Window.Open(AnalyzingDataLbl);
        Window.Update(1, 0);

        TotalRecNo := ExcelBuf.Count();
        RecNo := 0;

        if ExcelBuf.FindSet() then
            repeat
                RecNo += 1;

                if TotalRecNo > 0 then
                    Window.Update(1, Round(RecNo / TotalRecNo * 10000, 1));

                Celda := CopyStr(
                    ExcelBuf.xlColID + ExcelBuf.xlRowID,
                    1,
                    MaxStrLen(Celda));

                if Celda = Cell1 then begin
                    Evaluate(Qty, ExcelBuf."Cell Value as Text");
                    Cell1 := IncStr(Cell1);
                end else
                    if Celda = Cell2 then begin
                        Evaluate(Amt, ExcelBuf."Cell Value as Text");
                        Cell2 := IncStr(Cell2);
                    end else
                        if Celda = Cell3 then begin
                            CodEmpleado := CopyStr(
                                ExcelBuf."Cell Value as Text",
                                1,
                                MaxStrLen(CodEmpleado));

                            CodEmpleado := DelChr(CodEmpleado, '=', ', .');
                            Cell3 := IncStr(Cell3);
                        end;

                if CodEmpleado <> '' then begin
                    PerfilSal.Reset();
                    PerfilSal.SetRange("No. empleado", CodEmpleado);
                    PerfilSal.SetRange("Concepto salarial", ConceptoSal);

                    if PerfilSal.FindFirst() then begin
                        if Cell1 <> '' then
                            PerfilSal.Validate(Cantidad, Qty);

                        if (Cell2 <> '') and (Cell1 = '') then begin
                            PerfilSal.Validate(Cantidad, 1);

                            if PerfilSal."Formula Calculo" = '' then
                                PerfilSal.Validate(Importe, Amt);
                        end else
                            if Cell2 <> '' then begin
                                PerfilSal.Validate(Cantidad, Qty);

                                if PerfilSal."Formula Calculo" = '' then
                                    PerfilSal.Validate(Importe, Amt);
                            end;

                        PerfilSal.Modify();
                    end;
                end;
            until ExcelBuf.Next() = 0;

        Window.Close();
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
}
