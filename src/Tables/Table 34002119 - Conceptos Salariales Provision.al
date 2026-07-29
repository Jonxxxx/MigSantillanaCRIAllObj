table 34002119 "Conceptos Salariales Provision"
{

    fields
    {
        field(1; "Codigo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(2; Disponible; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Disponible';
            TableRelation = "Conceptos salariales".Codigo;

            trigger OnValidate()
            begin
                //IF Codigo = Disponible THEN
                //   ERROR(Err001);
            end;
        }
        field(3; "Tipo provision"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo provision';
            OptionCaption = 'Variable,Fix,Formula';
            OptionMembers = Variable,Fix,Formula;
        }
        field(4; "Gpo. Contable Empleado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Gpo. Contable Empleado';
            TableRelation = "Grupos Contables Empleados";
        }
        field(6; "No. Cuenta"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Cuenta';
            TableRelation = "G/L Account";
        }
        field(7; "No. Cuenta Contrapartida"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Cuenta Contrapartida';
            TableRelation = "G/L Account";
        }
        field(8; "Validar Contrapartida"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Validar Contrapartida';
        }
        field(11; "Formula Calculo"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Formula Calculo';
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnLookup()
            var
                ConcepSalar: Record 34002111;
            begin

                /*
                FormConcSalariales.LOOKUPMODE(TRUE);
                IF FormConcSalariales.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    CLEAR(ConcepSalar);
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
                    Regpolaca.DELETEALL;
                    RegFormula.DELETEALL;
                    Regconceptos.DELETEALL;

                    Regconceptos.Formula := DELCHR("Formula Calculo", '=', ' ');
                    RegFormula.SETRANGE(Formula, Regconceptos.Formula);
                    IF RegFormula.COUNT = 0 THEN BEGIN
                        Regconceptos.Formula := "Formula Calculo";
                        Scanner.RUN(Regconceptos);
                        Parser.RUN(Regconceptos);
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
        key(Key1; "Codigo", "Gpo. Contable Empleado")
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
        Scanner: Codeunit 34002106;
        Parser: Codeunit 34002105;
        FormConcSalariales: Page 34002110;
}

