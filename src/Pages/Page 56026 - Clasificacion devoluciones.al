page 55251 "Clasificacion devoluciones"
{
    Caption = 'Returns classification';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = 55250;
    SourceTableView = WHERE("Closed" = CONST(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No.';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(CustNo; Rec."Customer no.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Customer no.';
                    Caption = 'Customer no.';
                    TableRelation = Customer;
                }
                field("Customer name"; Rec."Customer name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Customer name';
                    Editable = false;
                }
                field("External document no."; Rec."External document no.")
                {
                    ApplicationArea = All;
                    ToolTip = 'External document no.';
                    Caption = 'External Doc. Number';
                }
                field(barcode; Barcode)
                {
                    ApplicationArea = All;
                    Caption = 'EAN';
                    TableRelation = "Item Reference"."Reference No.";

                    trigger OnValidate()
                    begin
                        ICR.SETCURRENTKEY("Reference No.");
                        ICR.SETRANGE("Reference No.", Barcode);
                        IF ICR.FINDFIRST THEN
                            Item.GET(ICR."Item No.")
                        ELSE BEGIN
                            Item.GET(Barcode);
                            ICR."Item No." := Barcode;
                        END;

                        ItemNo := ICR."Item No.";
                        Desc := Item.Description;
                        Iuom := Item."Base Unit of Measure";
                    end;
                }
                field(ItemNo; ItemNo)
                {
                    ApplicationArea = All;
                    Caption = 'Item no.';
                    TableRelation = Item;

                    trigger OnValidate()
                    begin
                        Item.GET(ItemNo);
                        Desc := Item.Description;
                        Iuom := Item."Base Unit of Measure";
                    end;
                }
                field(Desc; Desc)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Iuom; Iuom)
                {
                    ApplicationArea = All;
                    Caption = 'Unit of measure';
                    TableRelation = "Item Unit of Measure";
                }
                field(Cant; Cant)
                {
                    ApplicationArea = All;
                    Caption = 'Quantity';
                }
                field("Comentario producto"; ComentarioProd)
                {
                    ApplicationArea = All;
                }
                field("Cod. Almacen"; Rec."Cod. Almacen")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Almacen';
                }
            }
            part(Detalle; 55252)
            {
                SubPageLink = "No. Documento" = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Insert")
            {
                ApplicationArea = All;
                Caption = '&Insert';
                ToolTip = '&Insert';
                InFooterBar = true;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                ShortCutKey = 'Ctrl+Return';

                trigger OnAction()
                begin
                    IF Cant <= 0 THEN
                        ERROR(Err001);

                    CD2Record.RESET;
                    CD2Record.SETRANGE("No. Documento", Rec."No.");
                    IF CD2Record.FINDLAST THEN;

                    CD.INIT;
                    CD."No. Documento" := "No.";
                    CD.VALIDATE("Customer No.", "Customer no.");
                    CD.VALIDATE("Item No.", ItemNo);
                    CD.VALIDATE(Quantity, Cant);
                    CD."Line No." := CD2Record."Line No." + 1;
                    //CD."External Doc. Number" := EDoc;
                    CD."External Doc. Number" := "External document no.";
                    CD."Cross-Reference No." := Barcode;
                    CD.Comentario := ComentarioProd;
                    CD.INSERT(TRUE);

                    "Receipt date" := WORKDATE;
                    //"External document no." := EDoc;
                    MODIFY;

                    CurrPage.Detalle.PAGE.Refrescar;
                    CLEAR(ItemNo);
                    CLEAR(Desc);
                    CLEAR(Barcode);
                    CLEAR(Iuom);
                    CLEAR(Cant);
                    CLEAR(ComentarioProd);
                    Cant := 1;

                    CurrPage.UPDATE;
                end;
            }
            action("<Action1000000021>")
            {
                ApplicationArea = All;
                Caption = 'Cerrar recepcion';
                ToolTip = 'Cerrar recepcion';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Closed := TRUE;
                    "User id" := USERID;
                    "Closing Datetime" := CURRENTDATETIME;
                    MODIFY;

                    CurrPage.CLOSE;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Cant := 1;
    end;

    var
        CD: Record 55251;
        CD2Record: Record 55251;
        ICR: Record "Item Reference";
        Item: Record 27;
        CDR: Record 55250;
        Cant: Integer;
        Err001: Label 'Quantity can''t be negative or zero';
        Desc: Text[60];
        Iuom: Code[20];
        ItemNo: Code[20];
        CustNo: Code[20];
        Barcode: Code[22];
        _EDoc: Code[20];
        Err002: Label 'Quantity can''t be negative or zero';
        ComentarioProd: Text[250];
}

