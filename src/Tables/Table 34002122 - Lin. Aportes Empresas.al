table 34002122 "Lin. Aportes Empresas"
{

    fields
    {
        field(1; "No. Documento"; Code[20])
        {
        }
        field(2; "Empresa cotización"; Code[20])
        {
        }
        field(3; "Período"; Date)
        {
        }
        field(4; "No. Empleado"; Code[20])
        {
        }
        field(5; "Concepto Salarial"; Code[20])
        {
            TableRelation = "Conceptos salariales".Código;
        }
        field(6; "No. orden"; Integer)
        {
        }
        field(7; Descripcion; Text[50])
        {
        }
        field(8; "% Cotizable"; Decimal)
        {
        }
        field(9; "Base Imponible"; Decimal)
        {
        }
        field(10; Importe; Decimal)
        {
        }
        field(11; "Apellidos y Nombre"; Text[100])
        {
            //TODO: Ver CalcFormula = Lookup(Employee."Full Name" WHERE("No." = FIELD("No. Empleado")));
            FieldClass = FlowField;
        }
        field(12; "Tipo Nomina"; Option)
        {
            Description = 'Normal,Regalía,Bonificación';
            OptionCaption = 'Regular,Christmas,Bonus,Tip,Rent';
            OptionMembers = Normal,"Regalía","Bonificación",Propina,Renta;
        }
        field(13; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            DataClassification = ToBeClassified;
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
            Caption = 'Payroll type';
            DataClassification = ToBeClassified;
            TableRelation = "Tipos de nominas";
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
    }

    keys
    {
        key(Key1; "Período", "Tipo de nomina", "No. Empleado", "Job No.", "No. orden")
        {
        }
        key(Key2; "No. Documento", "Empresa cotización", "Período", "No. Empleado", "Concepto Salarial", "No. orden")
        {
        }
        key(Key3; "No. Empleado", "Período", "Concepto Salarial")
        {
            SumIndexFields = Importe;
        }
    }

    fieldgroups
    {
    }

    var
    //TODO: Ver DimMgt: Codeunit 408;

    procedure ShowDimensions()
    begin
        TESTFIELD("No. orden");
        //TODO: Ver DimMgt.ShowDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2 %3', TABLECAPTION, "No. Documento", "No. Empleado"));
    end;
}

