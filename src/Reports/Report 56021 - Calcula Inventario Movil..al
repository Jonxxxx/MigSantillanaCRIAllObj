report 56021 "Calcula Inventario Movil."
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; 27)
        {
            RequestFilterFields = "No.", "Location Filter";

            trigger OnAfterGetRecord()
            begin
                IF GUIALLOWED THEN BEGIN
                    Counter := Counter + 1;
                    Window.UPDATE(1, Item."No.");
                    Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));
                END;

                Loc.RESET;
                IF Loc.FINDSET THEN
                    REPEAT
                        Item1.GET("No.");
                        Item1.SETFILTER("Location Filter", Loc.Code);
                        Item1.CALCFIELDS(Inventory);
                        DispInv.INIT;
                        DispInv.VALIDATE("Cod. Producto", Item1."No.");
                        DispInv.VALIDATE(Descripcion, Item1.Description);
                        DispInv.VALIDATE("Cod. Almancen", Loc.Code);
                        DispInv.VALIDATE(Inventario, Item1.Inventory);
                        DispInv.VALIDATE("Fecha Ult. Actualizacion", WORKDATE);
                        DispInv.VALIDATE("Linea de Negocio", "Global Dimension 1 Code");
                        IF ICC.GET(Item."Item Category Code") THEN BEGIN
                            DispInv.VALIDATE("Cod. Categoria Producto", ICC.Code);
                            DispInv.VALIDATE("Nombre Categoria Producto", ICC.Description);
                        END;

                        IF Item1.Inventory <> 0 THEN
                            IF NOT DispInv.INSERT THEN
                                DispInv.MODIFY;
                    UNTIL Loc.NEXT = 0;
            end;

            trigger OnPreDataItem()
            begin
                DispInv.DELETEALL(TRUE);

                IF GUIALLOWED THEN BEGIN
                    CounterTotal := COUNT;
                    Window.OPEN(Text001);
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        IF GUIALLOWED THEN
            Window.CLOSE;
    end;

    var
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
        Text001: Label 'Reading  #1########## @2@@@@@@@@@@@@@';
        DispInv: Record 56024;
        Loc: Record 14;
        Item1: Record 27;
        Inventario: Decimal;
        ICC: Record 5722;
}

