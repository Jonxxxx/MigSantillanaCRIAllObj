table 34002114 "Tipos de acciones personal"
{
    Caption = 'Actions Human resources';
    DataPerCompany = false;
    DrillDownPageID = 34002147;
    LookupPageID = 34002147;

    fields
    {
        field(1; "Tipo de accion"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de accion';
            OptionCaption = ' ,Hiring,Change,Quit';
            OptionMembers = " ",Ingreso,Cambio,Salida;
        }
        field(2; Codigo; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(3; Descripcion; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(4; "Emitir documento"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Emitir documento';
        }
        field(5; "ID Documento"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID Documento';
        }
        field(6; "Editar salario"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Editar salario';
        }
        field(7; "Editar cargo"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Editar cargo';
        }
        field(8; "Transferir entre empresas"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Transferir entre empresas';
        }
        field(9; "Pagar preaviso"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Pagar preaviso';
        }
        field(10; "Pagar cesantia"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Pagar cesantia';
        }
        field(11; "Pagar regalia"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Pagar regalia';
            Enabled = false;
        }
        field(12; Suspension; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Suspension';
        }
    }

    keys
    {
        key(Key1; "Tipo de accion", Codigo)
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
        LinEsquema: Record 34002115;
}

