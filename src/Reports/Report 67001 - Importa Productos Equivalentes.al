report 67001 "Importa Productos Equivalentes"
{
    ApplicationArea = All;
    Caption = 'Import Equivalent items';
    ProcessingOnly = true;
    UsageCategory = Tasks;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = sorting(Number)
                                where(Number = const(1));

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
                group(Options)
                {
                    Caption = 'Options';

                    group("Import from")
                    {
                        Caption = 'Import from';

                        field(File_Name; FileName)
                        {
                            ApplicationArea = All;
                            Caption = 'Workbook File Name';

                            trigger OnAssistEdit()
                            begin
                                UploadFile();
                            end;

                            trigger OnValidate()
                            begin
                                FileNameOnAfterValidate();
                            end;
                        }

                        field(Sheet_Name; SheetName)
                        {
                            ApplicationArea = All;
                            Caption = 'Worksheet Name';

                            trigger OnAssistEdit()
                            begin
                                if not HasUploadedFile then
                                    UploadFile();

                                if HasUploadedFile then
                                    SheetName := SelectWorksheet();
                            end;
                        }
                    }

                    group("Data Columns")
                    {
                        Caption = 'Data Columns';

                        field(Cell_1; Cell1)
                        {
                            ApplicationArea = All;
                            Caption = 'Item Code Cell';
                        }

                        field(Cell_2; Cell2)
                        {
                            ApplicationArea = All;
                            Caption = 'Equivalent Item Code Cell';
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

    trigger OnPreReport()
    begin
        if not HasUploadedFile then
            UploadFile();

        if not HasUploadedFile then
            Error(FileNotSelectedErr);

        if SheetName = '' then
            SheetName := SelectWorksheet();

        if SheetName = '' then
            Error(SheetNotSelectedErr);
    end;

    var
        ExcelBuf: Record "Excel Buffer" temporary;
        PL: Record 67005;
        TempBlob: Codeunit "Temp Blob";
        Celda: Code[6];
        FileName: Text[250];
        SheetName: Text[250];
        Window: Dialog;
        CodProducto: Code[20];
        CodProdEq: Code[20];
        Cell1: Code[6];
        Cell2: Code[6];
        TotalRecNo: Integer;
        RecNo: Integer;
        NoLin: Integer;
        TipoDocumento: Integer;
        NoDocumento: Code[20];
        HasUploadedFile: Boolean;
        AnalyzingDataLbl: Label 'Analyzing Data...\\';
        ExcelFileFilterLbl: Label 'Excel files (*.xlsx)|*.xlsx';
        UploadedWorkbookLbl: Label 'Uploaded workbook';
        FileNotSelectedErr: Label 'You must select an Excel file.';
        SheetNotSelectedErr: Label 'You must select an Excel worksheet.';
        OpenBookErr: Label 'The Excel workbook could not be opened. %1';

    procedure RecibeParametros(TipoDoc: Integer; NoDoc: Code[20])
    begin
        TipoDocumento := TipoDoc;
        NoDocumento := NoDoc;
    end;

    local procedure ReadExcelSheet()
    var
        ExcelInStream: InStream;
        OpenBookError: Text;
    begin
        ExcelBuf.Reset();
        ExcelBuf.DeleteAll();

        TempBlob.CreateInStream(ExcelInStream);

        OpenBookError := ExcelBuf.OpenBookStream(ExcelInStream, SheetName);
        if OpenBookError <> '' then
            Error(OpenBookErr, OpenBookError);

        ExcelBuf.ReadSheet();
        ExcelBuf.CloseBook();
    end;

    local procedure AnalyzeData()
    begin
        if GuiAllowed() then begin
            Window.Open(
                AnalyzingDataLbl +
                '@1@@@@@@@@@@@@@@@@@@@@@@@@@\');
            Window.Update(1, 0);
        end;

        TotalRecNo := ExcelBuf.Count();
        RecNo := 0;

        if ExcelBuf.FindSet() then
            repeat
                RecNo += 1;

                if GuiAllowed() and (TotalRecNo <> 0) then
                    Window.Update(1, Round(RecNo / TotalRecNo * 10000, 1));

                Celda := ExcelBuf.xlColID + ExcelBuf.xlRowID;

                if Celda = Cell1 then begin
                    Evaluate(CodProducto, ExcelBuf."Cell Value as Text");
                    Cell1 := IncStr(Cell1);
                end else
                    if Celda = Cell2 then begin
                        Evaluate(CodProdEq, ExcelBuf."Cell Value as Text");
                        Cell2 := IncStr(Cell2);
                    end;

                if (CodProducto <> '') and (CodProdEq <> '') then begin
                    Clear(PL);
                    PL.Validate("Cod. Producto", CodProducto);
                    PL.Validate("Cod. Producto Anterior", CodProdEq);

                    if not PL.Insert() then
                        Clear(PL);

                    Clear(CodProducto);
                    Clear(CodProdEq);
                end;
            until ExcelBuf.Next() = 0;

        if GuiAllowed() then
            Window.Close();
    end;

    procedure UploadFile()
    var
        UploadInStream: InStream;
        BlobOutStream: OutStream;
    begin
        if not UploadIntoStream(ExcelFileFilterLbl, UploadInStream) then
            exit;

        Clear(TempBlob);
        TempBlob.CreateOutStream(BlobOutStream);
        CopyStream(BlobOutStream, UploadInStream);

        HasUploadedFile := true;
        FileName := UploadedWorkbookLbl;
        SheetName := SelectWorksheet();
    end;

    local procedure SelectWorksheet(): Text[250]
    var
        ExcelInStream: InStream;
    begin
        if not HasUploadedFile then
            Error(FileNotSelectedErr);

        TempBlob.CreateInStream(ExcelInStream);
        exit(ExcelBuf.SelectSheetsNameStream(ExcelInStream));
    end;

    local procedure FileNameOnAfterValidate()
    begin
        UploadFile();
    end;
}
