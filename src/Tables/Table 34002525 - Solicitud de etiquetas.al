table 34002525 "Solicitud de etiquetas"
{
    Caption = 'Labels request';
    DrillDownPageID = 34002532;
    LookupPageID = 34002532;

    fields
    {
        field(34002500; "ID Reporte"; Integer)
        {
            Caption = 'Report ID';
            Description = 'DsPOS Standar';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Report));
        }
        field(34002501; Usuario; Code[20])
        {
            Caption = 'User';
            Description = 'DsPOS Standar';
        }
        field(34002502; "No. Linea"; Integer)
        {
            Caption = 'Line no.';
            Description = 'DsPOS Standar';
        }
        field(34002503; "Nombre reporte"; Text[200])
        {
            Caption = 'Report name';
            Description = 'DsPOS Standar';
        }
        field(34002504; Cantidad; Integer)
        {
            Caption = 'Quantity';
            Description = 'DsPOS Standar';
        }
        field(34002505; "Fecha solicitud"; Date)
        {
            Caption = 'Date';
            Description = 'DsPOS Standar';
        }
        field(34002506; "Cod. barra"; Code[30])
        {
            Caption = 'Barcode';
            Description = 'DsPOS Standar';
        }
        field(34002507; "No. producto"; Code[20])
        {
            Caption = 'Item no.';
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
            Caption = 'Item description';
            Description = 'DsPOS Standar';
        }
        field(34002509; Confirmada; Boolean)
        {
            Caption = 'Confirmed';
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

