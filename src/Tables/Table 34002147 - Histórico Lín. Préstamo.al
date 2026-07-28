table 34002147 "Historico Lin. Prestamo"
{
    //IGNORAR: Page no existe DrillDownPageID = 34002135;
    //IGNORAR: Page no existe LookupPageID = 34002135;

    fields
    {
        field(1; "No. Prestamo"; Code[20])
        {
        }
        field(2; "No. Linea"; Integer)
        {
        }
        field(3; "Tipo CxC"; Option)
        {
            Description = ',Prestamo,Factura';
            OptionMembers = " ","Prestamo",Factura;
        }
        field(4; "No. Cuota"; Integer)
        {
        }
        field(5; "Fecha Transaccion"; Date)
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
                    Debito := Importe;
                    CLEAR(Credito);
                END
                ELSE BEGIN
                    Credito := Importe * -1;
                    CLEAR(Debito);
                END;
            end;
        }
        field(8; "Debito"; Decimal)
        {

            trigger OnValidate()
            begin
                Importe := Debito;
            end;
        }
        field(9; "Credito"; Decimal)
        {

            trigger OnValidate()
            begin
                Importe := -Credito;
            end;
        }
        field(10; Correccion; Boolean)
        {
            Caption = 'Correction';
        }
    }

    keys
    {
        key(Key1; "No. Prestamo", "No. Linea")
        {
            SumIndexFields = Importe, "Debito", "Credito";
        }
    }

    fieldgroups
    {
    }

    var
        HistLinPre: Record 34002147;
}

