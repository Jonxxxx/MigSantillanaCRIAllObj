table 34002198 "Lin. Prestamos cooperativa"
{
    //TODO: Page no existe DrillDownPageID = 34002135;
    //TODO: Page no existe LookupPageID = 34002135;

    fields
    {
        field(1; "No. Prestamo"; Code[20])
        {
            Caption = 'Loan no.';
        }
        field(2; "No. Cuota"; Integer)
        {
            Caption = 'Quote no.';
        }
        field(3; "Tipo prestamo"; Code[20])
        {
            Caption = 'Loan type';
            DataClassification = ToBeClassified;
            TableRelation = "Datos adicionales RRHH".Code WHERE("Tipo registro" = CONST("Tipo de préstamo"));
        }
        field(5; "Fecha Transaccion"; Date)
        {
            Caption = 'Transaction date';
        }
        field(6; "Codigo Empleado"; Code[20])
        {
            TableRelation = Employee;
        }
        field(7; "Saldo inicial"; Decimal)
        {
            Caption = 'Initial balance';

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
            Caption = 'Interest';

            trigger OnValidate()
            begin
                "Saldo inicial" := Interes;
            end;
        }
        field(9; "Importe cuota"; Decimal)
        {
            Caption = 'Fee amount';

            trigger OnValidate()
            begin
                "Saldo inicial" := -"Importe cuota";
            end;
        }
        field(10; Capital; Decimal)
        {
            Caption = 'Capital';
        }
        field(11; Saldo; Decimal)
        {
            Caption = 'Final balance';
            DataClassification = ToBeClassified;
        }
        field(12; "Importe mora"; Decimal)
        {
            Caption = 'Charge amount';
            DataClassification = ToBeClassified;
        }
        field(13; "Fecha mora"; Date)
        {
            Caption = 'Charge date';
            DataClassification = ToBeClassified;
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
        CabPrestamo: Record 34002197;
}

