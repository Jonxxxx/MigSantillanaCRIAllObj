page 34002148 "Saldos a favor ISR"
{
    AdditionalSearchTerms = 'Income tax balances';
    ApplicationArea = Basic, Suite, BasicHR;
    Caption = 'Income tax balances';
    PageType = List;
    SourceTable = 34002128;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Cod. Empleado"; "Cod. Empleado")
                {
                }
                field("Full Name"; "Full Name")
                {
                }
                field(Ano; Ano)
                {
                }
                field("Saldo a favor"; "Saldo a favor")
                {
                }
                field("Importe Pendiente"; "Importe Pendiente")
                {
                }
            }
        }
    }

    actions
    {
    }
}

