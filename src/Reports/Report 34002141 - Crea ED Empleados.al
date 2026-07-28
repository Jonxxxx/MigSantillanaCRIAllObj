report 34002141 "Crea ED Empleados"
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

                ExcelBuf.FIND('-');

                EVALUATE(Fila, COPYSTR(Cell1, 2, 5));

                // MESSAGE('%1 %2',Cell1);

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
                        field("Nombre fichero"; FileName)
                        {
                            Caption = 'Workbook File Name';

                            trigger OnAssistEdit()
                            begin
                                UploadFile;
                            end;
                        }
                        field(SheetName; SheetName)
                        {
                            Caption = 'Worksheet Name';

                            trigger OnAssistEdit()
                            begin
                                SheetName := ExcelBuf.SelectSheetsName(UploadedFileName)
                            end;
                        }
                        group(General)
                        {
                            field(Cell1; Cell1)
                            {
                                Caption = 'Employee code Cell';
                            }
                            field(Cell2; Cell2)
                            {
                                Caption = 'G/L Account Cell';
                            }
                            field(Cell3; Cell3)
                            {
                                Caption = 'Amount Cell';
                            }
                            field(Cell4; Cell4)
                            {
                                Caption = 'Dimension Code Cell';
                            }
                            field(Cell5; Cell5)
                            {
                                Caption = 'Dimension Value Cell';
                            }
                            field(Cell6; Cell6)
                            {
                                Caption = 'Balance Account';
                            }
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
        ExcelBuf: Record 370;
        GenJnlLine: Record 81;
        GenJnlLine2: Record 81;
        Emp: Record 5200;
        DefDim: Record 352;
        CodigoDiario: Code[20];
        CodigoSeccion: Code[20];
        Celda: Code[5];
        FileName: Text[250];
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
        Text003: Label '.xlsx';
        Cell3: Code[5];
        Cell4: Code[5];
        Cell5: Code[10];
        Cell6: Code[10];
        TotalRecNo: Integer;
        RecNo: Integer;
        Text006: Label 'Import Excel File';
        Text007: Label 'Analyzing Data...\\';
        NoLin: Integer;
        CodCuenta: Code[20];
        CodDim: Code[20];
        CodValorDim: Code[20];
        Fila: Integer;
        CtaContrapartida: Code[20];

    procedure RecibeParametros(CodDiario: Code[20]; CodSeccion: Code[20])
    begin
        CodigoDiario := CodDiario;
        CodigoSeccion := CodSeccion;
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
        Amt := 0;

        ExcelBuf.SETRANGE("Row No.", Fila, 9999999);

        IF ExcelBuf.FIND('-') THEN
            REPEAT

                RecNo := RecNo + 1;
                Window.UPDATE(1, ROUND(RecNo / TotalRecNo * 10000, 1));
                Celda := ExcelBuf.xlColID + ExcelBuf.xlRowID;
                IF Celda = Cell6 THEN BEGIN
                    EVALUATE(CtaContrapartida, ExcelBuf."Cell Value as Text");
                    Cell6 := INCSTR(Cell6);
                END
                ELSE
                    IF Celda = Cell5 THEN BEGIN
                        EVALUATE(CodValorDim, ExcelBuf."Cell Value as Text");
                        Cell5 := INCSTR(Cell5);
                    END
                    ELSE
                        IF Celda = Cell4 THEN BEGIN
                            EVALUATE(CodDim, ExcelBuf."Cell Value as Text");
                            Cell4 := INCSTR(Cell4);
                        END
                        ELSE
                            IF Celda = Cell3 THEN BEGIN
                                EVALUATE(Amt, ExcelBuf."Cell Value as Text");
                                Cell3 := INCSTR(Cell3);
                            END
                            ELSE
                                IF Celda = Cell2 THEN BEGIN
                                    CodCuenta := ExcelBuf."Cell Value as Text";
                                    Cell2 := INCSTR(Cell2);
                                END
                                ELSE
                                    IF Celda = Cell1 THEN BEGIN
                                        CodEmpleado := ExcelBuf."Cell Value as Text";
                                        CodEmpleado := DELCHR(CodEmpleado, '=', ', .');
                                        Cell1 := INCSTR(Cell1);
                                    END;

                //    MESSAGE('%1 %2 %3 %4 %5 %6 %7 %8',ExcelBuf.xlRowID,CodEmpleado,Qty,Amt,Celda,Cell1,Cell2,Cell3);

                IF (CodEmpleado <> '') AND (CodCuenta <> '') AND (Amt <> 0) AND
                   (CodDim <> '') AND (CodValorDim <> '') AND (CtaContrapartida <> '') THEN BEGIN
                    Emp.GET(CodEmpleado);
                    GenJnlLine2.RESET;
                    GenJnlLine2.SETRANGE("Journal Template Name", CodigoDiario);
                    GenJnlLine2.SETRANGE("Journal Batch Name", CodigoSeccion);
                    IF NOT GenJnlLine2.FINDLAST THEN
                        GenJnlLine2."Line No." := 0;

                    NoLin := GenJnlLine2."Line No." + 1000;

                    CLEAR(GenJnlLine);
                    GenJnlLine."Journal Template Name" := CodigoDiario;
                    GenJnlLine."Journal Batch Name" := CodigoSeccion;
                    GenJnlLine."Line No." := NoLin;
                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                    GenJnlLine.VALIDATE("Account No.", CodCuenta);
                    GenJnlLine.VALIDATE("Posting Date", TODAY);
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                    GenJnlLine."Document No." := 'NOMINA' + FORMAT(DATE2DMY(TODAY, 1)) + FORMAT(DATE2DMY(TODAY, 2)) +
                                                 FORMAT(DATE2DMY(TODAY, 3));
                    GenJnlLine.Description := Emp."Full Name";
                    GenJnlLine.VALIDATE(Amount, Amt);
                    GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                    GenJnlLine.VALIDATE("Bal. Account No.", CtaContrapartida);

                    GenJnlLine.INSERT(TRUE);
                    /*
                            DefDim.RESET;
                            DefDim.SETRANGE("Table ID",5200);
                            DefDim.SETRANGE("No.",CodEmpleado);
                            IF DefDim.FINDSET THEN
                               REPEAT
                                CLEAR(JLD);
                                JLD."Table ID"              := 81;
                                JLD."Journal Template Name" := CodigoDiario;
                                JLD."Journal Batch Name"    := CodigoSeccion;
                                JLD."Journal Line No."      := GenJnlLine."Line No.";
                                JLD.VALIDATE("Dimension Code",DefDim."Dimension Code");
                                JLD.VALIDATE("Dimension Value Code",DefDim."Dimension Value Code");
                                JLD.INSERT(TRUE);
                               UNTIL DefDim.NEXT =0;

                             CLEAR(JLD);
                             JLD."Table ID"              := 81;
                             JLD."Journal Template Name" := CodigoDiario;
                             JLD."Journal Batch Name"    := CodigoSeccion;
                             JLD."Journal Line No."      := GenJnlLine."Line No.";
                             JLD.VALIDATE("Dimension Code",CodDim);
                             JLD.VALIDATE("Dimension Value Code",CodValorDim);
                             JLD.INSERT(TRUE);
                    */
                    Amt := 0;
                    CodEmpleado := '';
                    CodCuenta := '';
                    CodDim := '';
                    CodValorDim := '';
                END;

            UNTIL ExcelBuf.NEXT = 0;

        Window.CLOSE;

    end;

    procedure UploadFile()
    var
        FileMgt: Codeunit 419;
        ClientFileName: Text[1024];
    begin
        UploadedFileName := FileMgt.UploadFile(Text006, Text003);
        FileName := UploadedFileName;
    end;

    local procedure FileNameOnAfterValidate()
    begin
        UploadFile;
    end;
}

