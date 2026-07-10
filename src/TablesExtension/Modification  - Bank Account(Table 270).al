tableextension 70000027 tableextension70000027 extends "Bank Account" 
{
    fields
    {
        modify("Global Dimension 1 Code")
        {
            Caption = 'Global Dimension 1 Code';
        }
        modify("Global Dimension 2 Code")
        {
            Caption = 'Global Dimension 2 Code';
        }
        modify("Bank Acc. Posting Group")
        {
            Caption = 'Bank Acc. Posting Group';
        }
        modify("Check Report ID")
        {
            Caption = 'Check Report ID';
        }
        modify("Check Report Name")
        {
            Caption = 'Check Report Name';
        }

        //Unsupported feature: Deletion (FieldCollection) on ""Identificador Empresa"(Field 34003000)".


        //Unsupported feature: Deletion (FieldCollection) on "Formato(Field 34003001)".


        //Unsupported feature: Deletion (FieldCollection) on "Secuencia(Field 34003002)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo Cuenta"(Field 34003003)".

    }

    //Unsupported feature: Property Modification (Attributes) on "AssistEdit(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "ShowContact(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "SetInsertFromContact(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "GetPaymentExportCodeunitID(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "GetPaymentExportXMLPortID(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "GetDDExportCodeunitID(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "GetDDExportXMLPortID(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "GetBankExportImportSetup(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "GetDDExportImportSetup(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "GetCreditTransferMessageNo(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "GetDirectDebitMessageNo(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "DisplayMap(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "GetDataExchDef(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "GetDataExchDefPaymentExport(PROCEDURE 51)".


    //Unsupported feature: Property Modification (Attributes) on "GetBankAccountNoWithCheck(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "GetBankAccountNo(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "CheckLastStatementNo(PROCEDURE 1020001)".


    //Unsupported feature: Property Modification (Attributes) on "GetPosPayExportCodeunitID(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateIncrementableText(PROCEDURE 1020000)".


    //Unsupported feature: Property Modification (Attributes) on "IsLinkedToBankStatementServiceProvider(PROCEDURE 27)".


    //Unsupported feature: Property Modification (Attributes) on "LinkStatementProvider(PROCEDURE 32)".


    //Unsupported feature: Property Modification (Attributes) on "SimpleLinkStatementProvider(PROCEDURE 39)".


    //Unsupported feature: Property Modification (Attributes) on "UnlinkStatementProvider(PROCEDURE 31)".


    //Unsupported feature: Property Modification (Attributes) on "RefreshStatementProvider(PROCEDURE 47)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateBankAccountLinking(PROCEDURE 35)".


    //Unsupported feature: Property Modification (Attributes) on "GetUnlinkedBankAccounts(PROCEDURE 30)".


    //Unsupported feature: Property Modification (Attributes) on "GetLinkedBankAccounts(PROCEDURE 33)".


    //Unsupported feature: Property Modification (Attributes) on "IsAutoLogonPossible(PROCEDURE 28)".


    //Unsupported feature: Property Modification (Attributes) on "DisableStatementProviders(PROCEDURE 45)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterIsUpdateNeeded(PROCEDURE 50)".


    //Unsupported feature: Property Modification (Attributes) on "OnCheckLinkedToStatementProviderEvent(PROCEDURE 22)".


    //Unsupported feature: Property Modification (Attributes) on "OnCheckAutoLogonPossibleEvent(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "OnUnlinkStatementProviderEvent(PROCEDURE 24)".


    //Unsupported feature: Property Modification (Attributes) on "OnMarkAccountLinkedEvent(PROCEDURE 41)".


    //Unsupported feature: Property Modification (Attributes) on "OnSimpleLinkStatementProviderEvent(PROCEDURE 40)".


    //Unsupported feature: Property Modification (Attributes) on "OnLinkStatementProviderEvent(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "OnRefreshStatementProviderEvent(PROCEDURE 48)".


    //Unsupported feature: Property Modification (Attributes) on "OnGetDataExchangeDefinitionEvent(PROCEDURE 26)".


    //Unsupported feature: Property Modification (Attributes) on "OnUpdateBankAccountLinkingEvent(PROCEDURE 34)".


    //Unsupported feature: Property Modification (Attributes) on "OnGetStatementProvidersEvent(PROCEDURE 36)".


    //Unsupported feature: Property Modification (Attributes) on "OnDisableStatementProviderEvent(PROCEDURE 46)".


    //Unsupported feature: Property Modification (TextConstString) on "Text000Err(Variable 1000)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text000Err : @@@="%1=currency code";ENU=You cannot change %1 because there are one or more open ledger entries for this bank account.;ESM=No se puede cambiar el banco %1 porque tiene movimientos pendientes.;FRC=Vous ne pouvez changer %1 parce qu'il y a une ou plusieurs écriture(s) pour ce compte bancaire.;ENC=You cannot change %1 because there are one or more open ledger entries for this bank account.;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text000Err : @@@="%1=currency code";ENU=You cannot change %1 because there are one or more open ledger entries for this bank account.;ESM=No se puede cambiar el banco %1 porque tiene movimientos pendientes.;FRC=Vous ne pouvez pas changer %1 parce qu'il existe une ou plusieurs écritures pour ce compte bancaire.;ENC=You cannot change %1 because there are one or more open ledger entries for this bank account.;
        //Variable type has not been exported.
}

