table 56101 "Contratos Bck"
{
    Caption = 'Contratos Bck';

    fields
    {
        field(1; "Empresa cotizaci n"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Empresa cotizaci n';
        }
        field(2; "No. empleado"; Code[15])
        {
            DataClassification = CustomerContent;
            Caption = 'No. empleado';
            TableRelation = Employee;
        }
        field(3; "No. Orden"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Orden';
        }
        field(4; "C d. contrato"; Code[5])
        {
            DataClassification = CustomerContent;
            Caption = 'C d. contrato';
            NotBlank = true;
            TableRelation = "Employment Contract";
        }
        field(5; Disponible; Code[12])
        {
            DataClassification = CustomerContent;
            Caption = 'Disponible';
            Enabled = false;
        }
        field(6; "Descripcion"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(7; "Fecha inicio"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha inicio';
        }
        field(8; "Duraci n"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Duraci n';
            DateFormula = true;
        }
        field(9; "Fecha finalizaci n"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha finalizaci n';
        }
        field(10; Cargo; Code[15])
        {
            DataClassification = CustomerContent;
            Caption = 'Cargo';
            TableRelation = "Puestos laborales";
        }
        field(11; "Centro trabajo"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Centro trabajo';
        }
        field(12; "Motivo baja"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Motivo baja';
            TableRelation = "Grounds for Termination";
        }
        field(21; Finalizado; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Finalizado';
        }
        field(22; "D as preaviso"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'D as preaviso';
            DateFormula = true;
            InitValue = '15D';
        }
        field(23; "Per odo prueba"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Per odo prueba';
            DateFormula = true;
        }
        field(33; Jornada; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Jornada';
        }
        field(34; "Tipo Pago Nomina"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Pago Nomina';
            OptionCaption = 'Daily,Weekly,Bi-Weekly,Half Month,Monthly,Yearly';
            OptionMembers = Diaria,Semanal,"Bi-Semanal",Quincenal,Mensual,Anual;
        }
        field(39; "D as semana"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'D as semana';
            DecimalPlaces = 2 : 2;
        }
        field(40; "Horas dia"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Horas dia';
            DecimalPlaces = 2 : 2;
        }
        field(41; "Horas semana"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Horas semana';
            DecimalPlaces = 2 : 2;
        }
        field(50; "Causa de la Baja"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Causa de la Baja';
        }
        field(61; Indefinido; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Indefinido';
        }
        field(62; Activo; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Activo';
        }
        field(63; "Grado ocupacion"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Grado ocupacion';
            Description = 'MdE';
            MaxValue = 100;
            MinValue = 0;
        }
        field(50000; "Fecha eliminaci n"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha eliminaci n';
        }
        field(50001; "Usuario eliminaci n"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Usuario eliminaci n';
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

