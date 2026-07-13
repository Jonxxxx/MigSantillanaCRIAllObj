table 56101 "Contratos Bck"
{
    Caption = 'Contratos Bck';

    fields
    {
        field(1; "Empresa cotizaci n"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "No. empleado"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(3; "No. Orden"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "C d. contrato"; Code[5])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Employment Contract";
        }
        field(5; Disponible; Code[12])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(6; "Descripcion"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Fecha inicio"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Duraci n"; Text[30])
        {
            DataClassification = ToBeClassified;
            DateFormula = true;
        }
        field(9; "Fecha finalizaci n"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Cargo; Code[15])
        {
            DataClassification = ToBeClassified;
            //TODO: Ver TableRelation = "Puestos laborales";
        }
        field(11; "Centro trabajo"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Motivo baja"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Grounds for Termination";
        }
        field(21; Finalizado; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "D as preaviso"; Text[30])
        {
            DataClassification = ToBeClassified;
            DateFormula = true;
            InitValue = '15D';
        }
        field(23; "Per odo prueba"; Text[30])
        {
            DataClassification = ToBeClassified;
            DateFormula = true;
        }
        field(33; Jornada; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Tipo Pago Nomina"; Option)
        {
            Caption = 'Payroll payment type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Daily,Weekly,Bi-Weekly,Half Month,Monthly,Yearly';
            OptionMembers = Diaria,Semanal,"Bi-Semanal",Quincenal,Mensual,Anual;
        }
        field(39; "D as semana"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(40; "Horas dia"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(41; "Horas semana"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(50; "Causa de la Baja"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(61; Indefinido; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(62; Activo; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63; "Grado ocupacion"; Decimal)
        {
            Caption = 'Grado ocupaci n';
            DataClassification = ToBeClassified;
            Description = 'MdE';
            MaxValue = 100;
            MinValue = 0;
        }
        field(50000; "Fecha eliminaci n"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Usuario eliminaci n"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No. empleado", "No. Orden")
        {
        }
    }

    fieldgroups
    {
    }
}

