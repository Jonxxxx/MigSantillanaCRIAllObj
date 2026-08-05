table 55266 Choferes
{
    // #2655 PLB 08/04/2014: A adido campos "Activo" y "Observaciones"

    Caption = 'Drivers';

    fields
    {
        field(1; "Cod. Chofer"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Chofer';
        }
        field(2; Nombre; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre';
        }
        field(3; "No. Licencia"; Code[9])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Licencia';

            trigger OnValidate()
            begin
                IF STRLEN("No. Licencia") <> 9 THEN
                    ERROR(error001);
            end;
        }
        field(4; Activo; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Activo';
        }
        field(5; Observaciones; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Observaciones';
        }
    }

    keys
    {
        key(Key1; "Cod. Chofer")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Cod. Chofer", Nombre)
        {
        }
    }

    var
        error001: Label 'Cantidad de digitos de licencia no puede ser diferente a 9';
}

