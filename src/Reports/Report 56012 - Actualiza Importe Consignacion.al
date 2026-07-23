report 56012 "Actualiza Importe Consignacion"
{
    Caption = 'Update Consignment Amount';
    Permissions = TableData 32 = rm;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; 18)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.";
            dataitem("Item Ledger Entry"; 32)
            {
                DataItemLink = "Location Code" = FIELD("No.");
                DataItemTableView = SORTING("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date")
                                    ORDER(Ascending)
                                    WHERE(Open = FILTER(True));

                trigger OnAfterGetRecord()
                begin
                    //IF "Pedido Consignacion" OR "Devolucion Consignacion" THEN
                    Counter := Counter + 1;
                    Window.UPDATE(1, "Item Ledger Entry"."Document No.");
                    Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

                    "Precio Unitario Cons. Act." := cuFunSan.CalcrPrecio("Item No.", "Location Code", "Unit of Measure Code", WORKDATE);
                    "Descuento % Cons. Actualizado" := cuFunSan.CalcDesc("Item No.", "Location Code", "Unit of Measure Code", WORKDATE);

                    "Importe Cons. bruto Act." := (Quantity * "Precio Unitario Cons. Act.");
                    wImpDesc := ((Quantity * "Precio Unitario Cons. Act.") * "Descuento % Cons. Actualizado") / 100;
                    "Importe Cons. Neto Act." := ((Quantity * "Precio Unitario Cons. Act.") - wImpDesc);
                    "Ult. Fecha Act. Imp. Consig." := WORKDATE;
                    MODIFY;
                end;

                trigger OnPostDataItem()
                begin
                    Window.CLOSE;
                end;

                trigger OnPreDataItem()
                begin
                    CounterTotal := COUNT;
                    Window.OPEN(Text001);
                end;
            }
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

    var
        cuFunSan: Codeunit 56000;
        wImpDesc: Decimal;
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
        Text001: Label 'Reading  #1########## @2@@@@@@@@@@@@@';
}

