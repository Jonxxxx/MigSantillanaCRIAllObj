table 34002505 Cajeros
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
        field(34002500;Tienda;Code[20])
        {
            Caption = 'Store';
            Description = 'DsPOS Standar';
            TableRelation = Tiendas."Cod. Tienda";
        }
        field(34002501;ID;Code[20])
        {
            Caption = 'ID';
            Description = 'DsPOS Standar';
            NotBlank = true;
        }
        field(34002502;Descripcion;Text[100])
        {
            Caption = 'Description';
            Description = 'DsPOS Standar';
        }
        field(34002503;"Grupo Cajero";Code[20])
        {
            Caption = 'Cashier Group';
            Description = 'DsPOS Standar';
            TableRelation = "Grupos Cajeros".Grupo WHERE (Tienda=FIELD(Tienda));
        }
        field(34002504;Contrasena;Text[30])
        {
            Caption = 'Password';
            Description = 'DsPOS Standar';
            ExtendedDatatype = Masked;
        }
        field(34002505;Tipo;Option)
        {
            Description = 'DsPOS Standar';
            OptionCaption = 'Cashier, Supervisor';
            OptionMembers = Cajero,Supervisor;
        }
        field(34002506;"Cod. Cajero SIC";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'JERM-SIC';
        }
    }

    keys
    {
        key(Key1;Tienda,ID)
        {
        }
        key(Key2;Tipo)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;Tienda,ID,Descripcion)
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

