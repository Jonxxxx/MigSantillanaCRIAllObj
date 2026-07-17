pageextension 50105 EXCCRIEmploymentContracts extends "Employment Contracts"
{
    layout
    {
        addafter(Description)
        {
            field(EXCCRIUndefined; Rec.Undefined)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Undefined value for the employment contract.';
            }
            field(EXCCRIDuracion; Rec.Duracion)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Duracion value for the employment contract.';
            }
        }
    }
}
