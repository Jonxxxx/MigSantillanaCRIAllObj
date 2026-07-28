report 34002514 "DsPOS - Ticket Venta BOL OFF"
{
    // #6079   PLB   31/10/2014   Desplazar el informe 3 milimetros hacia abajo
    //                            Desplazar la columna de los importes 3 milimetros a la izquierda
    //                            Mostrar las descripciones siempre en mayusculas
    // 
    // #5996   PLB   07/11/2014   Generar y mostrar Codigo QR
    // 
    // MOI - 09/12/2014 (#6935): Se a´Š¢ade el codigo de sucursal a la cabecera de la factura.
    //                           El codigo de sucursal se obtiene de la tabla Almacen y est´Š¢ como sentencia en el layout.
    // 
    // Proyecto: Microsoft Dynamics Nav
    // ------------------------------------------------------------------------------
    // FES   : Fausto Serrata
    // ------------------------------------------------------------------------------
    // No.             Firma         Fecha           Descripcion
    // ------------------------------------------------------------------------------
    // CPMCR-CEC       FES           08-06-2021      Comentario por migracion Costa Rica. Corregir error compilacion.
    DefaultLayout = RDLC;
    RDLCLayout = './DsPOS - Ticket Venta BOL OFF.rdlc';

    Permissions = TableData 21 = rm,
                  TableData 112 = rm,
                  TableData 7190 = rm,
                  TableData 34003012 = rim;

    dataset
    {
        dataitem("Sales Invoice Header"; 36)
        {
            CalcFields = "Amount Including VAT";
            DataItemTableView = SORTING("Document Type", "No.")
                                ORDER(Ascending)
                                WHERE("Document Type" = CONST(Invoice));
            RequestFilterFields = "No.", "Sell-to Customer No.";
            column(Emisor_1_; UPPERCASE(rEmpresa.Name))
            {
            }
            column(Emisor_2_; UPPERCASE(rTPV.Descripcion))
            {
            }
            column(Emisor_3_; UPPERCASE(rTPV.Direccion))
            {
            }
            column(Emisor_4_; UPPERCASE('Telefono: ' + rTPV.Telefono))
            {
            }
            column(Emisor_5_; Loc.City + ' - ' + Pais.Name)
            {
            }
            column(NIT_; 'NIT: ' + rTPV."No. Identificacion Fiscal")
            {
            }
            column(FacturaNo_; 'Factura No.: ' + NoFacFiscal)
            {
            }
            column(FechayHora_; FORMAT("Order Date") + ' ' + FORMAT("Hora creacion"))
            {
            }
            column(Sales_Invoice_Header__Bill_to_Name_; 'Se´Š¢or(es): ' + "Bill-to Name")
            {
            }
            column(Ruc_Cliente; 'NIT/CI Cliente: ' + "VAT Registration No.")
            {
            }
            column(CodDiv_; CodDiv)
            {
            }
            column(NombreVendedor_; 'VENDEDOR(a): ' + VendorName)
            {
            }
            column(NombreCajero_; 'CAJERO(a): ' + NombreCajero)
            {
            }
            column(DescriptionLine_1_____________CurrName; DescriptionLine[1] + ' ' + NombreDiv)
            {
            }
            column(Serie_Factura_________No__Comprobante_Fiscal_; 'Codigo de control: ' + "No. Comprobante Fiscal")
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
            dataitem("Sales Invoice Line"; 37)
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               Document No.=FIELD("No.");
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
            dataitem("Pagos TPV"; 34002521)
            {
                DataItemLink = "No. Borrador" = FIELD("No.");
                DataItemTableView = WHERE(Cambio = CONST(false));
                column(Forma_pago_PagosTPV_; "Forma pago TPV" + '  ' + CodDivPago + ':')
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
                column(Forma_pago_Cambio_; "Forma pago TPV" + '  ' + CodDiv + ':')
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
                    SIL.SETRANGE("Document Type", "Document Type");
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


                SCL.SETRANGE("Document Type", SCL."Document Type"::Invoice);
                SCL.SETRANGE("No.", "No.");

                IF SCL.FINDFIRST THEN
                    Comentario := SCL.Comment;

                CALCFIELDS(Amount, "Amount Including VAT");

                IF "Amount Including VAT" - Amount <> 0 THEN
                    txtIva := txt004
                ELSE
                    txtIva := '';

                //ChkTransMgt.FormatNoText(DescriptionLine,"Amount Including VAT",2058,"Currency Code");
                //TotFactura := "Amount Including VAT";

                IF Cust.GET("Sell-to Customer No.") THEN
                    Nombre := UPPERCASE(Cust.Name);

                IF PostCodes.GET("Sell-to Post Code", "Sell-to City") THEN BEGIN
                    Provincia := PostCodes.County;
                    Departamento := PostCodes.Colonia;
                END;
                PuntoLlegada := "Sell-to Address" + ', ' + "Sell-to City" + ', ' + Provincia + ', ' + Departamento;

                SCL.SETRANGE("Document Type", SCL."Document Type"::Invoice);
                SCL.SETRANGE("No.", "No.");
                IF SCL.FINDFIRST THEN;

                //Lineas de Venta
                I := 0;
                wTotalDescuento := 0;
                ImporteTotal := 0;

                SIL.RESET;
                SIL.SETRANGE("Document Type", "Document Type");
                SIL.SETRANGE("Document No.", "No.");
                SIL.SETFILTER(Quantity, '<>%1', 0);
                SIL.SETFILTER(Type, '<>%1', SIL.Type::"Charge (Item)");
                IF SIL.FINDSET THEN
                    REPEAT
                        I += 1;
                        CodProd_Arr[I] := SIL."No.";
                        Cantidad_Arr[I] := SIL.Quantity;
                        //Desc_Arr[I]      := SIL.Description; //-#6079
                        Desc_Arr[I] := UPPERCASE(SIL.Description); //+#6079
                        PrecUnit_Arr[I] := SIL."Unit Price";
                        Imp_Arr[I] := SIL."Amount Including VAT";
                        PorcDto_Arr[I] := SIL."Line Discount %";
                        ImpDesc_Arr[I] := SIL."Line Discount Amount";

                        ImporteTotal += Imp_Arr[I];
                        wTotalDescuento += ImpDesc_Arr[I];

                        //IVA
                        //Columna1IVA := 0;
                        //Columna2Iva := 0;
                        ColumnaExe := 0;
                        Columna1IVABase := 0;
                        Columna2IvaBase := 0;
                        ColumnaExeBase := 0;

                        ConfSant.GET;
                    UNTIL SIL.NEXT = 0;


                ChkTransMgt.FormatNoText(DescriptionLine, ImporteTotal, 2058, "Currency Code");
                TotFactura := ImporteTotal;

                //FuncBolv.CodigoQrEnBorrador("Sales Invoice Header", SalesInvHeader); //+#5996  /CPMCR-CEC+-

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
        SIL: Record 37;
        SCL: Record 44;
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
        ConfSant: Record 56001;
        Loc: Record 14;
        DimVal: Record 349;
        Cust: Record 18;
        PostCodes: Record 225;
        Customer: Record 18;
        CLE: Record 21;
        SSH: Record 110;
        ICR: Record 5717;
        VatPostSet: Record 325;
        VatProdPostGrp: Record 324;
        SalesInvHeader: Record 112;
        NoSeriesMgt: Codeunit 396;
        SegManagement: Codeunit 5051;
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
        CodDivPago: Code[20];
        NombreCajero: Text[100];
}

