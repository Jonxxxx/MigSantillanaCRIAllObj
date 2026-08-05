report 34002516 "DsPOS - Factura Venta EC ON"
{
    // #1379 CAT 08/01/14 Printamos la forma de pago.
    // 
    // Proyecto: Microsoft Dynamics Nav
    // ------------------------------------------------------------------------------
    // FES   : Fausto Serrata
    // ------------------------------------------------------------------------------
    // No.             Firma         Fecha           Descripcion
    // ------------------------------------------------------------------------------
    // CPMCR-CEC       FES           08-06-2021      Comentario por migracion Costa Rica. Corregir error compilacion.
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/DsPOS - Factura Venta EC ON.rdl';

    Permissions = TableData 21 = rm,
                  TableData 112 = rm,
                  TableData 7190 = rm,
                  TableData 34003012 = rim;

    dataset
    {
        dataitem("Sales Invoice Header"; 112)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.";
            column(Sales_Invoice_Header__Posting_Date_; FORMAT("Posting Date"))
            {
            }
            column(TIME; FORMAT(TIME))
            {
            }
            column(rCliente__No_Cliente; "Bill-to Customer No." + ' - ' + "Bill-to Name")
            {
            }
            column(rCliente__VAT_Registration_No__; "VAT Registration No.")
            {
            }
            column(Sales_Invoice_Header__Bill_to_Address_; "Bill-to Address")
            {
            }
            column(rCliente__Phone_No1_; "No. Telefono")
            {
            }
            column(Sales_Invoice_Header_TPV; TPV)
            {
            }
            column(Sales_Invoice_Header__No__Comprobante_Fiscal_; "No. Comprobante Fiscal")
            {
            }
            column(FormaPagoTPV; FormaPagoTPV)
            {
            }
            column(Sales_Invoice_Header__User_ID_2; FORMAT(TODAY))
            {
            }
            column(CodDivLocalFormateada; CodDiv + ' ' + FORMAT(TotFactura, 0, '<Precision,2:2><Standard format,0>'))
            {

            }
            column(Sales_Invoice_Header__User_ID_; "User ID")
            {
            }
            column(igv; igv)
            {
            }
            column(totDesc; Descuento)
            {
            }
            column(iBruto11; ImporteSinCargos - Descuento)
            {
            }
            column(DescriptionLine_1_____________CurrName; txt005 + ' ' + DescriptionLine[1] + ' ** ' + CurrName)
            {
            }
            column(Sales_Invoice_Line_Quantity_Control1000000004; CantENviada)
            {
                DecimalPlaces = 0 : 2;
            }
            column(ABS_Exento_; ABS(Exento))
            {
            }
            column(ABS_Grabado_; ABS(Grabado))
            {
                DecimalPlaces = 0 : 2;
            }
            column(Cambio; Cambio)
            {
            }
            column(Recibe; Recibe)
            {
            }
            column(FechaCaption; FechaCaptionLbl)
            {
            }
            column(No__de_Cliente___Caption; No__de_Cliente___CaptionLbl)
            {
            }
            column(VendedorCaption; VendedorCaptionLbl)
            {
            }
            column(RUC_Caption; RUC_CaptionLbl)
            {
            }
            column(EntregarCaption; EntregarCaptionLbl)
            {
            }
            column(Cantidad_Enviada; Cantidad_EnviadaLbl)
            {
            }
            column(Cod_ProductoCaption; Cod_ProductoCaptionLbl)
            {
            }
            column(Precio_UnitarioCaption; Precio_UnitarioCaptionLbl)
            {
            }
            column(Pct_DescCaption; Pct_DescCaptionLbl)
            {
            }
            column(Importe_Linea; Importe_LineaLbl)
            {
            }
            column(Desc_ProductoCaption; Desc_ProductoCaptionLbl)
            {
            }
            column(F__Pago_Caption; F__Pago_CaptionLbl)
            {
            }
            column(Total_Caption; Total_CaptionLbl)
            {
            }
            column(IVA_12_Caption; IVA_12_CaptionLbl)
            {
            }
            column(DESCUENTOCaption; DESCUENTOCaptionLbl)
            {
            }
            column(SUBTOTALCaption; SUBTOTALCaptionLbl)
            {
            }
            column(TOTALCaption; TOTALCaptionLbl)
            {
            }
            column(Tarifa_IVA_12____Caption; Tarifa_IVA_12____CaptionLbl)
            {
            }
            column(Tarifa_IVA_0____Caption; Tarifa_IVA_0____CaptionLbl)
            {
            }
            column(Cambio__Caption; Cambio__CaptionLbl)
            {
            }
            column(Recibe__Caption; Recibe__CaptionLbl)
            {
            }
            column(Sales_Invoice_Header_No_; "No.")
            {
            }
            dataitem("Sales Invoice Line"; 113)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", Type, "No.")
                                    WHERE(Quantity = FILTER(<> 0),
                                          Type = FILTER(<> 'Charge (Item)'));
                column(Sales_Invoice_Line_Description; Description)
                {
                }
                column(Sales_Invoice_Line__No__; "No.")
                {
                }
                column(Sales_Invoice_Line__Amount_Including_VAT_; "Amount Including VAT")
                {
                    DecimalPlaces = 0 : 2;
                }
                column(Sales_Invoice_Line__Unit_Price_; "Unit Price")
                {
                }
                column(Sales_Invoice_Line__Line_Discount___; "Line Discount %")
                {
                    DecimalPlaces = 2 : 2;
                }
                column(Sales_Invoice_Line_Quantity; Quantity)
                {
                }
                column(Sales_Invoice_Line_Description_Control1000000039; Description)
                {
                }
                column(Sales_Invoice_Line__Amount_Including_VAT__Control1000000040; "Amount Including VAT")
                {
                    DecimalPlaces = 0 : 2;
                }
                column(Sales_Invoice_Line__Unit_Price__Control1000000041; "Unit Price")
                {
                }
                column(Sales_Invoice_Line__No___Control1000000042; "No.")
                {
                }
                column(Sales_Invoice_Line_Quantity_Control1000000050; Quantity)
                {
                }
                column(Sales_Invoice_Line__Line_Discount____Control1000000053; "Line Discount %")
                {
                    DecimalPlaces = 2 : 2;
                }
                column(Sales_Invoice_Line_Document_No_; "Document No.")
                {
                }
                column(Sales_Invoice_Line_Line_No_; "Line No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //TODO Ver
                    /*
                    ICR.SETRANGE(ICR."Item No.", "No.");
                    ICR.SETRANGE(ICR."Unit of Measure", "Unit of Measure");
                    IF NOT ICR.FINDFIRST THEN BEGIN
                        ICR.RESET;
                        ICR.SETRANGE(ICR."Item No.", "No.");
                        IF ICR.FINDFIRST THEN
                            CodBarra := ICR."Cross-Reference No."
                        ELSE
                            CodBarra := ''
                    END;*/
                    //TODO: Temp
                    CodBarra := '';


                    /*
                    Descuento += "Line Discount Amount";
                    ImporteSinCargos += Amount + "Line Discount Amount";
                    Descuento += "Line Discount Amount";
                    CantENviada += Quantity;
                    CantSolicitada += "Cantidad Solicitada";
                    igv += "Amount Including VAT" - Amount;
                    */

                end;

                trigger OnPostDataItem()
                begin
                    Grabado := 0;
                    Exento := 0;
                end;

                trigger OnPreDataItem()
                begin
                    //CurrReport.CREATETOTALS(Amount,"Unit Price","Line Discount Amount","Amount Including VAT",Quantity);
                    //CurrReport.CREATETOTALS(ImporteSinCargos,Descuento,CantENviada,CantSolicitada,igv);
                end;
            }

            trigger OnAfterGetRecord()
            var
                rLocFormaPagoTPV: Record 34002513;
            begin

                Comentario := '';
                iBruto := 0;
                ImporteCargos := 0;
                ImporteSinCargos := 0;
                DescuentoCargos := 0;
                CantENviada := 0;
                CantSolicitada := 0;
                igv := 0;


                rCliente.GET("Sell-to Customer No.");

                IF Loc.GET("Location Code") THEN;

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


                SIL.RESET;
                SIL.SETRANGE("Document No.", "No.");
                SIL.SETFILTER(Type, '<>%1', SIL.Type::"Charge (Item)");
                IF SIL.FINDSET THEN
                    REPEAT
                        ImporteSinCargos += SIL.Amount + SIL."Line Discount Amount";
                        Descuento += SIL."Line Discount Amount";
                        CantENviada += SIL.Quantity;
                        CantSolicitada += SIL."Cantidad Solicitada";
                        igv += SIL."Amount Including VAT" - SIL.Amount;
                    UNTIL SIL.NEXT = 0;

                /*
                //Datos para Historico de RTC
                SIL.RESET;
                SIL.SETRANGE("Document No.","No.");
                SIL.SETFILTER(Type,'<>%1',SIL.Type::"Charge (Item)");
                IF SIL.FINDSET THEN
                  REPEAT
                    ImporteSinCargos += SIL.Amount + SIL."Line Discount Amount";
                    Descuento += SIL."Line Discount Amount";
                    CantENviada += SIL.Quantity;
                    igv += SIL."Amount Including VAT" - SIL.Amount;
                  UNTIL SIL.NEXT = 0;
                
                
                SIL.RESET;
                SIL.SETRANGE("Document No.","No.");
                SIL.SETRANGE(SIL.Type,SIL.Type::"Charge (Item)");
                IF SIL.FINDSET THEN
                  REPEAT
                    ImporteCargos += SIL.Amount + SIL."Line Discount Amount";
                    DescuentoCargos += SIL."Line Discount Amount";
                    igv += SIL."Amount Including VAT" - SIL.Amount;
                  UNTIL SIL.NEXT = 0;
                
                */
                //Datos Dimensiones

                //Tipo Clinte
                //PostedDocDim.RESET;
                //PostedDocDim.SETRANGE("Table ID",112);
                //PostedDocDim.SETRANGE("Document No.","No.");
                //PostedDocDim.SETRANGE("Dimension Code",'TIPO_CLIENTE');
                //PostedDocDim.SETRANGE("Line No.",0);
                //IF PostedDocDim.FINDFIRST THEN
                //  BEGIN
                //    //TipoCliente := PostedDocDim."Dimension Value Code";
                //    DimVal.RESET;
                //    DimVal.SETRANGE("Dimension Code",PostedDocDim."Dimension Code");
                //    DimVal.SETRANGE(Code,PostedDocDim."Dimension Value Code");
                //    IF DimVal.FINDFIRST THEN
                //      TipoCliente := DimVal.Name;
                //  END;
                recDimEntry.RESET;
                recDimEntry.SETRANGE("Dimension Set ID", "Dimension Set ID");
                recDimEntry.SETRANGE("Dimension Code", 'TIPO_CLIENTE');
                IF recDimEntry.FINDFIRST THEN BEGIN
                    //TipoCliente := PostedDocDim."Dimension Value Code";
                    DimVal.RESET;
                    DimVal.SETRANGE("Dimension Code", recDimEntry."Dimension Code");
                    DimVal.SETRANGE(Code, recDimEntry."Dimension Value Code");
                    IF DimVal.FINDFIRST THEN
                        TipoCliente := DimVal.Name;
                END;

                //Tipo Venta
                //PostedDocDim.RESET;
                //PostedDocDim.SETRANGE("Table ID",112);
                //PostedDocDim.SETRANGE("Document No.","No.");
                //PostedDocDim.SETRANGE("Dimension Code",'TIPO_VENTA');
                //PostedDocDim.SETRANGE("Line No.",0);
                //IF PostedDocDim.FINDFIRST THEN
                //  BEGIN
                //    //TipoCliente := PostedDocDim."Dimension Value Code";
                //    DimVal.RESET;
                //    DimVal.SETRANGE("Dimension Code",PostedDocDim."Dimension Code");
                //    DimVal.SETRANGE(Code,PostedDocDim."Dimension Value Code");
                //    IF DimVal.FINDFIRST THEN
                //      TipoVenta := DimVal.Name;
                //  END;

                recDimEntry.RESET;
                recDimEntry.SETRANGE("Dimension Set ID", "Dimension Set ID");
                recDimEntry.SETRANGE("Dimension Code", 'TIPO_VENTA');
                IF recDimEntry.FINDFIRST THEN BEGIN
                    //TipoCliente := PostedDocDim."Dimension Value Code";
                    DimVal.RESET;
                    DimVal.SETRANGE("Dimension Code", recDimEntry."Dimension Code");
                    DimVal.SETRANGE(Code, recDimEntry."Dimension Value Code");
                    IF DimVal.FINDFIRST THEN
                        TipoCliente := DimVal.Name;
                END;


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
                        //NCFAnulados."Tipo Documento" := NCFAnulados."Tipo Documento"::"2";//AMS      //CPMCR-CEC+-
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
                /*
               //Numero Guia de Remision
               SSH.RESET;
               SSH.SETRANGE(SSH."Order No.","Order No.");
               IF SSH.FINDFIRST THEN
                 NoGuia := SSH."Serie Remision" + '-'+SSH."No. Comprobante Fisc. Remision"
               ELSE
                 NoGuia := '';
               */

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
                /*
                // --------------------------------------- Codigo Dynasoft --------------------------------------------
                //INICIO #1379
                FormaPagoTPV := "Sales Invoice Header"."Forma de Pago TPV";
                IF rLocFormaPagoTPV.Devolucion THEN
                  FormaPagoTPV := 'N/C'
                ELSE
                  IF rLocFormaPagoTPV.GET("Forma de Pago TPV") THEN BEGIN
                    CASE rLocFormaPagoTPV."Forma Pago Agrupacion" OF
                      rLocFormaPagoTPV."Forma Pago Agrupacion"::Efectivo             : FormaPagoTPV := 'Efectivo';
                      rLocFormaPagoTPV."Forma Pago Agrupacion"::Cheque               : FormaPagoTPV := 'Ch';
                      rLocFormaPagoTPV."Forma Pago Agrupacion"::"Tarjeta de Credito" : FormaPagoTPV := 'T/C';
                      rLocFormaPagoTPV."Forma Pago Agrupacion"::"Tarjeta de Debito"  : FormaPagoTPV := 'T/D';
                    END;
                  END;
                IF FormaPagoTPV = 'CHEQUE' THEN FormaPagoTPV := 'Ch';
                //FIN #1379
                */

                PTPV.RESET;
                PTPV.SETRANGE("No. Borrador", "Order No.");
                PTPV.SETRANGE("No. Factura", "No.");
                PTPV.SETRANGE(Cambio, TRUE);
                IF PTPV.FINDFIRST THEN
                    FormaPagoTPV := PTPV."Forma pago TPV";

                VatEntry.RESET;
                VatEntry.SETRANGE("Document No.", "No.");
                IF VatEntry.FINDSET THEN
                    REPEAT
                        IF VatEntry.Amount <> 0 THEN
                            Grabado += VatEntry.Base
                        ELSE
                            Exento += VatEntry.Base
                    UNTIL VatEntry.NEXT = 0;

                PTPV.RESET;
                PTPV.SETRANGE("No. Factura", "No.");
                IF PTPV.FINDSET THEN
                    REPEAT
                        IF PTPV.Cambio THEN
                            Cambio := PTPV.Importe
                        ELSE
                            Recibe += PTPV.Importe
                    UNTIL PTPV.NEXT = 0;

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
        Text001: Label 'Page %1';
        Text002: Label 'Total %1';
        txt004: Label '(*) IVA';
        txt005: Label 'SON';
        Text000: Label 'COPY';
        FechaCaptionLbl: Label 'Fecha: ';
        No__de_Cliente___CaptionLbl: Label 'Cliente : ';
        VendedorCaptionLbl: Label 'Telefono:';
        RUC_CaptionLbl: Label 'RUC:';
        EntregarCaptionLbl: Label 'CAJA : ';
        Cantidad_EnviadaLbl: Label 'Cant.';
        Cod_ProductoCaptionLbl: Label 'Codigo / Desc.';
        Precio_UnitarioCaptionLbl: Label 'Precio Uni.';
        Pct_DescCaptionLbl: Label '% Desc';
        Importe_LineaLbl: Label 'TOTAL';
        Desc_ProductoCaptionLbl: Label 'Desc_Producto';
        F__Pago_CaptionLbl: Label 'F. Pago:';
        Total_CaptionLbl: Label 'Total ';
        IVA_12_CaptionLbl: Label 'IVA 12%';
        DESCUENTOCaptionLbl: Label 'Tot. Desc.:';
        SUBTOTALCaptionLbl: Label 'SUBTOTAL';
        TOTALCaptionLbl: Label 'No. Items : ';
        Tarifa_IVA_12____CaptionLbl: Label 'Tarifa IVA 12% : ';
        Tarifa_IVA_0____CaptionLbl: Label 'Tarifa IVA 0% : ';
        Cambio__CaptionLbl: Label 'Cambio: ';
        Recibe__CaptionLbl: Label 'Recibe: ';
        SCL: Record 44;
        ArchiveSH: Record 5107;
        ArchiveSL: Record 5108;
        SalesShptLine: Record 111;
        VatEntry: Record 254;
        Currency: Record 4;
        rEmpresa: Record 79;
        rCliente: Record 18;
        ConfSantillana: Record 55226;
        ConfigLinRep: Record 55227;
        PTPV: Record 34002521;
        FPTPV: Record 34002513;
        Vendedor_Comprador: Record 13;
        rPais: Record 9;
        ChkTransMgt: Report 10400;
        PT: Record 3;
        GLSetUp: Record 98;
        NCFAnulados: Record 34003012;
        CLE: Record 21;
        SSH: Record 110;
        SIL: Record 113;
        Loc: Record 14;
        DimVal: Record 349;
        Cust: Record 18;
        PostCodes: Record 225;
        Customer: Record 18;
        //TODO: Tabla no existe ICR: Record 5717;
        ConfSant: Record 55226;
        recDimEntry: Record 480;
        NoSeriesMgt: Codeunit "No. Series";
        SalesInvPrinted: Codeunit 315;

        wDiv: Code[10];
        VendorName: Text[50];
        vPais: Text[50];
        Comentario: Text[1024];
        DescriptionLine: array[2] of Text[250];
        CurrName: Text[30];
        txtIva: Text[30];
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
        ImporteSinCargos: Decimal;
        ImporteCargos: Decimal;
        DescuentoCargos: Decimal;
        CantENviada: Decimal;
        CantSolicitada: Decimal;
        Vendedor: Text[30];
        CodBarra: Code[20];
        LogInteraction: Boolean;
        Grabado: Decimal;
        Exento: Decimal;
        Cambio: Decimal;
        Recibe: Decimal;
        FormaPagoTPV: Text[30];
        recDim: Integer;

    procedure InitLogInteraction()
    begin
        //LogInteraction := SegManagement.FindInteractTmplCode(4) <> '';
    end;
}

