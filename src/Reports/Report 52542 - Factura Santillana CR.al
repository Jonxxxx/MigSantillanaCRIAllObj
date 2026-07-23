report 52542 "Factura Santillana CR"
{
    // #4186   30/09/2014      PLB           Se ha creado la opcion de poder imprimir las lineas por el ranking de ubicacion
    // 
    // MOI - 12/12/2014: Se añade la direccion y los comentarios en el footer del layout.
    //                   Se añaden los TextConstants para direccion y comentarios en el footer.
    // MOI - 12/02/2015: Se buscan todos los comentarios y se concatenan para mostrarlos.
    DefaultLayout = RDLC;
    RDLCLayout = './Factura Santillana CR.rdlc';


    dataset
    {
        dataitem("Sales Invoice Header"; 112)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.", "Sell-to Customer No.";
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
            column(Sales_Invoice_Header__Tipo_pedido_; "Venta TPV")
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
            column(Clave; Clave)
            {
            }
            column(Consecutivo; Consecutivo)
            {
            }
            column(Estado; Estado)
            {
            }
            column(Mensaje; Mensaje)
            {
            }
            column(FechaDocElectronico; "Fecha Doc Electronico")
            {
            }
            column(EmailFE; "E-Mail-FE")
            {
            }
            dataitem("Sales Invoice Line"; 113)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");
                column(CrossReferenceNo_SalesInvoiceLine; "Sales Invoice Line"."Cross-Reference No.")
                {
                }
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

                trigger OnAfterGetRecord()
                begin
                    IF (Type = Type::Item) AND (Quantity = 0) THEN
                        CurrReport.SKIP;
                    //Muestras
                    IF ("Sales Invoice Header"."Tipo de Venta" = "Sales Invoice Header"."Tipo de Venta"::Muestras) AND (Amount = 0) THEN BEGIN
                        //  Quantity :=1;
                        "Unit Price" := 0.01;
                        Amount := Quantity * "Unit Price";
                        "Amount Including VAT" := Amount;
                        TotalMuestra += Amount;
                    END;
                    //Muestras

                    //Codigo de barra
                    IF Type = Type::Item THEN BEGIN
                        Referencia.RESET;
                        Referencia.SETRANGE("Item No.", "No.");
                        Referencia.SETRANGE("Cross-Reference Type", 3);
                        IF Referencia.FINDFIRST THEN
                            "No." := Referencia."Cross-Reference No.";
                    END;
                    //Codigo de barra
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
            begin

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

                ChkTransMgt.FormatNoText(DescriptionLine, "Amount Including VAT", 2058, "Currency Code");

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
        TotalMuestra: Decimal;
        Referencia: Record 5717;
}

