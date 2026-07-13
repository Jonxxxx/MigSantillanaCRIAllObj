table 34002138 "Dist. Ctas. Gpo. Cont. x Dim."
{

    fields
    {
        field(1; "Código"; Code[10])
        {
        }
        field(2; "Descripción"; Text[50])
        {
        }
        field(3; "Shortcut Dimension"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = Dimension.Code;
        }
        field(4; "Código Concepto Salarial"; Code[20])
        {
            TableRelation = "Conceptos salariales".Código;

            trigger OnValidate()
            begin
                /*ConfNom.GET();
                ConceptosSal.SETRANGE("Shortcut Dimension",ConfNom."Dimension Conceptos Salariales");
                ConceptosSal.SETRANGE(Código,"Código Concepto Salarial");
                ConceptosSal.FINDFIRST;
                "Shortcut Dimension"         := ConceptosSal."Shortcut Dimension";
                Descripción                  := ConceptosSal.Descripción;
                "Tipo Cuenta Cuota Obrera"   := ConceptosSal."Tipo Cuenta Cuota Obrera";
                "Tipo Cuenta Cuota Patronal" := ConceptosSal."Tipo Cuenta Cuota Patronal";
                "No. Cuenta Cuota Patronal"  := ConceptosSal."No. Cuenta Cuota Patronal";
                */

            end;
        }
        field(5; Importe; Decimal)
        {
            InitValue = 100;
            MaxValue = 100;
        }
        field(6; "No. tarjeta"; Code[10])
        {
            TableRelation = "G/L Entry";
        }
        field(7; "Tipo de nomina"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Tipos de nominas";
        }
    }

    keys
    {
        key(Key1; "Código")
        {
        }
    }

    fieldgroups
    {
    }

    var
        ConfNom: Record 34002103;
        ConceptosSal: Record 34002111;
}

