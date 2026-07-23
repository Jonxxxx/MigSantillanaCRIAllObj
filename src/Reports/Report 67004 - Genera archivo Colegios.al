report 67004 "Genera archivo Colegios"
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Generate Schools File';
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UsageCategory = ReportsAndAnalysis;
    UseRequestPage = false;

    dataset
    {
        dataitem(Contact; Contact)
        {
            DataItemTableView = sorting("No.");

            dataitem("Colegio - Nivel"; 67036)
            {
                DataItemLink = "Cod. Colegio" = field("No.");
                DataItemTableView = sorting(
                    "Cod. Colegio",
                    "Cod. Nivel",
                    Turno);

                trigger OnAfterGetRecord()
                begin
                    Clear(LineBody);

                    SchoolRoute.Reset();
                    SchoolRoute.SetRange("Cod. Ruta", Ruta);

                    if SchoolRoute.FindFirst() then begin
                        DimensionValue.Reset();
                        DimensionValue.SetRange(
                            "Dimension Code",
                            APSSetup."Cod. Dimension Delegacion");
                        DimensionValue.SetRange(
                            Code,
                            Contact.Delegacion);
                        DimensionValue.FindFirst();

                        SalespersonPurchaser.Get(
                            SchoolRoute."Cod. Promotor");

                        LineBody :=
                            "Cod. Colegio" + ';' +
                            Contact.Name + ';' +
                            "Cod. Nivel" + ';' +
                            Contact."Post Code" + ';' +
                            Contact.City + ';' +
                            Contact.Address + ';' +
                            SchoolRoute."Cod. Promotor" + ';' +
                            SalespersonPurchaser.Name + ';' +
                            Contact.Delegacion + ';' +
                            DimensionValue.Name;

                        FileOutStream.WriteText(LineBody);
                        FileOutStream.WriteText();
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
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
            end;

            trigger OnPostDataItem()
            begin
                if GuiAllowed() then
                    Window.Close();

                DownloadSchoolsFile();
            end;

            trigger OnPreDataItem()
            begin
                APSSetup.Get();

                Counter := 0;
                CounterTotal := Count();

                TempBlob.CreateOutStream(
                    FileOutStream,
                    TextEncoding::Windows);

                if GuiAllowed() then
                    Window.Open(ProcessingLbl);
            end;
        }
    }

    var
        APSSetup: Record 67000;
        SchoolRoute: Record 67044;
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        DimensionValue: Record "Dimension Value";
        TempBlob: Codeunit "Temp Blob";
        FileOutStream: OutStream;
        LineBody: Text[500];
        CounterTotal: Integer;
        Counter: Integer;
        Window: Dialog;
        ProcessingLbl: Label 'Processing  #1########## @2@@@@@@@@@@@@@';
        FileNameLbl: Label 'COLEGIOS.csv', Locked = true;
        CSVFileFilterLbl: Label 'CSV files (*.csv)|*.csv';

    local procedure DownloadSchoolsFile()
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