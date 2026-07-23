report 51006 "Importa Pedidos vta. Cons."
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Import Orders vta. Cons.';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Excel Buffer"; 370)
        {
            DataItemTableView = SORTING(Row No., Column No.)
                                ORDER(Ascending);

            trigger OnAfterGetRecord()
            begin
                /*
                rSalesLine.RESET;
                rSalesLine.SETRANGE("Document No.",NoPedido);
                IF rSalesLine.FINDLAST THEN
                  NoLinea := rSalesLine."Line No."
                ELSE
                */
                NoLinea += 10000;

                //Creamos la linea temporal
                rSalesLineTMP.INIT;
                rSalesLineTMP."Document Type" := 1;
                rSalesLineTMP."Document No." := NoPedido;
                rSalesLineTMP."Line No." := NoLinea;
                rSalesLineTMP.Type := 2;
                rSalesLineTMP."No." := "Cell Value as Text";
                rSalesLineTMP.INSERT;
                NEXT(3);

            end;

            trigger OnPreDataItem()
            begin
                DELETEALL;
                OpenBook(FileName, Sheetname);
                ReadSheet();
                SETRANGE(xlColID, 'A', 'F');
            end;
        }
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

    trigger OnPostReport()
    begin
        //Eliminamos las lineas de productos que no esten en el documento excel
        rSalesLine.RESET;
        rSalesLine.SETRANGE("Document Type", 1);
        rSalesLine.SETRANGE("Document No.", NoPedido);
        IF rSalesLine.FINDSET THEN
            REPEAT
                rSalesLineTMP.RESET;
                rSalesLineTMP.SETRANGE(rSalesLineTMP."No.", rSalesLine."No.");
                IF NOT rSalesLineTMP.FINDFIRST THEN BEGIN
                    rSalesLine1.GET(rSalesLine."Document Type", rSalesLine."Document No.", rSalesLine."Line No.");
                    rSalesLine1.DELETE;
                END;
            UNTIL rSalesLine.NEXT = 0;
    end;

    trigger OnPreReport()
    begin
        NoPedido := CFuncSantillana.EnviaNoTransferencia;
    end;

    var
        rExcelBuffer: Record 370;
        FileName: Text[1024];
        Sheetname: Text[1024];
        NoProd: Code[20];
        wCantidad: Text[30];
        NoLinea: Integer;
        NoPedido: Code[20];
        CodAlmacenCliente: Code[20];
        CodAlmacenOrigen: Code[20];
        I: Integer;
        Text000: Label 'Analyzing Data...\\';
        Text001: Label 'Filters';
        Text002: Label 'Update Workbook';
        CodAlmacenTransito: Code[20];
        CFuncSantillana: Codeunit 56000;
        rSalesHeader: Record 36;
        rSalesLine: Record 37;
        rSalesLineTMP: Record 51003 temporary;
        txtPrecio: Text[30];
        txtDescuento: Text[30];
        wPrecio: Decimal;
        wDescuento: Decimal;
        rSalesHeader1: Record 36;
        Pedido: Boolean;
        Factura: Boolean;
        rSalesInvHeader: Record 112;
        txt003: Label 'At least one Order/Invoice have this External document No. %1 Confirm that you want to import the order';
        rSalesLine1: Record 37;

    procedure RecibeNoPedido(NoDocumento: Code[20])
    begin
        NoPedido := NoDocumento;
    end;
}

