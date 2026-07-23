report 67005 "Genera archivo Docentes"
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Generate Teachers File';
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UsageCategory = ReportsAndAnalysis;
    UseRequestPage = false;

    dataset
    {
        dataitem(Docentes; 67001)
        {
            DataItemTableView = sorting("No.");

            trigger OnPreDataItem()
            begin
                Counter := 0;
                CounterTotal := Count();

                TempBlob.CreateOutStream(
                    FileOutStream,
                    TextEncoding::Windows);

                if GuiAllowed() then
                    Window.Open(ProcessingLbl);
            end;

            trigger OnAfterGetRecord()
            begin
                Clear(LineBody);
                Clear(AdditionalData);

                Counter += 1;

                if GuiAllowed() then begin
                    Window.Update(1, "No.");

                    if CounterTotal <> 0 then
                        Window.Update(
                            2,
                            Round(
                                Counter / CounterTotal * 10000,
                                1));
                end;

                if "Job Type Code" <> '' then begin
                    AdditionalData.Reset();
                    AdditionalData.SetRange(
                        "Tipo registro",
                        AdditionalData."Tipo registro"::"Puestos de trabajo");
                    AdditionalData.SetRange(
                        Codigo,
                        "Job Type Code");

                    if not AdditionalData.FindFirst() then
                        Clear(AdditionalData);
                end;

                LineBody :=
                    "Document ID" + ';' +
                    "Salutation Code" + ';' +
                    Format(Sexo) + ';' +
                    Format(Hijos) + ';' +
                    "Last Name" + ';' +
                    "Second Last Name" + ';' +
                    "First Name" + ';' +
                    "Tipo documento" + ';' +
                    "Document ID" + ';' +
                    "Phone No." + ';' +
                    "Mobile Phone No." + ';' +
                    Address + ';' +
                    "Address 2" + ';' +
                    City + ';' +
                    "E-Mail" + ';' +
                    Format(
                        "Dia Nacimiento",
                        0,
                        '<Integer,2><Filler Character,0>') + '/' +
                    Format(
                        "Mes Nacimiento",
                        0,
                        '<Integer,2><Filler Character,0>') + '/' +
                    Format(
                        "Ano Nacimiento",
                        0,
                        '<Integer,4><Filler Character,0>') + ';' +
                    "Nivel Docente" + ';' +
                    "Job Type Code" + ';' +
                    AdditionalData.Descripcion;

                FileOutStream.WriteText(LineBody);
                FileOutStream.WriteText();
            end;

            trigger OnPostDataItem()
            begin
                if GuiAllowed() then
                    Window.Close();

                DownloadTeachersFile();
            end;
        }
    }

    var
        AdditionalData: Record 67002;
        TempBlob: Codeunit "Temp Blob";
        FileOutStream: OutStream;
        LineBody: Text[500];
        CounterTotal: Integer;
        Counter: Integer;
        Window: Dialog;
        ProcessingLbl: Label 'Processing  #1########## @2@@@@@@@@@@@@@';
        FileNameLbl: Label 'DOCENTES.csv', Locked = true;
        CSVFileFilterLbl: Label 'CSV files (*.csv)|*.csv';

    local procedure DownloadTeachersFile()
    var
        FileInStream: InStream;
        FileName: Text;
    begin
        TempBlob.CreateInStream(
            FileInStream,
            TextEncoding::Windows);

        FileName := FileNameLbl;

        DownloadFromStream(
            FileInStream,
            '',
            '',
            CSVFileFilterLbl,
            FileName);
    end;
}