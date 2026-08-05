table 55797 "Seleccion beneficios"
{
    Caption = 'Benefits selection';

    fields
    {
        field(1; "No. documento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. documento';
        }
        field(2; "Cod. Empleado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Empleado';
        }
        field(3; "Tipo Beneficio"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Beneficio';
            OptionCaption = 'Income,Others';
            OptionMembers = Ingresos,Otro;
        }
        field(4; Codigo; Code[16])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
            TableRelation = "Beneficios laborales".Codigo;

            trigger OnValidate()
            begin
                BeneficiosLab.RESET;
                BeneficiosLab.SETRANGE(Codigo, Codigo);
                BeneficiosLab.FINDFIRST;
                Descripcion := BeneficiosLab.Descripcion;
                "Tipo Beneficio" := BeneficiosLab."Tipo Beneficio";
            end;
        }
        field(5; Descripcion; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(6; Importe; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe';
        }
        field(7; Seleccionar; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Seleccionar';
        }
    }

    keys
    {
        key(Key1; "No. documento", "Tipo Beneficio", Codigo)
        {
        }
    }

    fieldgroups
    {
    }

    var
        BeneficiosLab: Record 55793;
}

