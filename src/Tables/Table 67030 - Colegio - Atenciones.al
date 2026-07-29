table 67030 "Colegio - Atenciones"
{

    fields
    {
        field(1; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Colegio';
            TableRelation = Contact WHERE("Type" = CONST(Company));

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
            DataClassification = CustomerContent;
            Caption = 'Cod. Atencion';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Atenciones));
        }
        field(3; "Cod. promotor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. promotor';
            //TOOD: Ver TableRelation = "Salesperson/Purchaser" WHERE("Tipo" = CONST(Vendedor));

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
            DataClassification = CustomerContent;
            Caption = 'Cod. Delegacion';
        }
        field(5; "Cod. Nivel"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Nivel';
            TableRelation = "Nivel Educativo";
        }
        field(6; "Cod. Turno"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Turno';
        }
        field(7; "Description Atencion"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description Atencion';
        }
        field(8; "Nombre Colegio"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Colegio';
        }
        field(9; "Nombre Comercial"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Comercial';
        }
        field(10; "Fecha Entrega"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Entrega';
        }
        field(11; Cantidad; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad';
        }
        field(12; "Costo Unitario"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Costo Unitario';
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

