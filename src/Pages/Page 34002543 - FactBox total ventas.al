page 34002543 "FactBox total ventas"
{
    PageType = ListPart;
    SourceTable = 55895;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Id TPV"; Rec."Id TPV")
                {
                    ApplicationArea = All;
                    ToolTip = 'Id TPV';
                    Caption = 'TPV';
                    Importance = Promoted;
                }
                field("Importe ventas"; Rec."Importe ventas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe ventas';
                    Caption = 'Ventas';
                }
                field("Importe cobros"; Rec."Importe cobros")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe cobros';
                    Caption = 'Cobros';
                }
            }
            grid(General)
            {
                group(GeneralGroup)
                {
                    field(Tienda; Rec.Tienda)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Tienda';
                        Caption = 'Store';
                    }
                    field("Importe ventas tienda"; Rec."Importe ventas Tienda")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Importe ventas Tienda';
                        Caption = 'Ventas';
                    }
                    field("Importe cobros tienda"; Rec."Importe cobros Tienda")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Importe cobros Tienda';
                        Caption = 'Cobros';
                    }
                }
            }
        }
    }

    actions
    {
    }

    var
        decTienda: Decimal;
        decTPV: Decimal;
}

