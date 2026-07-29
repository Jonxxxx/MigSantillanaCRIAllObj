table 70007 "Plantilla Queen Lista Mater."
{

    fields
    {
        field(1; "Codigo Santillana combo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Santillana combo';
            Description = 'CAMPO CLAVE';
        }
        field(2; "Codigo Santillana componente"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Santillana componente';
            Description = 'CAMPO CLAVE';
        }
        field(3; "ISBN Combo"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'ISBN Combo';
            Description = 'CAMPO CLAVE\';
        }
        field(4; "ISBN Componente"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'ISBN Componente';
            Description = 'CAMPO CLAVE\';
        }
        field(5; "Unidades Componente"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Unidades Componente';
        }
        field(6; "Unidad Medida Base"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Unidad Medida Base';
        }
    }

    keys
    {
        key(Key1; "Codigo Santillana combo", "Codigo Santillana componente", "ISBN Combo", "ISBN Componente")
        {
        }
    }

    fieldgroups
    {
    }
}

