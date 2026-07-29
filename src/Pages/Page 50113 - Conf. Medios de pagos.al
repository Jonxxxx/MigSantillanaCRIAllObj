page 50113 "Conf. Medios de pagos"
{
    PageType = List;
    SourceTable = 50110;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. med. pago"; Rec."Cod. med. pago")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. med. pago';
                }
                field(Credito; Rec.Credito)
                {
                    ApplicationArea = All;
                    ToolTip = 'Credito';
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Account Type';
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Account No.';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("Cod. Forma Pago"; Rec."Cod. Forma Pago")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Forma Pago';
                }
                field("ID Agrupacion"; Rec."ID Agrupacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Agrupacion';
                }
            }
        }
    }

    actions
    {
    }
}

