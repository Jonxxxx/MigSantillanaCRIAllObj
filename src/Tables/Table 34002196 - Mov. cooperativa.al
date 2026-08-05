table 55837 "Mov. cooperativa"
{
    Caption = 'Cooperative entries';
    DrillDownPageID = 55859;
    LookupPageID = 55859;

    fields
    {
        field(1; "No. Movimiento"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Movimiento';
        }
        field(2; "Tipo miembro"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo miembro';
            OptionCaption = 'Member, Partner';
            OptionMembers = Miembro,Socio;
        }
        field(3; "Employee No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Employee;
        }
        field(4; "Fecha registro"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha registro';
        }
        field(5; "No. documento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. documento';
        }
        field(6; "Tipo transaccion"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo transaccion';
            OptionCaption = ' ,Deposit,Loan,Fee,Late fee';
            OptionMembers = " ",Aporte,"Prestamo",Cuota,Mora;
        }
        field(7; Importe; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe';
        }
        field(8; "Full name"; Text[150])
        {
            CalcFormula = Lookup(Employee."Full Name" WHERE("No." = FIELD("Employee No.")));
            Caption = 'Full name';
            FieldClass = FlowField;
        }
        field(9; "Concepto salarial"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto salarial';
            TableRelation = "Conceptos salariales".Codigo;

            trigger OnValidate()
            var
                ConceptosSal: Record 55752;
            begin
            end;
        }
    }

    keys
    {
        key(Key1; "No. Movimiento")
        {
        }
        key(Key2; "No. documento", "Tipo transaccion")
        {
            SumIndexFields = Importe;
        }
        key(Key3; "Employee No.", "Tipo transaccion", "Fecha registro")
        {
            SumIndexFields = Importe;
        }
    }

    fieldgroups
    {
    }
}

