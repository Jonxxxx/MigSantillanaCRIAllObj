report 34002508 "DsPOS - Factura Venta BOL ON"
{
    // Proyecto: Microsoft Dynamics Nav
    // ------------------------------------------------------------------------------
    // FES   : Fausto Serrata
    // ------------------------------------------------------------------------------
    // No.             Firma         Fecha           Descripcion
    // ------------------------------------------------------------------------------
    // CPMCR-CEC       FES           08-06-2021      Comentario por migracion Costa Rica. Corregir error compilacion.
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/DsPOS - Factura Venta BOL ON.rdl';

    Permissions = TableData 21 = rm,
                  TableData 112 = rm,
                  TableData 7190 = rm,
                  TableData 34003012 = rim;

    dataset
    {
        dataitem("Sales Invoice Header"; 112)
        {
            CalcFields = "Amount Including VAT";
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.", "Sell-to Customer No.";
            column(Sales_Invoice_Header__Bill_to_Address_; Loc.Address)
            {
            }
            column(Sales_Invoice_Header__Bill_to_Name_; "Bill-to Name")
            {
            }
            column(Sales_Invoice_Header__Bill_to_city_; Loc.City + ' - ' + Pais.Name)
            {
            }
            column(Ruc_Cliente; "VAT Registration No.")
            {
            }
            column(NoFactFiscal; NoFacFiscal)
            {
            }
            column(CiudadEmision; Loc.City + ', ' + TextDia + ' de ' + TextMes + ' de ' + TextAno)
            {
            }
            column(C__Piloto____Tel___Fax____Fax; 'C. Piloto ' + Loc."Phone No." + ' Fax: ' + Loc."Fax No.")
            {
            }
            column(Bill_to_Address_________Bill_to_Address_2________Bill_to_City_; "Bill-to Address" + ', ' + "Bill-to Address 2" + ', ' + "Bill-to City")
            {
            }
            column(Sales_Invoice_Header__Due_Date_; "Due Date")
            {
            }
            column(CodProd_Arr_1_; CodProd_Arr[1])
            {
            }
            column(Cantidad_Arr_1_; Cantidad_Arr[1])
            {
            }
            column(Desc_Arr_1_; Desc_Arr[1])
            {
            }
            column(PrecUnit_Arr_1_; PrecUnit_Arr[1])
            {
            }
            column(Imp_Arr_1_; Imp_Arr[1])
            {
                DecimalPlaces = 2 : 2;
            }
            column(CodProd_Arr_2_; CodProd_Arr[2])
            {
            }
            column(Cantidad_Arr_2_; Cantidad_Arr[2])
            {
            }
            column(Desc_Arr_2_; Desc_Arr[2])
            {
            }
            column(PrecUnit_Arr_2_; PrecUnit_Arr[2])
            {
            }
            column(Imp_Arr_2_; Imp_Arr[2])
            {
                DecimalPlaces = 2 : 2;
            }
            column(CodProd_Arr_3_; CodProd_Arr[3])
            {
            }
            column(Cantidad_Arr_3_; Cantidad_Arr[3])
            {
            }
            column(Desc_Arr_3_; Desc_Arr[3])
            {
            }
            column(PrecUnit_Arr_3_; PrecUnit_Arr[3])
            {
            }
            column(Imp_Arr_3_; Imp_Arr[3])
            {
                DecimalPlaces = 2 : 2;
            }
            column(CodProd_Arr_4_; CodProd_Arr[4])
            {
            }
            column(Cantidad_Arr_4_; Cantidad_Arr[4])
            {
            }
            column(Desc_Arr_4_; Desc_Arr[4])
            {
            }
            column(PrecUnit_Arr_4_; PrecUnit_Arr[4])
            {
            }
            column(Imp_Arr_4_; Imp_Arr[4])
            {
                DecimalPlaces = 2 : 2;
            }
            column(CodProd_Arr_5_; CodProd_Arr[5])
            {
            }
            column(Cantidad_Arr_5_; Cantidad_Arr[5])
            {
            }
            column(Desc_Arr_5_; Desc_Arr[5])
            {
            }
            column(PrecUnit_Arr_5_; PrecUnit_Arr[5])
            {
            }
            column(Imp_Arr_5_; Imp_Arr[5])
            {
                DecimalPlaces = 2 : 2;
            }
            column(CodProd_Arr_6_; CodProd_Arr[6])
            {
            }
            column(Cantidad_Arr_6_; Cantidad_Arr[6])
            {
            }
            column(Desc_Arr_6_; Desc_Arr[6])
            {
            }
            column(PrecUnit_Arr_6_; PrecUnit_Arr[6])
            {
            }
            column(Imp_Arr_6_; Imp_Arr[6])
            {
                DecimalPlaces = 2 : 2;
            }
            column(CodProd_Arr_7_; CodProd_Arr[7])
            {
            }
            column(Cantidad_Arr_7_; Cantidad_Arr[7])
            {
            }
            column(Desc_Arr_7_; Desc_Arr[7])
            {
            }
            column(PrecUnit_Arr_7_; PrecUnit_Arr[7])
            {
            }
            column(Imp_Arr_7_; Imp_Arr[7])
            {
                DecimalPlaces = 2 : 2;
            }
            column(CodProd_Arr_8_; CodProd_Arr[8])
            {
            }
            column(Cantidad_Arr_8_; Cantidad_Arr[8])
            {
            }
            column(Desc_Arr_8_; Desc_Arr[8])
            {
            }
            column(PrecUnit_Arr_8_; PrecUnit_Arr[8])
            {
            }
            column(Imp_Arr_8_; Imp_Arr[8])
            {
                DecimalPlaces = 2 : 2;
            }
            column(CodProd_Arr_9_; CodProd_Arr[9])
            {
            }
            column(Cantidad_Arr_9_; Cantidad_Arr[9])
            {
            }
            column(Desc_Arr_9_; Desc_Arr[9])
            {
            }
            column(PrecUnit_Arr_9_; PrecUnit_Arr[9])
            {
            }
            column(Imp_Arr_9_; Imp_Arr[9])
            {
                DecimalPlaces = 2 : 2;
            }
            column(CodProd_Arr_10_; CodProd_Arr[10])
            {
            }
            column(Cantidad_Arr_10_; Cantidad_Arr[10])
            {
            }
            column(Desc_Arr_10_; Desc_Arr[10])
            {
            }
            column(PrecUnit_Arr_10_; PrecUnit_Arr[10])
            {
            }
            column(Imp_Arr_10_; Imp_Arr[10])
            {
                DecimalPlaces = 2 : 2;
            }
            column(CodProd_Arr_11_; CodProd_Arr[11])
            {
            }
            column(Cantidad_Arr_11_; Cantidad_Arr[11])
            {
            }
            column(Desc_Arr_11_; Desc_Arr[11])
            {
            }
            column(PrecUnit_Arr_11_; PrecUnit_Arr[11])
            {
            }
            column(Imp_Arr_11_; Imp_Arr[11])
            {
                DecimalPlaces = 2 : 2;
            }
            column(CodProd_Arr_12_; CodProd_Arr[12])
            {
            }
            column(Cantidad_Arr_12_; Cantidad_Arr[12])
            {
            }
            column(Desc_Arr_12_; Desc_Arr[12])
            {
            }
            column(PrecUnit_Arr_12_; PrecUnit_Arr[12])
            {
            }
            column(Imp_Arr_12_; Imp_Arr[12])
            {
                DecimalPlaces = 2 : 2;
            }
            column(NombreVendedor; VendorName)
            {
            }
            column(TotalDescuento; wTotalDescuento)
            {
            }
            column(ImporteBruto; "Amount Including VAT" + wTotalDescuento)
            {
                DecimalPlaces = 0 : 2;
            }
            column(DescriptionLine_1_____________CurrName; DescriptionLine[1] + ' ' + NombreDiv)
            {
            }
            column(Serie_Factura_________No__Comprobante_Fiscal_; "No. Comprobante Fiscal")
            {
            }
            column(ImporteTotal; ImporteTotal)
            {
            }
            column(Vcto_Caption; Vcto_CaptionLbl)
            {
            }
            column(Tasa_Cero___Sin_Derecho_a_Credito_Fiscal_Caption; Tasa_Cero___Sin_Derecho_a_Credito_Fiscal_CaptionLbl)
            {
            }
            column(Ley_No__366__del_Libro_y_la_LecturaCaption; Ley_No__366__del_Libro_y_la_LecturaCaptionLbl)
            {
            }
            column(Sales_Invoice_Header_No_; "No.")
            {
            }
            dataitem("Sales Invoice Line"; 113)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    WHERE(Quantity = FILTER(<> 0),
                                          Type = FILTER(<> 'Charge (Item)'));
                column(Sales_Invoice_Line__No__; "No.")
                {
                }
                column(Sales_Invoice_Line_Description; Description)
                {
                }
                column(Sales_Invoice_Line__Amount_Including_VAT_; "Amount Including VAT")
                {
                    DecimalPlaces = 0 : 2;
                }
                column(Sales_Invoice_Line__Unit_Price_; "Unit Price")
                {
                }
                column(Sales_Invoice_Line_Quantity; Quantity)
                {
                }
                column(Sales_Invoice_Line_Document_No_; "Document No.")
                {
                }
                column(Sales_Invoice_Line_Line_No_; "Line No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    /*
                    ICR.SETRANGE(ICR."Item No.","No.");
                    ICR.SETRANGE(ICR."Unit of Measure","Unit of Measure");
                    IF NOT ICR.FINDFIRST THEN
                      BEGIN
                        ICR.RESET;
                        ICR.SETRANGE(ICR."Item No.","No.");
                        IF ICR.FINDFIRST THEN
                          CodBarra := ICR."Cross-Reference No."
                        ELSE
                          CodBarra := ''
                      END;
                    
                    //IVA
                    //Columna1IVA := 0;
                    //Columna2Iva := 0;
                    ColumnaExe := 0;
                    Columna1IVABase :=0;
                    Columna2IvaBase :=0;
                    ColumnaExeBase  :=0;
                    {
                    ConfSant.GET;
                    ConfSant.TESTFIELD("% IVA Venta 1");
                    ConfSant.TESTFIELD("% IVA Venta 2");
                    IF ("Amount Including VAT" - Amount) <> 0 THEN
                      BEGIN
                        VatPostSet.RESET;
                        VatPostSet.SETRANGE("VAT Prod. Posting Group","VAT Prod. Posting Group");
                        VatPostSet.SETRANGE("VAT %",ConfSant."% IVA Venta 1");
                        IF VatPostSet.FINDFIRST  THEN
                          BEGIN
                          Columna1IVA += "Amount Including VAT" - Amount;
                          Columna1IVABase := Amount;
                          END;
                        VatPostSet.RESET;
                        VatPostSet.SETRANGE("VAT Prod. Posting Group","VAT Prod. Posting Group");
                        VatPostSet.SETRANGE("VAT %",ConfSant."% IVA Venta 2");
                        IF VatPostSet.FINDFIRST  THEN
                          BEGIN
                          Columna2Iva += "Amount Including VAT" - Amount;
                          Columna2IvaBase := Amount;
                          END;
                      END
                    ELSE
                      BEGIN
                      ColumnaExe := "Amount Including VAT";
                      ColumnaExeBase := Amount;
                      END;
                    //IVA
                     }
                    {
                    ImporteSinCargos += Amount + "Line Discount Amount";
                    Descuento += "Line Discount Amount";
                    CantENviada += Quantity;
                    CantSolicitada += "Cantidad Solicitada";
                    igv += "Amount Including VAT" - Amount;
                    }
                     */

                end;

                trigger OnPreDataItem()
                begin
                    //CurrReport.CREATETOTALS(Amount,"Unit Price","Line Discount Amount","Amount Including VAT",Quantity);
                    //CurrReport.CREATETOTALS(ImporteSinCargos,Descuento,CantENviada,CantSolicitada,igv);
                end;
            }
            dataitem(CopyLoop; 2000000026)
            {
                DataItemTableView = SORTING(Number);

                trigger OnAfterGetRecord()
                begin
                    CurrReport.PAGENO := 1;

                    IF CopyNo = NoLoops THEN BEGIN
                        IF NOT CurrReport.PREVIEW THEN
                            SalesInvPrinted.RUN("Sales Invoice Header");
                        CurrReport.BREAK;
                    END ELSE
                        CopyNo := CopyNo + 1;
                    IF CopyNo = 1 THEN // Original
                        CLEAR(CopyTxt)
                    ELSE
                        CopyTxt := Text000;
                end;

                trigger OnPreDataItem()
                begin
                    NoLoops := 1 + ABS(NoCopies) + Customer."Invoice Copies";
                    IF NoLoops <= 0 THEN
                        NoLoops := 1;
                    CopyNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                GLSetUp.GET;

                Comentario := '';
                iBruto := 0;
                ImporteCargos := 0;
                ImporteSinCargos := 0;
                DescuentoCargos := 0;
                CantENviada := 0;
                CantSolicitada := 0;
                igv := 0;
                Columna1IVA := 0;
                Columna2Iva := 0;
                IF rTPV.GET(TPV) THEN;

                //CPMCR-CEC+
                /*
                NoFacFiscal := FuncBolv.NoFacFiscal("No. Factura Fiscal");
                SerieCompleta := "Punto de Emision Factura" +'-'+"Establecimiento Factura"+"No. Comprobante Fiscal";
                */
                //CPMCR-CEC-

                rCliente.GET("Sell-to Customer No.");
                Tel := rCliente."Phone No.";
                Fax := rCliente."E-Mail 2";

                NombreDiv := GLSetUp."Nombre Divisa Local";

                IF NOT Loc.GET("Location Code") THEN BEGIN
                    SIL.RESET;
                    SIL.SETRANGE("Document No.", "No.");
                    SIL.SETRANGE("Location Code", '<>%1', '');
                    IF SIL.FINDFIRST THEN
                        Loc.GET(SIL."Location Code");
                END;
                IF Pais.GET(Loc."Country/Region Code") THEN;


                TextDia := FORMAT("Posting Date", 0, ('<day,2>'));
                TextMes := UPPERCASE(FORMAT("Posting Date", 0, ('<month Text>')));
                TextAno := FORMAT("Posting Date", 0, ('<year4>'));


                IF "Currency Code" <> '' THEN BEGIN
                    Currency.GET("Currency Code");
                    CurrName := Currency.Description;
                    CodDiv := "Currency Code";
                END
                ELSE BEGIN
                    CurrName := GLSetUp."Nombre Divisa Local";
                    CodDiv := GLSetUp."LCY Code";
                END;


                IF Vendedor_Comprador.GET("Salesperson Code") THEN
                    VendorName := Vendedor_Comprador.Name;

                IF PT.GET("Payment Terms Code") THEN
                    CondicionPago := PT.Description;

                SCL.SETRANGE("Document Type", SCL."Document Type"::"Posted Invoice");
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




                IF Cust.GET("Sell-to Customer No.") THEN
                    Nombre := UPPERCASE(Cust.Name);

                IF PostCodes.GET("Sell-to Post Code", "Sell-to City") THEN BEGIN
                    Provincia := PostCodes.County;
                    Departamento := PostCodes.Colonia;
                END;
                PuntoLlegada := "Sell-to Address" + ', ' + "Sell-to City" + ', ' + Provincia + ', ' + Departamento;


                //GRN Para anular el ncf actual y generar uno nuevo - Error de impresion -

                ConfSant.GET;
                IF ConfSant."Anula NCF al Reimprimir" THEN BEGIN
                    IF ("No. Printed" > 0) AND (NOT CurrReport.PREVIEW) THEN BEGIN
                        NCFAnulados."No. documento" := "No.";
                        NCFAnulados."No. Serie NCF Facturas" := "No. Serie NCF Facturas";
                        NCFAnulados."No. Comprobante Fiscal" := "No. Comprobante Fiscal";
                        NCFAnulados."Fecha anulacion" := TODAY;

                        //CPMCR-CEC+
                        /*
                        NCFAnulados."Tipo Documento" := 2;
                        NCFAnulados."No. Autorizacion" := "No. Autorizacion Comprobante";
                        NCFAnulados."Punto Emision"   := "Punto de Emision Factura";
                        NCFAnulados.Establecimiento   := "Establecimiento Factura";
                        */
                        //CPMCR-CEC-
                        NCFAnulados.INSERT;
                        "No. Comprobante Fiscal" := NoSeriesMgt.GetNextNo("No. Serie NCF Facturas", TODAY, TRUE);
                        MODIFY;

                        CLE.SETCURRENTKEY("Document No.", "Document Type", "Customer No.");
                        CLE.SETRANGE("Document No.", "No.");
                        CLE.SETRANGE("Document Type", CLE."Document Type"::Invoice);
                        CLE.SETRANGE("Customer No.", "Sell-to Customer No.");
                        CLE.FINDFIRST;
                        CLE."No. Comprobante Fiscal" := "No. Comprobante Fiscal";
                        CLE.MODIFY;
                    END;
                END;
                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN BEGIN
                        /*    IF "Bill-to Contact No." <> '' THEN
                              SegManagement.LogDocument(
                                4,"No.",0,0,DATABASE::Contact,"Bill-to Contact No.","Salesperson Code",
                                "Campaign No.","Posting Description",'')
                            ELSE
                              SegManagement.LogDocument(
                                4,"No.",0,0,DATABASE::Customer,"Bill-to Customer No.","Salesperson Code",
                                "Campaign No.","Posting Description",'');
                         */
                    END;

                // --------------------------------------- Codigo Dynasoft --------------------------------------------
                SCL.SETRANGE("Document Type", SCL."Document Type"::Invoice);
                SCL.SETRANGE("No.", "No.");
                IF SCL.FINDFIRST THEN;
                // --------------------------------------- Codigo Dynasoft --------------------------------------------


                //Lineas de Venta
                I := 0;
                wTotalDescuento := 0;
                ImporteTotal := 0;

                SIL.RESET;
                SIL.SETRANGE("Document No.", "No.");
                SIL.SETFILTER(Quantity, '<>%1', 0);
                SIL.SETFILTER(Type, '<>%1', SIL.Type::"Charge (Item)");
                IF SIL.FINDSET THEN
                    REPEAT
                        I += 1;
                        CodProd_Arr[I] := SIL."No.";
                        Cantidad_Arr[I] := SIL.Quantity;
                        Desc_Arr[I] := SIL.Description;
                        PrecUnit_Arr[I] := SIL."Unit Price";
                        Imp_Arr[I] := SIL."Amount Including VAT";
                        ImporteTotal += SIL."Amount Including VAT";
                        PorcDto_Arr[I] := SIL."Line Discount %";
                        ImpDesc_Arr[I] := SIL."Line Discount Amount";
                        wTotalDescuento += SIL."Line Discount Amount";
                        //IVA
                        //Columna1IVA := 0;
                        //Columna2Iva := 0;
                        ColumnaExe := 0;
                        Columna1IVABase := 0;
                        Columna2IvaBase := 0;
                        ColumnaExeBase := 0;

                        ConfSant.GET;
                    UNTIL SIL.NEXT = 0;

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
        Vendedor_Comprador: Record 13;
        rPais: Record 9;
        ChkTransMgt: Report 10400;
        PT: Record 3;
        GLSetUp: Record 98;
        NCFAnulados: Record 34003012;
        rTPV: Record 34002503;
        Pais: Record 9;
        ConfSant: Record 55226;
        SIL: Record 113;
        Loc: Record 14;
        DimVal: Record 349;
        Cust: Record 18;
        PostCodes: Record 225;
        Customer: Record 18;
        CLE: Record 21;
        SSH: Record 110;

        NoSeriesMgt: Codeunit "No. Series";

        SalesInvPrinted: Codeunit 315;
        wDiv: Code[10];
        VendorName: Text[50];
        vPais: Text[50];
        Comentario: Text[1024];
        DescriptionLine: array[2] of Text[250];
        CurrName: Text[30];
        Text002: Label 'Total %1';
        txtIva: Text[30];
        txt004: Label '(*) IVA';
        NoLineas: Integer;
        CondicionPago: Text[100];
        iBruto: Decimal;
        totDesc: Decimal;
        igv: Decimal;
        otros: Decimal;
        TotFactura: Decimal;
        CodDiv: Code[20];
        NoGuia: Code[50];
        Prueba: Decimal;
        Descuento: Decimal;
        TipoCliente: Text[100];
        TipoVenta: Text[100];
        txt005: Label 'SON';
        Nombre: Text[250];
        Provincia: Text[150];
        Departamento: Text[150];
        PuntoLlegada: Text[500];
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        CopyTxt: Text[10];
        Text000: Label 'COPY';
        ImporteSinCargos: Decimal;
        ImporteCargos: Decimal;
        DescuentoCargos: Decimal;
        CantENviada: Decimal;
        CantSolicitada: Decimal;
        Vendedor: Text[30];
        CodBarra: Code[20];
        LogInteraction: Boolean;
        Tel: Code[20];
        Fax: Code[20];
        SerieCompleta: Code[50];
        Columna1IVA: Decimal;
        Columna2Iva: Decimal;
        ColumnaExe: Decimal;
        Columna1IVABase: Decimal;
        Columna2IvaBase: Decimal;
        ColumnaExeBase: Decimal;
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
        ImporteTotal: Decimal;
        Vcto_CaptionLbl: Label 'Vcto:';
        Tasa_Cero___Sin_Derecho_a_Credito_Fiscal_CaptionLbl: Label 'Tasa Cero - Sin Derecho a Credito Fiscal,';
        Ley_No__366__del_Libro_y_la_LecturaCaptionLbl: Label 'Ley No. 366, del Libro y la Lectura';
}

