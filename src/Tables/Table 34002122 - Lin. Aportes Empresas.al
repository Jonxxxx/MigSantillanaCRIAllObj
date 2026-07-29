table 34002122 "Lin. Aportes Empresas"
{

    fields
    {
        field(1; "No. Documento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Documento';
        }
        field(2; "Empresa cotizacion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Empresa cotizacion';
        }
        field(3; "Periodo"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Periodo';
        }
        field(4; "No. Empleado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Empleado';
        }
        field(5; "Concepto Salarial"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto Salarial';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(6; "No. orden"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. orden';
        }
        field(7; Descripcion; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(8; "% Cotizable"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = '% Cotizable';
        }
        field(9; "Base Imponible"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Base Imponible';
        }
        field(10; Importe; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe';
        }
        field(11; "Apellidos y Nombre"; Text[100])
        {
            Caption = 'Apellidos y Nombre';
            CalcFormula = Lookup(Employee."Full Name" WHERE("No." = FIELD("No. Empleado")));
            FieldClass = FlowField;
        }
        field(12; "Tipo Nomina"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Nomina';
            Description = 'Normal,Regalia,Bonificacion';
            OptionCaption = 'Regular,Christmas,Bonus,Tip,Rent';
            OptionMembers = Normal,"Regalia","Bonificacion",Propina,Renta;
        }
        field(13; "Job No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job No.';
            TableRelation = Job;

            trigger OnValidate()
            var
                Job: Record 167;
                Cust: Record 18;
            begin
            end;
        }
        field(14; "Tipo de nomina"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de nomina';
            TableRelation = "Tipos de nominas";
        }
        field(480; "Dimension Set ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
    }

    keys
    {
        key(Key1; "Periodo", "Tipo de nomina", "No. Empleado", "Job No.", "No. orden")
        {
        }
        key(Key2; "No. Documento", "Empresa cotizacion", "Periodo", "No. Empleado", "Concepto Salarial", "No. orden")
        {
        }
        key(Key3; "No. Empleado", "Periodo", "Concepto Salarial")
        {
            SumIndexFields = Importe;
        }
    }

    fieldgroups
    {
    }

    var
        DimMgt: Codeunit 408;

    procedure ShowDimensions()
    begin
        TESTFIELD("No. orden");
        DimMgt.ShowDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2 %3', TABLECAPTION, "No. Documento", "No. Empleado"));
    end;
}

