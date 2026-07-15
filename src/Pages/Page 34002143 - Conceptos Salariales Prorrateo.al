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
                field(Codigo; Codigo)
                {
                    Editable = false;
                    Visible = false;
                }
                field("Tipo provision"; "Tipo provision")
                {
                }
                field("Gpo. Contable Empleado"; "Gpo. Contable Empleado")
                {
                    Visible = false;
                }
                field("Formula cálculo"; "Formula cálculo")
                {
                }
                field("No. Cuenta"; "No. Cuenta")
                {
                }
                field("No. Cuenta Contrapartida"; "No. Cuenta Contrapartida")
                {
                }
                field("Validar Contrapartida"; "Validar Contrapartida")
                {
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

