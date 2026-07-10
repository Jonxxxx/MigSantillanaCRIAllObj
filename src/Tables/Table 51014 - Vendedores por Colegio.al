table 51014 "Vendedores por Colegio"
{
    Caption = 'School SalesPerson';
    DrillDownPageID = 51010;
    LookupPageID = 51010;

    fields
    {
        field(1; "Cod. Colegio"; Code[20])
        {
            Caption = 'School Code';
        }
        field(2; "Cod. Vendedor"; Code[20])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            begin
                IF rSalesPerson.GET("Cod. Vendedor") THEN
                    "Nombre Vendedor" := rSalesPerson.Name;
            end;
        }
        field(3; "Nombre Vendedor"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Cod. Colegio", "Cod. Vendedor")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //Replicador
        rRec.GETTABLE(Rec);
        //GRN cuReplicatorFun.OnDelete(rRec);
        //Replicador
    end;

    var
        rSalesPerson: Record 13;
        rRec: RecordRef;
}

