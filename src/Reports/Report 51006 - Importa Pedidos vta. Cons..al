report 51006 "Importa Pedidos vta. Cons."
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Import Orders vta. Cons.';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Excel Buffer"; "Excel Buffer")
        {
            DataItemTableView = sorting("Row No.", "Column No.")
                                order(Ascending);
            UseTemporary = true;

            trigger OnAfterGetRecord()
            begin
                NoLinea += 10000;

                // Create the temporary sales line.
                rSalesLineTMP.Init();
                rSalesLineTMP."Document Type" :=
                    rSalesLineTMP."Document Type"::Order;
                rSalesLineTMP."Document No." := NoPedido;
                rSalesLineTMP."Line No." := NoLinea;
                rSalesLineTMP.Type := rSalesLineTMP.Type::Item;
                rSalesLineTMP."No." := "Cell Value as Text";
                rSalesLineTMP.Insert();

                Next(3);
            end;

            trigger OnPreDataItem()
            var
                ExcelInStream: InStream;
                OpenBookError: Text;
            begin
                DeleteAll();

                TempBlob.CreateInStream(ExcelInStream);

                OpenBookError :=
                    OpenBookStream(ExcelInStream, SheetName);

                if OpenBookError <> '' then
                    Error(ExcelImportErr, OpenBookError);

                ReadSheet();

                SetRange(xlColID, 'A', 'F');
            end;
        }
    }

    trigger OnPostReport()
    begin
        // Delete product lines that are not present in the Excel document.
        rSalesLine.Reset();
        rSalesLine.SetRange(
            "Document Type",
            rSalesLine."Document Type"::Order);
        rSalesLine.SetRange("Document No.", NoPedido);

        if rSalesLine.FindSet() then
            repeat
                rSalesLineTMP.Reset();
                rSalesLineTMP.SetRange("No.", rSalesLine."No.");

                if not rSalesLineTMP.FindFirst() then begin
                    rSalesLine1.Get(
                        rSalesLine."Document Type",
                        rSalesLine."Document No.",
                        rSalesLine."Line No.");
                    rSalesLine1.Delete();
                end;
            until rSalesLine.Next() = 0;
    end;

    trigger OnPreReport()
    begin
        NoPedido := CFuncSantillana.EnviaNoTransferencia();
        UploadExcelFile();
    end;

    var
        rExcelBuffer: Record "Excel Buffer" temporary;
        rSalesLine: Record "Sales Line";
        rSalesLine1: Record "Sales Line";
        rSalesLineTMP: Record 51003 temporary;
        TempBlob: Codeunit "Temp Blob";
        CFuncSantillana: Codeunit 56000;
        SheetName: Text[250];
        NoLinea: Integer;
        NoPedido: Code[20];
        ExcelFileFilterLbl: Label 'Excel files (*.xlsx)|*.xlsx';
        FileNotSelectedErr: Label 'You must select an Excel file.';
        SheetNotSelectedErr: Label 'You must select an Excel worksheet.';
        ExcelImportErr: Label 'The Excel file could not be opened. %1';

    local procedure UploadExcelFile()
    var
        UploadInStream: InStream;
        SheetInStream: InStream;
        ExcelOutStream: OutStream;
    begin
        if not UploadIntoStream(ExcelFileFilterLbl, UploadInStream) then
            Error(FileNotSelectedErr);

        TempBlob.CreateOutStream(ExcelOutStream);
        CopyStream(ExcelOutStream, UploadInStream);

        TempBlob.CreateInStream(SheetInStream);
        SheetName :=
            rExcelBuffer.SelectSheetsNameStream(SheetInStream);

        if SheetName = '' then
            Error(SheetNotSelectedErr);
    end;

    procedure RecibeNoPedido(NoDocumento: Code[20])
    begin
        NoPedido := NoDocumento;
    end;
}