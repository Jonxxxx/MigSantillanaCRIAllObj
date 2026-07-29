table 34002145 "CxC Empleados"
{
    //IGNORAR: Page no existe DrillDownPageID = 58102;
    //IGNORAR: Page no existe LookupPageID = 58102;

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
                    GestNoSerie.TestManual(TraeCodNoSerie);
                    "No. Prestamo" := '';
                END;
            end;
        }
        field(2; "Codigo Empleado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Empleado';
            TableRelation = Employee WHERE("Calcular Nomina" = CONST(True));

            trigger OnValidate()
            begin
                Empl.GET("Codigo Empleado");
                IF Empl."Termination Date" <> 0D THEN
                    ERROR(Err002, "Codigo Empleado");
            end;
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
        field(5; Importe; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe';
            DecimalPlaces = 2 : 2;
        }
        field(6; Cuotas; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cuotas';

            trigger OnValidate()
            begin
                IF "% a deducir de Ingresos" <> 0 THEN
                    ERROR(Err004);

                "Importe Cuota" := ROUND(Importe / Cuotas, 0.01);
            end;
        }
        field(7; "No. Documento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Documento';

            trigger OnLookup()
            begin

                Empl.GET("Codigo Empleado");
                //IF "Tipo CxC" = "Tipo CxC"::Factura THEN
                //   BEGIN
                Empl.TESTFIELD("Codigo Cliente");
                CLE.SETCURRENTKEY("Customer No.", Open, Positive, "Due Date", "Currency Code");
                CLE.SETRANGE("Customer No.", Empl."Codigo Cliente");
                CLE.SETRANGE(Open, TRUE);
                IF CLE.FINDFIRST THEN BEGIN
                    LiqMovsClientes.LOOKUPMODE(TRUE);
                    LiqMovsClientes.SETTABLEVIEW(CLE);
                    LiqMovsClientes.SETRECORD(CLE);
                    IF LiqMovsClientes.RUNMODAL = ACTION::LookupOK THEN BEGIN
                        LiqMovsClientes.GetCustLedgEntry(CLE);
                        "No. Documento" := CLE."Document No.";
                        Importe := CLE."Remaining Amount";
                        "No. Mov. Cliente" := CLE."Entry No.";
                    END;
                END;
                //   END;

                CLEAR(LiqMovsClientes);
            end;
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

            trigger OnValidate()
            begin
                CASE "Tipo Contrapartida" OF
                    "Tipo Contrapartida"::Cliente:
                        BEGIN
                            Empl.GET("Codigo Empleado");
                            "Cta. Contrapartida" := Empl."Codigo Cliente";
                        END;
                END;
            end;
        }
        field(10; "Cta. Contrapartida"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cta. Contrapartida';
            TableRelation = IF ("Tipo Contrapartida" = CONST(Cuenta)) "G/L Account"
            ELSE IF ("Tipo Contrapartida" = CONST(Cliente)) Customer
            ELSE IF ("Tipo Contrapartida" = CONST(Proveedor)) Vendor
            ELSE IF ("Tipo Contrapartida" = CONST(Banco)) "Bank Account";

            trigger OnValidate()
            begin
                IF "Cta. Contrapartida" = '' THEN
                    EXIT;

                CASE "Tipo Contrapartida" OF
                    "Tipo Contrapartida"::Cuenta:
                        CGCta.GET("Cta. Contrapartida");
                    "Tipo Contrapartida"::Cliente:
                        BEGIN
                            Clie.GET("Cta. Contrapartida");
                            Clie.TESTFIELD(Blocked, 0);
                        END;
                    "Tipo Contrapartida"::Proveedor:
                        BEGIN
                            Prov.GET("Cta. Contrapartida");
                            Prov.TESTFIELD(Blocked, 0);
                        END;
                END;
            end;
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
            FieldClass = Normal;
        }
        field(14; "% a deducir de Ingresos"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = '% a deducir de Ingresos';

            trigger OnValidate()
            begin
                IF Cuotas <> 0 THEN
                    ERROR(Err003);
            end;
        }
        field(15; "No. Mov. Cliente"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Mov. Cliente';
        }
        field(16; "Concepto Salarial"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto Salarial';
            TableRelation = "Conceptos salariales".Codigo;
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
        field(20; "Motivo Prestamos"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Motivo Prestamos';
        }
        field(21; "Full name"; Text[150])
        {
            Caption = 'Full name';
            CalcFormula = Lookup(Employee."Full Name" WHERE("No." = FIELD("Codigo Empleado")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No. Prestamo")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        NoSeries: Codeunit "No. Series";
    begin
        ConfNominas.Get();

        if "No. Prestamo" = '' then begin
            ConfNominas.TestField("No. serie CxC");
            "No. Prestamo" := NoSeries.GetNextNo(ConfNominas."No. serie CxC");
        end;

        Pendiente := true;
    end;

    var
        Empl: Record 5200;
        CLE: Record 21;
        LinEsqPercep: Record 34002115;
        LiqMovsClientes: Page 232;
        CGCta: Record 15;
        Clie: Record 18;
        Prov: Record 23;
        ConfNominas: Record 34002103;
        GestNoSerie: Codeunit "No. Series";
        Err001: Label 'You must specify as Balance Account a Bank or Vendor';
        Err002: Label 'You can''t do loans to this employee, %1 is already out of the company';
        Err003: Label 'You can''t specify Loan payment when Discount % is used';
        Err004: Label 'You can''t specify  Discount % when Loan paymen is used';

    procedure AsistEdic(CxCEmpleadosAnt: Record 34002145): Boolean
    begin
        ConfNominas.GET;
        TestNoSerie;

        /*
        IF GestNoSerie.SelectSeries(TraeCodNoSerie, CxCEmpleadosAnt."No. Prestamo", "No. Prestamo") THEN BEGIN
            ConfNominas.GET;
            TestNoSerie;
            GestNoSerie.SetSeries("No. Prestamo");
            EXIT(TRUE);
        END;
        */
    end;

    local procedure TestNoSerie(): Boolean
    begin
        CASE "Tipo CxC" OF
            "Tipo CxC"::Prestamo:
                ConfNominas.TESTFIELD("No. serie CxC");
        END;
    end;

    local procedure TraeCodNoSerie(): Code[10]
    begin
        CASE "Tipo CxC" OF
            "Tipo CxC"::Prestamo:
                EXIT(ConfNominas."No. serie CxC");
        END;
    end;
}

