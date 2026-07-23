report 56004 "Post Inventory Cost to G/L-TN"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/Post Inventory Cost to GL-TN.rdlc';
    AdditionalSearchTerms = 'reconcile inventory';
    ApplicationArea = Basic, Suite;
    Caption = 'Post Inventory Cost to G/L';
    Permissions = TableData 32 = r,
                  TableData 48 = r,
                  TableData 5406 = r,
                  TableData 5802 = rm,
                  TableData 5811 = rd,
                  TableData 5832 = rm;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(PageLoop; 2000000026)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = CONST(1));
            column(PostedCaption; STRSUBSTNO(Text002, SELECTSTR(PostMethod + 1, Text012)))
            {
            }
            column(CompanyName; COMPANYPROPERTY.DISPLAYNAME)
            {
            }
            column(Post; Post)
            {
            }
            column(DocNo; DocNo)
            {
            }
            column(PostMethodInt; PostMethodInt)
            {
            }
            column(ItemValueEntryTableCaption; ItemValueEntry.TABLECAPTION + ': ' + ValueEntryFilter)
            {
            }
            column(ValueEntryFilter; ValueEntryFilter)
            {
            }
            column(PageNoCaption; PageNoCaptionLbl)
            {
            }
            column(PostInvCosttoGLCaption; PostInvCosttoGLCaptionLbl)
            {
            }
            column(TestReportnotpostedCaption; TestReportnotpostedCaptionLbl)
            {
            }
            column(DocNoCaption; DocNoCaptionLbl)
            {
            }
            dataitem(PerEntryLoop; 2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                PrintOnlyIfDetail = true;
                column(PerEntryLoopNumber; Number)
                {
                }
                column(TotalCOGSAmt; TotalCOGSAmt)
                {
                    AutoFormatType = 1;
                }
                column(TotalInvtAdjmtAmt; TotalInvtAdjmtAmt)
                {
                    AutoFormatType = 1;
                }
                column(TotalDirCostAmt; TotalDirCostAmt)
                {
                    AutoFormatType = 1;
                }
                column(TotalOvhdCostAmt; TotalOvhdCostAmt)
                {
                    AutoFormatType = 1;
                }
                column(TotalVarPurchCostAmt; TotalVarPurchCostAmt)
                {
                    AutoFormatType = 1;
                }
                column(TotalVarMfgDirCostAmt; TotalVarMfgDirCostAmt)
                {
                    AutoFormatType = 1;
                }
                column(TotalVarMfgOvhdCostAmt; TotalVarMfgOvhdCostAmt)
                {
                    AutoFormatType = 1;
                }
                column(TotalWIPInvtAmt; TotalWIPInvtAmt)
                {
                    AutoFormatType = 1;
                }
                column(TotalInvtAmt; TotalInvtAmt)
                {
                    AutoFormatType = 1;
                }
                column(EntryNoCaption; EntryNoCaptionLbl)
                {
                }
                column(ItemLedgerEntryTypeCaption; ItemLedgerEntryTypeCaptionLbl)
                {
                }
                column(SourceNoCaption; SourceNoCaptionLbl)
                {
                }
                column(InvPostingGroupCaption; InvPostingGroupCaptionLbl)
                {
                }
                column(PostingDateCaption; PostingDateCaptionLbl)
                {
                }
                column(COGSCaption; COGSCaptionLbl)
                {
                }
                column(InventoryAdjustmentCaption; InventoryAdjustmentCaptionLbl)
                {
                }
                column(DirectCostAppliedCaption; DirectCostAppliedCaptionLbl)
                {
                }
                column(OverheadAppliedCaption; OverheadAppliedCaptionLbl)
                {
                }
                column(PurchaseVarianceCaption; PurchaseVarianceCaptionLbl)
                {
                }
                column(VarMfgDirectCostAppliedCaption; VarMfgDirectCostAppliedCaptionLbl)
                {
                }
                column(MfgOvhdVarianceCaption; MfgOvhdVarianceCaptionLbl)
                {
                }
                column(WIPInventoryCaption; WIPInventoryCaptionLbl)
                {
                }
                column(InventoryCaption; InventoryCaptionLbl)
                {
                }
                column(ExpectedCostCaption; ExpectedCostCaptionLbl)
                {
                }
                column(InventoryCostPostedtoGLCaption; InventoryCostPostedtoGLCaptionLbl)
                {
                }
                dataitem(PostValueEntryToGL; 5811)
                {
                    DataItemTableView = SORTING("Item No.", "Posting Date");
                    RequestFilterFields = "Item No.", "Posting Date";
                    column(ItemDescription; Item.Description)
                    {
                    }
                    column(ItemNo_PostValueEntryToGL; "Item No.")
                    {
                    }
                    column(ItemValueEntryPostingDate; FORMAT(ItemValueEntry."Posting Date"))
                    {
                    }
                    column(ItemValueEntryInvPostingGroup; ItemValueEntry."Inventory Posting Group")
                    {
                    }
                    column(ItemValueEntryDocumentNo; ItemValueEntry."Document No.")
                    {
                    }
                    column(ItemValueEntryItemLedgerEntryType; FORMAT(ItemValueEntry."Item Ledger Entry Type"))
                    {
                    }
                    column(ItemValueEntryEntryNo; ItemValueEntry."Entry No.")
                    {
                    }
                    column(ItemValueEntrySourceNo; ItemValueEntry."Source No.")
                    {
                    }
                    column(ItemValueEntryExpectedCost; FORMAT(ItemValueEntry."Expected Cost"))
                    {
                    }
                    column(InvtAmt; InvtAmt)
                    {
                        AutoFormatType = 1;
                    }
                    column(WIPInvtAmt; WIPInvtAmt)
                    {
                        AutoFormatType = 1;
                    }
                    column(VarMfgOvhdAmt; VarMfgOvhdAmt)
                    {
                        AutoFormatType = 1;
                    }
                    column(VarMfgDirCostAmt; VarMfgDirCostAmt)
                    {
                        AutoFormatType = 1;
                    }
                    column(VarPurchCostAmt; VarPurchCostAmt)
                    {
                        AutoFormatType = 1;
                    }
                    column(OvhdCostAmt; OvhdCostAmt)
                    {
                        AutoFormatType = 1;
                    }
                    column(DirCostAmt; DirCostAmt)
                    {
                        AutoFormatType = 1;
                    }
                    column(InvtAdjmtAmt; InvtAdjmtAmt)
                    {
                        AutoFormatType = 1;
                    }
                    column(COGSAmt; COGSAmt)
                    {
                        AutoFormatType = 1;
                    }
                    column(ItemCaption; ItemCaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        ItemValueEntry.GET("Value Entry No.");
                        WITH ItemValueEntry DO BEGIN
                            IF "Item Ledger Entry No." = 0 THEN BEGIN
                                TempCapValueEntry."Entry No." := "Entry No.";
                                TempCapValueEntry."Order Type" := "Order Type";
                                TempCapValueEntry."Order No." := "Order No.";
                                TempCapValueEntry.INSERT;
                            END;

                            IF ("Item Ledger Entry No." = 0) OR NOT Inventoriable OR
                               (("Cost Amount (Actual)" = 0) AND ("Cost Amount (Expected)" = 0) AND
                                ("Cost Amount (Actual) (ACY)" = 0) AND ("Cost Amount (Expected) (ACY)" = 0))
                            THEN
                                CurrReport.SKIP;
                        END;

                        IF NOT InvtPost.BufferInvtPosting(ItemValueEntry) THEN BEGIN
                            InsertValueEntryNoBuf(ItemValueEntry);
                            CurrReport.SKIP;
                        END;

                        UpdateAmounts;
                        MARK(TRUE);
                        IF Post AND (PostMethod = PostMethod::"per Entry") THEN
                            PostEntryToGL(ItemValueEntry);

                        Window.UPDATE(1, "Item No.");
                        IF NOT Item.GET("Item No.") THEN
                            Item.Description := Text005;
                    end;

                    trigger OnPostDataItem()
                    begin
                        IF Post THEN BEGIN
                            MARKEDONLY(TRUE);
                            DELETEALL;
                        END;
                        Window.CLOSE;
                    end;

                    trigger OnPreDataItem()
                    var
                        GLEntry: Record 17;
                    begin
                        Window.OPEN(Text003);
                        IF Post THEN BEGIN
                            GLEntry.LOCKTABLE;
                            IF GLEntry.FINDLAST THEN;
                        END;
                    end;
                }
                dataitem(CapValueEntryLoop; 2000000026)
                {
                    DataItemTableView = SORTING(Number);
                    column(OrderNo_CapValueEntryProd; CapValueEntry."Order No.")
                    {
                        IncludeCaption = true;
                    }
                    column(ExpectedCost_CapValueEntry; FORMAT(CapValueEntry."Expected Cost"))
                    {
                    }
                    column(InvtAmt2; InvtAmt)
                    {
                        AutoFormatType = 1;
                    }
                    column(WIPInvtAmt2; WIPInvtAmt)
                    {
                        AutoFormatType = 1;
                    }
                    column(VarMfgOvhdAmt2; VarMfgOvhdAmt)
                    {
                        AutoFormatType = 1;
                    }
                    column(VarMfgDirCostAmt2; VarMfgDirCostAmt)
                    {
                        AutoFormatType = 1;
                    }
                    column(VarPurchCostAmt2; VarPurchCostAmt)
                    {
                        AutoFormatType = 1;
                    }
                    column(OvhdCostAmt2; OvhdCostAmt)
                    {
                        AutoFormatType = 1;
                    }
                    column(DirCostAmt2; DirCostAmt)
                    {
                        AutoFormatType = 1;
                    }
                    column(InvtAdjmtAmt2; InvtAdjmtAmt)
                    {
                        AutoFormatType = 1;
                    }
                    column(COGSAmt2; COGSAmt)
                    {
                        AutoFormatType = 1;
                    }
                    column(PostingDate_CapValueEntry; FORMAT(CapValueEntry."Posting Date"))
                    {
                    }
                    column(InvPostingGroup_CapValueEntry; CapValueEntry."Inventory Posting Group")
                    {
                    }
                    column(SourceNo_CapValueEntry; CapValueEntry."Source No.")
                    {
                    }
                    column(DocumentNo_CapValueEntry; CapValueEntry."Document No.")
                    {
                    }
                    column(ItemLedgEntryType_CapValueEntry; CapValueEntry."Item Ledger Entry Type")
                    {
                    }
                    column(EntryNo_CapValueEntry; CapValueEntry."Entry No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        CapValueEntry.GET(TempCapValueEntry."Entry No.");
                        IF TempCapValueEntry.NEXT = 0 THEN;
                        IF NOT InvtPost.BufferInvtPosting(CapValueEntry) THEN BEGIN
                            InsertValueEntryNoBuf(CapValueEntry);
                            CurrReport.SKIP;
                        END;

                        UpdateAmounts;
                        PostValueEntryToGL.GET(CapValueEntry."Entry No.");
                        PostValueEntryToGL.MARK(TRUE);
                        IF Post AND (PostMethod = PostMethod::"per Entry") THEN
                            PostEntryToGL(CapValueEntry);
                    end;

                    trigger OnPostDataItem()
                    begin
                        TempCapValueEntry.DELETEALL;
                        IF Post THEN BEGIN
                            PostValueEntryToGL.MARKEDONLY(TRUE);
                            PostValueEntryToGL.DELETEALL;
                        END;
                    end;

                    trigger OnPreDataItem()
                    begin
                        SETRANGE(Number, 1, TempCapValueEntry.COUNT);

                        TempCapValueEntry.SETCURRENTKEY("Order Type", "Order No.", "Order Line No.");
                        IF TempCapValueEntry.FINDSET THEN;
                    end;
                }

                trigger OnPreDataItem()
                begin
                    CASE PostMethod OF
                        PostMethod::"per Posting Group":
                            IF DocNo = '' THEN
                                ERROR(
                                  Text000, ItemValueEntry.FIELDCAPTION("Document No."), SELECTSTR(PostMethod + 1, Text012));
                        PostMethod::"per Entry":
                            IF DocNo <> '' THEN
                                ERROR(
                                  Text001, ItemValueEntry.FIELDCAPTION("Document No."), SELECTSTR(PostMethod + 1, Text012));
                    END;
                    GLSetup.GET;
                end;
            }
            dataitem(InvtPostingBufferLoop; 2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = FILTER(1 ..));
                column(InvtPostBufAccTypeFormatted; FORMAT(InvtPostBuf."Account Type"))
                {
                }
                column(DimText; DimText)
                {
                }
                column(GenPostingSetupTxt; GenPostingSetupTxt)
                {
                }
                column(InvtPostBufAmount; InvtPostBuf.Amount)
                {
                }
                column(InvtPostBufPostingDate; FORMAT(InvtPostBuf."Posting Date"))
                {
                }
                column(EntryTypeCaption; EntryTypeCaptionLbl)
                {
                }
                column(DimTextCaption; DimTextCaptionLbl)
                {
                }
                column(GenPostingSetupTxtCaption; GenPostingSetupTxtCaptionLbl)
                {
                }
                column(TotalCaption; TotalCaptionLbl)
                {
                }
                column(InvtPostBufAmountCaption; InvtPostBufAmountCaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                var
                    DimSetEntry: Record 480;
                begin
                    IF Number = 1 THEN BEGIN
                        IF NOT InvtPostBuf.FINDSET THEN
                            CurrReport.BREAK;
                    END ELSE
                        IF InvtPostBuf.NEXT = 0 THEN
                            CurrReport.BREAK;

                    DimSetEntry.SETRANGE("Dimension Set ID", InvtPostBuf."Dimension Set ID");
                    GetDimText(DimSetEntry);

                    IF InvtPostBuf.UseInvtPostSetup THEN
                        GenPostingSetupTxt :=
                          STRSUBSTNO('%1,%2', InvtPostBuf."Location Code", InvtPostBuf."Inventory Posting Group")
                    ELSE
                        GenPostingSetupTxt :=
                          STRSUBSTNO('%1,%2', InvtPostBuf."Gen. Bus. Posting Group", InvtPostBuf."Gen. Prod. Posting Group");
                end;

                trigger OnPostDataItem()
                var
                    ValueEntry: Record 5802;
                begin
                    IF Post AND (PostMethod = PostMethod::"per Posting Group") THEN BEGIN
                        ValueEntry."Document No." := DocNo;
                        PostEntryToGL(ValueEntry);
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    IF PostMethod = PostMethod::"per Posting Group" THEN
                        InvtPost.GetInvtPostBuf(InvtPostBuf);
                    InvtPostBuf.RESET;
                end;
            }
            dataitem(SkippedValueEntry; 5802)
            {
                DataItemTableView = SORTING("Item No.");
                column(ItemNo_SkippedValueEntry; "Item No.")
                {
                }
                column(CostAmt; CostAmt)
                {
                }
                column(ExpectedCost_SkippedValueEntry; FORMAT("Expected Cost"))
                {
                }
                column(GenProdPostingGroup_SkippedValueEntry; "Gen. Prod. Posting Group")
                {
                    IncludeCaption = true;
                }
                column(GenBusPostingGroup_SkippedValueEntry; "Gen. Bus. Posting Group")
                {
                    IncludeCaption = true;
                }
                column(LocationCode_SkippedValueEntry; "Location Code")
                {
                    IncludeCaption = true;
                }
                column(InventoryPostingGroup_SkippedValueEntry; "Inventory Posting Group")
                {
                    IncludeCaption = true;
                }
                column(PostingDate_SkippedValueEntry; FORMAT("Posting Date"))
                {
                }
                column(SourceNo_SkippedValueEntry; "Source No.")
                {
                    IncludeCaption = true;
                }
                column(DocumentNo_SkippedValueEntry; "Document No.")
                {
                    IncludeCaption = true;
                }
                column(EntryType_SkippedValueEntry; "Entry Type")
                {
                    IncludeCaption = true;
                }
                column(ItemLedgEntryType_SkippedValueEntry; "Item Ledger Entry Type")
                {
                    IncludeCaption = true;
                }
                column(EntryNo_SkippedValueEntry; "Entry No.")
                {
                    IncludeCaption = true;
                }
                column(CostAmtCaption; CostAmtCaptionLbl)
                {
                }
                column(ExpectedCost_SkippedValueEntryCaption; ExpectedCost_SkippedValueEntryCaptionLbl)
                {
                }
                column(SkippedItemsCaption; SkippedItemsCaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF TempValueEntry.NEXT = 0 THEN
                        CLEAR(TempValueEntry);

                    SETRANGE("Item No.", TempValueEntry."Item No.");
                    SETRANGE("Entry No.", TempValueEntry."Entry No.");

                    IF Item.GET("Item No.") THEN;
                    IF "Expected Cost" THEN
                        CostAmt := "Cost Amount (Expected)"
                    ELSE
                        CostAmt := "Cost Amount (Actual)";
                end;

                trigger OnPreDataItem()
                begin
                    TempValueEntry.SETCURRENTKEY("Item No.");
                    IF NOT TempValueEntry.FINDSET THEN
                        CurrReport.BREAK;

                    SETRANGE("Item No.", TempValueEntry."Item No.");
                    SETRANGE("Entry No.", TempValueEntry."Entry No.");
                end;
            }

            trigger OnPreDataItem()
            begin
                PostMethodInt := PostMethod;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PostMethod; PostMethod)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posting Method';
                        OptionCaption = 'Per Posting Group,Per Entry';
                        ToolTip = 'Specifies if the batch job tests the posting of inventory value to the general ledger per inventory posting group or per posted value entry. If you post per entry, you achieve a detailed specification of how the inventory affects the general ledger.';
                    }
                    field(DocumentNo; DocNo)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Document No.';
                        ToolTip = 'Specifies the number of the document that is processed by the report or batch job.';
                    }
                    field(Post; Post)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Post';
                        ToolTip = 'Specifies that the inventory value will be posted to the general ledger when you run the batch job.';
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

    trigger OnInitReport()
    begin
        TotalValueEntriesPostedToGL := 0;
    end;

    trigger OnPostReport()
    var
        UpdateAnalysisView: Codeunit 410;
    begin
        IF Post THEN
            UpdateAnalysisView.UpdateAll(0, TRUE);
        DisplayStatistics(Post);
    end;

    trigger OnPreReport()
    begin
        OnBeforePreReport;

        ValueEntryFilter := PostValueEntryToGL.GETFILTERS;
        InvtSetup.GET;


        //AMS
        PostMethod := 1;
        Post := TRUE;
        //AMS
    end;

    var
        Text000: Label 'Please enter a %1 when posting %2.';
        Text001: Label 'Do not enter a %1 when posting %2.';
        Text002: Label 'Posted %1';
        Text003: Label 'Processing items             #1##########';
        Text005: Label 'The item no. no longer exists.';
        Text99000000: Label 'Processing production order  #1##########';
        Item: Record 27;
        GLSetup: Record 98;
        InvtSetup: Record 313;
        InvtPostBuf: Record 48 temporary;
        TempCapValueEntry: Record 5802 temporary;
        TempValueEntry: Record 5802 temporary;
        ItemValueEntry: Record 5802;
        CapValueEntry: Record 5802;
        InvtPost: Codeunit 5802;
        Window: Dialog;
        DocNo: Code[20];
        GenPostingSetupTxt: Text[250];
        ValueEntryFilter: Text;
        DimText: Text[120];
        PostMethod: Option "per Posting Group","per Entry";
        COGSAmt: Decimal;
        InvtAdjmtAmt: Decimal;
        DirCostAmt: Decimal;
        OvhdCostAmt: Decimal;
        VarPurchCostAmt: Decimal;
        VarMfgDirCostAmt: Decimal;
        VarMfgOvhdAmt: Decimal;
        WIPInvtAmt: Decimal;
        InvtAmt: Decimal;
        TotalCOGSAmt: Decimal;
        TotalInvtAdjmtAmt: Decimal;
        TotalDirCostAmt: Decimal;
        TotalOvhdCostAmt: Decimal;
        TotalVarPurchCostAmt: Decimal;
        TotalVarMfgDirCostAmt: Decimal;
        TotalVarMfgOvhdCostAmt: Decimal;
        TotalWIPInvtAmt: Decimal;
        TotalInvtAmt: Decimal;
        CostAmt: Decimal;
        Post: Boolean;
        Text012: Label 'per Posting Group,per Entry';
        PostMethodInt: Integer;
        PageNoCaptionLbl: Label 'Page';
        PostInvCosttoGLCaptionLbl: Label 'Post Inventory Cost to G/L';
        TestReportnotpostedCaptionLbl: Label 'Test Report (Not Posted)';
        DocNoCaptionLbl: Label 'Document No.';
        EntryNoCaptionLbl: Label 'Entry No.';
        ItemLedgerEntryTypeCaptionLbl: Label 'Item Ledger Entry Type';
        SourceNoCaptionLbl: Label 'Source No.';
        InvPostingGroupCaptionLbl: Label 'Inventory Posting Group';
        PostingDateCaptionLbl: Label 'Posting Date';
        COGSCaptionLbl: Label 'COGS', Comment = 'Cost of goods sold';
        InventoryAdjustmentCaptionLbl: Label 'Inventory Adjustment';
        DirectCostAppliedCaptionLbl: Label 'Direct Cost Applied';
        OverheadAppliedCaptionLbl: Label 'Overhead Applied';
        PurchaseVarianceCaptionLbl: Label 'Purchase Variance';
        VarMfgDirectCostAppliedCaptionLbl: Label 'Mfg. Direct Cost Variance';
        MfgOvhdVarianceCaptionLbl: Label 'Manufacturing Ovhd Variance';
        WIPInventoryCaptionLbl: Label 'WIP Inventory';
        InventoryCaptionLbl: Label 'Inventory';
        ExpectedCostCaptionLbl: Label 'Expected Cost';
        InventoryCostPostedtoGLCaptionLbl: Label 'Inventory Cost Posted to G/L';
        ItemCaptionLbl: Label 'Item';
        EntryTypeCaptionLbl: Label 'Entry Type';
        DimTextCaptionLbl: Label 'Line Dimensions';
        GenPostingSetupTxtCaptionLbl: Label 'General Posting Setup';
        TotalCaptionLbl: Label 'Total';
        InvtPostBufAmountCaptionLbl: Label 'Amount';
        CostAmtCaptionLbl: Label 'Cost Amount';
        ExpectedCost_SkippedValueEntryCaptionLbl: Label 'Skipped Value Entries';
        SkippedItemsCaptionLbl: Label 'Skipped Items';
        TotalValueEntriesPostedToGL: Integer;
        StatisticsMsg: Label '%1 value entries have been posted to the general ledger.', Comment = '10 value entries have been posted to the general ledger.';
        NothingToPostMsg: Label 'There is nothing to post to the general ledger.';

    [Scope('Personalization')]
    procedure InitializeRequest(NewPostMethod: Option; NewDocNo: Code[20]; NewPost: Boolean)
    begin
        PostMethod := NewPostMethod;
        DocNo := NewDocNo;
        Post := NewPost;
    end;

    local procedure GetDimText(var DimSetEntry: Record 480)
    var
        OldDimText: Text[75];
    begin
        DimText := '';

        IF DimSetEntry.FINDSET THEN
            REPEAT
                OldDimText := DimText;
                IF DimText = '' THEN
                    DimText := STRSUBSTNO('%1 - %2', DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code")
                ELSE
                    DimText :=
                      STRSUBSTNO(
                        '%1; %2 - %3', DimText, DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code");
                IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                    DimText := OldDimText;
                    EXIT;
                END;
            UNTIL DimSetEntry.NEXT = 0;
    end;

    local procedure PostEntryToGL(ValueEntry: Record 5802)
    begin
        InvtPost.Initialize(PostMethod = PostMethod::"per Posting Group");
        InvtPost.RUN(ValueEntry);
        TotalValueEntriesPostedToGL += 1;
    end;

    local procedure UpdateAmounts()
    begin
        InvtPost.GetAmtToPost(
          COGSAmt, InvtAdjmtAmt, DirCostAmt,
          OvhdCostAmt, VarPurchCostAmt, VarMfgDirCostAmt, VarMfgOvhdAmt,
          WIPInvtAmt, InvtAmt, FALSE);

        InvtPost.GetAmtToPost(
          TotalCOGSAmt, TotalInvtAdjmtAmt, TotalDirCostAmt,
          TotalOvhdCostAmt, TotalVarPurchCostAmt, TotalVarMfgDirCostAmt, TotalVarMfgOvhdCostAmt,
          TotalWIPInvtAmt, TotalInvtAmt, TRUE);
    end;

    local procedure InsertValueEntryNoBuf(ValueEntry: Record 5802)
    begin
        TempValueEntry.INIT;
        TempValueEntry := ValueEntry;
        TempValueEntry.INSERT;
    end;

    local procedure DisplayStatistics(NotSimulation: Boolean)
    begin
        IF GUIALLOWED AND NotSimulation THEN
            IF TotalValueEntriesPostedToGL > 0 THEN
                MESSAGE(StatisticsMsg, TotalValueEntriesPostedToGL)
            ELSE
                MESSAGE(NothingToPostMsg);
    end;

    [IntegrationEvent(TRUE, TRUE)]
    local procedure OnBeforePreReport()
    begin
    end;
}

