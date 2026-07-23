report 56136 "Control Ventas"
{
    // 001 #139 RRT 27.12.2013 -> Para no crear una nueva clave sustituyo el orden original de la tabla "Value entry"
    //              SORTING("Item Category Code","Item No.","Valuation Date","Location Code","Variant Code","Drop Shipment") por
    //              SORTING("Item No.","Valuation Date","Location Code","Variant Code","Drop Shipment")

    ApplicationArea = Basic, Suite, Service;
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Item; 27)
        {
            DataItemTableView = SORTING("Item Category Code");
            RequestFilterFields = "No.", "Item Category Code";
            dataitem("Value Entry"; 5802)
            {
                DataItemLink = "Item No." = FIELD("No.");
                DataItemTableView = SORTING("Item No.", "Valuation Date", "Location Code", "Variant Code", "Drop Shipment")
                                    ORDER(Ascending);
                RequestFilterFields = "Cod. Oferta", "Item No.", "Location Code", "Document No.", "Posting Date", "Salespers./Purch. Code";

                trigger OnAfterGetRecord()
                begin
                    //Filtro para Año Actual
                    Cant += "Invoiced Quantity" * -1;
                    VentasBrutas += "Sales Amount (Actual)";
                    Dto += "Discount Amount" * -1;
                    Valor += "Sales Amount (Actual)";
                    Costo += "Cost Amount (Actual)" * -1;

                    /*CantConsig         := 0;
                    VentasBrutasConsig := 0;
                    ValorConsig        := 0;
                    CostoConsig        := 0;
                    */

                end;

                trigger OnPostDataItem()
                begin

                    //Filtro para Año Anterior
                    rVE.RESET;
                    rVE.SETCURRENTKEY("Gen. Bus. Posting Group", "Item No.", "Location Code", "Document No.", "Posting Date", "Salespers./Purch. Code",
                                      "Source No.");
                    rVE.COPYFILTERS("Value Entry");
                    rVE.SETRANGE("Posting Date", CALCDATE('-1' + CalcFecha, FechaIni), CALCDATE('-1' + CalcFecha, FechaFin));
                    IF rVE.FIND('-') THEN
                        REPEAT
                            CantAnt += rVE."Invoiced Quantity" * -1;
                            VentasBrutasAnt += rVE."Sales Amount (Actual)";
                            DtoAnt += rVE."Discount Amount" * -1;
                            ValorAnt += rVE."Sales Amount (Actual)";
                            CostoAnt += rVE."Cost Amount (Actual)" * -1;
                        UNTIL rVE.NEXT = 0;

                    //Busco las lineas a consignacion
                    rSalesLine.SETCURRENTKEY("Document Type", Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Shipment Date");
                    rSalesLine.SETRANGE("Document Type", rSalesLine."Document Type"::Order);
                    rSalesLine.SETRANGE(Type, rSalesLine.Type::Item);
                    rSalesLine.SETRANGE("No.", Item."No.");
                    rSalesLine.SETRANGE("Shipment Date", 0D, FechaFin);
                    //rSalesLine.SETRANGE("Tipo pedido",1); //Consignacion
                    rSalesLine.SETFILTER("Outstanding Quantity", '<>%1', 0);
                    rSalesLine.SETFILTER("Location Code", GETFILTER("Location Code"));
                    IF rSalesLine.FIND('-') THEN
                        REPEAT
                            CantConsig += rSalesLine."Outstanding Quantity";
                            VentasBrutasConsig += rSalesLine."Outstanding Amount" + rSalesLine."Line Discount Amount";
                            ValorConsig += rSalesLine."Outstanding Amount";
                            CostoConsig += rSalesLine."Unit Cost" * rSalesLine."Outstanding Quantity";
                        UNTIL rSalesLine.NEXT = 0;
                end;

                trigger OnPreDataItem()
                begin
                    FechaIni := GETRANGEMIN("Posting Date");
                    FechaFin := GETRANGEMAX("Posting Date");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Counter := Counter + 1;
                Window.UPDATE(1, "No.");
                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE;

                //GRN To open Excel
                //fe mig TempExcelBuffer.CreateBookAndOpenExcel(Text010,'',COMPANYNAME,USERID);
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET();
                TempExcelBuffer.DELETEALL;
                CLEAR(TempExcelBuffer);

                //GRN Header Information from Company Info
                EnterCell(1, 1, UPPERCASE(COMPANYNAME), TRUE, FALSE, FALSE);
                EnterCell(2, 1, UPPERCASE(Text000), FALSE, FALSE, FALSE);
                EnterCell(3, 1, UPPERCASE(GETFILTERS), FALSE, FALSE, FALSE);

                //Header Information for Detail
                EnterCell(5, 1, Text001, TRUE, FALSE, FALSE);
                EnterCell(5, 8, Text002, TRUE, FALSE, FALSE);
                EnterCell(5, 13, Text003, TRUE, FALSE, FALSE);
                EnterCell(6, 1, Text004, TRUE, FALSE, FALSE);
                EnterCell(6, 2, Text005, TRUE, FALSE, FALSE);
                EnterCell(6, 3, Text006, TRUE, FALSE, FALSE);
                EnterCell(6, 4, Text007, TRUE, FALSE, FALSE);
                EnterCell(6, 5, Text008, TRUE, FALSE, FALSE);
                EnterCell(6, 7, Text005, TRUE, FALSE, FALSE);
                EnterCell(6, 8, Text006, TRUE, FALSE, FALSE);
                EnterCell(6, 9, Text007, TRUE, FALSE, FALSE);
                EnterCell(6, 10, Text008, TRUE, FALSE, FALSE);
                EnterCell(6, 12, Text005, TRUE, FALSE, FALSE);
                EnterCell(6, 13, Text006, TRUE, FALSE, FALSE);
                EnterCell(6, 14, Text007, TRUE, FALSE, FALSE);
                EnterCell(6, 15, Text008, TRUE, FALSE, FALSE);

                LineNo := 6;
                CLEAR(FechaIni);

                CounterTotal := COUNT;
                Window.OPEN(Text009);
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

    var
        CompanyInfo: Record 79;
        rVE: Record 5802;
        rSalesLine: Record 37;
        TempExcelBuffer: Record 370 temporary;
        FechaIni: Date;
        FechaFin: Date;
        Text009: Label 'Processing Item  #1########## @2@@@@@@@@@@@@@';
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

