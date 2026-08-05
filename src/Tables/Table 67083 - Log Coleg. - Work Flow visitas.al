table 67083 "Log Coleg. - Work Flow visitas"
{

    fields
    {
        field(1; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Colegio';
            TableRelation = "Contact Alt. Addr. Date Range";
        }
        field(2; Secuencia; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Secuencia';
        }
        field(3; Resultado; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Resultado';
        }
        field(4; Programado; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Programado';
        }
        field(5; Paso; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Paso';
        }
        field(6; Detalle; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Detalle';
        }
        field(7; Mantenimiento; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Mantenimiento';
        }
        field(8; Conquista; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Conquista';
        }
        field(9; "Area"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Area';
        }
        field(10; Fecha; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha';
        }
        field(11; "Cod. Promotor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Promotor';
            //TODO Ver: TableRelation = "Salesperson/Purchaser" WHERE("Tipo" = CONST(Vendedor));
        }
    }

    keys
    {
        key(Key1; Fecha, "Cod. Promotor", "Cod. Colegio", Secuencia)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    var
        CWF: Record 55529;
    begin
    end;
}

