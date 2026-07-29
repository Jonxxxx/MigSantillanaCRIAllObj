table 34002177 "Punch log"
{

    fields
    {
        field(1; "Cod. Empleado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Empleado';
            TableRelation = Employee;
        }
        field(2; "Fecha registro"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha registro';
        }
        field(3; "Hora registro"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora registro';
        }
        field(4; "No. tarjeta"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'No. tarjeta';
        }
        field(5; "ID Equipo"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'ID Equipo';
        }
        field(6; Procesado; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Procesado';
        }
        field(7; "Full name"; Text[60])
        {
            Caption = 'Full name';
            CalcFormula = Lookup(Employee."Full Name" WHERE("No." = FIELD("Cod. Empleado")));
            FieldClass = FlowField;
        }
        field(8; "Job Title"; Text[60])
        {
            CalcFormula = Lookup(Employee."Job Title" WHERE("No." = FIELD("Cod. Empleado")));
            Caption = 'Job Title';
            FieldClass = FlowField;
        }
        field(9; "Job No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job No.';
            TableRelation = Job;

            trigger OnValidate()
            begin
                IF "Job No." = '' THEN BEGIN
                    VALIDATE("Job Task No.", '');
                END;

                Job.GET("Job No.");
                Job.TestBlocked;
                Job.TESTFIELD("Bill-to Customer No.");
                Cust.GET(Job."Bill-to Customer No.");
                VALIDATE("Job Task No.", '');
            end;
        }
        field(10; "Job Task No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Job No."));

            trigger OnValidate()
            var
                JobTask: Record 1001;
            begin
                TESTFIELD("Job No.");
                IF "Job Task No." <> '' THEN BEGIN
                    JobTask.GET("Job No.", "Job Task No.");
                    JobTask.TESTFIELD("Job Task Type", JobTask."Job Task Type"::Posting);
                END;
            end;
        }
    }

    keys
    {
        key(Key1; "Cod. Empleado", "Fecha registro", "Hora registro")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Job: Record 167;
        Cust: Record 18;
}

