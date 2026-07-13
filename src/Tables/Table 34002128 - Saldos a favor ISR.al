table 34002128 "Saldos a favor ISR"
{

    fields
    {
        field(1; "Cód. Empleado"; Code[15])
        {
            TableRelation = Employee;
        }
        field(2; Ano; Integer)
        {
        }
        field(3; "Saldo a favor"; Decimal)
        {

            trigger OnValidate()
            begin
                IF "Importe Pendiente" = 0 THEN
                    "Importe Pendiente" := "Saldo a favor";
            end;
        }
        field(4; "Importe Pendiente"; Decimal)
        {
        }
        field(5; "Full Name"; Text[50])
        {
            CalcFormula = Lookup(Employee."Full Name" WHERE(No.=FIELD("Cód. Empleado")));
            Caption = 'Full Name';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"Cód. Empleado",Ano)
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
        BKISR: Record 34002130;
}

