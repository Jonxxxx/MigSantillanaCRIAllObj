page 34002129 "Lista Cab Impuestos"
{
    CardPageID = "Historico Cab. Impuestos";
    Editable = false;
    PageType = List;
    SourceTable = 34002121;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Tipo de nomina"; Rec."Tipo de nomina")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de nomina';
                }
                field("Tipo Nomina"; Rec."Tipo Nomina")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Nomina';
                    Visible = false;
                }
                field("No. Documento"; Rec."No. Documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Documento';
                }
                field("Unidad cotizacion"; Rec."Unidad cotizacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unidad cotizacion';
                }
                field(Periodo; Rec.Periodo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Periodo';
                }
                field("No. Contabilizacion"; Rec."No. Contabilizacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Contabilizacion';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;
}

