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

    labels
    {
    }

    trigger OnInitReport()
    var
        ConfPersMgt: Codeunit 9170;
        TempFile: File;
    begin

        TempFile.CREATETEMPFILE;
        FileName := TempFile.NAME + '.xml';
        TempFile.CLOSE;
        IF UPLOAD(Text001, '', Text002, '', FileName) THEN BEGIN
            ProfileFile.OPEN(FileName);
            ProfileFile.CREATEINSTREAM(FileInStream);
            XMLPORT.IMPORT(XMLPORT::"Importa Lista de Precios PR2", FileInStream);
            ProfileFile.CLOSE;
        END;
        CurrReport.QUIT;
    end;

    var
        FileName: Text[250];
        Text001: Label 'Import from CSV File';
        Text002: Label 'CSV Files (*.csv)|*.csv|All Files (*.*)|*.*';
        FileInStream: InStream;
        ProfileFile: File;
}

