table 34002148 "Diario de aumentos generales"
{

    fields
    {
        field(1; "Empresa Cotizacion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Empresa Cotizacion';
            TableRelation = "Empresas Cotizacion";
        }
        field(2; "No. empleado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. empleado';
            TableRelation = Employee;
        }
        field(3; "No. Linea"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Linea';
        }
        field(4; "Fecha Efectividad"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Efectividad';
        }
        field(5; Importe; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe';
        }
        field(6; Procesado; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Procesado';
        }
        field(7; "% Aumento"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = '% Aumento';
        }
        field(8; "Tope Salario"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Tope Salario';
        }
        field(13; "Tipo Aumento"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Aumento';
            Description = ' ,Gral. por Rango de Salarios,Gral. por % de aumento';
            OptionCaption = ' ,General by Salary range,General by rise %';
            OptionMembers = " ","Gral. por Rango de Salarios","Gral. por % de aumento";
        }
        field(14; "Full name"; Text[150])
        {
            CalcFormula = Lookup(Employee."Full Name" WHERE("No." = FIELD("No. empleado")));
            Caption = 'Full name';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Empresa Cotizacion", "No. empleado", "No. Linea")
        {
        }
    }

    fieldgroups
    {
    }
}

