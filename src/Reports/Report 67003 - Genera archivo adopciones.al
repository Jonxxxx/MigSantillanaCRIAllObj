report 67003 "Genera archivo adopciones"
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Generate Adoptions File';
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UsageCategory = ReportsAndAnalysis;
    UseRequestPage = false;

    dataset
    {
        dataitem("Colegio - Adopciones Detalle"; 67053)
        {
            DataItemTableView = sorting(
                                    "Cod. Colegio",
                                    "Cod. Nivel",
                                    "Cod. Grado",
                                    "Cod. Turno",
                                    "Cod. Promotor",
                                    "Cod. Producto")
                                where("Cantidad Alumnos" = filter(<> 0));

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
                Counter += 1;

                if GuiAllowed() then begin
                    Window.Update(1, "Cod. Colegio");

                    if CounterTotal <> 0 then
                        Window.Update(
                            2,
                            Round(Counter / CounterTotal * 10000, 1));
                end;

                Item.Get("Cod. Producto");

                LineBody :=
                    "Cod. Colegio" + ';' +
                    "Cod. Producto" + ';' +
                    "Descripcion producto" + ';' +
                    "Linea de negocio" + ';' +
                    Familia + ';' +
                    "Sub Familia" + ';' +
                    Serie + ';' +
                    "Cod. Grado" + ';' +
                    "Sub Familia" + ' ' +
                    Serie + ' ' +
                    Item.Tipos;

                FileOutStream.WriteText(LineBody);
                FileOutStream.WriteText();
            end;

            trigger OnPostDataItem()
            begin
                if GuiAllowed() then
                    Window.Close();

                DownloadAdoptionsFile();
            end;
        }
    }

    var
        Item: Record Item;
        TempBlob: Codeunit "Temp Blob";
        FileOutStream: OutStream;
        LineBody: Text[500];
        CounterTotal: Integer;
        Counter: Integer;
        Window: Dialog;
        ProcessingLbl: Label 'Processing  #1########## @2@@@@@@@@@@@@@';
        FileNameLbl: Label 'ADOPCIONES.csv', Locked = true;
        CSVFileFilterLbl: Label 'CSV files (*.csv)|*.csv';

    local procedure DownloadAdoptionsFile()
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