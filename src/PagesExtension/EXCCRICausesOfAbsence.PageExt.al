pageextension 50102 EXCCRICausesOfAbsence extends "Causes of Absence"
{
    layout
    {
        addafter(Description)
        {
            field(EXCCRICodConceptoSalarial; Rec."Cod. concepto salarial")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Cod. concepto salarial value for the cause of absence.';
            }
            field(EXCCRITipoDeNovedadTSS; Rec."Tipo de novedad TSS")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Tipo de novedad TSS value for the cause of absence.';
            }
            field(EXCCRIDiasLaborables; Rec."Dias laborables")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Dias laborables value for the cause of absence.';
            }
            field(EXCCRIMaximoDeDias; Rec."Maximo de dias")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Maximo de dias value for the cause of absence.';
            }
            field(EXCCRIDescripcionAPP; Rec."Descripcion APP")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Descripcion APP value for the cause of absence.';
            }
            field(EXCCRIPublish; Rec.Publish)
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Publish value for the cause of absence.';
            }
        }
    }
}
