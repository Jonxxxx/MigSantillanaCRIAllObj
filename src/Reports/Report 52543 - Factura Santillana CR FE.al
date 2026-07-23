report 52543 "Factura Santillana CR FE"
{
    // #4186   30/09/2014      PLB           Se ha creado la opcion de poder imprimir las lineas por el ranking de ubicacion
    // 
    // MOI - 12/12/2014: Se añade la direccion y los comentarios en el footer del layout.
    //                   Se añaden los TextConstants para direccion y comentarios en el footer.
    // MOI - 12/02/2015: Se buscan todos los comentarios y se concatenan para mostrarlos.
    // 001   YFC   17/08/2022    SANTINAV-2745: Ajustes
    // 002   SSM   04/09/2025    SANTINAV-8512: Ajustes
    // 003   LDP   19/10/2025    SANTINAV-8697: Problema con codigo QR en facturas electronicas ã Costa Rica
    // 004   LDP   24/11/2025    SANTINAV-8776: Error descripcion Facturacion Electronica
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/Factura Santillana CR FE.rdlc';


    dataset
    {
        dataitem("Sales Invoice Header"; 112)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.";
            column(Salesperson_Code________VendorName; "Salesperson Code" + ' ' + VendorName)
            {
            }
            column(Sales_Invoice_Header__No__; "No.")
            {
            }
            column(Sales_Invoice_Header__Payment_Terms_Code_; "Payment Terms Code")
            {
            }
            column(Sales_Invoice_Header__Order_No__; "Order No.")
            {
            }
            column(Sales_Invoice_Header__Sales_Invoice_Header___Bill_to_Name_; "Sales Invoice Header"."Bill-to Name")
            {
            }
            column(Sell_to_City____________Sell_to_County____________Sell_to_Post_Code_; "Sell-to City" + ', ' + "Sell-to County" + ', ' + "Sell-to Post Code")
            {
            }
            column(rCliente__Phone_No____________rCliente__Fax_No__; rCliente."Phone No." + ', ' + rCliente."E-Mail 2")
            {
            }
            column(Sales_Invoice_Header__VAT_Registration_No__; "VAT Registration No.")
            {
            }
            column(Sales_Invoice_Header__Sales_Invoice_Header___Bill_to_Address_; "Sales Invoice Header"."Bill-to Address")
            {
            }
            column(Sales_Invoice_Header__Posting_Date_; "Posting Date")
            {
            }
            column(Sales_Invoice_Header__Due_Date_; "Due Date")
            {
            }
            column(Sales_Invoice_Header__Sell_to_Customer_No__; "Sell-to Customer No.")
            {
            }
            column(PEDIDO_Caption; PEDIDO_CaptionLbl)
            {
            }
            column(ASESOR_Caption; ASESOR_CaptionLbl)
            {
            }
            column(PAGO_Caption; PAGO_CaptionLbl)
            {
            }
            column(CEDULA_JURIDICA_Caption; CEDULA_JURIDICA_CaptionLbl)
            {
            }
            column(TIPO_PEDIDO_Caption; TIPO_PEDIDO_CaptionLbl)
            {
            }
            column(VENCE_Caption; VENCE_CaptionLbl)
            {
            }
            column(DireccionCaption; DireccionCaptionLbl)
            {
            }
            column(ComentarioCaption; ComentarioCaptionLbl)
            {
            }
            column(Comentario; Comentario)
            {
            }
            column(Comentario2; "Ship-to Address" + ', ' + "Ship-to Address 2")
            {
            }
            column(Clave; Clave)
            {
            }
            column(Consecutivo; Consecutivo)
            {
            }
            column(Picture; rEmpresa.Picture)
            {
            }
            column(Email; "E-Mail-FE")
            {
            }
            column(Direccion; "Sell-to Customer Name 2")
            {
            }
            column(QRCode; "QR Code FE")
            {
            }
            column(NoTelefono_SalesInvoiceHeader; "Sales Invoice Header"."No. Telefono")
            {
            }
            column(ExternalDocumentNo_SalesInvoiceHeader; "Sales Invoice Header"."External Document No.")
            {
            }
            column(Compartir; Compartir)
            {
            }
            column(CodCategoria1; CodCategoria[1])
            {
            }
            column(CodCategoria2; CodCategoria[2])
            {
            }
            column(CodCategoria3; CodCategoria[3])
            {
            }
            column(DescCategoria1; DescCategoria[1])
            {
            }
            column(DescCategoria2; DescCategoria[2])
            {
            }
            column(DescCategoria3; DescCategoria[3])
            {
            }
            column(Cantidad1; Cantidad[1])
            {
            }
            column(Cantidad2; Cantidad[2])
            {
            }
            column(Cantidad3; Cantidad[3])
            {
            }
            column(Unitario1; Unitario[1])
            {
            }
            column(Unitario2; Unitario[2])
            {
            }
            column(Unitario3; Unitario[3])
            {
            }
            column(Total1; Total[1])
            {
            }
            column(Total2; Total[2])
            {
            }
            column(Total3; Total[3])
            {
            }
            column(PorcentajeDescuento1; PorcentajeDescuento[1])
            {
            }
            column(PorcentajeDescuento2; PorcentajeDescuento[2])
            {
            }
            column(PorcentajeDescuento3; PorcentajeDescuento[3])
            {
            }
            column(Importe1; Importe[1])
            {
            }
            column(Importe2; Importe[2])
            {
            }
            column(Importe3; Importe[3])
            {
            }
            column(TotalNeto1; TotalNeto[1])
            {
            }
            column(TotalNeto2; TotalNeto[2])
            {
            }
            column(TotalNeto3; TotalNeto[3])
            {
            }
            dataitem("Sales Invoice Line"; 113)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");
                UseTemporary = false;
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
                column(Quantity____Unit_Price_; Quantity * "Unit Price")
                {
                }
                column(Sales_Invoice_Line__Line_Discount___; "Line Discount %")
                {
                    DecimalPlaces = 2 : 2;
                }
                column(Sales_Invoice_Line__Line_Discount_Amount_; "Line Discount Amount")
                {
                    DecimalPlaces = 0 : 2;
                }
                column(Sales_Invoice_Line_Quantity; Quantity)
                {
                }
                column(Sales_Invoice_Line__Line_Discount_Amount__Control1000000040; "Line Discount Amount")
                {
                }
                column(Amount_Including_VAT____Amount; "Amount Including VAT" - Amount)
                {
                    DecimalPlaces = 0 : 2;
                }
                column(Sales_Invoice_Line__Amount_Including_VAT__Control1000000054; "Amount Including VAT")
                {
                    DecimalPlaces = 0 : 2;
                }
                column(Sales_Invoice_Line_Amount; Amount)
                {
                }
                column(Description_Text_No_to_Letter; DescriptionLine[1] + '  ' + CurrName)
                {
                }
                column(Sales_Invoice_Line_Amount_Control1000000012; Amount)
                {
                    DecimalPlaces = 0 : 2;
                }
                column(Amount_Including_VAT____Amount_Control1000000014; "Amount Including VAT" - Amount)
                {
                    DecimalPlaces = 0 : 2;
                }
                column(Amount____Line_Discount_Amount_; Amount + "Line Discount Amount")
                {
                }
                column(txtIva; txtIva)
                {
                }
                column(SUBTOTALCaption; SUBTOTALCaptionLbl)
                {
                }
                column(Sales_Invoice_Line_Document_No_; "Document No.")
                {
                }
                column(Sales_Invoice_Line_Line_No_; "Line No.")
                {
                }
                column(Sales_Invoice_Line_Compartir; Compartir)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF (Type = Type::Item) AND (Quantity = 0) THEN
                        CurrReport.SKIP;

                    //Muestras
                    IF ("Sales Invoice Header"."Tipo de Venta" = "Sales Invoice Header"."Tipo de Venta"::Muestras) AND (Amount = 0) THEN BEGIN
                        //Quantity := 1;
                        "Unit Price" := 0.01;
                        Amount := Quantity * "Unit Price";
                        "Amount Including VAT" := Amount;
                        TotalMuestra += Amount;
                    END;
                    //Muestras

                    //Codigo de barra
                    IF Type = Type::Item THEN BEGIN
                        //TODO: no existe Referencia.RESET;
                        //TODO: no existe Referencia.SETRANGE("Item No.", "No.");
                        //TODO: no existe Referencia.SETRANGE("Cross-Reference Type", 3);
                        //TODO: no existe IF Referencia.FINDFIRST THEN
                        //TODO: no existe "No." := Referencia."Cross-Reference No.";
                    END;
                    //Codigo de barra

                    /*
                    IF "Sales Invoice Header"."Categoria Pedido Venta" <> 'COMPARTIR' THEN BEGIN//004+ //Prueba
                      //002-
                      // ++ 001-YFC
                      CategoriaPedidoVenta.GET("Sales Invoice Header"."Categoria Pedido Venta");
                      IF CategoriaPedidoVenta."Filtrar Cod. Compartir" THEN BEGIN // -- 001-YFC
                        //*****************************************
                        IF ConfSant.GET THEN;
                        CASE "Sales Invoice Line".Compartir OF
                          "Sales Invoice Line".Compartir::Libros :
                            BEGIN
                              "No.":= ConfSant."Codigo Libro";
                              Description  := 'LIBROS';
                            END;
                          "Sales Invoice Line".Compartir::Aulas :
                            BEGIN
                              "No.":=ConfSant."Codigo Aulas";
                              Description  := 'AULAS';
                            END;
                          "Sales Invoice Line".Compartir::Servicios :
                            BEGIN
                              "No.":=ConfSant."Codigo Servicio";
                              Description  := 'SERVICIO';
                            END;
                          END;
                        //*****************************************
                      END;
                      //001-YFC
                      //002-
                    //END//004+-
                    */

                end;

                trigger OnPostDataItem()
                begin
                    IF ("Sales Invoice Header"."Tipo de Venta" = "Sales Invoice Header"."Tipo de Venta"::Muestras) THEN BEGIN
                        "Sales Invoice Header".Amount := TotalMuestra;
                        "Sales Invoice Header"."Amount Including VAT" := TotalMuestra;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    //+999
                    IF Order = Order::Ranking THEN
                        SETCURRENTKEY("Bin Ranking");
                    //-999

                    CurrReport.CREATETOTALS("Unit Price", "Line Discount Amount", "Amount Including VAT");
                end;
            }

            trigger OnAfterGetRecord()
            var
                QRCodeInput: Code[20];
                FE: Codeunit 52504;
                TempBlob: Codeunit "Temp Blob";
            begin
                IF NOT "QR Code FE".HASVALUE THEN
                    FunSan.CreaQRFE("No.");//003+-

                CALCFIELDS("QR Code FE");

                rCliente.GET("Sell-to Customer No.");

                IF "Sales Invoice Header"."Currency Code" <> '' THEN BEGIN
                    Currency.GET("Currency Code");
                    CurrName := Currency.Description;
                END
                ELSE
                    CurrName := Text003;

                IF Vendedor_Comprador.GET("Salesperson Code") THEN
                    VendorName := Vendedor_Comprador.Name;

                //IF "Currency Code" <> '' THEN
                //  wDiv := "Currency Code";
                //ELSE
                //  wDiv := 'RD$';

                CALCFIELDS("Amount Including VAT");
                CALCFIELDS(Amount);
                IF "Amount Including VAT" - Amount <> 0 THEN
                    txtIva := txt004
                ELSE
                    txtIva := '';

                //TODO: no existe ChkTransMgt.FormatNoText(DescriptionLine, "Amount Including VAT", 2058, "Currency Code");

                //MOI - 12/02/2015:Inicio
                CLEAR(Comentario);
                SCL.RESET;
                //"Document Type","No.","Document Line No.","Line No."
                SCL.SETRANGE(SCL."Document Type", SCL."Document Type"::"Posted Invoice");
                SCL.SETRANGE(SCL."No.", "Sales Invoice Header"."No.");
                SCL.SETRANGE(SCL."Document Line No.", 0);
                IF SCL.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                        Comentario += SCL.Comment;
                    UNTIL SCL.NEXT = 0;
                //MOI - 12/02/2015:Fin

                CLEAR(CodCategoria);
                CLEAR(DescCategoria);

                //004+
                //002+
                //IF "Sales Invoice Header"."Categoria Pedido Venta" = 'Compartir' THEN BEGIN
                CategoriaPedidoVenta.GET("Sales Invoice Header"."Categoria Pedido Venta");
                IF CategoriaPedidoVenta."Filtrar Cod. Compartir" THEN BEGIN
                    Compartir := TRUE;

                    SIL.RESET;
                    SIL.SETRANGE("Document No.", "No.");
                    IF SIL.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            CASE SIL.Compartir OF
                                SIL.Compartir::Libros:
                                    BEGIN
                                        IF CodCategoria[1] = '' THEN
                                            CodCategoria[1] := ConfSant."Codigo Libro";

                                        IF DescCategoria[1] = '' THEN
                                            DescCategoria[1] := 'LIBROS';

                                        Cantidad[1] += SIL.Quantity;
                                        Unitario[1] := SIL."Unit Price";
                                        Total[1] += SIL."Unit Price";
                                        PorcentajeDescuento[1] := SIL."Line Discount %";
                                        Importe[1] += SIL."Line Discount Amount";
                                        TotalNeto[1] += SIL."Amount Including VAT";
                                    END;
                                SIL.Compartir::Aulas:
                                    BEGIN
                                        IF CodCategoria[2] = '' THEN
                                            CodCategoria[2] := ConfSant."Codigo Aulas";

                                        IF DescCategoria[2] = '' THEN
                                            DescCategoria[2] := 'AULAS';

                                        Cantidad[2] += SIL.Quantity;
                                        Unitario[2] := SIL."Unit Price";
                                        Total[2] += SIL."Unit Price";
                                        PorcentajeDescuento[2] := SIL."Line Discount %";
                                        Importe[2] += SIL."Line Discount Amount";
                                        TotalNeto[2] += SIL."Amount Including VAT";
                                    END;
                                SIL.Compartir::Servicios:
                                    BEGIN
                                        IF CodCategoria[3] = '' THEN
                                            CodCategoria[3] := ConfSant."Codigo Servicio";

                                        IF DescCategoria[3] = '' THEN
                                            DescCategoria[3] := 'SERVICIOS';

                                        Cantidad[3] += SIL.Quantity;
                                        Unitario[3] := SIL."Unit Price";
                                        Total[3] += SIL."Unit Price";
                                        PorcentajeDescuento[3] := SIL."Line Discount %";
                                        Importe[3] += SIL."Line Discount Amount";
                                        TotalNeto[3] += SIL."Amount Including VAT";
                                    END;
                            END;
                        UNTIL SIL.NEXT = 0;
                END;
                //002+
                //004+-
            end;

            trigger OnPostDataItem()
            begin
                DocNum := "No.";
            end;

            trigger OnPreDataItem()
            begin
                rEmpresa.GET();
                rEmpresa.CALCFIELDS(Picture);
                rPais.SETRANGE(Code, rEmpresa."Country/Region Code");
                rPais.FINDFIRST;
                vPais := rEmpresa.City + ', ' + rPais.Name + ' ' + rEmpresa."Post Code";
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(Order; Order)
                    {
                        Caption = 'Line Order';
                        OptionCaption = 'Normal,Bin Ranking';
                    }
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

    trigger OnPreReport()
    begin
        ConfSant.GET();
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
        //TODO: no existe ChkTransMgt: Report 10400;
        DescriptionLine: array[2] of Text[250];
        CurrName: Text[30];
        Text002: Label 'Total %1';
        Text003: Label 'QUETZALES';
        txtIva: Text[30];
        txt004: Label '(*) IVA';
        NoLineas: Integer;
        PEDIDO_CaptionLbl: Label 'PEDIDO:';
        ASESOR_CaptionLbl: Label 'ASESOR:';
        PAGO_CaptionLbl: Label 'PAGO:';
        CEDULA_JURIDICA_CaptionLbl: Label 'Cedula Juridica:';
        TIPO_PEDIDO_CaptionLbl: Label 'TIPO PEDIDO:';
        VENCE_CaptionLbl: Label 'VENCE:';
        SUBTOTALCaptionLbl: Label 'SUBTOTAL';
        "Order": Option Normal,Ranking;
        DireccionCaptionLbl: Label 'Direccion: ';
        ComentarioCaptionLbl: Label 'Comentarios: ';
        //TODO: no existe Referencia: Record 5717;
        TotalMuestra: Decimal;
        View_SalesInvoiceLine: Query 50000;
        Number: Integer;
        DocNum: Code[20];
        Contador: Integer;
        Codigo: Code[20];
        Descripcion: Text;
        ConfSant: Record 56001;
        CategoriaPedidoVenta: Record 52503;
        SIL: Record 113;
        CodCategoria: array[3] of Code[20];
        DescCategoria: array[3] of Text[100];
        Cantidad: array[3] of Decimal;
        Unitario: array[3] of Decimal;
        Total: array[3] of Decimal;
        PorcentajeDescuento: array[3] of Decimal;
        Importe: array[3] of Decimal;
        TotalNeto: array[3] of Decimal;
        FunSan: Codeunit 56000;
        Compartir: Boolean;
}

