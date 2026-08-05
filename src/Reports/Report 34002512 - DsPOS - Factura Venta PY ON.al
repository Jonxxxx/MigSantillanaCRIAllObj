report 55906 "DsPOS - Factura Venta PY ON"
{
    // Proyecto: Microsoft Dynamics Nav
    // ------------------------------------------------------------------------------
    // FES   : Fausto Serrata
    // ------------------------------------------------------------------------------
    // No.             Firma         Fecha           Descripcion
    // ------------------------------------------------------------------------------
    // CPMCR-CEC       FES           08-06-2021      Comentario por migracion Costa Rica. Corregir error compilacion.
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/DsPOS - Factura Venta PY ON.rdl';

    Caption = 'DsPOS - Factura Venta PY ON';
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
            RequestFilterFields = "No.", "Sell-to Customer No.";
            column(Sales_Invoice_Header__Bill_to_Customer_No__; DELCHR("Bill-to Customer No.", '<>'))
            {
            }
            column(Sales_Invoice_Header__Posting_Date_; FORMAT("Posting Date"))
            {
            }
            column(Sales_Invoice_Header__Bill_to_Name_; "Bill-to Name")
            {
            }
            column(Sales_Invoice_Header__Bill_to_Address_; "Bill-to Address" + ', ' + "Bill-to City" + ', ' + "Bill-to County")
            {
            }
            column(FechaVencimiento; FORMAT("Due Date"))
            {
            }
            column(TelCliente; Tel)
            {
            }
            column(Ruc_Cliente; "VAT Registration No.")
            {
            }
            column(rCliente__No_Factura; "No.")
            {
            }
            column(rCliente__No_Cliente; rCliente."No.")
            {
            }
            column(CodProd_Arr_1; CodProd_Arr[1])
            {
            }
            column(Cantidad_Arr_1; Cantidad_Arr[1])
            {
            }
            column(Desc_Arr_1; Desc_Arr[1])
            {
            }
            column(PrecUnit_Arr_1; PrecUnit_Arr[1])
            {
                DecimalPlaces = 2 : 2;
            }
            column(PorcDto_Arr_1; PorcDto_Arr[1])
            {
                DecimalPlaces = 2 : 2;
            }
            column(ImpDesc_Arr_1; ImpDesc_Arr[1])
            {
                DecimalPlaces = 2 : 2;
            }
            column(BaseExe_Arr_1; BaseExe_Arr[1])
            {
                DecimalPlaces = 2 : 2;
            }
            column(Iva1_Arr_1; Iva1_Arr[1])
            {
                DecimalPlaces = 2 : 2;
            }
            column(Iva2_Arr_1; Iva2_Arr[1])
            {
                DecimalPlaces = 0 : 2;
            }
            column(Iva2_Arr_2; Iva2_Arr[2])
            {
                DecimalPlaces = 0 : 2;
            }
            column(Iva1_Arr_2; Iva1_Arr[2])
            {
                DecimalPlaces = 2 : 2;
            }
            column(BaseExe_Arr_2; BaseExe_Arr[2])
            {
                DecimalPlaces = 2 : 2;
            }
            column(ImpDesc_Arr_2; ImpDesc_Arr[2])
            {
                DecimalPlaces = 2 : 2;
            }
            column(PorcDto_Arr_2; PorcDto_Arr[2])
            {
                DecimalPlaces = 2 : 2;
            }
            column(PrecUnit_Arr_2; PrecUnit_Arr[2])
            {
                DecimalPlaces = 2 : 2;
            }
            column(Desc_Arr_2; Desc_Arr[2])
            {
            }
            column(Cantidad_Arr_2; Cantidad_Arr[2])
            {
            }
            column(CodProd_Arr_2; CodProd_Arr[2])
            {
            }
            column(Iva2_Arr_3; Iva2_Arr[3])
            {
                DecimalPlaces = 0 : 2;
            }
            column(Iva1_Arr_3; Iva1_Arr[3])
            {
                DecimalPlaces = 2 : 2;
            }
            column(BaseExe_Arr_3; BaseExe_Arr[3])
            {
                DecimalPlaces = 2 : 2;
            }
            column(ImpDesc_Arr_3; ImpDesc_Arr[3])
            {
                DecimalPlaces = 2 : 2;
            }
            column(PorcDto_Arr_3; PorcDto_Arr[3])
            {
                DecimalPlaces = 2 : 2;
            }
            column(PrecUnit_Arr_3; PrecUnit_Arr[3])
            {
                DecimalPlaces = 2 : 2;
            }
            column(Desc_Arr_3; Desc_Arr[3])
            {
            }
            column(Cantidad_Arr_3; Cantidad_Arr[3])
            {
            }
            column(CodProd_Arr_3; CodProd_Arr[3])
            {
            }
            column(CodProd_Arr_4; CodProd_Arr[4])
            {
            }
            column(Cantidad_Arr_4; Cantidad_Arr[4])
            {
            }
            column(Desc_Arr_4; Desc_Arr[4])
            {
            }
            column(PrecUnit_Arr_4; PrecUnit_Arr[4])
            {
                DecimalPlaces = 2 : 2;
            }
            column(PorcDto_Arr_4; PorcDto_Arr[4])
            {
                DecimalPlaces = 2 : 2;
            }
            column(ImpDesc_Arr_4; ImpDesc_Arr[4])
            {
                DecimalPlaces = 2 : 2;
            }
            column(BaseExe_Arr_4; BaseExe_Arr[4])
            {
                DecimalPlaces = 2 : 2;
            }
            column(Iva1_Arr_4; Iva1_Arr[4])
            {
                DecimalPlaces = 2 : 2;
            }
            column(Iva2_Arr_4; Iva2_Arr[4])
            {
                DecimalPlaces = 2 : 2;
            }
            column(Iva2_Arr_5; Iva2_Arr[5])
            {
                DecimalPlaces = 0 : 2;
            }
            column(Iva1_Arr_5; Iva1_Arr[5])
            {
                DecimalPlaces = 2 : 2;
            }
            column(BaseExe_Arr_5; BaseExe_Arr[5])
            {
                DecimalPlaces = 2 : 2;
            }
            column(ImpDesc_Arr_5; ImpDesc_Arr[5])
            {
                DecimalPlaces = 2 : 2;
            }
            column(PorcDto_Arr_5; PorcDto_Arr[5])
            {
                DecimalPlaces = 2 : 2;
            }
            column(PrecUnit_Arr_5; PrecUnit_Arr[5])
            {
                DecimalPlaces = 2 : 2;
            }
            column(Desc_Arr_5; Desc_Arr[5])
            {
            }
            column(Cantidad_Arr_5; Cantidad_Arr[5])
            {
            }
            column(CodProd_Arr_5; CodProd_Arr[5])
            {
            }
            column(Iva2_Arr_6; Iva2_Arr[6])
            {
                DecimalPlaces = 0 : 2;
            }
            column(Iva1_Arr_6; Iva1_Arr[6])
            {
                DecimalPlaces = 2 : 2;
            }
            column(BaseExe_Arr_6; BaseExe_Arr[6])
            {
                DecimalPlaces = 2 : 2;
            }
            column(ImpDesc_Arr_6; ImpDesc_Arr[6])
            {
                DecimalPlaces = 2 : 2;
            }
            column(PorcDto_Arr_6; PorcDto_Arr[6])
            {
                DecimalPlaces = 2 : 2;
            }
            column(PrecUnit_Arr_6; PrecUnit_Arr[6])
            {
                DecimalPlaces = 2 : 2;
            }
            column(Desc_Arr_6; Desc_Arr[6])
            {
            }
            column(Cantidad_Arr_6; Cantidad_Arr[6])
            {
            }
            column(CodProd_Arr_6; CodProd_Arr[6])
            {
            }
            column(CodProd_Arr_7; CodProd_Arr[7])
            {
            }
            column(Cantidad_Arr_7; Cantidad_Arr[7])
            {
            }
            column(Desc_Arr_7; Desc_Arr[7])
            {
            }
            column(PrecUnit_Arr_7; PrecUnit_Arr[7])
            {
                DecimalPlaces = 2 : 2;
            }
            column(PorcDto_Arr_7; PorcDto_Arr[7])
            {
                DecimalPlaces = 2 : 2;
            }
            column(ImpDesc_Arr_7; ImpDesc_Arr[7])
            {
                DecimalPlaces = 2 : 2;
            }
            column(BaseExe_Arr_7; BaseExe_Arr[7])
            {
                DecimalPlaces = 2 : 2;
            }
            column(Iva1_Arr_7; Iva1_Arr[7])
            {
                DecimalPlaces = 2 : 2;
            }
            column(Iva2_Arr_7; Iva2_Arr[7])
            {
                DecimalPlaces = 0 : 2;
            }
            column(Iva2_Arr_8; Iva2_Arr[8])
            {
                DecimalPlaces = 0 : 2;
            }
            column(Iva1_Arr_8; Iva1_Arr[8])
            {
                DecimalPlaces = 2 : 2;
            }
            column(BaseExe_Arr_8; BaseExe_Arr[8])
            {
                DecimalPlaces = 2 : 2;
            }
            column(ImpDesc_Arr_8; ImpDesc_Arr[8])
            {
                DecimalPlaces = 2 : 2;
            }
            column(PorcDto_Arr_8; PorcDto_Arr[8])
            {
                DecimalPlaces = 2 : 2;
            }
            column(PrecUnit_Arr_8; PrecUnit_Arr[8])
            {
                DecimalPlaces = 2 : 2;
            }
            column(Desc_Arr_8; Desc_Arr[8])
            {
            }
            column(Cantidad_Arr_8; Cantidad_Arr[8])
            {
            }
            column(CodProd_Arr_8; CodProd_Arr[8])
            {
            }
            column(Iva2_Arr_9; Iva2_Arr[9])
            {
                DecimalPlaces = 0 : 2;
            }
            column(Iva1_Arr_9; Iva1_Arr[9])
            {
                DecimalPlaces = 2 : 2;
            }
            column(BaseExe_Arr_9; BaseExe_Arr[9])
            {
                DecimalPlaces = 2 : 2;
            }
            column(ImpDesc_Arr_9; ImpDesc_Arr[9])
            {
                DecimalPlaces = 2 : 2;
            }
            column(PorcDto_Arr_9; PorcDto_Arr[9])
            {
                DecimalPlaces = 2 : 2;
            }
            column(PrecUnit_Arr_9; PrecUnit_Arr[9])
            {
                DecimalPlaces = 2 : 2;
            }
            column(Desc_Arr_9; Desc_Arr[9])
            {
            }
            column(Cantidad_Arr_9; Cantidad_Arr[9])
            {
            }
            column(CodProd_Arr_9; CodProd_Arr[9])
            {
            }
            column(CodProd_Arr_10; CodProd_Arr[10])
            {
            }
            column(Cantidad_Arr_10; Cantidad_Arr[10])
            {
            }
            column(Desc_Arr_10; Desc_Arr[10])
            {
            }
            column(PrecUnit_Arr_10; PrecUnit_Arr[10])
            {
                DecimalPlaces = 2 : 2;
            }
            column(PorcDto_Arr_10; PorcDto_Arr[10])
            {
                DecimalPlaces = 2 : 2;
            }
            column(ImpDesc_Arr_10; ImpDesc_Arr[10])
            {
                DecimalPlaces = 2 : 2;
            }
            column(BaseExe_Arr_10; BaseExe_Arr[10])
            {
                DecimalPlaces = 2 : 2;
            }
            column(Iva1_Arr_10; Iva1_Arr[10])
            {
                DecimalPlaces = 2 : 2;
            }
            column(Iva2_Arr_10; Iva2_Arr[10])
            {
                DecimalPlaces = 0 : 2;
            }
            column(TotalEx; wtotalEx)
            {
                DecimalPlaces = 2 : 2;
            }
            column(TotalDescuento; wTotalDescuento)
            {
                DecimalPlaces = 2 : 2;
            }
            column(DescriptionLine_1_____________CurrName; DescriptionLine[1] + ' ** ')
            {
            }
            column(Iva1_Total; Columna1IVA)
            {
                DecimalPlaces = 2 : 2;
            }
            column(Iva2_Total; Columna2Iva)
            {
                DecimalPlaces = 2 : 2;
            }
            column(ImporteFinal; "Amount Including VAT")
            {
                DecimalPlaces = 0 : 2;
            }
            column(ImporteIVaTotal; "Amount Including VAT" - Amount)
            {
                DecimalPlaces = 0 : 2;
            }
            column(Sales_Invoice_Header__No__; "No.")
            {
            }
            column(rCliente__No__; rCliente."No.")
            {
            }
            column(FORMAT__Posting_Date__; FORMAT("Posting Date"))
            {
            }
            column(Sales_Invoice_Header__Bill_to_Name__Control1000000103; "Bill-to Name")
            {
            }
            column(Bill_to_Address__________Bill_to_City________Bill_to_County_; "Bill-to Address" + ', ' + "Bill-to City" + ', ' + "Bill-to County")
            {
            }
            column(FORMAT__Due_Date__; FORMAT("Due Date"))
            {
            }
            column(Tel; Tel)
            {
            }
            column(Sales_Invoice_Header__VAT_Registration_No__; "VAT Registration No.")
            {
            }
            column(DELCHR__Bill_to_Customer_No________; DELCHR("Bill-to Customer No.", '<>'))
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
            column(PorcDto_Arr_1_; PorcDto_Arr[1])
            {
            }
            column(ImpDesc_Arr_1_; ImpDesc_Arr[1])
            {
            }
            column(BaseExe_Arr_1_; BaseExe_Arr[1])
            {
            }
            column(BaseExe_Arr_2_; BaseExe_Arr[2])
            {
            }
            column(ImpDesc_Arr_2_; ImpDesc_Arr[2])
            {
            }
            column(PorcDto_Arr_2_; PorcDto_Arr[2])
            {
            }
            column(PrecUnit_Arr_2_; PrecUnit_Arr[2])
            {
            }
            column(Desc_Arr_2_; Desc_Arr[2])
            {
            }
            column(Cantidad_Arr_2_; Cantidad_Arr[2])
            {
            }
            column(CodProd_Arr_2_; CodProd_Arr[2])
            {
            }
            column(Iva1_Arr_1_; Iva1_Arr[1])
            {
            }
            column(Iva1_Arr_2_; Iva1_Arr[2])
            {
            }
            column(Iva1_Arr_3_; Iva1_Arr[3])
            {
            }
            column(BaseExe_Arr_3_; BaseExe_Arr[3])
            {
            }
            column(ImpDesc_Arr_3_; ImpDesc_Arr[3])
            {
            }
            column(PorcDto_Arr_3_; PorcDto_Arr[3])
            {
            }
            column(PrecUnit_Arr_3_; PrecUnit_Arr[3])
            {
            }
            column(Desc_Arr_3_; Desc_Arr[3])
            {
            }
            column(Cantidad_Arr_3_; Cantidad_Arr[3])
            {
            }
            column(CodProd_Arr_3_; CodProd_Arr[3])
            {
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
            column(PorcDto_Arr_4_; PorcDto_Arr[4])
            {
            }
            column(ImpDesc_Arr_4_; ImpDesc_Arr[4])
            {
            }
            column(BaseExe_Arr_4_; BaseExe_Arr[4])
            {
            }
            column(Iva1_Arr_4_; Iva1_Arr[4])
            {
            }
            column(Iva1_Arr_5_; Iva1_Arr[5])
            {
            }
            column(BaseExe_Arr_5_; BaseExe_Arr[5])
            {
            }
            column(ImpDesc_Arr_5_; ImpDesc_Arr[5])
            {
            }
            column(PorcDto_Arr_5_; PorcDto_Arr[5])
            {
            }
            column(PrecUnit_Arr_5_; PrecUnit_Arr[5])
            {
            }
            column(Desc_Arr_5_; Desc_Arr[5])
            {
            }
            column(Cantidad_Arr_5_; Cantidad_Arr[5])
            {
            }
            column(CodProd_Arr_5_; CodProd_Arr[5])
            {
            }
            column(Iva1_Arr_6_; Iva1_Arr[6])
            {
            }
            column(BaseExe_Arr_6_; BaseExe_Arr[6])
            {
            }
            column(ImpDesc_Arr_6_; ImpDesc_Arr[6])
            {
            }
            column(PorcDto_Arr_6_; PorcDto_Arr[6])
            {
            }
            column(PrecUnit_Arr_6_; PrecUnit_Arr[6])
            {
            }
            column(Desc_Arr_6_; Desc_Arr[6])
            {
            }
            column(Cantidad_Arr_6_; Cantidad_Arr[6])
            {
            }
            column(CodProd_Arr_6_; CodProd_Arr[6])
            {
            }
            column(Iva2_Arr_1_; Iva2_Arr[1])
            {
                DecimalPlaces = 2 : 2;
            }
            column(Iva2_Arr_2_; Iva2_Arr[2])
            {
                DecimalPlaces = 0 : 2;
            }
            column(Iva2_Arr_3_; Iva2_Arr[3])
            {
                DecimalPlaces = 0 : 2;
            }
            column(Iva2_Arr_4_; Iva2_Arr[4])
            {
                DecimalPlaces = 0 : 2;
            }
            column(Iva2_Arr_5_; Iva2_Arr[5])
            {
                DecimalPlaces = 0 : 2;
            }
            column(Iva2_Arr_6_; Iva2_Arr[6])
            {
                DecimalPlaces = 0 : 2;
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
            column(PorcDto_Arr_7_; PorcDto_Arr[7])
            {
            }
            column(ImpDesc_Arr_7_; ImpDesc_Arr[7])
            {
            }
            column(BaseExe_Arr_7_; BaseExe_Arr[7])
            {
            }
            column(Iva1_Arr_7_; Iva1_Arr[7])
            {
            }
            column(Iva2_Arr_7_; Iva2_Arr[7])
            {
                DecimalPlaces = 0 : 2;
            }
            column(Iva2_Arr_8_; Iva2_Arr[8])
            {
                DecimalPlaces = 0 : 2;
            }
            column(Iva1_Arr_8_; Iva1_Arr[8])
            {
            }
            column(BaseExe_Arr_8_; BaseExe_Arr[8])
            {
            }
            column(ImpDesc_Arr_8_; ImpDesc_Arr[8])
            {
            }
            column(PorcDto_Arr_8_; PorcDto_Arr[8])
            {
            }
            column(PrecUnit_Arr_8_; PrecUnit_Arr[8])
            {
            }
            column(Desc_Arr_8_; Desc_Arr[8])
            {
            }
            column(Cantidad_Arr_8_; Cantidad_Arr[8])
            {
            }
            column(CodProd_Arr_8_; CodProd_Arr[8])
            {
            }
            column(Iva2_Arr_9_; Iva2_Arr[9])
            {
                DecimalPlaces = 0 : 2;
            }
            column(Iva1_Arr_9_; Iva1_Arr[9])
            {
            }
            column(BaseExe_Arr_9_; BaseExe_Arr[9])
            {
            }
            column(ImpDesc_Arr_9_; ImpDesc_Arr[9])
            {
            }
            column(PorcDto_Arr_9_; PorcDto_Arr[9])
            {
            }
            column(PrecUnit_Arr_9_; PrecUnit_Arr[9])
            {
            }
            column(Desc_Arr_9_; Desc_Arr[9])
            {
            }
            column(Cantidad_Arr_9_; Cantidad_Arr[9])
            {
            }
            column(CodProd_Arr_9_; CodProd_Arr[9])
            {
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
            column(PorcDto_Arr_10_; PorcDto_Arr[10])
            {
            }
            column(ImpDesc_Arr_10_; ImpDesc_Arr[10])
            {
            }
            column(BaseExe_Arr_10_; BaseExe_Arr[10])
            {
            }
            column(Iva1_Arr_10_; Iva1_Arr[10])
            {
            }
            column(Iva2_Arr_10_; Iva2_Arr[10])
            {
                DecimalPlaces = 0 : 2;
            }
            column(wtotalEx; wtotalEx)
            {
            }
            column(wTotalDescuento; wTotalDescuento)
            {
            }
            column(DescriptionLine_1__________; DescriptionLine[1] + ' ** ')
            {
            }
            column(Sales_Invoice_Header__Amount_Including_VAT_; "Amount Including VAT")
            {
                DecimalPlaces = 0 : 2;
            }
            column(Columna1IVA; Columna1IVA)
            {
            }
            column(Columna2Iva; Columna2Iva)
            {
            }
            column(Amount_Including_VAT____Amount; "Amount Including VAT" - Amount)
            {
            }

            trigger OnAfterGetRecord()
            begin
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

                //SerieCompleta := "Punto de Emision Factura" +'-'+"Establecimiento Factura"+"No. Comprobante Fiscal";    //CPMCR-CEC+-

                rCliente.GET("Sell-to Customer No.");
                Tel := rCliente."Phone No.";


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

                SIL.RESET;
                SIL.SETRANGE("Document No.", "No.");
                IF SIL.FINDSET THEN
                    REPEAT
                        I += 1;
                        CodProd_Arr[I] := SIL."No.";
                        Cantidad_Arr[I] := SIL.Quantity;
                        Desc_Arr[I] := SIL.Description;
                        PrecUnit_Arr[I] := SIL."Unit Price";
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
                        //CPMCR-CEC+
                        /*
                        ConfSant.TESTFIELD("% IVA Venta 1");
                        ConfSant.TESTFIELD("% IVA Venta 2");
                        */
                        //CPMCR-CEC-
                        IF (SIL."Amount Including VAT" - SIL.Amount) <> 0 THEN BEGIN
                            VatPostSet.RESET;
                            VatPostSet.SETRANGE("VAT Prod. Posting Group", SIL."VAT Prod. Posting Group");
                            //VatPostSet.SETRANGE("VAT %",ConfSant."% IVA Venta 1");      //CPMCR-CEC+-
                            IF VatPostSet.FINDFIRST THEN BEGIN
                                Columna1IVA += SIL."Amount Including VAT" - SIL.Amount;
                                Columna1IVABase := SIL.Amount;
                            END;
                            VatPostSet.RESET;
                            VatPostSet.SETRANGE("VAT Prod. Posting Group", SIL."VAT Prod. Posting Group");
                            //VatPostSet.SETRANGE("VAT %",ConfSant."% IVA Venta 2");   //CPMCR-CEC+-
                            IF VatPostSet.FINDFIRST THEN BEGIN
                                Columna2Iva += SIL."Amount Including VAT" - SIL.Amount;
                                Columna2IvaBase := SIL.Amount;

                            END;
                        END
                        ELSE BEGIN
                            ColumnaExe := SIL."Amount Including VAT";
                            ColumnaExeBase := SIL.Amount;
                            wtotalEx += SIL."Amount Including VAT";
                        END;
                        //IVA
                        BaseExe_Arr[I] := ColumnaExeBase;
                        Iva1_Arr[I] := Columna1IVABase;
                        Iva2_Arr[I] := Columna2IvaBase;
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
        CodDiv: Code[20];
        NCFAnulados: Record 34003012;
        NoSeriesMgt: Codeunit "No. Series";
        CLE: Record 21;
        SSH: Record 110;
        NoGuia: Code[50];
        Prueba: Decimal;
        Descuento: Decimal;
        SIL: Record 113;
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
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        Customer: Record 18;
        SalesInvPrinted: Codeunit 315;
        CopyTxt: Text[10];
        Text000: Label 'COPY';
        ConfSant: Record 55226;
        ImporteSinCargos: Decimal;
        ImporteCargos: Decimal;
        DescuentoCargos: Decimal;
        CantENviada: Decimal;
        CantSolicitada: Decimal;
        Vendedor: Text[30];
        LogInteraction: Boolean;
        Tel: Code[20];
        SerieCompleta: Code[50];
        VatPostSet: Record 325;
        VatProdPostGrp: Record 324;
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
        I: Integer;
        wTotalDescuento: Decimal;
        wtotalEx: Decimal;
        IvaTotal: Decimal;

    procedure InitLogInteraction()
    begin
        //LogInteraction := SegManagement.FindInteractTmplCode(4) <> '';
    end;
}

