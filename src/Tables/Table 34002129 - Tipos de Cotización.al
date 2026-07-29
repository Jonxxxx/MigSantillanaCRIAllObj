table 34002129 "Tipos de Cotizacion"
{
    DrillDownPageID = 34002146;
    LookupPageID = 34002146;

    fields
    {
        field(1; Ano; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Ano';
            NotBlank = true;
        }
        field(2; "Codigo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
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
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(4; "Porciento Empresa"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Porciento Empresa';
            DecimalPlaces = 2 : 2;
        }
        field(5; "Porciento Empleado"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Porciento Empleado';
            DecimalPlaces = 2 : 2;
        }
        field(6; "Cuota Empresa"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cuota Empresa';
            DecimalPlaces = 0 : 5;
        }
        field(7; "Cuota Empleado"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cuota Empleado';
            DecimalPlaces = 2 : 2;
        }
        field(8; "Base aplicar"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Base aplicar';
            Description = 'Salario Base,Ingresos';
            OptionMembers = "Salario Base",Ingresos;
        }
        field(9; "Tope Salarial/Acumulado Anual"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Tope Salarial/Acumulado Anual';
            DecimalPlaces = 2 : 2;
        }
        field(10; "Acumula por"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Acumula por';
            Description = ' ,Empleado,Empresa,Ambos';
            OptionCaption = ' ,Employee,Company,Both';
            OptionMembers = " ",Empleado,Empresa,Ambos;
        }
        field(11; "Control por escalas"; Boolean)
        {
            Caption = 'Control por escalas';
            CalcFormula = Exist("Distribucion Importes TSS" WHERE(Ano = FIELD("Ano"),
                                                                   "Concepto Salarial" = FIELD("Codigo")));
            FieldClass = FlowField;
        }
        field(12; "Porciento Empresa Pensionados"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Porciento Empresa Pensionados';
            DecimalPlaces = 2 : 2;
        }
        field(13; "Porciento Empleado Pensionados"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Porciento Empleado Pensionados';
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

