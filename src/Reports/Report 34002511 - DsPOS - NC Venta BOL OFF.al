report 55905 "DsPOS - NC Venta BOL OFF"
{
    // $001 11/08/2014 JML : DSPOS Bolivia 2013R2
    //                       Reporte basado en el de notas de credito registradas 54002
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/DsPOS - NC Venta BOL OFF.rdl';

    Permissions = TableData 21 = rm,
                  TableData 114 = rm,
                  TableData 7190 = rm,
                  TableData 55967 = rim;

    dataset
    {
        dataitem("Sales Cr.Memo Header"; 36)
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                ORDER(Ascending)
                                WHERE("Document Type" = CONST("Credit Memo"));
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
                    SETRANGE(Number, 1, wMax);

                    I := 0;
                end;
            }
            dataitem("Sales Line"; 37)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                    WHERE("Document Type" = CONST("Credit Memo"));

                trigger OnPreDataItem()
                begin
                    CurrReport.CREATETOTALS(Amount, "Unit Price", "Line Discount Amount", "Amount Including VAT", Quantity);
                end;
            }
            dataitem(SCML2; 37)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                    WHERE("Document Type" = FILTER("Credit Memo"),
                                          Type = FILTER(<> Item));

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
                ChkTransMgt: Report 10400;
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

                NoFacFiscal := "No. Fiscal TPV";

                TextDia := FORMAT("Posting Date", 0, ('<day,2>'));
                TextMes := UPPERCASE(FORMAT("Posting Date", 0, ('<month Text>')));
                TextAno := FORMAT("Posting Date", 0, ('<year4>'));

                NombreDiv := GLSetUp."Nombre Divisa Local";

                IF Loc.GET("Location Code") THEN;

                SCL.RESET;
                SCL.SETRANGE("Document Type", SCL."Document Type"::"Credit Memo");
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

                SCML.RESET;
                SCML.SETRANGE("Document Type", "Document Type"::"Credit Memo");
                SCML.SETRANGE("Document No.", "No.");
                SCML.SETFILTER(Type, '<>%1', SCML.Type::"Charge (Item)");
                IF SCML.FINDSET THEN
                    REPEAT
                        ImporteSinCargos += SCML.Amount + SCML."Line Discount Amount";
                        Descuento += SCML."Line Discount Amount";
                        CantUnidades += SCML.Quantity;
                        igv += SCML."Amount Including VAT" - SCML.Amount;
                    UNTIL SCML.NEXT = 0;


                I := 0;
                SCML.RESET;
                SCML.SETRANGE("Document Type", "Document Type"::"Credit Memo");
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

                        SIL.RESET;
                        SIL.SETRANGE("Document No.", SCML."Devuelve a Documento");
                        SIL.SETRANGE("Line No.", SCML."Devuelve a Linea Documento");
                        IF SIL.FINDFIRST THEN BEGIN
                            CodProd_Fact_Arr[I] := SIL."No.";
                            Cantidad_Fact_Arr[I] := SIL.Quantity;
                            Desc_Fact_Arr[I] := SIL.Description;
                            PrecUnit_Fact_Arr[I] := SIL."Unit Price";
                            CodUndMed_Fact_Arr[I] := SIL."Unit of Measure Code";
                            Imp_Fact_Arr[I] := SIL."Amount Including VAT";
                            ImpDescFact += SIL."Line Discount Amount";
                            ImporteTotalFact += SIL."Amount Including VAT";

                            ImpDesc += SIL."Line Discount Amount";
                            ImporteTotal += SIL."Amount Including VAT";
                        END;
                    UNTIL SCML.NEXT = 0;
            end;

            trigger OnPreDataItem()
            var
                lrCredit: Record 36;
            begin
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
    end;

    var
        GLSetUp: Record 98;
        SCL: Record 44;
        rCliente: Record 18;
        Text001: Label 'Page %1';
        SIL: Record 113;
        _PT: Record 3;
        SSH: Record 110;
        SCML: Record 37;
        Loc: Record 14;
        wDiv: Code[10];
        _VendorName: Text[50];
        Comentario: Text[1024];
        DescriptionLine: array[2] of Text[250];
        Text002: Label 'Total %1';
        txtIva: Text[30];
        txt004: Label '(*) IVA';
        NoLineas: Integer;
        _CondicionPago: Text[100];
        iBruto: Decimal;
        totDesc: Decimal;
        igv: Decimal;
        otros: Decimal;
        TotFactura: Decimal;
        NoGuia: Code[50];
        Prueba: Decimal;
        Descuento: Decimal;
        txt005: Label 'SON';
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        Text004: Label 'COPY';
        OutputNo: Integer;
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
        NoFacFiscal: Code[50];
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

