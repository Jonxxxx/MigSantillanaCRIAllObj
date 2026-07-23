report 56035 "Importa Lin. Compras"
{
    Caption = 'Import Purch. Lines';
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
                COMMIT;
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
                        field(DimensionProveedor; DimProv)
                        {
                            Caption = 'Vendor Dim. Code';
                            TableRelation = Dimension;
                        }
                    }
                    group("Data Columns")
                    {
                        Caption = 'Data Columns';
                        field(Cell_1; Cell1)
                        {
                            Caption = 'Item/G/L Account Code Cell';
                        }
                        field(Cell_2; Cell2)
                        {
                            Caption = 'Quantity Cell';
                        }
                        field(Cell_3; Cell3)
                        {
                            Caption = 'Direct Unit cost Cell';
                        }
                        field(Cell_4; Cell4)
                        {
                            Caption = 'Employee Cell';
                        }
                        field(Cell_5; Cell5)
                        {
                            Caption = 'Vendor Cell';
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
        PL: Record 39;
        PL2: Record 39;
        Item: Record 27;
        GLAcc: Record 15;
        Empl: Record 5200;
        DefDim: Record 352;
        Celda: Code[5];
        FileName: Text[250];
        UploadedFileName: Text[1024];
        SheetName: Text[250];
        Window: Dialog;
        Description: Text[50];
        CodProducto: Code[20];
        Cantidad: Decimal;
        Empleado: Code[20];
        Prov: Code[20];
        DimProv: Code[20];
        Costo: Decimal;
        Cell1: Code[5];
        Cell2: Code[5];
        Text0001: Label 'aaa';
        Text007: Label 'Analyzing Data...\\';
        Cell3: Code[5];
        Cell4: Code[5];
        Cell5: Code[5];
        TotalRecNo: Integer;
        RecNo: Integer;
        Text006: Label 'Import Excel File';
        NoLin: Integer;
        CodProd: Code[20];
        TipoDocumento: Integer;
        NoDocumento: Code[20];
        Err001: Label 'The code %1 doesn''t exist either as Item or G/L Account';
        FilaAnt: Integer;
        FirstTime: Boolean;
        UltimaFila: Integer;
        UltimaCelda: Code[20];
        Err002: Label 'Cost can''t be zero, check line %1';
        Err003: Label 'Quantity can''t be zero, check line %1';
        Err004: Label 'G/L Account or Item code can''t be blank, check line %1';
        ExcelFileExtensionTok: Label '.xlsx', Locked = true;

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

        FirstTime := TRUE;

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
        DimVal: Record 349;
        TempDimSetEntry: Record 480 temporary;
        DimMgt: Codeunit 408;
    begin
        Window.OPEN(
          Text007 +
          '@1@@@@@@@@@@@@@@@@@@@@@@@@@\');
        Window.UPDATE(1, 0);
        TotalRecNo := ExcelBuf.COUNT;
        RecNo := 0;
        FilaAnt := 0;
        IF ExcelBuf.FINDLAST THEN
            UltimaFila := ExcelBuf."Row No.";

        IF ExcelBuf.FIND('-') THEN
            REPEAT
                IF FirstTime THEN BEGIN
                    FirstTime := FALSE;
                    FilaAnt := ExcelBuf."Row No.";
                END;

                RecNo := RecNo + 1;
                Window.UPDATE(1, ROUND(RecNo / TotalRecNo * 10000, 1));
                Celda := ExcelBuf.xlColID + ExcelBuf.xlRowID;
                IF Celda = Cell1 THEN BEGIN
                    EVALUATE(CodProducto, ExcelBuf."Cell Value as Text");
                    Cell1 := INCSTR(Cell1);
                    IF NOT Item.GET(CodProducto) THEN
                        IF NOT GLAcc.GET(CodProducto) THEN
                            ERROR(Err001, CodProducto);
                END;

                IF Celda = Cell2 THEN BEGIN
                    EVALUATE(Cantidad, ExcelBuf."Cell Value as Text");
                    Cell2 := INCSTR(Cell2);
                    IF Cantidad = 0 THEN
                        ERROR(Err003, ExcelBuf."Row No.");
                END;

                IF Celda = Cell3 THEN BEGIN
                    EVALUATE(Costo, ExcelBuf."Cell Value as Text");
                    Cell3 := INCSTR(Cell3);
                    IF Costo = 0 THEN
                        ERROR(Err002, ExcelBuf."Row No.");
                END;

                IF Celda = Cell4 THEN
                    EVALUATE(Empleado, ExcelBuf."Cell Value as Text");

                IF Celda = Cell5 THEN
                    EVALUATE(Prov, ExcelBuf."Cell Value as Text");

                IF (CodProducto <> '') AND (Cantidad <> 0) AND (Costo <> 0) AND (FilaAnt < ExcelBuf."Row No.") THEN BEGIN
                    FilaAnt := ExcelBuf."Row No.";
                    Cell4 := INCSTR(Cell4);
                    Cell5 := INCSTR(Cell5);
                    PL2.RESET;
                    PL2.SETRANGE("Document Type", TipoDocumento);
                    PL2.SETRANGE("Document No.", NoDocumento);
                    IF NOT PL2.FINDLAST THEN
                        PL2."Line No." := 0;

                    PL2."Line No." += 1000;

                    PL.INIT;
                    PL."Document Type" := TipoDocumento;
                    PL."Document No." := NoDocumento;
                    PL."Line No." := PL2."Line No.";

                    IF Item.GET(CodProducto) THEN
                        PL.Type := PL.Type::Item
                    ELSE
                        PL.Type := PL.Type::"G/L Account";
                    PL.VALIDATE("No.", CodProducto);
                    PL.VALIDATE(Quantity, Cantidad);
                    PL.VALIDATE("Direct Unit Cost", Costo);
                    PL.INSERT(TRUE);

                    CLEAR(TempDimSetEntry);
                    IF Empleado <> '' THEN BEGIN
                        IF Empl.GET(Empleado) THEN BEGIN
                            PL.Description := COPYSTR(Empl."Full Name", 1, 60);
                            PL.MODIFY;

                            DefDim.RESET;
                            DefDim.SETRANGE("Table ID", 5200);
                            DefDim.SETRANGE("No.", Empleado);
                            DefDim.SETRANGE("Value Posting", 2); //Igual a codigo
                            IF DefDim.FINDSET THEN
                                REPEAT
                                    DimVal.GET(DefDim."Dimension Code", DefDim."Dimension Value Code");
                                    TempDimSetEntry.INIT;
                                    TempDimSetEntry."Dimension Code" := DefDim."Dimension Code";
                                    TempDimSetEntry."Dimension Value Code" := DefDim."Dimension Value Code";
                                    TempDimSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
                                    TempDimSetEntry.INSERT;
                                UNTIL DefDim.NEXT = 0;
                        END;
                    END;

                    IF Prov <> '' THEN BEGIN
                        DimVal.GET(DimProv, Prov);
                        TempDimSetEntry.INIT;
                        TempDimSetEntry."Dimension Code" := DimProv;
                        TempDimSetEntry."Dimension Value Code" := Prov;
                        TempDimSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
                        TempDimSetEntry.INSERT;
                    END;

                    PL."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);
                    PL.MODIFY;

                    CodProducto := '';
                    Empleado := '';
                    Prov := '';
                    Cantidad := 0;
                    Costo := 0;
                END;
            UNTIL ExcelBuf.NEXT = 0;

        Cell1 := COPYSTR(Cell1, 1, 1) + FORMAT(UltimaFila);
        Cell2 := COPYSTR(Cell2, 1, 1) + FORMAT(UltimaFila);
        Cell3 := COPYSTR(Cell3, 1, 1) + FORMAT(UltimaFila);
        Cell4 := COPYSTR(Cell4, 1, 1) + FORMAT(UltimaFila);
        Cell5 := COPYSTR(Cell5, 1, 1) + FORMAT(UltimaFila);

        ExcelBuf.SETRANGE("Row No.", UltimaFila);
        IF ExcelBuf.FINDLAST THEN
            UltimaCelda := ExcelBuf.xlColID + ExcelBuf.xlRowID;

        ExcelBuf.RESET;
        ExcelBuf.SETRANGE("Row No.", UltimaFila);
        IF ExcelBuf.FIND('-') THEN
            REPEAT
                RecNo := RecNo + 1;
                Window.UPDATE(1, ROUND(RecNo / TotalRecNo * 10000, 1));
                Celda := ExcelBuf.xlColID + ExcelBuf.xlRowID;
                IF Celda = Cell1 THEN BEGIN
                    EVALUATE(CodProducto, ExcelBuf."Cell Value as Text");
                    Cell1 := INCSTR(Cell1);
                    IF NOT Item.GET(CodProducto) THEN
                        IF NOT GLAcc.GET(CodProducto) THEN
                            ERROR(Err001, CodProducto);
                END;

                IF Celda = Cell2 THEN BEGIN
                    EVALUATE(Cantidad, ExcelBuf."Cell Value as Text");
                    Cell2 := INCSTR(Cell2);
                    IF Cantidad = 0 THEN
                        ERROR(Err003, ExcelBuf."Row No.");
                END;

                IF Celda = Cell3 THEN BEGIN
                    EVALUATE(Costo, ExcelBuf."Cell Value as Text");
                    Cell3 := INCSTR(Cell3);
                    IF Costo = 0 THEN
                        ERROR(Err002, ExcelBuf."Row No.");
                END;

                IF Celda = Cell4 THEN BEGIN
                    EVALUATE(Empleado, ExcelBuf."Cell Value as Text");
                    Cell4 := INCSTR(Cell4);
                END;

                IF Celda = Cell5 THEN BEGIN
                    EVALUATE(Prov, ExcelBuf."Cell Value as Text");
                    Cell5 := INCSTR(Cell5);
                END;

                IF (CodProducto <> '') AND (Cantidad <> 0) AND (Costo <> 0) AND (UltimaCelda = ExcelBuf.xlColID + ExcelBuf.xlRowID) THEN BEGIN
                    PL2.RESET;
                    PL2.SETRANGE("Document Type", TipoDocumento);
                    PL2.SETRANGE("Document No.", NoDocumento);
                    IF NOT PL2.FINDLAST THEN
                        PL2."Line No." := 0;

                    PL2."Line No." += 1000;

                    PL.INIT;
                    PL."Document Type" := TipoDocumento;
                    PL."Document No." := NoDocumento;
                    PL."Line No." := PL2."Line No.";

                    IF Item.GET(CodProducto) THEN
                        PL.Type := PL.Type::Item
                    ELSE
                        PL.Type := PL.Type::"G/L Account";
                    PL.VALIDATE("No.", CodProducto);
                    PL.VALIDATE(Quantity, Cantidad);
                    PL.VALIDATE("Direct Unit Cost", Costo);
                    PL.INSERT(TRUE);
                    CLEAR(TempDimSetEntry);
                    IF Empleado <> '' THEN BEGIN
                        IF Empl.GET(Empleado) THEN BEGIN
                            PL.Description := COPYSTR(Empl."Full Name", 1, 60);
                            PL.MODIFY;

                            DefDim.RESET;
                            DefDim.SETRANGE("Table ID", 5200);
                            DefDim.SETRANGE("No.", Empleado);
                            DefDim.SETRANGE("Value Posting", 2); //Igual a codigo
                            IF DefDim.FINDSET THEN
                                REPEAT
                                    DimVal.GET(DefDim."Dimension Code", DefDim."Dimension Value Code");
                                    TempDimSetEntry.INIT;
                                    TempDimSetEntry."Dimension Code" := DefDim."Dimension Code";
                                    TempDimSetEntry."Dimension Value Code" := DefDim."Dimension Value Code";
                                    TempDimSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
                                    TempDimSetEntry.INSERT;

                                UNTIL DefDim.NEXT = 0;
                        END;
                    END;
                    IF Prov <> '' THEN BEGIN
                        DimVal.GET(DimProv, Prov);
                        TempDimSetEntry.INIT;
                        TempDimSetEntry."Dimension Code" := DimProv;
                        TempDimSetEntry."Dimension Value Code" := Prov;
                        TempDimSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
                        TempDimSetEntry.INSERT;

                    END;
                    PL."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);
                    PL.MODIFY;

                END;
            UNTIL ExcelBuf.NEXT = 0;

        Window.CLOSE;
    end;

    procedure UploadFile()
    var
        FileMgt: Codeunit 419;
        ClientFileName: Text[1024];
    begin
        UploadedFileName := FileMgt.UploadFile(Text006, ExcelFileExtensionTok);

        FileName := UploadedFileName;
    end;

    local procedure FileNameOnAfterValidate()
    begin
        UploadFile;
    end;
}

