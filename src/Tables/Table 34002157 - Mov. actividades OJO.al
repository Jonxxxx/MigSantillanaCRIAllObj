table 55798 "Mov. actividades OJO"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
        }
        field(4; "No. empleado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. empleado';
            TableRelation = Employee;
        }
        field(5; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Date';
        }
        field(6; "Puesto trabajo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Puesto trabajo';
        }
        field(7; "Apellidos y Nombre"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Apellidos y Nombre';
            Editable = false;
        }
        field(8; "Job No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(9; "Job Task No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Job No."));

            trigger OnValidate()
            var
                JobTask: Record 1001;
            begin
            end;
        }
        field(10; "Resource No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Resource No.';
            TableRelation = Resource;
        }
        field(11; "Unit of Measure Code"; Code[20])
        {
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(13; "Job Task Name"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Task Name';
            Editable = false;
        }
        field(14; "Concepto salarial"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto salarial';
            TableRelation = "Conceptos salariales";

            trigger OnValidate()
            var
                ConceptoSal: Record 55752;
            begin
            end;
        }
        field(15; "Tipo concepto"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo concepto';
            Description = 'Ingresos,Deducciones';
            Editable = false;
            OptionMembers = Ingresos,Deducciones;
        }
        field(16; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity';
            DecimalPlaces = 2 : 2;
        }
        field(17; Amount; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
            DecimalPlaces = 2 : 2;
        }
        field(18; "Tipo Tarifa"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Tarifa';
            Description = 'Precio fijo,Precio variable';
            Editable = false;
            OptionMembers = "Precio fijo","Precio variable";
        }
        field(19; "Precio Tarifa"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Precio Tarifa';
        }
        field(20; "Inicio Periodo"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Inicio Periodo';
        }
        field(21; "Fin Periodo"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fin Periodo';
        }
        field(22; "Work Type Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Work Type Code';
            TableRelation = "Work Type";
        }
        field(23; "Working Center"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Working Center';
        }
        field(24; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
        }
        field(25; "Gen. Bus. Posting Group"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(26; "Gen. Prod. Posting Group"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Job No.", "Job Task No.", "No. empleado", "Working Center", "Posting Date")
        {
        }
    }

    fieldgroups
    {
    }
}

