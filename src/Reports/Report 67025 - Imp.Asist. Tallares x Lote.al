report 67025 "Imp.Asist. Tallares x Lote"
{
    Caption = 'Import Assistance workshops by Lot';
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

            trigger OnPostDataItem()
            begin
                Window.CLOSE;
                MESSAGE(Text001);
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
                field("Nombre Fichero"; FileName)
                {
                    Caption = 'Nombre Fichero';

                    trigger OnAssistEdit()
                    begin
                        UploadFile;
                    end;
                }
                field("Nombre Hoja"; SheetName)
                {
                    Caption = 'Nombre Hoja';

                    trigger OnAssistEdit()
                    begin
                        IF ISSERVICETIER THEN
                            SheetName := ExcelBuf.SelectSheetsName(UploadedFileName)
                        ELSE
                            SheetName := ExcelBuf.SelectSheetsName(FileName);
                    end;
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

    trigger OnPreReport()
    var
        BusUnit: Record 220;
    begin
    end;

    var
        ExcelBuf: Record 370 temporary;
        PlanifEvento: Record 67051;
        "Asist_T&E": Record 67016;
        Docente: Record 67001;
        FileName: Text[250];
        UploadedFileName: Text[1024];
        SheetName: Text[250];
        RecNo: Integer;
        CodTaller: Code[20];
        CodDocente: Code[20];
        Window: Dialog;
        TotalRecNo: Integer;
        wNreg: Integer;
        UltFila: Integer;
        Text007: Label 'Analyzing Data...\\';
        Text006: Label 'Import Excel File';
        Text001: Label 'Import completed, please review';

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

                CLEAR("Asist_T&E");
                CodTaller := ExcelBuf."Cell Value as Text";

                PlanifEvento.RESET;
                PlanifEvento.SETRANGE("Cod. Taller - Evento", CodTaller);
                PlanifEvento.FINDFIRST;

                ExcelBuf.NEXT(1);
                CodDocente := ExcelBuf."Cell Value as Text";
                Docente.RESET;
                Docente.SETRANGE("Document ID", CodDocente);
                Docente.FINDFIRST;

                CLEAR("Asist_T&E");
                "Asist_T&E".VALIDATE("Tipo Evento", PlanifEvento."Tipo Evento");
                "Asist_T&E".VALIDATE("Cod. Taller - Evento", CodTaller);
                "Asist_T&E".VALIDATE("Cod. Expositor", PlanifEvento.Expositor);
                "Asist_T&E".Secuencia := PlanifEvento.Secuencia;
                "Asist_T&E".VALIDATE("Cod. Docente", Docente."No.");
                IF "Asist_T&E".INSERT(TRUE) THEN;

                RecNo := RecNo + 1;
            UNTIL ExcelBuf.NEXT = 0;
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

