table 55839 "Lin. Prestamos cooperativa"
{
    //IGNORAR: Page no existe DrillDownPageID = 55776;
    //IGNORAR: Page no existe LookupPageID = 55776;

    fields
    {
        field(1; "No. Prestamo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Prestamo';
        }
        field(2; "No. Cuota"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Cuota';
        }
        field(3; "Tipo prestamo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo prestamo';
            TableRelation = "Datos adicionales RRHH".Code WHERE("Tipo registro" = CONST("Tipo de Prestamo"));
        }
        field(5; "Fecha Transaccion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Transaccion';
        }
        field(6; "Codigo Empleado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Empleado';
            TableRelation = Employee;
        }
        field(7; "Saldo inicial"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Saldo inicial';

            trigger OnValidate()
            begin
                IF "Saldo inicial" > 0 THEN BEGIN
                    Interes := "Saldo inicial";
                    CLEAR("Importe cuota");
                END
                ELSE BEGIN
                    "Importe cuota" := "Saldo inicial" * -1;
                    CLEAR(Interes);
                END;
            end;
        }
        field(8; Interes; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Interes';

            trigger OnValidate()
            begin
                "Saldo inicial" := Interes;
            end;
        }
        field(9; "Importe cuota"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe cuota';

            trigger OnValidate()
            begin
                "Saldo inicial" := -"Importe cuota";
            end;
        }
        field(10; Capital; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Capital';
        }
        field(11; Saldo; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Saldo';
        }
        field(12; "Importe mora"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe mora';
        }
        field(13; "Fecha mora"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha mora';
        }
    }

    keys
    {
        key(Key1; "No. Prestamo", "No. Cuota")
        {
            SumIndexFields = "Saldo inicial", Interes, "Importe cuota";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        CabPrestamo.GET("No. Prestamo");

        "Tipo prestamo" := CabPrestamo."Tipo prestamo";
        "Codigo Empleado" := CabPrestamo."Employee No.";
    end;

    var
        CabPrestamo: Record 55838;
}

