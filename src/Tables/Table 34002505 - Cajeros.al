table 55899 Cajeros
{
    // #348662 25.11.2020  RRT: Actualizar DS-POS para ajustar a version 43c. Redenominar tambien campos con caracteres conflictivos.
    // 
    //  LDP: Luis Jose De La Cruz Paredes
    //  ------------------------------------------------------------------------
    //  No.                 Fecha           Firma    Descripcion
    //  ------------------------------------------------------------------------
    //  SIC-JERM            25-07-2023      LDP      Se añade campo: Cajero SIC

    Caption = 'POS Users';

    fields
    {
        field(55894; Tienda; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tienda';
            Description = 'DsPOS Standar';
            TableRelation = Tiendas."Cod. Tienda";
        }
        field(55895; ID; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
            Description = 'DsPOS Standar';
            NotBlank = true;
        }
        field(55896; Descripcion; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
            Description = 'DsPOS Standar';
        }
        field(55897; "Grupo Cajero"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Grupo Cajero';
            Description = 'DsPOS Standar';
            TableRelation = "Grupos Cajeros".Grupo WHERE(Tienda = FIELD("Tienda"));
        }
        field(55898; Contrasena; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Contrasena';
            Description = 'DsPOS Standar';
            ExtendedDatatype = Masked;
        }
        field(55899; Tipo; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo';
            Description = 'DsPOS Standar';
            OptionCaption = 'Cashier, Supervisor';
            OptionMembers = Cajero,Supervisor;
        }
        field(55900; "Cod. Cajero SIC"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Cajero SIC';
            Description = 'JERM-SIC';
        }
    }

    keys
    {
        key(Key1; Tienda, ID)
        {
        }
        key(Key2; Tipo)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Tienda, ID, Descripcion)
        {
        }
    }

    trigger OnInsert()
    begin

        TESTFIELD(ID);
        TESTFIELD(Tienda);
        TESTFIELD("Grupo Cajero");
        TESTFIELD(Contrasena);
    end;
}

