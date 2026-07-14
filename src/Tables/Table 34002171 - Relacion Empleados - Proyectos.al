table 34002171 "Relacion Empleados - Proyectos"
{

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                //TODO: Ver IF Employee.GET("Employee No.") THEN
                //TODO: Ver     "Full name" := Employee."Full Name";
            end;
        }
        field(2; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;

            trigger OnValidate()
            var
                Job: Record 167;
            begin
            end;
        }
        field(3; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Job No."));
        }
        field(4; "Job Line Type"; Option)
        {
            Caption = 'Job Line Type';
            OptionCaption = ' ,Schedule,Contract,Both Schedule and Contract';
            OptionMembers = " ",Schedule,Contract,"Both Schedule and Contract";
        }
        field(5; "Job Unit Price"; Decimal)
        {
            BlankZero = true;
            Caption = 'Job Unit Price';
        }
        field(6; "Job Description"; Text[60])
        {
            CalcFormula = Lookup(Job.Description WHERE("No." = FIELD("Job No.")));
            Caption = 'Job Description';
            FieldClass = FlowField;
        }
        field(7; "Job Task Name"; Text[60])
        {
            //TODO: Ver CalcFormula = Lookup("Job Task".Description WHERE("Job No." = FIELD("Job No."),
            //TODO: Ver                                                   "Task No." = FIELD("Job Task No.")));
            Caption = 'Job Task No.';
            FieldClass = FlowField;
        }
        field(8; "% to distribute"; Decimal)
        {
            Caption = '% to distribute';

            trigger OnValidate()
            var
                RelEmp_Job: Record 34002171;
                TotDistrib: Decimal;
            begin
                TotDistrib := 0;

                RelEmp_Job.RESET;
                RelEmp_Job.SETRANGE("Employee No.", "Employee No.");
                RelEmp_Job.SETFILTER("Job No.", '<>%1', "Job No.");
                IF RelEmp_Job.FINDSET THEN
                    REPEAT
                        TotDistrib += RelEmp_Job."% to distribute";
                    UNTIL RelEmp_Job.NEXT = 0;

                TotDistrib += "% to distribute";

                IF TotDistrib > 100 THEN
                    ERROR(STRSUBSTNO(Err001, FIELDCAPTION("% to distribute")));
            end;
        }
        field(9; "Concepto salarial"; Code[20])
        {
            Caption = 'Wage Code';
            TableRelation = "Conceptos salariales".Codigo;

            trigger OnValidate()
            begin
                IF ConcepSalar.GET("Concepto salarial") THEN
                    "Descripcion concepto" := ConcepSalar.Descripcion;
            end;
        }
        field(10; Precio; Decimal)
        {
            Caption = 'Unit price';
        }
        field(11; "Full name"; Text[60])
        {
            //TODO: Ver CalcFormula = Lookup(Employee."Full Name" WHERE("No." = FIELD("Employee No.")));
            Caption = 'Full name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Descripcion concepto"; Text[60])
        {
            Caption = 'Wage description';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Job No.", "Job Task No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        PerfilSalario.RESET;
        PerfilSalario.SETRANGE("No. empleado", "Employee No.");
        PerfilSalario.SETRANGE("Salario Base", TRUE);
        IF PerfilSalario.FINDFIRST THEN
            "Job Unit Price" := PerfilSalario.Importe;
    end;

    var
        PerfilSalario: Record 34002115;
        Err001: Label 'The top value allowed must be 100 for the %1';
        Employee: Record 5200;
        ConcepSalar: Record 34002111;
}

