tableextension 55013 EXCCRIItemLedgerEntry extends "Item Ledger Entry"
{
    fields
    {
        field(55000; "Cod. Procedencia"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Procedencia;
        }
        field(55001; "Cod. Edicion"; Code[20])
        {
            DataClassification = CustomerContent;
            // Ver TableRelation = 55130;
        }
        field(55002; Areas; Code[20])
        {
            DataClassification = CustomerContent;
            // Ver TableRelation = 55131;
        }
        field(55003; "No. Paginas"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55004; ISBN; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(55005; "Componentes Prod."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Componentes Prod.";
        }
        field(55006; "Nivel Educativo"; Code[20])
        {
            DataClassification = CustomerContent;
            // Ver TableRelation = 55132;
        }
        field(55007; Cursos; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Cursos;
        }
        field(55008; "Precio Unitario Cons. Inicial"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55009; "Descuento % Cons. Inicial"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55010; "Importe Cons. bruto Inicial"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55011; "Importe Cons. Neto Inicial"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55012; "Cant. Consignacion Pendiente"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55013; "No. Mov. Prod. Cosg. a Liq."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(55014; "Pedido Consignacion"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(55015; "Devolucion Consignacion"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(55016; "Descripcion Producto"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            Editable = false;
        }
        field(55017; "Precio Unitario Cons. Act."; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55018; "Descuento % Cons. Actualizado"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55019; "Importe Cons. bruto Act."; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55020; "Importe Cons. Neto Act."; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55021; "Ult. Fecha Act. Imp. Consig."; Date)
        {
            Caption = 'Consig. Amount Last update';
            DataClassification = CustomerContent;
        }
        field(55245; "No aplica Derechos de Autor"; Boolean)
        {
            Caption = 'Apply Author Copyright';
            DataClassification = CustomerContent;
        }
        field(55246; Promocion; Boolean)
        {
            Caption = 'Promotion';
            DataClassification = CustomerContent;
        }
        field(55469; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = Contact;
        }
        field(55470; "Cod. Vendedor"; Code[20])
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
