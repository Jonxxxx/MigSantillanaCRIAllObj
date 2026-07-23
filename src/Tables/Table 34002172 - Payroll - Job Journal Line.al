table 34002172 "Payroll - Job Journal Line"
{
    Caption = 'Payroll - Job Journal';

    fields
    {
        field(1; "Journal Template Name"; Code[20])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Payroll - Job Journal Template";
        }
        field(2; "Journal Batch Name"; Code[20])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Payroll - Job Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(3; "Line no."; Integer)
        {
        }
        field(4; "No. empleado"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                Empleados.GET("No. empleado");
                Empleados.TESTFIELD("Resource No.");
                Empleados.TESTFIELD("Distribuir salario en proyecto", FALSE);

                "Apellidos y Nombre" := Empleados."Full Name";
                "Puesto trabajo" := Empleados."Job Type Code";

                VALIDATE("Resource No.", Empleados."Resource No.");
            end;
        }
        field(5; "Posting Date"; Date)
        {
            Caption = 'Posting Date';

            trigger OnValidate()
            begin
                //Busco la tarifa para esa operacion
                //VALIDATE(Operacion);
            end;
        }
        field(6; "Puesto trabajo"; Code[20])
        {
            Editable = false;
        }
        field(7; "Apellidos y Nombre"; Text[60])
        {
            Editable = false;
        }
        field(8; "Job No."; Code[20])
        {
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
        field(9; "Job Task No."; Code[20])
        {
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
        field(10; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            TableRelation = Resource;

            trigger OnValidate()
            begin
                Res.GET("Resource No.");
                "Unit of Measure Code" := Res."Base Unit of Measure";
            end;
        }
        field(11; "Unit of Measure Code"; Code[20])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Unit of Measure";

            trigger OnLookup()
            var
                ItemUnitOfMeasure: Record 5404;
                ResourceUnitOfMeasure: Record 205;
                UnitOfMeasure: Record 204;
                Resource: Record 156;
                "Filter": Text;
            begin
            end;

            trigger OnValidate()
            var
                Resource: Record 156;
            begin
            end;
        }
        field(12; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(13; "Job Task Name"; Text[60])
        {
            Caption = 'Job Task Name';
            Editable = false;
        }
        field(14; "Concepto salarial"; Code[20])
        {
            TableRelation = "Conceptos salariales";

            trigger OnValidate()
            var
                ConceptoSal: Record 34002111;
            begin
                ConceptoSal.GET("Concepto salarial");
                "Tipo concepto" := ConceptoSal."Tipo concepto";
            end;
        }
        field(15; "Tipo concepto"; Option)
        {
            Description = 'Ingresos,Deducciones';
            Editable = false;
            OptionMembers = Ingresos,Deducciones;
        }
        field(16; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            begin
                Amount := "Precio Costo" * Quantity;
            end;
        }
        field(17; Amount; Decimal)
        {
            Caption = 'Amount';
            DecimalPlaces = 2 : 2;
            Editable = false;

            trigger OnValidate()
            begin
                "Precio Costo" := Amount / Quantity;
            end;
        }
        field(18; "Tipo Tarifa"; Option)
        {
            Caption = 'Working type';
            Description = 'Precio fijo,Precio variable';
            Editable = false;
            OptionMembers = "Precio fijo","Precio variable";
        }
        field(19; "Precio Costo"; Decimal)
        {
            Editable = false;

            trigger OnValidate()
            begin
                VALIDATE(Quantity);
            end;
        }
        field(20; "Inicio Periodo"; Date)
        {

            trigger OnValidate()
            begin
                "Fin Periodo" := CALCDATE('PM', "Fin Periodo");
            end;
        }
        field(21; "Fin Periodo"; Date)
        {
        }
        field(22; "Work Type Code"; Code[20])
        {
            Caption = 'Work Type Code';
            TableRelation = "Resource Cost"."Work Type Code" WHERE(Type = CONST(Resource),
                                                                    Code = FIELD("Resource No."));

            trigger OnValidate()
            var
                ResPrices: Record 202;
            begin
                IF ("Work Type Code" = '') AND (xRec."Work Type Code" <> '') THEN BEGIN
                    Res.GET("Resource No.");
                    "Unit of Measure Code" := Res."Base Unit of Measure";
                    VALIDATE("Unit of Measure Code");
                    "Gen. Prod. Posting Group" := Res."Gen. Prod. Posting Group";
                END;

                IF WorkType.GET("Work Type Code") THEN BEGIN
                    ResPrices.RESET;
                    ResPrices.SETRANGE(Type, 0); // Resource
                    ResPrices.SETRANGE(Code, "Resource No.");
                    ResPrices.SETRANGE("Work Type Code", "Work Type Code");
                    ResPrices.FINDFIRST;

                    IF WorkType."Unit of Measure Code" <> '' THEN BEGIN
                        "Unit of Measure Code" := WorkType."Unit of Measure Code";
                        IF ResUnitofMeasure.GET("Resource No.", "Unit of Measure Code") THEN
                            "Qty. per Unit of Measure" := ResUnitofMeasure."Qty. per Unit of Measure";
                    END
                    ELSE BEGIN
                        Res.GET("Resource No.");
                        "Unit of Measure Code" := Res."Base Unit of Measure";
                        VALIDATE("Unit of Measure Code");
                        "Gen. Prod. Posting Group" := Res."Gen. Prod. Posting Group";
                    END;

                    VALIDATE("Precio Costo", ResPrices."Direct Unit Cost");
                END;
            end;
        }
        field(23; "Document No."; Code[20])
        {
        }
        field(24; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(25; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
    }

    keys
    {
        key(Key1; "Journal Template Name", "Journal Batch Name", "Line no.")
        {
        }
        key(Key2; "Journal Template Name", "Journal Batch Name", "No. empleado")
        {
        }
        key(Key3; "Journal Template Name", "Journal Batch Name", "Posting Date", "No. empleado")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Job: Record 167;
        Cust: Record 18;
        Res: Record 156;
        ResUnitofMeasure: Record 205;
        Empresa: Record 34002100;
        Empleados: Record 5200;
        WorkType: Record 200;
        DimMgt: Codeunit 408;
}

