tableextension 70000020 tableextension70000020 extends Vendor 
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Address 2"(Field 6)".


        //Unsupported feature: Property Modification (Data type) on "City(Field 7)".


        //Unsupported feature: Property Modification (Data type) on ""Phone No."(Field 9)".


        //Unsupported feature: Property Modification (Data type) on ""Telex No."(Field 10)".

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
        modify("Pay-to No. of Blanket Orders")
        {
            Caption = 'Pay-to No. of Blanket Orders';
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
                IF NOT UserSetup."Desbloquea Proveedores" THEN
                  ERROR(Text100)
                ELSE BEGIN
                  ValidaCampReq.Maestros(23,"No.");
                  ValidaCampReq.Dimensiones(23,"No.",0,0);
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

        //Unsupported feature: Property Deletion (InitValue) on "Blocked(Field 39)".


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
            VPG.GET("Vendor Posting Group");

            IF ("VAT Registration No." <> '') AND ((VPG."NCF Obligatorio") OR (VPG."Permite Emitir NCF")) THEN
               BEGIN
                 IF RNCDGII.GET("VAT Registration No.") THEN // jpg validar rnc desde nueva tabla dgii ++
                   BEGIN
                      Name := RNCDGII.Name;
                     IF RNCDGII."Search Name" <> '' THEN
                      "Search Name" := RNCDGII."Search Name";
                   END
                  ELSE // jpg validar rnc desde nueva tabla dgii --
                    BEGIN
                     ConsultaRNC.BuscarRNC("VAT Registration No.",Datos);
                     IF Datos[2] <> '' THEN
                        Name := COPYSTR(Datos[2],1,MAXSTRLEN(Name));
                     IF Datos[3] <> '' THEN
                        "Search Name" := COPYSTR(Datos[3],1,MAXSTRLEN("Search Name"));
                    END;
               END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
            */
        //end;

        //Unsupported feature: Property Deletion (TableRelation) on ""VAT Registration No."(Field 86)".


        //Unsupported feature: Property Deletion (ValidateTableRelation) on ""VAT Registration No."(Field 86)".



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
                ERROR(Text004,Cont."No.",Cont.Name,"No.",Name);

              IF Cont.Type = Cont.Type::Person THEN
                Contact := Cont.Name;

              IF Cont."Phone No." <> '' THEN
                "Phone No." := Cont."Phone No.";
              IF Cont."E-Mail" <> '' THEN
                "E-Mail" := Cont."E-Mail";
            END;
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
            #12..17
            */
        //end;

        //Unsupported feature: Property Deletion (Description) on ""Tax Identification Type"(Field 14020)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Actividad Proveedor"(Field 54000)".


        //Unsupported feature: Deletion (FieldCollection) on "Inactivo(Field 56000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Vendedor"(Field 34002803)".


        //Unsupported feature: Deletion (FieldCollection) on "Rappel(Field 34002804)".


        //Unsupported feature: Deletion (FieldCollection) on "Taller(Field 34002805)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Clasificacion Gasto"(Field 34003007)".

        field(93;"EORI Number";Text[40])
        {
            Caption = 'EORI Number';
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "AssistEdit(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "ShowContact(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "SetInsertFromContact(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "CheckBlockedVendOnDocs(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "CheckBlockedVendOnJnls(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "CreateAndShowNewInvoice(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "CreateAndShowNewCreditMemo(PROCEDURE 22)".


    //Unsupported feature: Property Modification (Attributes) on "CreateAndShowNewPurchaseOrder(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "VendBlockedErrorMessage(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "VendPrivacyBlockedErrorMessage(PROCEDURE 62)".


    //Unsupported feature: Property Modification (Attributes) on "GetPrivacyBlockedGenericErrorText(PROCEDURE 73)".


    //Unsupported feature: Property Modification (Attributes) on "DisplayMap(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "CalcOverDueBalance(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateRFCNo(PROCEDURE 1020000)".


    //Unsupported feature: Property Modification (Attributes) on "GetInvoicedPrepmtAmountLCY(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "GetTotalAmountLCY(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "HasAddress(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "GetVendorNo(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "GetVendorNoOpenCard(PROCEDURE 56)".


    //Unsupported feature: Property Modification (Attributes) on "OpenVendorLedgerEntries(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "SetInsertFromTemplate(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "SetAddress(PROCEDURE 40)".


    //Unsupported feature: Variable Insertion (Variable: LogNotVerified) (VariableCollection) on "VATRegistrationValidation(PROCEDURE 14)".



    //Unsupported feature: Code Modification on "VATRegistrationValidation(PROCEDURE 14)".

    //procedure VATRegistrationValidation();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IsHandled := FALSE;
        OnBeforeVATRegistrationValidation(Rec,IsHandled);
        IF IsHandled THEN
          EXIT;

        IF NOT VATRegistrationNoFormat.Test("VAT Registration No.","Country/Region Code","No.",DATABASE::Vendor) THEN
          EXIT;

        VATRegistrationLogMgt.LogVendor(Rec);

        IF ("Country/Region Code" = '') AND (VATRegistrationNoFormat."Country/Region Code" = '') THEN
          EXIT;
        ApplicableCountryCode := "Country/Region Code";
        IF ApplicableCountryCode = '' THEN
          ApplicableCountryCode := VATRegistrationNoFormat."Country/Region Code";
        IF VATRegNoSrvConfig.VATRegNoSrvIsEnabled THEN BEGIN
          VATRegistrationLogMgt.ValidateVATRegNoWithVIES(ResultRecordRef,Rec,"No.",
            VATRegistrationLog."Account Type"::Vendor,ApplicableCountryCode);
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
              ResultRecordRef,Rec,"No.",VATRegistrationLog."Account Type"::Vendor,ApplicableCountryCode);
            ResultRecordRef.SETTABLE(Rec);
          END;
        END;

        IF LogNotVerified THEN
          VATRegistrationLogMgt.LogVendor(Rec);
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "UpdateCurrencyId(PROCEDURE 55)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePaymentTermsId(PROCEDURE 57)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePaymentMethodId(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateReferencedIds(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "GetReferencedIds(PROCEDURE 46)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterValidateCity(PROCEDURE 75)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterValidatePostCode(PROCEDURE 71)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeIsContactUpdateNeeded(PROCEDURE 50)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckBlockedVend(PROCEDURE 24)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeValidateShortcutDimCode(PROCEDURE 70)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeVATRegistrationValidation(PROCEDURE 27)".



    //Unsupported feature: Property Modification (TextConstString) on "Text002(Variable 1001)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text002 : ENU=You have set %1 to %2. Do you want to update the %3 price list accordingly?;ESM=Tiene fijado %1 a %2. ¿Quiere actualizar el %3 lista precio en concordancia?;FRC=Vous avez réglé %1 à %2. Souhaitez-vous mettre à jour la liste de prix %3 en conséquence ?;ENC=You have set %1 to %2. Do you want to update the %3 price list accordingly?;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text002 : ENU=You have set %1 to %2. Do you want to update the %3 price list accordingly?;ESM=Tiene fijado %1 a %2. ¿Quiere actualizar el %3 lista precio en concordancia?;FRC=Vous avez paramétré %1 sur %2. Souhaitez-vous mettre à jour la liste des prix %3 en conséquence ?;ENC=You have set %1 to %2. Do you want to update the %3 price list accordingly?;
        //Variable type has not been exported.
}

