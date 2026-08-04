table 55175 "Vendedores por Colegio"
{
    Caption = 'School SalesPerson';
    DrillDownPageID = 55171;
    LookupPageID = 55171;

    fields
    {
        field(1; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Colegio';
        }
        field(2; "Cod. Vendedor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Vendedor';
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            begin
                IF rSalesPerson.GET("Cod. Vendedor") THEN
                    "Nombre Vendedor" := rSalesPerson.Name;
            end;
        }
        field(3; "Nombre Vendedor"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Vendedor';
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

