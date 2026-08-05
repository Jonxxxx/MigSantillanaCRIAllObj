table 67039 "Promotor - Entrega Muestras"
{
    DrillDownPageID = 67039;
    LookupPageID = 67039;

    fields
    {
        field(1; "Cod. Promotor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Promotor';
            TableRelation = "Salesperson/Purchaser" WHERE("Tipo" = CONST(Vendedor));
        }
        field(2; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Colegio';
            TableRelation = Contact WHERE("Type" = CONST(Company));
        }
        field(3; Fecha; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha';
        }
        field(4; "Nombre Colegio"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Colegio';
        }
        field(5; Estado; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Estado';
        }
        field(6; "Fecha Visita"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Visita';
        }
        field(7; "Hora Inicial Visita"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora Inicial Visita';
        }
        field(8; "Hora Inicial Final"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora Inicial Final';
        }
        field(9; "Fecha Proxima Visita"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Proxima Visita';
        }
        field(10; Comentario; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Comentario';
        }
        field(11; "Fecha Devolucion Planificada"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Devolucion Planificada';
        }
        field(12; "Fecha Devolucion Realizada"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Devolucion Realizada';
        }
        field(13; "Documento referencia"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Documento referencia';
        }
        field(14; "No. pedido de venta"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. pedido de venta';
        }
        field(15; Facturado; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Facturado';
        }
        field(16; Cantidad; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad';

            trigger OnValidate()
            begin
                PromPptoMuestras.RESET;
                PromPptoMuestras.SETRANGE("Cod. Promotor", "Cod. Promotor");
                PromPptoMuestras.SETRANGE("Cod. Producto", "Cod. Producto");
                IF NOT PromPptoMuestras.FINDFIRST THEN
                    ERROR(Err002, "Cod. Producto");

                PromPptoMuestras.CALCFIELDS("Cantidad consumida");
                IF (PromPptoMuestras."Cantidad consumida" + Cantidad > PromPptoMuestras.Quantity) AND
                   (PromPptoMuestras."Cantidad consumida" <> 0) OR (Cantidad > PromPptoMuestras.Quantity) THEN
                    ERROR(Err001);
            end;
        }
        field(17; "Cod. Producto"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Producto';
            TableRelation = Item;

            trigger OnValidate()
            begin
                Prod.GET("Cod. Producto");
                "Descripcion producto" := Prod.Description;

                PromPptoMuestras.RESET;
                PromPptoMuestras.SETRANGE("Cod. Promotor", "Cod. Promotor");
                PromPptoMuestras.SETRANGE("Cod. Producto", "Cod. Producto");
                IF NOT PromPptoMuestras.FINDFIRST THEN
                    ERROR(Err002, "Cod. Producto");
            end;
        }
        field(18; "Descripcion producto"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion producto';
        }
        field(19; "Cantidad Presupuestada"; Decimal)
        {
            Caption = 'Cantidad Presupuestada';
            CalcFormula = Lookup("Promotor - Ppto Muestras".Quantity WHERE("Cod. Promotor" = FIELD("Cod. Promotor"),
                                                                            "Cod. Producto" = FIELD("Cod. Producto")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Cantidad consumida"; Decimal)
        {
            Caption = 'Cantidad consumida';
            CalcFormula = Sum("Promotor - Entrega Muestras".Cantidad WHERE("Cod. Promotor" = FIELD("Cod. Promotor"),
                                                                            "Cod. Producto" = FIELD("Cod. Producto")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Cod. Promotor", "Cod. Colegio", "Cod. Producto", Fecha)
        {
            SumIndexFields = Cantidad;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        PromPlanifVisit.SETRANGE("Cod. Promotor", "Cod. Promotor");
        PromPlanifVisit.SETRANGE("Cod. Colegio", "Cod. Colegio");
        PromPlanifVisit.SETRANGE(Fecha, Fecha);
        PromPlanifVisit.FINDFIRST;

        "Fecha Visita" := PromPlanifVisit."Fecha Visita";
        "Hora Inicial Visita" := PromPlanifVisit."Hora Inicial Visita";
        "Hora Inicial Final" := PromPlanifVisit."Hora Final Visita";
        "Fecha Proxima Visita" := PromPlanifVisit."Fecha Proxima Visita";
    end;

    var
        Prod: Record 27;
        PromPlanifVisit: Record 67038;
        PromPptoMuestras: Record 55495;
        Err001: Label 'The sum o the samples for this salesperson exceed the budget''s quantity';
        Err002: Label 'Item %1 is not in the budget for this Salesperson';
}

