table 55758 "Historico Cab. nomina"
{
    DataCaptionFields = "No. empleado", Nombre, "Tipo de nomina", "Periodo";
    DrillDownPageID = 55764;
    LookupPageID = 55764;

    fields
    {
        field(1; "No. Documento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Documento';
        }
        field(2; "No. empleado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. empleado';
            TableRelation = Employee;
        }
        field(3; Ano; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Ano';
        }
        field(4; "Tipo de nomina"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de nomina';
            TableRelation = "Tipos de nominas";
        }
        field(5; "Periodo"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Periodo';
        }
        field(6; "Centro trabajo"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Centro trabajo';
            TableRelation = "Centros de Trabajo"."Centro de trabajo" WHERE("Empresa cotizacion" = FIELD("Empresa cotizacion"));
        }
        field(7; "No. afiliacion"; Code[12])
        {
            DataClassification = CustomerContent;
            Caption = 'No. afiliacion';
        }
        field(8; "Empresa cotizacion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Empresa cotizacion';
            TableRelation = "Empresas Cotizacion";
        }
        field(9; "Grupo cotizac"; Code[2])
        {
            DataClassification = CustomerContent;
            Caption = 'Grupo cotizac';
            TableRelation = "Historico Puntos Propina";
        }
        field(10; "Dias cotizados"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Dias cotizados';
        }
        field(11; "Horas jornada"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Horas jornada';
            DecimalPlaces = 2 : 2;
        }
        field(12; "Importe Factura"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Factura';
            DecimalPlaces = 2 : 2;
        }
        field(13; "Job No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job No.';
            TableRelation = Job;

            trigger OnValidate()
            var
                Job: Record 167;
                Cust: Record 18;
            begin
            end;
        }
        field(17; "Salario Minimo"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Salario Minimo';
            DecimalPlaces = 2 : 2;
        }
        field(22; Prorrata; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Prorrata';
            DecimalPlaces = 2 : 2;
        }
        field(23; "Base ISR"; Decimal)
        {
            Caption = 'Base ISR';
            CalcFormula = Sum("Historico Lin. nomina".Total WHERE("No. empleado" = FIELD("No. empleado"),
                                                                   Periodo = FIELD("Periodo"),
                                                                   "Tipo Nomina" = FIELD("Tipo Nomina"),
                                                                   "Cotiza ISR" = CONST(true),
                                                                   "Texto Informativo" = CONST(false)));
            DecimalPlaces = 2 : 2;
            FieldClass = FlowField;
        }
        field(24; Inicio; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Inicio';
        }
        field(25; Fin; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fin';
        }
        field(27; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(28; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(29; "Fecha Pago"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Pago';
        }
        field(30; "Fecha Entrada"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Entrada';
        }
        field(31; "Fecha Salida"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Salida';
        }
        field(34; "Bonificacion"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Bonificacion';
            DecimalPlaces = 2 : 2;
        }
        field(40; Nombre; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre';
        }
        field(41; Cargo; Code[15])
        {
            DataClassification = CustomerContent;
            Caption = 'Cargo';
        }
        field(43; "Nivel indentacion"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Nivel indentacion';
            Enabled = false;
        }
        field(61; "Prest.accident. div.-adicional"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Prest.accident. div.-adicional';
            DecimalPlaces = 2 : 2;
            Enabled = false;
        }
        field(62; "Base ISR div.-adicional"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Base ISR div.-adicional';
            DecimalPlaces = 2 : 2;
        }
        field(100; "Total deducciones"; Decimal)
        {
            Caption = 'Total deducciones';

            CalcFormula = Sum("Historico Lin. nomina".Total WHERE("No. empleado" = FIELD("No. empleado"),
                                                                   Periodo = FIELD("Periodo"),
                                                                   "Tipo de nomina" = FIELD("Tipo de nomina"),
                                                                   "Tipo concepto" = CONST(Deducciones),
                                                                   Total = FILTER(<> 0),
                                                                   "Texto Informativo" = CONST(False)));
            DecimalPlaces = 2 : 2;
            FieldClass = FlowField;
        }
        field(101; "Total Ingresos"; Decimal)
        {
            Caption = 'Total Ingresos';

            CalcFormula = Sum("Historico Lin. nomina".Total WHERE("No. empleado" = FIELD("No. empleado"),
                                                                   Periodo = FIELD("Periodo"),
                                                                   "Tipo de nomina" = FIELD("Tipo de nomina"),
                                                                   "Tipo concepto" = CONST(Ingresos),
                                                                   Total = FILTER(<> 0),
                                                                   "Texto Informativo" = CONST(False)));
            DecimalPlaces = 2 : 2;
            FieldClass = FlowField;
        }
        field(102; "Total deducciones div.-adicion"; Decimal)
        {
            Caption = 'Total deducciones div.-adicion';
            DecimalPlaces = 2 : 2;
            Enabled = false;
            FieldClass = FlowField;
        }
        field(103; "Total devengos div.-adicion"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total devengos div.-adicion';
            DecimalPlaces = 2 : 2;
            Enabled = false;
        }
        field(110; "Liquid.ISR"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Liquid.ISR';
        }
        field(120; "Tipo Archivo"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Archivo';
        }
        field(130; "Factor maternidad"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Factor maternidad';
            BlankZero = true;
            DecimalPlaces = 2 : 2;
            Enabled = false;
        }
        field(150; "No. Contabilizacion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Contabilizacion';
        }
        field(151; "Total Ingreso Salario"; Decimal)
        {
            Caption = 'Total Ingreso Salario';
            CalcFormula = Sum("Historico Lin. nomina".Total WHERE("No. Documento" = FIELD("Empresa cotizacion"),
                                                                   "No. empleado" = FIELD("No. empleado"),
                                                                   Periodo = FIELD("Periodo"),
                                                                   "Salario Base" = CONST(True)));
            FieldClass = FlowField;
        }
        field(152; "Tipo Empleado"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Empleado';
            Description = 'Fijo,Temporal,Otro';
            OptionMembers = Fijo,Temporal,Otro;
        }
        field(153; Banco; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Banco';
        }
        field(154; "Tipo Cuenta"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Cuenta';
            Description = '  ,Ahorro con libreta,Corriente con libreta,Ahorro Tarjeta Elect.,Corriente Tarjeta Elect.';
            OptionMembers = "  ","Ahorro con libreta","Corriente con libreta","Ahorro Tarjeta Elect.","Corriente Tarjeta Elect.";
        }
        field(155; "Frecuencia de pago"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Frecuencia de pago';
            OptionCaption = 'Daily,Weekly,Bi-Weekly,Half Month,Monthly,Yearly';
            OptionMembers = Diaria,Semanal,"Bi-Semanal",Quincenal,Mensual,Anual;
        }
        field(156; Cuenta; Text[22])
        {
            DataClassification = CustomerContent;
            Caption = 'Cuenta';
        }
        field(157; "Plaza Oficina"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Plaza Oficina';
        }
        field(158; "Forma de Cobro"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Forma de Cobro';
            Description = ' ,Efectivo,Cheque,Transferencia Banc.';
            OptionMembers = " ",Efectivo,Cheque,"Transferencia Banc.";
        }
        field(159; "Tipo Nomina"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Nomina';
            Description = 'Normal,Regalia,Bonificacion';
            OptionCaption = 'Regular,Christmas,Bonus,Tip,Rent';
            OptionMembers = Normal,"Regalia","Bonificacion",Propina,Renta;
        }
        field(160; Departamento; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Departamento';
            TableRelation = Departamentos;
        }
        field(161; "Sub-Departamento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sub-Departamento';
            TableRelation = "Sub-Departamentos".Codigo WHERE("Cod. Departamento" = FIELD("Departamento"));
        }
        field(480; "Dimension Set ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
    }

    keys
    {
        key(Key1; Ano, "No. empleado", "Periodo", "Job No.", "Tipo de nomina")
        {
        }
        key(Key2; Ano, "Periodo", "No. empleado")
        {
        }
        key(Key3; "No. empleado", Ano, "Periodo", "Tipo de nomina")
        {
        }
        key(Key4; "No. Documento", Ano, "Periodo", "No. empleado", "Tipo de nomina")
        {
        }
        key(Key5; "Periodo", "Shortcut Dimension 1 Code", Nombre)
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
        //ERROR('Utilice funcion de borrado de nominas..........');
    end;

    trigger OnInsert()
    begin
        //ERROR('No puede grabar nominas manualmente..........');
    end;

    var
        LinTabla: Decimal;
        "Cod. divisa": Code[10];
        CalculoInvertido: Boolean;
        DimMgt: Codeunit 408;

    procedure Anular()
    var
        LinNomina: Record 55759;
        LinNomina2: Record 55759;
        DimSet: Record 480;
    begin
        LinNomina.RESET;
        LinNomina.SETRANGE("No. empleado", "No. empleado");
        LinNomina.SETRANGE(Periodo, Periodo);
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
        ConfNominas: Record 55744;
        Divisa: Record 4;
    begin
        //TraeDivisa
        ConfNominas.GET('');
        IF ConfNominas."Concepto Incentivos" <> '' THEN BEGIN
            "Cod. divisa" := ConfNominas."Concepto Incentivos";
            CalculoInvertido := FALSE;
        END ELSE BEGIN
            "Cod. divisa" := ConfNominas."Incidencias Dto. Nomina";
            CalculoInvertido := TRUE;
        END;
        IF "Cod. divisa" <> '' THEN BEGIN
            Divisa.GET("Cod. divisa");
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

