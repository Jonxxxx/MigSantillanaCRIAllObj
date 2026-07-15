table 34002512 Acciones
{
    Caption = 'Actions';

    fields
    {
        field(34002500; "ID Accion"; Code[20])
        {
            Caption = 'Action ID';
            Description = 'DsPOS Standar';
            Editable = false;
            NotBlank = true;
        }
        field(34002501; Descripcion; Text[250])
        {
            Caption = 'Description';
            Description = 'DsPOS Standar';
            Editable = false;
        }
        field(34002502; "Tipo Accion"; Option)
        {
            Description = 'DsPOS Standar';
            Editable = false;
            OptionCaption = 'Action,Mandatory,Line Action';
            OptionMembers = "Accion",Obligatoria,"Accion Linea";
        }
        field(34002503; "Necesita Datos"; Boolean)
        {
            Description = 'DsPOS Standar';
            Editable = false;
        }
        field(34002504; "Tipo Datos"; Option)
        {
            Description = 'DsPOS Standar';
            Editable = false;
            OptionMembers = ,Numerico,Texto;
        }
        field(34002505; "Literal Pedir Datos"; Text[75])
        {
            Description = 'DsPOS Standar';
            Editable = true;

            trigger OnValidate()
            begin
                IF "Necesita Datos" AND ("Literal Pedir Datos" = '') THEN
                    ERROR(Error002);
            end;
        }
    }

    keys
    {
        key(Key1; "ID Accion")
        {
        }
        key(Key2; "Tipo Accion")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "ID Accion", Descripcion)
        {
        }
    }

    trigger OnDelete()
    begin
        ERROR(Error001);
    end;

    var
        Error001: Label 'Imposible Borrar Acciones';
        Error002: Label 'Debe Especificar un Literal para la ventana de peticion de datos';
}

