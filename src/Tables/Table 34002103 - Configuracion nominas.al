table 34002103 "Configuracion nominas"
{

    fields
    {
        field(1; Codigo; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(2; "No. serie nominas"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'No. serie nominas';
            TableRelation = "No. Series";
        }
        field(3; "No. serie CxC"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'No. serie CxC';
            TableRelation = "No. Series";
        }
        field(4; "No. serie reg. CxC"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'No. serie reg. CxC';
            TableRelation = "No. Series";
        }
        field(5; "Journal Template Name"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Journal Template Name';
            TableRelation = "Gen. Journal Template";
        }
        field(6; "Journal Batch Name"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Journal Batch Name';
        }
        field(7; "Dimension Conceptos Salariales"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension Conceptos Salariales';
            TableRelation = Dimension;
        }
        field(9; "Incidencias Ausencia Propinas"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Incidencias Ausencia Propinas';
            TableRelation = "Cause of Absence".Code;
        }
        field(10; "Incidencias Dto. Nomina"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Incidencias Dto. Nomina';
            TableRelation = "Cause of Absence".Code;
        }
        field(11; "Concepto Incentivos"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto Incentivos';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(12; "Impuestos manuales"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Impuestos manuales';
        }
        field(13; "Concepto CxC Empl."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto CxC Empl.';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(14; "Concepto ISR Cobrado en exceso"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto ISR Cobrado en exceso';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(15; "Concepto Sal. Base"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto Sal. Base';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(16; "Concepto ISR"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto ISR';
            CaptionClass = '4,3,1';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(17; "Concepto Retroactivo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto Retroactivo';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(18; "Concepto Inasistencia"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto Inasistencia';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(19; "Concepto AFP"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto AFP';
            CaptionClass = '4,4,1';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(20; "Concepto SFS"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto SFS';
            CaptionClass = '4,5,1';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(21; "Concepto Regalia"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto Regalia';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(22; "Concepto Bonificacion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto Bonificacion';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(23; "Concepto Vacaciones"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto Vacaciones';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(24; "Concepto Horas Ext. 100%"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto Horas Ext. 100%';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(25; "Concepto Horas Ext. 35%"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto Horas Ext. 35%';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(26; "Concepto Sal. hora"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto Sal. hora';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(27; "Concepto SRL"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto SRL';
            CaptionClass = '4,7,1';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(28; "Concepto INFOTEP"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto INFOTEP';
            CaptionClass = '4,6,1';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(29; "Concepto Dias feriados"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto Dias feriados';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(30; "Concepto Horas nocturnas"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto Horas nocturnas';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(31; "Job Journal Template Name"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Journal Template Name';
            Description = 'Proyectos';
            TableRelation = "Gen. Journal Template";
        }
        field(32; "Job Journal Batch Name"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Journal Batch Name';
            Description = 'Proyectos';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Job Journal Template Name"));
        }
        field(33; "Concepto Dieta"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto Dieta';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(34; "Concepto Transporte"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto Transporte';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(35; "Salario Minimo"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Salario Minimo';
        }
        field(36; "Secuencia de archivo Batch"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Secuencia de archivo Batch';
        }
        field(37; "No. Proyecto Generico"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Proyecto Generico';
            Description = 'Proyectos';
            TableRelation = Job;
        }
        field(38; "Concepto Preaviso"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto Preaviso';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(39; "Concepto Cesantia"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto Cesantia';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(40; "Fecha secuencia"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha secuencia';

            trigger OnValidate()
            begin
                //IF ("Fecha secuencia" > 31) OR ("Fecha secuencia" < 27) THEN
                //   ERROR('Dia inválido, favor verificar');
            end;
        }
        field(41; "Metodo Calculo ausencias"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Metodo Calculo ausencias';
            TableRelation = "Parametros Calculo Dias";
        }
        field(42; "Registro de provision"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Registro de provision';
            OptionCaption = 'Monthly,Half month,Bi weekly,Wekly,Daily';
            OptionMembers = Mensual,Quincenal,"Bi-Semanal",Semanal,Diaria;
        }
        field(43; "Concepto devolucion ISR"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto devolucion ISR';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(44; "Tasa Cambio Calculo Divisa"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Tasa Cambio Calculo Divisa';
        }
        field(45; "Metodo calculo Ingresos"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Metodo calculo Ingresos';
            TableRelation = "Parametros Calculo Dias";
        }
        field(46; "Metodo calculo Salidas"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Metodo calculo Salidas';
            TableRelation = "Parametros Calculo Dias";
        }
        field(47; "Cod. Cta. Nominas Pago Transf."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Cta. Nominas Pago Transf.';
            TableRelation = IF ("Tipo cuenta" = CONST(Cuenta)) "G/L Account"
            ELSE IF ("Tipo cuenta" = CONST(Banco)) "Bank Account";
        }
        field(48; "Cta. Nominas Otros Pagos"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cta. Nominas Otros Pagos';

            /*
            TableRelation = IF ("Tipo Cta.Otros Pagos" = CONST(Cuenta)) "G/L Account"."No."
            ELSE IF ("Tipo Cta. Otros Pagos" = CONST(Banco)) "Bank Account"."No."
            ELSE IF ("Tipo Cta. Otros Pagos" = CONST(Proveedor)) Vendor."No.";*/
        }
        field(49; "Web Page TSS"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Web Page TSS';
            ExtendedDatatype = URL;
        }
        field(50; "Web Page DGII"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Web Page DGII';
            ExtendedDatatype = URL;
        }
        field(51; "Path Archivos Electronicos"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Path Archivos Electronicos';
        }
        field(52; "Importe Anual IHSS Base ISR"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Anual IHSS Base ISR';
            Description = 'Honduras';
        }
        field(53; "% dif. Ingresos y descuentos"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = '% dif. Ingresos y descuentos';
        }
        field(54; "Tipo cuenta"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo cuenta';
            OptionCaption = 'G/l Account/Bank account';
            OptionMembers = Cuenta,Banco;
        }
        field(55; "Vacaciones colectivas"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Vacaciones colectivas';
        }
        field(56; "Texto email recibos"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Texto email recibos';
        }
        field(57; "Tiempo espera Envio email"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Tiempo espera Envio email';
        }
        field(58; "Journal Template Name CK"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Journal Template Name CK';
            TableRelation = "Gen. Journal Template";
        }
        field(59; "Journal Batch Name CK"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Journal Batch Name CK';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name CK"));
        }
        field(60; "Tipo Cta. Otros Pagos"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Cta. Otros Pagos';
            OptionCaption = 'G/L Account,Bank Account,Vendor';
            OptionMembers = Cuenta,Banco,Proveedor;
        }
        field(61; "Codeunit calculo nomina"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Codeunit calculo nomina';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Codeunit));
        }
        field(62; "Nomina de Pais"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Nomina de Pais';
            TableRelation = "Country/Region";
        }
        field(63; "No. serie Sol. Prest. Coop."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. serie Sol. Prest. Coop.';
            TableRelation = "No. Series";
        }
        field(64; "No. serie Hist. Prest. Coop."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. serie Hist. Prest. Coop.';
            TableRelation = "No. Series";
        }
        field(65; "Concepto Cuota cooperativa"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto Cuota cooperativa';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(66; "Mod. cooperativa activo"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Mod. cooperativa activo';
        }
        field(67; "Codeunit Archivos Electronicos"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Codeunit Archivos Electronicos';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Codeunit));
        }
        field(68; "Dimension Empleado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension Empleado';
            Description = 'OJO, verificar su uso en algun pais';
            TableRelation = Dimension;
        }
        field(69; "Metodo Calculo SS"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Metodo Calculo SS';
            OptionCaption = 'Period Income,Balanced';
            OptionMembers = "Ingresos del Periodo",Balanceado;
        }
        field(70; "Cta. Lin. Planif. Proyectos"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cta. Lin. Planif. Proyectos';
            Description = 'Proyectos';

            trigger OnLookup()
            begin
                JPL.RESET;
                JPL.SETRANGE(Type, JPL.Type::"G/L Account");
                IF PAGE.RUNMODAL(0, JPL) = ACTION::LookupOK THEN BEGIN
                    VALIDATE("Cta. Lin. Planif. Proyectos", JPL."No.");
                END;
            end;

            trigger OnValidate()
            begin
                IF "Cta. Lin. Planif. Proyectos" <> '' THEN BEGIN
                    JPL.RESET;
                    JPL.SETRANGE(Type, JPL.Type::"G/L Account");
                    JPL.SETRANGE("No.", "Cta. Lin. Planif. Proyectos");
                    JPL.FINDFIRST;
                END;
            end;
        }
        field(71; "ID Informe de nomina"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID Informe de nomina';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Report));
        }
        field(72; "Proceso recalculo ISR automat."; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Proceso recalculo ISR automat.';
        }
        field(79; "Concepto Antiguedad Laboral"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto Antiguedad Laboral';
            Description = 'Honduras';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(80; "Importe gastos medicos"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe gastos medicos';
            Description = 'Honduras';
        }
        field(81; "Calcular horas reg. asistencia"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Calcular horas reg. asistencia';
        }
        field(82; "Divisa para Entrada de Diario"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Divisa para Entrada de Diario';
            TableRelation = Currency;
        }
        field(83; "Usar Acciones de personal"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Usar Acciones de personal';
        }
        field(84; "Dias para corte nominas"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Dias para corte nominas';
        }
        field(85; "Habilitar numeradores globales"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Habilitar numeradores globales';
        }
        field(86; "Dias vacaciones adicionales"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Dias vacaciones adicionales';
        }
        field(87; "Multiempresa activo"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Multiempresa activo';
        }
        field(88; "XML importa datos ponchador"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'XML importa datos ponchador';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(XmlPort));
        }
        field(89; "Tiempo minimo prest. coop."; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Tiempo minimo prest. coop.';
        }
        field(90; "Concepto Dependiente Adicional"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto Dependiente Adicional';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(91; "Caption Depto"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Caption Depto';
        }
        field(92; "Caption Sub Depto"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Caption Sub Depto';
        }
        field(93; "Caption ISR"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Caption ISR';
        }
        field(94; "Caption INFOTEP"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Caption INFOTEP';
        }
        field(95; "Caption AFP"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Caption AFP';
        }
        field(96; "Caption SFS"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Caption SFS';
        }
        field(97; "Caption SRL"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Caption SRL';
        }
        field(98; "CU Procesa datos ponchador"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'CU Procesa datos ponchador';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Codeunit));
        }
        field(99; "Completar horas ponchador"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Completar horas ponchador';
        }
        field(100; "Horas de almuerzo"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Horas de almuerzo';
        }
        field(101; "Adelantar salario vacaciones"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Adelantar salario vacaciones';
        }
        field(102; "Integracion ponche activa"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Integracion ponche activa';
        }
        field(103; "Prioridad correos"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Prioridad correos';
            OptionCaption = 'Personal email,Company email';
            OptionMembers = "Correo personal","Correo empresarial";
        }
        field(104; "Act. Excluido TSS automatico"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Act. Excluido TSS automatico';
        }
        field(55225; "Concepto Reembolso gtos."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto Reembolso gtos.';
            Description = 'NOVAL';
            TableRelation = "Conceptos salariales".Codigo;
        }
    }

    keys
    {
        key(Key1; Codigo)
        {
        }
    }

    fieldgroups
    {
    }

    var
        JPL: Record 1003;
}

