report 34002182 "Importa datos empleados"
{
    Caption = 'Import Employee data';
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
                group(General)
                {
                    group("Import from")
                    {
                        Caption = 'Import from';
                        field(ConceptoSal; ConceptoSal)
                        {
                            Caption = 'Wedge''s Concept';
                            TableRelation = "Conceptos salariales";
                        }
                        group(General2)
                        {
                            field(Cell3; Cell3)
                            {
                                Caption = 'Employee code cell';
                            }
                            field(Cell1; Cell1)
                            {
                                Caption = 'Quantity Cell';
                            }
                            field(Cell2; Cell2)
                            {
                                Caption = 'Amount Cell';
                            }
                        }
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnQueryClosePage(CloseAction: Action): Boolean
        var
            FileMgt: Codeunit 419;
        begin
            IF CloseAction = ACTION::OK THEN BEGIN
                IF ServerFileName = '' THEN
                    ServerFileName := FileMgt.UploadFile(Text006, ExcelFileExtensionTok);
                IF ServerFileName = '' THEN
                    EXIT(FALSE);
            END;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        NoLin := 1000;
    end;

    trigger OnPreReport()
    begin
        IF SheetName = '' THEN
            SheetName := ExcelBuf.SelectSheetsName(ServerFileName);
    end;

    var
        ExcelBuf: Record 370;
        PerfilSal: Record 34002115;
        Celda: Code[5];
        ServerFileName: Text[250];
        UploadedFileName: Text[1024];
        SheetName: Text[250];
        Window: Dialog;
        Description: Text[50];
        Qty: Decimal;
        Amt: Decimal;
        CodEmpleado: Code[20];
        Cell1: Code[5];
        Cell2: Code[5];
        Text0001: Label 'aaa';
        Text007: Label 'Analyzing Data...\\';
        Cell3: Code[5];
        TotalRecNo: Integer;
        RecNo: Integer;
        Text006: Label 'Import Excel File';
        NoLin: Integer;
        CodProd: Code[20];
        ConceptoSal: Code[20];
        ExcelFileExtensionTok: Label '.xlsx', Locked = true;

    local procedure ReadExcelSheet()
    begin
        /*
        IF ISSERVICETIER THEN
          IF UploadedFileName = '' THEN
            UploadFile
          ELSE
            FileName := UploadedFileName;
        */
        ExcelBuf.OpenBook(ServerFileName, SheetName);
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
                    EVALUATE(Qty, ExcelBuf."Cell Value as Text");
                    Cell1 := INCSTR(Cell1);
                END
                ELSE
                    IF Celda = Cell2 THEN BEGIN
                        EVALUATE(Amt, ExcelBuf."Cell Value as Text");
                        Cell2 := INCSTR(Cell2);
                    END
                    ELSE
                        IF Celda = Cell3 THEN BEGIN
                            CodEmpleado := ExcelBuf."Cell Value as Text";
                            CodEmpleado := DELCHR(CodEmpleado, '=', ', .');
                            Cell3 := INCSTR(Cell3);
                        END;

                //    MESSAGE('%1 %2 %3 %4 %5 %6 %7 %8',CodEmpleado,Qty,Amt,Celda,Cell1,Cell2,Cell3);

                IF CodEmpleado <> '' THEN BEGIN
                    PerfilSal.RESET;
                    PerfilSal.SETRANGE("No. empleado", CodEmpleado);
                    PerfilSal.SETRANGE("Concepto salarial", ConceptoSal);
                    IF PerfilSal.FINDFIRST THEN BEGIN
                        IF Cell1 <> '' THEN
                            PerfilSal.VALIDATE(Cantidad, Qty);

                        IF (Cell2 <> '') AND (Cell1 = '') THEN BEGIN
                            PerfilSal.VALIDATE(Cantidad, 1);
                            IF PerfilSal."Formula Calculo" = '' THEN
                                PerfilSal.VALIDATE(Importe, Amt);
                        END
                        ELSE
                            IF Cell2 <> '' THEN BEGIN
                                PerfilSal.VALIDATE(Cantidad, Qty);
                                IF PerfilSal."Formula Calculo" = '' THEN
                                    PerfilSal.VALIDATE(Importe, Amt);
                            END;

                        PerfilSal.MODIFY;
                    END;
                END;
            UNTIL ExcelBuf.NEXT = 0;

        Window.CLOSE;
    end;

    [Scope('Personalization')]
    procedure SetFileName(NewFileName: Text)
    begin
        ServerFileName := NewFileName;
    end;
}

