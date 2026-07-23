report 52503 "Importar Lista Precios PR2"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Import Price List';
    ProcessingOnly = true;
    UsageCategory = Tasks;
    UseRequestPage = false;

    dataset
    {
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnInitReport()
    var
        FileInStream: InStream;
    begin
        if UploadIntoStream(CSVFileFilterLbl, FileInStream) then
            Xmlport.Import(
                Xmlport::"Importa Lista de Precios PR2",
                FileInStream);

        CurrReport.Quit();
    end;

    var
        CSVFileFilterLbl: Label 'CSV Files (*.csv)|*.csv|All Files (*.*)|*.*';
}