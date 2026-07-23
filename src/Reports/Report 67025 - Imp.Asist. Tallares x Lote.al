report 67025 "Imp.Asist. Tallares x Lote"
{
    ApplicationArea = All;
    Caption = 'Import Assistance workshops by Lot';
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

            trigger OnPostDataItem()
            begin
                if GuiAllowed() then begin
                    Window.Close();
                    Message(ImportCompletedLbl);
                end;
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
                field(FileNameField; FileName)
                {
                    ApplicationArea = All;
                    Caption = 'Nombre Fichero';
                    ToolTip = 'Specifies the Excel workbook to import.';

                    trigger OnAssistEdit()
                    begin
                        UploadFile();
                    end;

                    trigger OnValidate()
                    begin
                        FileNameOnAfterValidate();
                    end;
                }

                field(SheetNameField; SheetName)
                {
                    ApplicationArea = All;
                    Caption = 'Nombre Hoja';
                    ToolTip = 'Specifies the worksheet to import.';

                    trigger OnAssistEdit()
                    begin
                        if not HasUploadedFile then
                            UploadFile();

                        if HasUploadedFile then
                            SheetName := SelectWorksheet();
                    end;
                }
            }
        }
    }

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
        PlanifEvento: Record 67051;
        "Asist_T&E": Record 67016;
        Docente: Record 67001;
        TempBlob: Codeunit "Temp Blob";
        FileName: Text[250];
        SheetName: Text[250];
        RecNo: Integer;
        CodTaller: Code[20];
        CodDocente: Code[20];
        Window: Dialog;
        TotalRecNo: Integer;
        HasUploadedFile: Boolean;
        AnalyzingDataLbl: Label 'Analyzing Data...\\';
        ExcelFileFilterLbl: Label 'Excel files (*.xlsx)|*.xlsx';
        UploadedWorkbookLbl: Label 'Uploaded workbook';
        ImportCompletedLbl: Label 'Import completed, please review';
        FileNotSelectedErr: Label 'You must select an Excel file.';
        SheetNotSelectedErr: Label 'You must select an Excel worksheet.';
        OpenBookErr: Label 'The Excel workbook could not be opened. %1';

    local procedure ReadExcelSheet()
    var
        ExcelInStream: InStream;
        OpenBookError: Text;
    begin
        ExcelBuf.Reset();
        ExcelBuf.DeleteAll();

        TempBlob.CreateInStream(ExcelInStream);

        OpenBookError :=
            ExcelBuf.OpenBookStream(
                ExcelInStream,
                SheetName);

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

        if ExcelBuf.Find('-') then
            repeat
                RecNo += 1;

                if GuiAllowed() and (TotalRecNo <> 0) then
                    Window.Update(
                        1,
                        Round(
                            RecNo / TotalRecNo * 10000,
                            1));

                Clear("Asist_T&E");

                CodTaller :=
                    ExcelBuf."Cell Value as Text";

                PlanifEvento.Reset();
                PlanifEvento.SetRange(
                    "Cod. Taller - Evento",
                    CodTaller);
                PlanifEvento.FindFirst();

                ExcelBuf.Next(1);

                CodDocente :=
                    ExcelBuf."Cell Value as Text";

                Docente.Reset();
                Docente.SetRange(
                    "Document ID",
                    CodDocente);
                Docente.FindFirst();

                Clear("Asist_T&E");

                "Asist_T&E".Validate(
                    "Tipo Evento",
                    PlanifEvento."Tipo Evento");

                "Asist_T&E".Validate(
                    "Cod. Taller - Evento",
                    CodTaller);

                "Asist_T&E".Validate(
                    "Cod. Expositor",
                    PlanifEvento.Expositor);

                "Asist_T&E".Secuencia :=
                    PlanifEvento.Secuencia;

                "Asist_T&E".Validate(
                    "Cod. Docente",
                    Docente."No.");

                if not "Asist_T&E".Insert(true) then
                    Clear("Asist_T&E");

                RecNo += 1;
            until ExcelBuf.Next() = 0;
    end;

    procedure UploadFile()
    var
        UploadInStream: InStream;
        BlobOutStream: OutStream;
    begin
        if not UploadIntoStream(
             ExcelFileFilterLbl,
             UploadInStream)
        then
            exit;

        Clear(TempBlob);
        TempBlob.CreateOutStream(BlobOutStream);

        CopyStream(
            BlobOutStream,
            UploadInStream);

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

        exit(
            ExcelBuf.SelectSheetsNameStream(
                ExcelInStream));
    end;

    local procedure FileNameOnAfterValidate()
    begin
        UploadFile();
    end;
}