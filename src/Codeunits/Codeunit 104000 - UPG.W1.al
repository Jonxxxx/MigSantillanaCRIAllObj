codeunit 104000 "UPG.W1"
{
    Subtype = Upgrade;

    trigger OnRun()
    begin
    end;

    var
        DataUpgradeMgt: Codeunit 9900;
        ODataUtility: Codeunit 6710;
        PowerBICustomerListTxt: Label 'Power BI Customer List', Locked = true;
        PowerBIVendorListTxt: Label 'Power BI Vendor List', Locked = true;
        PowerBIJobsListTxt: Label 'Power BI Jobs List', Locked = true;
        PowerBISalesListTxt: Label 'Power BI Sales List', Locked = true;
        PowerBIPurchaseListTxt: Label 'Power BI Purchase List', Locked = true;
        PowerBIItemPurchasesListTxt: Label 'Power BI Item Purchase List', Locked = true;
        PowerBIItemSalesListTxt: Label 'Power BI Item Sales List', Locked = true;
        PowerBIGLAmountListTxt: Label 'Power BI GL Amount List', Locked = true;
        PowerBIGLBudgetedAmountListTxt: Label 'Power BI GL BudgetedAmount', Locked = true;
        PowerBITopCustOverviewTxt: Label 'Power BI Top Cust. Overview', Locked = true;
        PowerBISalesHdrCustTxt: Label 'Power BI Sales Hdr. Cust.', Locked = true;
        PowerBICustItemLedgEntTxt: Label 'Power BI Cust. Item Ledg. Ent.', Locked = true;
        PowerBICustLedgerEntriesTxt: Label 'Power BI Cust. Ledger Entries', Locked = true;
        PowerBIVendorLedgerEntriesTxt: Label 'Power BI Vendor Ledger Entries', Locked = true;
        PowerBIPurchaseHdrVendorTxt: Label 'Power BI Purchase Hdr. Vendor', Locked = true;
        PowerBIVendItemLedgEntTxt: Label 'Power BI Vend. Item Ledg. Ent.', Locked = true;
        PowerBIAgedAccPayableTxt: Label 'Power BI Aged Acc. Payable', Locked = true;
        PowerBIAgedAccReceivableTxt: Label 'Power BI Aged Acc. Receivable', Locked = true;
        PowerBIAgedInventoryChartTxt: Label 'Power BI Aged Inventory Chart', Locked = true;
        PowerBIJobActBudgPriceTxt: Label 'Power BI Job Act. v. Budg. Price', Locked = true;
        PowerBIJobProfitabilityTxt: Label 'Power BI Job Profitability', Locked = true;
        PowerBIJobActBudgCostTxt: Label 'Power BI Job Act. v. Budg. Cost', Locked = true;
        PowerBISalesPipelineTxt: Label 'Power BI Sales Pipeline', Locked = true;
        PowerBITop5OpportunitiesTxt: Label 'Power BI Top 5 Opportunities', Locked = true;
        PowerBIWorkDateCalcTxt: Label 'Power BI WorkDate Calc.', Locked = true;
        PowerBIReportLabelsTxt: Label 'Power BI Report Labels', Locked = true;
        JobListTxt: Label 'Job List', Locked = true;
        JobTaskLinesTxt: Label 'Job Task Lines', Locked = true;
        JobPlanningLinesTxt: Label 'Job Planning Lines', Locked = true;

    [CheckPrecondition]
    procedure CheckPreconditions()
    begin
    end;

    [TableSyncSetup]
    procedure GetTableSyncSetupW1(var TableSynchSetup Record: 2000000135")
    begin
        // The purpose of this method is to define how old and new tables will be available for dataupgrade

        // The method is called at a point in time where schema changes have not yet been synchronized to
        // the database so tables except virtual tables cannot be accessed

        // TableSynchSetup."Table ID":
        // Id of the table with schema changes (i.e the modified table).

        // TableSynchSetup."Upgrade Table ID":
        // Id of table where old data will be available in case the selected TableSynchSetup.Mode option is one of Copy or Move , otherwise 0

        // TableSynchSetup.Mode:
        // An option indicating how the data will be handled during synchronization
        // Check: Synchronize without saving data in the upgrade table, fails if there is data in the modified field/table
        // Copy: Synchronize with saving data in the upgrade table, the modified table contains data in matching fields
        // Move: Synchronize with moving the data in the upgrade table,the changed table is empty; the upgrade logic is handled only by application code
        // Force: Synchronize without saving data in the upgrade table, disregard if there is data in the modified field/table

        // Examples:
        // DataUpgradeMgt.SetTableSyncSetup(DATABASE::"Sales Header",DATABASE::"UPG Sales Header",TableSynchSetup.Mode::Copy);
        // DataUpgradeMgt.SetTableSyncSetup(DATABASE::"Payment Export Data",0,TableSynchSetup.Mode::Force);

        DataUpgradeMgt.SetTableSyncSetup(DATABASE::"Sales & Receivables Setup", 0, TableSynchSetup.Mode::Force);
        DataUpgradeMgt.SetTableSyncSetup(DATABASE::"Purchases & Payables Setup", 0, TableSynchSetup.Mode::Force);
    end;

    [UpgradePerCompany]
    procedure UpgradeReportSelections()
    var
        ReportSelections: Record 77;
    begin
        WITH ReportSelections DO BEGIN
            IF NOT GET(Usage::"S.Arch.Blanket", '1') THEN
                InsertReportSelections(Usage::"S.Arch.Blanket", '1', REPORT::"Archived Blanket Sales Order");
            IF NOT GET(Usage::"P.Arch.Blanket", '1') THEN
                InsertReportSelections(Usage::"P.Arch.Blanket", '1', REPORT::"Archived Blanket Purch. Order");
        END;
    end;

    local procedure InsertReportSelections(ReportUsage: Integer; ReportSequence: Code[10]; ReportID: Integer)
    var
        ReportSelections: Record 77;
    begin
        WITH ReportSelections DO BEGIN
            INIT;
            Usage := ReportUsage;
            Sequence := ReportSequence;
            "Report ID" := ReportID;
            INSERT;
        END;
    end;

    [UpgradePerCompany]
    procedure UpgradeSalesSetup()
    var
        SalesReceivablesSetup: Record 311;
    begin
        IF SalesReceivablesSetup.GET THEN BEGIN
            SalesReceivablesSetup."Archive Orders" := SalesReceivablesSetup."Archive Quotes and Orders";
            IF SalesReceivablesSetup."Archive Quotes and Orders" THEN
                SalesReceivablesSetup."Archive Quotes" := SalesReceivablesSetup."Archive Quotes"::Always;
            SalesReceivablesSetup.MODIFY;
        END;
    end;

    [UpgradePerCompany]
    procedure UpgradePurchSetup()
    var
        PurchPayablesSetup: Record 312;
    begin
        IF PurchPayablesSetup.GET THEN BEGIN
            PurchPayablesSetup."Archive Orders" := PurchPayablesSetup."Archive Quotes and Orders";
            IF PurchPayablesSetup."Archive Quotes and Orders" THEN
                PurchPayablesSetup."Archive Quotes" := PurchPayablesSetup."Archive Quotes"::Always;
            PurchPayablesSetup.MODIFY;
        END;
    end;

    [UpgradePerCompany]
    procedure UpdateO365EmailSetup()
    var
        O365EmailSetup: Record 2118;
        NewO365EmailSetup: Record 2118;
        TempO365EmailSetup Record: 2118" temporary;
        IntegrationManagement: Codeunit 5150;
    begin
        IF O365EmailSetup.FINDSET THEN
            REPEAT
                IF UPPERCASE(O365EmailSetup.Code) = UPPERCASE(O365EmailSetup.Email) THEN BEGIN
                    TempO365EmailSetup.COPY(O365EmailSetup);
                    TempO365EmailSetup.INSERT;
                END;
            UNTIL O365EmailSetup.NEXT = 0;

        IF TempO365EmailSetup.FINDSET THEN
            REPEAT
                IF O365EmailSetup.GET(TempO365EmailSetup.Code, TempO365EmailSetup.RecipientType) THEN BEGIN
                    NewO365EmailSetup := O365EmailSetup;
                    NewO365EmailSetup.Code := COPYSTR(IntegrationManagement.GetIdWithoutBrackets(CREATEGUID), 1, MAXSTRLEN(O365EmailSetup.Code));

                    O365EmailSetup.DELETE;
                    NewO365EmailSetup.INSERT;
                END;
            UNTIL TempO365EmailSetup.NEXT = 0;
    end;

    [UpgradePerCompany]
    procedure UpdateAzureADMgtProviderSetup()
    begin
        CODEUNIT.RUN(CODEUNIT::"Setup Azure AD Mgt. Provider");
    end;

    [UpgradePerCompany]
    procedure UpdateSalesQuoteEntityBuffer()
    var
        SalesQuoteEntityBuffer: Record 5505;
        SalesHeader: Record 36;
    begin
        SalesHeader.SETAUTOCALCFIELDS("Last Email Sent Time", "Last Email Sent Status");

        IF SalesQuoteEntityBuffer.FINDSET(TRUE, FALSE) THEN
            REPEAT
                IF SalesHeader.GET(SalesHeader."Document Type"::Quote, SalesQuoteEntityBuffer."No.") THEN
                    IF SalesHeader."Last Email Sent Status" <> SalesQuoteEntityBuffer."Last Email Sent Status" THEN BEGIN
                        SalesQuoteEntityBuffer."Last Email Sent Status" := SalesHeader."Last Email Sent Status";
                        SalesQuoteEntityBuffer.MODIFY(TRUE);
                    END;
            UNTIL SalesQuoteEntityBuffer.NEXT = 0;
    end;

    [UpgradePerCompany]
    procedure UpdatePulseEventSettings()
    var
        O365C2GraphEventSettings: Record 2162;
    begin
        IF NOT O365C2GraphEventSettings.GET THEN
            EXIT;

        O365C2GraphEventSettings."Kpi Update Enabled" := TRUE;

        IF O365C2GraphEventSettings.MODIFY THEN;
    end;

    [UpgradePerCompany]
    procedure UpdateVATRateChangeSetup()
    var
        VATRateChangeSetup: Record 550;
    begin
        IF VATRateChangeSetup.GET THEN BEGIN
            VATRateChangeSetup."Ignore Status on Service Docs." := TRUE;
            VATRateChangeSetup.MODIFY;
        END;
    end;

    [UpgradePerCompany]
    procedure UpdateUnpostedNotificationsForAllUsers()
    var
        MyNotifications: Record 1518;
        FilterBlob: Record 99008535;
        InstructionMgt: Codeunit 1330;
        OutStream: OutStream;
    begin
        MyNotifications.SETRANGE("Apply to Table Id", 0);
        MyNotifications.SETRANGE("Notification Id", InstructionMgt.GetClosingUnpostedDocumentNotificationId);
        IF NOT MyNotifications.ISEMPTY THEN BEGIN
            FilterBlob.INIT;
            FilterBlob.Blob.CREATEOUTSTREAM(OutStream);
            OutStream.WRITE(
              MyNotifications.GetXmlFromTableView(DATABASE::"Sales Header", InstructionMgt.GetDocumentTypeInvoiceFilter));
            MyNotifications.MODIFYALL("Apply to Table Filter", FilterBlob.Blob, FALSE);
            MyNotifications.MODIFYALL("Apply to Table Id", DATABASE::"Sales Header", TRUE);
        END;
    end;

    [UpgradePerDatabase]
    procedure UpgradePermissionSets()
    var
        PermissionSet: Record 2000000004;
        PermissionManager: Codeunit 9002;
    begin
        PermissionSet.SETRANGE(Hash, '');
        IF PermissionSet.FINDSET THEN
            REPEAT
                PermissionManager.UpdateHashForPermissionSet(PermissionSet."Role ID");
            UNTIL PermissionSet.NEXT = 0;
    end;

    [UpgradePerCompany]
    procedure CleanupDataExch()
    var
        DataExch: Record 1220;
        DataExchField: Record 1221;
    begin
        DataExch.DELETEALL;
        DataExchField.DELETEALL;
    end;

    local procedure CreateTenantWebServiceOData(TenantWebService: Record 2000000168)
    var
        TenantWebServiceOData: Record 6710;
        SelectText: Text;
    begin
        TenantWebServiceOData.INIT;
        TenantWebServiceOData.TenantWebServiceID := TenantWebService.RECORDID;
        IF NOT TenantWebServiceOData.INSERT THEN;
        ODataUtility.GenerateSelectText(TenantWebService."Service Name", TenantWebService."Object Type", SelectText);
        TenantWebServiceOData.SetOdataSelectClause(SelectText);
        TenantWebServiceOData.MODIFY;
    end;

    local procedure CreateTenantWebServiceColumn(TenantWebServiceRecordId: RecordID; FieldNumber: Integer; DataItem: Integer)
    var
        TenantWebServiceColumns: Record 6711;
        FieldTable: Record 2000000041;
        ODataUtility: Codeunit 6710;
        FieldNameConverted: Text;
    begin
        TenantWebServiceColumns.INIT;
        TenantWebServiceColumns."Entry ID" := 0;
        TenantWebServiceColumns."Data Item" := DataItem;
        TenantWebServiceColumns."Field Number" := FieldNumber;
        TenantWebServiceColumns.TenantWebServiceID := TenantWebServiceRecordId;
        TenantWebServiceColumns.Include := TRUE;

        IF FieldTable.GET(DataItem, FieldNumber) THEN
            FieldNameConverted := ODataUtility.ConvertNavFieldNameToOdataName(FieldTable.FieldName);

        TenantWebServiceColumns."Field Name" := COPYSTR(FieldNameConverted, 1, 250);
        IF TenantWebServiceColumns.INSERT THEN;
    end;

    [UpgradePerCompany]
    procedure CreatePowerBITenantWebServices()
    begin
        CreatePowerBICustomerList;
        CreatePowerBIVendorList;
        CreatePowerBIJobList;
        CreatePowerBISalesList;
        CreatePowerBIPurchaseList;
        CreatePowerBIItemPurchaseList;
        CreatePowerBIItemSalesList;
        CreatePowerBIGLAmountList;
        CreatePowerBIGLBudgetedAmountList;
        CreatePowerBITopCustOverviewWebService;
        CreatePowerBISalesHdrCustWebService;
        CreatePowerBICustItemLedgEntWebService;
        CreatePowerBICustLedgerEntriesWebService;
        CreatePowerBIVendorLedgerEntriesWebService;
        CreatePowerBIPurchaseHdrVendorWebService;
        CreatePowerBIVendItemLedgEntWebService;
        CreatePowerBIAgedAccPayableWebService;
        CreatePowerBIAgedAccReceivableWebService;
        CreatePowerBIAgedInventoryChartWebService;
        CreatePowerBIJobActBudgPriceWebService;
        CreatePowerBIJobProfitabilityWebService;
        CreatePowerBIJobActBudgCostWebService;
        CreatePowerBISalesPipelineWebService;
        CreatePowerBITop5OpportunitiesWebService;
        CreatePowerBIWorkDateCalcWebService;
        CreatePowerBIReportLabelsWebService;
    end;

    local procedure CreatePowerBICustomerList()
    var
        TenantWebService: Record 2000000168;
        Customer: Record 18;
        DetailedCustLedgEntry: Record 379;
        WebServiceManagement: Codeunit 9750;
    begin
        WebServiceManagement.CreateTenantWebService(
          TenantWebService."Object Type"::Query, QUERY::"Power BI Customer List", PowerBICustomerListTxt, TRUE);

        TenantWebService.GET(TenantWebService."Object Type"::Query, PowerBICustomerListTxt);
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, Customer.FIELDNO("No."), DATABASE::Customer);
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, Customer.FIELDNO(Name), DATABASE::Customer);
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, Customer.FIELDNO("Credit Limit (LCY)"), DATABASE::Customer);
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, Customer.FIELDNO("Balance Due"), DATABASE::Customer);
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, DetailedCustLedgEntry.FIELDNO("Posting Date"),
          DATABASE::"Detailed Cust. Ledg. Entry");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, DetailedCustLedgEntry.FIELDNO("Cust. Ledger Entry No."),
          DATABASE::"Detailed Cust. Ledg. Entry");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, DetailedCustLedgEntry.FIELDNO(Amount),
          DATABASE::"Detailed Cust. Ledg. Entry");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, DetailedCustLedgEntry.FIELDNO("Amount (LCY)"),
          DATABASE::"Detailed Cust. Ledg. Entry");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, DetailedCustLedgEntry.FIELDNO("Transaction No."),
          DATABASE::"Detailed Cust. Ledg. Entry");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, DetailedCustLedgEntry.FIELDNO("Entry No."),
          DATABASE::"Detailed Cust. Ledg. Entry");

        CreateTenantWebServiceOData(TenantWebService);
    end;

    local procedure CreatePowerBIVendorList()
    var
        Vendor: Record 23;
        DetailedVendorLedgEntry: Record 380;
        TenantWebService: Record 2000000168;
        WebServiceManagement: Codeunit 9750;
    begin
        WebServiceManagement.CreateTenantWebService(
          TenantWebService."Object Type"::Query, QUERY::"Power BI Vendor List", PowerBIVendorListTxt, TRUE);

        TenantWebService.GET(TenantWebService."Object Type"::Query, PowerBIVendorListTxt);
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, Vendor.FIELDNO("No."), DATABASE::Vendor);
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, Vendor.FIELDNO(Name), DATABASE::Vendor);
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, Vendor.FIELDNO("Balance Due"), DATABASE::Vendor);
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, DetailedVendorLedgEntry.FIELDNO("Posting Date"),
          DATABASE::"Detailed Vendor Ledg. Entry");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, DetailedVendorLedgEntry.FIELDNO("Applied Vend. Ledger Entry No."),
          DATABASE::"Detailed Vendor Ledg. Entry");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, DetailedVendorLedgEntry.FIELDNO(Amount),
          DATABASE::"Detailed Vendor Ledg. Entry");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, DetailedVendorLedgEntry.FIELDNO("Amount (LCY)"),
          DATABASE::"Detailed Vendor Ledg. Entry");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, DetailedVendorLedgEntry.FIELDNO("Transaction No."),
          DATABASE::"Detailed Vendor Ledg. Entry");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, DetailedVendorLedgEntry.FIELDNO("Entry No."),
          DATABASE::"Detailed Vendor Ledg. Entry");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, DetailedVendorLedgEntry.FIELDNO("Remaining Pmt. Disc. Possible"),
          DATABASE::"Detailed Vendor Ledg. Entry");

        CreateTenantWebServiceOData(TenantWebService);
    end;

    local procedure CreatePowerBIJobList()
    var
        JobLedgerEntry: Record 169;
        TenantWebService: Record 2000000168;
        Job: Record 167;
        WebServiceManagement: Codeunit 9750;
    begin
        WebServiceManagement.CreateTenantWebService(
          TenantWebService."Object Type"::Query, QUERY::"Power BI Jobs List", PowerBIJobsListTxt, TRUE);

        TenantWebService.GET(TenantWebService."Object Type"::Query, PowerBIJobsListTxt);
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, Job.FIELDNO("No."), DATABASE::Job);
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, Job.FIELDNO("Search Description"), DATABASE::Job);
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, Job.FIELDNO(Complete), DATABASE::Job);
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, Job.FIELDNO(Status), DATABASE::Job);
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, JobLedgerEntry.FIELDNO("Posting Date"), DATABASE::"Job Ledger Entry");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, JobLedgerEntry.FIELDNO("Total Cost"), DATABASE::"Job Ledger Entry");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, JobLedgerEntry.FIELDNO("Entry No."), DATABASE::"Job Ledger Entry");

        CreateTenantWebServiceOData(TenantWebService);
    end;

    local procedure CreatePowerBISalesList()
    var
        SalesHeader: Record 36;
        SalesLine: Record 37;
        TenantWebService: Record 2000000168;
        WebServiceManagement: Codeunit 9750;
    begin
        WebServiceManagement.CreateTenantWebService(
          TenantWebService."Object Type"::Query, QUERY::"Power BI Sales List", PowerBISalesListTxt, TRUE);

        TenantWebService.GET(TenantWebService."Object Type"::Query, PowerBISalesListTxt);
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, SalesHeader.FIELDNO("No."), DATABASE::"Sales Header");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, SalesHeader.FIELDNO("Requested Delivery Date"),
          DATABASE::"Sales Header");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, SalesHeader.FIELDNO("Shipment Date"), DATABASE::"Sales Header");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, SalesHeader.FIELDNO("Due Date"), DATABASE::"Sales Header");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, SalesLine.FIELDNO(Quantity), DATABASE::"Sales Line");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, SalesLine.FIELDNO(Amount), DATABASE::"Sales Line");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, SalesLine.FIELDNO("No."), DATABASE::"Sales Line");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, SalesLine.FIELDNO(Description), DATABASE::"Sales Line");

        CreateTenantWebServiceOData(TenantWebService);
    end;

    local procedure CreatePowerBIPurchaseList()
    var
        PurchaseHeader: Record 38;
        PurchaseLine: Record 39;
        TenantWebService: Record 2000000168;
        WebServiceManagement: Codeunit 9750;
    begin
        WebServiceManagement.CreateTenantWebService(
          TenantWebService."Object Type"::Query, QUERY::"Power BI Purchase List", PowerBIPurchaseListTxt, TRUE);

        TenantWebService.GET(TenantWebService."Object Type"::Query, PowerBIPurchaseListTxt);
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, PurchaseHeader.FIELDNO("No."), DATABASE::"Purchase Header");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, PurchaseHeader.FIELDNO("Order Date"), DATABASE::"Purchase Header");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, PurchaseHeader.FIELDNO("Expected Receipt Date"),
          DATABASE::"Purchase Header");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, PurchaseHeader.FIELDNO("Due Date"), DATABASE::"Purchase Header");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, PurchaseHeader.FIELDNO("Pmt. Discount Date"),
          DATABASE::"Purchase Header");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, PurchaseLine.FIELDNO(Quantity), DATABASE::"Purchase Line");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, PurchaseLine.FIELDNO(Amount), DATABASE::"Purchase Line");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, PurchaseLine.FIELDNO("No."), DATABASE::"Purchase Line");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, PurchaseLine.FIELDNO(Description), DATABASE::"Purchase Line");

        CreateTenantWebServiceOData(TenantWebService);
    end;

    local procedure CreatePowerBIItemPurchaseList()
    var
        Item: Record 27;
        ItemLedgerEntry: Record 32;
        TenantWebService: Record 2000000168;
        WebServiceManagement: Codeunit 9750;
    begin
        WebServiceManagement.CreateTenantWebService(
          TenantWebService."Object Type"::Query, QUERY::"Power BI Item Purchase List", PowerBIItemPurchasesListTxt, TRUE);

        TenantWebService.GET(TenantWebService."Object Type"::Query, PowerBIItemPurchasesListTxt);
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, Item.FIELDNO("No."), DATABASE::Item);
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, Item.FIELDNO("Search Description"), DATABASE::Item);
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, ItemLedgerEntry.FIELDNO("Posting Date"),
          DATABASE::"Item Ledger Entry");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, ItemLedgerEntry.FIELDNO("Invoiced Quantity"),
          DATABASE::"Item Ledger Entry");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, ItemLedgerEntry.FIELDNO("Entry No."), DATABASE::"Item Ledger Entry");

        CreateTenantWebServiceOData(TenantWebService);
    end;

    local procedure CreatePowerBIItemSalesList()
    var
        Item: Record 27;
        ValueEntry: Record 5802;
        TenantWebService: Record 2000000168;
        WebServiceManagement: Codeunit 9750;
    begin
        WebServiceManagement.CreateTenantWebService(
          TenantWebService."Object Type"::Query, QUERY::"Power BI Item Sales List", PowerBIItemSalesListTxt, TRUE);

        TenantWebService.GET(TenantWebService."Object Type"::Query, PowerBIItemSalesListTxt);
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, Item.FIELDNO("No."), DATABASE::Item);
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, Item.FIELDNO("Search Description"), DATABASE::Item);
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, ValueEntry.FIELDNO("Posting Date"), DATABASE::"Value Entry");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, ValueEntry.FIELDNO("Invoiced Quantity"), DATABASE::"Value Entry");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, ValueEntry.FIELDNO("Entry No."), DATABASE::"Value Entry");

        CreateTenantWebServiceOData(TenantWebService);
    end;

    local procedure CreatePowerBIGLAmountList()
    var
        GLAccount: Record 15;
        GLEntry: Record 17;
        TenantWebService: Record 2000000168;
        WebServiceManagement: Codeunit 9750;
    begin
        WebServiceManagement.CreateTenantWebService(
          TenantWebService."Object Type"::Query, QUERY::"Power BI GL Amount List", PowerBIGLAmountListTxt, TRUE);

        TenantWebService.GET(TenantWebService."Object Type"::Query, PowerBIGLAmountListTxt);
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, GLAccount.FIELDNO("No."), DATABASE::"G/L Account");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, GLAccount.FIELDNO(Name), DATABASE::"G/L Account");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, GLAccount.FIELDNO("Account Type"), DATABASE::"G/L Account");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, GLAccount.FIELDNO("Debit/Credit"), DATABASE::"G/L Account");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, GLEntry.FIELDNO("Posting Date"), DATABASE::"G/L Entry");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, GLEntry.FIELDNO(Amount), DATABASE::"G/L Entry");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, GLEntry.FIELDNO("Entry No."), DATABASE::"G/L Entry");

        CreateTenantWebServiceOData(TenantWebService);
    end;

    local procedure CreatePowerBIGLBudgetedAmountList()
    var
        GLAccount: Record 15;
        GLBudgetEntry: Record 96;
        TenantWebService: Record 2000000168;
        WebServiceManagement: Codeunit 9750;
    begin
        WebServiceManagement.CreateTenantWebService(
          TenantWebService."Object Type"::Query, QUERY::"Power BI GL Budgeted Amount", PowerBIGLBudgetedAmountListTxt, TRUE);

        TenantWebService.GET(TenantWebService."Object Type"::Query, PowerBIGLBudgetedAmountListTxt);
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, GLAccount.FIELDNO("No."), DATABASE::"G/L Account");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, GLAccount.FIELDNO(Name), DATABASE::"G/L Account");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, GLAccount.FIELDNO("Account Type"), DATABASE::"G/L Account");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, GLAccount.FIELDNO("Debit/Credit"), DATABASE::"G/L Account");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, GLBudgetEntry.FIELDNO(Date), DATABASE::"G/L Budget Entry");
        CreateTenantWebServiceColumn(TenantWebService.RECORDID, GLBudgetEntry.FIELDNO(Amount), DATABASE::"G/L Budget Entry");

        CreateTenantWebServiceOData(TenantWebService);
    end;

    local procedure CreatePowerBITopCustOverviewWebService()
    var
        CustLedgerEntry: Record 21;
        Customer: Record 18;
        TenantWebService: Record 2000000168;
        WebServiceManagement: Codeunit 9750;
        metaData: DotNet QueryMetadataReader;
    begin
        WebServiceManagement.CreateTenantWebService(
          TenantWebService."Object Type"::Query, QUERY::"Power BI Top Cust. Overview", PowerBITopCustOverviewTxt, TRUE);

        TenantWebService.GET(TenantWebService."Object Type"::Query, PowerBITopCustOverviewTxt);
        ODataUtility.GetTenantWebServiceMetadata(TenantWebService, metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, CustLedgerEntry.FIELDNO("Entry No."),
          DATABASE::"Cust. Ledger Entry", metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, CustLedgerEntry.FIELDNO("Posting Date"),
          DATABASE::"Cust. Ledger Entry", metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, CustLedgerEntry.FIELDNO("Customer No."),
          DATABASE::"Cust. Ledger Entry", metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, CustLedgerEntry.FIELDNO("Sales (LCY)"),
          DATABASE::"Cust. Ledger Entry", metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, Customer.FIELDNO(Name),
          DATABASE::Customer, metaData);

        CreateTenantWebServiceOData(TenantWebService);
    end;

    local procedure CreatePowerBISalesHdrCustWebService()
    var
        SalesHeader: Record 36;
        SalesLine: Record 37;
        Item: Record 27;
        Customer: Record 18;
        TenantWebService: Record 2000000168;
        WebServiceManagement: Codeunit 9750;
        metaData: DotNet QueryMetadataReader;
    begin
        WebServiceManagement.CreateTenantWebService(
          TenantWebService."Object Type"::Query, QUERY::"Power BI Sales Hdr. Cust.", PowerBISalesHdrCustTxt, TRUE);

        TenantWebService.GET(TenantWebService."Object Type"::Query, PowerBISalesHdrCustTxt);
        ODataUtility.GetTenantWebServiceMetadata(TenantWebService, metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, SalesHeader.FIELDNO("No."), DATABASE::"Sales Header",
          metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, SalesLine.FIELDNO("No."), DATABASE::"Sales Line",
          metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, SalesLine.FIELDNO(Quantity),
          DATABASE::"Sales Line", metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, SalesLine.FIELDNO("Qty. Invoiced (Base)"),
          DATABASE::"Sales Line", metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, SalesLine.FIELDNO("Qty. Shipped (Base)"),
          DATABASE::"Sales Line", metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, Item.FIELDNO("Base Unit of Measure"),
          DATABASE::Item, metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, Item.FIELDNO(Description),
          DATABASE::Item, metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, Item.FIELDNO(Inventory),
          DATABASE::Item, metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, Item.FIELDNO("Unit Price"),
          DATABASE::Item, metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, Customer.FIELDNO("No."),
          DATABASE::Customer, metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, Customer.FIELDNO(Name),
          DATABASE::Customer, metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, Customer.FIELDNO(Balance),
          DATABASE::Customer, metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, Customer.FIELDNO("Country/Region Code"),
          DATABASE::Customer, metaData);

        CreateTenantWebServiceOData(TenantWebService);
    end;

    local procedure CreatePowerBICustItemLedgEntWebService()
    var
        Customer: Record 18;
        ItemLedgerEntry: Record 32;
        TenantWebService: Record 2000000168;
        WebServiceManagement: Codeunit 9750;
        metaData: DotNet QueryMetadataReader;
    begin
        WebServiceManagement.CreateTenantWebService(
          TenantWebService."Object Type"::Query, QUERY::"Power BI Cust. Item Ledg. Ent.", PowerBICustItemLedgEntTxt, TRUE);

        TenantWebService.GET(TenantWebService."Object Type"::Query, PowerBICustItemLedgEntTxt);
        ODataUtility.GetTenantWebServiceMetadata(TenantWebService, metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, Customer.FIELDNO("No."),
          DATABASE::Customer, metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, ItemLedgerEntry.FIELDNO("Item No."),
          DATABASE::"Item Ledger Entry", metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, ItemLedgerEntry.FIELDNO(Quantity),
          DATABASE::"Item Ledger Entry", metaData);

        CreateTenantWebServiceOData(TenantWebService);
    end;

    local procedure CreatePowerBICustLedgerEntriesWebService()
    var
        CustLedgerEntry: Record 21;
        TenantWebService: Record 2000000168;
        WebServiceManagement: Codeunit 9750;
        metaData: DotNet QueryMetadataReader;
    begin
        WebServiceManagement.CreateTenantWebService(
          TenantWebService."Object Type"::Query, QUERY::"Power BI Cust. Ledger Entries", PowerBICustLedgerEntriesTxt, TRUE);

        TenantWebService.GET(TenantWebService."Object Type"::Query, PowerBICustLedgerEntriesTxt);
        ODataUtility.GetTenantWebServiceMetadata(TenantWebService, metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, CustLedgerEntry.FIELDNO("Entry No."),
          DATABASE::"Cust. Ledger Entry", metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, CustLedgerEntry.FIELDNO("Due Date"),
          DATABASE::"Cust. Ledger Entry", metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, CustLedgerEntry.FIELDNO("Remaining Amt. (LCY)"),
          DATABASE::"Cust. Ledger Entry", metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, CustLedgerEntry.FIELDNO(Open),
          DATABASE::"Cust. Ledger Entry", metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, CustLedgerEntry.FIELDNO("Customer Posting Group"),
          DATABASE::"Cust. Ledger Entry", metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, CustLedgerEntry.FIELDNO("Sales (LCY)"),
          DATABASE::"Cust. Ledger Entry", metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, CustLedgerEntry.FIELDNO("Posting Date"),
          DATABASE::"Cust. Ledger Entry", metaData);

        CreateTenantWebServiceOData(TenantWebService);
    end;

    local procedure CreatePowerBIVendorLedgerEntriesWebService()
    var
        VendorLedgerEntry: Record 25;
        TenantWebService: Record 2000000168;
        WebServiceManagement: Codeunit 9750;
        metaData: DotNet QueryMetadataReader;
    begin
        WebServiceManagement.CreateTenantWebService(
          TenantWebService."Object Type"::Query, QUERY::"Power BI Vendor Ledger Entries", PowerBIVendorLedgerEntriesTxt, TRUE);

        TenantWebService.GET(TenantWebService."Object Type"::Query, PowerBIVendorLedgerEntriesTxt);
        ODataUtility.GetTenantWebServiceMetadata(TenantWebService, metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, VendorLedgerEntry.FIELDNO("Entry No."),
          DATABASE::"Vendor Ledger Entry", metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, VendorLedgerEntry.FIELDNO("Due Date"),
          DATABASE::"Vendor Ledger Entry", metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, VendorLedgerEntry.FIELDNO("Remaining Amt. (LCY)"),
          DATABASE::"Vendor Ledger Entry", metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, VendorLedgerEntry.FIELDNO(Open),
          DATABASE::"Vendor Ledger Entry", metaData);

        CreateTenantWebServiceOData(TenantWebService);
    end;

    local procedure CreatePowerBIPurchaseHdrVendorWebService()
    var
        PurchaseHeader: Record 38;
        PurchaseLine: Record 39;
        Item: Record 27;
        Vendor: Record 23;
        TenantWebService: Record 2000000168;
        WebServiceManagement: Codeunit 9750;
        metaData: DotNet QueryMetadataReader;
    begin
        WebServiceManagement.CreateTenantWebService(
          TenantWebService."Object Type"::Query, QUERY::"Power BI Purchase Hdr. Vendor", PowerBIPurchaseHdrVendorTxt, TRUE);

        TenantWebService.GET(TenantWebService."Object Type"::Query, PowerBIPurchaseHdrVendorTxt);
        ODataUtility.GetTenantWebServiceMetadata(TenantWebService, metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, PurchaseHeader.FIELDNO("No."),
          DATABASE::"Purchase Header", metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, PurchaseLine.FIELDNO("No."),
          DATABASE::"Purchase Line", metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, PurchaseLine.FIELDNO(Quantity),
          DATABASE::"Purchase Line", metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, Item.FIELDNO("Base Unit of Measure"),
          DATABASE::Item, metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, Item.FIELDNO(Description),
          DATABASE::Item, metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, Item.FIELDNO(Inventory),
          DATABASE::Item, metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, Item.FIELDNO("Qty. on Purch. Order"),
          DATABASE::Item, metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, Item.FIELDNO("Unit Price"),
          DATABASE::Item, metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, Vendor.FIELDNO("No."),
          DATABASE::Vendor, metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, Vendor.FIELDNO(Name),
          DATABASE::Vendor, metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, Vendor.FIELDNO(Balance),
          DATABASE::Vendor, metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, Vendor.FIELDNO("Country/Region Code"),
          DATABASE::Vendor, metaData);

        CreateTenantWebServiceOData(TenantWebService);
    end;

    local procedure CreatePowerBIVendItemLedgEntWebService()
    var
        Vendor: Record 23;
        ItemLedgerEntry: Record 32;
        TenantWebService: Record 2000000168;
        WebServiceManagement: Codeunit 9750;
        metaData: DotNet QueryMetadataReader;
    begin
        WebServiceManagement.CreateTenantWebService(
          TenantWebService."Object Type"::Query, QUERY::"Power BI Vend. Item Ledg. Ent.", PowerBIVendItemLedgEntTxt, TRUE);

        TenantWebService.GET(TenantWebService."Object Type"::Query, PowerBIVendItemLedgEntTxt);
        ODataUtility.GetTenantWebServiceMetadata(TenantWebService, metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, Vendor.FIELDNO("No."),
          DATABASE::Vendor, metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, ItemLedgerEntry.FIELDNO("Item No."),
          DATABASE::"Item Ledger Entry", metaData);
        ODataUtility.CreateTenantWebServiceColumnForQuery(TenantWebService.RECORDID, ItemLedgerEntry.FIELDNO(Quantity),
          DATABASE::"Item Ledger Entry", metaData);

        CreateTenantWebServiceOData(TenantWebService);
    end;

    local procedure CreatePowerBIAgedAccPayableWebService()
    var
        PowerBIChartBuffer: Record 6305;
        TenantWebService: Record 2000000168;
        WebServiceManagement: Codeunit 9750;
    begin
        WebServiceManagement.CreateTenantWebService(
          TenantWebService."Object Type"::Page, PAGE::"PBI Aged Acc. Payable", PowerBIAgedAccPayableTxt, TRUE);

        TenantWebService.GET(TenantWebService."Object Type"::Page, PowerBIAgedAccPayableTxt);
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO(ID),
          DATABASE::"Power BI Chart Buffer");
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO(Value),
          DATABASE::"Power BI Chart Buffer");
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO("Period Type"),
          DATABASE::"Power BI Chart Buffer");
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO(Date),
          DATABASE::"Power BI Chart Buffer");
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO("Date Sorting"),
          DATABASE::"Power BI Chart Buffer");
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO("Period Type Sorting"),
          DATABASE::"Power BI Chart Buffer");

        CreateTenantWebServiceOData(TenantWebService);
    end;

    local procedure CreatePowerBIAgedAccReceivableWebService()
    var
        PowerBIChartBuffer: Record 6305;
        TenantWebService: Record 2000000168;
        WebServiceManagement: Codeunit 9750;
    begin
        WebServiceManagement.CreateTenantWebService(
          TenantWebService."Object Type"::Page, PAGE::"PBI Aged Acc. Receivable", PowerBIAgedAccReceivableTxt, TRUE);

        TenantWebService.GET(TenantWebService."Object Type"::Page, PowerBIAgedAccReceivableTxt);
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO(ID),
          DATABASE::"Power BI Chart Buffer");
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO(Value),
          DATABASE::"Power BI Chart Buffer");
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO(Date),
          DATABASE::"Power BI Chart Buffer");
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO("Date Sorting"),
          DATABASE::"Power BI Chart Buffer");
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO("Period Type"),
          DATABASE::"Power BI Chart Buffer");
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO("Period Type Sorting"),
          DATABASE::"Power BI Chart Buffer");
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO("Measure Name"),
          DATABASE::"Power BI Chart Buffer");

        CreateTenantWebServiceOData(TenantWebService);
    end;

    local procedure CreatePowerBIAgedInventoryChartWebService()
    var
        PowerBIChartBuffer: Record 6305;
        TenantWebService: Record 2000000168;
        WebServiceManagement: Codeunit 9750;
    begin
        WebServiceManagement.CreateTenantWebService(
          TenantWebService."Object Type"::Page, PAGE::"PBI Aged Inventory Chart", PowerBIAgedInventoryChartTxt, TRUE);

        TenantWebService.GET(TenantWebService."Object Type"::Page, PowerBIAgedInventoryChartTxt);
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO(ID),
          DATABASE::"Power BI Chart Buffer");
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO(Value),
          DATABASE::"Power BI Chart Buffer");
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO(Date),
          DATABASE::"Power BI Chart Buffer");
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO("Period Type"),
          DATABASE::"Power BI Chart Buffer");
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO("Period Type Sorting"),
          DATABASE::"Power BI Chart Buffer");

        CreateTenantWebServiceOData(TenantWebService);
    end;

    local procedure CreatePowerBIJobActBudgPriceWebService()
    var
        PowerBIChartBuffer: Record 6305;
        TenantWebService: Record 2000000168;
        WebServiceManagement: Codeunit 9750;
    begin
        WebServiceManagement.CreateTenantWebService(
          TenantWebService."Object Type"::Page, PAGE::"PBI Job Act. v. Budg. Price", PowerBIJobActBudgPriceTxt, TRUE);

        TenantWebService.GET(TenantWebService."Object Type"::Page, PowerBIJobActBudgPriceTxt);
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO("Measure No."),
          DATABASE::"Power BI Chart Buffer");
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO("Measure Name"),
          DATABASE::"Power BI Chart Buffer");
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO(Value),
          DATABASE::"Power BI Chart Buffer");

        CreateTenantWebServiceOData(TenantWebService);
    end;

    local procedure CreatePowerBIJobProfitabilityWebService()
    var
        PowerBIChartBuffer: Record 6305;
        TenantWebService: Record 2000000168;
        WebServiceManagement: Codeunit 9750;
    begin
        WebServiceManagement.CreateTenantWebService(
          TenantWebService."Object Type"::Page, PAGE::"PBI Job Profitability", PowerBIJobProfitabilityTxt, TRUE);

        TenantWebService.GET(TenantWebService."Object Type"::Page, PowerBIJobProfitabilityTxt);
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO("Measure No."),
          DATABASE::"Power BI Chart Buffer");
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO("Measure Name"),
          DATABASE::"Power BI Chart Buffer");
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO(Value),
          DATABASE::"Power BI Chart Buffer");

        CreateTenantWebServiceOData(TenantWebService);
    end;

    local procedure CreatePowerBIJobActBudgCostWebService()
    var
        PowerBIChartBuffer: Record 6305;
        TenantWebService: Record 2000000168;
        WebServiceManagement: Codeunit 9750;
    begin
        WebServiceManagement.CreateTenantWebService(
          TenantWebService."Object Type"::Page, PAGE::"PBI Job Act. v. Budg. Cost", PowerBIJobActBudgCostTxt, TRUE);

        TenantWebService.GET(TenantWebService."Object Type"::Page, PowerBIJobActBudgCostTxt);
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO("Measure No."),
          DATABASE::"Power BI Chart Buffer");
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO("Measure Name"),
          DATABASE::"Power BI Chart Buffer");
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO(Value),
          DATABASE::"Power BI Chart Buffer");

        CreateTenantWebServiceOData(TenantWebService);
    end;

    local procedure CreatePowerBISalesPipelineWebService()
    var
        PowerBIChartBuffer: Record 6305;
        TenantWebService: Record 2000000168;
        WebServiceManagement: Codeunit 9750;
    begin
        WebServiceManagement.CreateTenantWebService(
          TenantWebService."Object Type"::Page, PAGE::"PBI Sales Pipeline", PowerBISalesPipelineTxt, TRUE);

        TenantWebService.GET(TenantWebService."Object Type"::Page, PowerBISalesPipelineTxt);
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO(ID),
          DATABASE::"Power BI Chart Buffer");
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO("Row No."),
          DATABASE::"Power BI Chart Buffer");
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO(Value),
          DATABASE::"Power BI Chart Buffer");
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO("Measure Name"),
          DATABASE::"Power BI Chart Buffer");
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO("Measure No."),
          DATABASE::"Power BI Chart Buffer");

        CreateTenantWebServiceOData(TenantWebService);
    end;

    local procedure CreatePowerBITop5OpportunitiesWebService()
    var
        PowerBIChartBuffer: Record 6305;
        TenantWebService: Record 2000000168;
        WebServiceManagement: Codeunit 9750;
    begin
        WebServiceManagement.CreateTenantWebService(
          TenantWebService."Object Type"::Page, PAGE::"PBI Top 5 Opportunities", PowerBITop5OpportunitiesTxt, TRUE);

        TenantWebService.GET(TenantWebService."Object Type"::Page, PowerBITop5OpportunitiesTxt);
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO(ID),
          DATABASE::"Power BI Chart Buffer");
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO(Value),
          DATABASE::"Power BI Chart Buffer");
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO("Measure Name"),
          DATABASE::"Power BI Chart Buffer");
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIChartBuffer.FIELDNO("Measure No."),
          DATABASE::"Power BI Chart Buffer");

        CreateTenantWebServiceOData(TenantWebService);
    end;

    local procedure CreatePowerBIWorkDateCalcWebService()
    var
        TenantWebService: Record 2000000168;
        WebServiceManagement: Codeunit 9750;
    begin
        WebServiceManagement.CreateTenantWebService(
          TenantWebService."Object Type"::Page, PAGE::"PBI WorkDate Calc.", PowerBIWorkDateCalcTxt, TRUE);

        TenantWebService.GET(TenantWebService."Object Type"::Page, PowerBIWorkDateCalcTxt);

        CreateTenantWebServiceOData(TenantWebService);
    end;

    local procedure CreatePowerBIReportLabelsWebService()
    var
        PowerBIReportLabels: Record 6306;
        TenantWebService: Record 2000000168;
        WebServiceManagement: Codeunit 9750;
    begin
        WebServiceManagement.CreateTenantWebService(
          TenantWebService."Object Type"::Page, PAGE::"PBI Report Labels", PowerBIReportLabelsTxt, TRUE);

        TenantWebService.GET(TenantWebService."Object Type"::Page, PowerBIReportLabelsTxt);
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIReportLabels.FIELDNO("Label ID"),
          DATABASE::"Power BI Report Labels");
        ODataUtility.CreateTenantWebServiceColumnForPage(TenantWebService.RECORDID, PowerBIReportLabels.FIELDNO("Text Value"),
          DATABASE::"Power BI Report Labels");

        CreateTenantWebServiceOData(TenantWebService);
    end;

    [UpgradePerCompany]
    procedure CreateJobWebServices()
    var
        TenantWebService: Record 2000000168;
    begin
        TenantWebService.INIT;
        TenantWebService."Object Type" := TenantWebService."Object Type"::Page;
        TenantWebService."Object ID" := PAGE::"Job List";
        TenantWebService."Service Name" := COPYSTR(JobListTxt, 1, MAXSTRLEN(TenantWebService."Service Name"));
        TenantWebService.Published := TRUE;

        IF TenantWebService.INSERT THEN BEGIN
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 1, DATABASE::Job);
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 3, DATABASE::Job);
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 5, DATABASE::Job);
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 19, DATABASE::Job);
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 20, DATABASE::Job);
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 2, DATABASE::Job);
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 1036, DATABASE::Job);

            CreateTenantWebServiceOData(TenantWebService);
        END;

        CLEAR(TenantWebService);

        TenantWebService.INIT;
        TenantWebService."Object Type" := TenantWebService."Object Type"::Page;
        TenantWebService."Object ID" := PAGE::"Job Task Lines";
        TenantWebService."Service Name" := COPYSTR(JobTaskLinesTxt, 1, MAXSTRLEN(TenantWebService."Service Name"));
        TenantWebService.Published := TRUE;

        IF TenantWebService.INSERT THEN BEGIN
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 1, DATABASE::"Job Task");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 2, DATABASE::"Job Task");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 3, DATABASE::"Job Task");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 4, DATABASE::"Job Task");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 21, DATABASE::"Job Task");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 7, DATABASE::"Job Task");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 6, DATABASE::"Job Task");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 9, DATABASE::"Job Task");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 66, DATABASE::"Job Task");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 67, DATABASE::"Job Task");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 10, DATABASE::"Job Task");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 11, DATABASE::"Job Task");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 12, DATABASE::"Job Task");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 13, DATABASE::"Job Task");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 14, DATABASE::"Job Task");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 15, DATABASE::"Job Task");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 17, DATABASE::"Job Task");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 16, DATABASE::"Job Task");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 64, DATABASE::"Job Task");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 65, DATABASE::"Job Task");

            CreateTenantWebServiceOData(TenantWebService);
        END;

        CLEAR(TenantWebService);

        TenantWebService.INIT;
        TenantWebService."Object Type" := TenantWebService."Object Type"::Page;
        TenantWebService."Object ID" := PAGE::"Job Planning Lines";
        TenantWebService."Service Name" := COPYSTR(JobPlanningLinesTxt, 1, MAXSTRLEN(TenantWebService."Service Name"));
        TenantWebService.Published := TRUE;

        IF TenantWebService.INSERT THEN BEGIN
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 1000, DATABASE::"Job Planning Line");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 3, DATABASE::"Job Planning Line");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 5794, DATABASE::"Job Planning Line");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 4, DATABASE::"Job Planning Line");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 5, DATABASE::"Job Planning Line");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 7, DATABASE::"Job Planning Line");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 8, DATABASE::"Job Planning Line");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 9, DATABASE::"Job Planning Line");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 1060, DATABASE::"Job Planning Line");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 1002, DATABASE::"Job Planning Line");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 1003, DATABASE::"Job Planning Line");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 1004, DATABASE::"Job Planning Line");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 1006, DATABASE::"Job Planning Line");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 1071, DATABASE::"Job Planning Line");
            CreateTenantWebServiceColumn(TenantWebService.RECORDID, 1035, DATABASE::"Job Planning Line");

            CreateTenantWebServiceOData(TenantWebService);
        END;
    end;

    [UpgradePerCompany]
    procedure UpdateCheckFieldSetup()
    var
        IntrastatJnlLine: Record 263;
    begin
        InsertCheckFieldSetup(IntrastatJnlLine.FIELDNO("Tariff No."));
        InsertCheckFieldSetup(IntrastatJnlLine.FIELDNO("Country/Region Code"));
        InsertCheckFieldSetup(IntrastatJnlLine.FIELDNO("Transaction Type"));
        InsertCheckFieldSetup(IntrastatJnlLine.FIELDNO("Total Weight"));
        InsertCheckFieldSetup(IntrastatJnlLine.FIELDNO(Quantity));
    end;

    local procedure InsertCheckFieldSetup(FieldNumber: Integer)
    var
        IntrastatCheckFieldSetup: Record 8451;
    begin
        WITH IntrastatCheckFieldSetup DO BEGIN
            INIT;
            VALIDATE("Field No.", FieldNumber);
            IF INSERT THEN;
        END;
    end;

    [UpgradePerCompany]
    procedure UpdateItems()
    var
        Item: Record 27;
    begin
        IF Item.FINDSET(TRUE, FALSE) THEN
            REPEAT
                Item.VALIDATE("Sales Blocked", FALSE);
                Item.VALIDATE("Purchasing Blocked", FALSE);
                Item.UpdateItemCategoryId;
                IF Item.MODIFY THEN;
            UNTIL Item.NEXT = 0;
    end;

    [UpgradePerCompany]
    procedure UpgradeAPIs()
    begin
        UpgradeSalesInvoiceEntityAggregate;
        UpgradePurchInvEntityAggregate;
        UpgradeSalesOrderEntityBuffer;
        UpgradeSalesQuoteEntityBuffer;
        UpgradeSalesCrMemoEntityBuffer;
        UpgradeSalesOrderShipmentMethod;
        UpgradeSalesCrMemoShipmentMethod;
    end;

    [Normal]
    local procedure UpgradeSalesInvoiceEntityAggregate()
    var
        SalesInvoiceEntityAggregate: Record 5475;
        SalesHeader: Record 36;
        SalesInvoiceHeader: Record 112;
        UpgradeTags: Codeunit 9998;
        UpgradeTagMgt: Codeunit 9999;
        SourceRecordRef: RecordRef;
        TargetRecordRef: RecordRef;
    begin
        IF UpgradeTagMgt.HasUpgradeTag(UpgradeTags.GetNewSalesInvoiceEntityAggregateUpgradeTag) THEN
            EXIT;

        IF SalesInvoiceEntityAggregate.FINDSET(TRUE, FALSE) THEN
            REPEAT
                IF SalesInvoiceEntityAggregate.Posted THEN BEGIN
                    SalesInvoiceHeader.SETRANGE(Id, SalesInvoiceEntityAggregate.Id);
                    IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                        SourceRecordRef.GETTABLE(SalesInvoiceHeader);
                        TargetRecordRef.GETTABLE(SalesInvoiceEntityAggregate);
                        UpdateSalesDocumentFields(SourceRecordRef, TargetRecordRef, TRUE, TRUE, TRUE);
                    END;
                END ELSE BEGIN
                    SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Invoice);
                    SalesHeader.SETRANGE(Id, SalesInvoiceEntityAggregate.Id);
                    IF SalesHeader.FINDFIRST THEN BEGIN
                        SourceRecordRef.GETTABLE(SalesHeader);
                        TargetRecordRef.GETTABLE(SalesInvoiceEntityAggregate);
                        UpdateSalesDocumentFields(SourceRecordRef, TargetRecordRef, TRUE, TRUE, TRUE);
                    END;
                END;
            UNTIL SalesInvoiceEntityAggregate.NEXT = 0;

        UpgradeTagMgt.SetUpgradeTag(UpgradeTags.GetNewSalesInvoiceEntityAggregateUpgradeTag);
    end;

    [Normal]
    local procedure UpgradePurchInvEntityAggregate()
    var
        PurchInvEntityAggregate: Record 5477;
        PurchaseHeader: Record 38;
        PurchInvHeader: Record 122;
        UpgradeTags: Codeunit 9998;
        UpgradeTagMgt: Codeunit 9999;
        SourceRecordRef: RecordRef;
        TargetRecordRef: RecordRef;
    begin
        IF UpgradeTagMgt.HasUpgradeTag(UpgradeTags.GetNewPurchInvEntityAggregateUpgradeTag) THEN
            EXIT;

        IF PurchInvEntityAggregate.FINDSET(TRUE, FALSE) THEN
            REPEAT
                IF PurchInvEntityAggregate.Posted THEN BEGIN
                    PurchInvHeader.SETRANGE(Id, PurchInvEntityAggregate.Id);
                    IF PurchInvHeader.FINDFIRST THEN BEGIN
                        SourceRecordRef.GETTABLE(PurchInvHeader);
                        TargetRecordRef.GETTABLE(PurchInvEntityAggregate);
                        UpdatePurchaseDocumentFields(SourceRecordRef, TargetRecordRef, TRUE, TRUE);
                    END;
                END ELSE BEGIN
                    PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Invoice);
                    PurchaseHeader.SETRANGE(Id, PurchInvEntityAggregate.Id);
                    IF PurchaseHeader.FINDFIRST THEN BEGIN
                        SourceRecordRef.GETTABLE(PurchaseHeader);
                        TargetRecordRef.GETTABLE(PurchInvEntityAggregate);
                        UpdatePurchaseDocumentFields(SourceRecordRef, TargetRecordRef, TRUE, TRUE);
                    END;
                END;
            UNTIL PurchInvEntityAggregate.NEXT = 0;

        UpgradeTagMgt.SetUpgradeTag(UpgradeTags.GetNewPurchInvEntityAggregateUpgradeTag);
    end;

    [Normal]
    local procedure UpgradeSalesOrderEntityBuffer()
    var
        SalesOrderEntityBuffer: Record 5495;
        SalesHeader: Record 36;
        UpgradeTags: Codeunit 9998;
        UpgradeTagMgt: Codeunit 9999;
        SourceRecordRef: RecordRef;
        TargetRecordRef: RecordRef;
    begin
        IF UpgradeTagMgt.HasUpgradeTag(UpgradeTags.GetNewSalesOrderEntityBufferUpgradeTag) THEN
            EXIT;

        IF SalesOrderEntityBuffer.FINDSET(TRUE, FALSE) THEN
            REPEAT
                SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
                SalesHeader.SETRANGE(Id, SalesOrderEntityBuffer.Id);
                IF SalesHeader.FINDFIRST THEN BEGIN
                    SourceRecordRef.GETTABLE(SalesHeader);
                    TargetRecordRef.GETTABLE(SalesOrderEntityBuffer);
                    UpdateSalesDocumentFields(SourceRecordRef, TargetRecordRef, TRUE, TRUE, TRUE);
                END;
            UNTIL SalesOrderEntityBuffer.NEXT = 0;

        UpgradeTagMgt.SetUpgradeTag(UpgradeTags.GetNewSalesOrderEntityBufferUpgradeTag);
    end;

    local procedure UpgradeSalesQuoteEntityBuffer()
    var
        SalesQuoteEntityBuffer: Record 5505;
        SalesHeader: Record 36;
        UpgradeTags: Codeunit 9998;
        UpgradeTagMgt: Codeunit 9999;
        SourceRecordRef: RecordRef;
        TargetRecordRef: RecordRef;
    begin
        IF UpgradeTagMgt.HasUpgradeTag(UpgradeTags.GetNewSalesQuoteEntityBufferUpgradeTag) THEN
            EXIT;

        IF SalesQuoteEntityBuffer.FINDSET(TRUE, FALSE) THEN
            REPEAT
                SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Quote);
                SalesHeader.SETRANGE(Id, SalesQuoteEntityBuffer.Id);
                IF SalesHeader.FINDFIRST THEN BEGIN
                    SourceRecordRef.GETTABLE(SalesHeader);
                    TargetRecordRef.GETTABLE(SalesQuoteEntityBuffer);
                    UpdateSalesDocumentFields(SourceRecordRef, TargetRecordRef, TRUE, TRUE, TRUE);
                END;
            UNTIL SalesQuoteEntityBuffer.NEXT = 0;

        UpgradeTagMgt.SetUpgradeTag(UpgradeTags.GetNewSalesQuoteEntityBufferUpgradeTag);
    end;

    local procedure UpgradeSalesCrMemoEntityBuffer()
    var
        SalesCrMemoEntityBuffer: Record 5507;
        SalesHeader: Record 36;
        SalesCrMemoHeader: Record 114;
        UpgradeTags: Codeunit 9998;
        UpgradeTagMgt: Codeunit 9999;
        SourceRecordRef: RecordRef;
        TargetRecordRef: RecordRef;
    begin
        IF UpgradeTagMgt.HasUpgradeTag(UpgradeTags.GetNewSalesCrMemoEntityBufferUpgradeTag) THEN
            EXIT;

        IF SalesCrMemoEntityBuffer.FINDSET(TRUE, FALSE) THEN
            REPEAT
                IF SalesCrMemoEntityBuffer.Posted THEN BEGIN
                    SalesCrMemoHeader.SETRANGE(Id, SalesCrMemoEntityBuffer.Id);
                    IF SalesCrMemoHeader.FINDFIRST THEN BEGIN
                        SourceRecordRef.GETTABLE(SalesCrMemoHeader);
                        TargetRecordRef.GETTABLE(SalesCrMemoEntityBuffer);
                        UpdateSalesDocumentFields(SourceRecordRef, TargetRecordRef, TRUE, TRUE, FALSE);
                    END;
                END ELSE BEGIN
                    SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::"Credit Memo");
                    SalesHeader.SETRANGE(Id, SalesCrMemoEntityBuffer.Id);
                    IF SalesHeader.FINDFIRST THEN BEGIN
                        SourceRecordRef.GETTABLE(SalesHeader);
                        TargetRecordRef.GETTABLE(SalesCrMemoEntityBuffer);
                        UpdateSalesDocumentFields(SourceRecordRef, TargetRecordRef, TRUE, TRUE, FALSE);
                    END;
                END;
            UNTIL SalesCrMemoEntityBuffer.NEXT = 0;

        UpgradeTagMgt.SetUpgradeTag(UpgradeTags.GetNewSalesCrMemoEntityBufferUpgradeTag);
    end;

    local procedure UpdateSalesDocumentFields(SourceRecordRef: RecordRef; TargetRecordRef: RecordRef; SellTo: Boolean; BillTo: Boolean; ShipTo: Boolean)
    var
        SalesHeader: Record 36;
        SalesOrderEntityBuffer: Record 5495;
        Customer: Record 18;
        CodeFieldRef: FieldRef;
        IdFieldRef: FieldRef;
        EmptyGuid: Guid;
    begin
        IF SellTo THEN BEGIN
            CopyFieldValue(SourceRecordRef, TargetRecordRef, SalesHeader.FIELDNO("Sell-to Phone No."));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, SalesHeader.FIELDNO("Sell-to E-Mail"));
        END;
        IF BillTo THEN BEGIN
            CopyFieldValue(SourceRecordRef, TargetRecordRef, SalesHeader.FIELDNO("Bill-to Customer No."));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, SalesHeader.FIELDNO("Bill-to Name"));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, SalesHeader.FIELDNO("Bill-to Address"));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, SalesHeader.FIELDNO("Bill-to Address 2"));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, SalesHeader.FIELDNO("Bill-to City"));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, SalesHeader.FIELDNO("Bill-to Contact"));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, SalesHeader.FIELDNO("Bill-to Post Code"));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, SalesHeader.FIELDNO("Bill-to County"));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, SalesHeader.FIELDNO("Bill-to Country/Region Code"));
            CodeFieldRef := TargetRecordRef.FIELD(SalesOrderEntityBuffer.FIELDNO("Bill-to Customer No."));
            IdFieldRef := TargetRecordRef.FIELD(SalesOrderEntityBuffer.FIELDNO("Bill-to Customer Id"));
            IF Customer.GET(CodeFieldRef.VALUE) THEN
                IdFieldRef.VALUE := Customer.Id
            ELSE
                IdFieldRef.VALUE := EmptyGuid;
        END;
        IF ShipTo THEN BEGIN
            CopyFieldValue(SourceRecordRef, TargetRecordRef, SalesHeader.FIELDNO("Ship-to Code"));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, SalesHeader.FIELDNO("Ship-to Name"));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, SalesHeader.FIELDNO("Ship-to Address"));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, SalesHeader.FIELDNO("Ship-to Address 2"));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, SalesHeader.FIELDNO("Ship-to City"));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, SalesHeader.FIELDNO("Ship-to Contact"));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, SalesHeader.FIELDNO("Ship-to Post Code"));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, SalesHeader.FIELDNO("Ship-to County"));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, SalesHeader.FIELDNO("Ship-to Country/Region Code"));
        END;
        TargetRecordRef.MODIFY;
    end;

    local procedure UpdatePurchaseDocumentFields(var SourceRecordRef: RecordRef; var TargetRecordRef: RecordRef; PayTo: Boolean; ShipTo: Boolean)
    var
        PurchaseHeader: Record 38;
        PurchInvEntityAggregate: Record 5477;
        Vendor: Record 23;
        Currency: Record 4;
        CodeFieldRef: FieldRef;
        IdFieldRef: FieldRef;
        EmptyGuid: Guid;
    begin
        IF PayTo THEN BEGIN
            CopyFieldValue(SourceRecordRef, TargetRecordRef, PurchaseHeader.FIELDNO("Pay-to Vendor No."));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, PurchaseHeader.FIELDNO("Pay-to Name"));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, PurchaseHeader.FIELDNO("Pay-to Address"));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, PurchaseHeader.FIELDNO("Pay-to Address 2"));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, PurchaseHeader.FIELDNO("Pay-to City"));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, PurchaseHeader.FIELDNO("Pay-to Contact"));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, PurchaseHeader.FIELDNO("Pay-to Post Code"));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, PurchaseHeader.FIELDNO("Pay-to County"));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, PurchaseHeader.FIELDNO("Pay-to Country/Region Code"));
            CodeFieldRef := TargetRecordRef.FIELD(PurchInvEntityAggregate.FIELDNO("Pay-to Vendor No."));
            IdFieldRef := TargetRecordRef.FIELD(PurchInvEntityAggregate.FIELDNO("Pay-to Vendor Id"));
            IF Vendor.GET(CodeFieldRef.VALUE) THEN
                IdFieldRef.VALUE := Vendor.Id
            ELSE
                IdFieldRef.VALUE := EmptyGuid;
            CodeFieldRef := TargetRecordRef.FIELD(PurchInvEntityAggregate.FIELDNO("Currency Code"));
            IdFieldRef := TargetRecordRef.FIELD(PurchInvEntityAggregate.FIELDNO("Currency Id"));
            IF Vendor.GET(CodeFieldRef.VALUE) THEN
                IdFieldRef.VALUE := Currency.Id
            ELSE
                IdFieldRef.VALUE := EmptyGuid;
        END;
        IF ShipTo THEN BEGIN
            CopyFieldValue(SourceRecordRef, TargetRecordRef, PurchaseHeader.FIELDNO("Ship-to Code"));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, PurchaseHeader.FIELDNO("Ship-to Name"));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, PurchaseHeader.FIELDNO("Ship-to Address"));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, PurchaseHeader.FIELDNO("Ship-to Address 2"));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, PurchaseHeader.FIELDNO("Ship-to City"));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, PurchaseHeader.FIELDNO("Ship-to Contact"));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, PurchaseHeader.FIELDNO("Ship-to Post Code"));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, PurchaseHeader.FIELDNO("Ship-to County"));
            CopyFieldValue(SourceRecordRef, TargetRecordRef, PurchaseHeader.FIELDNO("Ship-to Country/Region Code"));
        END;
        TargetRecordRef.MODIFY;
    end;

    local procedure CopyFieldValue(var SourceRecordRef: RecordRef; var TargetRecordRef: RecordRef; FieldNo: Integer)
    var
        SourceFieldRef: FieldRef;
        TargetFieldRef: FieldRef;
    begin
        SourceFieldRef := SourceRecordRef.FIELD(FieldNo);
        TargetFieldRef := TargetRecordRef.FIELD(FieldNo);
        IF TargetFieldRef.VALUE <> SourceFieldRef.VALUE THEN
            TargetFieldRef.VALUE := SourceFieldRef.VALUE;
    end;

    [UpgradePerCompany]
    procedure UpgradeWorkDescripiton()
    var
        SalesHeader: Record 36;
        SalesShipmentHeader: Record 110;
        SalesInvoiceHeader: Record 112;
        SalesCrMemoHeader: Record 114;
    begin
        IF SalesHeader.FINDSET THEN
            REPEAT
                IF SalesHeader."Work Description".HASVALUE THEN BEGIN
                    SalesHeader.CALCFIELDS("Work Description");
                    IF NOT TryReadWorkDescriptionWithUTF8Encoding(SalesHeader, SalesHeader.FIELDNO("Work Description")) THEN
                        ChangeEncodingToUTF8(SalesHeader, SalesHeader.FIELDNO("Work Description"));
                END;
            UNTIL SalesHeader.NEXT = 0;

        IF SalesShipmentHeader.FINDSET THEN
            REPEAT
                IF SalesShipmentHeader."Work Description".HASVALUE THEN BEGIN
                    SalesShipmentHeader.CALCFIELDS("Work Description");
                    IF NOT TryReadWorkDescriptionWithUTF8Encoding(SalesShipmentHeader, SalesShipmentHeader.FIELDNO("Work Description")) THEN
                        ChangeEncodingToUTF8(SalesShipmentHeader, SalesShipmentHeader.FIELDNO("Work Description"));
                END;
            UNTIL SalesShipmentHeader.NEXT = 0;

        IF SalesInvoiceHeader.FINDSET THEN
            REPEAT
                IF SalesInvoiceHeader."Work Description".HASVALUE THEN BEGIN
                    SalesInvoiceHeader.CALCFIELDS("Work Description");
                    IF NOT TryReadWorkDescriptionWithUTF8Encoding(SalesInvoiceHeader, SalesInvoiceHeader.FIELDNO("Work Description")) THEN
                        ChangeEncodingToUTF8(SalesInvoiceHeader, SalesInvoiceHeader.FIELDNO("Work Description"));
                END;
            UNTIL SalesInvoiceHeader.NEXT = 0;

        IF SalesCrMemoHeader.FINDSET THEN
            REPEAT
                IF SalesCrMemoHeader."Work Description".HASVALUE THEN BEGIN
                    SalesCrMemoHeader.CALCFIELDS("Work Description");
                    IF NOT TryReadWorkDescriptionWithUTF8Encoding(SalesCrMemoHeader, SalesCrMemoHeader.FIELDNO("Work Description")) THEN
                        ChangeEncodingToUTF8(SalesCrMemoHeader, SalesCrMemoHeader.FIELDNO("Work Description"));
                END;
            UNTIL SalesCrMemoHeader.NEXT = 0;
    end;

    [TryFunction]
    local procedure TryReadWorkDescriptionWithUTF8Encoding(NavRecord: Variant; FieldNo: Integer)
    var
        TempBlob Record: 99008535" temporary;
        RecordRef: RecordRef;
        FieldRef: FieldRef;
        InStream: InStream;
        TempText: Text;
    begin
        RecordRef.GETTABLE(NavRecord);
        FieldRef := RecordRef.FIELD(FieldNo);
        TempBlob.Blob := FieldRef.VALUE;
        TempBlob.Blob.CREATEINSTREAM(InStream, TEXTENCODING::UTF8);
        InStream.READ(TempText);
        CLEAR(TempBlob.Blob);
    end;

    local procedure ChangeEncodingToUTF8(NavRecord: Variant; FieldNo: Integer)
    var
        TempBlob Record: 99008535" temporary;
        RecordRef: RecordRef;
        FieldRef: FieldRef;
        InStream: InStream;
        OutStream: OutStream;
        TempText: Text;
    begin
        RecordRef.GETTABLE(NavRecord);
        FieldRef := RecordRef.FIELD(FieldNo);
        TempBlob.Blob := FieldRef.VALUE;
        TempBlob.Blob.CREATEINSTREAM(InStream, TEXTENCODING::Windows);
        InStream.READ(TempText);
        CLEAR(TempBlob.Blob);
        TempBlob.Blob.CREATEOUTSTREAM(OutStream, TEXTENCODING::UTF8);
        OutStream.WRITE(TempText);
        FieldRef.VALUE := TempBlob.Blob;
        RecordRef.MODIFY;
    end;

    [UpgradePerCompany]
    procedure UpdateJobs()
    var
        Job: Record 167;
        UpgradeTagMgt: Codeunit 9999;
        UpgradeTags: Codeunit 9998;
        IntegrationManagement: Codeunit 5150;
        RecordRef: RecordRef;
    begin
        IF UpgradeTagMgt.HasUpgradeTag(UpgradeTags.GetAddingIDToJobsUpgradeTag) THEN
            EXIT;
        IF Job.FINDSET(TRUE, FALSE) THEN
            REPEAT
                IF ISNULLGUID(Job.Id) THEN BEGIN
                    RecordRef.GETTABLE(Job);
                    IntegrationManagement.InsertUpdateIntegrationRecord(RecordRef, CURRENTDATETIME);
                    RecordRef.SETTABLE(Job);
                    Job.MODIFY;
                    Job.UpdateReferencedIds;
                END;
            UNTIL Job.NEXT = 0;
        UpgradeTagMgt.SetUpgradeTag(UpgradeTags.GetAddingIDToJobsUpgradeTag);
    end;

    [UpgradePerCompany]
    procedure UpgradeVATReportSetup()
    var
        VATReportSetup: Record 743;
        UpgradeTagMgt: Codeunit 9999;
        UpgradeTags: Codeunit 9998;
        DateFormulaText: Text;
    begin
        IF UpgradeTagMgt.HasUpgradeTag(UpgradeTags.GetVATRepSetupPeriodRemCalcUpgradeTag) THEN
            EXIT;

        WITH VATReportSetup DO BEGIN
            IF NOT GET THEN
                EXIT;
            IF IsPeriodReminderCalculation OR ("Period Reminder Time" = 0) THEN
                EXIT;

            DateFormulaText := STRSUBSTNO('<%1D>', "Period Reminder Time");
            EVALUATE("Period Reminder Calculation", DateFormulaText);
            "Period Reminder Time" := 0;

            IF MODIFY THEN;
        END;

        UpgradeTagMgt.SetUpgradeTag(UpgradeTags.GetVATRepSetupPeriodRemCalcUpgradeTag);
    end;

    local procedure UpgradeSalesOrderShipmentMethod()
    var
        SalesOrderEntityBuffer: Record 5495;
        SalesHeader: Record 36;
        UpgradeTags: Codeunit 9998;
        UpgradeTagMgt: Codeunit 9999;
        SourceRecordRef: RecordRef;
        TargetRecordRef: RecordRef;
    begin
        IF UpgradeTagMgt.HasUpgradeTag(UpgradeTags.GetSalesOrderShipmentMethodUpgradeTag) THEN
            EXIT;

        IF SalesOrderEntityBuffer.FINDSET(TRUE, FALSE) THEN
            REPEAT
                SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
                SalesHeader.SETRANGE(Id, SalesOrderEntityBuffer.Id);
                IF SalesHeader.FINDFIRST THEN BEGIN
                    SourceRecordRef.GETTABLE(SalesHeader);
                    TargetRecordRef.GETTABLE(SalesOrderEntityBuffer);
                    CopySalesDocumentShipmentMethodFields(SourceRecordRef, TargetRecordRef);
                    TargetRecordRef.MODIFY;
                END;
            UNTIL SalesOrderEntityBuffer.NEXT = 0;

        UpgradeTagMgt.SetUpgradeTag(UpgradeTags.GetSalesOrderShipmentMethodUpgradeTag);
    end;

    local procedure UpgradeSalesCrMemoShipmentMethod()
    var
        SalesCrMemoEntityBuffer: Record 5507;
        SalesHeader: Record 36;
        SalesCrMemoHeader: Record 114;
        UpgradeTags: Codeunit 9998;
        UpgradeTagMgt: Codeunit 9999;
        SourceRecordRef: RecordRef;
        TargetRecordRef: RecordRef;
    begin
        IF UpgradeTagMgt.HasUpgradeTag(UpgradeTags.GetSalesCrMemoShipmentMethodUpgradeTag) THEN
            EXIT;

        IF SalesCrMemoEntityBuffer.FINDSET(TRUE, FALSE) THEN
            REPEAT
                IF SalesCrMemoEntityBuffer.Posted THEN BEGIN
                    SalesCrMemoHeader.SETRANGE(Id, SalesCrMemoEntityBuffer.Id);
                    IF SalesCrMemoHeader.FINDFIRST THEN BEGIN
                        SourceRecordRef.GETTABLE(SalesCrMemoHeader);
                        TargetRecordRef.GETTABLE(SalesCrMemoEntityBuffer);
                        CopySalesDocumentShipmentMethodFields(SourceRecordRef, TargetRecordRef);
                        TargetRecordRef.MODIFY;
                    END;
                END ELSE BEGIN
                    SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::"Credit Memo");
                    SalesHeader.SETRANGE(Id, SalesCrMemoEntityBuffer.Id);
                    IF SalesHeader.FINDFIRST THEN BEGIN
                        SourceRecordRef.GETTABLE(SalesHeader);
                        TargetRecordRef.GETTABLE(SalesCrMemoEntityBuffer);
                        CopySalesDocumentShipmentMethodFields(SourceRecordRef, TargetRecordRef);
                        TargetRecordRef.MODIFY;
                    END;
                END;
            UNTIL SalesCrMemoEntityBuffer.NEXT = 0;

        UpgradeTagMgt.SetUpgradeTag(UpgradeTags.GetSalesCrMemoShipmentMethodUpgradeTag);
    end;

    local procedure CopySalesDocumentShipmentMethodFields(var SourceRecordRef: RecordRef; var TargetRecordRef: RecordRef)
    var
        SalesHeader: Record 36;
        SalesOrderEntityBuffer: Record 5495;
        ShipmentMethod: Record 10;
        CodeFieldRef: FieldRef;
        IdFieldRef: FieldRef;
        EmptyGuid: Guid;
    begin
        CopyFieldValue(SourceRecordRef, TargetRecordRef, SalesHeader.FIELDNO("Shipment Method Code"));
        CodeFieldRef := TargetRecordRef.FIELD(SalesOrderEntityBuffer.FIELDNO("Shipment Method Code"));
        IdFieldRef := TargetRecordRef.FIELD(SalesOrderEntityBuffer.FIELDNO("Shipment Method Id"));
        IF ShipmentMethod.GET(CodeFieldRef.VALUE) THEN
            IdFieldRef.VALUE := ShipmentMethod.Id
        ELSE
            IdFieldRef.VALUE := EmptyGuid;
    end;
}

