page 55789 "Saldos a favor ISR"
{
    AdditionalSearchTerms = 'Income tax balances';
    ApplicationArea = Basic, Suite, BasicHR;
    Caption = 'Income tax balances';
    PageType = List;
    SourceTable = 55769;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Cod. Empleado"; Rec."Cod. Empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Empleado';
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Full Name';
                }
                field(Ano; Rec.Ano)
                {
                    ApplicationArea = All;
                    ToolTip = 'Ano';
                }
                field("Saldo a favor"; Rec."Saldo a favor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Saldo a favor';
                }
                field("Importe Pendiente"; Rec."Importe Pendiente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Pendiente';
                }
            }
        }
    }

    actions
    {
    }
}

