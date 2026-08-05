table 55919 "Solicitud de etiquetas"
{
    Caption = 'Labels request';
    DrillDownPageID = 55926;
    LookupPageID = 55926;

    fields
    {
        field(55894; "ID Reporte"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID Reporte';
            Description = 'DsPOS Standar';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Report));
        }
        field(55895; Usuario; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Usuario';
            Description = 'DsPOS Standar';
        }
        field(55896; "No. Linea"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Linea';
            Description = 'DsPOS Standar';
        }
        field(55897; "Nombre reporte"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre reporte';
            Description = 'DsPOS Standar';
        }
        field(55898; Cantidad; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad';
            Description = 'DsPOS Standar';
        }
        field(55899; "Fecha solicitud"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha solicitud';
            Description = 'DsPOS Standar';
        }
        field(55900; "Cod. barra"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. barra';
            Description = 'DsPOS Standar';
        }
        field(55901; "No. producto"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. producto';
            Description = 'DsPOS Standar';
            TableRelation = Item;

            trigger OnValidate()
            var
                rItem: Record 27;
            begin
                IF rItem.GET("No. producto") THEN
                    "Descripcion producto" := rItem.Description;
            end;
        }
        field(55902; "Descripcion producto"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion producto';
            Description = 'DsPOS Standar';
        }
        field(55903; Confirmada; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Confirmada';
            Description = 'DsPOS Standar';
        }
    }

    keys
    {
        key(Key1; "ID Reporte", Usuario, "No. Linea")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Usuario := USERID;
    end;
}

