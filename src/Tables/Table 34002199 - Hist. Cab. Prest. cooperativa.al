table 34002199 "Hist. Cab. Prest. cooperativa"
{
    Caption = 'Cooperative loan header';
    DrillDownPageID = 34002222;
    LookupPageID = 34002222;

    fields
    {
        field(1; "No. Prestamo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Prestamo';

            trigger OnValidate()
            var
                NoSeries: Codeunit "No. Series";
            begin
                ConfNominas.Get();

                if "No. Prestamo" = '' then begin
                    ConfNominas.TestField("No. serie reg. CxC");
                    "No. Prestamo" := NoSeries.GetNextNo(ConfNominas."No. serie reg. CxC");
                end;
            end;
        }
        field(2; "Employee No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Employee;
        }
        field(3; "No. afiliado"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'No. afiliado';
            Enabled = false;
        }
        field(4; "Tipo de miembro"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de miembro';
            OptionCaption = 'Member, Partner';
            OptionMembers = Miembro,Socio;
        }
        field(5; "Tipo prestamo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo prestamo';
            TableRelation = "Datos adicionales RRHH" WHERE("Tipo registro" = CONST("Tipo de Prestamo"));
        }
        field(6; Importe; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe';
            DecimalPlaces = 2 : 2;
        }
        field(7; "% Interes"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = '% Interes';
        }
        field(8; "Cantidad de Cuotas"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad de Cuotas';
        }
        field(9; "Fecha Inicio Deduccion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Inicio Deduccion';
        }
        field(10; "1ra Quincena"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = '1ra Quincena';
        }
        field(11; "2da Quincena"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = '2da Quincena';
        }
        field(12; "Motivo Prestamo"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Motivo Prestamo';
        }
        field(13; "Full name"; Text[150])
        {
            CalcFormula = Lookup(Employee."Full Name" WHERE("No." = FIELD("Employee No.")));
            Caption = 'Full name';
            FieldClass = FlowField;
        }
        field(14; "Concepto Salarial"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto Salarial';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(15; "Importe Pendiente"; Decimal)
        {
            Caption = 'Importe Pendiente';
            CalcFormula = Sum("Mov. cooperativa".Importe WHERE("No. documento" = FIELD("No. Prestamo"),
                                                                "Tipo transaccion" = FILTER(> Aporte)));
            DecimalPlaces = 2 : 2;
            FieldClass = FlowField;
        }
        field(16; Pendiente; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Pendiente';
            Editable = true;
        }
        field(17; "Motivo de cierre"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Motivo de cierre';
        }
        field(18; "No. Solicitud prestamo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Solicitud prestamo';
        }
        field(25; Status; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionCaption = 'Active,Paused,Completed';
            OptionMembers = Activo,Pausado,Completado;
        }
        field(26; "Fecha de pausa"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha de pausa';
        }
    }

    keys
    {
        key(Key1; "No. Prestamo")
        {
        }
        key(Key2; "Employee No.", "No. Prestamo")
        {
        }
        key(Key3; "Employee No.", "Fecha Inicio Deduccion")
        {
        }
    }

    fieldgroups
    {
    }

    var
        ConfNominas: Record 34002103;
        GestNoSerie: Codeunit "No. Series";
}

