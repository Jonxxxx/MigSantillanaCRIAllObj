table 56071 "Rutas de Hojas de Rutas"
{
    // #29481  03/09/2015  FAA   Creada para este desarrollo.


    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'No. de Ruta';
            TableRelation = "Maestro de Rutas".Codigo;

            trigger OnValidate()
            var
                recMaestrosRutas: Record 56070;
            begin

                IF recMaestrosRutas.GET(Code) THEN
                    "Nombre de Ruta" := recMaestrosRutas."Nombre de Ruta";
            end;
        }
        field(2; "Nombre de Ruta"; Text[80])
        {
            Editable = false;
        }
        field(5; CP; Code[20])
        {
            Caption = 'C digo Postal';
            TableRelation = "Post Code".Code;
            ValidateTableRelation = true;

            trigger OnValidate()
            var
                recCodigoPostal: Record 225;
            begin

                recCodigoPostal.SETFILTER(Code, CP);

                IF recCodigoPostal.FINDFIRST THEN BEGIN
                    City := recCodigoPostal.City;
                    "Region Code" := recCodigoPostal."Country/Region Code";
                    Country := recCodigoPostal.County;
                    Colonia := recCodigoPostal.Colonia;
                    IF recCodigoPostal."Country/Region Code" = '' THEN
                        "Region Code" := 'CR';
                END;
            end;
        }
        field(6; City; Text[60])
        {
            Caption = 'Municipio/Ciudad';
            Editable = false;
        }
        field(7; "Region Code"; Code[10])
        {
            Caption = 'C d. Pais';
            Editable = false;
        }
        field(8; Country; Text[60])
        {
            Caption = 'Provincia';
            Editable = false;
        }
        field(9; Colonia; Text[60])
        {
            Editable = false;
        }
        field(15; "Tiempo de Envio"; DateFormula)
        {

            trigger OnValidate()
            var
                DateTest: Date;
                Text000: Label 'The %1 cannot be negative.';
            begin
                /*DateTest := CALCDATE(Provincia,WORKDATE);
                IF DateTest < WORKDATE THEN
                  ERROR(Text000,FIELDCAPTION(Provincia))*/

            end;
        }
    }

    keys
    {
        key(Key1; "Code", CP)
        {
        }
        key(Key2; CP, City)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", "Nombre de Ruta")
        {
        }
    }
}

