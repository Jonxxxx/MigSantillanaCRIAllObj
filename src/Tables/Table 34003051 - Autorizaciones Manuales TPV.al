table 34003051 "Autorizaciones Manuales TPV"
{

    fields
    {
        field(10; Tienda; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tienda';
            Description = 'DsPOS Bolivia';
            TableRelation = Tiendas."Cod. Tienda";
        }
        field(20; Autorizacion; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Autorizacion';
            Description = 'DsPOS Bolivia';
            Editable = true;

            trigger OnValidate()
            var
                rLinSerie: Record 309;
                rCabSeries: Record 308;
            begin
            end;
        }
        field(30; "Fecha Inicial"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Inicial';
            Description = 'DsPOS Bolivia';
        }
        field(40; "Fecha Final"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Final';
            Description = 'DsPOS Bolivia';
        }
        field(50; "No. Inicial"; Code[40])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Inicial';
            Description = 'DsPOS Bolivia';
        }
        field(60; "No Final"; Code[40])
        {
            DataClassification = CustomerContent;
            Caption = 'No Final';
            Description = 'DsPOS Bolivia';
        }
        field(70; "Descripcion"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
            Description = 'DsPOS Bolivia';
        }
        field(80; "Filtro Fecha"; Date)
        {
            Caption = 'Filtro Fecha';
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key1; Tienda, Autorizacion, "Fecha Inicial")
        {
        }
    }

    fieldgroups
    {
    }
}

