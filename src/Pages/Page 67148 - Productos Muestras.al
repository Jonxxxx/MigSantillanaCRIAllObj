page 67148 "Productos Muestras"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPlus;
    SourceTable = 7302;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item No."; "Item No.")
                {
                }
                field("Item Description"; "Item Description")
                {
                }
                field(Quantity; Quantity)
                {
                }
            }
        }
    }

    actions
    {
        group()
        {
            action()
            {

                trigger OnAction()
                begin
                    /*
                    TH.GET(NoDocumento);
                    SETRANGE("Location Code",TH."Transfer-from Code");
                    SETRANGE("Bin Code",TH."Cod. Ubicacion Alm. Origen");
                    
                    MARKEDONLY(TRUE);
                    IF FINDSET THEN
                        REPEAT
                         NoLin += 1000;
                         TL.INIT;
                         TL."Document No." := TH."No.";
                         TL."Line No."     := NoLin;
                         TL.VALIDATE("Transfer-from Code",TH."Transfer-from Code");
                         TL.VALIDATE("Transfer-to Code",TH."Transfer-to Code");
                         TL.VALIDATE("Item No.","Item No.");
                    //     TL.VALIDATE(Quantity,1);
                         IF TH."Cod. Ubicacion Alm. Origen" <> '' THEN
                            TL.VALIDATE("Transfer-from Bin Code",TH."Cod. Ubicacion Alm. Origen");
                         IF TH."Cod. Ubicacion Alm. Destino" <> '' THEN
                            TL.VALIDATE("Transfer-To Bin Code",TH."Cod. Ubicacion Alm. Destino");
                         IF NOT TL.INSERT(TRUE) THEN
                            TL.MODIFY(TRUE);
                        UNTIL NEXT = 0;
                    */

                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        recPromotor: Record 13;
    begin
        IF gPromotor = '' THEN
            EXIT;

        recPromotor.GET(gPromotor);
        SETRANGE("Location Code", recPromotor."Location code");
        SETRANGE("Bin Code", gPromotor);
    end;

    var
        gPromotor: Code[20];

    procedure RecibeParametros(CodPromotor: Code[20])
    begin
        gPromotor := CodPromotor;
    end;
}

