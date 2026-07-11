page 56053 "Actualiza Descuento"
{

    layout
    {
        area(content)
        {
            field(PorcDesc; PorcDesc)
            {
                Caption = 'Discount %';
            }
        }
    }

    actions
    {
    }

    trigger OnClosePage()
    begin
        Window.OPEN(Text004);
        LCF.RESET;
        LCF.SETCURRENTKEY("Document Type", "Document No.", "ID Usuario", "Line No.");
        LCF.SETRANGE("Document Type", 1);
        LCF.SETRANGE("Document No.", NoPedido);
        LCF.SETRANGE("ID Usuario", USERID);
        CounterTotal := LCF.COUNT;
        IF LCF.FINDSET THEN
            REPEAT
                Counter := Counter + 1;
                Window.UPDATE(1, LCF."No.");
                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));
                LCF."Line Discount %" := PorcDesc;
                LCF.MODIFY;
            UNTIL LCF.NEXT = 0;
        Window.CLOSE;
    end;

    var
        NoPedido: Code[20];
        PorcDesc: Decimal;
        LCF: Record 56011;
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
        Text004: Label 'Reading  #1########## @2@@@@@@@@@@@@@';

    procedure RecibeNoPedido(NoPed_Loc: Code[20])
    begin
        NoPedido := NoPed_Loc;
    end;
}

