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
                field("Tipo concepto"; Rec."Tipo concepto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo concepto';
                }
                field("Concepto salarial"; Rec."Concepto salarial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Concepto salarial';
                }
                field("Salario Base"; Rec."Salario Base")
                {
                    ApplicationArea = All;
                    ToolTip = 'Salario Base';
                }
                field(Periodo; Rec.Periodo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Periodo';
                    Visible = false;
                }
                field("Cotiza ISR"; Rec."Cotiza ISR")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cotiza ISR';
                }
                field("Sujeto Cotizacion"; Rec."Sujeto Cotizacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sujeto Cotizacion';
                }
                field("Texto Informativo"; Rec."Texto Informativo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Texto Informativo';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field(Cantidad; Rec.Cantidad)
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Currency Code';
                }
                field("Importe Base"; Rec."Importe Base")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Base';
                }
                field(Total; Rec.Total)
                {
                    ApplicationArea = All;
                    ToolTip = 'Total';
                }
                field("% Cotizable"; Rec."% Cotizable")
                {
                    ApplicationArea = All;
                    ToolTip = '% Cotizable';
                }
                field("% Pago Empleado"; Rec."% Pago Empleado")
                {
                    ApplicationArea = All;
                    ToolTip = '% Pago Empleado';
                }
                field(Formula; Rec.Formula)
                {
                    ApplicationArea = All;
                    ToolTip = 'Formula';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shortcut Dimension 1 Code';
                    Visible = false;
                }
                field(Comentario; Rec.Comentario)
                {
                    ApplicationArea = All;
                    ToolTip = 'Comentario';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shortcut Dimension 2 Code';
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
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    ToolTip = 'Dimensions';
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

