report 67000 "Copia productos"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; 27)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Global Dimension 1 Code", Edicion, "Sub Familia";

            trigger OnAfterGetRecord()
            begin
                IF Promotor = '' THEN
                    ERROR(Err001);
                Counter := Counter + 1;
                Window.UPDATE(1, "No.");
                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

                CASE TipoPresupuesto OF
                    0: //Ventas
                        BEGIN
                            PptoVentas.INIT;
                            PptoVentas.VALIDATE("Cod. Promotor", Promotor);
                            PptoVentas.VALIDATE("Cod. Producto", "No.");
                            IF PptoVentas.INSERT THEN;
                        END;
                    1: //Muestras
                        BEGIN
                            PptoMuestras.INIT;
                            PptoMuestras.VALIDATE("Cod. Promotor", Promotor);
                            PptoMuestras.VALIDATE("Cod. Producto", "No.");
                            IF PptoMuestras.INSERT THEN;
                        END;
                END;
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
        Text001: Label 'Reading item  #1########## @2@@@@@@@@@@@@@';
        PptoVentas: Record 67027;
        PptoMuestras: Record 67028;
        Promotor: Code[20];
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
        Err001: Label 'You must specify a Salesperson Code';
        TipoPresupuesto: Option Ventas,Muestras;

    procedure RecibeDatos(CodPromotor: Code[20]; TipoPpto: Option Ventas,Muestras)
    begin
        Promotor := CodPromotor;
        TipoPresupuesto := TipoPpto;
    end;
}

