page 34002554 "Notas Credito Venta Regis POS"
{
    // #21038  29/05/2015  MOI   Se añaden los campos "CAE" "CAEC" y "Respuesta CAE/CAEC".
    // 
    // LDP: Luis Jose De La Cruz Paredes
    // ------------------------------------------------------------------------
    // No.         Fecha           Firma    Descripcion
    // ------------------------------------------------------------------------
    // 001       07-11-2023      LDP      SIC-JERM: Se apadata a la nueva version el boton de liquidar contra pagos TPV
    // 002        08-09-2024      LDP      SANTINAV-6837: Facturas pendientes de liquidar

    ApplicationArea = Basic, Suite;
    Caption = 'POS Posted Sales Credit Memos';
    CardPageID = "Posted Sales Credit Memo";
    Editable = false;
    PageType = List;
    SourceTable = 114;
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
                field("Posting Date"; "Posting Date")
                {
                    Visible = true;
                }
                field("No."; "No.")
                {
                }
                field("No. Fiscal TPV"; "No. Fiscal TPV")
                {
                }
                field(Liquidado; "Liquidado TPV")
                {
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
                field("No. Comprobante Fiscal Rel."; "No. Comprobante Fiscal Rel.")
                {
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                }
                field("Sell-to Customer Name"; "Sell-to Customer Name")
                {
                }
                field("Currency Code"; "Currency Code")
                {
                }
                field(Amount; Amount)
                {

                    trigger OnDrillDown()
                    begin
                        SETRANGE("No.");
                        PAGE.RUNMODAL(PAGE::"Posted Sales Credit Memo", Rec)
                    end;
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {

                    trigger OnDrillDown()
                    begin
                        SETRANGE("No.");
                        PAGE.RUNMODAL(PAGE::"Posted Sales Credit Memo", Rec)
                    end;
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
                field("Cod. Colegio"; "Cod. Colegio")
                {
                }
                field("Nombre Colegio"; "Nombre Colegio")
                {
                }
                field("Bill-to Contact"; "Bill-to Contact")
                {
                    Visible = false;
                }
                field("Document Date"; "Document Date")
                {
                }
                field("No. Documento SIC"; "No. Documento SIC")
                {
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
            group("&Cr. Memo")
            {
                Caption = '&Cr. Memo';
                Image = CreditMemo;
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()
                    begin
                        PAGE.RUN(PAGE::"Posted Sales Credit Memo", Rec)
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
                            PAGE.RUNMODAL(PAGE::"Sales Credit Memo Statistics", Rec, "No.")
                        //TODO: Ver ELSE
                        //TODO: Ver PAGE.RUNMODAL(PAGE::"Sales Credit Memo Stats.", Rec, "No.");
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    //TODO: Ver RunObject = Page "Sales Comment Sheet";
                    //TODO: Ver RunPageLink = "Document Type" = CONST("Posted Credit Memo"),
                    //TODO: Ver "No." = FIELD("No.");
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
            action("Liquidar contra Pagos TPV")
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
                    //TODO: Ver RegistrarCobrosDsPos.RegistrarCobrosNotaCreditoTPVManual(Rec);//002+-
                    //001+ Comentada version dspos anterior
                    /*
                    rParam.INIT;
                    rParam.Accion    := rParam.Accion::LiquidarNotaCredito;
                    rParam.Documento := "No.";
                    rParam.Manual    := TRUE;
                    CODEUNIT.RUN(CODEUNIT::"Funciones DsPOS - Comunes",rParam);
                    */
                    //001- Comentada version dspos anterior

                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        SetSecurityFilterOnRespCenter;
    end;

    var
        gtCAE: Text[160];
        gtCAEC: Text[160];
        gtRespuesta: Text[100];
    //TODO: Ver RegistrarCobrosDsPos: Codeunit 50116;
}

