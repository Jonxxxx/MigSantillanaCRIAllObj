page 34002124 "Historico lineas nomina"
{
    AutoSplitKey = true;
    PageType = ListPart;
    Permissions = TableData 34002118 = rimd;
    SourceTable = 34002118;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Tipo concepto"; "Tipo concepto")
                {
                }
                field("Concepto salarial"; "Concepto salarial")
                {
                }
                field("Salario Base"; "Salario Base")
                {
                }
                field(Periodo; Periodo)
                {
                    Visible = false;
                }
                field("Cotiza ISR"; "Cotiza ISR")
                {
                }
                field("Sujeto Cotizacion"; "Sujeto Cotizacion")
                {
                }
                field("Texto Informativo"; "Texto Informativo")
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field(Cantidad; Cantidad)
                {
                }
                field("Currency Code"; "Currency Code")
                {
                }
                field("Importe Base"; "Importe Base")
                {
                }
                field(Total; Total)
                {
                }
                field("% Cotizable"; "% Cotizable")
                {
                }
                field("% Pago Empleado"; "% Pago Empleado")
                {
                }
                field(Formula; Formula)
                {
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    Visible = false;
                }
                field(Comentario; Comentario)
                {
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        ShowDimensions;
                    end;
                }

            }
        }
    }

    var
        AccumImporte: Decimal;
        TotalImporte: Decimal;
        AccumParcial: Decimal;
        TotalParcial: Decimal;
}

