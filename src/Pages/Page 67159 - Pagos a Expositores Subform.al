page 55618 "Pagos a Expositores Subform"
{
    PageType = List;
    SourceTable = 55558;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Evento"; Rec."Cod. Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Evento';
                }
                field("Descripcion Evento"; Rec."Descripcion Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Evento';
                }
                field(Secuencia; Rec.Secuencia)
                {
                    ApplicationArea = All;
                    ToolTip = 'Secuencia';
                }
                field("Tipo Evento"; Rec."Tipo Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Evento';
                }
                field("Cod. Expositor"; Rec."Cod. Expositor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Expositor';
                    Editable = false;
                }
                field("Monto a Pagar"; Rec."Monto a Pagar")
                {
                    ApplicationArea = All;
                    ToolTip = 'Monto a Pagar';
                }
            }
        }
    }

    actions
    {
    }
}

