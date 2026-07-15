tableextension 50013 EXCCRIItemLedgerEntry extends "Item Ledger Entry"
{
    fields
    {
        field(50000; "Cod. Procedencia"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Procedencia;
        }
        field(50001; "Cod. Edicion"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TODO: Ver TableRelation = 50131;
        }
        field(50002; Areas; Code[20])
        {
            DataClassification = ToBeClassified;
            //TODO: Ver TableRelation = 50132;
        }
        field(50003; "No. Paginas"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; ISBN; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Componentes Prod."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Componentes Prod.";
        }
        field(50006; "Nivel Educativo"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TODO: Ver TableRelation = 50133;
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
        field(50011; "Importe Cons. Neto Inicial"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Cant. Consignacion Pendiente"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "No. Mov. Prod. Cosg. a Liq."; Integer)
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
        field(50016; "Descripcion Producto"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            Editable = false;
        }
        field(50017; "Precio Unitario Cons. Act."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Descuento % Cons. Actualizado"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Importe Cons. bruto Act."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Importe Cons. Neto Act."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Ult. Fecha Act. Imp. Consig."; Date)
        {
            Caption = 'Consig. Amount Last update';
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
        field(67002; "Cod. Colegio"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Contact;
        }
        field(67003; "Cod. Vendedor"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
        }
    }

    keys
    {
        key(EXCCRIConsignmentAmounts; "Location Code", Open)
        {
            //TODO: Ver SumIndexFields = "Importe Cons. Neto Inicial", "Importe Cons. Neto Act.";
        }
        key(EXCCRIConsignmentOrder; "Pedido Consignacion")
        {
        }
        key(EXCCRIConsignmentPosting; "Posting Date", "Location Code")
        {
            //TODO: Ver SumIndexFields = "Importe Cons. bruto Inicial", "Importe Cons. Neto Inicial";
        }
    }
}
