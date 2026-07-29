table 34002525 "Solicitud de etiquetas"
{
    Caption = 'Labels request';
    DrillDownPageID = 34002532;
    LookupPageID = 34002532;

    fields
    {
        field(34002500; "ID Reporte"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID Reporte';
            Description = 'DsPOS Standar';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Report));
        }
        field(34002501; Usuario; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Usuario';
            Description = 'DsPOS Standar';
        }
        field(34002502; "No. Linea"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Linea';
            Description = 'DsPOS Standar';
        }
        field(34002503; "Nombre reporte"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre reporte';
            Description = 'DsPOS Standar';
        }
        field(34002504; Cantidad; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad';
            Description = 'DsPOS Standar';
        }
        field(34002505; "Fecha solicitud"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha solicitud';
            Description = 'DsPOS Standar';
        }
        field(34002506; "Cod. barra"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. barra';
            Description = 'DsPOS Standar';
        }
        field(34002507; "No. producto"; Code[20])
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
        field(34002508; "Descripcion producto"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion producto';
            Description = 'DsPOS Standar';
        }
        field(34002509; Confirmada; Boolean)
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

