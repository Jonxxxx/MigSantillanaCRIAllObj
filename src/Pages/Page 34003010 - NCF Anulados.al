page 34003010 "NCF Anulados"
{
    Editable = false;
    PageType = List;
    SourceTable = 34003012;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("No. documento"; Rec."No. documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. documento';
                }
                field("No. Comprobante Fiscal"; Rec."No. Comprobante Fiscal")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Comprobante Fiscal';
                }
                field("Fecha anulacion"; Rec."Fecha anulacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha anulacion';
                }
                field("No. Serie NCF Abonos"; Rec."No. Serie NCF Abonos")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Serie NCF Abonos';
                    Visible = false;
                }
                field("No. Serie NCF Facturas"; Rec."No. Serie NCF Facturas")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Serie NCF Facturas';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

