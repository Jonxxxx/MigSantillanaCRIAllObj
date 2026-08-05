table 55769 "Saldos a favor ISR"
{

    fields
    {
        field(1; "Cod. Empleado"; Code[15])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Empleado';
            TableRelation = Employee;
        }
        field(2; Ano; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Ano';
        }
        field(3; "Saldo a favor"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Saldo a favor';

            trigger OnValidate()
            begin
                IF "Importe Pendiente" = 0 THEN
                    "Importe Pendiente" := "Saldo a favor";
            end;
        }
        field(4; "Importe Pendiente"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Pendiente';
        }
        field(5; "Full Name"; Text[50])
        {
            CalcFormula = Lookup(Employee."Full Name" WHERE("No." = FIELD("Cod. Empleado")));
            Caption = 'Full Name';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Cod. Empleado", Ano)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        BKISR.TRANSFERFIELDS(Rec);
        IF NOT BKISR.INSERT THEN
            BKISR.MODIFY;
    end;

    var
        BKISR: Record 55771;
}

