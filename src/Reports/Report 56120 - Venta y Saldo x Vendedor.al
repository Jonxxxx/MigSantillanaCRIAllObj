report 56120 "Venta y Saldo x Vendedor"
{
    ApplicationArea = Basic, Suite, Service;
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Salesperson/Purchaser"; 13)
        {
            DataItemTableView = SORTING(Code);
            RequestFilterFields = "Code";
            dataitem("Cust. Ledger Entry"; 21)
            {
                CalcFields = "Original Amt. (LCY)", "Remaining Amt. (LCY)";
                DataItemLink = "Salesperson Code" = FIELD(Code);
                DataItemTableView = SORTING("Salesperson Code", "Posting Date")
                                    WHERE("Document Type" = FILTER(Invoice | 'Credit Memo'));

                trigger OnAfterGetRecord()
                begin
                    rCust.GET("Customer No.");
                    CALCFIELDS("Original Amt. (LCY)", "Remaining Amt. (LCY)");
                    "TMP: Ventas x Vend. - Zona"."Cod. Vendedor" := "Salesperson Code";
                    "TMP: Ventas x Vend. - Zona"."Cod. Zona" := rCust."Service Zone Code";
                    "TMP: Ventas x Vend. - Zona"."Monto Original" := "Original Amt. (LCY)";
                    "TMP: Ventas x Vend. - Zona"."Monto Pendiente" := "Remaining Amt. (LCY)";
                    "TMP: Ventas x Vend. - Zona"."Entry No." := "Entry No.";
                    "TMP: Ventas x Vend. - Zona".INSERT;
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Posting Date", FechaIni, FechaFin);
                    SETRANGE("Date Filter", FechaIni, FechaFin);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Counter := Counter + 1;
                Window.UPDATE(1, Code);
                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                "TMP: Ventas x Vend. - Zona".DELETEALL;

                CounterTotal := COUNT;
                Window.OPEN(Text007);
            end;
        }
        dataitem("TMP: Ventas x Vend. - Zona"; 50005)
        {
            DataItemTableView = SORTING("Cod. Vendedor", "Cod. Zona", "Entry No.");

            trigger OnPostDataItem()
            begin
                //GRN To open Excel
                //fes mig TempExcelBuffer.CreateBookAndOpenExcel(Text006,'',COMPANYNAME,USERID);
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET();
                NoCol := SZ.COUNT;

                TempExcelBuffer.DELETEALL;
                CLEAR(TempExcelBuffer);

                //GRN Header Information from Company Info
                EnterCell(1, 1, UPPERCASE(COMPANYNAME), TRUE, FALSE, FALSE);
                EnterCell(2, 1, UPPERCASE(Text000), FALSE, FALSE, FALSE);
                txtFiltro := UPPERCASE(GETFILTERS) + ', ' + Text011 + ' ' + FORMAT(FechaIni) + '..' + FORMAT(FechaFin);

                EnterCell(3, 1, txtFiltro, FALSE, FALSE, FALSE);

                //Header Information for Detail
                EnterCell(5, 1, Text004, TRUE, FALSE, FALSE);
                //EnterCell(5,02,Text001,TRUE,FALSE,FALSE);

                NoCol := 4;
                SZ.FIND('-');
                REPEAT
                    EnterCell(5, NoCol, SZ.Description, TRUE, FALSE, FALSE);
                    EnterCell(6, NoCol, Text001, TRUE, FALSE, FALSE);
                    EnterCell(6, NoCol + 1, Text002, TRUE, FALSE, FALSE);
                    Columna[NoCol] := SZ.Code;
                    NoCol += 2;
                UNTIL SZ.NEXT = 0;

                LineNo := 6;
                CLEAR(FechaIni);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(FechaIni; FechaIni)
                {
                    Caption = 'Fecha inicial';
                }
                field(FechaFin; FechaFin)
                {
                    Caption = 'Fecha Final';
                }
                field(IdiomaOffice; IdiomaOffice)
                {
                    Caption = 'Idioma Office';
                }
            }
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
        "TMP: Ventas x Vend. - Zona".DELETEALL;
    end;

    var
        CompanyInfo: Record 79;
        rCust: Record 18;
        TempExcelBuffer: Record 370 temporary;
        SZ: Record 5957;
        Index: Integer;
        Index2: Integer;
        Text000: Label 'Report of Sales and Balance by Salesman';
        LineNo: Integer;
        Text001: Label 'Sale';
        Text002: Label 'Pending';
        Text004: Label 'Salesperson';
        Text005: Label 'TOTAL';
        Text006: Label 'SalesbySalesPerson';
        Text011: Label 'Dates Filter';
        DivisaLocal: Boolean;
        LinIni: Integer;
        LinFin: Integer;
        IdiomaOffice: Option English,"Español";
        Columna: array[50] of Code[20];
        Importe: array[50] of Decimal;
        Pendiente: array[50] of Decimal;
        i: Integer;
        FechaIni: Date;
        FechaFin: Date;
        txtFiltro: Code[800];
        NoCol: Integer;
        Filtro: Text[150];
        Window: Dialog;
        Counter: Integer;
        Text007: Label 'Processing  #1########## @2@@@@@@@@@@@@@';
        CounterTotal: Integer;
        VendAnt: Code[10];

    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[150]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean)
    begin
        TempExcelBuffer.INIT;
        TempExcelBuffer.VALIDATE("Row No.", RowNo);
        TempExcelBuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text" := CellValue;
        TempExcelBuffer.Formula := '';
        TempExcelBuffer.Bold := Bold;
        TempExcelBuffer.Italic := Italic;
        TempExcelBuffer.Underline := UnderLine;
        TempExcelBuffer.INSERT;
    end;

    local procedure EnterFormula(RowNo: Integer; ColumnNo: Integer; CellValue: Text[150]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean; Formula: Text[250])
    begin
        TempExcelBuffer.INIT;
        TempExcelBuffer.VALIDATE("Row No.", RowNo);
        TempExcelBuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text" := CellValue;
        TempExcelBuffer.Formula := Formula;
        TempExcelBuffer.Bold := Bold;
        TempExcelBuffer.Italic := Italic;
        TempExcelBuffer.Underline := UnderLine;
        TempExcelBuffer.INSERT;
    end;
}

