table 34002197 "Cab. Prestamos cooperativa"
{
    Caption = 'Cooperative loan header';
    DrillDownPageID = 55779;
    LookupPageID = 55779;

    fields
    {
        field(1; "No. Prestamo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Prestamo';

            trigger OnValidate()
            begin

                IF "No. Prestamo" <> xRec."No. Prestamo" THEN BEGIN
                    ConfNominas.GET;
                    ConfNominas.TESTFIELD("No. serie Sol. Prest. Coop.");
                    NoSeriesMgt.TestManual(ConfNominas."No. serie Sol. Prest. Coop.");
                END;
            end;
        }
        field(2; "Employee No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = "Miembros cooperativa";

            trigger OnValidate()
            begin
                Employee.GET("Employee No.");
                Miembroscooperativa.GET("Employee No.");
                "Tipo de miembro" := Miembroscooperativa."Tipo de miembro";
            end;
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
            TableRelation = "Datos adicionales RRHH".Code WHERE("Tipo registro" = CONST("Tipo de Prestamo"));
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
            MaxValue = 100;
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
    }

    keys
    {
        key(Key1; "No. Prestamo")
        {
        }
        key(Key2; "Employee No.", "No. Prestamo")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "No. Prestamo" = '' THEN BEGIN
            ConfNominas.GET;
            ConfNominas.TESTFIELD("No. serie Sol. Prest. Coop.");
            "No. Prestamo" := NoSeriesMgt.GetNextNo(ConfNominas."No. serie Sol. Prest. Coop.");
        END;
    end;

    var
        ConfNominas: Record 55744;
        Miembroscooperativa: Record 34002195;
        Employee: Record 5200;
        NoSeriesMgt: Codeunit "No. Series";

    [Scope('Personalization')]
    procedure AssistEdit(): Boolean
    var
        NoSeriesCode: Code[20];
    begin
        ConfNominas.Get();
        ConfNominas.TestField("No. serie Sol. Prest. Coop.");

        if NoSeriesMgt.LookupRelatedNoSeries(
             ConfNominas."No. serie Sol. Prest. Coop.",
             ConfNominas."No. serie Sol. Prest. Coop.",
             NoSeriesCode)
        then begin
            "No. Prestamo" := NoSeriesMgt.GetNextNo(NoSeriesCode);
            exit(true);
        end;

        exit(false);
    end;
}

