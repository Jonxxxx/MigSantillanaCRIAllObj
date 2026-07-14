table 34002129 "Tipos de Cotización"
{
    //TODO: Ver DrillDownPageID = 34002146;
    //TODO: Ver LookupPageID = 34002146;

    fields
    {
        field(1; Ano; Integer)
        {
            Caption = 'Year';
            NotBlank = true;
        }
        field(2; "Codigo"; Code[20])
        {
            TableRelation = "Conceptos salariales".Codigo;

            trigger OnValidate()
            begin
                ConceptosSal.SETRANGE(Codigo, Codigo);
                ConceptosSal.FINDFIRST;
                Descripcion := ConceptosSal.Descripcion;
            end;
        }
        field(3; "Descripcion"; Text[60])
        {
        }
        field(4; "Porciento Empresa"; Decimal)
        {
            Caption = 'Company %';
            DecimalPlaces = 2 : 2;
        }
        field(5; "Porciento Empleado"; Decimal)
        {
            Caption = 'Employee %';
            DecimalPlaces = 2 : 2;
        }
        field(6; "Cuota Empresa"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(7; "Cuota Empleado"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(8; "Base aplicar"; Option)
        {
            Description = 'Salario Base,Ingresos';
            OptionMembers = "Salario Base",Ingresos;
        }
        field(9; "Tope Salarial/Acumulado Anual"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(10; "Acumula por"; Option)
        {
            Caption = 'Acummulate by';
            Description = ' ,Empleado,Empresa,Ambos';
            OptionCaption = ' ,Employee,Company,Both';
            OptionMembers = " ",Empleado,Empresa,Ambos;
        }
        field(11; "Control por escalas"; Boolean)
        {
            CalcFormula = Exist("Distribucion Importes TSS" WHERE(Ano = FIELD("Ano"),
                                                                   "Concepto Salarial" = FIELD("Codigo")));
            FieldClass = FlowField;
        }
        field(12; "Porciento Empresa Pensionados"; Decimal)
        {
            Caption = 'Retired Company %';
            DecimalPlaces = 2 : 2;
        }
        field(13; "Porciento Empleado Pensionados"; Decimal)
        {
            Caption = 'Retired Employee %';
            DecimalPlaces = 2 : 2;
        }
    }

    keys
    {
        key(Key1; Ano, "Codigo")
        {
        }
    }

    fieldgroups
    {
    }

    var
        ConceptosSal: Record 34002111;
}

