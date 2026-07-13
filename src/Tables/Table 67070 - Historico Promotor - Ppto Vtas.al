table 67070 "Historico Promotor - Ppto Vtas"
{
    DrillDownPageID = 67027;
    LookupPageID = 67027;

    fields
    {
        field(1; "Cod. Promotor"; Code[20])
        {
            //TODO Ver: TableRelation = "Salesperson/Purchaser" WHERE("Tipo" = CONST(Vendedor));

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
        }
        field(6; "Cantidad camp. anterior"; Decimal)
        {
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
        field(20; "Campana"; Code[4])
        {
            TableRelation = Campaign;
        }
    }

    keys
    {
        key(Key1; "Campana", "Cod. Promotor", "Cod. Producto")
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

