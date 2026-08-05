table 55901 "Grupos Cajeros"
{
    Caption = 'Cashier Group';
    DrillDownPageID = 55902;
    LookupPageID = 55901;

    fields
    {
        field(55894; Tienda; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tienda';
            Description = 'DsPOS Standar';
            TableRelation = Tiendas."Cod. Tienda";
        }
        field(55895; Grupo; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Grupo';
            Description = 'DsPOS Standar';
        }
        field(55896; Descripcion; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
            Description = 'DsPOS Standar';
        }
        field(55897; "Cliente al contado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cliente al contado';
            Description = 'DsPOS Standar';
            TableRelation = Customer."No.";
        }
    }

    keys
    {
        key(Key1; Tienda, Grupo)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        TESTFIELD(Tienda);
        TESTFIELD(Grupo);
    end;
}

