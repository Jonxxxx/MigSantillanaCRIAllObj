table 67010 "Tipos de Eventos"
{
    DrillDownPageID = 67010;
    LookupPageID = 67010;

    fields
    {
        field(1; Codigo; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(2; Descripcion; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(3; Cantidad; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad';
        }
        field(4; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(5; "Ingresar grados"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Ingresar grados';
        }
        field(6; "Ingresar libros a presentar"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Ingresar libros a presentar';
        }
        field(7; Seleccionar; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Seleccionar';
        }
    }

    keys
    {
        key(Key1; Codigo)
        {
        }
        key(Key2; Descripcion)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Codigo, Descripcion)
        {
        }
    }

    var
        DimMgt: Codeunit 408;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        //DimMgt.SaveDefaultDim(DATABASE::Customer,"No.",FieldNumber,ShortcutDimCode);
        //MODIFY;
    end;
}

