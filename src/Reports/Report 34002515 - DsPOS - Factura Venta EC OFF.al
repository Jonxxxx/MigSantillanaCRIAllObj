report 34002515 "DsPOS - Factura Venta EC OFF"
{
    DefaultLayout = RDLC;
    RDLCLayout = './DsPOS - Factura Venta EC OFF.rdlc';
    Permissions = TableData 21 = rm,
                  TableData 112 = rm,
                  TableData 7190 = rm,
                  TableData 34003012 = rim;

    dataset
    {
        dataitem("Sales Header"; 36)
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                ORDER(Ascending)
                                WHERE("Document Type" = CONST(Invoice));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.";
            column(Empresa_RUC; rEmpresa."VAT Registration No.")
            {
            }
            column(Tienda_Direccion_; rTiendas.Direccion)
            {
            }
            column(Tienda_Direccion_2; rTiendas."Direccion 2")
            {
            }
            column(Tienda_Telefono; rTiendas.Telefono)
            {
            }
            column(Sales_Invoice_Header__Posting_Date_; FORMAT("Posting Date"))
            {
            }
            column(TIME; FORMAT(TIME))
            {
            }
            column(Cabecera_CIF; "Sales Header"."VAT Registration No.")
            {
            }
            column(Cabecera__Direccion; "Bill-to Address")
            {
            }
            column(Cabecera_Nombre; "Sales Header"."Bill-to Name")
            {
            }
            column(Cabecera_Telefono; "Sales Header"."No. Telefono")
            {
            }
            column(Cabecera_Email; "Sales Header"."E-Mail")
            {
            }
            column(Cabecera_Cajero; "Sales Header"."ID Cajero")
            {
            }
            column(Sales_Invoice_Header_TPV; TPV)
            {
            }
            column(Sales_Invoice_Header__No__Comprobante_Fiscal_; "No. Comprobante Fiscal")
            {
            }
            column(Sales_Invoice_Header__User_ID_2; FORMAT(TODAY))
            {
            }
            column(CodDivLocalFormateada; CodDiv + ' ' + FORMAT(TotFactura, 0, '<Precision,2:2><Standard format,0>'))
            {
                DecimalPlaces = 2 : 2;
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
            column(ABS_Exento_; ABS(Exento))
            {
            }
            column(ABS_Grabado_; ABS(Grabado))
            {
                DecimalPlaces = 0 : 2;
            }
            column(FechaCaption; FechaCaptionLbl)
            {
            }
            column(No__de_Cliente___Caption; No__de_Cliente___CaptionLbl)
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
            column(Sales_Invoice_Header_No_; "No.")
            {
            }
            dataitem("Sales Line"; 37)
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               Document No.=FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
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
                    ICR.SETRANGE(ICR."Item No.", "No.");
                    ICR.SETRANGE(ICR."Unit of Measure", "Unit of Measure");
                    IF NOT ICR.FINDFIRST THEN BEGIN
                        ICR.RESET;
                        ICR.SETRANGE(ICR."Item No.", "No.");
                        IF ICR.FINDFIRST THEN
                            CodBarra := ICR."Cross-Reference No."
                        ELSE
                            CodBarra := ''
                    END;
                end;

                trigger OnPostDataItem()
                begin
                    Grabado := 0;
                    Exento := 0;
                end;
            }
            dataitem("Pagos TPV"; 34002521)
            {
                DataItemLink = "No. Borrador" = FIELD("No.");
                DataItemTableView = WHERE(Cambio = CONST(false));
                column(Forma_pago_PagosTPV_; "Forma pago TPV")
                {
                }
                column(Divisapago_PagosTPV_; CodDivPago + ':')
                {
                }
                column(Importe_PagosTPV_; Importe)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    IF "Cod. divisa" = '' THEN
                        CodDivPago := GLSetUp."LCY Code"
                    ELSE
                        CodDivPago := "Cod. divisa";
                end;
            }
            dataitem(Cambio; 34002521)
            {
                DataItemLink = "No. Borrador" = FIELD("No.");
                DataItemTableView = WHERE(Cambio = CONST(true));
                column(Forma_pago_Cambio_; 'Cambio')
                {
                }
                column(Divisapago_Cambio_; CodDivPago + ':')
                {
                }
                column(Importe_Cambio_; Importe)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    IF "Cod. divisa" = '' THEN
                        CodDivPago := GLSetUp."LCY Code"
                    ELSE
                        CodDivPago := "Cod. divisa";
                end;
            }

            trigger OnAfterGetRecord()
            var
                rLocFormaPagoTPV: Record 34002513;
            begin

                rTiendas.GET(Tienda);

                Comentario := '';
                iBruto := 0;
                ImporteCargos := 0;
                ImporteSinCargos := 0;
                DescuentoCargos := 0;
                CantENviada := 0;
                CantSolicitada := 0;
                igv := 0;

                rCliente.GET("Sell-to Customer No.");

                IF "Currency Code" <> '' THEN BEGIN
                    Currency.GET("Currency Code");
                    CurrName := Currency.Description;
                    CodDiv := "Currency Code";
                END
                ELSE BEGIN
                    CurrName := GLSetUp."Nombre Divisa Local";
                    CodDiv := GLSetUp."LCY Code";
                END;

                CALCFIELDS(Amount, "Amount Including VAT");

                IF "Amount Including VAT" - Amount <> 0 THEN
                    txtIva := txt004
                ELSE
                    txtIva := '';

                ChkTransMgt.FormatNoText(DescriptionLine, "Amount Including VAT", 2058, "Currency Code");

                TotFactura := "Amount Including VAT";


                recSalesLine.RESET;
                recSalesLine.SETRANGE("Document Type", "Document Type");
                recSalesLine.SETRANGE("Document No.", "No.");
                recSalesLine.SETFILTER(Type, '<>%1', recSalesLine.Type::"Charge (Item)");
                IF recSalesLine.FINDSET THEN
                    REPEAT
                        ImporteSinCargos += recSalesLine.Amount + recSalesLine."Line Discount Amount";
                        Descuento += recSalesLine."Line Discount Amount";
                        CantENviada += recSalesLine.Quantity;
                        igv += recSalesLine."Amount Including VAT" - recSalesLine.Amount;

                        IF recSalesLine."VAT %" <> 0 THEN
                            Grabado += recSalesLine."VAT Base Amount"
                        ELSE
                            Exento += recSalesLine."VAT Base Amount"

                    UNTIL recSalesLine.NEXT = 0;


                IF Cust.GET("Sell-to Customer No.") THEN
                    Nombre := UPPERCASE(Cust.Name);
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
        ConfSantillana: Record 56001;
        ConfigLinRep: Record 56002;
        _ArchiveSH: Record 5107;
        _ArchiveSL: Record 5108;
        _SalesShptLine: Record 111;
        recSalesLine: Record 37;
        VatEntry: Record 254;
        Currency: Record 4;
        rEmpresa: Record 79;
        rCliente: Record 18;
        rPais: Record 9;
        ChkTransMgt: Report 10400;
        GLSetUp: Record 98;
        Cust: Record 18;
        Customer: Record 18;
        ICR: Record 5717;
        ConfSant: Record 56001;
        recDimEntry: Record 480;
        NoSeriesMgt: Codeunit 396;
        SalesInvPrinted: Codeunit 315;
        SegManagement: Codeunit 5051;
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
        CodBarra: Code[20];
        LogInteraction: Boolean;
        Grabado: Decimal;
        Exento: Decimal;
        rTiendas: Record 34002503;
        CodDivPago: Code[20];
}

