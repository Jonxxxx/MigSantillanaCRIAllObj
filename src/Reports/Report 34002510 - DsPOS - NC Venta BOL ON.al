report 55904 "DsPOS - NC Venta BOL ON"
{
    // 001 #2306 RRT 11.03.2014, Hab´Š¢a una limitacion de mostrar 10 Lineas.
    //     He quitado esta limitacion con lo que en alg´Š¢n caso el informe no cabr´Š¢ en una s´Š¢la Pagina.
    //     Ahora, el nomero de Lineas podr´Š¢ ser de 50, que es el tamAno del ARRAY.
    // 
    // Proyecto: Microsoft Dynamics Nav
    // ------------------------------------------------------------------------------
    // FES   : Fausto Serrata
    // ------------------------------------------------------------------------------
    // No.             Firma         Fecha           Descripcion
    // ------------------------------------------------------------------------------
    // CPMCR-CEC       FES           08-06-2021      Comentario por migracion Costa Rica. Corregir error compilacion.
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/DsPOS - NC Venta BOL ON.rdl';

    Permissions = TableData 21 = rm,
                  TableData 114 = rm,
                  TableData 7190 = rm,
                  TableData 34003012 = rim;

    dataset
    {
        dataitem("Sales Cr.Memo Header"; 114)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.", "Sell-to Customer No.";
            column(Sales_Invoice_Header__Bill_to_Address_; Loc.Address + ' ' + Loc."Address 2" + ' ' + Loc.City + ' ' + Loc.County)
            {
            }
            column(NoFactFiscal; NoFacFiscal)
            {
            }
            column(C__Piloto____Tel___Fax____Fax; 'C. Piloto ' + Tel + ' Fax: ' + Fax)
            {
            }
            column(Sales_Invoice_Header__Bill_to_city_; Loc.City + ' -  ' + Loc."Country/Region Code")
            {
            }
            column(SFC__; 'SFC:')
            {
            }
            column(CiudadEmision; Loc.City + ', ' + TextDia + ' de ' + TextMes + ' de ' + TextAno)
            {
            }
            column(Sales_Invoice_Header__Bill_to_Name_; "Bill-to Name")
            {
            }
            column(Ruc_Cliente; "VAT Registration No.")
            {
            }
            column(Sales_Invoice_Header__Due_Date_; "Posting Date")
            {
            }
            column(NoFiscalFactura; NoFiscalFactura)
            {
            }
            column(NoAutFac; NoAutFac)
            {
            }
            column(Sales_Cr_Memo_Header__No__; "No.")
            {
            }
            column(ImpDesc; ImpDesc)
            {
                DecimalPlaces = 2 : 2;
            }
            column(ImporteTotal; ImporteTotal)
            {
                DecimalPlaces = 2 : 2;
            }
            column(DescriptionLine_1_____________CurrName; DescriptionLine[1] + ' ' + NombreDiv)
            {
            }
            column(Serie_Factura_________No__Comprobante_Fiscal_; "Sales Cr.Memo Header"."No. Comprobante Fiscal")
            {
            }
            column(DescuentoCaption_Control1000000138; DescuentoCaption_Control1000000138Lbl)
            {
            }
            dataitem(LineaBloque1; 2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    ORDER(Ascending);
                column(Cantidad_Fact_Arr_I_; Cantidad_Fact_Arr[I])
                {
                }
                column(CodUndMed_Fact_Arr_1_; CodUndMed_Fact_Arr[I])
                {
                }
                column(Desc_Fact_Arr_1_; Desc_Fact_Arr[I])
                {
                }
                column(PrecUnit_Fact_Arr_1_; PrecUnit_Fact_Arr[I])
                {
                }
                column(Imp_Fact_Arr_1_; Imp_Fact_Arr[I])
                {
                    DecimalPlaces = 2 : 2;
                }
                column(ImpDescFact; ImpDescFact)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(ImporteTotalFact; ImporteTotalFact)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(DescuentoCaption; DescuentoCaptionLbl)
                {
                }
                column(LineaBloque1_Number; Number)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    I := I + 1;
                end;

                trigger OnPreDataItem()
                begin
                    //+001
                    //... a´Š¢adido este DataItem, para rehacer el informe.

                    wMax := I;
                    SETRANGE(Number, 1, wMax);

                    I := 0;
                end;
            }
            dataitem(LineaBloque2; 2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    ORDER(Ascending);
                column(Cantidad_Arr_1_; Cantidad_Arr[I])
                {
                }
                column(CodProd_Arr_1_; CodUndMed_Arr[I])
                {
                }
                column(Desc_Arr_1_; Desc_Arr[I])
                {
                }
                column(PrecUnit_Arr_1_; PrecUnit_Arr[I])
                {
                }
                column(Imp_Arr_1_; Imp_Arr[I])
                {
                    DecimalPlaces = 2 : 2;
                }
                column(LineaBloque2_Number; Number)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    I := I + 1;
                end;

                trigger OnPreDataItem()
                begin
                    //+001
                    //... He a´Š¢adido este DataItem.
                    SETRANGE(Number, 1, wMax);

                    I := 0;
                end;
            }
            dataitem("Sales Cr.Memo Line"; 115)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");

                trigger OnPreDataItem()
                begin
                    CurrReport.CREATETOTALS(Amount, "Unit Price", "Line Discount Amount", "Amount Including VAT", Quantity);
                end;
            }
            dataitem(SCML2; 115)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    WHERE(Type = FILTER(<> Item));

                trigger OnAfterGetRecord()
                begin
                    //otros += Amount;
                end;

                trigger OnPreDataItem()
                begin
                    //otros := 0;
                end;
            }
            dataitem(CopyLoop; 2000000026)
            {
                DataItemTableView = SORTING(Number);

                trigger OnAfterGetRecord()
                begin
                    CurrReport.PAGENO := 1;
                    IF Number > 1 THEN BEGIN
                        CopyText := Text004;
                        IF ISSERVICETIER THEN
                            OutputNo += 1;
                    END;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        SalesCrMemoCountPrinted.RUN("Sales Cr.Memo Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    IF ISSERVICETIER THEN
                        OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            var
                DimSetEntry: Record 480;
            begin
                GLSetUp.GET;


                Comentario := '';
                iBruto := 0;
                ImporteCargos := 0;
                ImporteSinCargos := 0;
                DescuentoCargos := 0;
                CantUnidades := 0;
                ImporteTotal := 0;
                ImporteTotalFact := 0;
                ImpDesc := 0;
                ImpDescFact := 0;


                //+001
                CLEAR(CodProd_Arr);
                CLEAR(Cantidad_Arr);
                CLEAR(Desc_Arr);
                CLEAR(PrecUnit_Arr);
                CLEAR(CodUndMed_Arr);
                CLEAR(Imp_Arr);
                CLEAR(ImpDesc);
                CLEAR(ImporteTotal);
                CLEAR(CodProd_Fact_Arr);
                CLEAR(Cantidad_Fact_Arr);
                CLEAR(Desc_Fact_Arr);
                CLEAR(PrecUnit_Fact_Arr);
                CLEAR(CodUndMed_Fact_Arr);
                CLEAR(Imp_Fact_Arr);
                CLEAR(ImpDescFact);
                CLEAR(ImporteTotalFact);
                ;

                //-001

                rCliente.GET("Sell-to Customer No.");
                Tel := rCliente."Phone No.";
                Fax := rCliente."E-Mail 2";

                //NoFacFiscal := FuncBolv.NoFacFiscal("No. Factura Fiscal");     //CPMCR-CEC+-

                TextDia := FORMAT("Posting Date", 0, ('<day,2>'));
                TextMes := UPPERCASE(FORMAT("Posting Date", 0, ('<month Text>')));
                TextAno := FORMAT("Posting Date", 0, ('<year4>'));

                NombreDiv := GLSetUp."Nombre Divisa Local";

                IF Loc.GET("Location Code") THEN;

                IF "Currency Code" <> '' THEN BEGIN
                    Currency.GET("Currency Code");
                    CurrName := Currency.Description;
                    CodDivLocal := "Currency Code";
                END
                ELSE BEGIN
                    CurrName := GLSetUp."Nombre Divisa Local";
                    CodDivLocal := GLSetUp."LCY Code";
                END;

                IF Vendedor_Comprador.GET("Salesperson Code") THEN
                    VendorName := Vendedor_Comprador.Name;

                IF PT.GET("Payment Terms Code") THEN
                    CondicionPago := PT.Description;

                SCL.SETRANGE("Document Type", SCL."Document Type"::"Posted Credit Memo");
                SCL.SETRANGE("No.", "No.");

                IF SCL.FINDFIRST THEN
                    Comentario := SCL.Comment;


                CALCFIELDS(Amount, "Amount Including VAT");

                IF "Amount Including VAT" - Amount <> 0 THEN
                    txtIva := txt004
                ELSE
                    txtIva := '';

                ChkTransMgt.FormatNoText(DescriptionLine, "Amount Including VAT", 2058, "Currency Code");

                TotFactura := "Amount Including VAT";


                //Datos para Historico de RTC
                SCML.RESET;
                SCML.SETRANGE("Document No.", "No.");
                SCML.SETFILTER(Type, '<>%1', SCML.Type::"Charge (Item)");
                IF SCML.FINDSET THEN
                    REPEAT
                        ImporteSinCargos += SCML.Amount + SCML."Line Discount Amount";
                        Descuento += SCML."Line Discount Amount";
                        CantUnidades += SCML.Quantity;
                        igv += SCML."Amount Including VAT" - SCML.Amount;
                    UNTIL SCML.NEXT = 0;

                //Busco la factura liquidada
                CLE.RESET;
                CLE.SETCURRENTKEY("Document No.", "Document Type", "Customer No.");
                CLE.SETRANGE("Document No.", "No.");
                CLE.SETRANGE("Document Type", CLE."Document Type"::"Credit Memo");
                CLE.SETRANGE("Customer No.", "Bill-to Customer No.");
                CLE.FINDFIRST;
                //Nota de Credito Cerrada por Numero de movimiento
                IF CLE."Closed by Entry No." <> 0 THEN BEGIN
                    CLE2.GET(CLE."Closed by Entry No.");
                    IF CLE2."Document Type" = CLE2."Document Type"::Invoice THEN
                        NoFacLiq := CLE2."Document No.";
                END
                ELSE
                  //Factura Cerrada por numero de Movimiento
                  BEGIN
                    CLE2.RESET;
                    CLE2.SETCURRENTKEY("Closed by Entry No.");
                    CLE2.SETRANGE("Closed by Entry No.", CLE."Entry No.");
                    CLE2.SETRANGE("Document Type", CLE2."Document Type"::Invoice);
                    IF CLE2.FINDFIRST THEN
                        NoFacLiq := CLE2."Document No.";
                END;

                //Factura Liquidada
                /*
                IF SIH.GET(NoFacLiq) THEN
                  BEGIN
                    NoFiscalFactura := FuncBolv.NoFacFiscal(SIH."No. Factura Fiscal");
                    NoAutFac        := SIH."No. Autorizacion Comprobante";
                    I := 0;
                    SIL.RESET;
                    SIL.SETRANGE("Document No.",NoFacLiq);
                    SIL.SETRANGE(Type,SIL.Type::Item);
                    IF SIL.FINDSET THEN
                      REPEAT
                        I += 1;
                        CodProd_Fact_Arr[I]   := SIL."No.";
                        Cantidad_Fact_Arr[I]  := SIL.Quantity;
                        Desc_Fact_Arr[I]      := SIL.Description;
                        PrecUnit_Fact_Arr[I]  := SIL."Unit Price";
                        CodUndMed_Fact_Arr[I] := SIL."Unit of Measure Code";
                        Imp_Fact_Arr[I]       := SIL."Amount Including VAT";
                        ImpDescFact           += SIL."Line Discount Amount";
                        ImporteTotalFact      += SIL."Amount Including VAT";
                      UNTIL SIL.NEXT = 0;
                  END;
                */

                //Nota de Credito
                I := 0;
                SCML.RESET;
                SCML.SETRANGE("Document No.", "No.");
                SCML.SETRANGE(Type, SCML.Type::Item);
                IF SCML.FINDSET THEN
                    REPEAT
                        I += 1;
                        CodProd_Arr[I] := SCML."No.";
                        Cantidad_Arr[I] := SCML.Quantity;
                        Desc_Arr[I] := SCML.Description;
                        PrecUnit_Arr[I] := SCML."Unit Price";
                        CodUndMed_Arr[I] := SCML."Unit of Measure Code";
                        Imp_Arr[I] := SCML."Amount Including VAT";

                        //+001
                        //... Los siguientes valores salen incorrectos al procesar varias notas de credito.
                        ImpDesc += SIL."Line Discount Amount";
                        ImporteTotal += SIL."Amount Including VAT";

                        SIL.RESET;
                        SIL.SETRANGE("Document No.", NoFacLiq);
                        SIL.SETRANGE(Type, SIL.Type::Item);
                        SIL.SETRANGE("No.", SCML."No.");
                        IF SIL.FINDFIRST THEN BEGIN
                            CodProd_Fact_Arr[I] := SIL."No.";
                            Cantidad_Fact_Arr[I] := SIL.Quantity;
                            Desc_Fact_Arr[I] := SIL.Description;
                            PrecUnit_Fact_Arr[I] := SIL."Unit Price";
                            CodUndMed_Fact_Arr[I] := SIL."Unit of Measure Code";
                            Imp_Fact_Arr[I] := SIL."Amount Including VAT";
                            ImpDescFact += SIL."Line Discount Amount";
                            ImporteTotalFact += SIL."Amount Including VAT";
                        END;


                    UNTIL SCML.NEXT = 0;


                //Datos Dimensiones

                //Tipo Clinte
                DimSetEntry.RESET;
                IF "Sales Cr.Memo Header"."Dimension Set ID" <> 0 THEN BEGIN
                    DimSetEntry.SETRANGE("Dimension Set ID", "Sales Cr.Memo Header"."Dimension Set ID");
                    DimSetEntry.SETRANGE("Dimension Code", 'TIPO_CLIENTE');
                    IF DimSetEntry.FINDFIRST THEN BEGIN
                        DimVal.RESET;
                        DimVal.SETRANGE("Dimension Code", DimSetEntry."Dimension Code");
                        DimVal.SETRANGE(Code, DimSetEntry."Dimension Value Code");
                        IF DimVal.FINDFIRST THEN
                            TipoCliente := DimVal.Name;
                    END;
                END;


                //Tipo Venta
                DimSetEntry.RESET;
                IF "Sales Cr.Memo Header"."Dimension Set ID" <> 0 THEN BEGIN
                    DimSetEntry.SETRANGE("Dimension Set ID", "Sales Cr.Memo Header"."Dimension Set ID");
                    DimSetEntry.SETRANGE("Dimension Code", 'TIPO_VENTA');
                    IF DimSetEntry.FINDFIRST THEN BEGIN
                        DimVal.RESET;
                        DimVal.SETRANGE("Dimension Code", DimSetEntry."Dimension Code");
                        DimVal.SETRANGE(Code, DimSetEntry."Dimension Value Code");
                        IF DimVal.FINDFIRST THEN
                            TipoVenta := DimVal.Name;
                    END;
                END;


                IF Cust.GET("Sell-to Customer No.") THEN
                    Nombre := UPPERCASE(Cust.Name);

                IF PostCodes.GET(Cust."Post Code", Cust.City) THEN BEGIN
                    Provincia := PostCodes.County;
                    Departamento := PostCodes.Colonia;
                END;
                PuntoLlegada := "Bill-to Address" + ', ' + "Bill-to City" + ', ' + Provincia + ', ' + Departamento;

            end;

            trigger OnPreDataItem()
            var
                lrCredit: Record 114;
            begin
                //+001
                //... A´Š¢adimos un control.
                lrCredit.COPYFILTERS("Sales Cr.Memo Header");
                IF lrCredit.COUNT > 1 THEN
                    ERROR(Text100);
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

    trigger OnPreReport()
    begin
        GLSetUp.GET;
        GLSetUp.TESTFIELD("LCY Code");
        GLSetUp.TESTFIELD("Nombre Divisa Local");

        rEmpresa.GET();
        rEmpresa.CALCFIELDS(Picture);
        rPais.SETRANGE(Code, rEmpresa."Country/Region Code");
        rPais.FINDFIRST;
        vPais := rEmpresa.City + ', ' + rPais.Name + ' ' + rEmpresa."Post Code";
    end;

    var
        SCL: Record 44;
        ArchiveSH: Record 5107;
        ArchiveSL: Record 5108;
        SalesShptLine: Record 111;
        VatEntry: Record 254;
        Currency: Record 4;
        rEmpresa: Record 79;
        rCliente: Record 18;
        Text001: Label 'Page %1';
        wDiv: Code[10];
        VendorName: Text[50];
        Vendedor_Comprador: Record 13;
        vPais: Text[50];
        rPais: Record 9;
        Comentario: Text[1024];
        ChkTransMgt: Report 10400;
        DescriptionLine: array[2] of Text[250];
        CurrName: Text[30];
        Text002: Label 'Total %1';
        txtIva: Text[30];
        txt004: Label '(*) IVA';
        NoLineas: Integer;
        PT: Record 3;
        CondicionPago: Text[100];
        iBruto: Decimal;
        totDesc: Decimal;
        igv: Decimal;
        otros: Decimal;
        TotFactura: Decimal;
        GLSetUp: Record 98;
        CodDivLocal: Code[20];
        NCFAnulados: Record 34003012;
        NoSeriesMgt: Codeunit "No. Series";
        CLE: Record 21;
        SSH: Record 110;
        NoGuia: Code[50];
        Prueba: Decimal;
        Descuento: Decimal;
        SCML: Record 115;
        TipoCliente: Text[100];
        TipoVenta: Text[100];
        Loc: Record 14;
        DimVal: Record 349;
        txt005: Label 'SON';
        Cust: Record 18;
        Nombre: Text[250];
        PostCodes: Record 225;
        Provincia: Text[150];
        Departamento: Text[150];
        PuntoLlegada: Text[500];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        Text004: Label 'COPY';
        OutputNo: Integer;
        SalesCrMemoCountPrinted: Codeunit "Sales Cr. Memo-Printed";
        ConfSant: Record 55226;
        ImporteSinCargos: Decimal;
        ImporteCargos: Decimal;
        DescuentoCargos: Decimal;
        CantUnidades: Decimal;
        CodProd_Arr: array[50] of Code[20];
        Cantidad_Arr: array[50] of Integer;
        Desc_Arr: array[50] of Text[200];
        PrecUnit_Arr: array[50] of Decimal;
        PorcDto_Arr: array[50] of Decimal;
        ImpDesc_Arr: array[50] of Decimal;
        BaseExe_Arr: array[50] of Decimal;
        Iva1_Arr: array[50] of Decimal;
        Iva2_Arr: array[50] of Decimal;
        Imp_Arr: array[50] of Decimal;
        I: Integer;
        wTotalDescuento: Decimal;
        wtotalEx: Decimal;
        IvaTotal: Decimal;
        NoFacFiscal: Code[12];
        CiudadEmision: Code[20];
        TextDia: Text[30];
        TextMes: Text[30];
        TextAno: Text[30];
        NombreDiv: Text[30];
        Tel: Code[20];
        Fax: Code[20];
        CodProd_Fact_Arr: array[50] of Code[20];
        Cantidad_Fact_Arr: array[50] of Integer;
        Desc_Fact_Arr: array[50] of Text[200];
        PrecUnit_Fact_Arr: array[50] of Decimal;
        PorcDto_Fact_Arr: array[50] of Decimal;
        ImpDesc_Fact_Arr: array[50] of Decimal;
        BaseExe_Fact_Arr: array[50] of Decimal;
        Iva1_Fact_Arr: array[50] of Decimal;
        Iva2_Fact_Arr: array[50] of Decimal;
        Imp_Fact_Arr: array[50] of Decimal;
        CodUndMed_Fact_Arr: array[50] of Code[20];
        CodUndMed_Arr: array[50] of Code[20];
        SIH: Record 112;
        SIL: Record 113;
        CLE2: Record 21;
        NoFacLiq: Code[20];
        ImporteTotal: Decimal;
        ImporteTotalFact: Decimal;
        ImpDesc: Decimal;
        ImpDescFact: Decimal;
        NoFiscalFactura: Code[40];
        NoAutFac: Code[30];
        wMax: Integer;
        KK: Boolean;
        Text100: Label 'El informe est´Š¢ adaptado para imprimir s´Š¢lo una nota de credito';
        DescuentoCaption_Control1000000138Lbl: Label 'Descuento';
        DescuentoCaptionLbl: Label 'Descuento';
}

