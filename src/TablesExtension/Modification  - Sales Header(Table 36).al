tableextension 70000044 tableextension70000044 extends "Sales Header"
{
    fields
    {
        modify("Sell-to Customer No.")
        {
            TableRelation = Customer;
        }
        modify("Bill-to Customer No.")
        {
            TableRelation = Customer;
        }

        //Unsupported feature: Property Modification (Data type) on ""Bill-to City"(Field 9)".


        //Unsupported feature: Property Modification (Data type) on ""Ship-to City"(Field 17)".

        modify("Location Code")
        {
            TableRelation = Location WHERE(Use As In-Transit=CONST(false));
        }
        modify("Shortcut Dimension 1 Code")
        {
            Caption = 'Shortcut Dimension 1 Code';
        }
        modify("Shortcut Dimension 2 Code")
        {
            Caption = 'Shortcut Dimension 2 Code';
        }
        modify("Salesperson Code")
        {
            TableRelation = "Salesperson/Purchaser";
        }

        //Unsupported feature: Property Modification (Data type) on ""VAT Registration No."(Field 70)".

        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Gen. Bus. Posting Group';
        }

        //Unsupported feature: Property Modification (Data type) on ""Sell-to City"(Field 83)".

        modify("Sell-to Post Code")
        {
            TableRelation = IF (Sell-to Country/Region Code=CONST()) "Post Code"
                            ELSE IF (Sell-to Country/Region Code=FILTER(<>'')) "Post Code" WHERE (Country/Region Code=FIELD(Sell-to Country/Region Code));
        }
        modify("Ship-to Post Code")
        {
            TableRelation = IF (Ship-to Country/Region Code=CONST()) "Post Code"
                            ELSE IF (Ship-to Country/Region Code=FILTER(<>'')) "Post Code" WHERE (Country/Region Code=FIELD(Ship-to Country/Region Code));
        }
        modify("Area")
        {
            Caption = 'Area';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'VAT Bus. Posting Group';
        }
        modify("Prepmt. Pmt. Discount Date")
        {
            Caption = 'Prepmt. Pmt. Discount Date';
        }
        modify("Direct Debit Mandate ID")
        {
            Caption = 'Direct Debit Mandate ID';
        }
        modify("Location Filter")
        {
            TableRelation = Location;
        }

        //Unsupported feature: Code Modification on ""Sell-to Customer No."(Field 2).OnValidate".

        //trigger "(Field 2)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CheckCreditLimitIfLineNotInsertedYet;
            IF "No." = '' THEN
              InitRecord;
            TestStatusOpen;

            //+#4196
            //ValidaCampos.Maestros(18,"Sell-to Customer No.");
            //ValidaCampos.Dimensiones(18,"Sell-to Customer No.",0,0);
            //-#4196

            //019
            MktSetUp.GET;
            ContacBusRel.RESET;
            ContacBusRel.SETRANGE("Business Relation Code",MktSetUp."Bus. Rel. Code for Customers");
            ContacBusRel.SETRANGE("No.","Sell-to Customer No.");
            IF ContacBusRel.FINDFIRST THEN
              VALIDATE("Cod. Colegio",ContacBusRel."Contact No.");
            //019

            IF ("Sell-to Customer No." <> xRec."Sell-to Customer No.") AND
               (xRec."Sell-to Customer No." <> '')
            THEN BEGIN
              IF ("Opportunity No." <> '') AND ("Document Type" IN ["Document Type"::Quote,"Document Type"::Order]) THEN
                ERROR(
                  Text062,
                  FIELDCAPTION("Sell-to Customer No."),
                  FIELDCAPTION("Opportunity No."),
                  "Opportunity No.",
                  "Document Type");
              IF GetHideValidationDialog OR NOT GUIALLOWED THEN
                Confirmed := TRUE
              ELSE
                Confirmed := CONFIRM(ConfirmChangeQst,FALSE,SellToCustomerTxt);
              IF Confirmed THEN BEGIN
                SalesLine.SETRANGE("Document Type","Document Type");
                SalesLine.SETRANGE("Document No.","No.");
                IF "Sell-to Customer No." = '' THEN BEGIN
                  IF SalesLine.FINDFIRST THEN
                    ERROR(
                      Text005,
                      FIELDCAPTION("Sell-to Customer No."));
                  INIT;
                  OnValidateSellToCustomerNoAfterInit(Rec,xRec);
                  GetSalesSetup;
                  "No. Series" := xRec."No. Series";
                  InitRecord;
                  InitNoSeries;
                  EXIT;
                END;

                CheckShipmentInfo(SalesLine,FALSE);
                CheckPrepmtInfo(SalesLine);
                CheckReturnInfo(SalesLine,FALSE);

                SalesLine.RESET;
              END ELSE BEGIN
                Rec := xRec;
                EXIT;
              END;
            END;

            IF ("Document Type" = "Document Type"::Order) AND
               (xRec."Sell-to Customer No." <> "Sell-to Customer No.")
            THEN BEGIN
              SalesLine.SETRANGE("Document Type",SalesLine."Document Type"::Order);
              SalesLine.SETRANGE("Document No.","No.");
              SalesLine.SETFILTER("Purch. Order Line No.",'<>0');
              IF NOT SalesLine.ISEMPTY THEN
                ERROR(
                  Text006,
                  FIELDCAPTION("Sell-to Customer No."));
              SalesLine.RESET;
            END;

            GetCust("Sell-to Customer No.");
            Cust.CheckBlockedCustOnDocs(Cust,"Document Type",FALSE,FALSE);
            GLSetup.GET;
            IF GLSetup."VAT in Use" THEN
              Cust.TESTFIELD("Gen. Bus. Posting Group");
            OnAfterCheckSellToCust(Rec,xRec,Cust);

            CopySellToCustomerAddressFieldsFromCustomer(Cust);

            IF "Sell-to Customer No." = xRec."Sell-to Customer No." THEN
              IF ShippedSalesLinesExist OR ReturnReceiptExist THEN BEGIN
                TESTFIELD("VAT Bus. Posting Group",xRec."VAT Bus. Posting Group");
                TESTFIELD("Gen. Bus. Posting Group",xRec."Gen. Bus. Posting Group");
              END;

            "Sell-to IC Partner Code" := Cust."IC Partner Code";
            "Send IC Document" := ("Sell-to IC Partner Code" <> '') AND ("IC Direction" = "IC Direction"::Outgoing);

            VALIDATE("Ship-to Code",Cust."Ship-to Code");
            IF Cust."Bill-to Customer No." <> '' THEN
              VALIDATE("Bill-to Customer No.",Cust."Bill-to Customer No.")
            ELSE BEGIN
              IF "Bill-to Customer No." = "Sell-to Customer No." THEN
                SkipBillToContact := TRUE;
              VALIDATE("Bill-to Customer No.","Sell-to Customer No.");
              SkipBillToContact := FALSE;
            END;

            GetShippingTime(FIELDNO("Sell-to Customer No."));

            IF (xRec."Sell-to Customer No." <> "Sell-to Customer No.") OR
               (xRec."Currency Code" <> "Currency Code") OR
               (xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group") OR
               (xRec."VAT Bus. Posting Group" <> "VAT Bus. Posting Group")
            THEN
              RecreateSalesLines(SellToCustomerTxt);

            //DSLoc1.01 This is a requested field for the NCF
            //CustomerPostingGr.GET(Cust."Customer Posting Group");
            //IF NOT CustomerPostingGr."RNC/Cedula no Requerido" THEN
              Cust.TESTFIELD("VAT Registration No.");

            //DSLoc1.01 To record the Serial No for NCF. on Documents
            CustomerPostingGr.GET(Cust."Customer Posting Group");
            IF "Document Type" IN ["Document Type"::Quote,"Document Type"::Order,"Document Type"::Invoice] THEN
                "No. Serie NCF Facturas" := CustomerPostingGr."No. Serie NCF Factura Venta"
            ELSE
            IF "Document Type" IN ["Document Type"::"Credit Memo","Document Type"::"Return Order"] THEN
               "No. Serie NCF Abonos" := CustomerPostingGr."No. Serie NCF Abonos Venta";
            //DSLoc1.01 END

            IF NOT SkipSellToContact THEN
              UpdateSellToCont("Sell-to Customer No.");

            IF "No." <> '' THEN
              StandardCodesMgt.CheckShowSalesRecurringLinesNotification(Rec);

            IF (xRec."Sell-to Customer No." <> '') AND (xRec."Sell-to Customer No." <> "Sell-to Customer No.") THEN
              RecallModifyAddressNotification(GetModifyCustomerAddressNotificationId);

            IF xRec."Sell-to Customer No." <> "Sell-to Customer No." THEN
              CopyCFDIFieldsFromCustomer;

            //008
            CPG.GET(Cust."Customer Posting Group");
            "No aplica Derechos de Autor" := CPG."No aplica Derechos de Autor";
            Promocion := CPG.Promocion;
            //008
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
            #20..93
            LocationCode := "Location Code";

            #94..102
            VALIDATE("Location Code",LocationCode);
            #103..111
            #126..136
            */
        //end;

        //Unsupported feature: Property Deletion (Description) on ""Sell-to Customer No."(Field 2)".



        //Unsupported feature: Code Modification on ""Bill-to Customer No."(Field 4).OnValidate".

        //trigger "(Field 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TestStatusOpen;

            //+#4196
            //ValidaCampos.Maestros(18,"Bill-to Customer No.");
            //ValidaCampos.Dimensiones(18,"Bill-to Customer No.",0,0);
            //-#4196

            BilltoCustomerNoChanged := xRec."Bill-to Customer No." <> "Bill-to Customer No.";
            IF BilltoCustomerNoChanged THEN
              IF xRec."Bill-to Customer No." = '' THEN
            #11..71

            IF xRec."Bill-to Customer No." <> "Bill-to Customer No." THEN
              CopyCFDIFieldsFromCustomer;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            TestStatusOpen;
            #8..74
            */
        //end;

        //Unsupported feature: Property Deletion (Description) on ""Bill-to Customer No."(Field 4)".



        //Unsupported feature: Code Modification on ""Bill-to Name"(Field 5).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            //IF ShouldLookForCustomerByName("Bill-to Customer No.") THEN
            //  VALIDATE("Bill-to Customer No.",Customer.GetCustNo("Bill-to Name"));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF ShouldLookForCustomerByName("Bill-to Customer No.") THEN
              VALIDATE("Bill-to Customer No.",Customer.GetCustNo("Bill-to Name"));
            */
        //end;


        //Unsupported feature: Code Modification on ""Ship-to Code"(Field 12).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF ("Document Type" = "Document Type"::Order) AND
               (xRec."Ship-to Code" <> "Ship-to Code")
            THEN BEGIN
            #4..15
                IF xRec."Ship-to Code" <> '' THEN
                  BEGIN
                  GetCust("Sell-to Customer No.");
                  //003
                  IF "Tipo pedido" <> 1 THEN
                  //003
                    IF Cust."Location Code" <> '' THEN
                      VALIDATE("Location Code",Cust."Location Code");
                  "Tax Area Code" := Cust."Tax Area Code";
                END;
                ShipToAddr.GET("Sell-to Customer No.","Ship-to Code");

                CopyShipToCustomerAddressFieldsFromShipToAddr(ShipToAddr);

              END ELSE
                IF "Sell-to Customer No." <> '' THEN BEGIN
                  GetCust("Sell-to Customer No.");
            #33..49
                IF xRec."Tax Liable" <> "Tax Liable" THEN
                  VALIDATE("Tax Liable");
              END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..18
                  IF Cust."Location Code" <> '' THEN
                    VALIDATE("Location Code",Cust."Location Code");
            #24..26
                CopyShipToCustomerAddressFieldsFromShipToAddr(ShipToAddr);
            #30..52
            */
        //end;


        //Unsupported feature: Code Modification on ""Posting Date"(Field 20).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD("Posting Date");
            TestNoSeriesDate(
              "Posting No.","Posting No. Series",
            #4..21

            IF "Currency Code" <> '' THEN BEGIN
              UpdateCurrencyFactor;
              IF "Currency Factor" <> xRec."Currency Factor" THEN
                ConfirmUpdateCurrencyFactor;
            END;

            IF "Posting Date" <> xRec."Posting Date" THEN
              IF DeferralHeadersExist THEN
                ConfirmUpdateDeferralDate;
            SynchronizeAsmHeader;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..24
              IF ("Currency Factor" <> xRec."Currency Factor") AND NOT CalledFromWhseDoc THEN
            #26..32
            */
        //end;


        //Unsupported feature: Code Modification on ""Location Code"(Field 28).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TestStatusOpen;

            //ValidaCampos.Maestros(14,"Location Code"); //+#4196

            IF ("Location Code" <> xRec."Location Code") AND
               (xRec."Sell-to Customer No." = "Sell-to Customer No.")
            THEN
              //003
              IF "Tipo pedido" <> 1 THEN
              //003
              MessageIfSalesLinesExist(FIELDCAPTION("Location Code"));

            UpdateShipToAddress;
            UpdateOutboundWhseHandlingTime;

            //002 - **Pendiente Cambiar a manejo de dimension estandar**
            IF "Tipo pedido" = 1 THEN
              BEGIN
                Location.GET("Location Code");
                DefDim.RESET;
                DefDim.SETRANGE("Table ID",14);
                DefDim.SETRANGE("No.","Location Code");
                IF DefDim.FINDSET THEN BEGIN
                  DimMgt.GetDimensionSet(TempDimSetEntry,"Dimension Set ID");
                  REPEAT
                    DimVal.GET(DefDim."Dimension Code",DefDim."Dimension Value Code");
                    IF TempDimSetEntry.GET("Dimension Set ID",DefDim."Dimension Code") THEN
                      TempDimSetEntry.DELETE;
                    TempDimSetEntry.INIT;
                    TempDimSetEntry."Dimension Set ID" := "Dimension Set ID";
                    TempDimSetEntry."Dimension Code" := DefDim."Dimension Code";
                    TempDimSetEntry."Dimension Value Code" := DefDim."Dimension Value Code";
                    TempDimSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
                    TempDimSetEntry.INSERT;
                  UNTIL DefDim.NEXT = 0;
                  "Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);
                  MODIFY;
                END;
              END;
            //002 - Fin
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            TestStatusOpen;
            #5..7
            #11..14
            */
        //end;

        //Unsupported feature: Property Deletion (Description) on ""Location Code"(Field 28)".



        //Unsupported feature: Code Modification on ""Prices Including VAT"(Field 35).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TestStatusOpen;

            IF "Prices Including VAT" <> xRec."Prices Including VAT" THEN BEGIN
            #4..60
                        SalesLine."Line Amount" := SalesLine."Amount Including VAT" + SalesLine."Inv. Discount Amount"
                      ELSE
                        SalesLine."Line Amount" := SalesLine.Amount + SalesLine."Inv. Discount Amount";
                  END;
                  OnValidatePricesIncludingVATOnBeforeSalesLineModify(Rec,SalesLine,Currency,RecalculatePrice);
                  SalesLine.MODIFY;
                UNTIL SalesLine.NEXT = 0;
              END;
              OnAfterChangePricesIncludingVAT(Rec);
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..63
                    UpdatePrepmtAmounts(SalesLine);
            #64..70
            */
        //end;


        //Unsupported feature: Code Modification on ""Salesperson Code"(Field 43).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ValidateSalesPersonOnSalesHeader(Rec,FALSE,FALSE);

            //+#4196
            //ValidaCampos.Maestros(13,"Salesperson Code");
            //ValidaCampos.Dimensiones(13,"Salesperson Code",0,0);
            //-#4196

            IF Status <> Status::Open THEN //012
              BEGIN                        //012
            ApprovalEntry.SETRANGE("Table ID",DATABASE::"Sales Header");
            ApprovalEntry.SETRANGE("Document Type","Document Type");
            ApprovalEntry.SETRANGE("Document No.","No.");
            ApprovalEntry.SETFILTER(Status,'%1|%2',ApprovalEntry.Status::Created,ApprovalEntry.Status::Open);
            IF NOT ApprovalEntry.ISEMPTY THEN
              ERROR(Text053,FIELDCAPTION("Salesperson Code"));
            END;//012

            CreateDim(
              DATABASE::"Salesperson/Purchaser","Salesperson Code",
              DATABASE::Customer,"Bill-to Customer No.",
              DATABASE::Campaign,"Campaign No.",
              DATABASE::"Responsibility Center","Responsibility Center",
              DATABASE::"Customer Template","Bill-to Customer Template Code");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ValidateSalesPersonOnSalesHeader(Rec,FALSE,FALSE);

            #10..15
            #17..23
            */
        //end;


        //Unsupported feature: Code Modification on ""Sell-to Customer Name"(Field 79).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            //IF NOT IdentityManagement.IsInvAppId AND ShouldLookForCustomerByName("Sell-to Customer No.") THEN
            //  VALIDATE("Sell-to Customer No.",Customer.GetCustNo("Sell-to Customer Name"));
            GetShippingTime(FIELDNO("Sell-to Customer Name"));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF NOT IdentityManagement.IsInvAppId AND ShouldLookForCustomerByName("Sell-to Customer No.") THEN
              VALIDATE("Sell-to Customer No.",Customer.GetCustNo("Sell-to Customer Name"));
            GetShippingTime(FIELDNO("Sell-to Customer Name"));
            */
        //end;


        //Unsupported feature: Code Modification on ""Sell-to Contact"(Field 84).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ModifyCustomerAddress;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF "Sell-to Contact" = '' THEN
              VALIDATE("Sell-to Contact No.",'');
            ModifyCustomerAddress;
            */
        //end;

        //Unsupported feature: Deletion on "Correction(Field 98).OnValidate".


        //Unsupported feature: Property Deletion (Description) on ""Location Filter"(Field 5754)".


        //Unsupported feature: Deletion (FieldCollection) on ""Estado distribucion"(Field 50000)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. copias Picking"(Field 50008)".


        //Unsupported feature: Deletion (FieldCollection) on ""Nota de Credito"(Field 50009)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo de Venta"(Field 50010)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Bultos"(Field 50011)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad para devolucion"(Field 50012)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad en lineas"(Field 50013)".


        //Unsupported feature: Deletion (FieldCollection) on ""PO Box address"(Field 50014)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Documento SIC"(Field 50110)".


        //Unsupported feature: Deletion (FieldCollection) on ""Source counter"(Field 50111)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Cajero"(Field 50112)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Supervisor"(Field 50113)".


        //Unsupported feature: Deletion (FieldCollection) on ""Error Registro"(Field 50114)".


        //Unsupported feature: Deletion (FieldCollection) on "Clave(Field 52500)".


        //Unsupported feature: Deletion (FieldCollection) on "Consecutivo(Field 52501)".


        //Unsupported feature: Deletion (FieldCollection) on "Estado(Field 52502)".


        //Unsupported feature: Deletion (FieldCollection) on "Mensaje(Field 52503)".


        //Unsupported feature: Deletion (FieldCollection) on ""Fecha Doc Electronico"(Field 52504)".


        //Unsupported feature: Deletion (FieldCollection) on ""E-Mail-FE"(Field 52505)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo Doc Electronico"(Field 52506)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo Doc. Ref."(Field 52508)".


        //Unsupported feature: Deletion (FieldCollection) on ""Numero Referencia FE"(Field 52509)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo Doc. Ref NC"(Field 52510)".


        //Unsupported feature: Deletion (FieldCollection) on ""Codigo Referencia"(Field 52511)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Doc Historico"(Field 52512)".


        //Unsupported feature: Deletion (FieldCollection) on ""Categoria Pedido Venta"(Field 52513)".


        //Unsupported feature: Deletion (FieldCollection) on ""ID Cajero (Obsoleto)"(Field 53000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Hora creacion (Obsoleto)"(Field 53001)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo pedido"(Field 53002)".


        //Unsupported feature: Deletion (FieldCollection) on ""Factura comprimida"(Field 53004)".


        //Unsupported feature: Deletion (FieldCollection) on ""Importe ITBIS Incl."(Field 53005)".


        //Unsupported feature: Deletion (FieldCollection) on ""Venta a credito (Obsoleto)"(Field 53006)".


        //Unsupported feature: Deletion (FieldCollection) on ""Importe a liquidar"(Field 53007)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tienda (Obsoleto)"(Field 53008)".


        //Unsupported feature: Deletion (FieldCollection) on ""Factura en Historico"(Field 53009)".


        //Unsupported feature: Deletion (FieldCollection) on ""Pedido Consignacion"(Field 56000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Collector Code"(Field 56001)".


        //Unsupported feature: Deletion (FieldCollection) on ""Pre pedido"(Field 56002)".


        //Unsupported feature: Deletion (FieldCollection) on ""Devolucion Consignacion"(Field 56003)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Cupon"(Field 56004)".


        //Unsupported feature: Deletion (FieldCollection) on ""Siguiente No."(Field 56005)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Colegio"(Field 56006)".


        //Unsupported feature: Deletion (FieldCollection) on ""Nombre Colegio"(Field 56007)".


        //Unsupported feature: Deletion (FieldCollection) on ""Re facturacion"(Field 56008)".


        //Unsupported feature: Deletion (FieldCollection) on ""No aplica Derechos de Autor"(Field 56020)".


        //Unsupported feature: Deletion (FieldCollection) on "Promocion(Field 56021)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad de Bultos"(Field 56062)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Hoja de Ruta"(Field 56063)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Hoja de Ruta Reg."(Field 56064)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Envio de Almacen"(Field 56070)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Picking"(Field 56071)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Picking Reg."(Field 56072)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Packing"(Field 56073)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Packing Reg."(Field 56074)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Factura"(Field 56075)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Envio"(Field 56076)".


        //Unsupported feature: Deletion (FieldCollection) on ""% de aprobacion"(Field 56077)".


        //Unsupported feature: Deletion (FieldCollection) on ""En Hoja de Ruta"(Field 56098)".


        //Unsupported feature: Deletion (FieldCollection) on ""Estado packing"(Field 56121)".


        //Unsupported feature: Deletion (FieldCollection) on ""Venta Call Center"(Field 56300)".


        //Unsupported feature: Deletion (FieldCollection) on ""Pago recibido"(Field 56301)".


        //Unsupported feature: Deletion (FieldCollection) on ""Aprobado cobros"(Field 56302)".


        //Unsupported feature: Deletion (FieldCollection) on ""Ruta de Distribucion"(Field 56303)".


        //Unsupported feature: Deletion (FieldCollection) on "Origen(Field 56310)".


        //Unsupported feature: Deletion (FieldCollection) on ""Estado E-Commerce"(Field 56311)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tax Identification Type"(Field 56312)".


        //Unsupported feature: Deletion (FieldCollection) on ""Metodo de Envio E-Commerce"(Field 56313)".


        //Unsupported feature: Deletion (FieldCollection) on ""ID Cajero"(Field 34002500)".


        //Unsupported feature: Deletion (FieldCollection) on ""Hora creacion"(Field 34002501)".


        //Unsupported feature: Deletion (FieldCollection) on ""Venta TPV"(Field 34002502)".


        //Unsupported feature: Deletion (FieldCollection) on "TPV(Field 34002503)".


        //Unsupported feature: Deletion (FieldCollection) on "Tienda(Field 34002504)".


        //Unsupported feature: Deletion (FieldCollection) on ""Venta a credito"(Field 34002505)".


        //Unsupported feature: Deletion (FieldCollection) on ""Registrado TPV"(Field 34002509)".


        //Unsupported feature: Deletion (FieldCollection) on ""Anulado TPV"(Field 34002510)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Fiscal TPV"(Field 34002511)".


        //Unsupported feature: Deletion (FieldCollection) on "Turno(Field 34002512)".


        //Unsupported feature: Deletion (FieldCollection) on ""Anulado por Documento"(Field 34002513)".


        //Unsupported feature: Deletion (FieldCollection) on ""Anula a Documento"(Field 34002514)".


        //Unsupported feature: Deletion (FieldCollection) on "Devolucion(Field 34002515)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Telefono"(Field 34002516)".


        //Unsupported feature: Deletion (FieldCollection) on ""Replicado POS"(Field 34002517)".


        //Unsupported feature: Deletion (FieldCollection) on ""E-Mail"(Field 34002518)".


        //Unsupported feature: Deletion (FieldCollection) on "Aparcado(Field 34002519)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo venta TPV"(Field 34002521)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Serie NCF Facturas"(Field 34003001)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Comprobante Fiscal"(Field 34003002)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Comprobante Fiscal Rel."(Field 34003003)".


        //Unsupported feature: Deletion (FieldCollection) on ""Razon anulacion NCF"(Field 34003004)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Serie NCF Abonos"(Field 34003005)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Clasificacion Gasto"(Field 34003006)".


        //Unsupported feature: Deletion (FieldCollection) on ""Fecha vencimiento NCF"(Field 34003007)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo de ingreso"(Field 34003008)".

        field(10000;"Sales Tax Amount Rounding";Decimal)
        {
            Caption = 'Sales Tax Amount Rounding';
        }
        field(10001;"Prepmt. Sales Tax Rounding Amt";Decimal)
        {
            Caption = 'Prepmt. Sales Tax Rounding Amt';
        }
        field(10044;"Transport Operators";Integer)
        {
            CalcFormula = Count("CFDI Transport Operator" WHERE (Document Table ID=CONST(36),
                                                                 Document Type=FIELD(Document Type),
                                                                 Document No.=FIELD(No.)));
            Caption = 'Transport Operators';
            FieldClass = FlowField;
        }
        field(10045;"Transit-from Date/Time";DateTime)
        {
            Caption = 'Transit-from Date/Time';
        }
        field(10046;"Transit Hours";Integer)
        {
            Caption = 'Transit Hours';
        }
        field(10047;"Transit Distance";Decimal)
        {
            Caption = 'Transit Distance';
        }
        field(10048;"Insurer Name";Text[50])
        {
            Caption = 'Insurer Name';
        }
        field(10049;"Insurer Policy Number";Text[30])
        {
            Caption = 'Insurer Policy Number';
        }
        field(10050;"Foreign Trade";Boolean)
        {
            Caption = 'Foreign Trade';
        }
        field(10051;"Vehicle Code";Code[20])
        {
            Caption = 'Vehicle Code';
            TableRelation = "Fixed Asset";
        }
        field(10052;"Trailer 1;Code[20])
        {
            Caption = 'Trailer 1';
            TableRelation = "Fixed Asset" WHERE (SAT Trailer Type=FILTER(<>''));
        }
        field(10053;"Trailer 2;Code[20])
        {
            Caption = 'Trailer 2';
            TableRelation = "Fixed Asset" WHERE (SAT Trailer Type=FILTER(<>''));
        }
        field(10055;"Transit-to Location";Code[10])
        {
            Caption = 'Transit-to Location';
            TableRelation = Location WHERE (Use As In-Transit=CONST(false));
        }
        field(10056;"Medical Insurer Name";Text[50])
        {
            Caption = 'Medical Insurer Name';
        }
        field(10057;"Medical Ins. Policy Number";Text[30])
        {
            Caption = 'Medical Ins. Policy Number';
        }
        field(10058;"SAT Weight Unit Of Measure";Code[10])
        {
            Caption = 'SAT Weight Unit Of Measure';
            TableRelation = "SAT Weight Unit of Measure";
        }
        field(27004;"CFDI Export Code";Code[10])
        {
            Caption = 'CFDI Export Code';
            TableRelation = "CFDI Export Code";
        }
    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""ID Cajero (Obsoleto),Tipo pedido"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""External Document No."(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Document Type,Sell-to Customer No.,Status"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Posting Date"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Requested Delivery Date"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Promised Delivery Date"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Shipment Date"(Key)".

    }


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF NOT UserSetupMgt.CheckRespCenter(0,"Responsibility Center") THEN
          ERROR(
            Text022,
            RespCenter.TABLECAPTION,UserSetupMgt.GetSalesFilter);

        ArchiveManagement.AutoArchiveSalesDocument(Rec);
        PostSalesDelete.DeleteHeader(
          Rec,SalesShptHeader,SalesInvHeader,SalesCrMemoHeader,ReturnRcptHeader,
          SalesInvHeaderPrepmt,SalesCrMemoHeaderPrepmt);
        UpdateOpportunity;

        VALIDATE("Applies-to ID",'');
        VALIDATE("Incoming Document Entry No.",0);

        ApprovalsMgmt.OnDeleteRecordInApprovalRequest(RECORDID);
        SalesLine.RESET;
        SalesLine.LOCKTABLE;

        WhseRequest.SETRANGE("Source Type",DATABASE::"Sales Line");
        WhseRequest.SETRANGE("Source Subtype","Document Type");
        WhseRequest.SETRANGE("Source No.","No.");
        IF NOT WhseRequest.ISEMPTY THEN
          WhseRequest.DELETEALL(TRUE);

        SalesLine.SETRANGE("Document Type","Document Type");
        SalesLine.SETRANGE("Document No.","No.");
        SalesLine.SETRANGE(Type,SalesLine.Type::"Charge (Item)");

        DeleteSalesLines;
        SalesLine.SETRANGE(Type);
        DeleteSalesLines;

        SalesCommentLine.SETRANGE("Document Type","Document Type");
        SalesCommentLine.SETRANGE("No.","No.");
        SalesCommentLine.DELETEALL;

        IF "Tax Area Code" <> '' THEN BEGIN
          SalesTaxDifference.RESET;
          SalesTaxDifference.SETRANGE("Document Product Area",SalesTaxDifference."Document Product Area"::Sales);
          SalesTaxDifference.SETRANGE("Document Type","Document Type");
          SalesTaxDifference.SETRANGE("Document No.","No.");
          SalesTaxDifference.DELETEALL;
        END;

        IF (SalesShptHeader."No." <> '') OR
           (SalesInvHeader."No." <> '') OR
           (SalesCrMemoHeader."No." <> '') OR
           (ReturnRcptHeader."No." <> '') OR
           (SalesInvHeaderPrepmt."No." <> '') OR
           (SalesCrMemoHeaderPrepmt."No." <> '')
        THEN
          MESSAGE(PostedDocsToPrintCreatedMsg);

        IF IdentityManagement.IsInvAppId AND CustInvoiceDisc.GET(SalesHeader."Invoice Disc. Code") THEN
          CustInvoiceDisc.DELETE; // Cleanup of autogenerated cust. invoice discounts

        //006
        IF "Tipo pedido" = "Tipo pedido"::TPV THEN
          BEGIN
            rPagosTPV.RESET;
          //  rPagosTPV.SETRANGE("No. pedido","No.");
            rPagosTPV.DELETEALL;
          END;
        //006

        IF "Document Type" = "Document Type"::"Return Order" THEN   //$022
          ControlClasificacionDevolucion;                           //
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..55
        */
    //end;


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        InitInsert;
        InsertMode := TRUE;

        #4..15

        // Remove view filters so that the cards does not show filtered view notification
        SETVIEW('');

        //010
        IF UserSetUp.GET(USERID) THEN
          BEGIN
            IF UserSetUp."Usuario Movilidad" THEN
              VALIDATE("Tipo pedido","Tipo pedido"::Movilidad);
          END;
        //010;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..18
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "InitInsert(PROCEDURE 61)".


    //Unsupported feature: Property Modification (Attributes) on "InitRecord(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "AssistEdit(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "TestNoSeries(PROCEDURE 6)".



    //Unsupported feature: Code Modification on "TestNoSeries(PROCEDURE 6)".

    //procedure TestNoSeries();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GetSalesSetup;
        IsHandled := FALSE;
        OnBeforeTestNoSeries(Rec,IsHandled);
        IF NOT IsHandled THEN
          CASE "Document Type" OF
            "Document Type"::Quote:
              SalesSetup.TESTFIELD("Quote Nos.");
            "Document Type"::Order:
              BEGIN    //DSLoc1.01 Localizacion Guatemala
                SalesSetup.TESTFIELD("Order Nos.");
                IF "Pre pedido" THEN //DSLoc1.01 Localizacion Guatemala
                  SalesSetup.TESTFIELD("Pre Order Nos.");  //DSLoc1.01 Localizacion Guatemala
              END;
            "Document Type"::Invoice:
              BEGIN
                SalesSetup.TESTFIELD("Invoice Nos.");
        #17..27
          END;

        OnAfterTestNoSeries(Rec);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..8
              SalesSetup.TESTFIELD("Order Nos.");
        #14..30
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "GetNoSeriesCode(PROCEDURE 9)".



    //Unsupported feature: Code Modification on "GetNoSeriesCode(PROCEDURE 9)".

    //procedure GetNoSeriesCode();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GetSalesSetup;
        IsHandled := FALSE;
        OnBeforeGetNoSeriesCode(Rec,SalesSetup,NoSeriesCode,IsHandled);
        #4..7
          "Document Type"::Quote:
            NoSeriesCode := SalesSetup."Quote Nos.";
          "Document Type"::Order:
            BEGIN    //DSLoc1.01 Localizacion Guatemala
              IF "Pre pedido" THEN    //DSLoc1.01 Localizacion Guatemala
                NoSeriesCode := SalesSetup."Pre Order Nos." //DSLoc1.01 Localizacion Guatemala
              ELSE    //DSLoc1.01 Localizacion Guatemala
                NoSeriesCode := SalesSetup."Order Nos.";
            END;    //DSLoc1.01 Localizacion Guatemala
          "Document Type"::Invoice:
            NoSeriesCode := SalesSetup."Invoice Nos.";
          "Document Type"::"Return Order":
        #20..24
        END;
        OnAfterGetNoSeriesCode(Rec,SalesSetup,NoSeriesCode);
        EXIT(NoSeriesMgt.GetNoSeriesWithCheck(NoSeriesCode,SelectNoSeriesAllowed,"No. Series"));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..10
            NoSeriesCode := SalesSetup."Order Nos.";
        #17..27
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "ConfirmDeletion(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "SalesLinesExist(PROCEDURE 3)".


    //Unsupported feature: Variable Insertion (Variable: TempSalesCommentLine) (VariableCollection) on "RecreateSalesLines(PROCEDURE 4)".



    //Unsupported feature: Code Modification on "RecreateSalesLines(PROCEDURE 4)".

    //procedure RecreateSalesLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF NOT SalesLinesExist THEN
          EXIT;

        #4..24
          ReservEntry.LOCKTABLE;
          MODIFY;
          OnBeforeRecreateSalesLines(Rec);

          SalesLine.RESET;
          SalesLine.SETRANGE("Document Type","Document Type");
          SalesLine.SETRANGE("Document No.","No.");
          OnRecreateSalesLinesOnAfterSetSalesLineFilters(SalesLine);
          IF SalesLine.FINDSET THEN BEGIN
            TempReservEntry.DELETEALL;
            RecreateReservEntryReqLine(TempSalesLine,TempATOLink,ATOLink);
            TransferItemChargeAssgntSalesToTemp(ItemChargeAssgntSales,TempItemChargeAssgntSales);

            SalesLine.DELETEALL(TRUE);
            SalesLine.INIT;
            SalesLine."Line No." := 0;
        #41..63
                  SalesLine.FINDLAST;
                  ExtendedTextAdded := TRUE;
                END;
              SalesLineReserve.CopyReservEntryFromTemp(TempReservEntry,TempSalesLine,SalesLine."Line No.");
              RecreateReqLine(TempSalesLine,SalesLine."Line No.",FALSE);
              SynchronizeForReservations(SalesLine,TempSalesLine);
        #70..76
              END;
            UNTIL TempSalesLine.NEXT = 0;

            CreateItemChargeAssgntSales(TempItemChargeAssgntSales,TempSalesLine,TempInteger);

            TempSalesLine.SETRANGE(Type);
        #83..88
          ERROR(STRSUBSTNO(RecreateSalesLinesCancelErr,ChangedFieldName));

        SalesLine.BlockDynamicTracking(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..27
        #29..35
            StoreSalesCommentLineToTemp(TempSalesCommentLine);
            SalesCommentLine.DeleteComments("Document Type","No.");
            TransferItemChargeAssgntSalesToTemp(ItemChargeAssgntSales,TempItemChargeAssgntSales);
        #38..66
              RestoreSalesCommentLine(TempSalesCommentLine,TempSalesLine."Line No.",SalesLine."Line No.");
        #67..79
            RestoreSalesCommentLine(TempSalesCommentLine,0,0);
        #80..91
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "MessageIfSalesLinesExist(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "PriceMessageIfSalesLinesExist(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateCurrencyFactor(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "SetHideValidationDialog(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "GetHideValidationDialog(PROCEDURE 123)".



    //Unsupported feature: Code Modification on "UpdateLocationCode(PROCEDURE 223)".

    //procedure UpdateLocationCode();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IsHandled := FALSE;
        OnBeforeUpdateLocationCode(Rec,LocationCode,IsHandled);
        IF NOT IsHandled THEN
          //003
          IF "Tipo pedido" <> 1 THEN
          //003
            VALIDATE("Location Code",UserSetupMgt.GetLocation(0,LocationCode,"Responsibility Center"));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
          VALIDATE("Location Code",UserSetupMgt.GetLocation(0,LocationCode,"Responsibility Center"));
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "UpdateSalesLines(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateSalesLinesByFieldNo(PROCEDURE 154)".


    //Unsupported feature: Property Modification (Attributes) on "CreateDim(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "CheckCustomerCreated(PROCEDURE 18)".



    //Unsupported feature: Code Modification on "GetSellToCustomerFaxNo(PROCEDURE 209)".

    //procedure GetSellToCustomerFaxNo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF Customer.GET("Sell-to Customer No.") THEN
          EXIT(Customer."E-Mail 2");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF Customer.GET("Sell-to Customer No.") THEN
          EXIT(Customer."Fax No.");
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "CheckCreditMaxBeforeInsert(PROCEDURE 28)".


    //Unsupported feature: Property Modification (Attributes) on "CreateInvtPutAwayPick(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "CreateTask(PROCEDURE 30)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateShipToAddress(PROCEDURE 31)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDocDim(PROCEDURE 32)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateAllLineDim(PROCEDURE 34)".


    //Unsupported feature: Property Modification (Attributes) on "LookupAdjmtValueEntries(PROCEDURE 37)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustomerVATRegistrationNumber(PROCEDURE 63)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustomerVATRegistrationNumberLbl(PROCEDURE 62)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustomerGlobalLocationNumber(PROCEDURE 164)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustomerGlobalLocationNumberLbl(PROCEDURE 161)".


    //Unsupported feature: Property Modification (Attributes) on "GetPstdDocLinesToRevere(PROCEDURE 39)".


    //Unsupported feature: Property Modification (Attributes) on "CalcInvDiscForHeader(PROCEDURE 45)".


    //Unsupported feature: Property Modification (Attributes) on "SetSecurityFilterOnRespCenter(PROCEDURE 43)".


    //Unsupported feature: Property Modification (Attributes) on "InventoryPickConflict(PROCEDURE 46)".


    //Unsupported feature: Property Modification (Attributes) on "WhseShpmntConflict(PROCEDURE 52)".


    //Unsupported feature: Property Modification (Attributes) on "CheckItemAvailabilityInLines(PROCEDURE 142)".


    //Unsupported feature: Property Modification (Attributes) on "QtyToShipIsZero(PROCEDURE 49)".


    //Unsupported feature: Property Modification (Attributes) on "IsApprovedForPosting(PROCEDURE 53)".


    //Unsupported feature: Property Modification (Attributes) on "IsApprovedForPostingBatch(PROCEDURE 54)".


    //Unsupported feature: Property Modification (Attributes) on "GetLegalStatement(PROCEDURE 60)".


    //Unsupported feature: Property Modification (Attributes) on "SendToPosting(PROCEDURE 57)".


    //Unsupported feature: Property Modification (Attributes) on "CancelBackgroundPosting(PROCEDURE 48)".


    //Unsupported feature: Property Modification (Attributes) on "EmailRecords(PROCEDURE 135)".


    //Unsupported feature: Property Modification (Attributes) on "GetDocTypeTxt(PROCEDURE 140)".


    //Unsupported feature: Property Modification (Attributes) on "LinkSalesDocWithOpportunity(PROCEDURE 79)".


    //Unsupported feature: Property Modification (Attributes) on "SynchronizeAsmHeader(PROCEDURE 56)".


    //Unsupported feature: Property Modification (Attributes) on "CheckShippingAdvice(PROCEDURE 55)".


    //Unsupported feature: Property Modification (Attributes) on "TryGetFilterCustNoRange(PROCEDURE 128)".


    //Unsupported feature: Property Modification (Attributes) on "InvoicedLineExists(PROCEDURE 156)".


    //Unsupported feature: Property Modification (Attributes) on "CreateDimSetForPrepmtAccDefaultDim(PROCEDURE 73)".


    //Unsupported feature: Property Modification (Attributes) on "OpenSalesOrderStatistics(PROCEDURE 70)".


    //Unsupported feature: Property Modification (Attributes) on "GetCardpageID(PROCEDURE 58)".


    //Unsupported feature: Property Modification (Attributes) on "CheckAvailableCreditLimit(PROCEDURE 67)".


    //Unsupported feature: Property Modification (Attributes) on "SetStatus(PROCEDURE 99)".



    //Unsupported feature: Code Modification on "CreateSalesLine(PROCEDURE 78)".

    //procedure CreateSalesLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        OnBeforeCreateSalesLine(TempSalesLine,IsHandled);
        IF IsHandled THEN
          EXIT;

        SalesLine.INIT;
        SalesLine."Line No." := SalesLine."Line No." + 10000;
        SalesLine.VALIDATE(Type,TempSalesLine.Type);
        OnCreateSalesLineOnAfterAssignType(SalesLine,TempSalesLine);
        IF TempSalesLine."No." = '' THEN BEGIN
          SalesLine.VALIDATE(Description,TempSalesLine.Description);
          SalesLine.VALIDATE("Description 2",TempSalesLine."Description 2");
        END ELSE BEGIN
          SalesLine.VALIDATE("No.",TempSalesLine."No.");
          IF SalesLine.Type <> SalesLine.Type::" " THEN BEGIN
            SalesLine.VALIDATE("Unit of Measure Code",TempSalesLine."Unit of Measure Code");
            SalesLine.VALIDATE("Variant Code",TempSalesLine."Variant Code");
            IF TempSalesLine.Quantity <> 0 THEN BEGIN
              SalesLine.VALIDATE(Quantity,TempSalesLine.Quantity);
              SalesLine.VALIDATE("Qty. to Assemble to Order",TempSalesLine."Qty. to Assemble to Order");
            END;
            SalesLine."Purchase Order No." := TempSalesLine."Purchase Order No.";
            SalesLine."Purch. Order Line No." := TempSalesLine."Purch. Order Line No.";
            SalesLine."Drop Shipment" := SalesLine."Purch. Order Line No." <> 0;
            //011
            SantSetup.GET;
            IF SantSetup."Mant. Cant. Al Cambiar Cliente" THEN
              BEGIN
                SalesLine."Cantidad Solicitada" := TempSalesLine."Cantidad Solicitada";
                SalesLine."Cantidad Aprobada" := TempSalesLine."Cantidad Aprobada";
                SalesLine."Cantidad pendiente BO" := TempSalesLine."Cantidad pendiente BO";
                SalesLine."Cantidad a Anular" := TempSalesLine."Cantidad a Anular";
                SalesLine."Cantidad a Ajustar" := TempSalesLine."Cantidad a Ajustar";
                SalesLine."Porcentaje Cant. Aprobada" := SalesLine."Porcentaje Cant. Aprobada";
              END;
            //011
          END;
          SalesLine.VALIDATE("Shipment Date",TempSalesLine."Shipment Date");
        END;
        OnBeforeSalesLineInsert(SalesLine,TempSalesLine);
        SalesLine.INSERT;
        OnAfterCreateSalesLine(SalesLine,TempSalesLine);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..9
          SalesLine.Description := TempSalesLine.Description;
          SalesLine."Description 2" := TempSalesLine."Description 2;
        #12..23
        #36..41
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "OnCheckSalesPostRestrictions(PROCEDURE 115)".


    //Unsupported feature: Property Modification (Attributes) on "OnCustomerCreditLimitExceeded(PROCEDURE 74)".


    //Unsupported feature: Property Modification (Attributes) on "OnCustomerCreditLimitNotExceeded(PROCEDURE 76)".


    //Unsupported feature: Property Modification (Attributes) on "OnCheckSalesReleaseRestrictions(PROCEDURE 81)".


    //Unsupported feature: Property Modification (Attributes) on "CheckSalesReleaseRestrictions(PROCEDURE 162)".


    //Unsupported feature: Property Modification (Attributes) on "DeferralHeadersExist(PROCEDURE 82)".


    //Unsupported feature: Property Modification (Attributes) on "SetSellToCustomerFromFilter(PROCEDURE 186)".


    //Unsupported feature: Property Modification (Attributes) on "CopySellToCustomerFilter(PROCEDURE 44)".


    //Unsupported feature: Property Modification (Attributes) on "BatchConfirmUpdateDeferralDate(PROCEDURE 130)".


    //Unsupported feature: Property Modification (Attributes) on "GetSelectedPaymentServicesText(PROCEDURE 84)".


    //Unsupported feature: Property Modification (Attributes) on "SetDefaultPaymentServices(PROCEDURE 86)".


    //Unsupported feature: Property Modification (Attributes) on "ChangePaymentServiceSetting(PROCEDURE 87)".


    //Unsupported feature: Property Modification (Attributes) on "IsCreditDocType(PROCEDURE 110)".


    //Unsupported feature: Property Modification (Attributes) on "HasSellToAddress(PROCEDURE 94)".


    //Unsupported feature: Property Modification (Attributes) on "HasShipToAddress(PROCEDURE 103)".


    //Unsupported feature: Property Modification (Attributes) on "HasBillToAddress(PROCEDURE 95)".



    //Unsupported feature: Code Modification on "CopyCFDIFieldsFromCustomer(PROCEDURE 1310000)".

    //procedure CopyCFDIFieldsFromCustomer();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF Customer.GET("Bill-to Customer No.") THEN BEGIN
          "CFDI Purpose" := Customer."CFDI Purpose";
          "CFDI Relation" := Customer."CFDI Relation";
        END ELSE
          IF Customer.GET("Sell-to Customer No.") THEN BEGIN
            "CFDI Purpose" := Customer."CFDI Purpose";
            "CFDI Relation" := Customer."CFDI Relation";
          END ELSE BEGIN
            "CFDI Purpose" := '';
            "CFDI Relation" := '';
          END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
          "CFDI Export Code" := Customer."CFDI Export Code";
        #4..7
            "CFDI Export Code" := Customer."CFDI Export Code";
        #8..10
            "CFDI Export Code" := '';
          END;
        */
    //end;


    //Unsupported feature: Code Modification on "CopySellToCustomerAddressFieldsFromCustomer(PROCEDURE 90)".

    //procedure CopySellToCustomerAddressFieldsFromCustomer();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Sell-to Customer Template Code" := '';
        "Sell-to Customer Name" := Cust.Name;
        "Posting Description" := Cust.Name; //GRN 07/08/2013
        "Sell-to Customer Name 2" := Cust."Name 2;
        "Sell-to Phone No." := Cust."Phone No.";
        "Sell-to E-Mail" := Cust."E-Mail";
        IF SellToCustomerIsReplaced OR ShouldCopyAddressFromSellToCustomer(SellToCustomer) THEN BEGIN
          //#5935:Inicio
          //"Sell-to Address" := SellToCustomer.Address;
          "Sell-to Address" := COPYSTR(SellToCustomer.Address,1,MAXSTRLEN("Sell-to Address"));
          //#5935:Fin

          "Sell-to Address 2" := SellToCustomer."Address 2;
          "Sell-to City" := SellToCustomer.City;
          "Sell-to Post Code" := SellToCustomer."Post Code";
          "Sell-to County" := SellToCustomer.County;
          "Sell-to Country/Region Code" := SellToCustomer."Country/Region Code";

          "Ruta de Distribucion" := Cust."Ruta Distribucion";           //#29481
          "Collector Code" := Cust."Collector Code"; //GRN Para llenar el cobrador
            //MDM FE CR
          "E-Mail-FE" := Cust."E-Mail";
            //MDM FE CR
        END;
        IF NOT SkipSellToContact THEN
          "Sell-to Contact" := SellToCustomer.Contact;
        #27..36
        UpdateLocationCode(SellToCustomer."Location Code");

        OnAfterCopySellToCustomerAddressFieldsFromCustomer(Rec,SellToCustomer,CurrFieldNo);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        "Sell-to Customer Template Code" := '';
        "Sell-to Customer Name" := Cust.Name;
        #4..6
        IF SellToCustomerIsReplaced OR
           ShouldCopyAddressFromSellToCustomer(SellToCustomer) OR
           (HasDifferentSellToAddress(SellToCustomer) AND SellToCustomer.HasAddress)
        THEN BEGIN
          "Sell-to Address" := SellToCustomer.Address;
        #13..17
        #24..39
        */
    //end;


    //Unsupported feature: Code Modification on "CopyShipToCustomerAddressFieldsFromCustomer(PROCEDURE 98)".

    //procedure CopyShipToCustomerAddressFieldsFromCustomer();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IsHandled := FALSE;
        OnBeforeCopyShipToCustomerAddressFieldsFromCustomer(Rec,SellToCustomer,IsHandled);
        IF IsHandled THEN
          EXIT;

        "Ship-to Name" := Cust.Name;
        "Ship-to Name 2" := Cust."Name 2;
        IF SellToCustomerIsReplaced OR ShipToAddressEqualsOldSellToAddress THEN BEGIN
          //#5935:Inicio
          //"Ship-to Address" := SellToCustomer.Address;
          "Ship-to Address":=COPYSTR(SellToCustomer.Address,1,MAXSTRLEN("Ship-to Address"));
          //#5935:Fin

          "Ship-to Address 2" := SellToCustomer."Address 2;
          "Ship-to City" := SellToCustomer.City;
          "Ship-to Post Code" := SellToCustomer."Post Code";
        #17..23
          "Tax Area Code" := Cust."Tax Area Code";
          "Tax Liable" := Cust."Tax Liable";
        END;
        //003
        IF "Tipo pedido" <> 1 THEN
        //003
          IF Cust."Location Code" <> '' THEN
            VALIDATE("Location Code",Cust."Location Code");
        "Shipping Agent Code" := Cust."Shipping Agent Code";
        "Shipping Agent Service Code" := Cust."Shipping Agent Service Code";

        OnAfterCopyShipToCustomerAddressFieldsFromCustomer(Rec,SellToCustomer);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..7
        IF SellToCustomerIsReplaced OR
           ShipToAddressEqualsOldSellToAddress OR
           (HasDifferentShipToAddress(SellToCustomer) AND SellToCustomer.HasAddress)
        THEN BEGIN
          "Ship-to Address" := SellToCustomer.Address;
        #14..26
        IF Cust."Location Code" <> '' THEN
          VALIDATE("Location Code",Cust."Location Code");
        #32..35
        */
    //end;


    //Unsupported feature: Code Modification on "CopyShipToCustomerAddressFieldsFromShipToAddr(PROCEDURE 165)".

    //procedure CopyShipToCustomerAddressFieldsFromShipToAddr();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IsHandled := FALSE;
        OnBeforeCopyShipToCustomerAddressFieldsFromShipToAddr(Rec,ShipToAddr,IsHandled);
        IF IsHandled THEN
        #4..13
        "Ship-to Contact" := ShipToAddr.Contact;
        IF ShipToAddr."Shipment Method Code" <> '' THEN
          VALIDATE("Shipment Method Code",ShipToAddr."Shipment Method Code");

        //003
        IF "Tipo pedido" <> 1 THEN
        //003
          IF ShipToAddr."Location Code" <> '' THEN
            VALIDATE("Location Code",ShipToAddr."Location Code");
        "Shipping Agent Code" := ShipToAddr."Shipping Agent Code";
        "Shipping Agent Service Code" := ShipToAddr."Shipping Agent Service Code";
        IF ShipToAddr."Tax Area Code" <> '' THEN
          "Tax Area Code" := ShipToAddr."Tax Area Code";
        "Tax Liable" := ShipToAddr."Tax Liable";

        OnAfterCopyShipToCustomerAddressFieldsFromShipToAddr(Rec,ShipToAddr);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..16
        IF ShipToAddr."Location Code" <> '' THEN
          VALIDATE("Location Code",ShipToAddr."Location Code");
        #23..29
        */
    //end;


    //Unsupported feature: Code Modification on "CopyBillToCustomerAddressFieldsFromCustomer(PROCEDURE 93)".

    //procedure CopyBillToCustomerAddressFieldsFromCustomer();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Bill-to Customer Template Code" := '';
        "Bill-to Name" := BillToCustomer.Name;
        "Bill-to Name 2" := BillToCustomer."Name 2;
        IF BillToCustomerIsReplaced OR ShouldCopyAddressFromBillToCustomer(BillToCustomer) THEN BEGIN

          //#5935:Inicio
          //"Bill-to Address" := BillToCustomer.Address;
          "Bill-to Address":=COPYSTR(BillToCustomer.Address,1,MAXSTRLEN("Bill-to Address"));
          //#5935:Fin

          "Bill-to Address 2" := BillToCustomer."Address 2;
          "Bill-to City" := BillToCustomer.City;
          "Bill-to Post Code" := BillToCustomer."Post Code";
        #14..50
        "Tax Liable" := BillToCustomer."Tax Liable";

        OnAfterSetFieldsBilltoCustomer(Rec,BillToCustomer);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        IF BillToCustomerIsReplaced OR
           ShouldCopyAddressFromBillToCustomer(BillToCustomer) OR
           (HasDifferentBillToAddress(BillToCustomer) AND BillToCustomer.HasAddress)
        THEN BEGIN
          "Bill-to Address" := BillToCustomer.Address;
        #11..53
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "SetShipToAddress(PROCEDURE 117)".



    //Unsupported feature: Code Modification on "ShouldCopyAddressFromBillToCustomer(PROCEDURE 102)".

    //procedure ShouldCopyAddressFromBillToCustomer();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        EXIT((NOT HasBillToAddress) AND BillToCustomer.HasAddress);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        EXIT(((NOT HasBillToAddress) AND BillToCustomer.HasAddress) OR (xRec."Bill-to Contact" <> BillToCustomer.Contact));
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "ShipToAddressEqualsSellToAddress(PROCEDURE 111)".


    //Unsupported feature: Property Modification (Attributes) on "BillToAddressEqualsSellToAddress(PROCEDURE 232)".


    //Unsupported feature: Property Modification (Attributes) on "CopySellToAddressToShipToAddress(PROCEDURE 112)".


    //Unsupported feature: Property Modification (Attributes) on "CopySellToAddressToBillToAddress(PROCEDURE 92)".


    //Unsupported feature: Property Modification (Attributes) on "ConfirmCloseUnposted(PROCEDURE 104)".


    //Unsupported feature: Property Modification (Attributes) on "InitFromSalesHeader(PROCEDURE 109)".


    //Unsupported feature: Property Modification (Attributes) on "SetWorkDescription(PROCEDURE 120)".


    //Unsupported feature: Property Modification (Attributes) on "GetWorkDescription(PROCEDURE 114)".


    //Unsupported feature: Property Modification (Attributes) on "GetWorkDescriptionWorkDescriptionCalculated(PROCEDURE 160)".


    //Unsupported feature: Property Modification (Attributes) on "SetAllowSelectNoSeries(PROCEDURE 100)".


    //Unsupported feature: Property Modification (Attributes) on "SelltoCustomerNoOnAfterValidate(PROCEDURE 125)".


    //Unsupported feature: Property Modification (Attributes) on "SelectSalesHeaderCustomerTemplate(PROCEDURE 127)".


    //Unsupported feature: Property Modification (Attributes) on "RecallModifyAddressNotification(PROCEDURE 148)".


    //Unsupported feature: Property Modification (Attributes) on "GetModifyCustomerAddressNotificationId(PROCEDURE 193)".


    //Unsupported feature: Property Modification (Attributes) on "GetModifyBillToCustomerAddressNotificationId(PROCEDURE 191)".


    //Unsupported feature: Property Modification (Attributes) on "GetLineInvoiceDiscountResetNotificationId(PROCEDURE 307)".


    //Unsupported feature: Property Modification (Attributes) on "SetModifyCustomerAddressNotificationDefaultState(PROCEDURE 89)".


    //Unsupported feature: Property Modification (Attributes) on "SetModifyBillToCustomerAddressNotificationDefaultState(PROCEDURE 91)".


    //Unsupported feature: Property Modification (Attributes) on "DontNotifyCurrentUserAgain(PROCEDURE 141)".


    //Unsupported feature: Property Modification (Attributes) on "HasDifferentSellToAddress(PROCEDURE 195)".


    //Unsupported feature: Property Modification (Attributes) on "HasDifferentBillToAddress(PROCEDURE 192)".


    //Unsupported feature: Property Modification (Attributes) on "HasDifferentShipToAddress(PROCEDURE 1059)".


    //Unsupported feature: Property Modification (Attributes) on "ShowInteractionLogEntries(PROCEDURE 131)".


    //Unsupported feature: Property Modification (Attributes) on "GetBillToNo(PROCEDURE 132)".


    //Unsupported feature: Property Modification (Attributes) on "GetCurrencySymbol(PROCEDURE 146)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateSalesPersonOnSalesHeader(PROCEDURE 218)".


    //Unsupported feature: Property Modification (Attributes) on "TestQuantityShippedField(PROCEDURE 190)".


    //Unsupported feature: Property Modification (Attributes) on "TestStatusOpen(PROCEDURE 134)".


    //Unsupported feature: Property Modification (Attributes) on "SuspendStatusCheck(PROCEDURE 133)".


    //Unsupported feature: Property Modification (Attributes) on "CheckForBlockedLines(PROCEDURE 220)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitRecord(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitNoSeries(PROCEDURE 35)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckCreditLimitCondition(PROCEDURE 290)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckCreditMaxBeforeInsert(PROCEDURE 237)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckBillToCust(PROCEDURE 321)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckSellToCust(PROCEDURE 319)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckShippingAdvice(PROCEDURE 330)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterConfirmSalesPrice(PROCEDURE 183)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterRecreateSalesLine(PROCEDURE 152)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterDeleteAllTempSalesLines(PROCEDURE 155)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitFromSalesHeader(PROCEDURE 246)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInsertTempSalesLine(PROCEDURE 158)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterIsApprovedForPosting(PROCEDURE 219)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterIsApprovedForPostingBatch(PROCEDURE 221)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetNoSeriesCode(PROCEDURE 166)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetPostingNoSeriesCode(PROCEDURE 175)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetPrepaymentPostingNoSeriesCode(PROCEDURE 178)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetSalesSetup(PROCEDURE 249)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetDocTypeText(PROCEDURE 257)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterTestNoSeries(PROCEDURE 136)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateShipToAddress(PROCEDURE 137)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateCurrencyFactor(PROCEDURE 180)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAppliesToDocNoOnLookup(PROCEDURE 163)".


    //Unsupported feature: Property Modification (Attributes) on "OnUpdateSalesLineByChangedFieldName(PROCEDURE 139)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateDimTableIDs(PROCEDURE 138)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterValidateShortcutDimCode(PROCEDURE 176)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateSalesLine(PROCEDURE 147)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterIsShipToAddressEqualToSellToAddress(PROCEDURE 230)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSalesQuoteAccepted(PROCEDURE 143)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterChangePricesIncludingVAT(PROCEDURE 187)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSendSalesHeader(PROCEDURE 144)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSetApplyToFilters(PROCEDURE 227)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSetFieldsBilltoCustomer(PROCEDURE 151)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterTransferExtendedTextForSalesLineRecreation(PROCEDURE 145)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromSellToCustTemplate(PROCEDURE 184)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopySellToAddressToShipToAddress(PROCEDURE 198)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopySellToAddressToBillToAddress(PROCEDURE 200)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopySellToCustomerAddressFieldsFromCustomer(PROCEDURE 177)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyShipToCustomerAddressFieldsFromCustomer(PROCEDURE 173)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyShipToCustomerAddressFieldsFromShipToAddr(PROCEDURE 174)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckCreditLimit(PROCEDURE 196)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckCreditMaxBeforeInsert(PROCEDURE 235)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckCreditLimitIfLineNotInsertedYet(PROCEDURE 238)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeConfirmBillToContactNoChange(PROCEDURE 229)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeConfirmUpdateCurrencyFactor(PROCEDURE 241)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCopyShipToCustomerAddressFieldsFromCustomer(PROCEDURE 231)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCopyShipToCustomerAddressFieldsFromShipToAddr(PROCEDURE 260)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCreateSalesLine(PROCEDURE 244)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeGetNoSeriesCode(PROCEDURE 309)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeGetPostingNoSeriesCode(PROCEDURE 212)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInitInsert(PROCEDURE 208)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInitRecord(PROCEDURE 210)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeIsCreditDocType(PROCEDURE 226)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateCurrencyFactor(PROCEDURE 153)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforePriceMessageIfSalesLinesExist(PROCEDURE 243)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeRecreateSalesLines(PROCEDURE 197)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeRecreateSalesLinesHandler(PROCEDURE 251)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeSalesLineByChangedFieldNo(PROCEDURE 168)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeSalesLineInsert(PROCEDURE 169)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeTestNoSeries(PROCEDURE 213)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeSetSecurityFilterOnRespCenter(PROCEDURE 207)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateAllLineDim(PROCEDURE 236)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateLocationCode(PROCEDURE 228)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateSalesLineAmounts(PROCEDURE 262)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateSalesLinesByFieldNo(PROCEDURE 303)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateShipToAddress(PROCEDURE 254)".


    //Unsupported feature: Property Modification (Attributes) on "OnCheckItemAvailabilityInLinesOnAfterSetFilters(PROCEDURE 242)".


    //Unsupported feature: Property Modification (Attributes) on "OnCollectParamsInBufferForCreateDimSetOnAfterSetTempSalesLineFilters(PROCEDURE 255)".


    //Unsupported feature: Property Modification (Attributes) on "OnCopySelltoCustomerAddressFieldsFromCustomerOnAfterAssignRespCenter(PROCEDURE 182)".


    //Unsupported feature: Property Modification (Attributes) on "OnCreateDimOnBeforeUpdateLines(PROCEDURE 222)".


    //Unsupported feature: Property Modification (Attributes) on "OnCreateSalesLineOnAfterAssignType(PROCEDURE 185)".


    //Unsupported feature: Property Modification (Attributes) on "OnInitFromContactOnBeforeInitRecord(PROCEDURE 245)".


    //Unsupported feature: Property Modification (Attributes) on "OnInitFromTemplateOnBeforeInitRecord(PROCEDURE 250)".


    //Unsupported feature: Property Modification (Attributes) on "OnInitInsertOnBeforeInitRecord(PROCEDURE 179)".


    //Unsupported feature: Property Modification (Attributes) on "OnInsertTempSalesLineInBufferOnBeforeTempSalesLineInsert(PROCEDURE 256)".


    //Unsupported feature: Property Modification (Attributes) on "OnUpdateBillToCustOnAfterSalesQuote(PROCEDURE 188)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateBilltoCustomerTemplateCodeBeforeRecreateSalesLines(PROCEDURE 171)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateSellToCustomerNoAfterInit(PROCEDURE 206)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterTestQuantityShippedField(PROCEDURE 189)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeTestSalesLineFieldsBeforeRecreate(PROCEDURE 217)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeTestStatusOpen(PROCEDURE 202)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterTestStatusOpen(PROCEDURE 201)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateBillToCont(PROCEDURE 199)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateSellToCont(PROCEDURE 203)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateSellToCust(PROCEDURE 204)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateSalesLines(PROCEDURE 205)".


    //Unsupported feature: Property Modification (Attributes) on "OnRecreateSalesLinesOnAfterSetSalesLineFilters(PROCEDURE 239)".


    //Unsupported feature: Property Modification (Attributes) on "OnRecreateSalesLinesOnBeforeConfirm(PROCEDURE 211)".


    //Unsupported feature: Property Modification (Attributes) on "OnUpdateAllLineDimOnBeforeSalesLineModify(PROCEDURE 247)".


    //Unsupported feature: Property Modification (Attributes) on "OnUpdateSalesLinesByFieldNoOnBeforeSalesLineModify(PROCEDURE 240)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidatePaymentTermsCodeOnBeforeCalcDueDate(PROCEDURE 224)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidatePaymentTermsCodeOnBeforeCalcPmtDiscDate(PROCEDURE 225)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidatePaymentTermsCodeOnBeforeValidateDueDate(PROCEDURE 253)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidatePaymentTermsCodeOnBeforeValidateDueDateWhenBlank(PROCEDURE 252)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidatePostingDateOnBeforeAssignDocumentDate(PROCEDURE 234)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidatePricesIncludingVATOnBeforeSalesLineModify(PROCEDURE 214)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateShippingAgentCodeOnBeforeUpdateLines(PROCEDURE 215)".


    local procedure StoreSalesCommentLineToTemp(var TempSalesCommentLine: Record 44 temporary)
    var
        SalesCommentLine: Record 44;
    begin
        SalesCommentLine.SETRANGE("Document Type","Document Type");
        SalesCommentLine.SETRANGE("No.","No.");
        IF SalesCommentLine.FINDSET THEN
          REPEAT
            TempSalesCommentLine := SalesCommentLine;
            TempSalesCommentLine.INSERT;
          UNTIL SalesCommentLine.NEXT = 0;
    end;

    local procedure RestoreSalesCommentLine(var TempSalesCommentLine: Record 44 temporary;OldDocumentLineNo: Integer;NewDocumentLineNo: Integer)
    begin
        TempSalesCommentLine.SETRANGE("Document Type","Document Type");
        TempSalesCommentLine.SETRANGE("No.","No.");
        TempSalesCommentLine.SETRANGE("Document Line No.",OldDocumentLineNo);
        IF TempSalesCommentLine.FINDSET THEN
          REPEAT
            SalesCommentLine := TempSalesCommentLine;
            SalesCommentLine."Document Line No." := NewDocumentLineNo;
            SalesCommentLine.INSERT;
          UNTIL TempSalesCommentLine.NEXT = 0;
    end;

    procedure SetCalledFromWhseDoc(NewCalledFromWhseDoc: Boolean)
    begin
        CalledFromWhseDoc := NewCalledFromWhseDoc;
    end;

    local procedure UpdatePrepmtAmounts(var SalesLine Record: 37")
    var
        Currency: Record 4;
    begin
        Currency.Initialize("Currency Code");
        IF "Document Type" = "Document Type"::Order THEN BEGIN
          SalesLine."Prepmt. Line Amount" := ROUND(
              SalesLine."Line Amount" * SalesLine."Prepayment %" / 100,Currency."Amount Rounding Precision");
          IF ABS(SalesLine."Inv. Discount Amount" + SalesLine."Prepmt. Line Amount") > ABS(SalesLine."Line Amount") THEN
            SalesLine."Prepmt. Line Amount" := SalesLine."Line Amount" - SalesLine."Inv. Discount Amount";
        END;
    end;

    procedure ShouldSearchForCustomerByName(CustomerNo: Code[20]): Boolean
    begin
        EXIT(ShouldLookForCustomerByName(CustomerNo));
    end;

    var
        LocationCode: Code[10];


    //Unsupported feature: Property Modification (TextConstString) on "ConfirmChangeQst(Variable 1004)".

    //var
        //>>>> ORIGINAL VALUE:
        //ConfirmChangeQst : @@@="%1 = a Field Caption like Currency Code";ENU=Do you want to change %1?;ESM=¿Confirma que desea cambiar %1?;FRC=Désirez-vous modifier %1?;ENC=Do you want to change %1?;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ConfirmChangeQst : @@@="%1 = a Field Caption like Currency Code";ENU=Do you want to change %1?;ESM=¿Confirma que desea cambiar %1?;FRC=Souhaitez-vous modifier la valeur du champ %1 ?;ENC=Do you want to change %1?;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text014(Variable 1014)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text014 : ENU=Deleting this document will cause a gap in the number series for posted credit memos. An empty posted credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?;ESM=Si elimina el documento, se provocará una discontinuidad en la numeración de la serie de notas de crédito registradas. Se creará un nota crédito regis. en blanco %1 para completar este error en las series numéricas.\\¿Desea continuar?;FRC=La suppression de ce document va engendrer un écart dans la série de numéros d'avoirs reportés. Un avoir reporté vide %1 va être créé pour éviter un écart dans la série de numéros.\\Voulez-vous continuer ?;ENC=Deleting this document will cause a gap in the number series for posted credit memos. An empty posted credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text014 : ENU=Deleting this document will cause a gap in the number series for posted credit memos. An empty posted credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?;ESM=Si elimina el documento, se provocará una discontinuidad en la serie numérica de notas de crédito registradas. Se creará una nota de crédito registrada en blanco %1 para completar este error en la serie numérica.\\¿Desea continuar?;FRC=La suppression de ce document va engendrer un écart dans la série de numéros des notes de crédit reportées. Une note de crédit reportée vide %1 va être créée pour éviter un écart dans la série de numéros.\\Voulez-vous continuer?;ENC=Deleting this document will cause a gap in the number series for posted credit memos. An empty posted credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text039(Variable 1086)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text039 : ENU=Contact %1 %2 is not related to a customer.;ESM=Contacto %1 %2 no está relacionado con un cliente.;FRC=Le contact %1 %2 n'est pas associé à un client.;ENC=Contact %1 %2 is not related to a customer.;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text039 : ENU=Contact %1 %2 is not related to a customer.;ESM=El contacto %1 %2 no está relacionado con un cliente.;FRC=Le contact %1 %2 n'est associé à aucun client.;ENC=Contact %1 %2 is not related to a customer.;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "PostedDocsToPrintCreatedMsg(Variable 1084)".

    //var
        //>>>> ORIGINAL VALUE:
        //PostedDocsToPrintCreatedMsg : ENU=One or more related posted documents have been generated during deletion to fill gaps in the posting number series. You can view or print the documents from the respective document archive.;ESM=Durante la eliminación, se han generado uno o más documentos registrados relacionados en sustitución de los números de registro que faltan de la serie. Puede ver o imprimir los documentos del archivo de documentos correspondiente.;FRC=Un ou plusieurs documents reportés connexes ont été générés lors de la suppression pour éviter une discontinuité dans la série de numéros de report. Vous pouvez afficher ou imprimer les documents à partir de l'archive de document correspondant.;ENC=One or more related posted documents have been generated during deletion to fill gaps in the posting number series. You can view or print the documents from the respective document archive.;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //PostedDocsToPrintCreatedMsg : ENU=One or more related posted documents have been generated during deletion to fill gaps in the posting number series. You can view or print the documents from the respective document archive.;ESM=Durante la eliminación, se han generado uno o más documentos registrados relacionados en sustitución de los números de registro que faltan de la serie. Puede ver o imprimir los documentos del archivo de documentos correspondiente.;FRC=Un ou plusieurs documents reportés connexes ont été générés lors de la suppression pour éviter des écarts dans la série de numéros de report. Vous pouvez afficher ou imprimer les documents à partir de l'archive du document correspondant.;ENC=One or more related posted documents have been generated during deletion to fill gaps in the posting number series. You can view or print the documents from the respective document archive.;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "ValidVATNoMsg(Variable 1254)".

    //var
        //>>>> ORIGINAL VALUE:
        //ValidVATNoMsg : ENU=The tax registration number is valid.;ESM=El RFC/Curp es válido.;FRC=Le numéro d'identification TVA est valide.;ENC=The GST/HST Registration Number is valid.;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ValidVATNoMsg : ENU=The specified Tax registration number is valid.;ESM=El CIF/NIF especificado es válido.;FRC=Le numéro d'enregistrement TVA spécifié est valide.;ENC=The specified GST/HST Registration Number is valid.;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "ConfirmEmptyEmailQst(Variable 1017)".

    //var
        //>>>> ORIGINAL VALUE:
        //ConfirmEmptyEmailQst : @@@=%1 - Contact No., %2 - Email;ENU=Contact %1 has no email address specified. The value in the Email field on the sales order, %2, will be deleted. Do you want to continue?;ESM=El contacto %1 no tiene una dirección de correo electrónico especificada. Se eliminará el valor del campo Correo electrónico del pedido de venta, %2. ¿Desea continuar?;FRC=Le contact %1 n'a pas d'adresse de courriel spécifiée. La valeur du champ Courriel sur le document de vente, %2, sera supprimée. Souhaitez-vous continuer?;ENC=Contact %1 has no email address specified. The value in the Email field on the sales order, %2, will be deleted. Do you want to continue?;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ConfirmEmptyEmailQst : @@@=%1 - Contact No., %2 - Email;ENU=Contact %1 has no email address specified. The value in the Email field on the sales order, %2, will be deleted. Do you want to continue?;ESM=El contacto %1 no tiene ninguna dirección de correo electrónico especificada. Se eliminará el valor del campo Correo electrónico del pedido de venta, %2. ¿Desea continuar?;FRC=Le contact %1 n'a pas d'adresse de courriel spécifiée. La valeur du champ Courriel sur le document de vente, %2, sera supprimée. Souhaitez-vous continuer?;ENC=Contact %1 has no email address specified. The value in the Email field on the sales order, %2, will be deleted. Do you want to continue?;
        //Variable type has not been exported.

    var
        CalledFromWhseDoc: Boolean;
}

