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

