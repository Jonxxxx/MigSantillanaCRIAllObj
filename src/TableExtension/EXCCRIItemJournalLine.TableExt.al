tableextension 50019 EXCCRIItemJournalLine extends "Item Journal Line"
{
    fields
    {
        modify("Item No.")
        {
            TableRelation = Item where(Inactivo = const(false));
        }
        modify("Location Code")
        {
            TableRelation = Location where(Inactivo = const(false));
        }
        modify("New Location Code")
        {
            TableRelation = Location where(Inactivo = const(false));
        }
        modify("Originally Ordered No.")
        {
            TableRelation = Item where(Inactivo = const(false));
        }
        modify("Invoice-to Source No.")
        {
            TableRelation =
                if ("Source Type" = const(Customer)) Customer where(Inactivo = const(false))
            else if ("Source Type" = const(Vendor)) Vendor where(Inactivo = const(false));
        }
        modify("Gen. Bus. Posting Group")
        {
            trigger OnAfterValidate()
            var
                EXCCRIGenBusinessPostingGroup: Record "Gen. Business Posting Group";
            begin
                if EXCCRIGenBusinessPostingGroup.Get("Gen. Bus. Posting Group") then
                    Promocion := EXCCRIGenBusinessPostingGroup.Promocion;
            end;
        }

        field(50000; "No. Paginas"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Componentes Producto"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Componentes Prod.";
        }
        field(50002; ISBN; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Cod. Procedencia"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Procedencia;
        }
        field(50004; "Cod. Edicion"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Edicion;
        }
        field(50005; Areas; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Nivel Educativo"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Nivel Educativo";
        }
        field(50007; Cursos; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Cursos;
        }
        field(50008; "Precio Unitario Cons. Inicial"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Descuento % Cons. Inicial"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Importe Cons. bruto Inicial"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Importe Cons Neto Inicial"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "No. Mov. Prod. Cosg. a Liq."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Pedido Consignacion"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Devolucion Consignacion"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Precio Unitario Cons. Act."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Descuento % Cons. Actualizado"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Importe Cons. bruto Act."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Importe Cons. Neto Actualizado"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(56020; "No aplica Derechos de Autor"; Boolean)
        {
            Caption = 'Apply Author Copyright';
            DataClassification = ToBeClassified;
        }
        field(56021; Promocion; Boolean)
        {
            Caption = 'Promotion';
            DataClassification = ToBeClassified;
        }
        field(56022; "Cod. Colegio"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Contact;
        }
        field(34002500; Barcode; Code[22])
        {
            Caption = 'Barcode';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                EXCCRIItemReference: Record "Item Reference";
            begin
                EXCCRIItemReference.SetCurrentKey("Reference No.");
                EXCCRIItemReference.SetRange("Reference No.", Barcode);
                EXCCRIItemReference.FindFirst();

                Validate("Item No.", EXCCRIItemReference."Item No.");
                if EXCCRIItemReference."Unit of Measure" <> '' then
                    Validate(
                        "Unit of Measure Code",
                        EXCCRIItemReference."Unit of Measure");
                if EXCCRIItemReference."Variant Code" <> '' then
                    Validate(
                        "Variant Code",
                        EXCCRIItemReference."Variant Code");
            end;
        }
    }
}
