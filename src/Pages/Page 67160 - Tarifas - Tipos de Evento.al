page 55619 "Tarifas - Tipos de Evento"
{
    PageType = List;
    SourceTable = 55535;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tipo Evento"; Rec."Tipo Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Evento';
                }
                field(Distrito; Rec.Distrito)
                {
                    ApplicationArea = All;
                    ToolTip = 'Distrito';
                }
                field(Pago; Rec.Pago)
                {
                    ApplicationArea = All;
                    ToolTip = 'Pago';
                }
                field("Tipo Pago"; Rec."Tipo Pago")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Pago';
                }
                field(Monto; Rec.Monto)
                {
                    ApplicationArea = All;
                    ToolTip = 'Monto';
                }
            }
        }
    }

    actions
    {
    }
}

