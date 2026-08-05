report 55782 "Crea ED Empleados"
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

                if ExcelBuf.IsEmpty() then
                    Error(EmptyExcelFileErr);

                Evaluate(Fila, CopyStr(Cell1, 2, 5));
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

                        field("Nombre fichero"; FileName)
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
                                SelectSheetName();
                            end;
                        }

                        group(General2)
                        {
                            ShowCaption = false;

                            field(Cell1; Cell1)
                            {
                                ApplicationArea = All;
                                Caption = 'Employee code Cell';
                                ToolTip = 'Employee code Cell';
                            }

                            field(Cell2; Cell2)
                            {
                                ApplicationArea = All;
                                Caption = 'G/L Account Cell';
                                ToolTip = 'G/L Account Cell';
                            }

                            field(Cell3; Cell3)
                            {
                                ApplicationArea = All;
                                Caption = 'Amount Cell';
                                ToolTip = 'Amount Cell';
                            }

                            field(Cell4; Cell4)
                            {
                                ApplicationArea = All;
                                Caption = 'Dimension Code Cell';
                                ToolTip = 'Dimension Code Cell';
                            }

                            field(Cell5; Cell5)
                            {
                                ApplicationArea = All;
                                Caption = 'Dimension Value Cell';
                                ToolTip = 'Dimension Value Cell';
                            }

                            field(Cell6; Cell6)
                            {
                                ApplicationArea = All;
                                Caption = 'Balance Account';
                                ToolTip = 'Balance Account';
                            }
                        }
                    }
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        NoLin := 1000;
    end;

    var
        ExcelBuf: Record "Excel Buffer" temporary;
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlLine2: Record "Gen. Journal Line";
        Emp: Record Employee;
        ExcelFileTempBlob: Codeunit "Temp Blob";
        CodigoDiario: Code[20];
        CodigoSeccion: Code[20];
        Celda: Code[20];
        FileName: Text[1024];
        SheetName: Text[250];
        Window: Dialog;
        Amt: Decimal;
        CodEmpleado: Code[20];
        Cell1: Code[10];
        Cell2: Code[10];
        Cell3: Code[10];
        Cell4: Code[10];
        Cell5: Code[10];
        Cell6: Code[10];
        TotalRecNo: Integer;
        RecNo: Integer;
        NoLin: Integer;
        CodCuenta: Code[20];
        CodDim: Code[20];
        CodValorDim: Code[20];
        Fila: Integer;
        CtaContrapartida: Code[20];
        ExcelFileFilterLbl: Label 'Excel Workbook (*.xlsx)|*.xlsx';
        ExcelFileExtensionLbl: Label 'xlsx', Locked = true;
        ImportExcelFileLbl: Label 'Import Excel File';
        AnalyzingDataLbl: Label 'Analyzing Data...\@1@@@@@@@@@@@@@@@@@@@@@@@@@';
        NoExcelFileErr: Label 'You must select an Excel workbook before running the import.';
        NoWorksheetErr: Label 'You must select a worksheet before running the import.';
        EmptyExcelFileErr: Label 'The selected worksheet does not contain any data.';
        ExcelOpenErr: Label 'The Excel workbook could not be opened. %1';

    procedure RecibeParametros(CodDiario: Code[20]; CodSeccion: Code[20])
    begin
        CodigoDiario := CodDiario;
        CodigoSeccion := CodSeccion;
    end;

    procedure UploadFile()
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
            ExcelFileExtensionLbl);

        if UploadedFileName = '' then begin
            Clear(FileName);
            Clear(SheetName);
            exit;
        end;

        FileName := CopyStr(FileManagement.GetFileName(UploadedFileName), 1, MaxStrLen(FileName));
        Clear(SheetName);
    end;

    local procedure SelectSheetName()
    var
        ExcelInStream: InStream;
    begin
        if not ExcelFileTempBlob.HasValue() then
            UploadFile();

        if not ExcelFileTempBlob.HasValue() then
            exit;

        ExcelFileTempBlob.CreateInStream(ExcelInStream);
        SheetName := ExcelBuf.SelectSheetsNameStream(ExcelInStream);
    end;

    local procedure ReadExcelSheet()
    var
        ExcelInStream: InStream;
        OpenBookError: Text;
    begin
        if not ExcelFileTempBlob.HasValue() then
            UploadFile();

        if not ExcelFileTempBlob.HasValue() then
            Error(NoExcelFileErr);

        if SheetName = '' then
            SelectSheetName();

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
        Amt := 0;

        ExcelBuf.SetRange("Row No.", Fila, 9999999);

        if ExcelBuf.FindSet() then
            repeat
                RecNo += 1;

                if TotalRecNo > 0 then
                    Window.Update(1, Round(RecNo / TotalRecNo * 10000, 1));

                Celda := CopyStr(ExcelBuf.xlColID + ExcelBuf.xlRowID, 1, MaxStrLen(Celda));

                if Celda = Cell6 then begin
                    Evaluate(CtaContrapartida, ExcelBuf."Cell Value as Text");
                    Cell6 := IncStr(Cell6);
                end else
                    if Celda = Cell5 then begin
                        Evaluate(CodValorDim, ExcelBuf."Cell Value as Text");
                        Cell5 := IncStr(Cell5);
                    end else
                        if Celda = Cell4 then begin
                            Evaluate(CodDim, ExcelBuf."Cell Value as Text");
                            Cell4 := IncStr(Cell4);
                        end else
                            if Celda = Cell3 then begin
                                Evaluate(Amt, ExcelBuf."Cell Value as Text");
                                Cell3 := IncStr(Cell3);
                            end else
                                if Celda = Cell2 then begin
                                    CodCuenta := CopyStr(
                                        ExcelBuf."Cell Value as Text",
                                        1,
                                        MaxStrLen(CodCuenta));

                                    Cell2 := IncStr(Cell2);
                                end else
                                    if Celda = Cell1 then begin
                                        CodEmpleado := CopyStr(
                                            ExcelBuf."Cell Value as Text",
                                            1,
                                            MaxStrLen(CodEmpleado));

                                        CodEmpleado := DelChr(CodEmpleado, '=', ', .');
                                        Cell1 := IncStr(Cell1);
                                    end;

                if (CodEmpleado <> '') and
                   (CodCuenta <> '') and
                   (Amt <> 0) and
                   (CodDim <> '') and
                   (CodValorDim <> '') and
                   (CtaContrapartida <> '')
                then begin
                    Emp.Get(CodEmpleado);

                    GenJnlLine2.Reset();
                    GenJnlLine2.SetRange("Journal Template Name", CodigoDiario);
                    GenJnlLine2.SetRange("Journal Batch Name", CodigoSeccion);

                    if not GenJnlLine2.FindLast() then
                        GenJnlLine2."Line No." := 0;

                    NoLin := GenJnlLine2."Line No." + 1000;

                    Clear(GenJnlLine);
                    GenJnlLine.Init();
                    GenJnlLine."Journal Template Name" := CodigoDiario;
                    GenJnlLine."Journal Batch Name" := CodigoSeccion;
                    GenJnlLine."Line No." := NoLin;
                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                    GenJnlLine.Validate("Account No.", CodCuenta);
                    GenJnlLine.Validate("Posting Date", Today);
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                    GenJnlLine."Document No." :=
                        CopyStr(
                            'NOMINA' +
                            Format(Date2DMY(Today, 1)) +
                            Format(Date2DMY(Today, 2)) +
                            Format(Date2DMY(Today, 3)),
                            1,
                            MaxStrLen(GenJnlLine."Document No."));

                    GenJnlLine.Description := CopyStr(Emp."Full Name", 1, MaxStrLen(GenJnlLine.Description));
                    GenJnlLine.Validate(Amount, Amt);
                    GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                    GenJnlLine.Validate("Bal. Account No.", CtaContrapartida);
                    GenJnlLine.Insert(true);

                    Clear(Amt);
                    Clear(CodEmpleado);
                    Clear(CodCuenta);
                    Clear(CodDim);
                    Clear(CodValorDim);
                    Clear(CtaContrapartida);
                end;
            until ExcelBuf.Next() = 0;

        Window.Close();
    end;
}
