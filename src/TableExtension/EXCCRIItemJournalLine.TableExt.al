tableextension 55244 EXCCRIItemJournalLine extends "Item Journal Line"
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

        field(55225; "No. Paginas"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55226; "Componentes Producto"; Text[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Componentes Prod.";
        }
        field(55227; ISBN; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(55228; "Cod. Procedencia"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Procedencia;
        }
        field(55229; "Cod. Edicion"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Edicion;
        }
        field(55230; Areas; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(55231; "Nivel Educativo"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Nivel Educativo";
        }
        field(55232; Cursos; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Cursos;
        }
        field(55233; "Precio Unitario Cons. Inicial"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55234; "Descuento % Cons. Inicial"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55235; "Importe Cons. bruto Inicial"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55236; "Importe Cons Neto Inicial"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55237; "No. Mov. Prod. Cosg. a Liq."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(55239; "Pedido Consignacion"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(55240; "Devolucion Consignacion"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(55241; "Precio Unitario Cons. Act."; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55242; "Descuento % Cons. Actualizado"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55243; "Importe Cons. bruto Act."; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55244; "Importe Cons. Neto Actualizado"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(56020; "No aplica Derechos de Autor"; Boolean)
        {
            Caption = 'Apply Author Copyright';
            DataClassification = CustomerContent;
        }
        field(56021; Promocion; Boolean)
        {
            Caption = 'Promotion';
            DataClassification = CustomerContent;
        }
        field(56022; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Contact;
        }
        field(34002500; Barcode; Code[22])
        {
            Caption = 'Barcode';
            DataClassification = CustomerContent;

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
