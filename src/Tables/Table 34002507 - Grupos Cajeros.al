table 34002507 "Grupos Cajeros"
{
    Caption = 'Cashier Group';
    DrillDownPageID = 34002508;
    LookupPageID = 34002507;

    fields
    {
        field(34002500; Tienda; Code[20])
        {
            Description = 'DsPOS Standar';
            TableRelation = Tiendas."Cod. Tienda";
        }
        field(34002501; Grupo; Code[20])
        {
            Description = 'DsPOS Standar';
        }
        field(34002502; Descripcion; Text[250])
        {
            Description = 'DsPOS Standar';
        }
        field(34002503; "Cliente al contado"; Code[20])
        {
            Caption = 'Cash Customer';
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

