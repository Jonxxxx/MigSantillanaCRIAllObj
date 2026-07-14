table 34002147 "Histórico Lín. Préstamo"
{
    //TODO: Ver DrillDownPageID = 34002135;
    //TODO: Ver LookupPageID = 34002135;

    fields
    {
        field(1; "No. Préstamo"; Code[20])
        {
        }
        field(2; "No. Línea"; Integer)
        {
        }
        field(3; "Tipo CxC"; Option)
        {
            Description = ',Préstamo,Factura';
            OptionMembers = " ","Préstamo",Factura;
        }
        field(4; "No. Cuota"; Integer)
        {
        }
        field(5; "Fecha Transacción"; Date)
        {
        }
        field(6; "Codigo Empleado"; Code[20])
        {
            TableRelation = Employee;
        }
        field(7; Importe; Decimal)
        {

            trigger OnValidate()
            begin
                IF Importe > 0 THEN BEGIN
                    Débito := Importe;
                    CLEAR(Crédito);
                END
                ELSE BEGIN
                    Crédito := Importe * -1;
                    CLEAR(Débito);
                END;
            end;
        }
        field(8; "Débito"; Decimal)
        {

            trigger OnValidate()
            begin
                Importe := Débito;
            end;
        }
        field(9; "Crédito"; Decimal)
        {

            trigger OnValidate()
            begin
                Importe := -Crédito;
            end;
        }
        field(10; Correccion; Boolean)
        {
            Caption = 'Correction';
        }
    }

    keys
    {
        key(Key1; "No. Préstamo", "No. Línea")
        {
            SumIndexFields = Importe, "Débito", "Crédito";
        }
    }

    fieldgroups
    {
    }

    var
        HistLinPre: Record 34002147;
}

