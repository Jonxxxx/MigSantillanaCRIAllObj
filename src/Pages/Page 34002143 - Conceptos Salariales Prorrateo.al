page 34002143 "Conceptos Salariales Prorrateo"
{
    DataCaptionFields = "Codigo";
    PageType = List;
    SourceTable = 34002119;

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
                    Editable = false;
                    Visible = false;
                }
                field("Tipo provision"; Rec."Tipo provision")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo provision';
                }
                field("Gpo. Contable Empleado"; Rec."Gpo. Contable Empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Gpo. Contable Empleado';
                    Visible = false;
                }
                field("Formula Calculo"; Rec."Formula Calculo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Formula Calculo';
                }
                field("No. Cuenta"; Rec."No. Cuenta")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Cuenta';
                }
                field("No. Cuenta Contrapartida"; Rec."No. Cuenta Contrapartida")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Cuenta Contrapartida';
                }
                field("Validar Contrapartida"; Rec."Validar Contrapartida")
                {
                    ApplicationArea = All;
                    ToolTip = 'Validar Contrapartida';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        ConceptoSal.SETRANGE(Codigo, Codigo);
        ConceptoSal.FINDFIRST;
        ConceptoSal.TESTFIELD(Provisionar);
    end;

    var
        ConceptoSal: Record 34002111;
}

