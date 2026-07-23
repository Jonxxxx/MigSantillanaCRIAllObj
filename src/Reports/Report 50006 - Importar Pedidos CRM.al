report 50006 "Importar Pedidos CRM"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Import CRM Orders';
    ProcessingOnly = true;
    UsageCategory = Tasks;

    trigger OnPreReport()
    var
        FileInStream: InStream;
    begin
        if UploadIntoStream(XmlFileFilterLbl, FileInStream) then
            Xmlport.Import(
                Xmlport::"Importar Pedidos CRM",
                FileInStream);

        CurrReport.Quit();
    end;

    var
        XmlFileFilterLbl: Label 'XML Files (*.xml)|*.xml';
}