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
                field("Document Date"; "Document Date")
                {
                }
                field("External Document No."; "External Document No.")
                {
                }
                field(Liquidado; "Liquidado TPV")
                {
                }
                field("Cod. Colegio"; "Cod. Colegio")
                {
                }
                field("Nombre Colegio"; "Nombre Colegio")
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
                        PAGE.RUNMODAL(PAGE::"Posted Sales Invoice", Rec)
                    end;
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {

                    trigger OnDrillDown()
                    begin
                        SETRANGE("No.");
                        PAGE.RUNMODAL(PAGE::"Posted Sales Invoice", Rec)
                    end;
                }
                field("VAT Registration No."; "VAT Registration No.")
                {
                }
                field("Location Code"; "Location Code")
                {
                    Visible = true;
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
                        //TODO: Ver ELSE
                        //TODO: Ver     PAGE.RUNMODAL(PAGE::"Sales Invoice Stats.", Rec, "No.");
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    //TODO: Ver RunObject = Page "Sales Comment Sheet";
                    //TODO: Ver RunPageLink = "Document Type" = CONST("Posted Invoice"),
                    //TODO: Ver               "No." = FIELD("No.");
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
                    //TODO: Ver RegistrarCobrosDsPos.RegistrarCobrosFacturaTPVManual(Rec); //002+-

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
    //TODO: Ver RegistrarCobrosDsPos: Codeunit 50116;
}

