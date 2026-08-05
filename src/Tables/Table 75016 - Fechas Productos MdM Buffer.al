table 55697 "Fechas Productos MdM Buffer"
{

    fields
    {
        field(1; "Cod Producto"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod Producto';
            TableRelation = Item;
        }
        field(10; "Fecha Alb Compra"; Date)
        {
            Caption = 'Fecha Alb Compra';
            CalcFormula = Min("Purch. Rcpt. Line"."Posting Date" WHERE("Type" = CONST(Item),
                                                                        "No." = FIELD("Cod Producto"),
                                                                        "Quantity" = FILTER(<> 0),
                                                                        "Correction" = CONST(false)));
            Description = 'Flowfield';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Fecha Alb Venta"; Date)
        {
            Caption = 'Fecha Alb Venta';
            CalcFormula = Min("Sales Shipment Line"."Posting Date" WHERE("Type" = CONST(Item),
                                                                          "No." = FIELD("Cod Producto"),
                                                                          "Quantity" = FILTER(<> 0),
                                                                          "Correction" = CONST(false)));
            Description = 'Flowfield';
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; "Fecha Fact Venta"; Date)
        {
            Caption = 'Fecha Fact Venta';
            CalcFormula = Min("Sales Invoice Line"."Posting Date" WHERE("Type" = CONST(Item),
                                                                         "No." = FIELD("Cod Producto"),
                                                                         "Quantity" = FILTER(<> 0)));
            Description = 'Flowfield';
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; "Tiene Componentes"; Boolean)
        {
            Caption = 'Tiene Componentes';
            CalcFormula = Exist("BOM Component" WHERE("Parent Item No." = FIELD("Cod Producto"),
                                                       "Type" = CONST(Item)));
            Description = 'Flowfield';
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "Es Componente"; Boolean)
        {
            Caption = 'Es Componente';
            CalcFormula = Exist("BOM Component" WHERE("Type" = CONST(Item),
                                                       "No." = FIELD("Cod Producto")));
            Description = 'Flowfield';
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; "Fecha Ensamblado"; Date)
        {
            Caption = 'Fecha Ensamblado';
            CalcFormula = Min("Posted Assembly Header"."Posting Date" WHERE("Item No." = FIELD("Cod Producto"),
                                                                             "Quantity" = FILTER(<> 0)));
            Description = 'Flowfield';
            Editable = false;
            FieldClass = FlowField;
        }
        field(25; CodProdEsamblado; Code[20])
        {
            Caption = 'CodProdEsamblado';
            CalcFormula = Lookup("BOM Component"."Parent Item No." WHERE("No." = FIELD("Cod Producto"),
                                                                          "Type" = CONST(Item)));
            Description = 'Flowfield, Si es componente, el producto ensamblado al que pertenece';
            Editable = false;
            FieldClass = FlowField;
        }
        field(55689; "Fecha Almacen"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Almacen';
            Description = 'MdM';
        }
        field(55690; "Fecha Comercializacion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Comercializacion';
            Description = 'MdM';
        }
    }

    keys
    {
        key(Key1; "Cod Producto")
        {
        }
    }

    fieldgroups
    {
    }
}

