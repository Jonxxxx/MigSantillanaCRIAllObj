table 34002105 "Dist. Ctas. Gpo. Cont. Empl."
{
    Caption = 'Distribucion Ctas. Gpo. Contable Empleados';
    DataCaptionFields = "Codigo";
    DrillDownPageID = 34002140;
    LookupPageID = 34002140;

    fields
    {
        field(1; "Codigo"; Code[10])
        {
        }
        field(2; "Descripcion"; Text[50])
        {
        }
        field(3; "Shortcut Dimension"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = Dimension.Code;
        }
        field(4; "Codigo Concepto Salarial"; Code[20])
        {
            TableRelation = "Conceptos salariales".Codigo;

            trigger OnValidate()
            begin
                ConfNom.GET();
                ConceptosSal.SETRANGE("Shortcut Dimension", ConfNom."Dimension Conceptos Salariales");
                ConceptosSal.SETRANGE(Codigo, "Codigo Concepto Salarial");
                ConceptosSal.FINDFIRST;
                "Shortcut Dimension" := ConceptosSal."Shortcut Dimension";
                Descripcion := ConceptosSal.Descripcion;
                "Tipo Cuenta Cuota Obrera" := ConceptosSal."Tipo Cuenta Cuota Obrera";
                "Tipo Cuenta Cuota Patronal" := ConceptosSal."Tipo Cuenta Cuota Patronal";
                "No. Cuenta Cuota Patronal" := ConceptosSal."No. Cuenta Cuota Patronal";
            end;
        }
        field(5; "Tipo Cuenta Cuota Obrera"; Option)
        {
            OptionCaption = 'G/L Account,Vendor,Customer';
            OptionMembers = Cuenta,Proveedor,Cliente;
        }
        field(6; "No. Cuenta Cuota Obrera"; Code[20])
        {
            TableRelation = IF ("Tipo Cuenta Cuota Obrera" = CONST(Cuenta)) "G/L Account"."No."
            ELSE IF ("Tipo Cuenta Cuota Obrera" = CONST(Proveedor)) Vendor."No.";
        }
        field(7; "Tipo Cuenta Cuota Patronal"; Option)
        {
            OptionCaption = 'G/L Account,Vendor';
            OptionMembers = Cuenta,Proveedor;
        }
        field(8; "No. Cuenta Cuota Patronal"; Code[20])
        {
            TableRelation = IF ("Tipo Cuenta Cuota Patronal" = CONST(Cuenta)) "G/L Account"."No."
            ELSE IF ("Tipo Cuenta Cuota Patronal" = CONST(Proveedor)) Vendor."No.";
        }
        field(9; "Tipo Cuenta Contrapartida CO"; Option)
        {
            OptionCaption = 'G/L Account,Vendor';
            OptionMembers = Cuenta,Proveedor;
        }
        field(10; "No. Cuenta Contrapartida CO"; Code[20])
        {
            TableRelation = IF ("Tipo Cuenta Contrapartida CO" = CONST(Cuenta)) "G/L Account"."No."
            ELSE IF ("Tipo Cuenta Contrapartida CO" = CONST(Proveedor)) Vendor."No.";
        }
        field(11; "Tipo Cuenta Contrapartida CP"; Option)
        {
            OptionCaption = 'G/L Account,Vendor';
            OptionMembers = Cuenta,Proveedor;
        }
        field(12; "No. Cuenta Contrapartida CP"; Code[20])
        {
            TableRelation = IF ("Tipo Cuenta Contrapartida CP" = CONST(Cuenta)) "G/L Account"."No."
            ELSE IF ("Tipo Cuenta Contrapartida CP" = CONST(Proveedor)) Vendor."No.";
        }
        field(13; "% a Distribuir"; Decimal)
        {
            InitValue = 100;
            MaxValue = 100;
        }
        field(14; "No. Linea"; Integer)
        {
        }
        field(15; Provisionar; Boolean)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Codigo", "Shortcut Dimension", "Codigo Concepto Salarial", "No. Linea")
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

