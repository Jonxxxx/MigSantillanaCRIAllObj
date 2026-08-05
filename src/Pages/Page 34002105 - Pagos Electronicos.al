page 55746 "Pagos Electronicos"
{
    Caption = 'Electronic Payment Income Distribution';
    PageType = List;
    SourceTable = 55749;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("No. empleado"; Rec."No. empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. empleado';
                    Visible = false;
                }
                field("Cod. Banco"; Rec."Cod. Banco")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Banco';
                }
                field("Tipo Cuenta"; Rec."Tipo Cuenta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Cuenta';
                }
                field("Numero Cuenta"; Rec."Numero Cuenta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Numero Cuenta';
                }
                field("Nro. tarjeta"; Rec."Nro. tarjeta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nro. tarjeta';
                }
                field(Importe; Rec.Importe)
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe';
                }
                field("Fecha vencimiento"; Rec."Fecha vencimiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha vencimiento';
                }
                field("Tipo Importe"; Rec."Tipo Importe")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Importe';
                }
            }
        }
    }

    actions
    {
    }
}

