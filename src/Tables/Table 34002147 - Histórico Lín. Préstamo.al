table 55788 "Historico Lin. Prestamo"
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
        field(2; "No. Linea"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Linea';
        }
        field(3; "Tipo CxC"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo CxC';
            Description = ',Prestamo,Factura';
            OptionMembers = " ","Prestamo",Factura;
        }
        field(4; "No. Cuota"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Cuota';
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
        field(7; Importe; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe';

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
            DataClassification = CustomerContent;
            Caption = 'Debito';

            trigger OnValidate()
            begin
                Importe := Debito;
            end;
        }
        field(9; "Credito"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Credito';

            trigger OnValidate()
            begin
                Importe := -Credito;
            end;
        }
        field(10; Correccion; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Correccion';
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
        HistLinPre: Record 55788;
}

