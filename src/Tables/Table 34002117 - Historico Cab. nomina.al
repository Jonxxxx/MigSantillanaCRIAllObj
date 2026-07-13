table 34002117 "Historico Cab. nomina"
{
    DataCaptionFields = "No. empleado", Nombre, "Tipo de nomina", "Período";
    //TODO: Ver DrillDownPageID = 34002123;
    //TODO: Ver LookupPageID = 34002123;

    fields
    {
        field(1; "No. Documento"; Code[20])
        {
        }
        field(2; "No. empleado"; Code[20])
        {
            TableRelation = Employee;
        }
        field(3; Ano; Integer)
        {
        }
        field(4; "Tipo de nomina"; Code[20])
        {
            Caption = 'Payroll type';
            TableRelation = "Tipos de nominas";
        }
        field(5; "Período"; Date)
        {
        }
        field(6; "Centro trabajo"; Code[10])
        {
            TableRelation = "Centros de Trabajo"."Centro de trabajo" WHERE("Empresa cotización" = FIELD("Empresa cotización"));
        }
        field(7; "No. afiliación"; Code[12])
        {
        }
        field(8; "Empresa cotización"; Code[20])
        {
            TableRelation = "Empresas Cotización";
        }
        field(9; "Grupo cotizac"; Code[2])
        {
            TableRelation = "Histórico Puntos Propina";
        }
        field(10; "Días cotizados"; Integer)
        {
        }
        field(11; "Horas jornada"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(12; "Importe Factura"; Decimal)
        {
            DecimalPlaces = 2 : 2;
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
        field(17; "Salario Mínimo"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(22; Prorrata; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(23; "Base ISR"; Decimal)
        {
            CalcFormula = Sum("Historico Lin. nomina".Total WHERE("No. empleado" = FIELD("No. empleado"),
                                                                   Período = FIELD("Período"),
                                                                   "Tipo Nómina" = FIELD("Tipo Nomina"),
                                                                   "Cotiza ISR" = CONST(true),
                                                                   "Texto Informativo" = CONST(false)));
            DecimalPlaces = 2 : 2;
            FieldClass = FlowField;
        }
        field(24; Inicio; Date)
        {
        }
        field(25; Fin; Date)
        {
        }
        field(27; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(28; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(29; "Fecha Pago"; Date)
        {
        }
        field(30; "Fecha Entrada"; Date)
        {
        }
        field(31; "Fecha Salida"; Date)
        {
        }
        field(34; "Bonificación"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(40; Nombre; Text[60])
        {
        }
        field(41; Cargo; Code[15])
        {
        }
        field(43; "Nivel indentacion"; Integer)
        {
            Enabled = false;
        }
        field(61; "Prest.accident. div.-adicional"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            Enabled = false;
        }
        field(62; "Base ISR div.-adicional"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(100; "Total deducciones"; Decimal)
        {
            //TODO: Ver 
            /*
            CalcFormula = Sum("Historico Lin. nomina".Total WHERE("No. empleado" = FIELD("No. empleado"),
                                                                   Período = FIELD("Período"),
                                                                   "de nomina" = FIELD("Tipo de nomina"),
                                                                   "Tipo concepto" = CONST(Deducciones),
                                                                   Total = FILTER(<> 0),
                                                                   "Texto Informativo" = CONST(No)));*/
            DecimalPlaces = 2 : 2;
            FieldClass = FlowField;
        }
        field(101; "Total Ingresos"; Decimal)
        {
            //TODO: Ver 
            /*
            CalcFormula = Sum("Historico Lin. nomina".Total WHERE("No. empleado" = FIELD("No. empleado"),
                                                                   Período = FIELD("Período"),
                                                                   "de nomina" = FIELD("Tipo de nomina"),
                                                                   "Tipo concepto" = CONST(Ingresos),
                                                                   Total = FILTER(<> 0),
                                                                   "Texto Informativo" = CONST(No)));*/
            DecimalPlaces = 2 : 2;
            FieldClass = FlowField;
        }
        field(102; "Total deducciones div.-adicion"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            Enabled = false;
            FieldClass = FlowField;
        }
        field(103; "Total devengos div.-adicion"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            Enabled = false;
        }
        field(110; "Liquid.ISR"; Boolean)
        {
        }
        field(120; "Tipo Archivo"; Integer)
        {
        }
        field(130; "Factor maternidad"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 2;
            Enabled = false;
        }
        field(150; "No. Contabilización"; Code[20])
        {
        }
        field(151; "Total Ingreso Salario"; Decimal)
        {
            CalcFormula = Sum("Historico Lin. nomina".Total WHERE("No. Documento" = FIELD("Empresa cotización"),
                                                                   "No. empleado" = FIELD("No. empleado"),
                                                                   Período = FIELD("Período"),
                                                                   "Salario Base" = CONST(True)));
            FieldClass = FlowField;
        }
        field(152; "Tipo Empleado"; Option)
        {
            Description = 'Fijo,Temporal,Otro';
            OptionMembers = Fijo,Temporal,Otro;
        }
        field(153; Banco; Code[20])
        {
        }
        field(154; "Tipo Cuenta"; Option)
        {
            Description = '  ,Ahorro con libreta,Corriente con libreta,Ahorro Tarjeta Elect.,Corriente Tarjeta Elect.';
            OptionMembers = "  ","Ahorro con libreta","Corriente con libreta","Ahorro Tarjeta Elect.","Corriente Tarjeta Elect.";
        }
        field(155; "Frecuencia de pago"; Option)
        {
            Caption = 'Payment frequency';
            OptionCaption = 'Daily,Weekly,Bi-Weekly,Half Month,Monthly,Yearly';
            OptionMembers = Diaria,Semanal,"Bi-Semanal",Quincenal,Mensual,Anual;
        }
        field(156; Cuenta; Text[22])
        {
        }
        field(157; "Plaza Oficina"; Text[20])
        {
        }
        field(158; "Forma de Cobro"; Option)
        {
            Description = ' ,Efectivo,Cheque,Transferencia Banc.';
            OptionMembers = " ",Efectivo,Cheque,"Transferencia Banc.";
        }
        field(159; "Tipo Nomina"; Option)
        {
            Description = 'Normal,Regalía,Bonificación';
            OptionCaption = 'Regular,Christmas,Bonus,Tip,Rent';
            OptionMembers = Normal,"Regalía","Bonificación",Propina,Renta;
        }
        field(160; Departamento; Code[20])
        {
            Caption = 'Department';
            TableRelation = Departamentos;
        }
        field(161; "Sub-Departamento"; Code[20])
        {
            Caption = 'Sub-Department';
            TableRelation = "Sub-Departamentos".Codigo WHERE("Cod. Departamento" = FIELD("Departamento"));
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
        key(Key1; Ano, "No. empleado", "Período", "Job No.", "Tipo de nomina")
        {
        }
        key(Key2; Ano, "Período", "No. empleado")
        {
        }
        key(Key3; "No. empleado", Ano, "Período", "Tipo de nomina")
        {
        }
        key(Key4; "No. Documento", Ano, "Período", "No. empleado", "Tipo de nomina")
        {
        }
        key(Key5; "Período", "Shortcut Dimension 1 Code", Nombre)
        {
        }
        key(Key6; Nombre)
        {
        }
        key(Key7; "Forma de Cobro", Departamento, "Sub-Departamento")
        {
        }
        key(Key8; Departamento, "Sub-Departamento")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //ERROR('Utilice función de borrado de nóminas..........');
    end;

    trigger OnInsert()
    begin
        //ERROR('No puede grabar nóminas manualmente..........');
    end;

    var
        LinTabla: Decimal;
        "Cód. divisa": Code[10];
        CalculoInvertido: Boolean;
        DimMgt: Codeunit 408;

    procedure Anular()
    var
        LinNomina: Record 34002118;
        LinNomina2: Record 34002118;
        DimSet: Record 480;
    begin
        LinNomina.RESET;
        LinNomina.SETRANGE("No. empleado", "No. empleado");
        LinNomina.SETRANGE(Período, Período);
        LinNomina.SETRANGE("Tipo de nomina", "Tipo de nomina");
        LinNomina.SETRANGE("Job No.", "Job No.");
        IF LinNomina.FINDSET(TRUE, FALSE) THEN
            REPEAT
                LinNomina.DELETE();
            UNTIL LinNomina.NEXT = 0;
        DELETE;
    end;

    procedure TraeDivisa()
    var
        ConfNominas: Record 34002103;
        Divisa: Record 4;
    begin
        //TraeDivisa
        ConfNominas.GET('');
        IF ConfNominas."Concepto Incentivos" <> '' THEN BEGIN
            "Cód. divisa" := ConfNominas."Concepto Incentivos";
            CalculoInvertido := FALSE;
        END ELSE BEGIN
            "Cód. divisa" := ConfNominas."Incidencias Dto. Nomina";
            CalculoInvertido := TRUE;
        END;
        IF "Cód. divisa" <> '' THEN BEGIN
            Divisa.GET("Cód. divisa");
            Divisa.TESTFIELD("Amount Rounding Precision");
        END;

        IF CalculoInvertido THEN
            Divisa.InitRoundingPrecision;
    end;

    procedure ShowDimensions()
    begin
        DimMgt.ShowDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2 %3', TABLECAPTION, "No. Documento", "No. empleado"));
    end;
}

