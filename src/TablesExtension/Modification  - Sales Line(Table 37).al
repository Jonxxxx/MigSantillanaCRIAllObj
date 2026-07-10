tableextension 70000045 tableextension70000045 extends "Sales Line"
{
    fields
    {
        modify("Document Type")
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';

            //Unsupported feature: Property Modification (OptionString) on ""Document Type"(Field 1)".

        }
        modify("Sell-to Customer No.")
        {
            TableRelation = Customer;
        }
        modify("No.")
        {
            TableRelation = IF (Type = CONST(" ")) "Standard Text"
            ELSE IF (Type = CONST(G/L Account),
                                     System-Created Entry=CONST(false)) "G/L Account" WHERE (Direct Posting=CONST(true),
                                                                                          Account Type=CONST(Posting),
                                                                                          Blocked=CONST(false))
                                                                                          ELSE IF (Type=CONST(G/L Account),
                                                                                                   System-Created Entry=CONST(true)) "G/L Account"
                                                                                                   ELSE IF (Type=CONST(Resource)) Resource
                                                                                                   ELSE IF (Type=CONST(Fixed Asset)) "Fixed Asset"
                                                                                                   ELSE IF (Type=CONST("Charge (Item)")) "Item Charge"
                                                                                                   ELSE IF (Type=CONST(Item),
                                                                                                            Document Type=FILTER(<>Credit Memo&<>Return Order)) Item WHERE (Blocked=CONST(false),
                                                                                                                                                                            Sales Blocked=CONST(false))
                                                                                                                                                                            ELSE IF (Type=CONST(Item),
                                                                                                                                                                                     Document Type=FILTER(Credit Memo|Return Order)) Item WHERE (Blocked=CONST(false));
        }
        modify("Location Code")
        {
            TableRelation = Location WHERE (Use As In-Transit=CONST(false));
        }
        modify(Description)
        {
            TableRelation = IF (Type=CONST(G/L Account),
                                System-Created Entry=CONST(false),
                                No.=CONST('')) "G/L Account".Name WHERE (Direct Posting=CONST(true),
                                                                         Account Type=CONST(Posting),
                                                                         Blocked=CONST(false))
                                                                         ELSE IF (Type=CONST(G/L Account),
                                                                                  System-Created Entry=CONST(true),
                                                                                  No.=CONST('')) "G/L Account".Name
                                                                                  ELSE IF (Type=CONST(Item),
                                                                                           Document Type=FILTER(<>Credit Memo&<>Return Order),
                                                                                           No.=CONST('')) Item.Description WHERE (Blocked=CONST(false),
                                                                                                                                  Sales Blocked=CONST(false))
                                                                                                                                  ELSE IF (Type=CONST(Item),
                                                                                                                                           Document Type=FILTER(Credit Memo|Return Order),
                                                                                                                                           No.=CONST('')) Item.Description WHERE (Blocked=CONST(false))
                                                                                                                                           ELSE IF (Type=CONST(Resource),
                                                                                                                                                    No.=CONST('')) Resource.Name
                                                                                                                                                    ELSE IF (Type=CONST(Fixed Asset),
                                                                                                                                                             No.=CONST('')) "Fixed Asset".Description
                                                                                                                                                             ELSE IF (Type=CONST("Charge (Item)"),
                                                                                                                                                                      No.=CONST('')) "Item Charge".Description;
        }

        //Unsupported feature: Property Modification (Data type) on ""Description 2"(Field 12)".

        modify("Shortcut Dimension 1 Code")
        {
            Caption = 'Shortcut Dimension 1 Code';
        }
        modify("Shortcut Dimension 2 Code")
        {
            Caption = 'Shortcut Dimension 2 Code';
        }
        modify("Bill-to Customer No.")
        {
            TableRelation = Customer;
        }
        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Gen. Bus. Posting Group';
        }
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        modify("Attached to Line No.")
        {
            Caption = 'Attached to Line No.';
        }
        modify("Area")
        {
            Caption = 'Area';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'VAT Bus. Posting Group';
        }
        modify("VAT Prod. Posting Group")
        {
            Caption = 'VAT Prod. Posting Group';
        }
        modify("IC Partner Ref. Type")
        {
            Caption = 'IC Partner Ref. Type';
        }
        modify("Job Contract Entry No.")
        {
            Caption = 'Job Contract Entry No.';
        }
        modify("Unit of Measure Code")
        {
            Caption = 'Unit of Measure Code';
        }
        modify("Depr. until FA Posting Date")
        {
            Caption = 'Depr. until FA Posting Date';
        }
        modify("Duplicate in Depreciation Book")
        {
            Caption = 'Duplicate in Depreciation Book';
        }
        modify("Originally Ordered No.")
        {
            TableRelation = IF (Type=CONST(Item)) Item;
        }
        modify("BOM Item No.")
        {
            TableRelation = Item;
        }
        modify(Subtype)
        {
            OptionCaption = ' ,Item - Inventory,Item - Service,Comment';
        }

        //Unsupported feature: Property Deletion (Description) on ""Sell-to Customer No."(Field 2)".


        //Unsupported feature: Code Modification on ""No."(Field 6).OnValidate".

        //trigger "(Field 6)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            GetSalesSetup;

            "No." := FindOrCreateRecordByNo("No.");

            TestJobPlanningLine;
            TestStatusOpen;
            CheckItemAvailable(FIELDNO("No."));

            IF (xRec."No." <> "No.") AND (Quantity <> 0) THEN BEGIN
              TESTFIELD("Qty. to Asm. to Order (Base)",0);
              CALCFIELDS("Reserved Qty. (Base)");
              TESTFIELD("Reserved Qty. (Base)",0);
              IF Type = Type::Item THEN
                WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
              OnValidateNoOnAfterVerifyChange(Rec,xRec);
            END;

            TESTFIELD("Qty. Shipped Not Invoiced",0);
            TESTFIELD("Quantity Shipped",0);
            TESTFIELD("Shipment No.",'');

            TESTFIELD("Prepmt. Amt. Inv.",0);

            TESTFIELD("Return Qty. Rcd. Not Invd.",0);
            TESTFIELD("Return Qty. Received",0);
            TESTFIELD("Return Receipt No.",'');

            IF "No." = '' THEN
              ATOLink.DeleteAsmFromSalesLine(Rec);
            CheckAssocPurchOrder(FIELDCAPTION("No."));
            AddOnIntegrMgt.CheckReceiptOrderStatus(Rec);

            OnValidateNoOnBeforeInitRec(Rec,xRec,CurrFieldNo);
            TempSalesLine := Rec;
            INIT;
            IF xRec."Line Amount" <> 0 THEN
              "Recalculate Invoice Disc." := TRUE;
            Type := TempSalesLine.Type;
            "No." := TempSalesLine."No.";
            OnValidateNoOnCopyFromTempSalesLine(Rec,TempSalesLine);
            IF "No." = '' THEN
              EXIT;

            IF HasTypeToFillMandatoryFields THEN
              Quantity := TempSalesLine.Quantity;

            "System-Created Entry" := TempSalesLine."System-Created Entry";
            GetSalesHeader;
            InitHeaderDefaults(SalesHeader);
            OnValidateNoOnAfterInitHeaderDefaults(SalesHeader,TempSalesLine);

            CALCFIELDS("Substitution Available");

            "Promised Delivery Date" := SalesHeader."Promised Delivery Date";
            "Requested Delivery Date" := SalesHeader."Requested Delivery Date";
            "Shipment Date" :=
              CalendarMgmt.CalcDateBOC(
                '',SalesHeader."Shipment Date",CalChange."Source Type"::Location,"Location Code",'',
                CalChange."Source Type"::"Shipping Agent","Shipping Agent Code","Shipping Agent Service Code",FALSE);

            IsHandled := FALSE;
            OnValidateNoOnBeforeUpdateDates(Rec,xRec,SalesHeader,CurrFieldNo,IsHandled,TempSalesLine);
            IF NOT IsHandled THEN
              UpdateDates;

            OnAfterAssignHeaderValues(Rec,SalesHeader);

            CASE Type OF
              Type::" ":
                CopyFromStandardText;
              Type::"G/L Account":
                CopyFromGLAccount;
              Type::Item:
                BEGIN
                  CopyFromItem;

                  //012 Se buscan las adopciones, si existe, se llenan los datos
                  IF SalesHeader."Salesperson Code" = '' THEN
                    SalesHeader."Salesperson Code" := TempSalesLine."Cod. Vendedor";
                  IF SalesHeader."Salesperson Code" <> '' THEN
                    BEGIN
                      //Se busca la Ruta del Promotor para tener el Nivel
                      PromotorRuta.RESET;
                      PromotorRuta.SETRANGE("Cod. Promotor",SalesHeader."Salesperson Code");
                      IF PromotorRuta.FINDFIRST THEN
                         BEGIN
                          //Se buscar el Nivel de ese Colegio para esa Ruta
                          ColNivel.RESET;
                          ColNivel.SETRANGE("Cod. Colegio",SalesHeader."Bill-to Contact No.");
                          ColNivel.SETRANGE(Ruta,PromotorRuta."Cod. Ruta");
                          IF ColNivel.FINDFIRST THEN;

                          AdopcionesDetalle.RESET;
                          AdopcionesDetalle.SETCURRENTKEY("Cod. Colegio","Cod. Promotor","Cod. Producto");
                          AdopcionesDetalle.SETRANGE("Cod. Colegio",SalesHeader."Bill-to Contact No.");
                          AdopcionesDetalle.SETRANGE("Cod. Promotor",SalesHeader."Salesperson Code");
                          AdopcionesDetalle.SETRANGE("Cod. Nivel",ColNivel."Cod. Nivel");
                          AdopcionesDetalle.SETRANGE("Cod. Producto","No.");
                          IF AdopcionesDetalle.FINDFIRST THEN
                             BEGIN
                              Adopcion           := AdopcionesDetalle.Adopcion;
                              "Cod. Vendedor"    := SalesHeader."Salesperson Code";
                              "Cantidad Alumnos" := AdopcionesDetalle."Cantidad Alumnos";
                              "Cod. Colegio"     := AdopcionesDetalle."Cod. Colegio";
                             END;
                         END;
                     END;
                END;
              Type::Resource:
                CopyFromResource;
              Type::"Fixed Asset":
                CopyFromFixedAsset;
              Type::"Charge (Item)":
                CopyFromItemCharge;
            END;

            OnAfterAssignFieldsForNo(Rec,xRec,SalesHeader);

            IF Type <> Type::" " THEN BEGIN
              PostingSetupMgt.CheckGenPostingSetupSalesAccount("Gen. Bus. Posting Group","Gen. Prod. Posting Group");
              PostingSetupMgt.CheckGenPostingSetupCOGSAccount("Gen. Bus. Posting Group","Gen. Prod. Posting Group");
              PostingSetupMgt.CheckVATPostingSetupSalesAccount("VAT Bus. Posting Group","VAT Prod. Posting Group");
            END;

            IF HasTypeToFillMandatoryFields AND (Type <> Type::"Fixed Asset") THEN
              VALIDATE("VAT Prod. Posting Group");

            UpdatePrepmtSetupFields;

            IF HasTypeToFillMandatoryFields THEN BEGIN
              VALIDATE("Unit of Measure Code");
              IF Quantity <> 0 THEN BEGIN
                InitOutstanding;
                IF IsCreditDocType THEN
                  InitQtyToReceive
                ELSE
                  InitQtyToShip;
                InitQtyToAsm;
                UpdateWithWarehouseShip;
              END;
              UpdateUnitPrice(FIELDNO("No."));
            END;

            OnValidateNoOnAfterUpdateUnitPrice(Rec,xRec);

            CreateDim(
              DimMgt.TypeToTableID3(Type),"No.",
              DATABASE::Job,"Job No.",
              DATABASE::"Responsibility Center","Responsibility Center");

            IF "No." <> xRec."No." THEN BEGIN
              IF Type = Type::Item THEN
                IF (Quantity <> 0) AND ItemExists(xRec."No.") THEN BEGIN
                  ReserveSalesLine.VerifyChange(Rec,xRec);
                  WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
                END;
              GetDefaultBin;
              AutoAsmToOrder;
              DeleteItemChargeAssgnt("Document Type","Document No.","Line No.");
              IF Type = Type::"Charge (Item)" THEN
                DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");
            END;

            UpdateItemCrossRef;

            IF GUIALLOWED THEN BEGIN // 021-YFC
              IF "Document Type" = "Document Type"::Order THEN //GRN 20/10/11 Para que solo pregunte cuando es Pedido
                 BEGIN
                   IF NOT Temporal THEN //AMS 07/02/12 Control para no desplegar el mensaje si la inserción
                                        //viene hecha por el proceso que calcula la tarifa
                     BEGIN
                       SalesHeader2.RESET;
                       SalesHeader2.SETRANGE("No.","Document No.");
                       SalesHeader2.SETRANGE("Document Type","Document Type");
                       IF SalesHeader2.FINDFIRST THEN;

                       SalesLine2.RESET;
                       SalesLine2.SETRANGE("Document Type",SalesLine2."Document Type"::Order);
                       SalesLine2.SETRANGE("Sell-to Customer No.","Sell-to Customer No.");
                       SalesLine2.SETRANGE(Type,Type);
                       SalesLine2.SETRANGE("No.","No.");

                      IF SalesHeader2."Registrado TPV" = FALSE THEN BEGIN
                       IF SalesLine2.FINDFIRST THEN
                          IF NOT CONFIRM(txt003,FALSE,SalesLine2."Document No.") THEN
                             VALIDATE("No.",'');
                      END;
                     END;
                 END
            END; // 021-YFC
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..73
                CopyFromItem;
            #109..164
            */
        //end;

        //Unsupported feature: Property Deletion (Description) on ""No."(Field 6)".


        //Unsupported feature: Property Deletion (Description) on ""Location Code"(Field 7)".



        //Unsupported feature: Code Modification on "Description(Field 11).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF Type = Type::" " THEN
              EXIT;

            IF "No." <> '' THEN
              EXIT;

            CASE Type OF
              Type::Item:
                BEGIN
                  //005
                  IF Users.GET(USERID) THEN
                    BEGIN
                      IF NOT Users."Modifica Desc. prod. Lin. Vta." THEN
                          IF "Document Type" IN ["Document Type"::Order,"Document Type"::Invoice] THEN
                          ERROR(Err001,FIELDCAPTION(Description));
                    END
                  ELSE
                    ERROR(Err001,FIELDCAPTION(Description));
                  //005
                  IF STRLEN(Description) <= MAXSTRLEN(Item."No.") THEN
                    DescriptionIsNo := Item.GET(Description)
                  ELSE
                    DescriptionIsNo := FALSE;

                  IF NOT DescriptionIsNo THEN BEGIN
                    Item.SETRANGE(Blocked,FALSE);
                    Item.SETRANGE("Sales Blocked",FALSE);

                    // looking for an item with exact description
                    Item.SETRANGE(Description,Description);
                    IF Item.FINDFIRST THEN BEGIN
                      VALIDATE("No.",Item."No.");
                      EXIT;
                    END;

                    // looking for an item with similar description
                    Item.SETFILTER(Description,'''@' + CONVERTSTR(Description,'''','?') + '''');
                    IF Item.FINDFIRST THEN BEGIN
                      VALIDATE("No.",Item."No.");
                      EXIT;
                    END;
                  END;

                  GetSalesSetup;
                  DefaultCreate := ("No." = '') AND SalesSetup."Create Item from Description";
                  IF Item.TryGetItemNoOpenCard(
                       ReturnValue,Description,DefaultCreate,NOT GetHideValidationDialog,TRUE)
                  THEN
                    CASE ReturnValue OF
                      '':
                        BEGIN
                          LookupRequested := TRUE;
                          Description := xRec.Description;
                        END;
                      "No.":
                        Description := xRec.Description;
                      ELSE BEGIN
                        CurrFieldNo := FIELDNO("No.");
                        VALIDATE("No.",COPYSTR(ReturnValue,1,MAXSTRLEN(Item."No.")));
                      END;
                    END;
                END;
              ELSE BEGIN
                IsHandled := FALSE;
                OnBeforeFindNoByDescription(Rec,xRec,CurrFieldNo,IsHandled);
                IF NOT IsHandled THEN BEGIN
                  ReturnValue := FindRecordMgt.FindNoByDescription(Type,Description,TRUE);
                  IF ReturnValue <> '' THEN BEGIN
                    CurrFieldNo := FIELDNO("No.");
                    VALIDATE("No.",COPYSTR(ReturnValue,1,MAXSTRLEN("No.")));
                  END;
                END;
              END;
            END;

            IsHandled := FALSE;
            OnValidateDescriptionOnBeforeCannotFindDescrError(Rec,xRec,IsHandled);
            IF NOT IsHandled THEN
              IF ("No." = '') AND GUIALLOWED AND ApplicationAreaMgmtFacade.IsFoundationEnabled THEN
                IF "Document Type" IN
                   ["Document Type"::Order,"Document Type"::Invoice,"Document Type"::Quote,"Document Type"::"Credit Memo"]
                THEN
                  ERROR(CannotFindDescErr,Type,Description);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..9
            #20..83
            */
        //end;


        //Unsupported feature: Code Modification on "Quantity(Field 15).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*

            //003
            VALIDATE("Cod. Cupon",'');
            //003

            //007
            IF Quantity < 0 THEN
              ERROR(Error005);
            //007

            //008
            IF "Linea Copiada" THEN
              BEGIN
                Precio := "Unit Price";
                "%Desc" := "Line Discount %";
              END;
            //008

            TestJobPlanningLine;
            TestStatusOpen;

            CheckAssocPurchOrder(FIELDCAPTION(Quantity));

            IF "Shipment No." <> '' THEN
              CheckShipmentRelation
            ELSE
              IF "Return Receipt No." <> '' THEN
                CheckRetRcptRelation;

            "Quantity (Base)" := CalcBaseQty(Quantity);

            OnValidateQuantityOnAfterCalcBaseQty(Rec,xRec);

            IF IsCreditDocType THEN BEGIN
              IF (Quantity * "Return Qty. Received" < 0) OR
                 ((ABS(Quantity) < ABS("Return Qty. Received")) AND ("Return Receipt No." = ''))
              THEN
                FIELDERROR(Quantity,STRSUBSTNO(Text003,FIELDCAPTION("Return Qty. Received")));
              IF ("Quantity (Base)" * "Return Qty. Received (Base)" < 0) OR
                 ((ABS("Quantity (Base)") < ABS("Return Qty. Received (Base)")) AND ("Return Receipt No." = ''))
              THEN
                FIELDERROR("Quantity (Base)",STRSUBSTNO(Text003,FIELDCAPTION("Return Qty. Received (Base)")));
            END ELSE BEGIN
              IF (Quantity * "Quantity Shipped" < 0) OR
                 ((ABS(Quantity) < ABS("Quantity Shipped")) AND ("Shipment No." = ''))
              THEN
                FIELDERROR(Quantity,STRSUBSTNO(Text003,FIELDCAPTION("Quantity Shipped")));
              IF ("Quantity (Base)" * "Qty. Shipped (Base)" < 0) OR
                 ((ABS("Quantity (Base)") < ABS("Qty. Shipped (Base)")) AND ("Shipment No." = ''))
              THEN
                FIELDERROR("Quantity (Base)",STRSUBSTNO(Text003,FIELDCAPTION("Qty. Shipped (Base)")));
            END;

            IF (Type = Type::"Charge (Item)") AND (CurrFieldNo <> 0) THEN BEGIN
              IF (Quantity = 0) AND ("Qty. to Assign" <> 0) THEN
                FIELDERROR("Qty. to Assign",STRSUBSTNO(Text009,FIELDCAPTION(Quantity),Quantity));
              IF (Quantity * "Qty. Assigned" < 0) OR (ABS(Quantity) < ABS("Qty. Assigned")) THEN
                FIELDERROR(Quantity,STRSUBSTNO(Text003,FIELDCAPTION("Qty. Assigned")));
            END;

            AddOnIntegrMgt.CheckReceiptOrderStatus(Rec);
            IF (xRec.Quantity <> Quantity) OR (xRec."Quantity (Base)" <> "Quantity (Base)") THEN BEGIN
              InitOutstanding;
              IF IsCreditDocType THEN
                InitQtyToReceive
              ELSE
                InitQtyToShip;
              InitQtyToAsm;
              SetDefaultQuantity;
            END;

            CheckItemAvailable(FIELDNO(Quantity));

            IF (Quantity * xRec.Quantity < 0) OR (Quantity = 0) THEN
              InitItemAppl(FALSE);

            IF Type = Type::Item THEN BEGIN
              UpdateUnitPrice(FIELDNO(Quantity));
              IF (xRec.Quantity <> Quantity) OR (xRec."Quantity (Base)" <> "Quantity (Base)") THEN BEGIN
                OnBeforeVerifyReservedQty(Rec,xRec,FIELDNO(Quantity));
                ReserveSalesLine.VerifyQuantity(Rec,xRec);
                IF NOT "Drop Shipment" THEN
                  UpdateWithWarehouseShip;
                WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
                IF ("Quantity (Base)" * xRec."Quantity (Base)" <= 0) AND ("No." <> '') THEN BEGIN
                  GetItem(Item);
                  OnValidateQuantityOnBeforeGetUnitCost(Rec,Item);
                  IF (Item."Costing Method" = Item."Costing Method"::Standard) AND NOT IsShipment THEN
                    GetUnitCost;
                END;
              END;
              VALIDATE("Qty. to Assemble to Order");
              IF (Quantity = "Quantity Invoiced") AND (CurrFieldNo <> 0) THEN
                CheckItemChargeAssgnt;
              CheckApplFromItemLedgEntry(ItemLedgEntry);
            END ELSE
              VALIDATE("Line Discount %");

            IF (xRec.Quantity <> Quantity) AND (Quantity = 0) AND
               ((Amount <> 0) OR ("Amount Including VAT" <> 0) OR ("VAT Base Amount" <> 0))
            THEN BEGIN
              Amount := 0;
              "Amount Including VAT" := 0;
              "VAT Base Amount" := 0;
            END;

            UpdatePrePaymentAmounts;

            //008
            IF "Linea Copiada" THEN
              BEGIN
                VALIDATE("Unit Price",Precio);
                VALIDATE("Line Discount %","%Desc");
              END;
            //008

            //006
            PreciosTipoVenta;

            CheckWMS;

            UpdatePlanned;
            IF "Document Type" = "Document Type"::"Return Order" THEN
              ValidateReturnReasonCode(FIELDNO(Quantity));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #19..60
            CheckRetentionAttachedToLineNo;

            #61..108
            #120..124
            */
        //end;

        //Unsupported feature: Property Deletion (Description) on ""Bill-to Customer No."(Field 68)".



        //Unsupported feature: Code Modification on ""Blanket Order Line No."(Field 98).OnValidate".

        //trigger "(Field 98)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD("Quantity Shipped",0);
            IF "Blanket Order Line No." <> 0 THEN BEGIN
              SalesLine2.GET("Document Type"::"Blanket Order","Blanket Order No.","Blanket Order Line No.");
              SalesLine2.TESTFIELD(Type,Type);
              SalesLine2.TESTFIELD("No.","No.");
              SalesLine2.TESTFIELD("Bill-to Customer No.","Bill-to Customer No.");
              SalesLine2.TESTFIELD("Sell-to Customer No.","Sell-to Customer No.");
              IF "Drop Shipment" THEN BEGIN
                SalesLine2.TESTFIELD("Variant Code","Variant Code");
                SalesLine2.TESTFIELD("Location Code","Location Code");
                SalesLine2.TESTFIELD("Unit of Measure Code","Unit of Measure Code");
            #12..16
              VALIDATE("Unit Price",SalesLine2."Unit Price");
              VALIDATE("Line Discount %",SalesLine2."Line Discount %");
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..7
              IF "Drop Shipment" OR "Special Order" THEN BEGIN
            #9..19
            */
        //end;

        //Unsupported feature: Property Deletion (Description) on ""Originally Ordered No."(Field 5703)".


        //Unsupported feature: Property Deletion (Description) on ""BOM Item No."(Field 5909)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Procedencia"(Field 50000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Edicion"(Field 50001)".


        //Unsupported feature: Deletion (FieldCollection) on "Areas(Field 50002)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Paginas"(Field 50003)".


        //Unsupported feature: Deletion (FieldCollection) on "ISBN(Field 50004)".


        //Unsupported feature: Deletion (FieldCollection) on ""Componentes Prod."(Field 50005)".


        //Unsupported feature: Deletion (FieldCollection) on ""Nivel Educativo"(Field 50006)".


        //Unsupported feature: Deletion (FieldCollection) on "Cursos(Field 50007)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad Inv. en Consignacion"(Field 50008)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad Consignacion Devuelta"(Field 50009)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Pedido Consignacion"(Field 50010)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Linea Pedido Consignacion"(Field 50011)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Mov. Prod. Cosg. a Liq."(Field 50012)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Estante"(Field 50013)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Cupon"(Field 50014)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Linea Cupon"(Field 50015)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad Aprobada"(Field 50016)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad pendiente BO"(Field 50017)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad a Anular"(Field 50018)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad Solicitada"(Field 50019)".


        //Unsupported feature: Deletion (FieldCollection) on "Temporal(Field 50020)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad Anulada"(Field 50022)".


        //Unsupported feature: Deletion (FieldCollection) on "EAN(Field 50023)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad a Ajustar"(Field 50040)".


        //Unsupported feature: Deletion (FieldCollection) on ""Porcentaje Cant. Aprobada"(Field 50041)".


        //Unsupported feature: Deletion (FieldCollection) on "SIC(Field 50110)".


        //Unsupported feature: Deletion (FieldCollection) on ""Linea Copiada"(Field 55500)".


        //Unsupported feature: Deletion (FieldCollection) on ""Disponible BackOrder"(Field 56001)".


        //Unsupported feature: Deletion (FieldCollection) on ""Nombre Cliente"(Field 56005)".


        //Unsupported feature: Deletion (FieldCollection) on ""Fecha Registro"(Field 56006)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo Pedido"(Field 56007)".


        //Unsupported feature: Deletion (FieldCollection) on ""Bin Ranking"(Field 56008)".


        //Unsupported feature: Deletion (FieldCollection) on "Compartir(Field 56009)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo Descuento FE"(Field 56015)".


        //Unsupported feature: Deletion (FieldCollection) on ""Anulada en TPV"(Field 34002500)".


        //Unsupported feature: Deletion (FieldCollection) on ""Precio anulacion TPV"(Field 34002501)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad anulacion TPV"(Field 34002502)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad agregada"(Field 34002503)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Vendedor"(Field 34002504)".


        //Unsupported feature: Deletion (FieldCollection) on "Devuelto(Field 34002505)".


        //Unsupported feature: Deletion (FieldCollection) on ""Devuelto en Documento"(Field 34002506)".


        //Unsupported feature: Deletion (FieldCollection) on ""Devuelto en Linea Documento"(Field 34002507)".


        //Unsupported feature: Deletion (FieldCollection) on ""Devuelve a Documento"(Field 34002508)".


        //Unsupported feature: Deletion (FieldCollection) on ""Devuelve a Linea Documento"(Field 34002509)".


        //Unsupported feature: Deletion (FieldCollection) on ""Registrado TPV"(Field 34002511)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad Alumnos"(Field 34002800)".


        //Unsupported feature: Deletion (FieldCollection) on "Adopcion(Field 34002801)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Colegio"(Field 34002802)".


        //Unsupported feature: Deletion (FieldCollection) on "Presupuesto(Field 34002803)".

        field(10001;"Retention Attached to Line No.";Integer)
        {
            Caption = 'Retention Attached to Line No.';
            TableRelation = IF (Quantity=FILTER(<0)) "Sales Line"."Line No." WHERE (Document Type=FIELD(Document Type),
                                                                                    Document No.=FIELD(Document No.),
                                                                                    Quantity=FILTER(>0));

            trigger OnValidate()
            begin
                CheckRetentionAttachedToLineNo;
            end;
        }
        field(10002;"Retention VAT %";Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Retention tax %';
            MaxValue = 100;
            MinValue = 0;
        }
        field(10003;"Custom Transit Number";Text[30])
        {
            Caption = 'Custom Transit Number';
        }
    }
    keys
    {

        //Unsupported feature: Property Insertion (Enabled) on ""Document Type,Document No.,Type,No."(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Type,Document No.,Document Type"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""No.,Type,Shipment Date,Location Code,Document Type"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Location Code,Shipment Date"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Disponible BackOrder"(Key)".

    }


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TestStatusOpen;

        IF (Quantity <> 0) AND ItemExists("No.") THEN BEGIN
          ReserveSalesLine.DeleteLine(Rec);
          CALCFIELDS("Reserved Qty. (Base)");
          TESTFIELD("Reserved Qty. (Base)",0);
          IF "Shipment No." = '' THEN
            TESTFIELD("Qty. Shipped Not Invoiced",0);
          IF "Return Receipt No." = '' THEN
            TESTFIELD("Return Qty. Rcd. Not Invd.",0);
          WhseValidateSourceLine.SalesLineDelete(Rec);
        END;

        IF ("Document Type" = "Document Type"::Order) AND (Quantity <> "Quantity Invoiced") THEN
          TESTFIELD("Prepmt. Amt. Inv.","Prepmt Amt Deducted");

        CleanDropShipmentFields;
        CleanSpecialOrderFieldsAndCheckAssocPurchOrder;
        CatalogItemMgt.DelNonStockSales(Rec);

        IF "Document Type" = "Document Type"::"Blanket Order" THEN BEGIN
          SalesLine2.RESET;
          SalesLine2.SETCURRENTKEY("Document Type","Blanket Order No.","Blanket Order Line No.");
          SalesLine2.SETRANGE("Blanket Order No.","Document No.");
          SalesLine2.SETRANGE("Blanket Order Line No.","Line No.");
          IF SalesLine2.FINDFIRST THEN
            SalesLine2.TESTFIELD("Blanket Order Line No.",0);
        END;

        IF Type = Type::Item THEN BEGIN
          ATOLink.DeleteAsmFromSalesLine(Rec);
          DeleteItemChargeAssgnt("Document Type","Document No.","Line No.");
        END;

        IF Type = Type::"Charge (Item)" THEN
          DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");

        CapableToPromise.RemoveReqLines("Document No.","Line No.",0,FALSE);

        //+#121213
        //... Si se trata de un documento del TPV, auditamos el borrado que hagamos de líneas con el fin de auditar y quizás prevenir el error
        //... de las facturas sin linea.
        IF lrCV.GET("Document Type","Document No.") THEN
          IF lrCV."Venta TPV" THEN BEGIN
            lNumLog := lcPos.IniciarLog(3,lrCV.Tienda,lrCV.TPV);
            lcPos.ModificarDatosLog(lNumLog,1,"Document Type",lrCV."No.",lrCV."Posting No.",lrCV."No. Fiscal TPV",lrCV."No. Comprobante Fiscal",
                                    STRSUBSTNO(TextL001,"Line No.","No.",Quantity) );
          END;
        //-#121213

        IF "Line No." <> 0 THEN BEGIN
          SalesLine2.RESET;
          SalesLine2.SETRANGE("Document Type","Document Type");
          SalesLine2.SETRANGE("Document No.","Document No.");
          SalesLine2.SETRANGE("Attached to Line No.","Line No.");
          SalesLine2.SETFILTER("Line No.",'<>%1',"Line No.");
          SalesLine2.DELETEALL(TRUE);
        END;

        IF "Job Contract Entry No." <> 0 THEN
          JobCreateInvoice.DeleteSalesLine(Rec);

        SalesCommentLine.SETRANGE("Document Type","Document Type");
        SalesCommentLine.SETRANGE("No.","Document No.");
        SalesCommentLine.SETRANGE("Document Line No.","Line No.");
        IF NOT SalesCommentLine.ISEMPTY THEN
          SalesCommentLine.DELETEALL;

        // In case we have roundings on VAT or Sales Tax, we should update some other line
        IF (Type <> Type::" ") AND ("Line No." <> 0) AND ("Attached to Line No." = 0) AND ("Job Contract Entry No." = 0 ) AND
           (Quantity <> 0) AND (Amount <> 0) AND (Amount <> "Amount Including VAT") AND NOT StatusCheckSuspended
        THEN BEGIN
          Quantity := 0;
          "Quantity (Base)" := 0;
          "Line Discount Amount" := 0;
          "Inv. Discount Amount" := 0;
          "Inv. Disc. Amount to Invoice" := 0;
          UpdateAmounts;
        END;

        IF "Deferral Code" <> '' THEN
          DeferralUtilities.DeferralCodeOnDelete(
            DeferralUtilities.GetSalesDeferralDocType,'','',
            "Document Type","Document No.","Line No.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..39
        #51..74
          "Qty. to Invoice" := 0;
          "Qty. to Invoice (Base)" := 0;
        #75..84
        */
    //end;


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        VALIDATE("Cod. Colegio",SalesHeader."Cod. Colegio"); //018
        TestStatusOpen;
        IF Quantity <> 0 THEN BEGIN
          OnBeforeVerifyReservedQty(Rec,xRec,0);
        #5..10
            ERROR(Text056,SalesHeader."Shipping Advice");
        IF ("Deferral Code" <> '') AND (GetDeferralAmount <> 0) THEN
          UpdateDeferralAmounts;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #2..13
        */
    //end;


    //Unsupported feature: Code Modification on "OnModify".

    //trigger OnModify()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF ("Document Type" = "Document Type"::"Blanket Order") AND
           ((Type <> xRec.Type) OR ("No." <> xRec."No."))
        THEN BEGIN
        #4..13

        IF ((Quantity <> 0) OR (xRec.Quantity <> 0)) AND ItemExists(xRec."No.") AND NOT FullReservedQtyIsForAsmToOrder THEN
          ReserveSalesLine.VerifyChange(Rec,xRec);

        GetSalesHeader;                              //$015
        SalesHeader.ControlClasificacionDevolucion;  //

        //018
        SalesHeader.GET("Document Type","Document No.");
        VALIDATE("Cod. Colegio",SalesHeader."Cod. Colegio");
        //018
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..16
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "InitOutstanding(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "InitOutstandingAmount(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "InitQtyToShip(PROCEDURE 15)".



    //Unsupported feature: Code Modification on "InitQtyToShip(PROCEDURE 15)".

    //procedure InitQtyToShip();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GetSalesSetup;
        IF (SalesSetup."Default Quantity to Ship" = SalesSetup."Default Quantity to Ship"::Remainder) OR
           ("Document Type" = "Document Type"::Invoice)
        THEN BEGIN
          "Qty. to Ship" := "Outstanding Quantity";
          "Qty. to Ship (Base)" := "Outstanding Qty. (Base)";
        END ELSE
          IF "Qty. to Ship" <> 0 THEN
            "Qty. to Ship (Base)" := CalcBaseQty("Qty. to Ship");

        CheckServItemCreation;

        OnAfterInitQtyToShip(Rec,CurrFieldNo);

        InitQtyToInvoice;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..8
            "Qty. to Ship (Base)" := MaxQtyToShipBase(CalcBaseQty("Qty. to Ship"));
        #10..15
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "InitQtyToReceive(PROCEDURE 5803)".


    //Unsupported feature: Property Modification (Attributes) on "InitQtyToInvoice(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "MaxQtyToInvoice(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "MaxQtyToInvoiceBase(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "CalcLineAmount(PROCEDURE 163)".



    //Unsupported feature: Code Modification on "CopyFromItem(PROCEDURE 144)".

    //procedure CopyFromItem();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GetItem(Item);
        IsHandled := FALSE;
        OnBeforeCopyFromItem(Rec,Item,IsHandled);
        #4..15

        Description := Item.Description;
        "Description 2" := Item."Description 2;

        ISBN := Item.ISBN;//010
        "Nivel Educativo" := Item."Nivel Educativo APS"; //+$018
        Compartir := Item.Compartir;  //SANTINAV-2745

        GetUnitCost;
        "Allow Invoice Disc." := Item."Allow Invoice Disc.";
        "Units per Parcel" := Item."Units per Parcel";
        #27..53
        InitDeferralCode;
        SetDefaultItemQuantity;
        OnAfterAssignItemValues(Rec,Item);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..18
        #24..56
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "SetSalesHeader(PROCEDURE 24)".


    //Unsupported feature: Property Modification (Attributes) on "GetSalesHeader(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateUnitPrice(PROCEDURE 2)".



    //Unsupported feature: Code Modification on "UpdateUnitPrice(PROCEDURE 2)".

    //procedure UpdateUnitPrice();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IsHandled := FALSE;
        OnBeforeUpdateUnitPrice(Rec,xRec,CalledByFieldNo,CurrFieldNo,IsHandled);
        IF IsHandled THEN
          EXIT;

        GetSalesHeader;
        TESTFIELD("Qty. per Unit of Measure");

        CASE Type OF
          Type::Item,
          Type::Resource:
            BEGIN
              IsHandled := FALSE;
              OnUpdateUnitPriceOnBeforeFindPrice(SalesHeader,Rec,CalledByFieldNo,CurrFieldNo,IsHandled);
              IF NOT IsHandled THEN BEGIN
                IF NOT ("Copied From Posted Doc." AND IsCreditDocType) THEN
                  PriceCalcMgt.FindSalesLineLineDisc(SalesHeader,Rec);
                PriceCalcMgt.FindSalesLinePrice(SalesHeader,Rec,CalledByFieldNo);
              END;
            END;
        END;

        IF "Copied From Posted Doc." AND IsCreditDocType AND ("Appl.-from Item Entry" <> 0) THEN
          IF xRec."Unit Price" <> "Unit Price" THEN
            IF GUIALLOWED THEN
              ShowMessageOnce(STRSUBSTNO(UnitPriceChangedMsg,Type,"No."));

        //GRN+ Para los clientes internos
        CustPostGr.GET(SalesHeader."Customer Posting Group");
        IF CustPostGr."Cliente Interno" THEN
           VALIDATE("Unit Price","Unit Cost")
        ELSE
        //GRN-
          VALIDATE("Unit Price");

        OnAfterUpdateUnitPrice(Rec,xRec,CalledByFieldNo,CurrFieldNo);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..27
        VALIDATE("Unit Price");

        OnAfterUpdateUnitPrice(Rec,xRec,CalledByFieldNo,CurrFieldNo);
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "FindResUnitCost(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePrepmtSetupFields(PROCEDURE 102)".



    //Unsupported feature: Code Modification on "UpdatePrepmtAmounts(PROCEDURE 197)".

    //procedure UpdatePrepmtAmounts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IsHandled := FALSE;
        OnBeforeUpdatePrepmtAmounts(Rec,SalesHeader,IsHandled);
        IF IsHandled THEN
        #4..10
        END;
        IF SalesHeader."Document Type" <> SalesHeader."Document Type"::Invoice THEN BEGIN
          "Prepayment VAT Difference" := 0;
          IF NOT PrePaymentLineAmountEntered THEN
            "Prepmt. Line Amount" := ROUND("Line Amount" * "Prepayment %" / 100,Currency."Amount Rounding Precision");
          IF "Prepmt. Line Amount" < "Prepmt. Amt. Inv." THEN BEGIN
            IF IsServiceCharge THEN
              ERROR(CannotChangePrepaidServiceChargeErr);
        #19..32
              FIELDERROR("Line Amount",STRSUBSTNO(Text044,xRec."Line Amount"));
            FIELDERROR("Line Amount",STRSUBSTNO(Text045,xRec."Line Amount"));
          END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..13
          IF NOT PrePaymentLineAmountEntered THEN BEGIN
            "Prepmt. Line Amount" := ROUND("Line Amount" * "Prepayment %" / 100,Currency."Amount Rounding Precision");
            IF ABS("Inv. Discount Amount" + "Prepmt. Line Amount") > ABS("Line Amount") THEN
              "Prepmt. Line Amount" := "Line Amount" - "Inv. Discount Amount";
          END;
        #16..35
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "UpdateAmounts(PROCEDURE 3)".


    //Unsupported feature: Variable Insertion (Variable: TotalVATDifference) (VariableCollection) on "UpdateVATAmounts(PROCEDURE 38)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateVATAmounts(PROCEDURE 38)".



    //Unsupported feature: Code Modification on "UpdateVATAmounts(PROCEDURE 38)".

    //procedure UpdateVATAmounts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        OnBeforeUpdateVATAmounts(Rec);

        GetSalesHeader;
        #4..32
          THEN BEGIN
            SalesLine2.SETFILTER("VAT %",'<>0');
            IF NOT SalesLine2.ISEMPTY THEN BEGIN
              SalesLine2.CALCSUMS("Line Amount","Inv. Discount Amount",Amount,"Amount Including VAT","Quantity (Base)");
              TotalLineAmount := SalesLine2."Line Amount";
              TotalInvDiscAmount := SalesLine2."Inv. Discount Amount";
              TotalAmount := SalesLine2.Amount;
              TotalAmountInclVAT := SalesLine2."Amount Including VAT";
              TotalQuantityBase := SalesLine2."Quantity (Base)";
              OnAfterUpdateTotalAmounts(Rec,SalesLine2,TotalAmount,TotalAmountInclVAT,TotalLineAmount,TotalInvDiscAmount);
            END;
        #44..97
                    ROUND(
                      (TotalAmount + Amount) * (1 - SalesHeader."VAT Base Discount %" / 100) * "VAT %" / 100,
                      Currency."Amount Rounding Precision",Currency.VATRoundingDirection) -
                    TotalAmountInclVAT;
                END;
              "VAT Calculation Type"::"Full VAT":
                BEGIN
        #105..123
        END;

        OnAfterUpdateVATAmounts(Rec);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..35
              SalesLine2.CALCSUMS("Line Amount","Inv. Discount Amount",Amount,"Amount Including VAT","Quantity (Base)","VAT Difference");
        #37..40
              TotalVATDifference := SalesLine2."VAT Difference";
        #41..100
                    TotalAmountInclVAT + TotalVATDifference;
        #102..126
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "CheckItemAvailable(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "ShowReservation(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "ShowReservationEntries(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "AutoReserve(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "AutoAsmToOrder(PROCEDURE 82)".


    //Unsupported feature: Property Modification (Attributes) on "CalcPlannedDeliveryDate(PROCEDURE 92)".


    //Unsupported feature: Property Modification (Attributes) on "CalcPlannedShptDate(PROCEDURE 93)".


    //Unsupported feature: Property Modification (Attributes) on "CalcShipmentDate(PROCEDURE 111)".


    //Unsupported feature: Property Modification (Attributes) on "SignedXX(PROCEDURE 20)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "OpenItemTrackingLines(PROCEDURE 6500)".


    //Unsupported feature: Property Modification (Attributes) on "CreateDim(PROCEDURE 26)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "LookupShortcutDimCode(PROCEDURE 28)".


    //Unsupported feature: Property Modification (Attributes) on "ShowShortcutDimCode(PROCEDURE 27)".


    //Unsupported feature: Property Modification (Attributes) on "SelectMultipleItems(PROCEDURE 180)".


    //Unsupported feature: Property Modification (Attributes) on "ShowItemSub(PROCEDURE 30)".


    //Unsupported feature: Property Modification (Attributes) on "ShowNonstock(PROCEDURE 32)".


    //Unsupported feature: Property Modification (Attributes) on "GetCaptionClass(PROCEDURE 34)".


    //Unsupported feature: Property Modification (Attributes) on "GetUnitCost(PROCEDURE 5808)".


    //Unsupported feature: Property Modification (Attributes) on "ShowItemChargeAssgnt(PROCEDURE 5801)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateItemChargeAssgnt(PROCEDURE 5807)".


    //Unsupported feature: Property Modification (Attributes) on "TestStatusOpen(PROCEDURE 33)".


    //Unsupported feature: Property Modification (Attributes) on "SuspendStatusCheck(PROCEDURE 39)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateVATOnLines(PROCEDURE 36)".



    //Unsupported feature: Code Modification on "UpdateVATOnLines(PROCEDURE 36)".

    //procedure UpdateVATOnLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        LineWasModified := FALSE;
        IF QtyType = QtyType::Shipping THEN
          EXIT;
        #4..13
          LOCKTABLE;
          IF FINDSET THEN
            REPEAT
              IF NOT ZeroAmountLine(QtyType) THEN BEGIN
                DeferralAmount := GetDeferralAmount;
                VATAmountLine.GET("VAT Identifier","VAT Calculation Type","Tax Group Code","Tax Area Code",FALSE,"Line Amount" >= 0);
                IF VATAmountLine.Modified THEN BEGIN
        #21..133
        END;

        OnAfterUpdateVATOnLines(SalesHeader,SalesLine,VATAmountLine,QtyType);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..16
              IF NOT ZeroAmountLine(QtyType) AND
                 ((SalesHeader."Document Type" <> SalesHeader."Document Type"::Invoice) OR ("Prepmt. Amt. Inv." = 0))
              THEN BEGIN
        #18..136
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "CalcVATAmountLines(PROCEDURE 35)".


    //Unsupported feature: Property Modification (Attributes) on "GetCPGInvRoundAcc(PROCEDURE 71)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateWithWarehouseShip(PROCEDURE 41)".


    //Unsupported feature: Property Modification (Attributes) on "GetItemTranslation(PROCEDURE 42)".


    //Unsupported feature: Property Modification (Attributes) on "PriceExists(PROCEDURE 44)".


    //Unsupported feature: Property Modification (Attributes) on "LineDiscExists(PROCEDURE 45)".


    //Unsupported feature: Property Modification (Attributes) on "RowID1(PROCEDURE 47)".


    //Unsupported feature: Property Modification (Attributes) on "GetATOBin(PROCEDURE 89)".


    //Unsupported feature: Property Modification (Attributes) on "IsInbound(PROCEDURE 97)".


    //Unsupported feature: Property Modification (Attributes) on "CheckAssocPurchOrder(PROCEDURE 51)".


    //Unsupported feature: Property Modification (Attributes) on "CrossReferenceNoLookUp(PROCEDURE 53)".


    //Unsupported feature: Property Modification (Attributes) on "ItemExists(PROCEDURE 54)".


    //Unsupported feature: Property Modification (Attributes) on "IsShipment(PROCEDURE 55)".


    //Unsupported feature: Property Modification (Attributes) on "SetHideValidationDialog(PROCEDURE 57)".


    //Unsupported feature: Property Modification (Attributes) on "GetHideValidationDialog(PROCEDURE 123)".


    //Unsupported feature: Property Modification (Attributes) on "CalcPrepaymentToDeduct(PROCEDURE 63)".


    //Unsupported feature: Property Modification (Attributes) on "IsFinalInvoice(PROCEDURE 116)".


    //Unsupported feature: Property Modification (Attributes) on "GetLineAmountToHandle(PROCEDURE 117)".


    //Unsupported feature: Property Modification (Attributes) on "GetLineAmountToHandleInclPrepmt(PROCEDURE 265)".


    //Unsupported feature: Property Modification (Attributes) on "GetLineAmountExclVAT(PROCEDURE 349)".


    //Unsupported feature: Property Modification (Attributes) on "GetLineAmountInclVAT(PROCEDURE 351)".


    //Unsupported feature: Property Modification (Attributes) on "SetHasBeenShown(PROCEDURE 59)".


    //Unsupported feature: Property Modification (Attributes) on "BlockDynamicTracking(PROCEDURE 58)".


    //Unsupported feature: Property Modification (Attributes) on "InitQtyToShip2(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "ShowLineComments(PROCEDURE 61)".


    //Unsupported feature: Property Modification (Attributes) on "SetDefaultQuantity(PROCEDURE 62)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePrePaymentAmounts(PROCEDURE 64)".


    //Unsupported feature: Property Modification (Attributes) on "ZeroAmountLine(PROCEDURE 65)".


    //Unsupported feature: Property Modification (Attributes) on "FilterLinesWithItemToPlan(PROCEDURE 69)".


    //Unsupported feature: Property Modification (Attributes) on "FindLinesWithItemToPlan(PROCEDURE 66)".


    //Unsupported feature: Property Modification (Attributes) on "LinesWithItemToPlanExist(PROCEDURE 67)".


    //Unsupported feature: Property Modification (Attributes) on "AsmToOrderExists(PROCEDURE 72)".


    //Unsupported feature: Property Modification (Attributes) on "FullQtyIsForAsmToOrder(PROCEDURE 74)".


    //Unsupported feature: Property Modification (Attributes) on "QtyBaseOnATO(PROCEDURE 86)".


    //Unsupported feature: Property Modification (Attributes) on "QtyAsmRemainingBaseOnATO(PROCEDURE 90)".


    //Unsupported feature: Property Modification (Attributes) on "QtyToAsmBaseOnATO(PROCEDURE 88)".


    //Unsupported feature: Property Modification (Attributes) on "IsAsmToOrderAllowed(PROCEDURE 77)".


    //Unsupported feature: Property Modification (Attributes) on "IsAsmToOrderRequired(PROCEDURE 81)".


    //Unsupported feature: Property Modification (Attributes) on "CheckAsmToOrder(PROCEDURE 85)".


    //Unsupported feature: Property Modification (Attributes) on "ShowAsmToOrderLines(PROCEDURE 80)".


    //Unsupported feature: Property Modification (Attributes) on "FindOpenATOEntry(PROCEDURE 96)".


    //Unsupported feature: Property Modification (Attributes) on "RollUpAsmCost(PROCEDURE 83)".


    //Unsupported feature: Property Modification (Attributes) on "RollupAsmPrice(PROCEDURE 84)".


    //Unsupported feature: Property Modification (Attributes) on "OutstandingInvoiceAmountFromShipment(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "IsShippedReceivedItemDimChanged(PROCEDURE 113)".


    //Unsupported feature: Property Modification (Attributes) on "ConfirmShippedReceivedItemDimChange(PROCEDURE 114)".


    //Unsupported feature: Property Modification (Attributes) on "InitType(PROCEDURE 91)".


    //Unsupported feature: Property Modification (Attributes) on "CalcSalesTaxLines(PROCEDURE 1020000)".


    //Unsupported feature: Property Modification (Attributes) on "CheckLocationOnWMS(PROCEDURE 101)".


    //Unsupported feature: Property Modification (Attributes) on "IsNonInventoriableItem(PROCEDURE 195)".


    //Unsupported feature: Property Modification (Attributes) on "IsInventoriableItem(PROCEDURE 196)".


    //Unsupported feature: Property Modification (Attributes) on "CalcAmountIncludingTax(PROCEDURE 1020003)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateLineDiscountPercent(PROCEDURE 226)".


    //Unsupported feature: Property Modification (Attributes) on "HasTypeToFillMandatoryFields(PROCEDURE 103)".


    //Unsupported feature: Property Modification (Attributes) on "GetDeferralAmount(PROCEDURE 104)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePriceDescription(PROCEDURE 147)".


    //Unsupported feature: Property Modification (Attributes) on "DefaultDeferralCode(PROCEDURE 109)".


    //Unsupported feature: Property Modification (Attributes) on "IsCreditDocType(PROCEDURE 110)".


    //Unsupported feature: Property Modification (Attributes) on "CanEditUnitOfMeasureCode(PROCEDURE 115)".


    //Unsupported feature: Property Modification (Attributes) on "InsertFreightLine(PROCEDURE 121)".


    //Unsupported feature: Property Modification (Attributes) on "IsLookupRequested(PROCEDURE 119)".


    //Unsupported feature: Property Modification (Attributes) on "TestItemFields(PROCEDURE 120)".


    //Unsupported feature: Property Modification (Attributes) on "CalculateNotShippedInvExlcVatLCY(PROCEDURE 118)".


    //Unsupported feature: Property Modification (Attributes) on "ClearSalesHeader(PROCEDURE 124)".


    //Unsupported feature: Property Modification (Attributes) on "SendLineInvoiceDiscountResetNotification(PROCEDURE 323)".


    //Unsupported feature: Property Modification (Attributes) on "GetDocumentTypeDescription(PROCEDURE 156)".


    //Unsupported feature: Property Modification (Attributes) on "FormatType(PROCEDURE 149)".


    //Unsupported feature: Property Modification (Attributes) on "RenameNo(PROCEDURE 133)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePlanned(PROCEDURE 151)".


    //Unsupported feature: Property Modification (Attributes) on "AssignedItemCharge(PROCEDURE 153)".



    //Unsupported feature: Code Modification on "UpdateBaseAmounts(PROCEDURE 173)".

    //procedure UpdateBaseAmounts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        Amount := NewAmount;
        "Amount Including VAT" := NewAmountIncludingVAT;
        "VAT Base Amount" := NewVATBaseAmount;
        IF NOT SalesHeader."Prices Including VAT" AND (Amount > 0) AND (Amount < "Prepmt. Line Amount") THEN
          "Prepmt. Line Amount" := Amount;
        IF SalesHeader."Prices Including VAT" AND ("Amount Including VAT" > 0) AND ("Amount Including VAT" < "Prepmt. Line Amount") THEN
          "Prepmt. Line Amount" := "Amount Including VAT";
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "CalcPlannedDate(PROCEDURE 218)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignFieldsForNo(PROCEDURE 158)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignHeaderValues(PROCEDURE 134)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignStdTxtValues(PROCEDURE 135)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignGLAccountValues(PROCEDURE 138)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignItemValues(PROCEDURE 136)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignItemChargeValues(PROCEDURE 137)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignResourceValues(PROCEDURE 139)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignFixedAssetValues(PROCEDURE 140)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignItemUOM(PROCEDURE 141)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignResourceUOM(PROCEDURE 143)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAutoReserve(PROCEDURE 208)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckShipmentRelation(PROCEDURE 272)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckRetRcptRelation(PROCEDURE 274)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromItem(PROCEDURE 230)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterDeleteChargeChargeAssgnt(PROCEDURE 267)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterFilterLinesWithItemToPlan(PROCEDURE 217)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterFindResUnitCost(PROCEDURE 214)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetItemTranslation(PROCEDURE 329)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetSalesHeader(PROCEDURE 241)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetUnitCost(PROCEDURE 172)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitQtyToAsm(PROCEDURE 223)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterShowNonStock(PROCEDURE 263)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateLineDiscPct(PROCEDURE 232)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateUnitPrice(PROCEDURE 126)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAddItem(PROCEDURE 268)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeAddItems(PROCEDURE 252)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeAutoReserve(PROCEDURE 235)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCalcInvDiscToInvoice(PROCEDURE 220)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCalcPlannedShptDate(PROCEDURE 261)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCalcVATAmountLines(PROCEDURE 190)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckAssocPurchOrder(PROCEDURE 175)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckItemAvailable(PROCEDURE 225)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCopyFromItem(PROCEDURE 222)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCrossReferenceNoAssign(PROCEDURE 193)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeFindNoByDescription(PROCEDURE 260)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeGetDefaultBin(PROCEDURE 216)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeGetItemTranslation(PROCEDURE 275)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeGetSalesHeader(PROCEDURE 262)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeGetUnitCost(PROCEDURE 333)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInitQtyToAsm(PROCEDURE 221)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeIsAsmToOrderRequired(PROCEDURE 314)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeMaxQtyToInvoice(PROCEDURE 332)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeMaxQtyToInvoiceBase(PROCEDURE 234)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeShowItemSub(PROCEDURE 238)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeShowReservation(PROCEDURE 242)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeShowReservationEntries(PROCEDURE 240)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeTestJobPlanningLine(PROCEDURE 237)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeTestStatusOpen(PROCEDURE 205)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdatePrepmtAmounts(PROCEDURE 245)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdatePrepmtSetupFields(PROCEDURE 236)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateLineDiscPct(PROCEDURE 429)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateUnitPrice(PROCEDURE 127)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateVATAmounts(PROCEDURE 206)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeValidateReturnReasonCode(PROCEDURE 227)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeVerifyReservedQty(PROCEDURE 145)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitHeaderDefaults(PROCEDURE 161)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitOutstanding(PROCEDURE 215)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitOutstandingQty(PROCEDURE 202)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitOutstandingAmount(PROCEDURE 132)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitQtyToInvoice(PROCEDURE 128)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitQtyToShip(PROCEDURE 129)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitQtyToShip2(PROCEDURE 315)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitQtyToReceive(PROCEDURE 130)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCalcLineAmount(PROCEDURE 251)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCalcVATAmountLines(PROCEDURE 170)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetLineAmountToHandle(PROCEDURE 171)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSalesTaxCalculate(PROCEDURE 249)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSalesTaxCalculateReverse(PROCEDURE 246)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSetReserveWithoutPurchasingCode(PROCEDURE 233)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateAmounts(PROCEDURE 152)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateAmountsDone(PROCEDURE 165)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateDates(PROCEDURE 200)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateItemCrossRef(PROCEDURE 257)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateVATAmounts(PROCEDURE 199)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateVATOnLines(PROCEDURE 162)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateWithWarehouseShip(PROCEDURE 271)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterValidateCrossReferenceNo(PROCEDURE 258)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateDimTableIDs(PROCEDURE 164)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterShowItemSub(PROCEDURE 166)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterValidateReturnReasonCode(PROCEDURE 174)".


    //Unsupported feature: Property Modification (Attributes) on "OnInitQtyToShip2OnBeforeCalcInvDiscToInvoice(PROCEDURE 239)".


    //Unsupported feature: Property Modification (Attributes) on "OnShowItemChargeAssgntOnBeforeCalcItemCharge(PROCEDURE 194)".


    //Unsupported feature: Property Modification (Attributes) on "OnUpdateUnitPriceOnBeforeFindPrice(PROCEDURE 191)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateLocationCodeOnBeforeSetShipmentDate(PROCEDURE 201)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateTypeOnAfterCheckItem(PROCEDURE 188)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateTypeOnCopyFromTempSalesLine(PROCEDURE 167)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateNoOnAfterInitHeaderDefaults(PROCEDURE 269)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateNoOnAfterUpdateUnitPrice(PROCEDURE 255)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateNoOnAfterVerifyChange(PROCEDURE 187)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateNoOnCopyFromTempSalesLine(PROCEDURE 168)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateNoOnBeforeInitRec(PROCEDURE 31)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateNoOnBeforeUpdateDates(PROCEDURE 210)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateQuantityOnAfterCalcBaseQty(PROCEDURE 256)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateQuantityOnBeforeGetUnitCost(PROCEDURE 254)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateQtyToShipAfterInitQty(PROCEDURE 244)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateQtyToShipOnAfterCheck(PROCEDURE 270)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateQtyToReturnAfterInitQty(PROCEDURE 250)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateReturnQtyToReceiveOnAfterCheck(PROCEDURE 273)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateVariantCodeOnAfterChecks(PROCEDURE 213)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateVATProdPostingGroupOnBeforeCheckVATCalcType(PROCEDURE 259)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterTestStatusOpen(PROCEDURE 169)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSetDefaultQuantity(PROCEDURE 176)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateTotalAmounts(PROCEDURE 68)".


    //Unsupported feature: Property Modification (Attributes) on "OnCheckWarehouseOnBeforeShowDialog(PROCEDURE 247)".


    //Unsupported feature: Property Modification (Attributes) on "OnCalcShipmentDateOnPlannedShipmentDate(PROCEDURE 253)".


    //Unsupported feature: Property Modification (Attributes) on "OnCopyFromItemOnAfterCheck(PROCEDURE 243)".


    //Unsupported feature: Property Modification (Attributes) on "OnGetDeferralPostDate(PROCEDURE 159)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAutoAsmToOrder(PROCEDURE 179)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeAutoAsmToOrder(PROCEDURE 178)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterBlanketOrderLookup(PROCEDURE 182)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeBlanketOrderLookup(PROCEDURE 184)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCalcPlannedDeliveryDate(PROCEDURE 203)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeOpenItemTrackingLines(PROCEDURE 212)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckCreditLimitCondition(PROCEDURE 185)".


    //Unsupported feature: Property Modification (Attributes) on "OnUpdateAmountOnBeforeCheckCreditLimit(PROCEDURE 207)".


    //Unsupported feature: Property Modification (Attributes) on "OnUpdateVATOnLinesOnBeforeCalculateNewAmount(PROCEDURE 264)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateDescriptionOnBeforeCannotFindDescrError(PROCEDURE 451)".


    //Unsupported feature: Property Modification (Attributes) on "OnCalcVATAmountLinesOnAfterCalcLineTotals(PROCEDURE 266)".


    //Unsupported feature: Property Modification (Attributes) on "OnCrossReferenceNoLookupOnBeforeValidateUnitPrice(PROCEDURE 228)".


    procedure MaxQtyToShipBase(QtyToShipBase: Decimal): Decimal
    begin
        IF ABS(QtyToShipBase) > ABS("Outstanding Qty. (Base)") THEN
          EXIT("Outstanding Qty. (Base)");

        EXIT(QtyToShipBase);
    end;

    local procedure CheckRetentionAttachedToLineNo()
    begin
        IF Quantity >= 0 THEN
          TESTFIELD("Retention Attached to Line No.",0);
    end;
}

