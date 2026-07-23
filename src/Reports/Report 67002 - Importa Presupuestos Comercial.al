report 67002 "Importa Presupuestos Comercial"
{
    Caption = 'Importe Commercial Budget';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Integer"; 2000000026)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = CONST(1));

            trigger OnAfterGetRecord()
            begin
                ReadExcelSheet;
                AnalyzeData;
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
                            Caption = 'Workbook File Name';

                            trigger OnAssistEdit()
                            begin
                                UploadFile;
                            end;

                            trigger OnValidate()
                            begin
                                FileNameOnAfterValidate;
                            end;
                        }
                        field(Sheet_Name; SheetName)
                        {
                            Caption = 'Worksheet Name';

                            trigger OnAssistEdit()
                            begin
                                IF ISSERVICETIER THEN
                                    SheetName := ExcelBuf.SelectSheetsName(UploadedFileName)
                                ELSE
                                    SheetName := ExcelBuf.SelectSheetsName(FileName);
                            end;
                        }
                    }
                    group("Data Columns")
                    {
                        Caption = 'Data Columns';
                        field(Cell1; Cell1)
                        {
                            Caption = 'Salesperson Code Cell';
                        }
                        field(Cell2; Cell2)
                        {
                            Caption = 'Item Code Cell';
                        }
                        field(Cell3; Cell3)
                        {
                            Caption = 'Quantity Cell';
                        }
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        NoLin := 1000;
    end;

    var
        ExcelBuf: Record 370 temporary;
        PptoVentas: Record 67027;
        PptoMuestras: Record 67028;
        Celda: Code[6];
        FileName: Text[250];
        UploadedFileName: Text[1024];
        SheetName: Text[250];
        Window: Dialog;
        Description: Text[50];
        Qty: Decimal;
        Amt: Decimal;
        CodPromotor: Code[20];
        Cell1: Code[6];
        Cell2: Code[6];
        Text0001: Label 'aaa';
        Text007: Label 'Analyzing Data...\\';
        Cell3: Code[6];
        TotalRecNo: Integer;
        RecNo: Integer;
        Text006: Label 'Import Excel File';
        NoLin: Integer;
        CodProd: Code[20];
        TipoPresupuesto: Option Ventas,Muestras;
        Err001: Label 'The columns of Salesperson and Items can''t contain blank cells, verify line no. %1';
        Linea: Integer;

    local procedure ReadExcelSheet()
    begin
        IF ISSERVICETIER THEN
            IF UploadedFileName = '' THEN
                UploadFile
            ELSE
                FileName := UploadedFileName;

        ExcelBuf.OpenBook(FileName, SheetName);
        ExcelBuf.ReadSheet;
    end;

    local procedure AnalyzeData()
    var
        TempExcelBuf: Record 370 temporary;
        BudgetBuf: Record 371;
        TempBudgetBuf: Record 371 temporary;
        HeaderRowNo: Integer;
        CountDim: Integer;
        TestDate: Date;
        OldRowNo: Integer;
        DimRowNo: Integer;
        DimCode3: Code[20];
    begin
        Window.OPEN(
          Text007 +
          '@1@@@@@@@@@@@@@@@@@@@@@@@@@\');
        Window.UPDATE(1, 0);
        TotalRecNo := ExcelBuf.COUNT;
        RecNo := 0;

        IF ExcelBuf.FIND('-') THEN
            REPEAT
                RecNo := RecNo + 1;
                Window.UPDATE(1, ROUND(RecNo / TotalRecNo * 10000, 1));
                Celda := ExcelBuf.xlColID + ExcelBuf.xlRowID;
                IF Celda = Cell3 THEN BEGIN
                    EVALUATE(Qty, ExcelBuf."Cell Value as Text");
                    Cell3 := INCSTR(Cell3);
                END
                ELSE
                    IF Celda = Cell2 THEN BEGIN
                        CodProd := ExcelBuf."Cell Value as Text";
                        Cell2 := INCSTR(Cell2);
                    END
                    ELSE
                        IF Celda = Cell1 THEN BEGIN
                            CodPromotor := ExcelBuf."Cell Value as Text";
                            CodPromotor := DELCHR(CodPromotor, '=', ', .');
                            Cell1 := INCSTR(Cell1);
                        END;
                /*
                    IF ((CodPromotor = '') AND (COPYSTR(Cell1,1,1) = ExcelBuf.xlColID))  THEN
                       ERROR(Err001,Linea + 1);

                    IF ((CodProd = '') AND (COPYSTR(Cell2,1,1) = ExcelBuf.xlColID))  THEN
                       ERROR(Err001,Linea + 1);
                */
                IF (CodPromotor = '') AND (Celda = Cell1) THEN
                    ERROR(Err001, Linea + 1);

                IF (CodProd = '') AND (Celda = Cell2) THEN
                    ERROR(Err001, Linea + 1);

                IF TipoPresupuesto = 0 THEN BEGIN
                    PptoVentas.RESET;
                    PptoVentas.SETRANGE("Cod. Promotor", CodPromotor);
                    PptoVentas.SETRANGE("Cod. Producto", CodProd);
                    IF PptoVentas.FINDFIRST THEN BEGIN
                        PptoVentas.VALIDATE("Cod. Promotor", CodPromotor);
                        PptoVentas.VALIDATE("Cod. Producto", CodProd);
                        IF Cell3 <> '' THEN
                            PptoVentas.VALIDATE(Quantity, Qty);

                        PptoVentas.MODIFY;
                    END
                    ELSE BEGIN
                        PptoVentas.VALIDATE("Cod. Promotor", CodPromotor);
                        PptoVentas.VALIDATE("Cod. Producto", CodProd);
                        PptoVentas.VALIDATE(Quantity, Qty);
                        PptoVentas.INSERT;
                    END;
                END
                ELSE BEGIN
                    PptoMuestras.RESET;
                    PptoMuestras.SETRANGE("Cod. Promotor", CodPromotor);
                    PptoMuestras.SETRANGE("Cod. Producto", CodProd);
                    IF PptoMuestras.FINDFIRST THEN BEGIN
                        PptoMuestras.VALIDATE("Cod. Promotor", CodPromotor);
                        PptoMuestras.VALIDATE("Cod. Producto", CodProd);
                        IF Cell3 <> '' THEN
                            PptoMuestras.VALIDATE(Quantity, Qty);

                        PptoMuestras.MODIFY;
                    END
                    ELSE BEGIN
                        PptoMuestras.VALIDATE("Cod. Promotor", CodPromotor);
                        PptoMuestras.VALIDATE("Cod. Producto", CodProd);
                        PptoMuestras.VALIDATE(Quantity, Qty);
                        PptoMuestras.INSERT;
                    END;
                END;
            UNTIL ExcelBuf.NEXT = 0;

        Window.CLOSE;

    end;

    procedure UploadFile()
    var
        CommonDialogMgt: Codeunit 419;
        ClientFileName: Text[1024];
    begin
        //UploadedFileName := CommonDialogMgt.OpenFile(Text006,ClientFileName,2,'',0);
        UploadedFileName := CommonDialogMgt.UploadFile(Text006, ClientFileName);
        FileName := UploadedFileName;
    end;

    local procedure FileNameOnAfterValidate()
    begin
        UploadFile;
    end;

    procedure RecibeParametros(TipoPpto: Option Ventas,Muestras)
    begin
        TipoPresupuesto := TipoPpto;
    end;
}

