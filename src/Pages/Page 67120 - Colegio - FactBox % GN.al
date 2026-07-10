page 67120 "Colegio - FactBox % GN"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = Table67002;
    SourceTableView = SORTING(Tipo registro, Codigo)
                      WHERE(Tipo registro=CONST(Grupo de Negocio));

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Descripcion; Descripcion)
                {
                    Caption = 'Grupo de negocio';
                }
                field(TraerPorcentaje; TraerPorcentaje)
                {
                    Caption = '%';
                }
            }
        }
    }

    actions
    {
    }

    var
        codColegio: Code[20];

    procedure PasarParam(codPrmColegio: Code[20])
    begin
        codColegio := codPrmColegio;
    end;

    procedure TraerPorcentaje(): Decimal
    var
        recDetAdop Record: 67053;
        decTotalColegio: Decimal;
        decTotalNivel: Decimal;
    begin

        //Calcula el % del grupo de negociosobre el total de adopciones.

        recDetAdop.RESET;
        recDetAdop.SETRANGE("Cod. Colegio", codColegio);
        recDetAdop.SETFILTER(Adopcion, '%1|%2', recDetAdop.Adopcion::Mantener, recDetAdop.Adopcion::Conquista);
        recDetAdop.SETFILTER("Adopcion Real", '<>%1', 0);
        IF recDetAdop.FINDSET THEN
            REPEAT
                decTotalColegio += recDetAdop."Adopcion Real" * TraerPrecioUnitarioProducto(recDetAdop."Cod. Producto");
            UNTIL recDetAdop.NEXT = 0;

        IF decTotalColegio <> 0 THEN BEGIN
            recDetAdop.SETRANGE("Grupo de Negocio", Codigo);
            IF recDetAdop.FINDSET THEN
                REPEAT
                    decTotalNivel += recDetAdop."Adopcion Real" * TraerPrecioUnitarioProducto(recDetAdop."Cod. Producto");
                UNTIL recDetAdop.NEXT = 0;

            EXIT(ROUND(decTotalNivel / decTotalColegio * 100));
        END;
    end;

    procedure TraerPrecioUnitarioProducto(codPrmProducto: Code[20]): Decimal
    var
        recPrecios Record: 7002;
    begin
        recPrecios.RESET;
        recPrecios.SETRANGE("Item No.", codPrmProducto);
        recPrecios.SETRANGE("Sales Type", recPrecios."Sales Type"::"All Customers");
        recPrecios.SETRANGE("Sales Code", '');
        recPrecios.SETRANGE("Currency Code", '');
        recPrecios.SETRANGE("Variant Code", '');
        recPrecios.SETRANGE("Ending Date", 0D);
        IF recPrecios.FINDLAST THEN
            EXIT(recPrecios."Unit Price");
    end;
}

