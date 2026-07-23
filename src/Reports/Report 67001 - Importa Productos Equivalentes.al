report 67001 "Importa Productos Equivalentes"
{
    Caption = 'Import Equivalent items';
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
                        field(Cell_1; Cell1)
                        {
                            Caption = 'Item Code Cell';
                        }
                        field(Cell_2; Cell2)
                        {
                            Caption = 'Equivalent Item Code Cell';
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
        PL: Record 67005;
        PL2: Record 67005;
        Celda: Code[6];
        FileName: Text[250];
        UploadedFileName: Text[1024];
        SheetName: Text[250];
        Window: Dialog;
        Description: Text[50];
        CodProducto: Code[20];
        Cantidad: Decimal;
        CodProdEq: Code[20];
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
        TipoDocumento: Integer;
        NoDocumento: Code[20];

    procedure RecibeParametros(TipoDoc: Integer; NoDoc: Code[20])
    begin
        TipoDocumento := TipoDoc;
        NoDocumento := NoDoc;
    end;

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
                IF Celda = Cell1 THEN BEGIN
                    EVALUATE(CodProducto, ExcelBuf."Cell Value as Text");
                    Cell1 := INCSTR(Cell1);
                END
                ELSE
                    IF Celda = Cell2 THEN BEGIN
                        EVALUATE(CodProdEq, ExcelBuf."Cell Value as Text");
                        Cell2 := INCSTR(Cell2);
                    END;
                //    MESSAGE('a%1 b%2 c%3 d%4 e%5',Celda,Cell1,Cell2,CodProducto,CodProdEq);
                IF (CodProducto <> '') AND (CodProdEq <> '') THEN BEGIN
                    /*
                     PL2.RESET;
                     PL2.SETRANGE("Document Type",TipoDocumento);
                     PL2.SETRANGE("Document No.",NoDocumento);
                     IF NOT PL2.FINDLAST THEN
                        PL2."Line No." := 0;

                     PL2."Line No." += 1000;

                     PL.INIT;
                     PL."Document Type" := TipoDocumento;
                     PL."Document No."  := NoDocumento;
                     PL."Line No."      := PL2."Line No.";
                     PL.Type            := PL.Type::Item;
                     PL.VALIDATE("No.",CodProducto);
                     PL.VALIDATE(Quantity,Cantidad);
                     PL.VALIDATE("Direct Unit Cost",Costo);
                     PL.INSERT(TRUE);
                    END;
                   */
                    CLEAR(PL);
                    PL.VALIDATE("Cod. Producto", CodProducto);
                    PL.VALIDATE("Cod. Producto Anterior", CodProdEq);
                    IF PL.INSERT THEN;

                    CLEAR(CodProducto);
                    CLEAR(CodProdEq);
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
}

