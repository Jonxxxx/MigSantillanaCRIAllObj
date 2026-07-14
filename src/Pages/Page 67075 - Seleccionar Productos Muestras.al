page 67075 "Seleccionar Productos Muestras"
{
    // Esto va en OnAfterNextRecord
    // 
    // BC.RESET;
    // BC.SETRANGE("Location Code",TH."Transfer-from Code");
    // BC.SETRANGE("Bin Code",TH."Cod. Ubicacion Alm. Origen");
    // BC.SETRANGE("Item No.","Cod. Producto");
    // IF BC.FINDFIRST THEN
    //    BEGIN
    //     BC.CALCFIELDS("Quantity (Base)");
    //     IF BC."Quantity (Base)" = 0 THEN
    //        NEXT;
    //    END;

    PageType = ListPlus;
    SourceTable = 7302;

    layout
    {
        area(content)
        {
            repeater(GeneralG)
            {
                field(Seleccionar; Seleccionar)
                {
                    Caption = 'Select';

                    trigger OnValidate()
                    begin
                        MARK(Seleccionar);
                    end;
                }
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

    trigger OnAfterGetRecord()
    begin
        Seleccionar := FALSE;
        //IF "Cantidad seleccionada" <> 0 THEN
        /*IF Quantity <> 0 THEN
           BEGIN
            Seleccionar := TRUE;
            MARK(Seleccionar);
           END;
        */

    end;

    trigger OnOpenPage()
    begin
        TH.GET(NoDocumento);
        SETRANGE("Location Code", TH."Transfer-from Code");
        SETRANGE("Bin Code", TH."Cod. Ubicacion Alm. Origen");
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction IN [ACTION::OK, ACTION::LookupOK] THEN
            OKOnPush;
    end;

    var
        BC: Record 7302;
        TH: Record 5740;
        TL: Record 5741;
        TransLine2: Record 5741;
        PPM: Record 67028;
        Seleccionar: Boolean;
        NoDocumento: Code[20];

    procedure RecibeParametros(DocNo: Code[20]; CodPromotor: Code[20])
    begin
        NoDocumento := DocNo;
    end;

    local procedure OKOnPush()
    begin
        TH.GET(NoDocumento);
        SETRANGE("Location Code", TH."Transfer-from Code");
        SETRANGE("Bin Code", TH."Cod. Ubicacion Alm. Origen");

        MARKEDONLY(TRUE);
        IF FINDSET THEN
            REPEAT
                TL.INIT;

                TransLine2.RESET;
                TransLine2.SETRANGE("Document No.", TH."No.");
                IF TransLine2.FINDLAST THEN
                    TL."Line No." := TransLine2."Line No." + 10000
                ELSE
                    TL."Line No." := 10000;

                TL."Document No." := TH."No.";
                TL."Transfer-from Code" := TH."Transfer-from Code";
                TL."Transfer-to Code" := TH."Transfer-to Code";

                TL.VALIDATE("Transfer-from Code", TH."Transfer-from Code");
                TL.VALIDATE("Transfer-to Code", TH."Transfer-to Code");
                TL.VALIDATE("Item No.", "Item No.");
                //     TL.VALIDATE(Quantity,1);
                IF TH."Cod. Ubicacion Alm. Origen" <> '' THEN
                    TL.VALIDATE("Transfer-from Bin Code", TH."Cod. Ubicacion Alm. Origen");
                IF TH."Cod. Ubicacion Alm. Destino" <> '' THEN
                    TL.VALIDATE("Transfer-To Bin Code", TH."Cod. Ubicacion Alm. Destino");

                IF NOT TL.INSERT(TRUE) THEN
                    TL.MODIFY(TRUE);
            UNTIL NEXT = 0;
    end;
}

