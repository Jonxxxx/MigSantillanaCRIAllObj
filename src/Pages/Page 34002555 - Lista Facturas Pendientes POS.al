page 34002555 "Lista Facturas Pendientes POS"
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

    ApplicationArea = Basic, Suite;
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
                field("Posting Date"; "Posting Date")
                {
                    Visible = true;
                }
                field(Tienda; Tienda)
                {
                }
                field(TPV; TPV)
                {
                }
                field("ID Cajero"; "ID Cajero")
                {
                }
                field(Turno; Turno)
                {
                }
                field("Hora creacion"; "Hora creacion")
                {
                }
                field("No. Fiscal TPV"; "No. Fiscal TPV")
                {
                }
                field("No."; "No.")
                {
                }
                field("Posting No."; "Posting No.")
                {
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                }
                field("Sell-to Customer Name"; "Sell-to Customer Name")
                {
                }
                field("External Document No."; "External Document No.")
                {
                }
                field("Payment Method Code"; "Payment Method Code")
                {
                }
                field("Sell-to Post Code"; "Sell-to Post Code")
                {
                    Visible = false;
                }
                field("Sell-to Country/Region Code"; "Sell-to Country/Region Code")
                {
                    Visible = false;
                }
                field("Sell-to Contact"; "Sell-to Contact")
                {
                    Visible = false;
                }
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                    Visible = false;
                }
                field("Bill-to Name"; "Bill-to Name")
                {
                    Visible = false;
                }
                field("Bill-to Post Code"; "Bill-to Post Code")
                {
                    Visible = false;
                }
                field("Bill-to Country/Region Code"; "Bill-to Country/Region Code")
                {
                    Visible = false;
                }
                field("Bill-to Contact"; "Bill-to Contact")
                {
                    Visible = false;
                }
                field("Ship-to Code"; "Ship-to Code")
                {
                    Visible = false;
                }
                field("Ship-to Name"; "Ship-to Name")
                {
                    Visible = false;
                }
                field("Ship-to Post Code"; "Ship-to Post Code")
                {
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; "Ship-to Country/Region Code")
                {
                    Visible = false;
                }
                field("Ship-to Contact"; "Ship-to Contact")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    Visible = false;
                }
                field("Location Code"; "Location Code")
                {
                    Visible = true;
                }
                field("Customer Posting Group"; "Customer Posting Group")
                {
                    Visible = false;
                }
                field("Error Registro"; "Error Registro")
                {
                }
                field("Applies-to Doc. No."; "Applies-to Doc. No.")
                {
                }
                field("No. Documento SIC"; "No. Documento SIC")
                {
                }
            }
        }
        area(factboxes)
        {
            part(part1; 9082)
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = true;
            }
            part(Part2; 9084)
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
            group("&Invoice")
            {
                Caption = '&Invoice';
                Image = Invoice;
                action(Statistics)
                {
                    Caption = 'Statistics';
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
                        //TODO: Ver ELSE
                        //TODO: Ver     PAGE.RUNMODAL(PAGE::"Sales Order Stats.", Rec)
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    //TODO: Ver RunObject = Page "Sales Comment Sheet";
                    //TODO: Ver RunPageLink = "Document Type" = FIELD("Document Type"),
                    //TODO: Ver              "No." = FIELD("No."),
                    //TODO: Ver              "Document Line No." = CONST(0);
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        ShowDocDim;
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
                action("Completar Lineas")
                {
                    Visible = false;

                    trigger OnAction()
                    var
                    //TODO: Ver Utilitarioparacorregircosas: Codeunit 52502;
                    begin
                        //TODO: Ver Utilitarioparacorregircosas.TransferLineaActualizada2(Rec."No. Fiscal TPV", Rec."Location Code");
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
                    ApplicationArea = Basic, Suite;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F9';
                    ToolTip = 'Release the document to the next stage of processing. When a document is released, it will be included in all availability calculations from the expected receipt date of the items. You must reopen the document before you can make changes to it.';

                    trigger OnAction()
                    var
                    //TODO: Ver ReleaseSalesDoc: Codeunit 414;
                    begin
                        //TODO: Ver ReleaseSalesDoc.PerformManualRelease(Rec);
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedOnly = true;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                    trigger OnAction()
                    var
                    //TODO: Ver ReleaseSalesDoc: Codeunit 414;
                    begin
                        //TODO: Ver  ReleaseSalesDoc.PerformManualReopen(Rec);
                    end;
                }
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
        //TODO: Ver         wCostaRica := TRUE;
        //TODO: Ver END;
        //-#217374
    end;

    var
        ReportPrint: Codeunit 228;
        [InDataSet]
        JobQueueActive: Boolean;
        wCostaRica: Boolean;
    //TODO: Ver Registrar: Codeunit 50112;
    //TODO: Ver  Transfer_SIC: Codeunit 50110;
}

