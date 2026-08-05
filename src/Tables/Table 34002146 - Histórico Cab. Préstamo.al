table 55787 "Historico Cab. Prestamo"
{
    DrillDownPageID = 55779;
    LookupPageID = 55779;

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
        field(3; "Fecha Registro CxC"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Registro CxC';
        }
        field(4; "Tipo CxC"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo CxC';
            Description = ' ,Prestamo,Factura';
            OptionMembers = " ","Prestamo",Factura;
        }
        field(5; "Importe Original"; Decimal)
        {
            Caption = 'Importe Original';
            CalcFormula = Sum("Historico Lin. Prestamo".Debito WHERE("No. Prestamo" = FIELD("No. Prestamo")));
            DecimalPlaces = 2 : 2;
            FieldClass = FlowField;
        }
        field(6; Cuotas; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cuotas';
        }
        field(7; "No. Documento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Documento';
        }
        field(8; Pendiente; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Pendiente';
            Editable = true;
        }
        field(9; "Tipo Contrapartida"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Contrapartida';
            Description = 'Cuenta,Cliente,Proveedor,Banco';
            OptionMembers = Cuenta,Cliente,Proveedor,Banco;
        }
        field(10; "Cta. Contrapartida"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cta. Contrapartida';
        }
        field(11; "Fecha Inicio Deduccion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Inicio Deduccion';
        }
        field(12; "Nro. Solicitud CK"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Nro. Solicitud CK';
        }
        field(13; "Importe Pendiente Cte."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Pendiente Cte.';
            DecimalPlaces = 2 : 2;
        }
        field(14; "% Cuota"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = '% Cuota';
        }
        field(15; "No. Mov. Cliente"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Mov. Cliente';
        }
        field(16; "Importe Pendiente"; Decimal)
        {
            Caption = 'Importe Pendiente';
            CalcFormula = Sum("Historico Lin. Prestamo".Importe WHERE("No. Prestamo" = FIELD("No. Prestamo")));
            DecimalPlaces = 2 : 2;
            FieldClass = FlowField;
        }
        field(17; "1ra Quincena"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = '1ra Quincena';
        }
        field(18; "2da Quincena"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = '2da Quincena';
        }
        field(19; "Importe Cuota"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Cuota';
        }
        field(20; "Concepto Salarial"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto Salarial';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(21; "Motivo Prestamos"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Motivo Prestamos';
        }
        field(22; Correccion; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Correccion';
        }
        field(23; "Full name"; Text[150])
        {
            Caption = 'Full name';
            CalcFormula = Lookup(Employee."Full Name" WHERE("No." = FIELD("Employee No.")));
            FieldClass = FlowField;
        }
        field(24; "Motivo de cierre"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Motivo de cierre';
        }
    }

    keys
    {
        key(Key1; "No. Prestamo")
        {
        }
        key(Key2; "Employee No.", Pendiente)
        {
        }
        key(Key3; "Employee No.", "No. Prestamo")
        {
        }
    }

    fieldgroups
    {
    }

    var
        ConfNominas: Record 55744;
        GestNoSerie: Codeunit "No. Series";
}

