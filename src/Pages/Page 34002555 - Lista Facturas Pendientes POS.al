page 55949 "Lista Facturas Pendientes POS"
{
    // #217374, RRT, 18.09.2019: Mostrar la informacion de log para FE en Costa Rica.
    // #349127, RRT, 30.11.2020: Unificacion del producto.
    //  Proyecto: Implementacion Business Central
    // 
    //  LDP: Luis Jose De La Cruz Paredes
    //  ------------------------------------------------------------------------
    //  No.        Fecha           Firma    Descripcion
    //  ------------------------------------------------------------------------
    //  001        31-10-2023      LDP      Para que sea visible el boton incluso cuanod no haya ventas que procesar.

    ApplicationArea = All;
    Caption = 'Sales Invoices';
    CardPageID = "Ficha Facturas Pdtes POS";
    Editable = false;
    PageType = List;
    SourceTable = 36;
    SourceTableView = SORTING("Posting Date", "Venta TPV", Tienda, "Registrado TPV")
                      ORDER(Ascending)
                      WHERE("Document Type" = FILTER(Invoice | Order),
                            "Venta TPV" = CONST(True),
                            "Registrado TPV" = CONST(True));
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Posting Date';
                    Visible = true;
                }
                field(Tienda; Rec.Tienda)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tienda';
                }
                field(TPV; Rec.TPV)
                {
                    ApplicationArea = All;
                    ToolTip = 'TPV';
                }
                field("ID Cajero"; Rec."ID Cajero")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Cajero';
                }
                field(Turno; Rec.Turno)
                {
                    ApplicationArea = All;
                    ToolTip = 'Turno';
                }
                field("Hora creacion"; Rec."Hora creacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora creacion';
                }
                field("No. Fiscal TPV"; Rec."No. Fiscal TPV")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Fiscal TPV';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No.';
                }
                field("Posting No."; Rec."Posting No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Posting No.';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sell-to Customer No.';
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sell-to Customer Name';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'External Document No.';
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Payment Method Code';
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sell-to Post Code';
                    Visible = false;
                }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sell-to Country/Region Code';
                    Visible = false;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sell-to Contact';
                    Visible = false;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Bill-to Customer No.';
                    Visible = false;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Bill-to Name';
                    Visible = false;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Bill-to Post Code';
                    Visible = false;
                }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Bill-to Country/Region Code';
                    Visible = false;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Bill-to Contact';
                    Visible = false;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ship-to Code';
                    Visible = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ship-to Name';
                    Visible = false;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ship-to Post Code';
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ship-to Country/Region Code';
                    Visible = false;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ship-to Contact';
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shortcut Dimension 1 Code';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shortcut Dimension 2 Code';
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Location Code';
                    Visible = true;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Customer Posting Group';
                    Visible = false;
                }
                field("Error Registro"; Rec."Error Registro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Error Registro';
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Applies-to Doc. No.';
                }
                field("No. Documento SIC"; Rec."No. Documento SIC")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Documento SIC';
                }
            }
        }
        area(factboxes)
        {
            part(part1; 9082)
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = true;
                ApplicationArea = All;
            }
            part(Part2; 9084)
            {
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
                Visible = true;
                ApplicationArea = All;
            }
            systempart(Links; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Invoice")
            {
                Caption = '&Invoice';
                Image = Invoice;
                action(Statistics)
                {
                    ApplicationArea = All;
                    Caption = 'Statistics';
                    ToolTip = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        CalcInvDiscForHeader;
                        COMMIT;
                        IF "Tax Area Code" = '' THEN
                            PAGE.RUNMODAL(PAGE::"Sales Statistics", Rec)
                        ELSE
                            PAGE.RUNMODAL(PAGE::"Sales Order Stats.", Rec)
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    ToolTip = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    ToolTip = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        ShowDocDim;
                    end;
                }
                action("Log de Documentos Electronicos")
                {
                    ApplicationArea = All;
                    Caption = '&Log de Documentos Electronicos';
                    ToolTip = '&Log de Documentos Electronicos';
                    Image = Log;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 55199;
                    RunPageLink = NoDocumento = FIELD("Posting No.");
                    Visible = wCostaRica;
                }
                action("Completar Lineas")
                {
                    ApplicationArea = All;
                    Caption = 'Completar Lineas';
                    ToolTip = 'Completar Lineas';
                    Visible = false;

                    trigger OnAction()
                    var
                        Utilitarioparacorregircosas: Codeunit 55201;
                    begin
                        Utilitarioparacorregircosas.TransferLineaActualizada2(Rec."No. Fiscal TPV", Rec."Location Code");
                    end;
                }
            }
        }
        area(processing)
        {
            group(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release1)
                {
                    ApplicationArea = All;
                    Caption = 'Re&lease';
                    ToolTip = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit 414;
                    begin
                        ReleaseSalesDoc.PerformManualRelease(Rec);
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = All;
                    Caption = 'Re&open';
                    ToolTip = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit 414;
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                    end;
                }
                action("Registrar Ventas en Lote DSPOS")
                {
                    ApplicationArea = All;
                    Caption = 'Registrar Ventas en Lote DSPOS';
                    ToolTip = 'Registrar Ventas en Lote DSPOS';
                    Image = Process;

                    trigger OnAction()
                    begin
                        Registrar.RegistraFacturaManual();
                    end;
                }
                action("Convertir Pedidos DSPOS")
                {
                    ApplicationArea = All;
                    Caption = 'Convertir Pedidos DSPOS';
                    ToolTip = 'Convertir Pedidos DSPOS';
                    Image = Process;

                    trigger OnAction()
                    begin
                        Transfer_SIC.RUN();//001+-
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        SalesSetup: Record 311;
    // TODO: Manual review - Codeunit 55897 exists, but Pais is inside a disabled block and is not a compiled public procedure.
    // Original code: lcfComunes: Codeunit 55897;
    begin
        SetSecurityFilterOnRespCenter;
        JobQueueActive := SalesSetup.JobQueueActive;

        //+#217374
        wCostaRica := FALSE;
        // TODO: Manual review - Pais is not a compiled procedure, and numeric country value 9 must not be reinterpreted without verified option semantics.
        // Original code preserved below.
        // CASE lcFComunes.Pais OF
        //     9:
        //         wCostaRica := TRUE;
        // END;
        //-#217374
    end;

    var
        ReportPrint: Codeunit 228;
        [InDataSet]
        JobQueueActive: Boolean;
        wCostaRica: Boolean;
        Registrar: Codeunit 55111;
        Transfer_SIC: Codeunit 55110;
}

