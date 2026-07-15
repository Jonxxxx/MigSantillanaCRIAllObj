page 34002538 "Arqueo de caja"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    RefreshOnActivate = true;
    SourceTable = 34002526;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Tipo; Tipo)
                {
                    Editable = false;
                }
                field(Importe; Importe)
                {
                    Editable = false;
                }
                field(Cantidad; Cantidad)
                {
                    Style = Strong;
                    StyleExpr = TRUE;

                    trigger OnValidate()
                    begin
                        CurrPage.SAVERECORD;
                        CurrPage.UPDATE;
                    end;
                }
                field(Total; Total)
                {
                    Editable = false;
                }
                field("Descripcion"; TraerDescripcion)
                {
                    Editable = false;
                }
            }
            group(GrupoTotal)
            {
                Caption = 'Total en caja';
                field("Total contado"; TraerTotalContado)
                {
                }
            }
        }
    }

    actions
    {
    }

    procedure TraerTotalContado(): Decimal
    var
        recArqueo: Record 34002526;
        decTotal: Decimal;
    begin
        recArqueo.RESET;
        recArqueo.SETRANGE("Cod. tienda", "Cod. tienda");
        recArqueo.SETRANGE("Cod. TPV", "Cod. TPV");
        recArqueo.SETRANGE(Fecha, Fecha);
        recArqueo.SETRANGE("No. turno", "No. turno");
        recArqueo.SETRANGE("Forma de pago", "Forma de pago");
        recArqueo.SETRANGE("Cod. divisa", "Cod. divisa");
        IF recArqueo.FINDFIRST THEN BEGIN
            REPEAT
                decTotal += recArqueo.Total;
            UNTIL recArqueo.NEXT = 0;
            EXIT(decTotal);
        END;
    end;
}

