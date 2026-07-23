pageextension 50099 EXCCRIEmployeeCard extends "Employee Card"
{
    layout
    {
        addlast(General)
        {
            group(EXCCRIBankAffiliations)
            {
                Caption = 'Bank/Affiliations';

                group(EXCCRIBank)
                {
                    Caption = 'Bank';

                    field(EXCCRIFormaDeCobro; Rec."Forma de Cobro")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the Forma de Cobro value for the employee.';
                    }
                    field(EXCCRIDisponible1; Rec."Disponible 1")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the Disponible 1 value for the employee.';
                    }
                    field(EXCCRIDisponible2; Rec."Disponible 2")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the Disponible 2 value for the employee.';
                    }
                    field(EXCCRICuenta; Rec.Cuenta)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the Cuenta value for the employee.';
                    }
                }
                group(EXCCRISocialSecurity)
                {
                    Caption = 'Social Security';

                    field(EXCCRIDiaNacimiento; Rec."Dia nacimiento")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the Dia nacimiento value for the employee.';
                    }
                    field(EXCCRICodAFP; Rec."Cod. AFP")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the Cod. AFP value for the employee.';
                    }
                    field(EXCCRICodARS; Rec."Cod. ARS")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the Cod. ARS value for the employee.';
                    }
                    field(EXCCRIExcluidoCotizacionTSS; Rec."Excluido Cotizacion TSS")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the Excluido Cotizacion TSS value for the employee.';
                    }
                    field(EXCCRIExcluidoCotizacionISR; Rec."Excluido Cotizacion ISR")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the Excluido Cotizacion ISR value for the employee.';
                    }
                }
            }
        }
        addlast(FactBoxes)
        {
            part(EXCCRIEmployeeInformation; 34002182)
            {
                ApplicationArea = All;
                Caption = 'Employee Information';
            }
            part(EXCCRIPayrollInformation; 34002183)
            {
                ApplicationArea = All;
                Caption = 'Payroll Information';
            }
        }
    }
}
