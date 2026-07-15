page 34002557 "Lista Notas Credito Pdtes POS"
{
    // #217374, RRT, 18.09.2019: Mostrar la informacion de log para FE en Costa Rica.

    ApplicationArea = Basic, Suite;
    Caption = 'Sales Credit Memos';
    CardPageID = "Ficha Notas Crédito Pdtes POS";
    Editable = false;
    PageType = List;
    SourceTable = 36;
    SourceTableView = SORTING("Posting Date", "Venta TPV", Tienda, "Registrado TPV")
                      ORDER(Ascending)
                      WHERE("Document Type" = CONST("Credit Memo"),
                            "Venta TPV" = CONST(True),
                            "Registrado TPV" = CONST(True));
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Posting Date"; "Posting Date")
                {
                    Editable = ESACC_F20_Editable;
                    HideValue = ESACC_F20_HideValue;
                    Visible = true;
                }
                field(Tienda; Tienda)
                {
                    Editable = ESACC_F34002504_Editable;
                    HideValue = ESACC_F34002504_HideValue;
                    Visible = true;
                }
                field(TPV; TPV)
                {
                    Editable = ESACC_F34002503_Editable;
                    HideValue = ESACC_F34002503_HideValue;
                    Visible = true;
                }
                field("ID Cajero"; "ID Cajero")
                {
                    Editable = ESACC_F34002500_Editable;
                    HideValue = ESACC_F34002500_HideValue;
                    Visible = true;
                }
                field(Turno; Turno)
                {
                    Editable = ESACC_F34002512_Editable;
                    HideValue = ESACC_F34002512_HideValue;
                    Visible = true;
                }
                field("Hora creacion"; "Hora creacion")
                {
                    Editable = ESACC_F34002501_Editable;
                    HideValue = ESACC_F34002501_HideValue;
                    Visible = true;
                }
                field("Posting No."; "Posting No.")
                {
                    Editable = false;
                }
                field("No. Fiscal TPV"; "No. Fiscal TPV")
                {
                    Editable = ESACC_F34002511_Editable;
                    HideValue = ESACC_F34002511_HideValue;
                    Visible = true;
                }
                field("No."; "No.")
                {
                    Editable = false;
                    HideValue = ESACC_F3_HideValue;
                    ToolTip = 'ESACC_F3_Visible';
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    Editable = ESACC_F2_Editable;
                    HideValue = ESACC_F2_HideValue;
                    Visible = true;
                }
                field("Sell-to Customer Name"; "Sell-to Customer Name")
                {
                    Editable = ESACC_F79_Editable;
                    HideValue = ESACC_F79_HideValue;
                    Visible = true;
                }
                field("External Document No."; "External Document No.")
                {
                    Editable = ESACC_F100_Editable;
                    HideValue = ESACC_F100_HideValue;
                    Visible = true;
                }
                field("Sell-to Post Code"; "Sell-to Post Code")
                {
                    Editable = ESACC_F88_Editable;
                    HideValue = ESACC_F88_HideValue;
                    Visible = false;
                }
                field("Sell-to Country/Region Code"; "Sell-to Country/Region Code")
                {
                    Editable = ESACC_F90_Editable;
                    HideValue = ESACC_F90_HideValue;
                    Visible = false;
                }
                field("Sell-to Contact"; "Sell-to Contact")
                {
                    Editable = ESACC_F84_Editable;
                    HideValue = ESACC_F84_HideValue;
                    Visible = false;
                }
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                    Editable = ESACC_F4_Editable;
                    HideValue = ESACC_F4_HideValue;
                    Visible = false;
                }
                field("Bill-to Name"; "Bill-to Name")
                {
                    Editable = ESACC_F5_Editable;
                    HideValue = ESACC_F5_HideValue;
                    Visible = false;
                }
                field("Bill-to Post Code"; "Bill-to Post Code")
                {
                    Editable = ESACC_F85_Editable;
                    HideValue = ESACC_F85_HideValue;
                    Visible = false;
                }
                field("Bill-to Country/Region Code"; "Bill-to Country/Region Code")
                {
                    Editable = ESACC_F87_Editable;
                    HideValue = ESACC_F87_HideValue;
                    Visible = false;
                }
                field("Bill-to Contact"; "Bill-to Contact")
                {
                    Editable = ESACC_F10_Editable;
                    HideValue = ESACC_F10_HideValue;
                    Visible = false;
                }
                field("Ship-to Code"; "Ship-to Code")
                {
                    Editable = ESACC_F12_Editable;
                    HideValue = ESACC_F12_HideValue;
                    Visible = false;
                }
                field("Ship-to Name"; "Ship-to Name")
                {
                    Editable = ESACC_F13_Editable;
                    HideValue = ESACC_F13_HideValue;
                    Visible = false;
                }
                field("Ship-to Post Code"; "Ship-to Post Code")
                {
                    Editable = ESACC_F91_Editable;
                    HideValue = ESACC_F91_HideValue;
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; "Ship-to Country/Region Code")
                {
                    Editable = ESACC_F93_Editable;
                    HideValue = ESACC_F93_HideValue;
                    Visible = false;
                }
                field("Ship-to Contact"; "Ship-to Contact")
                {
                    Editable = ESACC_F18_Editable;
                    HideValue = ESACC_F18_HideValue;
                    Visible = false;
                }
                field("Location Code"; "Location Code")
                {
                    Editable = ESACC_F28_Editable;
                    HideValue = ESACC_F28_HideValue;
                    Visible = true;
                }
                field("Salesperson Code"; "Salesperson Code")
                {
                    Editable = ESACC_F43_Editable;
                    HideValue = ESACC_F43_HideValue;
                    Visible = false;
                }
                field("Error Registro"; "Error Registro")
                {
                    Enabled = false;
                }
                field("No. Documento SIC"; "No. Documento SIC")
                {
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part(PartPage; 9082)
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = true;
            }
            part(PartPage1; 9084)
            {
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
                Visible = true;
            }
            systempart(Links; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Cr. Memo")
            {
                Caption = '&Cr. Memo';
                Image = CreditMemo;
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Enabled = ESACC_C1102601021_Enabled;
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    Visible = ESACC_C1102601021_Visible;

                    trigger OnAction()
                    begin
                        CalcInvDiscForHeader;
                        COMMIT;
                        IF "Tax Area Code" = '' THEN
                            PAGE.RUNMODAL(PAGE::"Sales Statistics", Rec)
                        //TODO: Ver ELSE
                        //TODO: Ver     PAGE.RUNMODAL(PAGE::"Sales Order Stats.", Rec)
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Enabled = ESACC_C1102601023_Enabled;
                    Image = ViewComments;
                    //TODO: Ver RunObject = Page "Sales Comment Sheet";
                    //TODO: Ver RunPageLink = "Document Type" = FIELD("Document Type"),
                    //TODO: Ver               "No." = FIELD("No."),
                    //TODO: Ver               "Document Line No." = CONST(0);
                    Visible = ESACC_C1102601023_Visible;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Enabled = ESACC_C1102601024_Enabled;
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    Visible = ESACC_C1102601024_Visible;

                    trigger OnAction()
                    begin
                        ShowDocDim;
                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Enabled = ESACC_C1102601025_Enabled;
                    Image = Approvals;
                    Visible = ESACC_C1102601025_Visible;

                    trigger OnAction()
                    var
                    //TODO: Ver ApprovalEntries: Page "Approval Entries";
                    begin
                        //TODO: Ver  ApprovalEntries.Setfilters(DATABASE::"Sales Header", "Document Type", "No.");
                        //TODO: Ver ApprovalEntries.RUN;
                    end;
                }
                action("Log de Documentos Electronicos")
                {
                    Caption = '&Log de Documentos Electronicos';
                    Image = Log;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 52500;
                    RunPageLink = NoDocumento = FIELD("Posting No.");
                    Visible = wCostaRica;
                }
            }
        }
        area(processing)
        {
            group(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Enabled = ESACC_C1102601017_Enabled;
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    Visible = ESACC_C1102601017_Visible;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit 414;
                    begin
                        ReleaseSalesDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Enabled = ESACC_C1102601018_Enabled;
                    Image = ReOpen;
                    Visible = ESACC_C1102601018_Visible;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit 414;
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Send A&pproval Request")
                {
                    Caption = 'Send A&pproval Request';
                    Enabled = ESACC_C1102601014_Enabled;
                    Image = SendApprovalRequest;
                    Visible = ESACC_C1102601014_Visible;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit 1535;
                    begin
                        //fes IF ApprovalMgt.SendSalesApprovalRequest(Rec) THEN;
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = ESACC_C1102601015_Enabled;
                    Image = Cancel;
                    Visible = ESACC_C1102601015_Visible;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit 1535;
                    begin
                        //fes IF ApprovalMgt.CancelSalesApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }

            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Enabled = ESACC_C51_Enabled;
                    Image = TestReport;
                    Visible = ESACC_C51_Visible;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Enabled = ESACC_C52_Enabled;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    Visible = ESACC_C52_Visible;

                    trigger OnAction()
                    begin
                        SendToPosting(CODEUNIT::"Sales-Post (Yes/No)");
                    end;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Enabled = ESACC_C53_Enabled;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    Visible = ESACC_C53_Visible;

                    trigger OnAction()
                    begin
                        SendToPosting(CODEUNIT::"Sales-Post + Print");
                    end;
                }
                action("Post &Batch")
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Enabled = ESACC_C54_Enabled;
                    Image = PostBatch;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    Visible = ESACC_C54_Visible;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Sales Credit Memos", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Remove From Job Queue")
                {
                    Caption = 'Remove From Job Queue';
                    Enabled = ESACC_C3_Enabled;
                    Image = RemoveLine;
                    Visible = JobQueueActive;

                    trigger OnAction()
                    begin
                        CancelBackgroundPosting;
                    end;
                }
            }
            group("Gestion SICPOS")
            {
                Caption = 'Gestion SICPOS';
                action("Registrar Ventas en Lote DSPOS")
                {
                    ApplicationArea = Suite, Basic;
                    Image = Process;

                    trigger OnAction()
                    begin
                        //TODO: Ver Registrar.RegistraFacturaManual();
                    end;
                }
                action("Convertir Pedidos DSPOS")
                {
                    ApplicationArea = Suite, Basic;
                    Image = Process;

                    trigger OnAction()
                    begin
                        //TODO: Ver Transfer_SIC.RUN();//001+-
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        SalesSetup: Record 311;
    //TODO: Ver lcfComunes: Codeunit 34002503;
    begin
        SetSecurityFilterOnRespCenter;
        JobQueueActive := SalesSetup.JobQueueActive;

        //+#217374
        wCostaRica := FALSE;
        //TODO: Ver CASE lcFComunes.Pais OF
        //TODO: Ver     9:
        //TODO: Ver        wCostaRica := TRUE;
        //TODO: Ver END;
        //-#217374
    end;

    var
        //TODO: Ver ESACC_ESFLADSMgt: Codeunit 14123801;
        [InDataSet]
        ESACC_C3_Visible: Boolean;
        [InDataSet]
        ESACC_C3_Enabled: Boolean;
        [InDataSet]
        ESACC_C51_Visible: Boolean;
        [InDataSet]
        ESACC_C51_Enabled: Boolean;
        [InDataSet]
        ESACC_C52_Visible: Boolean;
        [InDataSet]
        ESACC_C52_Enabled: Boolean;
        [InDataSet]
        ESACC_C53_Visible: Boolean;
        [InDataSet]
        ESACC_C53_Enabled: Boolean;
        [InDataSet]
        ESACC_C54_Visible: Boolean;
        [InDataSet]
        ESACC_C54_Enabled: Boolean;
        [InDataSet]
        ESACC_C1102601014_Visible: Boolean;
        [InDataSet]
        ESACC_C1102601014_Enabled: Boolean;
        [InDataSet]
        ESACC_C1102601015_Visible: Boolean;
        [InDataSet]
        ESACC_C1102601015_Enabled: Boolean;
        [InDataSet]
        ESACC_C1102601017_Visible: Boolean;
        [InDataSet]
        ESACC_C1102601017_Enabled: Boolean;
        [InDataSet]
        ESACC_C1102601018_Visible: Boolean;
        [InDataSet]
        ESACC_C1102601018_Enabled: Boolean;
        [InDataSet]
        ESACC_C1102601021_Visible: Boolean;
        [InDataSet]
        ESACC_C1102601021_Enabled: Boolean;
        [InDataSet]
        ESACC_C1102601023_Visible: Boolean;
        [InDataSet]
        ESACC_C1102601023_Enabled: Boolean;
        [InDataSet]
        ESACC_C1102601024_Visible: Boolean;
        [InDataSet]
        ESACC_C1102601024_Enabled: Boolean;
        [InDataSet]
        ESACC_C1102601025_Visible: Boolean;
        [InDataSet]
        ESACC_C1102601025_Enabled: Boolean;
        [InDataSet]
        ESACC_F2_Visible: Boolean;
        [InDataSet]
        ESACC_F2_Editable: Boolean;
        [InDataSet]
        ESACC_F2_HideValue: Boolean;
        [InDataSet]
        ESACC_F3_Visible: Boolean;
        [InDataSet]
        ESACC_F3_Editable: Boolean;
        [InDataSet]
        ESACC_F3_HideValue: Boolean;
        [InDataSet]
        ESACC_F4_Visible: Boolean;
        [InDataSet]
        ESACC_F4_Editable: Boolean;
        [InDataSet]
        ESACC_F4_HideValue: Boolean;
        [InDataSet]
        ESACC_F5_Visible: Boolean;
        [InDataSet]
        ESACC_F5_Editable: Boolean;
        [InDataSet]
        ESACC_F5_HideValue: Boolean;
        [InDataSet]
        ESACC_F10_Visible: Boolean;
        [InDataSet]
        ESACC_F10_Editable: Boolean;
        [InDataSet]
        ESACC_F10_HideValue: Boolean;
        [InDataSet]
        ESACC_F12_Visible: Boolean;
        [InDataSet]
        ESACC_F12_Editable: Boolean;
        [InDataSet]
        ESACC_F12_HideValue: Boolean;
        [InDataSet]
        ESACC_F13_Visible: Boolean;
        [InDataSet]
        ESACC_F13_Editable: Boolean;
        [InDataSet]
        ESACC_F13_HideValue: Boolean;
        [InDataSet]
        ESACC_F18_Visible: Boolean;
        [InDataSet]
        ESACC_F18_Editable: Boolean;
        [InDataSet]
        ESACC_F18_HideValue: Boolean;
        [InDataSet]
        ESACC_F20_Visible: Boolean;
        [InDataSet]
        ESACC_F20_Editable: Boolean;
        [InDataSet]
        ESACC_F20_HideValue: Boolean;
        [InDataSet]
        ESACC_F28_Visible: Boolean;
        [InDataSet]
        ESACC_F28_Editable: Boolean;
        [InDataSet]
        ESACC_F28_HideValue: Boolean;
        [InDataSet]
        ESACC_F43_Visible: Boolean;
        [InDataSet]
        ESACC_F43_Editable: Boolean;
        [InDataSet]
        ESACC_F43_HideValue: Boolean;
        [InDataSet]
        ESACC_F79_Visible: Boolean;
        [InDataSet]
        ESACC_F79_Editable: Boolean;
        [InDataSet]
        ESACC_F79_HideValue: Boolean;
        [InDataSet]
        ESACC_F84_Visible: Boolean;
        [InDataSet]
        ESACC_F84_Editable: Boolean;
        [InDataSet]
        ESACC_F84_HideValue: Boolean;
        [InDataSet]
        ESACC_F85_Visible: Boolean;
        [InDataSet]
        ESACC_F85_Editable: Boolean;
        [InDataSet]
        ESACC_F85_HideValue: Boolean;
        [InDataSet]
        ESACC_F87_Visible: Boolean;
        [InDataSet]
        ESACC_F87_Editable: Boolean;
        [InDataSet]
        ESACC_F87_HideValue: Boolean;
        [InDataSet]
        ESACC_F88_Visible: Boolean;
        [InDataSet]
        ESACC_F88_Editable: Boolean;
        [InDataSet]
        ESACC_F88_HideValue: Boolean;
        [InDataSet]
        ESACC_F90_Visible: Boolean;
        [InDataSet]
        ESACC_F90_Editable: Boolean;
        [InDataSet]
        ESACC_F90_HideValue: Boolean;
        [InDataSet]
        ESACC_F91_Visible: Boolean;
        [InDataSet]
        ESACC_F91_Editable: Boolean;
        [InDataSet]
        ESACC_F91_HideValue: Boolean;
        [InDataSet]
        ESACC_F93_Visible: Boolean;
        [InDataSet]
        ESACC_F93_Editable: Boolean;
        [InDataSet]
        ESACC_F93_HideValue: Boolean;
        [InDataSet]
        ESACC_F100_Visible: Boolean;
        [InDataSet]
        ESACC_F100_Editable: Boolean;
        [InDataSet]
        ESACC_F100_HideValue: Boolean;
        [InDataSet]
        ESACC_F34002500_Visible: Boolean;
        [InDataSet]
        ESACC_F34002500_Editable: Boolean;
        [InDataSet]
        ESACC_F34002500_HideValue: Boolean;
        [InDataSet]
        ESACC_F34002501_Visible: Boolean;
        [InDataSet]
        ESACC_F34002501_Editable: Boolean;
        [InDataSet]
        ESACC_F34002501_HideValue: Boolean;
        [InDataSet]
        ESACC_F34002503_Visible: Boolean;
        [InDataSet]
        ESACC_F34002503_Editable: Boolean;
        [InDataSet]
        ESACC_F34002503_HideValue: Boolean;
        [InDataSet]
        ESACC_F34002504_Visible: Boolean;
        [InDataSet]
        ESACC_F34002504_Editable: Boolean;
        [InDataSet]
        ESACC_F34002504_HideValue: Boolean;
        [InDataSet]
        ESACC_F34002511_Visible: Boolean;
        [InDataSet]
        ESACC_F34002511_Editable: Boolean;
        [InDataSet]
        ESACC_F34002511_HideValue: Boolean;
        [InDataSet]
        ESACC_F34002512_Visible: Boolean;
        [InDataSet]
        ESACC_F34002512_Editable: Boolean;
        [InDataSet]
        ESACC_F34002512_HideValue: Boolean;
        ReportPrint: Codeunit 228;
        [InDataSet]
        JobQueueActive: Boolean;
        wCostaRica: Boolean;
    //TODO: Ver Registrar: Codeunit 50112;
    //TODO: Ver Transfer_SIC: Codeunit 50110;
}

