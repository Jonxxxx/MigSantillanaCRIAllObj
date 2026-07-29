table 67054 "TMP Reportes APS"
{

    fields
    {
        field(1; "No. Movimiento"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Movimiento';
        }
        field(2; "Cod. Editorial"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Editorial';
            NotBlank = true;
            TableRelation = Editoras;
        }
        field(3; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Colegio';
            NotBlank = true;
            TableRelation = Contact WHERE("Type" = CONST(Company));
        }
        field(4; "Cod. Local"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Local';
            TableRelation = "Contact Alt. Address".Code WHERE("Contact No." = FIELD("Cod. Colegio"));
        }
        field(5; "Cod. Nivel"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Nivel';
            NotBlank = true;
            TableRelation = "Colegio - Nivel"."Cod. Nivel" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"));
        }
        field(6; "Cod. Grado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Grado';
            NotBlank = true;
        }
        field(7; "Cod. Turno"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Turno';
        }
        field(8; "Cod. Promotor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Promotor';
            TableRelation = "Salesperson/Purchaser" WHERE("Tipo" = CONST(Vendedor));
        }
        field(9; "Cod. Producto"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Producto';
            NotBlank = true;
            TableRelation = Item;
        }
        field(10; "Grupo de negocio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Grupo de negocio';
        }
        field(11; "Linea de negocio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Linea de negocio';
        }
        field(12; Familia; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Familia';
        }
        field(13; "Sub Familia"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sub Familia';
        }
        field(14; Serie; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Serie';
        }
        field(15; "Cantidad Alumnos"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad Alumnos';
            DecimalPlaces = 0 : 0;
        }
        field(16; Adopcion; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Adopcion';
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ",Conquista,Mantener,Perdida,Retiro;
        }
        field(17; "Cant. Presupuestada"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cant. Presupuestada';
        }
    }

    keys
    {
        key(Key1; "No. Movimiento")
        {
        }
        key(Key2; "Cod. Colegio", "Grupo de negocio", "Cod. Grado", "Cod. Turno", "Cod. Promotor", "Cod. Producto")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Promotor: Record 13;
        date: Record 2000000007;
        fFechas: Page 67062;
}

