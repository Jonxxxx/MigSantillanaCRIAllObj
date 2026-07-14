table 34002106 "Param. Inic. Conceptos Sal."
{
    Caption = 'Clear Wedges';
    //TODO: Ver DrillDownPageID = 34002150;
    //TODO: Ver LookupPageID = 34002150;

    fields
    {
        field(1; Codigo; Code[20])
        {
            Caption = 'Code';
            TableRelation = "Conceptos salariales".Codigo;

            trigger OnValidate()
            var
                ConfNom: Record 34002103;
            begin
                ConfNom.GET();
                rConceptoSalarial.GET(Codigo);
                Descripcion := rConceptoSalarial.Descripcion;
                "Tipo concepto" := rConceptoSalarial."Tipo concepto";
            end;
        }
        field(2; Descripcion; Text[60])
        {
            Caption = 'Description';
        }
        field(3; "Tipo concepto"; Option)
        {
            Caption = 'Wedge type';
            Description = 'Ingresos,Deducciones,Bases';
            OptionCaption = 'Income,Deduction';
            OptionMembers = Ingresos,Deducciones;
        }
        field(4; "Inicializa Cantidad"; Boolean)
        {
            Caption = 'Clear Quantity';
        }
        field(5; "Inicializa Importe"; Boolean)
        {
            Caption = 'Clear Amount';

            trigger OnValidate()
            begin
                rLinPerfilSal.RESET;
                rLinPerfilSal.SETRANGE("Concepto salarial", Codigo);
                rLinPerfilSal.SETFILTER("Fórmula cálculo", '<>%1', ' ');
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
        rConceptoSalarial: Record 34002111;
        rLinPerfilSal: Record 34002115;
        Err001: Label 'This wedge''s concept has formula, amount can''t be cleared';
}

