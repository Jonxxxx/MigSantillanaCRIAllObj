table 55759 "Historico Lin. nomina"
{
    //IGNORAR: Page no existe DrillDownPageID = 55786;
    //IGNORAR: Page no existe LookupPageID = 55786;

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
        field(3; "Tipo Nomina"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Nomina';
            Description = 'Normal,Regalia,Bonificacion';
            OptionCaption = 'Regular,Christmas,Bonus,Tip,Rent';
            OptionMembers = Normal,"Regalia","Bonificacion",Propina,Renta;
        }
        field(4; "Periodo"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Periodo';
        }
        field(5; "No. Orden"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Orden';
        }
        field(6; Ano; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Ano';
        }
        field(7; Nombre; Text[80])
        {
            Caption = 'Nombre';
            CalcFormula = Lookup("Historico Cab. nomina".Nombre WHERE("No. Documento" = FIELD("No. Documento"),
                                                                       "No. empleado" = FIELD("No. empleado")));
            FieldClass = FlowField;
        }
        field(8; "Empresa cotizacion"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Empresa cotizacion';
            TableRelation = "Empresas Cotizacion";
        }
        field(9; "Concepto salarial"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto salarial';
            TableRelation = "Conceptos salariales".Codigo;

            trigger OnValidate()
            var
                ConceptosSal: Record 55752;
            begin
                ConceptosSal.SETRANGE(Codigo, "Concepto salarial");
                IF ConceptosSal.FINDFIRST THEN
                    Descripcion := ConceptosSal.Descripcion;
            end;
        }
        field(10; "Descripcion"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(11; Cantidad; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad';
            DecimalPlaces = 0 : 5;
        }
        field(12; "Importe Base"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Base';
            AutoFormatExpression = "Currency Code";
        }
        field(13; Total; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total';
            AutoFormatExpression = "Currency Code";
        }
        field(14; "% Cotizable"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = '% Cotizable';
        }
        field(15; "Tipo concepto"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo concepto';
            Description = 'Ingresos,Deducciones';
            OptionMembers = Ingresos,Deducciones;
        }
        field(16; "Salario Base"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Salario Base';
        }
        field(17; "Parcial divisa-adicional"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Parcial divisa-adicional';
            DecimalPlaces = 2 : 2;
        }
        field(18; "Sujeto Cotizacion"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Sujeto Cotizacion';
            InitValue = true;
        }
        field(19; "Cotiza ISR"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cotiza ISR';
            CaptionClass = '4,3,1';
            InitValue = false;
        }
        field(20; "Cotiza SFS"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cotiza SFS';
            CaptionClass = '4,5,1';
            InitValue = false;
        }
        field(21; "Cotiza AFP"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cotiza AFP';
            CaptionClass = '4,4,1';
        }
        field(22; "Formula"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Formula';

            trigger OnValidate()
            begin
                Formula := UPPERCASE(Formula);


                /*
                IF Formula <> '' THEN BEGIN
                    Regconceptos.Formula := DELCHR(Rec.Formula, '=', ' ');
                    RegFormula.SETRANGE(Formula, Regconceptos.Formula);
                    IF RegFormula.COUNT = 0 THEN BEGIN
                        Regconceptos.Formula := Rec.Formula;
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
                                RegLinPerSal.SETRANGE("Concepto salarial", Regpolaca.Token);
                                RegLinPerSal.SETRANGE("No. empleado", "No. empleado");
                                RegLinPerSal.SETRANGE(Periodo, Periodo);
                                IF RegLinPerSal.FINDFIRST THEN BEGIN
                                    Regconceptos.Concepto := Regpolaca.Token;
                                    Regconceptos.Valor := RegLinPerSal.Total;
                                    IF NOT Regconceptos.INSERT THEN
                                        Regconceptos.MODIFY;
                                END;
                            END;
                        UNTIL Regpolaca.NEXT = 0;

                    Calculadora.RUN;
                    Regconceptos.GET('resultado');
                    Total := Regconceptos.Valor;
                END;
                */
            end;
        }
        field(23; Imprimir; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Imprimir';
        }
        field(24; "Inicio periodo"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Inicio periodo';
        }
        field(25; "Fin periodo"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fin periodo';
        }
        field(26; "Texto Informativo"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Texto Informativo';
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
        field(29; "Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(30; "% Pago Empleado"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = '% Pago Empleado';
        }
        field(31; "Cotiza SRL"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cotiza SRL';
            CaptionClass = '4,7,1';
        }
        field(32; "Cotiza Infotep"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cotiza Infotep';
            CaptionClass = '4,6,1';
        }
        field(33; Departamento; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Departamento';
            CaptionClass = '4,1,1';
            TableRelation = Departamentos;
        }
        field(34; "Sub-Departamento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sub-Departamento';
            CaptionClass = '4,2,1';
            TableRelation = "Sub-Departamentos".Codigo WHERE("Cod. Departamento" = FIELD("Departamento"));
        }
        field(35; "Aplica para Regalia"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Aplica para Regalia';
        }
        field(39; "Cotiza FICA"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cotiza FICA';
            CaptionClass = '4,8,1';
        }
        field(40; "ISR compensado"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'ISR compensado';
        }
        field(43; "Aporte Voluntario"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Aporte Voluntario';
        }
        field(44; "Excluir de listados"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Excluir de listados';
        }
        field(45; Comentario; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Comentario';
        }
        field(46; "Tipo de nomina"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de nomina';
            TableRelation = "Tipos de nominas";
        }
        field(50; "Job No."; Code[20])
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
        field(155; "Frecuencia de pago"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Frecuencia de pago';
            OptionCaption = 'Daily,Weekly,Bi-Weekly,Half Month,Monthly,Yearly';
            OptionMembers = Diaria,Semanal,"Bi-Semanal",Quincenal,Mensual,Anual;
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
        key(Key1; "No. empleado", "Tipo de nomina", "Periodo", "No. Orden")
        {
            SumIndexFields = "Importe Base", Total, "Parcial divisa-adicional";
        }
        key(Key2; "No. empleado", "Periodo", "Tipo Nomina", "Cotiza ISR", "Texto Informativo")
        {
            SumIndexFields = "Importe Base", Total, "Parcial divisa-adicional";
        }
        key(Key3; "No. empleado", "Tipo concepto", "Periodo", "Concepto salarial")
        {
            SumIndexFields = Total, "Parcial divisa-adicional";
        }
        key(Key4; "No. empleado", "Periodo", "Salario Base", "No. Documento")
        {
            SumIndexFields = "Importe Base", Total, "Parcial divisa-adicional";
        }
        key(Key5; "No. Documento", "No. empleado", "Periodo", Cantidad)
        {
            SumIndexFields = "Importe Base", Total, "Parcial divisa-adicional";
        }
        key(Key6; "No. empleado", "Tipo concepto", "Periodo", "Texto Informativo", Total)
        {
            SumIndexFields = "Importe Base", Total, "Parcial divisa-adicional";
        }
        key(Key7; "Concepto salarial", "Periodo")
        {
        }
        key(Key8; Departamento, "Sub-Departamento", "No. empleado", "Periodo")
        {
        }
        key(Key9; "No. empleado", "Tipo Nomina", "Periodo", "Tipo concepto", "Concepto salarial")
        {
        }
        key(Key10; "Periodo", Departamento, "Sub-Departamento", "Concepto salarial")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        RecalculaAportePatronal;
    end;

    var
        ConfNominas: Record 55744;
        RegFormula: Record 55784;
        Regconceptos: Record 55785;
        Regpolaca: Record 55784;
        RegLinPerSal: Record 55759;
        DimMgt: Codeunit 408;
        Scanner: Codeunit 55747;
        Parser: Codeunit 55746;
        Calculadora: Codeunit 55748;

    procedure ShowDimensions()
    begin
        TESTFIELD("No. Orden");
        DimMgt.ShowDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2 %3', TABLECAPTION, "No. Documento", "No. Orden"));
    end;

    local procedure RecalculaAportePatronal()
    var
        LinAporteEmp: Record 55763;
        BaseCalculo: Decimal;
    begin
        LinAporteEmp.RESET;
        LinAporteEmp.SETRANGE("No. Empleado");
        LinAporteEmp.SETRANGE("Tipo de nomina", "Tipo de nomina");
        LinAporteEmp.SETRANGE("Concepto Salarial", "Concepto salarial");
        IF LinAporteEmp.FINDFIRST THEN BEGIN
            BaseCalculo := ROUND("Importe Base" * LinAporteEmp."% Cotizable" / 100, 0.01);
            LinAporteEmp.Importe := BaseCalculo;
            LinAporteEmp.MODIFY;
        END;
    end;
}

