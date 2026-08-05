table 55773 "Dimensiones Contabilizacion"
{

    fields
    {
        field(1; "Cod. Dimension"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Dimension';
            TableRelation = Dimension;
        }
        field(2; Orden; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Orden';
        }
        field(3; Descripcion; Text[30])
        {
            Caption = 'Descripcion';
            CalcFormula = Lookup(Dimension.Description WHERE(Code = FIELD("Cod. Dimension")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; Requerida; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Requerida';
        }
        field(5; "Validar en"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Validar en';
            OptionCaption = ' ,Empleados,Conceptos';
            OptionMembers = " ",Empleados,Conceptos;
        }
    }

    keys
    {
        key(Key1; "Cod. Dimension")
        {
        }
        key(Key2; Orden)
        {
        }
    }

    fieldgroups
    {
    }
}

