codeunit 56006 "Corrige devol"
{

    trigger OnRun()
    var
        rLinDev: Record 37;
    begin
        rLinDev.SETRANGE("Document Type", rLinDev."Document Type"::"Return Order");
        rLinDev.SETRANGE("Line No.", 20000);
        rLinDev.SETRANGE("Document No.", 'VD-015144');
        rLinDev.FINDSET;
        REPEAT
            rLinDev."Return Qty. Received" := 19;
            rLinDev."Return Qty. Received (Base)" := 19;
            rLinDev."Return Qty. Rcd. Not Invd." := 19;
            rLinDev."Ret. Qty. Rcd. Not Invd.(Base)" := 19;
            rLinDev.MODIFY;
        UNTIL rLinDev.NEXT = 0;
    end;
}

