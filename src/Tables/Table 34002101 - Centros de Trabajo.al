table 34002101 "Centros de Trabajo"
{
    LookupPageID = 34002101;

    fields
    {
        field(1; "Empresa cotizacion"; Code[20])
        {
            TableRelation = "Empresas Cotizacion";

            trigger OnValidate()
            begin
                IF EmpCotizacion.GET("Empresa cotizacion") THEN BEGIN
                    IF Direccion = '' THEN
                        Direccion := EmpCotizacion.Direccion;
                    Poblacion := EmpCotizacion.Provincia;
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
        field(3; "Direccion"; Text[40])
        {
        }
        field(4; "C.P."; Text[20])
        {
            TableRelation = "Post Code";

            trigger OnValidate()
            begin
                cpostal.SETRANGE(Code, "C.P.");
                IF Poblacion <> '' THEN
                    cpostal.SETRANGE(City, Poblacion);
                IF cpostal.FINDFIRST THEN BEGIN
                    Poblacion := cpostal.City;
                END;
            end;
        }
        field(5; "Poblacion"; Text[30])
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
        key(Key1; "Empresa cotizacion", "Centro de trabajo")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Centro de trabajo", Nombre, "Direccion", Provincia)
        {
        }
    }

    var
        EmpCotizacion: Record 34002100;
        cpostal: Record 225;
}

