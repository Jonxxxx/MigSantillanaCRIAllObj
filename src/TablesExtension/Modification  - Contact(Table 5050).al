tableextension 70000059 tableextension70000059 extends Contact 
{
    fields
    {
        modify("No. of Business Relations")
        {
            Caption = 'No. of Business Relations';
        }

        //Unsupported feature: Code Insertion on ""Phone No."(Field 9)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //var
            //Char: DotNet Char;
            //i: Integer;
        //begin
            /*
            FOR i := 1 TO STRLEN("Phone No.") DO
              IF Char.IsLetter("Phone No."[i]) THEN
                FIELDERROR("Phone No.",PhoneNoCannotContainLettersErr);
            */
        //end;


        //Unsupported feature: Code Insertion on ""Mobile Phone No."(Field 5061)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //var
            //Char: DotNet Char;
            //i: Integer;
        //begin
            /*
            FOR i := 1 TO STRLEN("Mobile Phone No.") DO
              IF Char.IsLetter("Mobile Phone No."[i]) THEN
                FIELDERROR("Mobile Phone No.",PhoneNoCannotContainLettersErr);
            */
        //end;

        //Unsupported feature: Deletion (FieldCollection) on ""% Descuento Cupon (Obsoleto)"(Field 50000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Almacen"(Field 50009)".


        //Unsupported feature: Deletion (FieldCollection) on "Departamento(Field 50013)".


        //Unsupported feature: Deletion (FieldCollection) on "Distritos(Field 50014)".


        //Unsupported feature: Deletion (FieldCollection) on "Provincia(Field 50015)".


        //Unsupported feature: Deletion (FieldCollection) on "Pais(Field 50016)".


        //Unsupported feature: Deletion (FieldCollection) on ""Nombre Almacen"(Field 50017)".


        //Unsupported feature: Deletion (FieldCollection) on ""Canal de compra"(Field 51000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Nombre canal"(Field 51001)".


        //Unsupported feature: Deletion (FieldCollection) on "Microempresario(Field 51002)".


        //Unsupported feature: Deletion (FieldCollection) on "Comisionista(Field 51003)".


        //Unsupported feature: Deletion (FieldCollection) on ""Orden religiosa"(Field 51004)".


        //Unsupported feature: Deletion (FieldCollection) on ""Asociacion Educativa"(Field 51005)".


        //Unsupported feature: Deletion (FieldCollection) on ""% Descuento Cupon"(Field 53000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Codigo Modular"(Field 53500)".


        //Unsupported feature: Deletion (FieldCollection) on ""Colegio SIC"(Field 53501)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo de colegio"(Field 67000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo educacion"(Field 67001)".


        //Unsupported feature: Deletion (FieldCollection) on ""Fecha decision"(Field 67002)".


        //Unsupported feature: Deletion (FieldCollection) on "Periodo(Field 67003)".


        //Unsupported feature: Deletion (FieldCollection) on "Bilingue(Field 67004)".


        //Unsupported feature: Deletion (FieldCollection) on "Ruta(Field 67005)".


        //Unsupported feature: Deletion (FieldCollection) on "Grupo(Field 67006)".


        //Unsupported feature: Deletion (FieldCollection) on "Cargo(Field 67007)".


        //Unsupported feature: Deletion (FieldCollection) on ""Descripcion Cargo"(Field 67008)".


        //Unsupported feature: Deletion (FieldCollection) on "Facebook(Field 67009)".


        //Unsupported feature: Deletion (FieldCollection) on ""Fecha Aniversario"(Field 67010)".


        //Unsupported feature: Deletion (FieldCollection) on ""Pension INI"(Field 67011)".


        //Unsupported feature: Deletion (FieldCollection) on ""Pension PRI"(Field 67012)".


        //Unsupported feature: Deletion (FieldCollection) on ""Pension SEC"(Field 67013)".


        //Unsupported feature: Deletion (FieldCollection) on ""Pension BA"(Field 67014)".


        //Unsupported feature: Deletion (FieldCollection) on ""Importe Pension INI"(Field 67015)".


        //Unsupported feature: Deletion (FieldCollection) on ""Importe Pension PRI"(Field 67016)".


        //Unsupported feature: Deletion (FieldCollection) on ""Importe Pension SEC"(Field 67017)".


        //Unsupported feature: Deletion (FieldCollection) on ""Importe Pension BA"(Field 67018)".


        //Unsupported feature: Deletion (FieldCollection) on "Delegacion(Field 67019)".


        //Unsupported feature: Deletion (FieldCollection) on ""Distribucion Geografica"(Field 67020)".


        //Unsupported feature: Deletion (FieldCollection) on ""Codigo Postal"(Field 67021)".


        //Unsupported feature: Deletion (FieldCollection) on ""Samples Location Code"(Field 67022)".

    }


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        RMSetup.GET;

        IF "No." = '' THEN BEGIN
          RMSetup.TESTFIELD("Contact Nos.");
          NoSeriesMgt.InitSeries(RMSetup."Contact Nos.",xRec."No. Series",0D,"No.","No. Series");
        END;


        //002+
        {
        ConfSantillana.GET;
        IF "Colegio SIC" = '' THEN BEGIN
          "Colegio SIC":= NoSeriesManagement.GetNextNo(ConfSantillana."Serie Colegio SIC",WORKDATE,TRUE);
        END;
        }
        //002-


        IF NOT SkipDefaults THEN BEGIN
          IF "Salesperson Code" = '' THEN BEGIN
            "Salesperson Code" := RMSetup."Default Salesperson Code";
            SetDefaultSalesperson;
          END;
          IF "Territory Code" = '' THEN
            "Territory Code" := RMSetup."Default Territory Code";
          IF "Country/Region Code" = '' THEN
            "Country/Region Code" := RMSetup."Default Country/Region Code";
          IF "Language Code" = '' THEN
            "Language Code" := RMSetup."Default Language Code";
          IF "Correspondence Type" = "Correspondence Type"::" " THEN
            "Correspondence Type" := RMSetup."Default Correspondence Type";
          IF "Salutation Code" = '' THEN
            IF Type = Type::Company THEN
              "Salutation Code" := RMSetup."Def. Company Salutation Code"
            ELSE
              "Salutation Code" := RMSetup."Default Person Salutation Code";
          OnAfterSetDefaults(Rec,RMSetup);
        END;

        TypeChange;
        SetLastDateTimeModified;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..7
        #19..41
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "OnModify(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "TypeChange(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "AssistEdit(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "CreateCustomer(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "CreateVendor(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "CreateVendor2(PROCEDURE 40)".


    //Unsupported feature: Property Modification (Attributes) on "CreateBankAccount(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "CreateCustomerLink(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "CreateVendorLink(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "CreateBankAccountLink(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "CreateInteraction(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "GetDefaultPhoneNo(PROCEDURE 31)".


    //Unsupported feature: Property Modification (Attributes) on "ShowCustVendBank(PROCEDURE 12)".



    //Unsupported feature: Code Modification on "ShowCustVendBank(PROCEDURE 12)".

    //procedure ShowCustVendBank();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        FormSelected := TRUE;

        ContBusRel.RESET;
        #4..21
            ContBusRel."Link to Table"::Customer:
              BEGIN
                Cust.GET(ContBusRel."No.");
                PAGE.RUN(PAGE::"Customer Card",Cust);
              END;
            ContBusRel."Link to Table"::Vendor:
              BEGIN
                Vend.GET(ContBusRel."No.");
                PAGE.RUN(PAGE::"Vendor Card",Vend);
              END;
            ContBusRel."Link to Table"::"Bank Account":
              BEGIN
                BankAcc.GET(ContBusRel."No.");
                PAGE.RUN(PAGE::"Bank Account Card",BankAcc);
              END;
          END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..24
                Cust.SETRANGE("Date Filter",0D,WORKDATE);
        #25..29
                Vend.SETRANGE("Date Filter",0D,WORKDATE);
        #30..34
                BankAcc.SETRANGE("Date Filter",0D,WORKDATE);
        #35..37
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "SetSkipDefault(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "IdenticalAddress(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "ActiveAltAddress(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "FindCustomerTemplate(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "ChooseCustomerTemplate(PROCEDURE 27)".


    //Unsupported feature: Property Modification (Attributes) on "GetSalutation(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "InheritCompanyToPersonData(PROCEDURE 24)".


    //Unsupported feature: Property Modification (Attributes) on "SetHideValidationDialog(PROCEDURE 26)".


    //Unsupported feature: Property Modification (Attributes) on "GetHideValidationDialog(PROCEDURE 123)".


    //Unsupported feature: Property Modification (Attributes) on "DisplayMap(PROCEDURE 36)".



    //Unsupported feature: Code Modification on "ProcessNameChange(PROCEDURE 37)".

    //procedure ProcessNameChange();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        UpdateSearchName;

        IF Type = Type::Company THEN
        #4..9
          ContBusRel.SETRANGE("Contact No.","Company No.");
          IF ContBusRel.FINDFIRST THEN
            IF Cust.GET(ContBusRel."No.") THEN
              IF Cust."Primary Contact No." = "No." THEN BEGIN
                Cust.Contact := Name;
                Cust.MODIFY;
              END;

          ContBusRel.SETRANGE("Link to Table",ContBusRel."Link to Table"::Vendor);
          IF ContBusRel.FINDFIRST THEN
            IF Vend.GET(ContBusRel."No.") THEN
              IF Vend."Primary Contact No." = "No." THEN BEGIN
                Vend.Contact := Name;
                Vend.MODIFY;
              END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..12
              IF ("No." <> '') AND (Cust."Primary Contact No." = "No.") THEN BEGIN
        #14..20
              IF ("No." <> '') AND (Vend."Primary Contact No." = "No.") THEN BEGIN
        #22..25
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "LookupCompany(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "LookupCustomerTemplate(PROCEDURE 53)".


    //Unsupported feature: Property Modification (Attributes) on "CheckForExistingRelationships(PROCEDURE 20)".


    //Unsupported feature: Property Modification (Attributes) on "SetLastDateTimeModified(PROCEDURE 28)".


    //Unsupported feature: Property Modification (Attributes) on "GetLastDateTimeModified(PROCEDURE 154)".


    //Unsupported feature: Property Modification (Attributes) on "SetLastDateTimeFilter(PROCEDURE 30)".


    //Unsupported feature: Property Modification (Attributes) on "TouchContact(PROCEDURE 32)".


    //Unsupported feature: Property Modification (Attributes) on "CountNoOfBusinessRelations(PROCEDURE 35)".


    //Unsupported feature: Property Modification (Attributes) on "CreateSalesQuoteFromContact(PROCEDURE 38)".


    //Unsupported feature: Property Modification (Attributes) on "ContactToCustBusinessRelationExist(PROCEDURE 44)".


    //Unsupported feature: Property Modification (Attributes) on "CheckIfMinorForProfiles(PROCEDURE 52)".


    //Unsupported feature: Property Modification (Attributes) on "CheckIfPrivacyBlocked(PROCEDURE 48)".


    //Unsupported feature: Property Modification (Attributes) on "CheckIfPrivacyBlockedGeneric(PROCEDURE 50)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetSalutation(PROCEDURE 54)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInheritCompanyToPersonData(PROCEDURE 58)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateQuotesForContact(PROCEDURE 56)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterVendorInsert(PROCEDURE 60)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeVendorInsert(PROCEDURE 43)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeChooseCustomerTemplate(PROCEDURE 65)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCustomerInsert(PROCEDURE 42)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeFindCustomerTemplate(PROCEDURE 64)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeIsUpdateNeeded(PROCEDURE 49)".


    //Unsupported feature: Property Modification (Attributes) on "OnCreateCustomerOnBeforeCustomerModify(PROCEDURE 59)".


    //Unsupported feature: Property Modification (Attributes) on "OnCreateCustomerOnTransferFieldsFromTemplate(PROCEDURE 55)".


    //Unsupported feature: Variable Insertion (Variable: LogNotVerified) (VariableCollection) on "VATRegistrationValidation(PROCEDURE 41)".



    //Unsupported feature: Code Modification on "VATRegistrationValidation(PROCEDURE 41)".

    //procedure VATRegistrationValidation();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IsHandled := FALSE;
        OnBeforeVATRegistrationValidation(Rec,IsHandled);
        IF IsHandled THEN
          EXIT;

        IF NOT VATRegistrationNoFormat.Test("VAT Registration No.","Country/Region Code","No.",DATABASE::Contact) THEN
          EXIT;

        VATRegistrationLogMgt.LogContact(Rec);

        IF ("Country/Region Code" = '') AND (VATRegistrationNoFormat."Country/Region Code" = '') THEN
          EXIT;
        ApplicableCountryCode := "Country/Region Code";
        IF ApplicableCountryCode = '' THEN
          ApplicableCountryCode := VATRegistrationNoFormat."Country/Region Code";

        IF VATRegNoSrvConfig.VATRegNoSrvIsEnabled THEN BEGIN
          VATRegistrationLogMgt.ValidateVATRegNoWithVIES(ResultRecordRef,Rec,"No.",
            VATRegistrationLog."Account Type"::Contact,ApplicableCountryCode);
          ResultRecordRef.SETTABLE(Rec);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..8
        LogNotVerified := TRUE;
        IF ("Country/Region Code" <> '') OR (VATRegistrationNoFormat."Country/Region Code" <> '') THEN BEGIN
          ApplicableCountryCode := "Country/Region Code";
          IF ApplicableCountryCode = '' THEN
            ApplicableCountryCode := VATRegistrationNoFormat."Country/Region Code";
          IF VATRegNoSrvConfig.VATRegNoSrvIsEnabled THEN BEGIN
            LogNotVerified := FALSE;
            VATRegistrationLogMgt.ValidateVATRegNoWithVIES(
              ResultRecordRef,Rec,"No.",VATRegistrationLog."Account Type"::Contact,ApplicableCountryCode);
            ResultRecordRef.SETTABLE(Rec);
          END;
        END;

        IF LogNotVerified THEN
          VATRegistrationLogMgt.LogContact(Rec);
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "GetContNo(PROCEDURE 45)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCalculatedName(PROCEDURE 79)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterIdenticalAddress(PROCEDURE 81)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterModifySellToCustomerNo(PROCEDURE 57)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterModifyBillToCustomerNo(PROCEDURE 62)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterOnModify(PROCEDURE 74)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSetDefaults(PROCEDURE 73)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSetTypeForContact(PROCEDURE 68)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSyncAddress(PROCEDURE 75)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterValidateCity(PROCEDURE 69)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterValidatePostCode(PROCEDURE 70)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeApplyCompanyChangeToPerson(PROCEDURE 61)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeDuplicateCheck(PROCEDURE 63)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckCompanyNo(PROCEDURE 67)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeVATRegistrationValidation(PROCEDURE 169)".


    //Unsupported feature: Property Modification (Attributes) on "OnCreateCustomerOnBeforeUpdateQuotes(PROCEDURE 71)".


    //Unsupported feature: Property Modification (Attributes) on "OnLookupCustomerTemplateOnBeforeSetTableView(PROCEDURE 72)".



    //Unsupported feature: Property Modification (TextConstString) on "MultipleCustomerTemplatesConfirmQst(Variable 1029)".

    //var
        //>>>> ORIGINAL VALUE:
        //MultipleCustomerTemplatesConfirmQst : @@@="%1=Customer Template Code,%2=Customer No.";ENU=Quotes with customer templates different from %1 were assigned to customer %2. Do you want to review the quotes now?;ESM=Las cotizaciones con plantillas de cliente distintas de %1 se asignaron al cliente %2. ¿Desea revisar las cotizaciones ahora?;FRC=Les devis avec des modèles client différents de %1 ont été affectés au client %2. Souhaitez-vous revoir les devis maintenant ?;ENC=Quotes with customer templates different from %1 were assigned to customer %2. Do you want to review the quotes now?;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //MultipleCustomerTemplatesConfirmQst : @@@="%1=Customer Template Code,%2=Customer No.";ENU=Quotes with customer templates different from %1 were assigned to customer %2. Do you want to review the quotes now?;ESM=Se asignaron cotizaciones con plantillas de cliente distintas de %1 al cliente %2. ¿Desea revisar las cotizaciones ahora?;FRC=Les devis avec des modèles client différents de %1 ont été affectés au client %2. Souhaitez-vous revoir les devis maintenant ?;ENC=Quotes with customer templates different from %1 were assigned to customer %2. Do you want to review the quotes now?;
        //Variable type has not been exported.

    var
        PhoneNoCannotContainLettersErr: Label 'must not contain letters';
}

