table 55754 "Perfil Salario x Cargo"
{

    fields
    {
        field(1; "Puesto de Trabajo"; Code[15])
        {
            DataClassification = CustomerContent;
            Caption = 'Puesto de Trabajo';
            TableRelation = "Puestos laborales".Codigo;

            trigger OnValidate()
            begin
                IF "Puesto de Trabajo" <> '' THEN BEGIN
                    Cargos.GET("Puesto de Trabajo");
                END;
            end;
        }
        field(2; "Concepto salarial"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto salarial';
            TableRelation = "Conceptos salariales".Codigo;

            trigger OnValidate()
            begin
                ConfNominas.GET();
                Conceptos.GET("Concepto salarial");
                Descripcion := Conceptos.Descripcion;
                "Tipo concepto" := Conceptos."Tipo concepto";
            end;
        }
        field(3; "No. de Orden"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. de Orden';
            Editable = false;
            Enabled = false;
        }
        field(4; "Descripcion"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(7; "Tipo concepto"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo concepto';
            Description = 'Ingresos,Deducciones';
            OptionMembers = Ingresos,Deducciones;
        }
        field(12; "1ra Quincena"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = '1ra Quincena';
        }
        field(13; "2da Quincena"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = '2da Quincena';
        }
        field(15; "Formula Calculo"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Formula Calculo';
        }
    }

    keys
    {
        key(Key1; "Puesto de Trabajo", "Concepto salarial")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Conceptos: Record 55752;
        Cargos: Record 55751;
        RegFormula: Record 55784;
        Regconceptos: Record 55785;
        Regpolaca: Record 55784;
        Percept: Record 5200;
        RegLinConvenio: Record 55754;
        LinConvFormula: Record 55754;
        Scanner: Codeunit 55747;
        Parser: Codeunit 55746;
        Calculadora: Codeunit 55748;
        ConfNominas: Record 55744;
        ok: Boolean;
        Msg001: Label 'The Concept %1 was not found in the table %2, please verify';
        FormConcSalariales: Page 55751;
}

