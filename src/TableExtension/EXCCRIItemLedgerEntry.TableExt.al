tableextension 55238 EXCCRIItemLedgerEntry extends "Item Ledger Entry"
{
    fields
    {
        field(55225; "Cod. Procedencia"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Procedencia;
        }
        field(55226; "Cod. Edicion"; Code[20])
        {
            DataClassification = CustomerContent;
            // Ver TableRelation = 55130;
        }
        field(55227; Areas; Code[20])
        {
            DataClassification = CustomerContent;
            // Ver TableRelation = 55131;
        }
        field(55228; "No. Paginas"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55229; ISBN; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(55230; "Componentes Prod."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Componentes Prod.";
        }
        field(55231; "Nivel Educativo"; Code[20])
        {
            DataClassification = CustomerContent;
            // Ver TableRelation = 55132;
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
        field(55236; "Importe Cons. Neto Inicial"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55237; "Cant. Consignacion Pendiente"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55238; "No. Mov. Prod. Cosg. a Liq."; Integer)
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
        field(55241; "Descripcion Producto"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            Editable = false;
        }
        field(55242; "Precio Unitario Cons. Act."; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55243; "Descuento % Cons. Actualizado"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55244; "Importe Cons. bruto Act."; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55245; "Importe Cons. Neto Act."; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55246; "Ult. Fecha Act. Imp. Consig."; Date)
        {
            Caption = 'Consig. Amount Last update';
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
        field(67002; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = Contact;
        }
        field(67003; "Cod. Vendedor"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser";
        }
    }

    keys
    {
        key(EXCCRIConsignmentAmounts; "Location Code", Open)
        {
            // Ver SumIndexFields = "Importe Cons. Neto Inicial", "Importe Cons. Neto Act.";
        }
        key(EXCCRIConsignmentOrder; "Pedido Consignacion")
        {
        }
        key(EXCCRIConsignmentPosting; "Posting Date", "Location Code")
        {
            // Ver SumIndexFields = "Importe Cons. bruto Inicial", "Importe Cons. Neto Inicial";
        }
    }
}
