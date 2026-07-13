table 34002197 "Cab. Prestamos cooperativa"
{
    Caption = 'Cooperative loan header';
    //TODO: Ver DrillDownPageID = 34002138;
    //TODO: Ver LookupPageID = 34002138;

    fields
    {
        field(1; "No. Prestamo"; Code[20])
        {
            Caption = 'Loan no.';

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
            Caption = 'Affiliate code';
            Enabled = false;
        }
        field(4; "Tipo de miembro"; Option)
        {
            Caption = 'Member type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Member, Partner';
            OptionMembers = Miembro,Socio;
        }
        field(5; "Tipo prestamo"; Code[20])
        {
            Caption = 'Loan type';
            TableRelation = "Datos adicionales RRHH".Code WHERE(Tipo registro=CONST(Tipo de préstamo));
        }
        field(6; Importe; Decimal)
        {
            Caption = 'Amount';
            DecimalPlaces = 2 : 2;
        }
        field(7; "% Interes"; Decimal)
        {
            Caption = 'Interest rate';
            MaxValue = 100;
        }
        field(8; "Cantidad de Cuotas"; Integer)
        {
            Caption = 'Fees quantities';
        }
        field(9; "Fecha Inicio Deduccion"; Date)
        {
            Caption = 'Deduction Start Date';
        }
        field(10; "1ra Quincena"; Boolean)
        {
            Caption = '1st half';
        }
        field(11; "2da Quincena"; Boolean)
        {
            Caption = '2nd half';
        }
        field(12; "Motivo Prestamo"; Text[60])
        {
            Caption = 'Reason for loan';
        }
        field(13; "Full name"; Text[150])
        {
            CalcFormula = Lookup(Employee."Full Name" WHERE(No.=FIELD(Employee No.)));
            Caption = 'Full name';
            FieldClass = FlowField;
        }
        field(14;"Concepto Salarial";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Conceptos salariales".Código;
        }
    }

    keys
    {
        key(Key1;"No. Prestamo")
        {
        }
        key(Key2;"Employee No.","No. Prestamo")
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
          NoSeriesMgt.InitSeries(ConfNominas."No. serie Sol. Prest. Coop.",ConfNominas."No. serie Sol. Prest. Coop.",0D,"No. Prestamo",ConfNominas."No. serie Sol. Prest. Coop.");
        END;
    end;

    var
        ConfNominas: Record "34002103";
        Miembroscooperativa: Record "34002195";
        Employee: Record "5200";
        NoSeriesMgt: Codeunit "396";

    [Scope('Personalization')]
    procedure AssistEdit(): Boolean
    begin
        ConfNominas.GET;
        ConfNominas.TESTFIELD("No. serie Sol. Prest. Coop.");
        IF NoSeriesMgt.SelectSeries(ConfNominas."No. serie Sol. Prest. Coop.",ConfNominas."No. serie Sol. Prest. Coop.",ConfNominas."No. serie Sol. Prest. Coop.") THEN BEGIN
          NoSeriesMgt.SetSeries("No. Prestamo");
          EXIT(TRUE);
        END;
    end;
}

