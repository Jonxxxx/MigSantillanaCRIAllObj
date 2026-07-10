tableextension 70000016 tableextension70000016 extends Customer
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on "City(Field 7)".

        modify("Global Dimension 1 Code")
        {
            Caption = 'Global Dimension 1 Code';
        }
        modify("Global Dimension 2 Code")
        {
            Caption = 'Global Dimension 2 Code';
        }
        modify("Fin. Charge Terms Code")
        {
            Caption = 'Fin. Charge Terms Code';
        }
        modify("Salesperson Code")
        {
            TableRelation = "Salesperson/Purchaser";
        }

        //Unsupported feature: Property Modification (CalcFormula) on "Balance(Field 58)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Balance (LCY)"(Field 59)".

        modify("E-Mail 2")
        {

            //Unsupported feature: Property Modification (Name) on ""E-Mail 2"(Field 84)".


            //Unsupported feature: Property Modification (Data type) on ""E-Mail 2"(Field 84)".

            Caption = 'Fax No.';
        }

        //Unsupported feature: Property Modification (Data type) on ""VAT Registration No."(Field 86)".

        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Gen. Bus. Posting Group';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'VAT Bus. Posting Group';
        }
        modify("No. of Pstd. Credit Memos")
        {
            Caption = 'No. of Pstd. Credit Memos';
        }
        modify("Validate EU Vat Reg. No.")
        {
            Caption = 'Validate EU VAT Reg. No.';
        }
        modify("Tax Identification Type")
        {
            OptionCaption = 'Legal Entity,Natural Person';

            //Unsupported feature: Property Modification (OptionString) on ""Tax Identification Type"(Field 14020)".

        }

        //Unsupported feature: Property Deletion (Description) on "Address(Field 5)".


        //Unsupported feature: Code Modification on "Blocked(Field 39).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF (Blocked <> Blocked::All) AND "Privacy Blocked" THEN
          IF GUIALLOWED THEN
            IF CONFIRM(ConfirmBlockedPrivacyBlockedQst) THEN
              "Privacy Blocked" := FALSE
            ELSE
              ERROR('')
          ELSE
            ERROR(CanNotChangeBlockedDueToPrivacyBlockedErr);

          //002++
        IF UserSetup.GET(USERID) THEN BEGIN
          IF Blocked <> Blocked::All THEN
            IF NOT UserSetup."Desbloquea Clientes" THEN
              ERROR(Text100)
            ELSE BEGIN
              ValidaCampReq.Maestros(18,"No.");
              ValidaCampReq.Dimensiones(18,"No.",0,0);
            END;
          END
        ELSE
          ERROR(Text100);
        //002--
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..8
        */
        //end;

        //Unsupported feature: Property Deletion (Description) on "Blocked(Field 39)".



        //Unsupported feature: Code Modification on ""VAT Registration No."(Field 86).OnValidate".

        //trigger "(Field 86)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "VAT Registration No." := UPPERCASE("VAT Registration No.");
        IF "VAT Registration No." <> xRec."VAT Registration No." THEN
          VATRegistrationValidation;

        //DSLoc0.01 Para buscar el nombre comercial de la empresa.
        {
        CPG.GET("Customer Posting Group");

        IF ("VAT Registration No." <> '') AND (CPG."Permite emitir NCF")
          AND NOT( CPG.Internacional)
           THEN
           BEGIN
             RNCDGII.GET("VAT Registration No."); // jpg validar rnc desde nueva tabla dgii ++
               BEGIN
                  Name := RNCDGII.Name;
                 IF RNCDGII."Search Name" <> '' THEN
                  "Search Name" := RNCDGII."Search Name";
               END
           END;
         }
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        */
        //end;

        //Unsupported feature: Property Deletion (ValidateTableRelation) on ""VAT Registration No."(Field 86)".



        //Unsupported feature: Code Modification on ""Post Code"(Field 91).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.LookupPostCode(City,"Post Code",County,"Country/Region Code");


        //005
        IF PostCode.GET("Post Code", City) THEN
          "Address 2" := PostCode.Colonia;
        //005

        //#29481 +++
        recRutasDistribucion.SETFILTER (CP, "Post Code");

        IF recRutasDistribucion.FINDFIRST THEN BEGIN
          "Ruta Distribucion" :=  recRutasDistribucion.Code;
        END;
        //#29481 +++
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.LookupPostCode(City,"Post Code",County,"Country/Region Code");
        */
        //end;


        //Unsupported feature: Code Modification on ""Post Code"(Field 91).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);

        OnAfterValidatePostCode(Rec,xRec);


        //005
        IF PostCode.GET("Post Code", City) THEN
          "Address 2" := PostCode.Colonia;
        //005

        //#29481 +++
        recRutasDistribucion.SETFILTER (CP, "Post Code");

        IF recRutasDistribucion.FINDFIRST THEN BEGIN
          "Ruta Distribucion" :=  recRutasDistribucion.Code;
        END;
        //#29481 +++
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        */
        //end;


        //Unsupported feature: Code Modification on ""Primary Contact No."(Field 5049).OnValidate".

        //trigger "(Field 5049)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Contact := '';
        IF "Primary Contact No." <> '' THEN BEGIN
          Cont.GET("Primary Contact No.");
        #4..6
          IF Cont."Company No." <> ContBusRel."Contact No." THEN
            ERROR(Text003,Cont."No.",Cont.Name,"No.",Name);

          IF Cont.Type = Cont.Type::Person THEN
            Contact := Cont.Name;

          IF Cont.Image.HASVALUE THEN
            CopyContactPicture(Cont);
        #15..19
        END ELSE
          IF Image.HASVALUE THEN
            CLEAR(Image);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..9
          IF Cont.Type = Cont.Type::Person THEN BEGIN
            Contact := Cont.Name;
            EXIT;
          END;
        #12..22
        */
        //end;


        //Unsupported feature: Code Modification on ""RFC No."(Field 10023).OnValidate".

        //trigger "(Field 10023)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CASE "Tax Identification Type" OF
          "Tax Identification Type"::"Persona jurídica":
            ValidateRFCNo(12);
          "Tax Identification Type"::"Persona física":
            ValidateRFCNo(13);
        END;
        Customer.RESET;
        Customer.SETRANGE("RFC No.","RFC No.");
        Customer.SETFILTER("No.",'<>%1',"No.");
        IF Customer.FINDFIRST THEN
          MESSAGE(Text10002,"RFC No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CASE "Tax Identification Type" OF
          "Tax Identification Type"::"Legal Entity":
            ValidateRFCNo(12);
          "Tax Identification Type"::"Natural Person":
        #5..11
        */
        //end;

        //Unsupported feature: Property Deletion (Description) on ""Tax Identification Type"(Field 14020)".


        //Unsupported feature: Deletion (FieldCollection) on ""Balance en Consignacion"(Field 50002)".


        //Unsupported feature: Deletion (FieldCollection) on ""Inventario en Consignacion"(Field 50003)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Almacen Consignacion"(Field 50004)".


        //Unsupported feature: Deletion (FieldCollection) on ""Prioridad entrega consignacion"(Field 50005)".


        //Unsupported feature: Deletion (FieldCollection) on ""Precios en Conduce de envio"(Field 50006)".


        //Unsupported feature: Deletion (FieldCollection) on ""Balance en Consignacion Act."(Field 50007)".


        //Unsupported feature: Deletion (FieldCollection) on ""Inventario en Consignacion Act"(Field 50008)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo de Venta"(Field 50010)".


        //Unsupported feature: Deletion (FieldCollection) on ""Admite Pendientes en Pedidos"(Field 50011)".


        //Unsupported feature: Deletion (FieldCollection) on ""PO Box address"(Field 50014)".


        //Unsupported feature: Deletion (FieldCollection) on ""No_ Cliente SIC"(Field 50100)".


        //Unsupported feature: Deletion (FieldCollection) on "GIRO(Field 52000)".


        //Unsupported feature: Deletion (FieldCollection) on "NRC(Field 52001)".


        //Unsupported feature: Deletion (FieldCollection) on ""Permite venta a credito (OBS)"(Field 53000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Enviado no fact. en Consig."(Field 53001)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Actividad Cliente"(Field 54000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Collector Code"(Field 56000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Permite Refacturar"(Field 56001)".


        //Unsupported feature: Deletion (FieldCollection) on ""Packing requerido"(Field 56002)".


        //Unsupported feature: Deletion (FieldCollection) on "APS(Field 56003)".


        //Unsupported feature: Deletion (FieldCollection) on "Inactivo(Field 56004)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Colegio"(Field 56007)".


        //Unsupported feature: Deletion (FieldCollection) on ""Nombre Colegio"(Field 56008)".


        //Unsupported feature: Deletion (FieldCollection) on ""Zona de cobro"(Field 56010)".


        //Unsupported feature: Deletion (FieldCollection) on ""Exento Provision"(Field 56026)".


        //Unsupported feature: Deletion (FieldCollection) on ""Saldo provision"(Field 56027)".


        //Unsupported feature: Deletion (FieldCollection) on ""Ruta Distribucion"(Field 56028)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipos de colegios"(Field 56029)".


        //Unsupported feature: Deletion (FieldCollection) on ""Permite venta a credito"(Field 34002500)".


        //Unsupported feature: Deletion (FieldCollection) on ""Colegio por defecto POS"(Field 34002501)".

        field(93; "EORI Number"; Text[40])
        {
            Caption = 'EORI Number';
        }
        field(27002; "SAT Tax Regime Classification"; Code[10])
        {
            Caption = 'SAT Tax Regime Classification';
            TableRelation = "SAT Tax Scheme";
        }
        field(27004; "CFDI Export Code"; Code[10])
        {
            Caption = 'CFDI Export Code';
            TableRelation = "CFDI Export Code";
        }
    }


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "No." = '' THEN BEGIN
      SalesSetup.GET;
      SalesSetup.TESTFIELD("Customer Nos.");
      NoSeriesMgt.InitSeries(SalesSetup."Customer Nos.",xRec."No. Series",0D,"No.","No. Series");
    END;

    IF "Invoice Disc. Code" = '' THEN
      "Invoice Disc. Code" := "No.";

    IF (NOT (InsertFromContact OR (InsertFromTemplate AND (Contact <> '')) OR ISTEMPORARY)) OR ForceUpdateContact THEN
      UpdateContFromCust.OnInsert(Rec);

    IF "Salesperson Code" = '' THEN
      SetDefaultSalesperson;
    //009+ Descomentar tras integracion Ramon.
    {
    //008++
    ConfSantillana.GET;
    IF "No_ Cliente SIC" = '' THEN BEGIN
      "No_ Cliente SIC":=NoSeriesManagement.GetNextNo(ConfSantillana."Serie Cliente SIC",WORKDATE,TRUE);
    END;
    //008-
    }
    //009- Descomentar tras integracion Ramon.
    //+#4196
    ConfEmpresa.GET();
    IF ConfEmpresa."Clientes Nuevos Bloqueados" THEN
      Blocked := Blocked::All;
    //-#4196

    DimMgt.UpdateDefaultDim(
      DATABASE::Customer,"No.",
      "Global Dimension 1 Code","Global Dimension 2 Code");

    UpdateReferencedIds;
    SetLastModifiedDateTime;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..14
    #30..36
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "AssistEdit(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "ShowContact(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "SetInsertFromContact(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "CheckBlockedCustOnDocs(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "CheckBlockedCustOnJnls(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "CustBlockedErrorMessage(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "CustPrivacyBlockedErrorMessage(PROCEDURE 72)".


    //Unsupported feature: Property Modification (Attributes) on "GetPrivacyBlockedGenericErrorText(PROCEDURE 73)".


    //Unsupported feature: Property Modification (Attributes) on "DisplayMap(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "GetTotalAmountLCY(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "GetTotalAmountLCYUI(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "GetSalesLCY(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "CalcAvailableCredit(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "CalcAvailableCreditUI(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "CalcOverdueBalance(PROCEDURE 11)".



    //Unsupported feature: Code Modification on "CalcOverdueBalance(PROCEDURE 11)".

    //procedure CalcOverdueBalance();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CustLedgEntryRemainAmtQuery.SETRANGE(Customer_No,"No.");
    CustLedgEntryRemainAmtQuery.SETRANGE(IsOpen,TRUE);
    CustLedgEntryRemainAmtQuery.SETFILTER(Due_Date,'<%1',WORKDATE);
    CustLedgEntryRemainAmtQuery.OPEN;

    IF CustLedgEntryRemainAmtQuery.READ THEN
      OverDueBalance := CustLedgEntryRemainAmtQuery.Sum_Remaining_Amt_LCY;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CustLedgEntryRemainAmtQuery.SETRANGE(Customer_No,"No.");
    CustLedgEntryRemainAmtQuery.SETFILTER(Due_Date,'<%1',TODAY);
    CustLedgEntryRemainAmtQuery.SETFILTER(Date_Filter,'<%1',TODAY);
    #4..7
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "ValidateRFCNo(PROCEDURE 1020000)".


    //Unsupported feature: Property Modification (Attributes) on "GetLegalEntityType(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "GetLegalEntityTypeLbl(PROCEDURE 26)".


    //Unsupported feature: Property Modification (Attributes) on "SetStyle(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "HasValidDDMandate(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "GetReturnRcdNotInvAmountLCY(PROCEDURE 53)".


    //Unsupported feature: Property Modification (Attributes) on "GetInvoicedPrepmtAmountLCY(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "CalcCreditLimitLCYExpendedPct(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "CreateAndShowNewInvoice(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "CreateAndShowNewOrder(PROCEDURE 30)".


    //Unsupported feature: Property Modification (Attributes) on "CreateAndShowNewCreditMemo(PROCEDURE 22)".


    //Unsupported feature: Property Modification (Attributes) on "CreateAndShowNewQuote(PROCEDURE 24)".


    //Unsupported feature: Property Modification (Attributes) on "GetBillToCustomerNo(PROCEDURE 27)".


    //Unsupported feature: Property Modification (Attributes) on "HasAddressIgnoreCountryCode(PROCEDURE 37)".


    //Unsupported feature: Property Modification (Attributes) on "HasAddress(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "HasDifferentAddress(PROCEDURE 49)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustNo(PROCEDURE 44)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustNoOpenCard(PROCEDURE 36)".


    //Unsupported feature: Property Modification (Attributes) on "CreateNewCustomer(PROCEDURE 28)".


    //Unsupported feature: Property Modification (Attributes) on "OpenCustomerLedgerEntries(PROCEDURE 31)".


    //Unsupported feature: Property Modification (Attributes) on "SetInsertFromTemplate(PROCEDURE 32)".


    //Unsupported feature: Property Modification (Attributes) on "IsLookupRequested(PROCEDURE 34)".



    //Unsupported feature: Code Modification on "IsContactUpdateNeeded(PROCEDURE 48)".

    //procedure IsContactUpdateNeeded();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    UpdateNeeded :=
      (Name <> xRec.Name) OR
      ("Search Name" <> xRec."Search Name") OR
    #4..11
      ("Language Code" <> xRec."Language Code") OR
      ("Salesperson Code" <> xRec."Salesperson Code") OR
      ("Country/Region Code" <> xRec."Country/Region Code") OR
      ("E-Mail 2" <> xRec."E-Mail 2") OR
      ("Telex Answer Back" <> xRec."Telex Answer Back") OR
      ("VAT Registration No." <> xRec."VAT Registration No.") OR
      ("Post Code" <> xRec."Post Code") OR
    #19..28

    OnBeforeIsContactUpdateNeeded(Rec,xRec,UpdateNeeded);
    EXIT(UpdateNeeded);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..14
      ("Fax No." <> xRec."Fax No.") OR
    #16..31
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "IsBlocked(PROCEDURE 52)".


    //Unsupported feature: Property Modification (Attributes) on "HasAnyOpenOrPostedDocuments(PROCEDURE 60)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromCustomerTemplate(PROCEDURE 63)".


    //Unsupported feature: Property Modification (Attributes) on "GetInsertFromContact(PROCEDURE 69)".


    //Unsupported feature: Property Modification (Attributes) on "GetInsertFromTemplate(PROCEDURE 68)".


    //Unsupported feature: Variable Insertion (Variable: LogNotVerified) (VariableCollection) on "VATRegistrationValidation(PROCEDURE 47)".



    //Unsupported feature: Code Modification on "VATRegistrationValidation(PROCEDURE 47)".

    //procedure VATRegistrationValidation();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsHandled := FALSE;
    OnBeforeVATRegistrationValidation(Rec,IsHandled);
    IF IsHandled THEN
      EXIT;

    IF NOT VATRegistrationNoFormat.Test("VAT Registration No.","Country/Region Code","No.",DATABASE::Customer) THEN
      EXIT;
    VATRegistrationLogMgt.LogCustomer(Rec);
    IF ("Country/Region Code" = '') AND (VATRegistrationNoFormat."Country/Region Code" = '') THEN
      EXIT;
    ApplicableCountryCode := "Country/Region Code";
    IF ApplicableCountryCode = '' THEN
      ApplicableCountryCode := VATRegistrationNoFormat."Country/Region Code";
    IF VATRegNoSrvConfig.VATRegNoSrvIsEnabled THEN BEGIN
      VATRegistrationLogMgt.ValidateVATRegNoWithVIES(ResultRecordRef,Rec,"No.",
        VATRegistrationLog."Account Type"::Customer,ApplicableCountryCode);
      ResultRecordRef.SETTABLE(Rec);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7

    LogNotVerified := TRUE;
    IF ("Country/Region Code" <> '') OR (VATRegistrationNoFormat."Country/Region Code" <> '') THEN BEGIN
      ApplicableCountryCode := "Country/Region Code";
      IF ApplicableCountryCode = '' THEN
        ApplicableCountryCode := VATRegistrationNoFormat."Country/Region Code";
      IF VATRegNoSrvConfig.VATRegNoSrvIsEnabled THEN BEGIN
        LogNotVerified := FALSE;
        VATRegistrationLogMgt.ValidateVATRegNoWithVIES(
          ResultRecordRef,Rec,"No.",VATRegistrationLog."Account Type"::Customer,ApplicableCountryCode);
        ResultRecordRef.SETTABLE(Rec);
      END;
    END;

    IF LogNotVerified THEN
      VATRegistrationLogMgt.LogCustomer(Rec);
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "SetAddress(PROCEDURE 40)".


    //Unsupported feature: Property Modification (Attributes) on "FindByEmail(PROCEDURE 41)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateReferencedIds(PROCEDURE 61)".


    //Unsupported feature: Property Modification (Attributes) on "GetReferencedIds(PROCEDURE 46)".


    //Unsupported feature: Property Modification (Attributes) on "SetForceUpdateContact(PROCEDURE 65)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateCurrencyId(PROCEDURE 55)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePaymentTermsId(PROCEDURE 57)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateShipmentMethodId(PROCEDURE 59)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePaymentMethodId(PROCEDURE 45)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateTaxAreaId(PROCEDURE 1166)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeIsContactUpdateNeeded(PROCEDURE 50)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromCustomerTemplate(PROCEDURE 64)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterHasAnyOpenOrPostedDocuments(PROCEDURE 62)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterValidateCity(PROCEDURE 75)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterValidatePostCode(PROCEDURE 71)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckBlockedCust(PROCEDURE 66)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeGetTotalAmountLCY(PROCEDURE 76)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeGetTotalAmountLCYUI(PROCEDURE 79)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeGetTotalAmountLCYCommon(PROCEDURE 80)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeValidateShortcutDimCode(PROCEDURE 70)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeVATRegistrationValidation(PROCEDURE 74)".

}

