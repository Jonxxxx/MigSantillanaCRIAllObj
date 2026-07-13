table 34002115 "Perfil Salarial"
{
    Caption = 'Wage Profile';

    fields
    {
        field(1; "Empresa cotización"; Code[10])
        {
        }
        field(2; "No. empleado"; Code[15])
        {
            Editable = false;
            TableRelation = Employee;
        }
        field(3; "Perfil salarial"; Code[10])
        {
            Editable = false;
        }
        field(4; "No. Linea"; Integer)
        {
        }
        field(5; Cargo; Code[10])
        {
            TableRelation = "Puestos laborales";
        }
        field(6; "Concepto salarial"; Code[20])
        {
            Caption = 'Wage Code';
            NotBlank = true;
            TableRelation = "Conceptos salariales".Código;

            trigger OnValidate()
            begin
                ConcepSalar.GET("Concepto salarial");

                //Empleado.GET("No. empleado");
                //"Empresa cotización"  := Empleado.Company;
                Descripción := ConcepSalar.Descripción;
                "Tipo concepto" := ConcepSalar."Tipo concepto";
                "Cotiza ISR" := ConcepSalar."Cotiza ISR";
                Prorratear := ConcepSalar.Provisionar;
                "Salario Base" := ConcepSalar."Salario Base";
                "Cotiza AFP" := ConcepSalar."Cotiza ISR";
                "Cotiza SFS" := ConcepSalar."Cotiza SFS";
                "Cotiza INFOTEP" := ConcepSalar."Cotiza INFOTEP";
                "Cotiza SRL" := ConcepSalar."Cotiza SRL";
                "Excluir de listados" := ConcepSalar."Excluir de listados";
                "Sujeto Cotización" := ConcepSalar."Sujeto Cotización";
                "Aplica para Regalia" := ConcepSalar."Aplica para Regalia";
                "Tipo de nomina" := ConcepSalar."Tipo de nomina";
            end;
        }
        field(7; "Descripción"; Text[50])
        {
        }
        field(8; Cantidad; Decimal)
        {
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            begin
                ConfNominas.GET();
                IF ConfNominas."Impuestos manuales" THEN
                    EXIT;

                IF Cantidad <> 0 THEN BEGIN
                    TiposCot.SETRANGE(Ano, DATE2DMY(WORKDATE, 3));
                    TiposCot.SETRANGE(Código, "Concepto salarial");
                    IF TiposCot.FINDFIRST THEN
                        ERROR(Err002, FIELDCAPTION(Cantidad));
                END;
            end;
        }
        field(9; Importe; Decimal)
        {
            DecimalPlaces = 2 : 4;

            trigger OnValidate()
            var
                NovAuto: Record 34002114;
                AcumuladoSalarios: Record 34002149;
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
                TiposCot.SETRANGE(Código, "Concepto salarial");
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
                    NovAuto."Empresa cotización" := "Empresa cotización";
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
            Description = 'Ingresos,Deducciones';
            OptionMembers = Ingresos,Deducciones;
        }
        field(11; "Sujeto Cotización"; Boolean)
        {

            trigger OnValidate()
            begin
                IF ("Tipo concepto" = 1) AND ("Sujeto Cotización") THEN
                    ERROR(Err001);
            end;
        }
        field(12; "Cotiza ISR"; Boolean)
        {
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
        }
        field(14; Prorratear; Boolean)
        {
        }
        field(15; "Fórmula cálculo"; Text[80])
        {

            trigger OnLookup()
            begin
                //TODO: Ver 
                /*
                FormConcSalariales.LOOKUPMODE(TRUE);
                IF FormConcSalariales.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    FormConcSalariales.GETRECORD(ConcepSalar);
                    "Fórmula cálculo" := "Fórmula cálculo" + ConcepSalar.Código;
                    CLEAR(FormConcSalariales);
                END;
                */
            end;

            trigger OnValidate()
            begin
                "Fórmula cálculo" := UPPERCASE("Fórmula cálculo");

                IF "Fórmula cálculo" <> '' THEN BEGIN
                    Regconceptos.Formula := DELCHR(Rec."Fórmula cálculo", '=', ' ');
                    RegFormula.SETRANGE(Formula, Regconceptos.Formula);
                    IF RegFormula.COUNT = 0 THEN BEGIN
                        Regconceptos.Formula := Rec."Fórmula cálculo";
                        //TODO: Ver Scanner.RUN(Regconceptos);
                        //TODO: Ver Parser.RUN(Regconceptos);
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

                    //TODO: Ver Calculadora.RUN;
                    Regconceptos.GET('resultado');
                    Importe := ROUND(Regconceptos.Valor, 0.01);
                END;
            end;
        }
        field(16; "Período generac."; Code[8])
        {
        }
        field(17; Imprimir; Boolean)
        {
        }
        field(18; "Inicio Período"; Date)
        {

            trigger OnValidate()
            begin
                IF "Inicio Período" <> 0D THEN
                    "Fin Período" := CALCDATE(Text001, "Inicio Período");
            end;
        }
        field(19; "Fin Período"; Date)
        {
        }
        field(20; Mes; Integer)
        {
        }
        field(21; "Mes Inicio"; Date)
        {
        }
        field(22; "Mes Fin"; Date)
        {
        }
        field(23; "Deducir dias"; Boolean)
        {
        }
        field(24; "1ra Quincena"; Boolean)
        {
        }
        field(25; "2da Quincena"; Boolean)
        {
        }
        field(26; Status; Option)
        {
            OptionMembers = Activo,Baja;
        }
        field(27; "Tipo Nómina"; Option)
        {
            OptionCaption = 'Regular,Christmas,Bonus,Tip,Rent';
            OptionMembers = Normal,"Regalía","Bonificación",Propina,Renta;
        }
        field(28; "Cotiza AFP"; Boolean)
        {
            CaptionClass = '4,4,1';
        }
        field(29; "Cotiza SFS"; Boolean)
        {
            CaptionClass = '4,5,1';
        }
        field(30; "Salario Base"; Boolean)
        {
            Editable = false;
        }
        field(31; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(32; "% ISR Pago Empleado"; Decimal)
        {
        }
        field(33; "Cotiza INFOTEP"; Boolean)
        {
            CaptionClass = '4,6,1';
        }
        field(34; "% Retencion Ingreso Salario"; Decimal)
        {
        }
        field(35; "Importe Acumulado"; Decimal)
        {
            CalcFormula = Sum("Historico Lin. nomina".Total WHERE("No. empleado" = FIELD("No. empleado"),
                                                                   Período = FIELD("Filtro Fecha"),
                                                                   "Concepto salarial" = FIELD("Concepto salarial")));
            FieldClass = FlowField;
        }
        field(36; "Filtro Fecha"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(37; "Cotiza SRL"; Boolean)
        {
            CaptionClass = '4,7,1';
        }
        field(38; "Aplica para Regalia"; Boolean)
        {
            Caption = 'Apply for EOY Salary';
        }
        field(40; "Job No."; Code[20])
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
        field(42; "Cotiza FICA"; Boolean)
        {
            CaptionClass = '4,8,1';
        }
        field(46; "Excluir de listados"; Boolean)
        {
            Description = 'Bolivia';
        }
        field(47; "Tipo de nomina"; Code[20])
        {
            Caption = 'Payroll type';
            DataClassification = ToBeClassified;
            TableRelation = "Tipos de nominas";
        }
        field(48; Comentario; Text[100])
        {
            DataClassification = ToBeClassified;
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
        key(Key3; "Perfil salarial", "Sujeto Cotización", "No. empleado")
        {
        }
        key(Key4; "No. empleado", "Sujeto Cotización")
        {
        }
        key(Key5; "Sujeto Cotización", "Salario Base")
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
        //TODO: Ver Cargo := Empleado."Job Type Code";
        //TODO: Ver "Empresa cotización" := Empleado.Company;

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
        RegFormula: Record 34002143;
        Regconceptos: Record 34002144;
        Regpolaca: Record 34002143;
        "Indemnización": Record 5200;
        HistLinNom: Record 34002118;
        RegLinPerSal: Record 34002115;
        ConcepSalar: Record 34002111;
        Empleado: Record 5200;
        Percept: Record 5200;
        TiposCot: Record 34002129;
        //TODO: Ver FormConcSalariales: Page 34002110;
        //TODO: Ver Scanner: Codeunit 34002106;
        //TODO: Ver Parser: Codeunit 34002105;
        //TODO: Ver Calculadora: Codeunit 34002107;
        ConfNominas: Record 34002103;
        ok: Boolean;
        Text001: Label 'CM';
        Text002: Label 'Yo had change the amount for the Base Salary, is this a Salary change or correction?';
        Err001: Label 'This field only applies to Incomes';
        Err002: Label '%1 must be cero, this is a System concept';
        Err003: Label '%1 is already assigned to this employee';
        Err004: Label '%1 can not be deleted because is in use';

    procedure "CálculoCantidad"(LinEsq: Record 34002115) "Factor cantidad": Decimal
    var
        "Horas semanales": Decimal;
        RegUdadCotiz: Record 34002100;
        RegPerceptores: Record 5200;
        RegContratos: Record 34002109;
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
        LinEsqPerFormula: Record 34002115;
    begin
        LinEsqPerFormula.SETRANGE("No. empleado", "No. empleado");
        LinEsqPerFormula.SETRANGE("Perfil salarial", "Perfil salarial");
        LinEsqPerFormula.SETFILTER("Fórmula cálculo", '<>%1', '');
        LinEsqPerFormula.SETFILTER("Concepto salarial", '<>%1', "Concepto salarial");
        IF LinEsqPerFormula.FIND('-') THEN
            REPEAT
                LinEsqPerFormula.VALIDATE("Fórmula cálculo");
                LinEsqPerFormula.Importe := ROUND(LinEsqPerFormula.Importe, 0.01);
                LinEsqPerFormula.MODIFY;
            UNTIL LinEsqPerFormula.NEXT = 0;
    end;
}

