table 34002145 "CxC Empleados"
{
    DrillDownPageID = 58102;
    //TODO: Ver LookupPageID = 58102;

    fields
    {
        field(1; "No. Préstamo"; Code[20])
        {

            trigger OnValidate()
            begin
                IF "No. Préstamo" <> xRec."No. Préstamo" THEN BEGIN
                    ConfNominas.GET;
                    GestNoSerie.TestManual(TraeCodNoSerie);
                    "No. Préstamo" := '';
                END;
            end;
        }
        field(2; "Codigo Empleado"; Code[20])
        {
            //TODO: Ver TableRelation = Employee WHERE("Calcular Nomina" = CONST(True));

            trigger OnValidate()
            begin
                Empl.GET("Codigo Empleado");
                IF Empl."Termination Date" <> 0D THEN
                    ERROR(Err002, "Codigo Empleado");
            end;
        }
        field(3; "Fecha Registro CxC"; Date)
        {
        }
        field(4; "Tipo CxC"; Option)
        {
            Description = ' ,Préstamo,Factura';
            OptionMembers = " ","Préstamo",Factura;
        }
        field(5; Importe; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(6; Cuotas; Integer)
        {

            trigger OnValidate()
            begin
                IF "% a deducir de Ingresos" <> 0 THEN
                    ERROR(Err004);

                "Importe Cuota" := ROUND(Importe / Cuotas, 0.01);
            end;
        }
        field(7; "No. Documento"; Code[20])
        {

            trigger OnLookup()
            begin

                Empl.GET("Codigo Empleado");
                //IF "Tipo CxC" = "Tipo CxC"::Factura THEN
                //   BEGIN
                //TODO: Ver Empl.TESTFIELD("Codigo Cliente");
                CLE.SETCURRENTKEY("Customer No.", Open, Positive, "Due Date", "Currency Code");
                //TODO: Ver CLE.SETRANGE("Customer No.", Empl."Codigo Cliente");
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
            Editable = true;
        }
        field(9; "Tipo Contrapartida"; Option)
        {
            Description = 'Cuenta,Cliente,Proveedor,Banco';
            OptionMembers = Cuenta,Cliente,Proveedor,Banco;

            trigger OnValidate()
            begin
                CASE "Tipo Contrapartida" OF
                    "Tipo Contrapartida"::Cliente:
                        BEGIN
                            Empl.GET("Codigo Empleado");
                            //TODO: Ver "Cta. Contrapartida" := Empl."Codigo Cliente";
                        END;
                END;
            end;
        }
        field(10; "Cta. Contrapartida"; Code[20])
        {
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
        }
        field(12; "Nro. Solicitud CK"; Code[20])
        {
        }
        field(13; "Importe Pendiente Cte."; Decimal)
        {
            FieldClass = Normal;
        }
        field(14; "% a deducir de Ingresos"; Decimal)
        {

            trigger OnValidate()
            begin
                IF Cuotas <> 0 THEN
                    ERROR(Err003);
            end;
        }
        field(15; "No. Mov. Cliente"; Integer)
        {
        }
        field(16; "Concepto Salarial"; Code[20])
        {
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(17; "1ra Quincena"; Boolean)
        {
        }
        field(18; "2da Quincena"; Boolean)
        {
        }
        field(19; "Importe Cuota"; Decimal)
        {
        }
        field(20; "Motivo Prestamos"; Text[60])
        {
        }
        field(21; "Full name"; Text[150])
        {
            //TODO: Ver CalcFormula = Lookup(Employee."Full Name" WHERE("No." = FIELD("Codigo Empleado")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No. Préstamo")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        ConfNominas.GET;
        IF "No. Préstamo" = '' THEN BEGIN
            ConfNominas.GET;
            ConfNominas.TESTFIELD("No. serie CxC");
            //TODO: Ver GestNoSerie.InitSeries(ConfNominas."No. serie CxC", ConfNominas."No. serie CxC", 0D, "No. Préstamo", ConfNominas."No. serie CxC");

        END;
        Pendiente := TRUE;
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
        //TODO: Ver 
        /*
        IF GestNoSerie.SelectSeries(TraeCodNoSerie, CxCEmpleadosAnt."No. Préstamo", "No. Préstamo") THEN BEGIN
            ConfNominas.GET;
            TestNoSerie;
            GestNoSerie.SetSeries("No. Préstamo");
            EXIT(TRUE);
        END;
        */
    end;

    local procedure TestNoSerie(): Boolean
    begin
        CASE "Tipo CxC" OF
            "Tipo CxC"::Préstamo:
                ConfNominas.TESTFIELD("No. serie CxC");
        END;
    end;

    local procedure TraeCodNoSerie(): Code[10]
    begin
        CASE "Tipo CxC" OF
            "Tipo CxC"::Préstamo:
                EXIT(ConfNominas."No. serie CxC");
        END;
    end;
}

