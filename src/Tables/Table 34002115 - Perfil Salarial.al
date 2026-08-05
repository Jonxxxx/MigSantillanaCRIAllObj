table 55756 "Perfil Salarial"
{
    Caption = 'Wage Profile';

    fields
    {
        field(1; "Empresa cotizacion"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Empresa cotizacion';
        }
        field(2; "No. empleado"; Code[15])
        {
            DataClassification = CustomerContent;
            Caption = 'No. empleado';
            Editable = false;
            TableRelation = Employee;
        }
        field(3; "Perfil salarial"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Perfil salarial';
            Editable = false;
        }
        field(4; "No. Linea"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Linea';
        }
        field(5; Cargo; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cargo';
            TableRelation = "Puestos laborales";
        }
        field(6; "Concepto salarial"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto salarial';
            NotBlank = true;
            TableRelation = "Conceptos salariales".Codigo;

            trigger OnValidate()
            begin
                ConcepSalar.GET("Concepto salarial");

                //Empleado.GET("No. empleado");
                //"Empresa cotizacion"  := Empleado.Company;
                Descripcion := ConcepSalar.Descripcion;
                "Tipo concepto" := ConcepSalar."Tipo concepto";
                "Cotiza ISR" := ConcepSalar."Cotiza ISR";
                Prorratear := ConcepSalar.Provisionar;
                "Salario Base" := ConcepSalar."Salario Base";
                "Cotiza AFP" := ConcepSalar."Cotiza ISR";
                "Cotiza SFS" := ConcepSalar."Cotiza SFS";
                "Cotiza INFOTEP" := ConcepSalar."Cotiza INFOTEP";
                "Cotiza SRL" := ConcepSalar."Cotiza SRL";
                "Excluir de listados" := ConcepSalar."Excluir de listados";
                "Sujeto Cotizacion" := ConcepSalar."Sujeto Cotizacion";
                "Aplica para Regalia" := ConcepSalar."Aplica para Regalia";
                "Tipo de nomina" := ConcepSalar."Tipo de nomina";
            end;
        }
        field(7; "Descripcion"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(8; Cantidad; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad';
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            begin
                ConfNominas.GET();
                IF ConfNominas."Impuestos manuales" THEN
                    EXIT;

                IF Cantidad <> 0 THEN BEGIN
                    TiposCot.SETRANGE(Ano, DATE2DMY(WORKDATE, 3));
                    TiposCot.SETRANGE(Codigo, "Concepto salarial");
                    IF TiposCot.FINDFIRST THEN
                        ERROR(Err002, FIELDCAPTION(Cantidad));
                END;
            end;
        }
        field(9; Importe; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe';
            DecimalPlaces = 2 : 4;

            trigger OnValidate()
            var
                NovAuto: Record 55755;
                AcumuladoSalarios: Record 55790;
                Selection: Integer;
                Text000: Label '&Correction,C&hange';
            begin
                Empleado.GET("No. empleado");

                IF Importe <> xRec.Importe THEN BEGIN
                    IF NOT INSERT THEN
                        MODIFY;
                    MiraSiFormula;
                END;

                TiposCot.SETRANGE(Ano, DATE2DMY(WORKDATE, 3));
                TiposCot.SETRANGE(Codigo, "Concepto salarial");
                IF TiposCot.FINDFIRST THEN
                    ERROR(Err002, FIELDCAPTION(Importe));

                /*
                IF ("Salario Base") AND (Importe <> 0) AND (xRec.Importe <>0) THEN
                   BEGIN
                //nav2009    Selection := STRMENU(Text000,1,Text002);
                    Selection := STRMENU(Text000,1);
                    //message('%1',selection);
                    CASE Selection OF
                     0:
                      ERROR('');
                     1:
                      EXIT ;
                    END;
                
                    NovAuto.INIT;
                    NovAuto."Cod. Empleado"      := "No. empleado";
                    NovAuto."Empresa cotizacion" := "Empresa cotizacion";
                    NovAuto.Periodo              := FORMAT(TODAY,0,'<Month,2>') + FORMAT(TODAY,0,'<Year4>');
                    NovAuto."Tipo Novedad"       := 6; //Cambio de datos
                    NovAuto."Fecha Inicio"       := TODAY;
                    NovAuto."Fecha Fin"          := TODAY;
                    NovAuto."Salario SS"         := Importe;
                    NovAuto."Salario ISR"        := Importe;
                    IF NOT NovAuto.INSERT THEN
                       NovAuto.MODIFY;
                
                    AcumuladoSalarios.RESET;
                    AcumuladoSalarios.SETRANGE("No. empleado","No. empleado");
                    IF NOT AcumuladoSalarios.FINDLAST THEN
                       BEGIN
                        AcumuladoSalarios."No. empleado"        := "No. empleado";
                        AcumuladoSalarios."Fecha Desde"         := Empleado."Employment Date";
                        AcumuladoSalarios."Fecha Hasta"         := CALCDATE('-1D', TODAY);
                        AcumuladoSalarios.Importe               := xRec.Importe;
                        IF NOT AcumuladoSalarios.INSERT THEN
                           AcumuladoSalarios.MODIFY;
                       END
                    ELSE
                       BEGIN
                        AcumuladoSalarios."No. empleado"        := "No. empleado";
                        AcumuladoSalarios."Fecha Desde"         := CALCDATE('+1D',AcumuladoSalarios."Fecha Hasta");
                        AcumuladoSalarios."Fecha Hasta"         := CALCDATE('-1D', TODAY);
                        AcumuladoSalarios.Importe               := xRec.Importe;
                        IF NOT AcumuladoSalarios.INSERT THEN
                           AcumuladoSalarios.MODIFY;
                       END;
                   END;
                */

            end;
        }
        field(10; "Tipo concepto"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo concepto';
            Description = 'Ingresos,Deducciones';
            OptionMembers = Ingresos,Deducciones;
        }
        field(11; "Sujeto Cotizacion"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Sujeto Cotizacion';

            trigger OnValidate()
            begin
                IF ("Tipo concepto" = 1) AND ("Sujeto Cotizacion") THEN
                    ERROR(Err001);
            end;
        }
        field(12; "Cotiza ISR"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cotiza ISR';
            CaptionClass = '4,3,1';
            InitValue = false;

            trigger OnValidate()
            begin
                //IF ("Cotiza ISR") AND ("Tipo concepto" = 1 ) THEN
                //   ERROR(Err001);
            end;
        }
        field(13; "Texto Informativo"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Texto Informativo';
        }
        field(14; Prorratear; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Prorratear';
        }
        field(15; "Formula Calculo"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Formula Calculo';

            trigger OnLookup()
            begin

                /*
                FormConcSalariales.LOOKUPMODE(TRUE);
                IF FormConcSalariales.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    FormConcSalariales.GETRECORD(ConcepSalar);
                    "Formula Calculo" := "Formula Calculo" + ConcepSalar.Codigo;
                    CLEAR(FormConcSalariales);
                END;
                */
            end;

            trigger OnValidate()
            begin
                "Formula Calculo" := UPPERCASE("Formula Calculo");

                IF "Formula Calculo" <> '' THEN BEGIN
                    Regconceptos.Formula := DELCHR(Rec."Formula Calculo", '=', ' ');
                    RegFormula.SETRANGE(Formula, Regconceptos.Formula);
                    IF RegFormula.COUNT = 0 THEN BEGIN
                        Regconceptos.Formula := Rec."Formula Calculo";
                        Scanner.RUN(Regconceptos);
                        Parser.RUN(Regconceptos);
                    END;

                    //    RegLinPerSal.SETCURRENTKEY("Perfil salarial","Concepto salarial","No. empleado");
                    Regconceptos.Concepto := 'resultado';
                    IF NOT Regconceptos.INSERT THEN
                        Regconceptos.MODIFY;

                    Regpolaca.SETRANGE(Formula, Regconceptos.Formula);
                    IF Regpolaca.FIND('-') THEN
                        REPEAT
                            IF COPYSTR(Regpolaca.Token, 1, 1) = '#' THEN BEGIN
                                CASE Regpolaca.Token OF
                                    '#1':
                                        BEGIN
                                            ConfNominas.GET;
                                            Regconceptos.Concepto := Regpolaca.Token;
                                        END;
                                END;
                                IF NOT Regconceptos.INSERT THEN
                                    Regconceptos.MODIFY;
                            END
                            ELSE BEGIN
                                RegLinPerSal.RESET;
                                RegLinPerSal.SETCURRENTKEY("Perfil salarial", "Concepto salarial", "No. empleado");
                                RegLinPerSal.SETRANGE("Perfil salarial", Rec."Perfil salarial");
                                RegLinPerSal.SETRANGE("Concepto salarial", Regpolaca.Token);
                                RegLinPerSal.SETRANGE("No. empleado", Rec."No. empleado");
                                IF RegLinPerSal.FINDFIRST THEN BEGIN
                                    Regconceptos.Concepto := Regpolaca.Token;
                                    IF RegLinPerSal.Cantidad <> 0 THEN
                                        Regconceptos.Valor := RegLinPerSal.Cantidad * RegLinPerSal.Importe
                                    ELSE
                                        Regconceptos.Valor := RegLinPerSal.Importe;
                                    IF NOT Regconceptos.INSERT THEN
                                        Regconceptos.MODIFY;
                                END;
                            END;
                        UNTIL Regpolaca.NEXT = 0;

                    Calculadora.RUN;
                    Regconceptos.GET('resultado');
                    Importe := ROUND(Regconceptos.Valor, 0.01);
                END;
            end;
        }
        field(16; "Periodo generac."; Code[8])
        {
            DataClassification = CustomerContent;
            Caption = 'Periodo generac.';
        }
        field(17; Imprimir; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Imprimir';
        }
        field(18; "Inicio Periodo"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Inicio Periodo';

            trigger OnValidate()
            begin
                IF "Inicio Periodo" <> 0D THEN
                    "Fin Periodo" := CALCDATE(Text001, "Inicio Periodo");
            end;
        }
        field(19; "Fin Periodo"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fin Periodo';
        }
        field(20; Mes; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Mes';
        }
        field(21; "Mes Inicio"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Mes Inicio';
        }
        field(22; "Mes Fin"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Mes Fin';
        }
        field(23; "Deducir dias"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Deducir dias';
        }
        field(24; "1ra Quincena"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = '1ra Quincena';
        }
        field(25; "2da Quincena"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = '2da Quincena';
        }
        field(26; Status; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionMembers = Activo,Baja;
        }
        field(27; "Tipo Nomina"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Nomina';
            OptionCaption = 'Regular,Christmas,Bonus,Tip,Rent';
            OptionMembers = Normal,"Regalia","Bonificacion",Propina,Renta;
        }
        field(28; "Cotiza AFP"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cotiza AFP';
            CaptionClass = '4,4,1';
        }
        field(29; "Cotiza SFS"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cotiza SFS';
            CaptionClass = '4,5,1';
        }
        field(30; "Salario Base"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Salario Base';
            Editable = false;
        }
        field(31; "Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(32; "% ISR Pago Empleado"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = '% ISR Pago Empleado';
        }
        field(33; "Cotiza INFOTEP"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cotiza INFOTEP';
            CaptionClass = '4,6,1';
        }
        field(34; "% Retencion Ingreso Salario"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = '% Retencion Ingreso Salario';
        }
        field(35; "Importe Acumulado"; Decimal)
        {
            Caption = 'Importe Acumulado';
            CalcFormula = Sum("Historico Lin. nomina".Total WHERE("No. empleado" = FIELD("No. empleado"),
                                                                   Periodo = FIELD("Filtro Fecha"),
                                                                   "Concepto salarial" = FIELD("Concepto salarial")));
            FieldClass = FlowField;
        }
        field(36; "Filtro Fecha"; Date)
        {
            Caption = 'Filtro Fecha';
            FieldClass = FlowFilter;
        }
        field(37; "Cotiza SRL"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cotiza SRL';
            CaptionClass = '4,7,1';
        }
        field(38; "Aplica para Regalia"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Aplica para Regalia';
        }
        field(40; "Job No."; Code[20])
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
        field(42; "Cotiza FICA"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cotiza FICA';
            CaptionClass = '4,8,1';
        }
        field(46; "Excluir de listados"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Excluir de listados';
            Description = 'Bolivia';
        }
        field(47; "Tipo de nomina"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de nomina';
            TableRelation = "Tipos de nominas";
        }
        field(48; Comentario; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Comentario';
        }
    }

    keys
    {
        key(Key1; "No. empleado", "Perfil salarial", "Concepto salarial")
        {
        }
        key(Key2; "Perfil salarial", "No. empleado")
        {
        }
        key(Key3; "Perfil salarial", "Sujeto Cotizacion", "No. empleado")
        {
        }
        key(Key4; "No. empleado", "Sujeto Cotizacion")
        {
        }
        key(Key5; "Sujeto Cotizacion", "Salario Base")
        {
        }
        key(Key6; "Perfil salarial", "Concepto salarial", "No. empleado")
        {
        }
        key(Key7; "No. empleado", "Concepto salarial")
        {
        }
        key(Key8; "Concepto salarial")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        HistLinNom.RESET;
        HistLinNom.SETRANGE("No. empleado", "No. empleado");
        HistLinNom.SETRANGE("Concepto salarial", "Concepto salarial");
        IF HistLinNom.FINDFIRST THEN
            ERROR(STRSUBSTNO(Err004, "Concepto salarial"));
    end;

    trigger OnInsert()
    begin
        Empleado.GET("No. empleado");
        Cargo := Empleado."Job Type Code";
        "Empresa cotizacion" := Empleado.Company;

        RegLinPerSal.RESET;
        RegLinPerSal.SETRANGE("No. empleado", "No. empleado");
        RegLinPerSal.SETRANGE("Concepto salarial", "Concepto salarial");
        IF RegLinPerSal.FINDFIRST THEN
            ERROR(Err003, "Concepto salarial");
    end;

    trigger OnModify()
    begin
        MiraSiFormula;
    end;

    var
        RegFormula: Record 55784;
        Regconceptos: Record 55785;
        Regpolaca: Record 55784;
        "Indemnizacion": Record 5200;
        HistLinNom: Record 55759;
        RegLinPerSal: Record 55756;
        ConcepSalar: Record 55752;
        Empleado: Record 5200;
        Percept: Record 5200;
        TiposCot: Record 55770;
        FormConcSalariales: Page 55751;
        Scanner: Codeunit 55747;
        Parser: Codeunit 55746;
        Calculadora: Codeunit 55748;
        ConfNominas: Record 55744;
        ok: Boolean;
        Text001: Label 'CM';
        Text002: Label 'Yo had change the amount for the Base Salary, is this a Salary change or correction?';
        Err001: Label 'This field only applies to Incomes';
        Err002: Label '%1 must be cero, this is a System concept';
        Err003: Label '%1 is already assigned to this employee';
        Err004: Label '%1 can not be deleted because is in use';

    procedure "CalculoCantidad"(LinEsq: Record 55756) "Factor cantidad": Decimal
    var
        "Horas semanales": Decimal;
        RegUdadCotiz: Record 55741;
        RegPerceptores: Record 5200;
        RegContratos: Record 55750;
    begin
        /*"Horas semanales" := 0;
        RegContratos.SETRANGE("No. empleado","No. empleado");
        IF RegContratos.FIND('+') THEN BEGIN
          IF RegContratos."Horas semana" <> 0 THEN
             "Horas semanales" := RegContratos."Horas semana"
          ELSE
            "Horas semanales" := RegContratos."Horas dia" * 5;
        END;
        */

    end;

    procedure MiraSiFormula()
    var
        LinEsqPerFormula: Record 55756;
    begin
        LinEsqPerFormula.SETRANGE("No. empleado", "No. empleado");
        LinEsqPerFormula.SETRANGE("Perfil salarial", "Perfil salarial");
        LinEsqPerFormula.SETFILTER("Formula Calculo", '<>%1', '');
        LinEsqPerFormula.SETFILTER("Concepto salarial", '<>%1', "Concepto salarial");
        IF LinEsqPerFormula.FIND('-') THEN
            REPEAT
                LinEsqPerFormula.VALIDATE("Formula Calculo");
                LinEsqPerFormula.Importe := ROUND(LinEsqPerFormula.Importe, 0.01);
                LinEsqPerFormula.MODIFY;
            UNTIL LinEsqPerFormula.NEXT = 0;
    end;
}

