table 34002101 "Centros de Trabajo"
{
    //TODO: Ver LookupPageID = 34002101;

    fields
    {
        field(1; "Empresa cotización"; Code[20])
        {
            TableRelation = "Empresas Cotización";

            trigger OnValidate()
            begin
                IF EmpCotizacion.GET("Empresa cotización") THEN BEGIN
                    IF Dirección = '' THEN
                        Dirección := EmpCotizacion.Dirección;
                    Población := EmpCotizacion.Provincia;
                    VALIDATE("C.P.", EmpCotizacion."Codigo Postal");
                END;
            end;
        }
        field(2; "Centro de trabajo"; Code[20])
        {
            NotBlank = true;
            Numeric = true;

            trigger OnValidate()
            begin
                IF STRLEN("Centro de trabajo") < 3 THEN ERROR('Valor comprendido entre 001 y 999');
            end;
        }
        field(3; "Dirección"; Text[40])
        {
        }
        field(4; "C.P."; Text[20])
        {
            TableRelation = "Post Code";

            trigger OnValidate()
            begin
                cpostal.SETRANGE(Code, "C.P.");
                IF Población <> '' THEN
                    cpostal.SETRANGE(City, Población);
                IF cpostal.FINDFIRST THEN BEGIN
                    Población := cpostal.City;
                END;
            end;
        }
        field(5; "Población"; Text[30])
        {
        }
        field(6; Provincia; Text[30])
        {
        }
        field(7; "Fecha de Cierre Nomina"; Date)
        {
        }
        field(8; Nombre; Text[60])
        {
            Caption = 'Name';
        }
    }

    keys
    {
        key(Key1; "Empresa cotización", "Centro de trabajo")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Centro de trabajo", Nombre, "Dirección", Provincia)
        {
        }
    }

    var
        EmpCotizacion: Record 34002100;
        cpostal: Record 225;
}

