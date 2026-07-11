table 56042 "Choferes por Transportista"
{
    // #2655 PLB 08/04/2014: - A adido campos calculados "Activo" y "Observaciones", enlazados con la tabla "Choferes"
    //                       - A adido FieldGroup para DropDown


    fields
    {
        field(1; "Cod. Transportista"; Code[20])
        {
            Caption = 'Shiping Agent';
            TableRelation = "Shipping Agent";

            trigger OnValidate()
            begin
                IF SA.GET("Cod. Transportista") THEN
                    "Nombre Transportista" := SA.Name
                ELSE
                    "Nombre Transportista" := '';
            end;
        }
        field(2; "Nombre Transportista"; Text[100])
        {
        }
        field(3; "Cod. Chofer"; Code[20])
        {
            Caption = 'Driver Code';
            TableRelation = Choferes;

            trigger OnValidate()
            begin
                IF Cho.GET("Cod. Chofer") THEN BEGIN
                    "Nombre Chofer" := Cho.Nombre;
                    "No. Licencia" := Cho."No. Licencia";
                END
                ELSE BEGIN
                    "Nombre Chofer" := '';
                    "No. Licencia" := '';
                END;
            end;
        }
        field(4; "Nombre Chofer"; Text[100])
        {
            Caption = 'Driver Name';
        }
        field(5; "No. Licencia"; Code[9])
        {
        }
        field(6; "Chofer activo"; Boolean)
        {
            CalcFormula = Lookup(Choferes.Activo WHERE("Cod. Chofer" = FIELD("Cod. Chofer")));
            FieldClass = FlowField;
        }
        field(7; "Observaciones chofer"; Text[100])
        {
            CalcFormula = Lookup(Choferes.Observaciones WHERE("Cod. Chofer" = FIELD("Cod. Chofer")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Cod. Transportista", "Cod. Chofer")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Cod. Chofer", "Nombre Chofer", "Chofer activo", "Observaciones chofer")
        {
        }
    }

    var
        SA: Record 291;
        Cho: Record 56041;
}

