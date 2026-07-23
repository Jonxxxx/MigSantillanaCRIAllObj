table 34002196 "Mov. cooperativa"
{
    Caption = 'Cooperative entries';
    DrillDownPageID = 34002218;
    //TODO: Ver LookupPageID = 34002218;

    fields
    {
        field(1; "No. Movimiento"; Integer)
        {
            Caption = 'Entry no.';
            DataClassification = ToBeClassified;
        }
        field(2; "Tipo miembro"; Option)
        {
            Caption = 'Member type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Member, Partner';
            OptionMembers = Miembro,Socio;
        }
        field(3; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = Employee;
        }
        field(4; "Fecha registro"; Date)
        {
            Caption = 'Posting date';
            DataClassification = ToBeClassified;
        }
        field(5; "No. documento"; Code[20])
        {
            Caption = 'Document no.';
            DataClassification = ToBeClassified;
        }
        field(6; "Tipo transaccion"; Option)
        {
            Caption = 'Transaction type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Deposit,Loan,Fee,Late fee';
            OptionMembers = " ",Aporte,"Préstamo",Cuota,Mora;
        }
        field(7; Importe; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(8; "Full name"; Text[150])
        {
            //TODO: Ver CalcFormula = Lookup(Employee."Full Name" WHERE("No."=FIELD("Employee No.")));
            Caption = 'Full name';
            FieldClass = FlowField;
        }
        field(9; "Concepto salarial"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Conceptos salariales".Codigo;

            trigger OnValidate()
            var
                ConceptosSal: Record 34002111;
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

