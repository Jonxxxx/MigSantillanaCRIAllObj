table 34002119 "Conceptos Salariales Provision"
{

    fields
    {
        field(1; "Código"; Code[20])
        {
            TableRelation = "Conceptos salariales".Código;
        }
        field(2; Disponible; Code[20])
        {
            TableRelation = "Conceptos salariales".Código;

            trigger OnValidate()
            begin
                //IF Código = Disponible THEN
                //   ERROR(Err001);
            end;
        }
        field(3; "Tipo provision"; Option)
        {
            Caption = 'Provition type';
            OptionCaption = 'Variable,Fix,Formula';
            OptionMembers = Variable,Fix,Formula;
        }
        field(4; "Gpo. Contable Empleado"; Code[20])
        {
            TableRelation = "Grupos Contables Empleados";
        }
        field(6; "No. Cuenta"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(7; "No. Cuenta Contrapartida"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(8; "Validar Contrapartida"; Boolean)
        {
        }
        field(11; "Fórmula cálculo"; Text[150])
        {
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnLookup()
            var
                ConcepSalar: Record 34002111;
            begin
                //TODO: Ver 
                /*
                FormConcSalariales.LOOKUPMODE(TRUE);
                IF FormConcSalariales.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    CLEAR(ConcepSalar);
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
                    Regpolaca.DELETEALL;
                    RegFormula.DELETEALL;
                    Regconceptos.DELETEALL;

                    Regconceptos.Formula := DELCHR("Fórmula cálculo", '=', ' ');
                    RegFormula.SETRANGE(Formula, Regconceptos.Formula);
                    IF RegFormula.COUNT = 0 THEN BEGIN
                        Regconceptos.Formula := "Fórmula cálculo";
                        //TODO: Ver Scanner.RUN(Regconceptos);
                        //TODO: Ver Parser.RUN(Regconceptos);
                    END;

                    Regconceptos.Concepto := 'resultado';
                    IF NOT Regconceptos.INSERT THEN
                        Regconceptos.MODIFY;

                    Regpolaca.RESET;
                    Regpolaca.SETRANGE(Formula, Regconceptos.Formula);
                    IF Regpolaca.FINDSET THEN
                        REPEAT
                            IF COPYSTR(Regpolaca.Token, 1, 1) = '#' THEN
                                CASE Regpolaca.Token OF
                                    '#1':
                                        Regconceptos.Concepto := Regpolaca.Token;
                                END;

                            IF NOT Regconceptos.INSERT THEN
                                Regconceptos.MODIFY;
                        UNTIL Regpolaca.NEXT = 0;
                END;
            end;
        }
    }

    keys
    {
        key(Key1; "Código", "Gpo. Contable Empleado")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Err001: Label 'Wedge Salary code can''t be equal to Wedge base salary code';
        RegFormula: Record 34002143 temporary;
        Regconceptos: Record 34002144;
        Regpolaca: Record 34002143 temporary;
    //TODO: Ver Scanner: Codeunit 34002106;
    //TODO: Ver Parser: Codeunit 34002105;
    //TODO: Ver FormConcSalariales: Page 34002110;
}

