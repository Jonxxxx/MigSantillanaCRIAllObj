table 67039 "Promotor - Entrega Muestras"
{
    DrillDownPageID = 67039;
    LookupPageID = 67039;

    fields
    {
        field(1; "Cod. Promotor"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser" WHERE("Tipo" = CONST(Vendedor));
        }
        field(2; "Cod. Colegio"; Code[20])
        {
            TableRelation = Contact WHERE("Type" = CONST(Company));
        }
        field(3; Fecha; Date)
        {
        }
        field(4; "Nombre Colegio"; Text[60])
        {
        }
        field(5; Estado; Text[30])
        {
        }
        field(6; "Fecha Visita"; Date)
        {
        }
        field(7; "Hora Inicial Visita"; Time)
        {
        }
        field(8; "Hora Inicial Final"; Time)
        {
        }
        field(9; "Fecha Proxima Visita"; Date)
        {
        }
        field(10; Comentario; Text[150])
        {
        }
        field(11; "Fecha Devolucion Planificada"; Date)
        {
        }
        field(12; "Fecha Devolucion Realizada"; Date)
        {
        }
        field(13; "Documento referencia"; Code[20])
        {
        }
        field(14; "No. pedido de venta"; Code[20])
        {
        }
        field(15; Facturado; Boolean)
        {
        }
        field(16; Cantidad; Decimal)
        {

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
        }
        field(19; "Cantidad Presupuestada"; Decimal)
        {
            CalcFormula = Lookup("Promotor - Ppto Muestras".Quantity WHERE("Cod. Promotor" = FIELD("Cod. Promotor"),
                                                                            Cod. Producto=FIELD("Cod. Producto")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(20;"Cantidad consumida";Decimal)
        {
            CalcFormula = Sum("Promotor - Entrega Muestras".Cantidad WHERE ("Cod. Promotor"=FIELD("Cod. Promotor"),
                                                                            Cod. Producto=FIELD("Cod. Producto")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"Cod. Promotor","Cod. Colegio","Cod. Producto",Fecha)
        {
            SumIndexFields = Cantidad;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        PromPlanifVisit.SETRANGE("Cod. Promotor","Cod. Promotor");
        PromPlanifVisit.SETRANGE("Cod. Colegio","Cod. Colegio");
        PromPlanifVisit.SETRANGE(Fecha,Fecha);
        PromPlanifVisit.FINDFIRST;

        "Fecha Visita"         := PromPlanifVisit."Fecha Visita";
        "Hora Inicial Visita"  := PromPlanifVisit."Hora Inicial Visita";
        "Hora Inicial Final"   := PromPlanifVisit."Hora Final Visita";
        "Fecha Proxima Visita" := PromPlanifVisit."Fecha Proxima Visita";
    end;

    var
        Prod: Record 27;
        PromPlanifVisit: Record 67038;
        PromPptoMuestras: Record 67028;
        Err001: Label 'The sum o the samples for this salesperson exceed the budget''s quantity';
        Err002: Label 'Item %1 is not in the budget for this Salesperson';
}

