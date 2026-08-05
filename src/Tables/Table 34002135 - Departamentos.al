table 55776 Departamentos
{
    Caption = 'Department';
    DrillDownPageID = 55809;
    LookupPageID = 55809;

    fields
    {
        field(1; Codigo; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(2; Descripcion; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(3; "Total Empleados"; Integer)
        {
            Caption = 'Total Empleados';
            CalcFormula = Count(Employee WHERE(Departamento = FIELD("Codigo")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; Inhabilitado; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inhabilitado';

            trigger OnValidate()
            begin

                Emp.SETRANGE(Departamento, Codigo);
                IF Emp.FINDFIRST THEN
                    ERROR(STRSUBSTNO(Err002, TABLECAPTION, Codigo));
            end;
        }
    }

    keys
    {
        key(Key1; Codigo)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Codigo, Descripcion)
        {
        }
    }

    trigger OnDelete()
    begin
        /*
        Emp.SETRANGE(Departamento,Codigo);
        IF Emp.FINDFIRST THEN
           ERROR(STRSUBSTNO(Err001,TABLECAPTION,Codigo));
        SubDepto.SETRANGE("Cod. Departamento",Codigo);
        IF SubDepto.FINDSET(TRUE,FALSE) THEN
           REPEAT
            SubDepto.DELETE(TRUE);
           UNTIL SubDepto.NEXT = 0;
        */

    end;

    var
        SubDepto: Record 55777;
        Emp: Record 5200;
        Err001: Label 'You can not delete %1 %2 because there are employees associated to it';
        Err002: Label 'You can not block %1 %2 because there are employees associated to it';
}

