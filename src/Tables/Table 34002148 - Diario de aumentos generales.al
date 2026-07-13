table 34002148 "Diario de aumentos generales"
{

    fields
    {
        field(1; "Empresa Cotizacion"; Code[20])
        {
            Caption = 'Business Name';
            TableRelation = "Empresas Cotización";
        }
        field(2; "No. empleado"; Code[20])
        {
            Caption = 'Employee no.';
            TableRelation = Employee;
        }
        field(3; "No. Linea"; Integer)
        {
            Caption = 'Line no.';
        }
        field(4; "Fecha Efectividad"; Date)
        {
            Caption = 'Efective date';
        }
        field(5; Importe; Decimal)
        {
            Caption = 'Amount';
        }
        field(6; Procesado; Boolean)
        {
            Caption = 'Processed';
        }
        field(7; "% Aumento"; Decimal)
        {
            Caption = '% to increase';
        }
        field(8; "Tope Salario"; Decimal)
        {
            Caption = 'Up to';
        }
        field(13; "Tipo Aumento"; Option)
        {
            Caption = 'Raising Type';
            Description = ' ,Gral. por Rango de Salarios,Gral. por % de aumento';
            OptionCaption = ' ,General by Salary range,General by rise %';
            OptionMembers = " ","Gral. por Rango de Salarios","Gral. por % de aumento";
        }
        field(14; "Full name"; Text[150])
        {
            CalcFormula = Lookup(Employee."Full Name" WHERE(No.=FIELD("No. empleado")));
            Caption = 'Full name';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"Empresa Cotizacion","No. empleado","No. Linea")
        {
        }
    }

    fieldgroups
    {
    }
}

