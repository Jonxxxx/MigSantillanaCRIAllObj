page 55757 "Historico lineas nominas"
{
    Caption = 'Lines';
    PageType = ListPart;
    SourceTable = 55759;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                Editable = false;
                field("Concepto salarial"; Rec."Concepto salarial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Concepto salarial';
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
                field("Tipo concepto"; Rec."Tipo concepto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo concepto';
                }
                field("Salario Base"; Rec."Salario Base")
                {
                    ApplicationArea = All;
                    ToolTip = 'Salario Base';
                }
                field("Sujeto Cotizacion"; Rec."Sujeto Cotizacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sujeto Cotizacion';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shortcut Dimension 1 Code';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shortcut Dimension 2 Code';
                }
                field("Cotiza ISR"; Rec."Cotiza ISR")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cotiza ISR';
                }
                field("Cotiza SFS"; Rec."Cotiza SFS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cotiza SFS';
                }
                field("Cotiza AFP"; Rec."Cotiza AFP")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cotiza AFP';
                }
                field(Formula; Rec.Formula)
                {
                    ApplicationArea = All;
                    ToolTip = 'Formula';
                }
                field("Texto Informativo"; Rec."Texto Informativo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Texto Informativo';
                }
                field("Cotiza SRL"; Rec."Cotiza SRL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cotiza SRL';
                }
                field("Cotiza Infotep"; Rec."Cotiza Infotep")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cotiza Infotep';
                }
                field("Aplica para Regalia"; Rec."Aplica para Regalia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Aplica para Regalia';
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

