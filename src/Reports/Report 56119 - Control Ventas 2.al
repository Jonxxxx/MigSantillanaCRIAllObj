report 56119 "Control Ventas 2"
{
    ApplicationArea = Basic, Suite, Service;
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; 18)
        {
            DataItemTableView = SORTING("Customer Posting Group");
            RequestFilterFields = "Customer Posting Group", "No.";
            dataitem("Value Entry"; 5802)
            {
                DataItemLink = Source No.=FIELD(No.);
                DataItemTableView = SORTING("Source Type", Source No., Cod. Oferta, Posting Date)
                                    WHERE("Source Type" = FILTER(Customer));
                RequestFilterFields = "Source No.", "Cod. Oferta", "Item No.", "Location Code", "Document No.", "Posting Date", "Salespers./Purch. Code";

                trigger OnAfterGetRecord()
                begin
                    //Filtro para Año Actual
                    Cant += "Invoiced Quantity" * -1;
                    VentasBrutas += "Sales Amount (Actual)";
                    Dto += "Discount Amount" * -1;
                    Valor += "Sales Amount (Actual)";
                    Costo += "Cost Amount (Actual)" * -1;

                    IF Detallado THEN BEGIN
                        LineNo += 1;
                        IF NOT rItem.GET("Item No.") THEN
                            rItem.INIT;
                        EnterCell(LineNo, 1, "Item No.", FALSE, FALSE, FALSE);
                        EnterCell(LineNo, 2, rItem.Description, FALSE, FALSE, FALSE);
                        EnterCell(LineNo, 5, FORMAT("Invoiced Quantity"), FALSE, FALSE, FALSE);
                        EnterCell(LineNo, 6, FORMAT("Sales Amount (Actual)" + "Discount Amount"), FALSE, FALSE, FALSE);
                        EnterCell(LineNo, 7, FORMAT("Sales Amount (Actual)"), FALSE, FALSE, FALSE);
                        EnterCell(LineNo, 8, FORMAT("Cost Amount (Actual)"), FALSE, FALSE, FALSE);
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    FechaIni := GETRANGEMIN("Posting Date");
                    FechaFin := GETRANGEMAX("Posting Date");
                    IF PrimeraVezD THEN BEGIN
                        PrimeraVezD := FALSE;
                        EnterCell(3, 1, UPPERCASE(Customer.GETFILTERS) + ', ' + UPPERCASE(GETFILTERS), FALSE, FALSE, FALSE);
                    END;

                    CurrReport.CREATETOTALS(Cant, VentasBrutas, Valor, Costo, Dto, CantAnt, VentasBrutasAnt, ValorAnt, CostoAnt, DtoAnt);
                    CurrReport.CREATETOTALS(CantConsig, VentasBrutasConsig, ValorConsig, CostoConsig);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF NOT PrimeraVez THEN BEGIN
                    Counter := Counter + 1;
                    Window.UPDATE(1, "No.");
                    Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));
                END;
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE;

                //GRN To open Excel
                //fes mig TempExcelBuffer.CreateBookAndOpenExcel(Text010,'',COMPANYNAME,USERID);
            end;

            trigger OnPreDataItem()
            begin
                PrimeraVez := TRUE;
                PrimeraVezD := TRUE;
                CompanyInfo.GET();
                TempExcelBuffer.DELETEALL;
                CLEAR(TempExcelBuffer);
                CounterTotal := COUNT;

                IF PrimeraVez THEN BEGIN
                    PrimeraVez := FALSE;

                    //GRN Header Information from Company Info
                    EnterCell(1, 1, UPPERCASE(COMPANYNAME), TRUE, FALSE, FALSE);
                    EnterCell(2, 1, UPPERCASE(Text000), FALSE, FALSE, FALSE);
                    //GRN    EnterCell(3,1,UPPERCASE(GETFILTERS),FALSE,FALSE,FALSE);

                    //Header Information for Detail
                    EnterCell(5, 1, Text001, TRUE, FALSE, FALSE);
                    EnterCell(5, 13, Text002, TRUE, FALSE, FALSE);
                    EnterCell(5, 18, Text003, TRUE, FALSE, FALSE);

                    EnterCell(6, 1, Text004, TRUE, FALSE, FALSE);

                    EnterCell(6, 5, Text005, TRUE, FALSE, FALSE);
                    EnterCell(6, 6, Text006, TRUE, FALSE, FALSE);
                    EnterCell(6, 7, Text007, TRUE, FALSE, FALSE);
                    EnterCell(6, 8, Text008, TRUE, FALSE, FALSE);

                    EnterCell(6, 10, Text005, TRUE, FALSE, FALSE);
                    EnterCell(6, 11, Text006, TRUE, FALSE, FALSE);
                    EnterCell(6, 12, Text007, TRUE, FALSE, FALSE);
                    EnterCell(6, 13, Text008, TRUE, FALSE, FALSE);

                    EnterCell(6, 15, Text005, TRUE, FALSE, FALSE);
                    EnterCell(6, 16, Text006, TRUE, FALSE, FALSE);
                    EnterCell(6, 17, Text007, TRUE, FALSE, FALSE);
                    EnterCell(6, 18, Text008, TRUE, FALSE, FALSE);

                    LineNo := 6;
                    CLEAR(FechaIni);


                    Window.OPEN(Text009);
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Detallado; Detallado)
                {
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

    var
        CompanyInfo: Record 79;
        rCust: Record 18;
        rVE: Record 5802;
        rSalesLine: Record 37;
        TempExcelBuffer: Record 370 temporary;
        rItem: Record 27;
        FechaIni: Date;
        FechaFin: Date;
        Text009: Label 'Processing Customer  #1########## @2@@@@@@@@@@@@@';
        Text010: Label 'Sales Control';
        Text000: Label 'Sales Control';
        Text001: Label 'Current Year Sales';
        Text002: Label 'Last Year Sales';
        Text003: Label 'Consignation''s Sales';
        Text004: Label 'Name';
        Text005: Label 'Quantity';
        Text006: Label 'GROSS Sales';
        Text007: Label 'Value';
        Text008: Label 'COST';
        CalcFecha: Label 'Y';
        GpoContAnt: Code[20];
        Cant: Decimal;
        VentasBrutas: Decimal;
        Valor: Decimal;
        Costo: Decimal;
        CantAnt: Decimal;
        VentasBrutasAnt: Decimal;
        ValorAnt: Decimal;
        CostoAnt: Decimal;
        CantConsig: Decimal;
        VentasBrutasConsig: Decimal;
        ValorConsig: Decimal;
        CostoConsig: Decimal;
        LineNo: Integer;
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
        CounterOK: Integer;
        Dto: Decimal;
        DtoAnt: Decimal;
        DtoConsig: Decimal;
        Detallado: Boolean;
        PrimeraVez: Boolean;
        PrimeraVezD: Boolean;

    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean)
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
}

