page 56026 "Clasificacion devoluciones"
{
    Caption = 'Returns classification';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = 56025;
    SourceTableView = WHERE("Closed" = CONST(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(CustNo; "Customer no.")
                {
                    Caption = 'Customer no.';
                    TableRelation = Customer;
                }
                field("Customer name"; "Customer name")
                {
                    Editable = false;
                }
                field("External document no."; "External document no.")
                {
                    Caption = 'External Doc. Number';
                }
                field(barcode; Barcode)
                {
                    Caption = 'EAN';
                    //TODO: Ver TableRelation = "Item Cross Reference"."Cross-Reference No.";

                    trigger OnValidate()
                    begin
                        //TODO: Ver ICR.SETCURRENTKEY("Cross-Reference No.");
                        //TODO: Ver ICR.SETRANGE("Cross-Reference No.", Barcode);
                        //TODO: Ver 
                        /*
                        IF ICR.FINDFIRST THEN
                            Item.GET(ICR."Item No.")
                        ELSE BEGIN
                            Item.GET(Barcode);
                            ICR."Item No." := Barcode;
                        END;

                        ItemNo := ICR."Item No.";*/
                        Desc := Item.Description;
                        Iuom := Item."Base Unit of Measure";
                    end;
                }
                field(ItemNo; ItemNo)
                {
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
                    Editable = false;
                }
                field(Iuom; Iuom)
                {
                    Caption = 'Unit of measure';
                    TableRelation = "Item Unit of Measure";
                }
                field(Cant; Cant)
                {
                    Caption = 'Quantity';
                }
                field("Comentario producto"; ComentarioProd)
                {
                }
                field("Cod. Almacen"; "Cod. Almacen")
                {
                }
            }
            part(Detalle; 56027)
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
                Caption = '&Insert';
                InFooterBar = true;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                ShortCutKey = 'Ctrl+Return';

                trigger OnAction()
                begin
                    IF Cant <= 0 THEN
                        ERROR(Err001);

                    //TODO: Ver CD2.RESET;
                    //TODO: Ver CD2.SETRANGE("No. Documento", "No.");
                    //TODO: Ver IF CD2.FINDLAST THEN;

                    CD.INIT;
                    CD."No. Documento" := "No.";
                    CD.VALIDATE("Customer No.", "Customer no.");
                    CD.VALIDATE("Item No.", ItemNo);
                    CD.VALIDATE(Quantity, Cant);
                    //TODO: Ver CD."Line No." := CD2."Line No." + 1;
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
                Caption = 'Cerrar recepcion';
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
        CD: Record 56026;
        CD2Record: Record 56026;
        //TODO: Ver ICR: Record 5717;
        Item: Record 27;
        CDR: Record 56025;
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

