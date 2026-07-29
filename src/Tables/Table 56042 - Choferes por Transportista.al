table 56042 "Choferes por Transportista"
{
    // #2655 PLB 08/04/2014: - A adido campos calculados "Activo" y "Observaciones", enlazados con la tabla "Choferes"
    //                       - A adido FieldGroup para DropDown


    fields
    {
        field(1; "Cod. Transportista"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Transportista';
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
            DataClassification = CustomerContent;
            Caption = 'Nombre Transportista';
        }
        field(3; "Cod. Chofer"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Chofer';
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
            DataClassification = CustomerContent;
            Caption = 'Nombre Chofer';
        }
        field(5; "No. Licencia"; Code[9])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Licencia';
        }
        field(6; "Chofer activo"; Boolean)
        {
            Caption = 'Chofer activo';
            CalcFormula = Lookup(Choferes.Activo WHERE("Cod. Chofer" = FIELD("Cod. Chofer")));
            FieldClass = FlowField;
        }
        field(7; "Observaciones chofer"; Text[100])
        {
            Caption = 'Observaciones chofer';
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

