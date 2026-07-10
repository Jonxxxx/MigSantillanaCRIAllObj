table 56041 Choferes
{
    // #2655 PLB 08/04/2014: A adido campos "Activo" y "Observaciones"

    Caption = 'Drivers';

    fields
    {
        field(1;"Cod. Chofer";Code[20])
        {
            Caption = 'Driver Code';
        }
        field(2;Nombre;Text[100])
        {
            Caption = 'Name';
        }
        field(3;"No. Licencia";Code[9])
        {

            trigger OnValidate()
            begin
                IF STRLEN("No. Licencia" ) <> 9 THEN
                  ERROR(error001);
            end;
        }
        field(4;Activo;Boolean)
        {
        }
        field(5;Observaciones;Text[100])
        {
        }
    }

    keys
    {
        key(Key1;"Cod. Chofer")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"Cod. Chofer",Nombre)
        {
        }
    }

    var
        error001: Label 'Cantidad de digitos de licencia no puede ser diferente a 9';
}

