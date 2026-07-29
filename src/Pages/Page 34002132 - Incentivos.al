page 34002132 Incentivos
{
    PageType = List;
    SourceTable = 34002126;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Concepto Salarial"; Rec."Concepto Salarial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Concepto Salarial';
                }
                field(Delegacion; Rec.Delegacion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Delegacion';
                }
                field("Fecha de Corte"; Rec."Fecha de Corte")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha de Corte';
                }
                field("Monto a Distribuir"; Rec."Monto a Distribuir")
                {
                    ApplicationArea = All;
                    ToolTip = 'Monto a Distribuir';
                }
                field("Fecha Ult. Corte"; Rec."Fecha Ult. Corte")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Ult. Corte';
                }
            }
        }
    }

    actions
    {
    }
}

