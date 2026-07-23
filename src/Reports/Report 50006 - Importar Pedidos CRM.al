report 50006 "Importar Pedidos CRM"
{
    // YFC     : Yefrecis Francisco Cruz
    // ------------------------------------------------------------------------
    // No.         Firma   Fecha         Descripcion
    // ------------------------------------------------------------------------
    // 001         YFC     31/01/2024    SANTINAV-5207

    ApplicationArea = Basic, Suite;
    Caption = 'Import CRM Orders';
    ProcessingOnly = true;
    UsageCategory = Tasks;

    dataset
    {
    }

    requestpage
    {

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

    trigger OnPreReport()
    begin

        TempFile.CREATETEMPFILE;
        FileName := TempFile.NAME + '.xml';
        TempFile.CLOSE;
        IF UPLOAD(Text001, '', Text002, '', FileName) THEN BEGIN
            ProfileFile.OPEN(FileName);
            ProfileFile.CREATEINSTREAM(FileInStream);
            XMLPORT.IMPORT(XMLPORT::"Importar Pedidos CRM", FileInStream);
            ProfileFile.CLOSE;
        END;
        CurrReport.QUIT;
    end;

    var
        FileName: Text[250];
        FileInStream: InStream;
        ProfileFile: File;
        Text001: Label 'Import from XML File';
        Text002: Label 'XML Files (*.xml)|*.xml';
        gdgVentana: Dialog;
        giContador: Integer;
        giTotalContador: Integer;
        Text003: Label 'XML Files (*.xml)|*.xml|All Files (*.*)|*.*';
        gtVentana: Label 'Procesando Cupones\Cupon #1#####\@2@@@@@';
        ConfPersMgt: Codeunit 9170;
        TempFile: File;
        "lErrorAñoEscolar": Label 'Debe indicar el año escolar.';
}

