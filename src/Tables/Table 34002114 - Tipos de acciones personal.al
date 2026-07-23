table 34002114 "Tipos de acciones personal"
{
    Caption = 'Actions Human resources';
    DataPerCompany = false;
    DrillDownPageID = 34002147;
    //TODO: Ver LookupPageID = 34002147;

    fields
    {
        field(1; "Tipo de accion"; Option)
        {
            Caption = 'Action type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Hiring,Change,Quit';
            OptionMembers = " ",Ingreso,Cambio,Salida;
        }
        field(2; Codigo; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Descripcion; Text[50])
        {
            Caption = 'Description';
        }
        field(4; "Emitir documento"; Boolean)
        {
            Caption = 'Print document';
        }
        field(5; "ID Documento"; Integer)
        {
            Caption = 'Document ID';
        }
        field(6; "Editar salario"; Boolean)
        {
        }
        field(7; "Editar cargo"; Boolean)
        {
        }
        field(8; "Transferir entre empresas"; Boolean)
        {
            Caption = 'Transfer between companies';
        }
        field(9; "Pagar preaviso"; Boolean)
        {
            Caption = 'Pagar preaviso';
        }
        field(10; "Pagar cesantia"; Boolean)
        {
            Caption = 'Pagar cesantia';
        }
        field(11; "Pagar regalia"; Decimal)
        {
            Caption = 'Pagar regalia';
            Enabled = false;
        }
        field(12; Suspension; Boolean)
        {
            Caption = 'Suspend';
            DataClassification = ToBeClassified;
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

