page 34002553 "Facturas Venta Regis POS"
{
    // #21038   29/05/2015  MOI   Se añaden los campos "CAE" "CAEC" y "respuesta CAE/CAEC".
    // #209023  01/04/2019  RRT   Añadir el campo "External Document No."
    // 
    // LDP: Luis Jose De La Cruz Paredes
    // ------------------------------------------------------------------------
    // No.         Fecha           Firma    Descripcion
    // ------------------------------------------------------------------------
    // 001       07-11-2023      LDP      SIC-JERM: Se apadata a la nueva version el boton de liquidar contra pagos TPV
    // 002        08-09-2024      LDP      SANTINAV-6837:Facturas pendientes de liquidar

    ApplicationArea = Basic, Suite;
    Caption = 'POS Posted Sales Invoices';
    CardPageID = "Posted Sales Invoice";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = 112;
    SourceTableView = SORTING("Posting Date", Tienda, "Venta TPV")
                      ORDER(Ascending)
                      WHERE("Venta TPV" = CONST(True));
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
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No.';
                }
                field("No. Fiscal TPV"; Rec."No. Fiscal TPV")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Fiscal TPV';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Document Date';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'External Document No.';
                }
                field(Liquidado; Rec."Liquidado TPV")
                {
                    ApplicationArea = All;
                    ToolTip = 'Liquidado TPV';
                }
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                }
                field("Nombre Colegio"; Rec."Nombre Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Colegio';
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
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Currency Code';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Amount';

                    trigger OnDrillDown()
                    begin
                        SETRANGE("No.");
                        PAGE.RUNMODAL(PAGE::"Posted Sales Invoice", Rec)
                    end;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Amount Including VAT';

                    trigger OnDrillDown()
                    begin
                        SETRANGE("No.");
                        PAGE.RUNMODAL(PAGE::"Posted Sales Invoice", Rec)
                    end;
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'VAT Registration No.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Location Code';
                    Visible = true;
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
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()
                    begin
                        PAGE.RUN(PAGE::"Posted Sales Invoice", Rec)
                    end;
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        IF "Tax Area Code" = '' THEN
                            PAGE.RUNMODAL(PAGE::"Sales Invoice Statistics", Rec, "No.")
                        ELSE
                            PAGE.RUNMODAL(PAGE::"Sales Invoice Stats.", Rec, "No.");
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = CONST("Posted Invoice"),
                                  "No." = FIELD("No.");
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        ShowDimensions;
                    end;
                }
            }
        }
        area(processing)
        {
            action("Liquidar Contra Pagos TPV")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    rParam: Record 34002522;
                    SalesPost: Codeunit 80;
                begin
                    //SalesPost.RegistrarCobrosTPVManual(Rec."No."); //001+ Version dspos-sic
                    RegistrarCobrosDsPos.RegistrarCobrosFacturaTPVManual(Rec); //002+-

                    //001+ Comentada version dspos anterior
                    /*
                    rParam.INIT;
                    rParam.Accion    := rParam.Accion::LiquidarFactura;
                    rParam.Documento := "No.";
                    rParam.Manual    := TRUE;
                    CODEUNIT.RUN(CODEUNIT::"Funciones DsPOS - Comunes",rParam);
                    */
                    //Comentada version dspos anterior

                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        SetSecurityFilterOnRespCenter;
    end;

    var
        ConfigSantillana: Record 56001;
        SalesInvHeader: Record 112;
        gtCAE: Text[160];
        gtCAEC: Text[160];
        gtRespuesta: Text[100];
        RegistrarCobrosDsPos: Codeunit 50116;
}

