table 67027 "Promotor - Ppto Vtas"
{
    DrillDownPageID = 67027;
    LookupPageID = 67027;

    fields
    {
        field(1; "Cod. Promotor"; Code[20])
        {
            //TOOD: Ver TableRelation = "Salesperson/Purchaser" WHERE("Tipo" = CONST(Vendedor));

            trigger OnValidate()
            begin
                IF Prom.GET("Cod. Promotor") THEN
                    "Nombre Promotor" := Prom.Name;
            end;
        }
        field(2; "Cod. Producto"; Code[20])
        {
            TableRelation = Item;

            trigger OnValidate()
            begin
                IF Item.GET("Cod. Producto") THEN
                    "Item Description" := Item.Description;

                //TOOD: Ver Item.TESTFIELD("Nivel Escolar (Grado)");
                //TOOD: Ver Item.TESTFIELD("Nivel Educativo APS");
                //TOOD: Ver Item.TESTFIELD("Grupo de Negocio");

                IF ProdEquivalente.GET("Cod. Producto") THEN
                    "Cod. producto equivalente" := ProdEquivalente."Cod. Producto Anterior";
            end;
        }
        field(3; "Nombre Promotor"; Text[60])
        {
        }
        field(4; "Item Description"; Text[100])
        {
            Caption = 'Item Description';
        }
        field(5; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 0;
        }
        field(6; "Cantidad camp. anterior"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(7; "Cod. producto equivalente"; Code[20])
        {
            TableRelation = Item;
        }
        field(8; Adopcion; Code[1])
        {
            ValuesAllowed = 'C,M,P,R';
        }
        field(9; "Adopcion anterior"; Code[1])
        {
        }
        field(10; "Cantidad Adoptada"; Decimal)
        {
            CalcFormula = Sum("Colegio - Adopciones Detalle"."Adopcion Real" WHERE("Cod. Promotor" = FIELD("Cod. Promotor"),
                                                                                    "Adopcion" = FILTER(Conquista .. Mantener),
                                                                                    "Cod. Producto" = FIELD("Cod. Producto")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Cod. Promotor", "Cod. Producto")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Prom: Record 13;
        Item: Record 27;
        ProdEquivalente: Record 67005;
}

