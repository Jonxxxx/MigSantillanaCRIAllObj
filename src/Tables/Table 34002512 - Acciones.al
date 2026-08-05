table 55906 Acciones
{
    Caption = 'Actions';

    fields
    {
        field(55894; "ID Accion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'ID Accion';
            Description = 'DsPOS Standar';
            Editable = false;
            NotBlank = true;
        }
        field(55895; Descripcion; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
            Description = 'DsPOS Standar';
            Editable = false;
        }
        field(55896; "Tipo Accion"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Accion';
            Description = 'DsPOS Standar';
            Editable = false;
            OptionCaption = 'Action,Mandatory,Line Action';
            OptionMembers = "Accion",Obligatoria,"Accion Linea";
        }
        field(55897; "Necesita Datos"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Necesita Datos';
            Description = 'DsPOS Standar';
            Editable = false;
        }
        field(55898; "Tipo Datos"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Datos';
            Description = 'DsPOS Standar';
            Editable = false;
            OptionMembers = ,Numerico,Texto;
        }
        field(55899; "Literal Pedir Datos"; Text[75])
        {
            DataClassification = CustomerContent;
            Caption = 'Literal Pedir Datos';
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

