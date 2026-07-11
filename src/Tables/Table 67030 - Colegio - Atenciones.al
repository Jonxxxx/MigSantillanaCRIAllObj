table 67030 "Colegio - Atenciones"
{

    fields
    {
        field(1; "Cod. Colegio"; Code[20])
        {
            TableRelation = Contact WHERE(Type = CONST(Company));

            trigger OnValidate()
            begin
                IF "Cod. Atencion" <> '' THEN BEGIN
                    Col.GET("Cod. Atencion");
                    "Nombre Colegio" := Col."Search Name";
                END;
            end;
        }
        field(2; "Cod. Atencion"; Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Atenciones));
        }
        field(3; "Cod. promotor"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser" WHERE(Tipo = CONST(Vendedor));

            trigger OnValidate()
            begin
                IF "Cod. promotor" <> '' THEN BEGIN
                    Com.GET("Cod. promotor");
                    "Nombre Comercial" := Com.Name;
                END;
            end;
        }
        field(4; "Cod. Delegacion"; Code[20])
        {
        }
        field(5; "Cod. Nivel"; Code[20])
        {
            TableRelation = "Nivel Educativo";
        }
        field(6; "Cod. Turno"; Code[20])
        {
        }
        field(7; "Description Atencion"; Text[100])
        {
        }
        field(8; "Nombre Colegio"; Text[60])
        {
        }
        field(9; "Nombre Comercial"; Text[60])
        {
        }
        field(10; "Fecha Entrega"; Date)
        {
        }
        field(11; Cantidad; Integer)
        {
        }
        field(12; "Costo Unitario"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Cod. Colegio", "Cod. Atencion")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Col: Record 5050;
        Com: Record 13;
}

