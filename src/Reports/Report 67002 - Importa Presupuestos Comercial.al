report 67002 "Importa Presupuestos Comercial"
{
    ApplicationArea = All;
    Caption = 'Importe Commercial Budget';
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

                        field(Cell1; Cell1)
                        {
                            ApplicationArea = All;
                            Caption = 'Salesperson Code Cell';
                        }

                        field(Cell2; Cell2)
                        {
                            ApplicationArea = All;
                            Caption = 'Item Code Cell';
                        }

                        field(Cell3; Cell3)
                        {
                            ApplicationArea = All;
                            Caption = 'Quantity Cell';
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
        PptoVentas: Record 67027;
        PptoMuestras: Record 67028;
        TempBlob: Codeunit "Temp Blob";
        Celda: Code[6];
        FileName: Text[250];
        SheetName: Text[250];
        Window: Dialog;
        Description: Text[50];
        Qty: Decimal;
        Amt: Decimal;
        CodPromotor: Code[20];
        Cell1: Code[6];
        Cell2: Code[6];
        Cell3: Code[6];
        TotalRecNo: Integer;
        RecNo: Integer;
        NoLin: Integer;
        CodProd: Code[20];
        TipoPresupuesto: Option Ventas,Muestras;
        Linea: Integer;
        HasUploadedFile: Boolean;
        AnalyzingDataLbl: Label 'Analyzing Data...\\';
        ExcelFileFilterLbl: Label 'Excel files (*.xlsx)|*.xlsx';
        UploadedWorkbookLbl: Label 'Uploaded workbook';
        FileNotSelectedErr: Label 'You must select an Excel file.';
        SheetNotSelectedErr: Label 'You must select an Excel worksheet.';
        OpenBookErr: Label 'The Excel workbook could not be opened. %1';
        BlankCellErr: Label 'The columns of Salesperson and Items can''t contain blank cells, verify line no. %1';

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
        Window.Open(
            AnalyzingDataLbl +
            '@1@@@@@@@@@@@@@@@@@@@@@@@@@\');
        Window.Update(1, 0);

        TotalRecNo := ExcelBuf.Count();
        RecNo := 0;

        if ExcelBuf.Find('-') then
            repeat
                RecNo := RecNo + 1;
                Window.Update(1, Round(RecNo / TotalRecNo * 10000, 1));

                Celda := ExcelBuf.xlColID + ExcelBuf.xlRowID;

                if Celda = Cell3 then begin
                    Evaluate(Qty, ExcelBuf."Cell Value as Text");
                    Cell3 := IncStr(Cell3);
                end else
                    if Celda = Cell2 then begin
                        CodProd := ExcelBuf."Cell Value as Text";
                        Cell2 := IncStr(Cell2);
                    end else
                        if Celda = Cell1 then begin
                            CodPromotor := ExcelBuf."Cell Value as Text";
                            CodPromotor := DelChr(CodPromotor, '=', ', .');
                            Cell1 := IncStr(Cell1);
                        end;

                if (CodPromotor = '') and (Celda = Cell1) then
                    Error(BlankCellErr, Linea + 1);

                if (CodProd = '') and (Celda = Cell2) then
                    Error(BlankCellErr, Linea + 1);

                if TipoPresupuesto = TipoPresupuesto::Ventas then begin
                    PptoVentas.Reset();
                    PptoVentas.SetRange("Cod. Promotor", CodPromotor);
                    PptoVentas.SetRange("Cod. Producto", CodProd);

                    if PptoVentas.FindFirst() then begin
                        PptoVentas.Validate("Cod. Promotor", CodPromotor);
                        PptoVentas.Validate("Cod. Producto", CodProd);

                        if Cell3 <> '' then
                            PptoVentas.Validate(Quantity, Qty);

                        PptoVentas.Modify();
                    end else begin
                        PptoVentas.Validate("Cod. Promotor", CodPromotor);
                        PptoVentas.Validate("Cod. Producto", CodProd);
                        PptoVentas.Validate(Quantity, Qty);
                        PptoVentas.Insert();
                    end;
                end else begin
                    PptoMuestras.Reset();
                    PptoMuestras.SetRange("Cod. Promotor", CodPromotor);
                    PptoMuestras.SetRange("Cod. Producto", CodProd);

                    if PptoMuestras.FindFirst() then begin
                        PptoMuestras.Validate("Cod. Promotor", CodPromotor);
                        PptoMuestras.Validate("Cod. Producto", CodProd);

                        if Cell3 <> '' then
                            PptoMuestras.Validate(Quantity, Qty);

                        PptoMuestras.Modify();
                    end else begin
                        PptoMuestras.Validate("Cod. Promotor", CodPromotor);
                        PptoMuestras.Validate("Cod. Producto", CodProd);
                        PptoMuestras.Validate(Quantity, Qty);
                        PptoMuestras.Insert();
                    end;
                end;
            until ExcelBuf.Next() = 0;

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

    procedure RecibeParametros(TipoPpto: Option Ventas,Muestras)
    begin
        TipoPresupuesto := TipoPpto;
    end;
}
