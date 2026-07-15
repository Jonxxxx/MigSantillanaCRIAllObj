page 34002116 "Historico lineas nominas"
{
    Caption = 'Lines';
    PageType = ListPart;
    SourceTable = 34002118;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                Editable = false;
                field("Concepto salarial"; "Concepto salarial")
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field(Cantidad; Cantidad)
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
                field("Tipo concepto"; "Tipo concepto")
                {
                }
                field("Salario Base"; "Salario Base")
                {
                }
                field("Sujeto Cotizacion"; "Sujeto Cotizacion")
                {
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                }
                field("Cotiza ISR"; "Cotiza ISR")
                {
                }
                field("Cotiza SFS"; "Cotiza SFS")
                {
                }
                field("Cotiza AFP"; "Cotiza AFP")
                {
                }
                field(Formula; Formula)
                {
                }
                field("Texto Informativo"; "Texto Informativo")
                {
                }
                field("Cotiza SRL"; "Cotiza SRL")
                {
                }
                field("Cotiza Infotep"; "Cotiza Infotep")
                {
                }
                field("Aplica para Regalia"; "Aplica para Regalia")
                {
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

