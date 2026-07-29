page 34002158 "Tipos de nominas"
{
    AdditionalSearchTerms = 'Payroll type';
    ApplicationArea = Basic, Suite, BasicHR;
    Caption = 'Payroll type';
    PageType = List;
    SourceTable = 34002158;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("Frecuencia de pago"; Rec."Frecuencia de pago")
                {
                    ApplicationArea = All;
                    ToolTip = 'Frecuencia de pago';
                }
                field("Validar contrato"; Rec."Validar contrato")
                {
                    ApplicationArea = All;
                    ToolTip = 'Validar contrato';
                }
                field("Tipo de nomina"; Rec."Tipo de nomina")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de nomina';
                }
                field("Incluir salario"; Rec."Incluir salario")
                {
                    ApplicationArea = All;
                    ToolTip = 'Incluir salario';
                }
                field("Cotiza ISR"; Rec."Cotiza ISR")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cotiza ISR';
                }
                field("Cotiza AFP"; Rec."Cotiza AFP")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cotiza AFP';
                }
                field("Cotiza SFS"; Rec."Cotiza SFS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cotiza SFS';
                }
                field("Cotiza INFOTEP"; Rec."Cotiza INFOTEP")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cotiza INFOTEP';
                }
                field("Cotiza SRL"; Rec."Cotiza SRL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cotiza SRL';
                }
                field("Dia inicio 1ra"; Rec."Dia inicio 1ra")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dia inicio 1ra';
                }
                field("Dia inicio 2da"; Rec."Dia inicio 2da")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dia inicio 2da';
                }
                field("Calcular ISR Mes en Bonific"; Rec."Calcular ISR Mes en Bonific")
                {
                    ApplicationArea = All;
                    ToolTip = 'Calcular ISR Mes en Bonific';
                }
            }
        }
    }

    actions
    {
    }
}

