table 34002113 "Perfil Salario x Cargo"
{

    fields
    {
        field(1;"Puesto de Trabajo";Code[15])
        {
            TableRelation = "Puestos laborales".Código;

            trigger OnValidate()
            begin
                IF "Puesto de Trabajo" <> '' THEN
                   BEGIN
                    Cargos.GET("Puesto de Trabajo");
                   END;
            end;
        }
        field(2;"Concepto salarial";Code[20])
        {
            TableRelation = "Conceptos salariales".Código;

            trigger OnValidate()
            begin
                ConfNominas.GET();
                Conceptos.GET("Concepto salarial");
                Descripción         := Conceptos.Descripción;
                "Tipo concepto"     := Conceptos."Tipo concepto";
            end;
        }
        field(3;"No. de Orden";Integer)
        {
            Editable = false;
            Enabled = false;
        }
        field(4;"Descripción";Text[50])
        {
        }
        field(7;"Tipo concepto";Option)
        {
            Description = 'Ingresos,Deducciones';
            OptionMembers = Ingresos,Deducciones;
        }
        field(12;"1ra Quincena";Boolean)
        {
        }
        field(13;"2da Quincena";Boolean)
        {
        }
        field(15;"Fórmula cálculo";Text[80])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Puesto de Trabajo","Concepto salarial")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Conceptos: Record "34002111";
        Cargos: Record "34002110";
        RegFormula: Record "34002143";
        Regconceptos: Record "34002144";
        Regpolaca: Record "34002143";
        Percept: Record "5200";
        RegLinConvenio: Record "34002113";
        LinConvFormula: Record "34002113";
        Scanner: Codeunit "34002106";
        Parser: Codeunit "34002105";
        Calculadora: Codeunit "34002107";
        ConfNominas: Record "34002103";
        ok: Boolean;
        Msg001: Label 'The Concept %1 was not found in the table %2, please verify';
        FormConcSalariales: Page "34002110";
}

