tableextension 70000088 tableextension70000088 extends "Service Header"
{
    fields
    {
        modify("Your Reference")
        {
            Caption = 'Your Reference';
        }
        modify("Shortcut Dimension 1 Code")
        {
            Caption = 'Shortcut Dimension 1 Code';
        }
        modify("Shortcut Dimension 2 Code")
        {
            Caption = 'Shortcut Dimension 2 Code';
        }
        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Gen. Bus. Posting Group';
        }
        modify("Area")
        {
            Caption = 'Area';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'VAT Bus. Posting Group';
        }

        //Unsupported feature: Code Modification on ""Ship-to Code"(Field 12).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Ship-to Code" <> xRec."Ship-to Code") AND
           ("Customer No." = xRec."Customer No.")
        THEN BEGIN
        #4..56
              "Tax Liable" := Cust."Tax Liable";
              IF Cust."Location Code" <> '' THEN
                "Location Code" := Cust."Location Code";
              "Ship-to Fax No." := Cust."E-Mail 2;
              "Ship-to E-Mail" := Cust."E-Mail";
            END;

        #64..75
        VALIDATE("Service Zone Code");

        IF ("Ship-to Code" <> xRec."Ship-to Code") AND
           ("Customer No." = xRec."Customer No.")
        THEN BEGIN
          MODIFY(TRUE);
          ServLine.LOCKTABLE;
        #83..89
          ServItemLine.SETRANGE("Document No.","No.");
          ServItemLine.DELETEALL(TRUE);
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..59
              "Ship-to Fax No." := Cust."Fax No.";
        #61..78
           ("Customer No." = xRec."Customer No.") AND
           ServItemLineExists
        #80..92
        */
        //end;

        //Unsupported feature: Deletion (FieldCollection) on ""No. Serie NCF Facturas"(Field 34003001)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Comprobante Fiscal"(Field 34003002)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Comprobante Fiscal Rel."(Field 34003003)".


        //Unsupported feature: Deletion (FieldCollection) on ""Razon anulacion NCF"(Field 34003004)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Serie NCF Abonos"(Field 34003005)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Clasificacion Gasto"(Field 34003006)".


        //Unsupported feature: Deletion (FieldCollection) on ""Fecha vencimiento NCF"(Field 34003007)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo de ingreso"(Field 34003008)".

        field(27004; "CFDI Export Code"; Code[10])
        {
            Caption = 'CFDI Export Code';
            TableRelation = "CFDI Export Code";
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "AssistEdit(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "CreateDim(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateAllLineDim(PROCEDURE 41)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 19)".


    //Unsupported feature: Variable Insertion (Variable: ServiceCommentLine) (VariableCollection) on "RecreateServLines(PROCEDURE 2)".


    //Unsupported feature: Variable Insertion (Variable: TempServiceCommentLine) (VariableCollection) on "RecreateServLines(PROCEDURE 2)".



    //Unsupported feature: Code Modification on "RecreateServLines(PROCEDURE 2)".

    //procedure RecreateServLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ServLineExists THEN BEGIN
      IF HideValidationDialog THEN
        Confirmed := TRUE
    #4..39
                TempServDocReg.INSERT;
              UNTIL ServDocReg.NEXT = 0;
          END;
          ServLine.DELETEALL(TRUE);

          IF "Document Type" = "Document Type"::Invoice THEN BEGIN
    #46..49
              UNTIL TempServDocReg.NEXT = 0;
          END;

          CreateServiceLines(TempServLine,ExtendedTextAdded);
          TempServLine.SETRANGE(Type);
          TempServLine.DELETEALL;
        END;
      END ELSE
        ERROR('');
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..42
          StoreServiceCommentLineToTemp(TempServiceCommentLine);
          ServiceCommentLine.DeleteComments(ServiceCommentLine."Table Name"::"Service Header","Document Type","No.");
    #43..52
          CreateServiceLines(TempServLine,ExtendedTextAdded,TempServiceCommentLine);
    #54..59
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "TestMandatoryFields(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateResponseDateTime(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "ServLineExists(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "SetHideValidationDialog(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "SetValidatingFromLines(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "CheckCreditMaxBeforeInsert(PROCEDURE 28)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateServiceOrderChangeLog(PROCEDURE 22)".


    //Unsupported feature: Property Modification (Attributes) on "InitRecord(PROCEDURE 32)".


    //Unsupported feature: Property Modification (Attributes) on "SetShipToAddress(PROCEDURE 117)".


    //Unsupported feature: Property Modification (Attributes) on "ConfirmDeletion(PROCEDURE 36)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDocDim(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "LookupAdjmtValueEntries(PROCEDURE 37)".


    //Unsupported feature: Property Modification (Attributes) on "CalcInvDiscForHeader(PROCEDURE 45)".


    //Unsupported feature: Property Modification (Attributes) on "SetSecurityFilterOnRespCenter(PROCEDURE 42)".


    //Unsupported feature: Property Modification (Attributes) on "InventoryPickConflict(PROCEDURE 47)".


    //Unsupported feature: Property Modification (Attributes) on "InvPickConflictResolutionTxt(PROCEDURE 48)".


    //Unsupported feature: Property Modification (Attributes) on "WhseShpmntConflict(PROCEDURE 52)".


    //Unsupported feature: Property Modification (Attributes) on "WhseShpmtConflictResolutionTxt(PROCEDURE 54)".


    //Unsupported feature: Parameter Insertion (Parameter: TempServiceCommentLine) (ParameterCollection) on "CreateServiceLines(PROCEDURE 50)".



    //Unsupported feature: Code Modification on "CreateServiceLines(PROCEDURE 50)".

    //procedure CreateServiceLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ServLine.INIT;
    ServLine."Line No." := 0;
    TempServLine.FIND('-');
    #4..70
          ServLine.FIND('+');
          ExtendedTextAdded := TRUE;
        END;
      CopyReservEntryFromTemp(TempServLine,ServLine."Line No.");
    UNTIL TempServLine.NEXT = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..73
      RestoreServiceCommentLine(TempServiceCommentLine,TempServLine."Line No.",ServLine."Line No.");
      CopyReservEntryFromTemp(TempServLine,ServLine."Line No.");
    UNTIL TempServLine.NEXT = 0;
    RestoreServiceCommentLine(TempServiceCommentLine,0,0);
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "SetCustomerFromFilter(PROCEDURE 186)".


    //Unsupported feature: Property Modification (Attributes) on "CopyCustomerFilter(PROCEDURE 51)".



    //Unsupported feature: Code Modification on "CopyCFDIFieldsFromCustomer(PROCEDURE 1310000)".

    //procedure CopyCFDIFieldsFromCustomer();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Customer.GET("Bill-to Customer No.") THEN BEGIN
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
    #4..6
      "CFDI Export Code" := '';
    END;
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "ConfirmCloseUnposted(PROCEDURE 98)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateSalesPersonOnServiceHeader(PROCEDURE 433)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyCustomerFields(PROCEDURE 71)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyBillToCustomerFields(PROCEDURE 70)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetPostingNoSeriesCode(PROCEDURE 61)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitRecord(PROCEDURE 34)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateShipToAddress(PROCEDURE 137)".


    //Unsupported feature: Property Modification (Attributes) on "OnUpdateServLineByChangedFieldName(PROCEDURE 139)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateDimTableIDs(PROCEDURE 138)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterValidateShortcutDimCode(PROCEDURE 176)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateCust(PROCEDURE 140)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterTransferExtendedTextForServLineRecreation(PROCEDURE 141)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckBlockedCustomer(PROCEDURE 69)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeConfirmUpdateContractNo(PROCEDURE 63)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeGetNoSeries(PROCEDURE 60)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeGetPostingNoSeriesCode(PROCEDURE 65)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInsertServLineOnServLineRecreation(PROCEDURE 35)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeTestMandatoryFields(PROCEDURE 57)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeTestNoSeries(PROCEDURE 58)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeTestNoSeriesManual(PROCEDURE 62)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateAllLineDim(PROCEDURE 236)".


    //Unsupported feature: Property Modification (Attributes) on "OnCreateDimOnBeforeUpdateLines(PROCEDURE 66)".


    local procedure StoreServiceCommentLineToTemp(var TempServiceCommentLine Record: 5906" temporary)
    var
        ServiceCommentLine Record: 5906;
    begin
        ServiceCommentLine.SETRANGE("Table Name", ServiceCommentLine."Table Name"::"Service Header");
        ServiceCommentLine.SETRANGE("Table Subtype", "Document Type");
        ServiceCommentLine.SETRANGE("No.", "No.");
        IF ServiceCommentLine.FINDSET THEN
            REPEAT
                TempServiceCommentLine := ServiceCommentLine;
                TempServiceCommentLine.INSERT;
            UNTIL ServiceCommentLine.NEXT = 0;
    end;

    local procedure RestoreServiceCommentLine(var TempServiceCommentLine Record: 5906" temporary;OldDocumentLineNo: Integer;NewDocumentLineNo: Integer)
    var
        ServiceCommentLine Record: 5906;
    begin
        TempServiceCommentLine.SETRANGE("Table Name", TempServiceCommentLine."Table Name"::"Service Header");
        TempServiceCommentLine.SETRANGE("Table Subtype", "Document Type");
        TempServiceCommentLine.SETRANGE("No.", "No.");
        TempServiceCommentLine.SETRANGE("Table Line No.", OldDocumentLineNo);
        IF TempServiceCommentLine.FINDSET THEN
            REPEAT
                ServiceCommentLine := TempServiceCommentLine;
                ServiceCommentLine."Table Line No." := NewDocumentLineNo;
                ServiceCommentLine.INSERT;
            UNTIL TempServiceCommentLine.NEXT = 0;
    end;

    [Scope('Personalization')]
    procedure IsCreditDocType(): Boolean
    begin
        EXIT("Document Type" = "Document Type"::"Credit Memo");
    end;


    //Unsupported feature: Property Modification (TextConstString) on "Text013(Variable 1089)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text013 : ENU=Deleting this document will cause a gap in the number series for posted credit memos. An empty posted credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?;ESM=Si elimina el documento, se provocará una discontinuidad en la numeración de la serie de notas de crédito registradas. Se creará un nota crédito regis. en blanco %1 para completar este error en las series numéricas.\\¿Desea continuar?;FRC=La suppression de ce document va engendrer un écart dans la série de numéros d'avoirs reportés. Un avoir reporté vide %1 va être créé pour éviter un écart dans la série de numéros.\\Voulez-vous continuer ?;ENC=Deleting this document will cause a gap in the number series for posted credit memos. An empty posted credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text013 : ENU=Deleting this document will cause a gap in the number series for posted credit memos. An empty posted credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?;ESM=Si elimina el documento, se provocará una discontinuidad en la serie numérica de notas de crédito registradas. Se creará una nota de crédito registrada en blanco %1 para completar este error en la serie numérica.\\¿Desea continuar?;FRC=La suppression de ce document va engendrer un écart dans la série de numéros des notes de crédit reportées. Une note de crédit reportée vide %1 va être créée pour éviter un écart dans la série de numéros.\\Voulez-vous continuer?;ENC=Deleting this document will cause a gap in the number series for posted credit memos. An empty posted credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text039(Variable 1061)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text039 : @@@="%1=Contact number;%2=Contact name;";ENU=Contact %1 %2 is not related to a customer.;ESM=Contacto %1 %2 no está relacionado con un cliente.;FRC=Le contact %1 %2 n'est pas associé à un client.;ENC=Contact %1 %2 is not related to a customer.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text039 : @@@="%1=Contact number;%2=Contact name;";ENU=Contact %1 %2 is not related to a customer.;ESM=El contacto %1 %2 no está relacionado con un cliente.;FRC=Le contact %1 %2 n'est associé à aucun client.;ENC=Contact %1 %2 is not related to a customer.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "PostedDocsToPrintCreatedMsg(Variable 1022)".

    //var
    //>>>> ORIGINAL VALUE:
    //PostedDocsToPrintCreatedMsg : ENU=One or more related posted documents have been generated during deletion to fill gaps in the posting number series. You can view or print the documents from the respective document archive.;ESM=Durante la eliminación, se han generado uno o más documentos registrados relacionados en sustitución de los números de registro que faltan de la serie. Puede ver o imprimir los documentos del archivo de documentos correspondiente.;FRC=Un ou plusieurs documents reportés connexes ont été générés lors de la suppression pour éviter une discontinuité dans la série de numéros de report. Vous pouvez afficher ou imprimer les documents à partir de l'archive de document correspondant.;ENC=One or more related posted documents have been generated during deletion to fill gaps in the posting number series. You can view or print the documents from the respective document archive.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PostedDocsToPrintCreatedMsg : ENU=One or more related posted documents have been generated during deletion to fill gaps in the posting number series. You can view or print the documents from the respective document archive.;ESM=Durante la eliminación, se han generado uno o más documentos registrados relacionados en sustitución de los números de registro que faltan de la serie. Puede ver o imprimir los documentos del archivo de documentos correspondiente.;FRC=Un ou plusieurs documents reportés connexes ont été générés lors de la suppression pour éviter des écarts dans la série de numéros de report. Vous pouvez afficher ou imprimer les documents à partir de l'archive du document correspondant.;ENC=One or more related posted documents have been generated during deletion to fill gaps in the posting number series. You can view or print the documents from the respective document archive.;
    //Variable type has not been exported.
}

