table 55747 "Param. Inic. Conceptos Sal."
{
    Caption = 'Clear Wedges';
    //IGNORAR: Page no existe DrillDownPageID = 55791;
    //IGNORAR: Page no existe LookupPageID = 55791;

    fields
    {
        field(1; Codigo; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
            TableRelation = "Conceptos salariales".Codigo;

            trigger OnValidate()
            var
                ConfNom: Record 55744;
            begin
                ConfNom.GET();
                rConceptoSalarial.GET(Codigo);
                Descripcion := rConceptoSalarial.Descripcion;
                "Tipo concepto" := rConceptoSalarial."Tipo concepto";
            end;
        }
        field(2; Descripcion; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(3; "Tipo concepto"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo concepto';
            Description = 'Ingresos,Deducciones,Bases';
            OptionCaption = 'Income,Deduction';
            OptionMembers = Ingresos,Deducciones;
        }
        field(4; "Inicializa Cantidad"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inicializa Cantidad';
        }
        field(5; "Inicializa Importe"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inicializa Importe';

            trigger OnValidate()
            begin
                rLinPerfilSal.RESET;
                rLinPerfilSal.SETRANGE("Concepto salarial", Codigo);
                rLinPerfilSal.SETFILTER("Formula Calculo", '<>%1', ' ');
                IF rLinPerfilSal.FINDFIRST THEN
                    IF "Inicializa Importe" THEN
                        ERROR(Err001);
            end;
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
        rConceptoSalarial: Record 55752;
        rLinPerfilSal: Record 55756;
        Err001: Label 'This wedge''s concept has formula, amount can''t be cleared';
}

